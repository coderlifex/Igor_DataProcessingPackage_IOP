#pragma rtGlobals=1		// Use modern global access method.

Proc FermiLevelPanel( )
   
      String Curr=GetDataFolder(1)
	DoWindow/F Fermi_Level_Fit_Panel
	if (V_flag==0)
		NewDataFolder/O/S root:FermiLevelFromAu
		Variable/G CorrectionFlag=NumVarOrDefault("root:FermiLevelFromAu:CorrectionFlag",1), CorrectionFlag=0
		Variable/G  FermiAngleStart=NumVarOrDefault("root:FermiLevelFromAu:FermiAngleStart",100)
		Variable/G  FermiAngleEnd=NumVarOrDefault("root:FermiLevelFromAu:FermiAngleEnd",100)
		Variable/G  FermiEnergyStart=NumVarOrDefault("root:FermiLevelFromAu:FermiEnergyStart",100)
		Variable/G  FermiEnergyEnd=NumVarOrDefault("root:FermiLevelFromAu:FermiEnergyEnd",100)
		Variable/G  FermiNorYStart=NumVarOrDefault("root:FermiLevelFromAu:FermiNorYStart",100)
		Variable/G  FermiNorYEnd=NumVarOrDefault("root:FermiLevelFromAu:FermiNorYEnd",100)
		String/G    FermiNamePrefix=StrVarOrDefault("root:FermiLevelFromAu:FermiNamePrefix","")	
		Variable/G  Background=NumVarOrDefault("root:FermiLevelFromAu:Background",100)
		Variable/G  BackgroundSlope=NumVarOrDefault("root:FermiLevelFromAu:BackgroundSlope",100)
		Variable/G  FermiHeight=NumVarOrDefault("root:FermiLevelFromAu:FermiHeight",100)	
		Variable/G  FermiLevel=NumVarOrDefault("root:FermiLevelFromAu:FermiLevel",100)
		Variable/G  FWHM=NumVarOrDefault("root:FermiLevelFromAu:FWHM",100)		
		Variable/G  FitEnergyStart=NumVarOrDefault("root:FermiLevelFromAu:FitEnergyStart",100)	
		Variable/G  FitEnergyEnd=NumVarOrDefault("root:FermiLevelFromAu:FitEnergyEnd",100)	
    		Variable/G  Temperature=NumVarOrDefault("root:FermiLevelFromAu:Temperature",100)
    		Variable/G  FermiLevelAverage=NumVarOrDefault("root:FermiLevelFromAu:FermiLevelAverage",100)    		
    		Variable/G  FermiLevelAverage2D=NumVarOrDefault("root:FermiLevelFromAu:FermiLevelAverage2D",100)
    		Variable/G  WaveXStep1D
 	    	String/G      FermiLevelFileList
	     	Variable/G  FileDimensionFlag
	        Variable/G  DataPoint, NXImage, NYImage
	        String/G TempFermiName
 	       SetDataFolder root:OriginalData
                root:FermiLevelFromAu:FermiLevelFileList=WaveList("A*",";","DIMS:2")	
	
		SetDataFolder root:FermiLevelFromAu

       Fermi_Level_Fit_Panel( )
       Endif
       SetDataFolder Curr	
    
End

Window Fermi_Level_Fit_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1/W=(0,101,480,330)
	ModifyPanel cbRGB=(64512,62423,1327)
	SetDrawLayer UserBack

	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 13,29,155,224                                 //Process Data
    SetDrawEnv fillfgc= (16384,65280,65280)
	DrawRRect 171,29,360,224                               //Fit initialization

    PopupMenu AuFermiEdge_file,pos={175,4},size={160,19}, proc=ShowFermiLevelImage,title="AuFermiLevelFile "
    PopupMenu AuFermiEdge_file,mode=6,popvalue="A12122000 ",value= #"root:FermiLevelFromAu:FermiLevelFileList\t\t" 
    PopupMenu popup_FileDimension,pos={75,4},size={30,25},proc=FileDimensionSelection,title="File?"
	PopupMenu popup_FileDimension,mode=1,popvalue="1D",value= #"\"1D;2D\""
    Button ProcessFermiButton pos={22,34},size={115,20},proc=ProcessFermiFile,title="ProcessAu2DImg",fsize=10
	SetDrawLayer UserBack
	DrawText 20,72,"Crop Image"
	SetVariable set_CropAngleStart,proc=SetVarProc,pos={20,75},size={125,25},title="Angle  Start",fSize=10
	SetVariable set_CropAngleStart,limits={-25,25,0.1},value=root:FermiLevelFromAu:FermiAngleStart
	SetVariable set_CropAngleEnd,proc=SetVarProc,pos={58,94},size={87,25},title="End",fSize=10
	SetVariable set_CropAngleEnd,limits={0,25,0.1},value=root:FermiLevelFromAu:FermiAngleEnd
	SetVariable set_CropEnergyStart,proc=SetVarProc,pos={20,115},size={125,25},title="EnergyStart",fSize=10
	SetVariable set_CropEnergyStart,limits={-inf,inf,0.1},value=root:FermiLevelFromAu:FermiEnergyStart
	SetVariable set_CropEnergyEnd,pos={58,134},size={87,25},title="End",fSize=10
	SetVariable set_CropEnergyEnd,limits={-inf,inf,0.1},value=root:FermiLevelFromAu:FermiEnergyEnd
	SetVariable set_NorYStart,proc=SetVarProc,pos={20,157},size={125,25},title="NorY  Start ",fSize=10
	SetVariable set_NorYStart,limits={-inf,inf,0.1},value=root:FermiLevelFromAu:FermiNorYStart
	SetVariable set_NorYEnd,proc=SetVarProc,pos={58,176},size={87,25},title="End",fSize=10
	SetVariable set_NorYEnd,limits={-inf,inf,0.1},value=root:FermiLevelFromAu:FermiNorYEnd
	SetVariable set_Newname,proc=SetVarProc,pos={20,200},size={125,25},title="Name Prefix",fSize=10
	SetVariable set_Newname, value= root:FermiLevelFromAu:FermiNamePrefix
//	SetDrawLayer UserBack
	DrawText 200,50,"Fitting Initialization"
	SetVariable set_Background,proc=SetVarProc,pos={180,50},size={175,25},title="Background       ",fSize=10	
	SetVariable set_Background,limits={-inf,inf,10},value= root:FermiLevelFromAu:Background
//	SetVariable set_BackgroundSlope,proc=SetVarProc,pos={180,70},size={150,25},title="BKGDSlope       ",fSize=10	
//	SetVariable set_BackgroundSlope,limits={-inf,inf,10},value= root:FermiLevelFromAu:BackgroundSlope	
	SetVariable set_FermiHeight,proc=SetVarProc,pos={180,70},size={175,25},title="Fermi Height     ",fSize=10
	SetVariable set_FermiHeight,limits={-inf,inf,10},value= root:FermiLevelFromAu:FermiHeight
	SetVariable set_FermiLevel,proc=SetVarProc,pos={180,100},size={175,25},title="FermiLevel(eV) ",fSize=10
	SetVariable set_FermiLevel,limits={-inf,inf,0.1},value= root:FermiLevelFromAu:FermiLevel
	SetVariable set_FWHM,proc=SetVarProc,pos={180,120},size={175,25},title="FWHM (meV)     ",fSize=10
	SetVariable set_FWHM,limits={-inf,inf,1},value= root:FermiLevelFromAu:FWHM
	SetVariable set_FitEnergyStart,proc=SetVarProc,pos={180,150},size={175,25},title="EnergyStart(eV) ",fSize=10
	SetVariable set_FitEnergyStart,limits={-inf,inf,0.1},value= root:FermiLevelFromAu:FitEnergyStart
	SetVariable set_FitEnergyEnd,proc=SetVarProc,pos={180,170},size={175,25},title="             End(eV)  ",fSize=10
	SetVariable set_FitEnergyEnd,limits={-inf,inf,0.1},value= root:FermiLevelFromAu:FitEnergyEnd
	SetVariable set_Temperature,proc=SetVarProc,pos={180,200},size={175,25},title="Temperature(K)",fSize=10
	SetVariable set_Temperature,limits={0,inf,0.1},value= root:FermiLevelFromAu:Temperature
	Button Calculate,pos={385,50},size={80,30},title="CALCULATE",proc=FermiCalculate
	Button Fit,pos={385,95},size={80,30},title="FIT",proc=FermiFunctionFit
	Button Clean,pos={375,140},size={100,30},title="CLEAN",proc=XJZClean
	Button Exit,pos={375,185},size={100,30},title="EXIT",proc=XJZDoneBotton

EndMacro


Proc FileDimensionSelection(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String Curr=GetDataFolder(1)
	SetDataFolder root:FermiLevelFromAu
	
         root:FermiLevelFromAu:FileDimensionFlag=popNum
         
         If (FileDimensionFlag==1)
         root:FermiLevelFromAu:FermiLevelFilelist=root:OriginalData:original1DFileList
         Else 
         root:FermiLevelFromAu:FermiLevelFilelist=root:OriginalData:originalFileList 
         Endif       
        
	SetDataFolder Curr
End


Proc ShowFermiLevelImage(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
        String FermiImageName="Au"+popStr
        String Fermi1DName="Au1D_"+popStr
        root:FermiLevelFromAu:TempFermiName=popStr
        
//     print  root:FermiLevelFromAu:TempFermiName
	
	   String Curr=GetDataFolder(1)
          SetDataFolder root:FermiLevelFromAu

                  If (FileDimensionFlag==2)
                		 DoWindow Au2D_OriginalFermiImage
	     	   		  if(V_flag==0)
                		 Duplicate/O root:OriginalData:$popStr  root:FermiLevelFromAu:$TempFermiName
	      	  		   Display; AppendImage root:OriginalData:$TempFermiName
                		  DoWindow/C Au2D_OriginalFermiImage
	     			    ModifyImage $TempFermiName ctab= {*,*,PlanetEarth,1}
	     	   		 Else
	     	   		 DoWindow/F Au2D_OriginalFermiImage
	     	   		 Endif
	            Else
                    DoWindow $Fermi1DName
 	           
 	            root:FermiLevelFromAu:WaveXStep1D=deltaX(root:OriginalData:$popStr)
 	            Print "Step=", 	WaveXStep1D  
 	               	    	     	   
	     	    if(V_flag==0)	     	   
                Duplicate/O root:OriginalData:$popStr  root:FermiLevelFromAu:$TempFermiName        
	            Display root:OriginalData:$TempFermiName 
	            ModifyGraph rgb=(16384,28160,65280),mode=3,marker=19
	            DoWindow/C  $Fermi1DName
	            Duplicate/O/R=(root:FermiLevelFromAu:FitEnergyStart,root:FermiLevelFromAu:FitEnergyEnd) root:OriginalData:$TempFermiName , EDCForFermiLevel        

	          
	     	    Else
	     	    DoWindow/F  $Fermi1DName
	     	    Endif	     	 
	        	Endif  

	SetDataFolder Curr
End


Proc  ProcessFermiFile(ctrlName) : ButtonControl
	 String ctrlName

        String curr=GetDataFolder(1)
        String OriginalFermiImage=root:FermiLevelFromAu:TempFermiName
        String ProcessedFermiImage="Pro_"+root:FermiLevelFromAu:TempFermiName

        DoWindow/K Au2D_OriginalFermiImage
        DoWindow Processed_Fermi_Image
        If (V_Flag==0)	        
 
        SetDataFolder root:FermiLevelFromAu
	
//     Crop Image
 
      Duplicate/O/R=(FermiEnergyStart,FermiEnergyEnd)(FermiAngleStart,FermiAngleEnd) $OriginalFermiImage, $ProcessedFermiImage

//    Normalize Y
                 XJZImginfo($ProcessedFermiImage)
		make/o/n=(ny) ytmp
		SetScale/P x ymin, yinc, "" ytmp
		ytmp = XJZAREA2D( $ProcessedFermiImage, FermiNorYStart, FermiNorYEnd, x )
		$ProcessedFermiImage /= ytmp[q]
		
	         Display; AppendImage $ProcessedFermiImage
	         ModifyImage $ProcessedFermiImage ctab= {*,*,PlanetEarth,1}
	         

         DoWindow/C Processed_Fermi_Image	 
	         
	 Else
         DoWindow/F Processed_Fermi_Image	 
	 Endif  
	 
	 ShowFermiImageSpectra()      

       SetDataFolder Curr

End


Proc FermiFunctionFit(ctrlName): ButtonControl
	String ctrlName
       String Curr=GetDataFolder(1)
       String ProcessedFermiImage="Pro_"+root:FermiLevelFromAu:TempFermiName
       SetDataFolder root:FermiLevelFromAu
		Pauseupdate;silent 1
      IF (FileDimensionFlag==2)
      
     Duplicate/O/R=(root:FermiLevelFromAu:FitEnergyStart,root:FermiLevelFromAu:FitEnergyEnd)(FermiAngleStart,FermiAngleEnd) $ProcessedFermiImage, ImageForFermiLevel 
	 FermiImageSpectraForFitting()  
    	 XJ2DFermiFunctionFit()
     ShowFittedFermiLevel()
        
 
     Else

    	 XJ1DFermiFunctionFit()
    	 root:FermiLevelFromAu:FermiLevelAverage=root:FermiLevelFromAu:FermiLevel
     Print "Average Fermi Level:", root:FermiLevelFromAu:FermiLevel
    	  
     	  
     Endif    
       
     SetDataFolder Curr

End

Function ShowFermiImageSpectra( )

	String Curr=GetDataFolder(1)
	SVar TempName=root:FermiLevelFromAu:TempFermiName
	String ProcessedFermiImage="Pro_"+TempName
	
//Kill EDC Curves in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledEDCList=WaveList("AuFermi*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	      Variable iEDC=0
	      Do
	      EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	      KillWaves/Z  $EDCCurve
	      iEDC+=1
	      While(iEDC<NoofKilledEDCList)
	      
//Kill Fitted Curves in root:FermiLevelFromAu
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	      
        Duplicate/O $ProcessedFermiImage, AuImage
//	Display; AppendImage AuImage
        	
	 variable/G nx, ny
	 variable/G xmin, xinc, xmax, ymin, yinc, ymax
        
        XJZImginfo(AuImage)

                String EnergyReference="Reference_Energy_Fermi"
	        Make/O/N=(nx) $EnergyReference
	        Wave ReferenceEnergy=$EnergyReference
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
       	 	
                String AngleReference="Reference_Angle_Fermi"
	        Make/O/N=(ny) $AngleReference
	        Wave ReferenceAngle=$AngleReference
                Variable jj=0
      	        Do
        		ReferenceAngle[jj]=ymin+yinc*jj
        		jj=jj+1
       	 	While(jj<ny) 
       	 	

                Make/O/N=(nx) AuFermi0
                AuFermi0=AuImage[p] [0]


                 String EDC
                 String EDCName
                 Variable i=1             
                
                 DoWindow Au_Fermi_Spectra
	         if(V_flag==0)
	         
                 Display  AuFermi0 vs ReferenceEnergy as "Fermi Spectra"
                 ModifyGraph mode(AuFermi0)=4,marker(AuFermi0)=8
                 ModifyGraph rgb(AuFermi0)=(0,15872,65280)
        		DoWindow/C Au_Fermi_Spectra
	         
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
                AppendToGraph EDCC vs ReferenceEnergy 
                ModifyGraph mode($EDCName)=4,marker($EDCName)=8
                ModifyGraph rgb($EDCName)=(0,15872,65280)                
	        i=i+1
	        While(i<ny) 
	        
	            		
	        	else
	        		DoWindow/F Au_Fermi_Spectra
	       
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
	        i=i+1
	        While(i<ny) 		
	        	endif  
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
                 
                 
	         SetDataFolder Curr  
	       
End


Function FermiImageSpectraForFitting( )

	String Curr=GetDataFolder(1)
	SVar TempName=root:FermiLevelFromAu:TempFermiName
	String ProcessedFermiImage="Pro_"+TempName
	
//Kill EDC Curves in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledEDCList=WaveList("AuFermi*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	      Variable iEDC=0
	      Do
	      EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	      KillWaves/Z  $EDCCurve
	      iEDC+=1
	      While(iEDC<NoofKilledEDCList)
	      
//Kill Fitted Curves in root:FermiLevelFromAu
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	      
       Duplicate/O ImageForFermiLevel, AuImage
//     Display; AppendImage AuImage
        	
	 variable/G nx, ny
	 variable/G xmin, xinc, xmax, ymin, yinc, ymax
        
         XJZImginfo(AuImage)

                String EnergyReference="Reference_Energy_Fermi"
	        Make/O/N=(nx) $EnergyReference
	        Wave ReferenceEnergy=$EnergyReference
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
       	 	
                String AngleReference="Reference_Angle_Fermi"
	        Make/O/N=(ny) $AngleReference
	        Wave ReferenceAngle=$AngleReference
                Variable jj=0
      	        Do
        		ReferenceAngle[jj]=ymin+yinc*jj
        		jj=jj+1
       	 	While(jj<ny) 
       	 	

                Make/O/N=(nx) AuFermi0
                AuFermi0=AuImage[p] [0]


                 String EDC
                 String EDCName
                 Variable i=1             
                
                 DoWindow Au_Fermi_Spectra
	         if(V_flag==0)
	         
                 Display  AuFermi0 vs ReferenceEnergy as "Fermi Spectra"
                 ModifyGraph mode(AuFermi0)=4,marker(AuFermi0)=8
                 ModifyGraph rgb(AuFermi0)=(0,15872,65280)
        		DoWindow/C Au_Fermi_Spectra
	         
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
                AppendToGraph EDCC vs ReferenceEnergy 
                ModifyGraph mode($EDCName)=4,marker($EDCName)=8
                ModifyGraph rgb($EDCName)=(0,15872,65280)                
	        i=i+1
	        While(i<ny) 
	        
	            		
	        	else
	        		DoWindow/F Au_Fermi_Spectra
	       
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
	        i=i+1
	        While(i<ny) 		
	        	endif  
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
                 
                 
	         SetDataFolder Curr  
	       
End


//Fermi Function Fit
Function XJFermiFit(w,y)


//   T=1K     k_BT=1.38062*10^(-23) J 
//   1meV=1.60219*10^(-19)*10^(-3)=1.60219*10^(-22) J

//   Therefore,  1K --> 1.38062*0.1/1.60219=0.08617meV
//                 300K-->25.85 meV


//Fermi level:      10~90% width:  4.40k_B T
//                  12~88% width:  3.98k_B T  ---corresponding to Lorentzian convolution




	//w[0]   constant background;
	//w[1]   Height of the Fermi Step; 
	//w[2]   Full Width at Half maximum;
	//w[3]   Fermi Edge position;
	wave w; Variable y
	
//	return w[0] + w[1]/(exp(4400*(y-w[3])/w[2])+1)
	
	variable val
//	val=w[0] + w[1]/(exp(4400*(y-w[3])/w[2])+1)                //10~90% width
	val=w[0] + w[1]/(exp(3980*(y-w[3])/w[2])+1)                //12~88% width	
	
	Return Val
	
//	NVar dw=w[0] + w[1]/(exp(4400*(x-w[3])/w[2])+1)
//	return dw(x)
	
END

//Fermi Function Fit
Function XJ1DFermiFit(w,x)


	//w[0]   constant background;
	//w[1]   Height of the Fermi Step; 
	//w[2]   Full Width at Half maximum;
	//w[3]   Fermi Edge position;
	//w[4]   Background Slope;
	wave w; Variable x

//	return w[0] + w[1]/(exp(4400*(x-w[3])/w[2])+1)+w[4]*x    //10~90% width
	return w[0] + w[1]/(exp(3980*(x-w[3])/w[2])+1)+w[4]*x    //12~88% width
	
END




//Fit Fermi Function with convolution
//-----------------------------------------------------------------------------------------
Function  FermiEdgeFit(w,y)
	Wave  w
	Variable  y
	string  sName="FitTemp"
	NVar EStart=root:FermiLevelFromAu:FitEnergyStart
	NVar EEnd=root:FermiLevelFromAu:FitEnergyEnd
	NVar dT=root:FermiLevelFromAu:WaveXStep1D
	NVar STemp=root:FermiLevelFromAu:Temperature
	
	Variable Fitnmpt=ceil(abs(EEnd-EStart)/dT)

//First, make a Gaussian

	Make/O/N=401 ConvG
	Setscale/P x -dT*200, dT, ConvG
	ConvG= exp(-(x/(w[2]/1000))^2)

	Variable sumConvG
	sumConvG=sum(ConvG, -inf, inf)
	ConvG/=sumConvG
	
//Second, make a new wave

Make/O/N=(Fitnmpt)  $sName
Setscale/I x, EStart, EEnd, $sName
        Variable TempE=STemp*0.025/300
	Wave dw=$sName
	dw=w[1]/(exp((y-w[3])/TempE)+1)
	Convolve/A ConvG,dw
	dw+=w[0]

	wave  wr=$sName
	return wr(y)

End
//-----------------------------------------------------------------------------------------------------------------







Function FermiCalculate(ctrlName): ButtonControl
String ctrlName

String curr=GetDataFolder(1)

SetDataFolder root:FermiLevelFromAu
 
 
      NVAR   DimensionFlag=root:FermiLevelFromAu:FileDimensionFlag
      SVAR   TempName=root:FermiLevelFromAu:TempFermiName
      WAVE  TempWave=$TempName
      NVar     DataPointNumber=root:FermiLevelFromAu:DataPoint
                   DataPointNumber=DimSize(TempWave,0) 
      Print  DimensionFlag,DataPointNumber, TempName
      Print MinofWave(TempWave), MaxofWave(TempWave)
 
 Make/O/N=(DataPointNumber) CalculatedFermiCurve
 NVAR ES=FitEnergyStart
 NVAR EN=FitEnergyEnd
 NVAR BG=Background
 NVAR BGSlope=BackgroundSlope
 NVAR FH=FermiHeight
 NVAR FL=FermiLevel
 NVAR FW=FWHM 
      BG=MinofWave(TempWave)
      FH=MaxofWave(TempWave) -MinofWave(TempWave)
 
Setscale x ES, EN, CalculatedFermiCurve
CalculatedFermiCurve=BG + FH/(exp(3980*(x-FL)/FW)+1)+x*BGSlope
//CalculatedFermiCurve=BG + FH/(exp(4400*(x-FL)/FW)+1)+x*BGSlope
RemoveFromGraph/Z  CalculatedFermiCurve
AppendToGraph CalculatedFermiCurve 
ModifyGraph mode(CalculatedFermiCurve)=0,lsize(CalculatedFermiCurve)=3;DelayUpdate
ModifyGraph rgb(CalculatedFermiCurve)=(65280,0,0)
 
 SetDataFolder curr

End

         
Function XJ2DFermiFunctionFit()
        String Curr=GetDataFolder(1)
        SetDataFolder root:FermiLevelFromAu
        Variable SN, EN, lim
        Variable i,j 
	String FermiList, Fermi_Name
	Variable w0,w1,w2,w3
	FermiList=WaveList("AuFermi*",";","DIMS:1")
	Variable NoofFermiCurves=ItemsinList(FermiList,";")
	
       SN=0
       EN=NoofFermiCurves-1
       NVar AuBackground=root:FermiLevelFromAu:Background
       NVar AuFermiHeight=root:FermiLevelFromAu:FermiHeight
       NVar AuFWHM=root:FermiLevelFromAu:FWHM
       NVar AuFermiLevel=root:FermiLevelFromAu:FermiLevel	
       
       w0=AuBackground
       w1=AuFermiHeight
       w2=AuFWHM
       w3=AuFermiLevel		
	Make/O Fermicoeff={w0, w1, w2,w3}
	Redimension/D  Fermicoeff 
	lim=EN+1
	Make/O/N=((EN-SN+1)) Fermi_Background=0, Fermi_Height=0, Fermi_FWHM=0, Fermi_Level=0, Fermi_Level2D_0=0,Fermi_Angle
	i=SN
        NVar Fermi_EnergyStart=root:FermiLevelFromAu:FitEnergyStart
        NVar Fermi_EnergyEnd=root:FermiLevelFromAu:FitEnergyEnd
        NVar FermiLevelAve2D=root:FermiLevelFromAu:FermiLevelAverage2D
        Wave AuEnergyReference=root:FermiLevelFromAu:Reference_Angle_Fermi
	do
		Fermi_Name=StringFromList(i,FermiList,";")
		FuncFit/Q=1 XJFermiFit Fermicoeff root:FermiLevelFromAu:$Fermi_Name  /D /X=root:FermiLevelFromAu:Reference_Energy_Fermi
	        Fermi_Background[i]=Fermicoeff[0]
	        Fermi_Height[i]=Fermicoeff[1]
	        Fermi_FWHM[i]=Fermicoeff[2]
	        Fermi_Level[i]=Fermicoeff[3]
                Fermi_Angle[i]=AuEnergyReference[i]
		i+=1
	while(i<lim)

         FermiLevelAve2D=AverageofWave(root:FermiLevelFromAu:Fermi_Level)
         Print "Average Fermi Level 2D:", FermiLevelAve2D
         Fermi_Level2D_0=Fermi_Level-FermiLevelAve2D

		
		SetDataFolder Curr
		
         End        
         
         
         
Proc XJ1DFermiFunctionFit()
        String Curr=GetDataFolder(1)
        SetDataFolder root:FermiLevelFromAu

       String Fermi1D_Name
       String FermiEDC="Au"+TempFermiName
       String FitCurve="fit_"+FermiEDC

       Variable Fermi1D_Background,  Fermi1D_BackgroundSlope, Fermi1D_Height, Fermi1D_FWHM, Fermi1D_FWHMError, Fermi1D_Level, Fermi1D_LevelError
	   Variable Fermi_EnergyStart=root:FermiLevelFromAu:FitEnergyStart
	   Variable Fermi_EnergyEnd=root:FermiLevelFromAu:FitEnergyEnd
	   Variable NumofX, Xminimum, Xincrement, XMaximum

	   Duplicate/O/R=(root:FermiLevelFromAu:FitEnergyStart,root:FermiLevelFromAu:FitEnergyEnd) $TempFermiName, $FermiEDC
          
	   NumofX=DimSize($FermiEDC, 0)
	   Xminimum=DimOffset($FermiEDC,0)
	   Xincrement=round(DimDelta($FermiEDC,0) * 1E6) / 1E6	
 	   XMaximum=Xminimum+Xincrement*(NumofX-1)
 	   

        root:FermiLevelFromAu:Background=MinofWave($FermiEDC)
        root:FermiLevelFromAu:FermiHeight=MaxofWave($FermiEDC)-MinofWave($FermiEDC)

        Variable w0,w1,w2,w3,w4
        w0=root:FermiLevelFromAu:Background
//        w0=0
        w1=root:FermiLevelFromAu:FermiHeight
//        w0=MinofWave($FermiEDC)
//        w1=MaxofWave($FermiEDC)-MinofWave($FermiEDC)
        w2=root:FermiLevelFromAu:FWHM
        w3=root:FermiLevelFromAu:FermiLevel
        w4=root:FermiLevelFromAu:BackgroundSlope
//      Make/O Fermicoeff={w0, w1, w2, w3,w4}	   
        Make/O Fermicoeff={w0, w1, w2, w3}	
        Redimension/D  Fermicoeff   
 	   
 	   
//	   Print NumofX, Xminimum, Xmaximum, Fermi_EnergyStart, Fermi_EnergyEnd
           Make/O/N=(NumofX) Fit1DEnergyAxis
                Variable ii=0
      	        Do
        		Fit1DEnergyAxis[ii]=Xminimum+Xincrement*ii
       		ii=ii+1
       	 	While(ii<NumofX)

               RemoveFromGraph/Z  $FitCurve 
               RemoveFromGraph/Z  CalculatedFermiCurve
	        FuncFit XJFermiFit Fermicoeff root:FermiLevelFromAu:$FermiEDC  /D /X=Fit1DEnergyAxis
//		FuncFit FermiEdgeFit  Fermicoeff root:FermiLevelFromAu:$FermiEDC /X=Fit1DEnergyAxis
//	        FuncFitMD ConvFunc(Fermicoeff,  root:FermiLevelFromAu:$FermiEDC, Fit1DEnergyAxis)	        
	        	        
	        Append $fitCurve  
	        Fermi1D_Background=Fermicoeff[0]
	        Fermi1D_Height=Fermicoeff[1]
	        Fermi1D_FWHM=Fermicoeff[2]
	        Fermi1D_Level=Fermicoeff[3]
	        Fermi1D_BackgroundSlope=Fermicoeff[4]
	        Fermi1D_FWHMError=W_sigma[2]
	        Fermi1D_LevelError=W_sigma[3]
	        
	        String FermiLevelLabel="Fermi Level= ("+num2str(Fermi1D_Level)+ " +/- " + num2str(Fermi1D_LevelError) +   ")eV"
	        String FWHMLabel="12~88%Width= ("+num2str(Fermi1D_FWHM) +  " +/- " + num2str(Fermi1D_FWHMError) +   ")meV"
	        Textbox/K/N=text0
	        Textbox/K/N=text1
	        Textbox/N=text0/F=0/A=RT FermiLevelLabel
	        AppendText/N=text0 FWHMLabel      
	        Print "Fermi Level= (", Fermi1D_Level, "+", Fermi1D_LevelError, ") eV"
	        Print "12~88%Width= (", Fermi1D_FWHM,"+", Fermi1D_FWHMError, ") meV"
		
		SetDataFolder Curr
		
         End


Proc ShowFittedFermiLevel()
      
       String Curr=GetDataFolder(1)
             
       SetDataFolder root:FermiLevelFromAu
       String WindowName="Au"+TempFermiName
       String EfLevel="Ef"+TempFermiName
       String EfAngle="Ang"+TempFermiName
       String EfFWHM="Wd"+TempFermiName
       Duplicate/O Fermi_Level $EfLevel
       Duplicate/O Fermi_Angle $EfAngle
       Duplicate/O Fermi_FWHM $EfFWHM
       
       DoWindow $WindowName
       
       If(V_flag==0)
       Display $EfLevel vs $EfAngle
//     Display Fermi_Level vs Fermi_Angle
       ModifyGraph mode=4,marker=19
       AppendToGraph/R $EfFWHM vs $EfAngle
//     AppendToGraph/R Fermi_FWHM vs Fermi_Angle
       ModifyGraph rgb($EfFWHM)=(0,15872,65280)
//     ModifyGraph rgb(Fermi_FWHM)=(0,15872,65280)
       ModifyGraph mode=4
       ModifyGraph mirror(bottom)=2
       ModifyGraph standoff(left)=0,standoff(bottom)=0
       Label left "\\Z12\\f01\\K(65280,0,0)Fitted Fermi Level (eV) "
       Label bottom "\\Z12\\f01Analyzer Angle (Degrees)"
       Label right "\\Z12\\f01\\K(0,15872,65280)Fitted FWHM (meV)"
       DoWindow/C $WindowName
       Else
       DoWindow/F $WindowName
       Endif  
       
       
        SetDataFolder Curr	

END

Proc XJZClean(ctrlName) : ButtonControl
	String ctrlName

	String Curr=GetDataFolder(1)
	
	//Kill duplicated files 1D in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledFileList1D=WaveList("A*",";","DIMS:1")
       	Variable NoofKilledFileList1D=ItemsinList(ToBeKilledFileList1D,";")
       	String File1D
	      Variable iFile1D=0
	      Do
	      File1D=StringFromList(iFile1D,ToBeKilledFileList1D,";")
	      KillWaves/Z  $File1D
	      iFile1D+=1
	      While(iFile1D<NoofKilledFileList1D)
	      
	      
	//Kill duplicated files 2D in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledFileList2D=WaveList("A*",";","DIMS:2")
       	Variable NoofKilledFileList2D=ItemsinList(ToBeKilledFileList2D,";")
       	String File2D
	      Variable iFile2D=0
	      Do
	      File2D=StringFromList(iFile2D,ToBeKilledFileList2D,";")
	      KillWaves/Z  $File2D
	      iFile2D+=1
	      While(iFile1D<NoofKilledFileList2D)	      
	      
	      	
	
	
	//Kill EDC Curves in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledEDCList=WaveList("Au*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	      Variable iEDC=0
	      Do
	      EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	      KillWaves/Z  $EDCCurve
	      iEDC+=1
	      While(iEDC<NoofKilledEDCList)
	
	//Kill Fitted Curves in root:FermiLevelFromAu
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	

	SetDataFolder Curr
	
End



Function XJZDoneBotton(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
//Execute XJZClean(ctrlName)

	
	//Kill duplicated files 1D in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledFileList1D=WaveList("A*",";","DIMS:1")
       	Variable NoofKilledFileList1D=ItemsinList(ToBeKilledFileList1D,";")
       	String File1D
	      Variable iFile1D=0
	      Do
	      File1D=StringFromList(iFile1D,ToBeKilledFileList1D,";")
	      KillWaves/Z  $File1D
	      iFile1D+=1
	      While(iFile1D<NoofKilledFileList1D)
	      
	      
	//Kill duplicated files 2D in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledFileList2D=WaveList("A*",";","DIMS:2")
       	Variable NoofKilledFileList2D=ItemsinList(ToBeKilledFileList2D,";")
       	String File2D
	      Variable iFile2D=0
	      Do
	      File2D=StringFromList(iFile2D,ToBeKilledFileList2D,";")
	      KillWaves/Z  $File2D
	      iFile2D+=1
	      While(iFile1D<NoofKilledFileList2D)	      
	      
	      	
	
	
	//Kill EDC Curves in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledEDCList=WaveList("Au*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	      Variable iEDC=0
	      Do
	      EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	      KillWaves/Z  $EDCCurve
	      iEDC+=1
	      While(iEDC<NoofKilledEDCList)
	
	//Kill Fitted Curves in root:FermiLevelFromAu
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	
	DoWindow/K Fermi_Level_Fit_Panel
	
	SetDataFolder Curr
	
End


Function MaxofWave(Wave0)
Wave Wave0
Variable DimofWave0=dimsize(Wave0,0)
Variable MaxofWave=0
Variable i=0
Do
If (Wave0[i]>MaxofWave)
MaxofWave=Wave0[i]
Else
Endif
i+=1
While(i<DimofWave0)
Return MaxofWave
End


Function MinofWave(Wave0)
Wave Wave0
Variable DimofWave0=dimsize(Wave0,0)
Variable MinofWave=Wave0[0]
Variable i=1
Do
If (Wave0[i]<MinofWave)
MinofWave=Wave0[i]
Else
Endif
i+=1
While(i<DimofWave0)
Return MinofWave
End


Function AverageofWave(Wave0)
Wave Wave0
Variable DimofWave0=dimsize(Wave0,0)
Variable SumofWave0, AverageofWave0
Variable i=0
SumofWave0=0

Do
SumofWave0+=Wave0[i]
i+=1
While(i<DimofWave0)
AverageofWave0=SumofWave0/DimofWave0
Return AverageofWave0
End
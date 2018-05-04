#pragma rtGlobals=1		// Use modern global access method.

Proc NumberofLorentzianSelection(ctrlName,popNum,popStr) : PopupMenuControl
//---------------------------------
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
//	Print popNum
	
	IF (popNum==1)
	Print "Number of Lorentzian=", popNum
       root:MDCSpectra:NumberofLorentzianPeaks=1
	EndIF
	
	IF (popNum==2)
       Print "Number of Lorentzian=", popNum
       root:MDCSpectra:NumberofLorentzianPeaks=2
       FitMoreLorentzianPanel( )	
	ENDIF
	
	
	IF (popNum==3)
       Print "Number of Lorentzian=", popNum
       root:MDCSpectra:NumberofLorentzianPeaks=3
       FitMoreLorentzianPanel( )	
	ENDIF
	
	IF (popNum==4)
       Print "Number of Lorentzian=", popNum
       root:MDCSpectra:NumberofLorentzianPeaks=4
       FitMoreLorentzianPanel( )	
	ENDIF
	
	
	IF (popNum==5)
       Print "Number of Lorentzian=", popNum
       root:MDCSpectra:NumberofLorentzianPeaks=5
       FitMoreLorentzianPanel( )	
	ENDIF	
	
	SetDataFolder Curr
END

Proc FitMoreLorentzianPanel( )
   
    String Curr=GetDataFolder(1)
	DoWindow/F More_Lorentzian_Fit_Panel
	if (V_flag==0)
	
       More_Lorentzian_Fit_Panel()
       
       Endif
       
       SetDataFolder Curr	
    
End

Window More_Lorentzian_Fit_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1/W=(0,101,620,380)
	ModifyPanel cbRGB=(64512,62423,1327)
	SetDrawLayer UserBack

//	SetDrawEnv fillfgc= (48896,49152,65280)
//	DrawRRect 13,29,146,224                                 //Process Data
       SetDrawEnv fillfgc= (16384,65280,65280)
	DrawRRect 618,188,1,38                              //Fit initialization

      SetDrawLayer UserBack
      DrawText 685,195,"Fitting Initialization Parameters"
      SetDrawEnv fillfgc= (65495,2134,34028)    
  
      ValDisplay Val_NumberofLorentzians,pos={200,5},size={230,25},title="Number of Lorentzians: ",fSize=15
      ValDisplay Val_NumberofLorentzians,limits={0,6,1},value= root:MDCSpectra:NumberofLorentzianPeaks

      SetVariable set_MDCBackground,pos={225,47},size={170,25},title="BKGD   ",fSize=15
      SetVariable set_MDCBackground,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCBackground
      SetVariable set_MDC1Height,pos={5,90},size={170,25},title="Height1  ",fSize=15
      SetVariable set_MDC1Height,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCHeight 
      SetVariable set_MDC1FWHM,pos={5,120},size={170,25},title="FWHM1 ",fSize=15
      SetVariable set_MDC1FWHM,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCFWHM
      SetVariable set_MDC1Position,pos={5,150},size={170,25},title="Position1",fSize=15
      SetVariable set_MDC1Position,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCPosition
      SetVariable set_MDC2Height,pos={225,90},size={170,25},title="Height2  ",fSize=15
      SetVariable set_MDC2Height,limits={-inf,inf,0.1},value= root:MDCSpectra:MDC2Height 
      SetVariable set_MDC2FWHM,pos={225,120},size={170,25},title="FWHM2 ",fSize=15
      SetVariable set_MDC2FWHM,limits={-inf,inf,0.1},value= root:MDCSpectra:MDC2FWHM
      SetVariable set_MDC2Position,pos={225,150},size={170,25},title="Position2",fSize=15
      SetVariable set_MDC2Position,limits={-inf,inf,0.1},value= root:MDCSpectra:MDC2Position
      SetVariable set_MDC3Height,pos={445,90},size={170,25},title="Height3  ",fSize=15
      SetVariable set_MDC3Height,limits={-inf,inf,0.1},value= root:MDCSpectra:MDC3Height 
      SetVariable set_MDC3FWHM,pos={445,120},size={170,25},title="FWHM3 ",fSize=15
      SetVariable set_MDC3FWHM,limits={-inf,inf,0.1},value= root:MDCSpectra:MDC3FWHM
      SetVariable set_MDC3Position,pos={445,150},size={170,25},title="Position3",fSize=15
      SetVariable set_MDC3Position,limits={-inf,inf,0.1},value= root:MDCSpectra:MDC3Position      
       

      //SetVariable set_StartingCurve,pos={120,200},size={180,25},title="MDCStart",fSize=15
     // SetVariable set_StartingCurve,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCCurveStart    
     // SetVariable set_EndingCurve,pos={345,200},size={150,25},title="End ",fSize=15
     // SetVariable set_EndingCurve,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCCurveEnd
       
      //PopupMenu DispersionMDC_file,pos={180,240},size={190,8}, proc=DispersionFromMDC_VariousPeaks,title="DispersionMDC",fSize=15
      PopupMenu DispersionMDC_file,pos={180,240},size={190,8}, proc=ZWTMDCLorentzFitting,title="DispersionMDC",fSize=15
      PopupMenu DispersionMDC_file,mode=6,popvalue="F2t15O140PP30T0P",value=root:Process:EKPiovera

      Button ExitMDCFitting,pos={525,210},size={80,55},title="Exit",proc=ExitMDCFitting, fSize=20
      

EndMacro




Function DispersionFromMDC_VariousPeaks(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
//Kill fitted Curves in Root:MDCSpectra
	SetDataFolder root:MDCSpectra
	String BeKilledFitList=WaveList("fit_*",";","DIMS:1")
       	Variable NoKilledFitList=ItemsinList(BeKilledFitList,";")
       	String FitCurve
	     Variable iFitted=0
	     Do
	     FitCurve=StringFromList(iFitted,BeKilledFitList,";")
	     KillWaves/Z  $FitCurve
	     iFitted+=1
	     While(iFitted<NoKilledFitList)	     
	     
     Variable ImageNameLength=strlen(popStr)
	 Variable PositionofT=strsearch(popStr,"Dis",0)
	 SVar ThetaAngleMDC=root:MDCSpectra:ThetaAngleForMDCPlot
//	 ThetaAngleMDC=popStr[PositionofT+4,ImageNameLength-1]
	 ThetaAngleMDC=popStr[0,ImageNameLength-1]	 
     Print "ThetaAngleMDC=", ThetaAngleMDC
 
 ////   XJZMDCStackforDispersion(ctrlName,popNum,popStr)
          
        XJZMDCStack_Eb_UnEven_Cor_ND(ctrlName,popNum,popStr) 
          
          Execute "XJLorentzianCurveFit()"
          Execute "DrawMDCDispersion()"
//        DoWindow/K $popStr
           
          SetDataFolder Curr
           
End	


//Lorentzian Fit
Function XJLorentzianFit_OnePeak(w,x)

	//w[0]   constant background;
	//w[1]   Height of the Lorentzian peak; 
	//w[2]   Full Width at Half maximum;
	//w[3]   Lorentzian Peak position;
	//w[4]   Background slope
	wave w; Variable x

	return w[0] +w[4]*x+ w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2))
END

//Two Lorentzians' Fit
Function XJLorentzianFit_TwoPeak(w,x)

	//w[0]   constant background;
	//w[1]   Height of the Lorentzian peak 1; 
	//w[2]   Full Width at Half maximum 1;
	//w[3]   Lorentzian Peak position 1;
	//w[4]   Background slope
	//w[5]   Height of the Lorentzian peak 2; 
	//w[6]   Full Width at Half maximum 2;
	//w[7]   Lorentzian Peak position 2;	
	
	wave w; Variable x

	return w[0] +w[4]*x+ w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2)) + w[5]*(w[6]/2)*(w[6]/2)/((x-w[7])*(x-w[7])+(w[6]/2)*(w[6]/2))
END


//Three Lorentzians' Fit
Function XJLorentzianFit_ThreePeak(w,x)

	//w[0]   constant background;
	//w[1]   Height of the Lorentzian peak 1; 
	//w[2]   Full Width at Half maximum 1;
	//w[3]   Lorentzian Peak position 1;
	//w[4]   Background slope
	//w[5]   Height of the Lorentzian peak 2; 
	//w[6]   Full Width at Half maximum 2;
	//w[7]   Lorentzian Peak position 2;
	//w[8]   Height of the Lorentzian peak 3; 
	//w[9]   Full Width at Half maximum 3;
	//w[10]   Lorentzian Peak position 3;	
	
	wave w; Variable x

	return w[0] +w[4]*x+ w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2)) + w[5]*(w[6]/2)*(w[6]/2)/((x-w[7])*(x-w[7])+(w[6]/2)*(w[6]/2)) + w[8]*(w[9]/2)*(w[9]/2)/((x-w[10])*(x-w[10])+(w[9]/2)*(w[9]/2))
END



Proc XJLorentzianCurveFit_Original()
        
    String Curr=GetDataFolder(1)
    SetDataFolder root:MDCSpectra
    String ReferenceMomentum="KRef_"+root:MDCSpectra:TempMDCName
	String EnergryRefreence="ERef_"+root:MDCSpectra:TempMDCName
    Variable SN, EN, lim
//    String/G ThetaFromName
    Variable i,j 
	String List, Name, TraceName, Order
	String ThetaAngle, NBackground, NHeight1, NFWHM1, NFWHMError1,NPosition1,NPositionError1,NEnergy
	String NHeight2, NFWHM2, NFWHMError2,NPosition2,NPositionError2
	String NHeight3, NFWHM3, NFWHMError3,NPosition3,NPositionError3	
	Variable w0,w1,w2,w3,w4,w5, w6, w7, w8, w9, w10
	
//       ThetaAngle=root:OriginalData:ThetaFromName
//     ThetaAngle=root:MDCFittedParameters:MDCTheta	
	   List=TraceNameList("", ";",1)
//       String/G MDCTheta=ThetaAngle
       SN=root:MDCSpectra:MDCCurveStart
       EN=root:MDCSpectra:MDCCurveEnd
       
       w0=root:MDCSpectra:MDCBackground
       w1=root:MDCSpectra:MDCHeight
       w2=root:MDCSpectra:MDCFWHM
       w3=root:MDCSpectra:MDCPosition	
       w4=1
       w5=root:MDCSpectra:MDC2Height
       w6=root:MDCSpectra:MDC2FWHM
       w7=root:MDCSpectra:MDC2Position	
       w8=root:MDCSpectra:MDC3Height
       w9=root:MDCSpectra:MDC3FWHM
       w10=root:MDCSpectra:MDC3Position	
       Make/O co_OnePeak={w0, w1, w2,w3,w4}
       Make/O co_TwoPeak={w0, w1, w2,w3,w4,w5,w6,w7}     
       Make/O co_ThreePeak={w0, w1, w2,w3,w4,w5,w6,w7,w8,w9,w10}   
       Redimension/D co_OnePeak;DelayUpdate
       Redimension/D co_TwoPeak;DelayUpdate
       Redimension/D co_ThreePeak
         
       
	lim=EN+1
	Make/O/N=((EN-SN+1)) Background=0, Height1=0, FWHM1=0, FWHMError1=0,Position1=0, PositionError1=0,Energy
	Make/O/N=((EN-SN+1)) Height2=0, FWHM2=0, FWHMError2=0, Position2=0, PositionError2=0
    Make/O/N=((EN-SN+1)) Height3=0, FWHM3=0, FWHMError3=0, Position3=0, PositionError3=0
	i=SN
	j=0
	Variable kStart=root:MDCSpectra:DispersionMomentumStart
	Variable kEnd=root:MDCSpectra:DispersionMomentumEnd
	Variable NumofPeaks=root:MDCSpectra:NumberofLorentzianPeaks
	Duplicate/O root:MDCSpectra:$ReferenceMomentum  RefMomentum
	DO
		Name=StringFromList(i,list,";")
		
	    IF(NumofPeaks==1)	
//		FuncFit XJLorentzianFit co root:MDCSpectra:$Name /D /X=root:MDCSpectra:ReferenceMomentumWav
		FuncFit XJLorentzianFit_OnePeak co_OnePeak root:MDCSpectra:$Name /D /X=RefMomentum
            Background[j]=co_OnePeak[0]
	        Height1[j]=co_OnePeak[1]
	        FWHM1[j]=co_OnePeak[2]
	        Position1[j]=co_OnePeak[3]
	        Energy[j]=root:MDCSpectra:ReferenceEnergyWave[i]  //----------Needs to be defined
	        
	        FWHMError1[j]=W_sigma[2]
	        PositionError1[j]=W_sigma[3]
	        
            co_OnePeak[0]=Background[j]
	        co_OnePeak[1]=Height1[j]
	        co_OnePeak[2]=FWHM1[j]
	        co_OnePeak[3]=Position1[j]
	        ENDIF
	        
	       IF(NumofPeaks==2)	
//		FuncFit XJLorentzianFit co root:MDCSpectra:$Name /D /X=root:MDCSpectra:ReferenceMomentumWav
		FuncFit XJLorentzianFit_TwoPeak co_TwoPeak root:MDCSpectra:$Name /D /X=RefMomentum
            Background[j]=co_TwoPeak[0]
	        Height1[j]=co_TwoPeak[1]
	        FWHM1[j]=co_TwoPeak[2]
	        Position1[j]=co_TwoPeak[3]
            Height2[j]=co_TwoPeak[5]
	        FWHM2[j]=co_TwoPeak[6]
	        Position2[j]=co_TwoPeak[7]	        
            Energy[j]=root:MDCSpectra:ReferenceEnergyWave[i]
                
	        FWHMError1[j]=W_sigma[2]
	        PositionError1[j]=W_sigma[3]
	        FWHMError2[j]=W_sigma[6]
	        PositionError2[j]=W_sigma[7]               
	        
            co_TwoPeak[0]=Background[j]
	        co_TwoPeak[1]=Height1[j]
	        co_TwoPeak[2]=FWHM1[j]
	        co_TwoPeak[3]=Position1[j]
	        co_TwoPeak[5]=Height2[j]
	        co_TwoPeak[6]=FWHM2[j]
	        co_TwoPeak[7]=Position2[j]	        
	        ENDIF	
	        
	        
	    IF(NumofPeaks==3)	
//		FuncFit XJLorentzianFit co root:MDCSpectra:$Name /D /X=root:MDCSpectra:ReferenceMomentumWav
		FuncFit XJLorentzianFit_ThreePeak co_ThreePeak root:MDCSpectra:$Name /D /X=RefMomentum
            Background[j]=co_ThreePeak[0]
	        Height1[j]=co_ThreePeak[1]
	        FWHM1[j]=co_ThreePeak[2]
	        Position1[j]=co_ThreePeak[3]
            Height2[j]=co_ThreePeak[5]
	        FWHM2[j]=co_ThreePeak[6]
	        Position2[j]=co_ThreePeak[7]
            Height3[j]=co_ThreePeak[8]
	        FWHM3[j]=co_ThreePeak[9]
	        Position3[j]=co_ThreePeak[10]        	        
            Energy[j]=root:MDCSpectra:ReferenceEnergyWave[i]
                
            FWHMError1[j]=W_sigma[2]
	        PositionError1[j]=W_sigma[3]
	        FWHMError2[j]=W_sigma[6]
	        PositionError2[j]=W_sigma[7]    
            FWHMError3[j]=W_sigma[9]
	        PositionError3[j]=W_sigma[10]               
                
	        
            co_TwoPeak[0]=Background[j]
	        co_TwoPeak[1]=Height1[j]
	        co_TwoPeak[2]=FWHM1[j]
	        co_TwoPeak[3]=Position1[j]
	        co_TwoPeak[5]=Height2[j]
	        co_TwoPeak[6]=FWHM2[j]
	        co_TwoPeak[7]=Position2[j]
	        co_TwoPeak[8]=Height3[j]
	        co_TwoPeak[9]=FWHM3[j]
	        co_TwoPeak[10]=Position3[j]	        	        
	        ENDIF		        
	        
            j+=1
		i+=1
	WHILE(i<lim)
	
//	NBackground= "Background"+ThetaAngleforMDCPlot
    NBackground= "BKGD"+ThetaAngleforMDCPlot
	NHeight1= "Height1"+ThetaAngleforMDCPlot
	NFWHM1= "FWHM1"+ThetaAngleforMDCPlot
	NPosition1= "Position1"+ThetaAngleforMDCPlot
	NEnergy="Energy"+ThetaAngleforMDCPlot
	
	NFWHMError1="FWHMError1"+ThetaAngleforMDCPlot
	NPositionError1="PosError1"+ThetaAngleforMDCPlot
	
	    IF(NumofPeaks==2)	
		NHeight2= "Height2"+ThetaAngleforMDCPlot
		NFWHM2= "FWHM2"+ThetaAngleforMDCPlot
		NPosition2= "Position2"+ThetaAngleforMDCPlot
		
		NFWHMError2= "FWHMError2"+ThetaAngleforMDCPlot
		NPositionError2= "PosError2"+ThetaAngleforMDCPlot		
			
		ENDIF
		
	    IF(NumofPeaks==3)
		NHeight2= "Height2"+ThetaAngleforMDCPlot
		NFWHM2= "FWHM2"+ThetaAngleforMDCPlot
		NPosition2= "Position2"+ThetaAngleforMDCPlot       	
		NHeight3= "Height3"+ThetaAngleforMDCPlot
		NFWHM3= "FWHM3"+ThetaAngleforMDCPlot
		NPosition3= "Position3"+ThetaAngleforMDCPlot
		
		NFWHMError2= "FWHMError2"+ThetaAngleforMDCPlot
		NPositionError2= "PosError2"+ThetaAngleforMDCPlot       	
		NFWHMError3= "FWHMError3"+ThetaAngleforMDCPlot
		NPositionError3= "PosError3"+ThetaAngleforMDCPlot		
		
			
		ENDIF		
		
		
	Duplicate/O Background, root:MDCFittedParameters:$NBackground
	Duplicate/O Height1, root:MDCFittedParameters:$NHeight1
	Duplicate/O FWHM1, root:MDCFittedParameters:$NFWHM1
	Duplicate/O FWHMError1, root:MDCFittedParameters:$NFWHMError1	
	Duplicate/O Position1, root:MDCFittedParameters:$NPosition1
	Duplicate/O PositionError1, root:MDCFittedParameters:$NPositionError1	
	Duplicate/O Energy, root:MDCFittedParameters:$NEnergy
	
	
	       IF(NumofPeaks==2)
		Duplicate/O Height2, root:MDCFittedParameters:$NHeight2
		Duplicate/O FWHM2, root:MDCFittedParameters:$NFWHM2
		Duplicate/O FWHMError2, root:MDCFittedParameters:$NFWHMError2		
		Duplicate/O Position2, root:MDCFittedParameters:$NPosition2
         	Duplicate/O PositionError2, root:MDCFittedParameters:$NPositionError2		
		
		ENDIF       	

	       IF(NumofPeaks==3)
		Duplicate/O Height2, root:MDCFittedParameters:$NHeight2
		Duplicate/O FWHM2, root:MDCFittedParameters:$NFWHM2
		Duplicate/O FWHMError2, root:MDCFittedParameters:$NFWHMError2
		Duplicate/O Position2, root:MDCFittedParameters:$NPosition2
		Duplicate/O PositionError2, root:MDCFittedParameters:$NPositionError2	       
		Duplicate/O Height3, root:MDCFittedParameters:$NHeight3
		Duplicate/O FWHM3, root:MDCFittedParameters:$NFWHM3
		Duplicate/O FWHMError3, root:MDCFittedParameters:$NFWHMError3
		Duplicate/O Position3, root:MDCFittedParameters:$NPosition3
                 Duplicate/O PositionError3, root:MDCFittedParameters:$NPositionError3
	
		ENDIF       	
	
       SetDataFolder Curr	

END




//This procedure is made on 2007/05/19, fitting MDCIntensity vs MDCMomentum with different k range and uneven interval 
Proc XJLorentzianCurveFit()
        
    String Curr=GetDataFolder(1)
    SetDataFolder root:MDCSpectra
    String ReferenceMomentum="KRef_"+root:MDCSpectra:TempMDCName
	String EnergryRefreence="ERef_"+root:MDCSpectra:TempMDCName
    Variable SN, EN, lim
    String/G ThetaFromName
    Variable i,j 
	String List, Name, TraceName, Order
	String ThetaAngle, NBackground, NHeight1, InvNHeight1, NFWHM1, NFWHMError1,NPosition1,NPositionError1,NEnergy
	String NHeight2, InvNHeight2, NFWHM2, NFWHMError2,NPosition2,NPositionError2
	String NHeight3, InvNHeight3, NFWHM3, NFWHMError3,NPosition3,NPositionError3	
	Variable w0,w1,w2,w3,w4,w5, w6, w7, w8, w9, w10
	
////       ThetaAngle=root:OriginalData:ThetaFromName
//     ThetaAngle=root:MDCFittedParameters:MDCTheta	
	   List=TraceNameList("", ";",1)
       String/G MDCTheta=ThetaAngle
       SN=root:MDCSpectra:MDCCurveStart
       EN=root:MDCSpectra:MDCCurveEnd
       
       w0=root:MDCSpectra:MDCBackground
       w1=root:MDCSpectra:MDCHeight
       w2=root:MDCSpectra:MDCFWHM
       w3=root:MDCSpectra:MDCPosition	
       w4=1
       w5=root:MDCSpectra:MDC2Height
       w6=root:MDCSpectra:MDC2FWHM
       w7=root:MDCSpectra:MDC2Position	
       w8=root:MDCSpectra:MDC3Height
       w9=root:MDCSpectra:MDC3FWHM
       w10=root:MDCSpectra:MDC3Position	
       Make/O co_OnePeak={w0, w1, w2,w3,w4}
       Make/O co_TwoPeak={w0, w1, w2,w3,w4,w5,w6,w7}     
       Make/O co_ThreePeak={w0, w1, w2,w3,w4,w5,w6,w7,w8,w9,w10}   
       Redimension/D co_OnePeak;DelayUpdate
       Redimension/D co_TwoPeak;DelayUpdate
       Redimension/D co_ThreePeak
         
       
	lim=EN+1
	Make/O/N=((EN-SN+1)) Background=0, Height1=0, FWHM1=0, FWHMError1=0,Position1=0, PositionError1=0,Energy
	Make/O/N=((EN-SN+1)) Height2=0, FWHM2=0, FWHMError2=0, Position2=0, PositionError2=0
    Make/O/N=((EN-SN+1)) Height3=0, FWHM3=0, FWHMError3=0, Position3=0, PositionError3=0
	i=SN
	j=0
	Variable kStart=root:MDCSpectra:DispersionMomentumStart
	Variable kEnd=root:MDCSpectra:DispersionMomentumEnd
	Variable NumofPeaks=root:MDCSpectra:NumberofLorentzianPeaks
////Duplicate/O root:MDCSpectra:$ReferenceMomentum  RefMomentum
	
	
	String ToFitMDCIntensity, ToFitMDCMomentum
	
	
	DO
		Name=StringFromList(i,list,";")
		
////    Print Name

		
	    ToFitMDCIntensity="MDCIntensity"+num2str(i)
	    ToFitMDCMomentum="MDcMomentum"+num2str(i)


	    IF(NumofPeaks==1)		    
	    
////	FuncFit XJLorentzianFit_OnePeak co_OnePeak root:MDCSpectra:$Name /D /X=RefMomentum		
		FuncFit XJLorentzianFit_OnePeak co_OnePeak root:MDCSpectra:$ToFitMDCIntensity /D /X=$ToFitMDCMomentum	
		
            Background[j]=co_OnePeak[0]
	        Height1[j]=co_OnePeak[1]
	        FWHM1[j]=co_OnePeak[2]
	        Position1[j]=co_OnePeak[3]
	        Energy[j]=root:MDCSpectra:ReferenceEnergyWave[i]
	        
	        FWHMError1[j]=W_sigma[2]
	        PositionError1[j]=W_sigma[3]
	        
            co_OnePeak[0]=Background[j]
	        co_OnePeak[1]=Height1[j]
	        co_OnePeak[2]=FWHM1[j]
	        co_OnePeak[3]=Position1[j]
	        ENDIF
	        
	       IF(NumofPeaks==2)	
//		FuncFit XJLorentzianFit co root:MDCSpectra:$Name /D /X=root:MDCSpectra:ReferenceMomentumWav
//		FuncFit XJLorentzianFit_TwoPeak co_TwoPeak root:MDCSpectra:$Name /D /X=RefMomentum
		FuncFit XJLorentzianFit_TwoPeak co_TwoPeak root:MDCSpectra:$ToFitMDCIntensity /D /X=$ToFitMDCMomentum		
		
		
		
            Background[j]=co_TwoPeak[0]
	        Height1[j]=co_TwoPeak[1]
	        FWHM1[j]=co_TwoPeak[2]
	        Position1[j]=co_TwoPeak[3]
            Height2[j]=co_TwoPeak[5]
	        FWHM2[j]=co_TwoPeak[6]
	        Position2[j]=co_TwoPeak[7]	        
            Energy[j]=root:MDCSpectra:ReferenceEnergyWave[i]
                
	        FWHMError1[j]=W_sigma[2]
	        PositionError1[j]=W_sigma[3]
	        FWHMError2[j]=W_sigma[6]
	        PositionError2[j]=W_sigma[7]               
	        
            co_TwoPeak[0]=Background[j]
	        co_TwoPeak[1]=Height1[j]
	        co_TwoPeak[2]=FWHM1[j]
	        co_TwoPeak[3]=Position1[j]
	        co_TwoPeak[5]=Height2[j]
	        co_TwoPeak[6]=FWHM2[j]
	        co_TwoPeak[7]=Position2[j]	        
	        ENDIF	
	        
	        
	    IF(NumofPeaks==3)	
//		FuncFit XJLorentzianFit co root:MDCSpectra:$Name /D /X=root:MDCSpectra:ReferenceMomentumWav
//		FuncFit XJLorentzianFit_ThreePeak co_ThreePeak root:MDCSpectra:$Name /D /X=RefMomentum
	    FuncFit XJLorentzianFit_ThreePeak co_ThreePeak root:MDCSpectra:$ToFitMDCIntensity /D /X=$ToFitMDCMomentum
		
		
            Background[j]=co_ThreePeak[0]
	        Height1[j]=co_ThreePeak[1]
	        FWHM1[j]=co_ThreePeak[2]
	        Position1[j]=co_ThreePeak[3]
            Height2[j]=co_ThreePeak[5]
	        FWHM2[j]=co_ThreePeak[6]
	        Position2[j]=co_ThreePeak[7]
            Height3[j]=co_ThreePeak[8]
	        FWHM3[j]=co_ThreePeak[9]
	        Position3[j]=co_ThreePeak[10]        	        
            Energy[j]=root:MDCSpectra:ReferenceEnergyWave[i]
                
            FWHMError1[j]=W_sigma[2]
	        PositionError1[j]=W_sigma[3]
	        FWHMError2[j]=W_sigma[6]
	        PositionError2[j]=W_sigma[7]    
            FWHMError3[j]=W_sigma[9]
	        PositionError3[j]=W_sigma[10]               
                
	        
            co_TwoPeak[0]=Background[j]
	        co_TwoPeak[1]=Height1[j]
	        co_TwoPeak[2]=FWHM1[j]
	        co_TwoPeak[3]=Position1[j]
	        co_TwoPeak[5]=Height2[j]
	        co_TwoPeak[6]=FWHM2[j]
	        co_TwoPeak[7]=Position2[j]
	        co_TwoPeak[8]=Height3[j]
	        co_TwoPeak[9]=FWHM3[j]
	        co_TwoPeak[10]=Position3[j]	        	        
	        ENDIF		        
	        
            j+=1
		i+=1
	WHILE(i<lim)
	
//	NBackground= "Background"+ThetaAngleforMDCPlot
    NBackground= "BKGD"+ThetaAngleforMDCPlot
	NHeight1= "Height1"+ThetaAngleforMDCPlot
	InvNHeight1= "InvHeight1"+ThetaAngleforMDCPlot
	NFWHM1= "FWHM1"+ThetaAngleforMDCPlot
	NPosition1= "Position1"+ThetaAngleforMDCPlot
	NEnergy="Energy"+ThetaAngleforMDCPlot
	
	NFWHMError1="FWHMError1"+ThetaAngleforMDCPlot
	NPositionError1="PosError1"+ThetaAngleforMDCPlot
	
	    IF(NumofPeaks==2)	
		NHeight2= "Height2"+ThetaAngleforMDCPlot
		InvNHeight2= "InvHeight2"+ThetaAngleforMDCPlot		
		NFWHM2= "FWHM2"+ThetaAngleforMDCPlot
		NPosition2= "Position2"+ThetaAngleforMDCPlot
		
		NFWHMError2= "FWHMError2"+ThetaAngleforMDCPlot
		NPositionError2= "PosError2"+ThetaAngleforMDCPlot		
			
		ENDIF
		
	    IF(NumofPeaks==3)
		NHeight2= "Height2"+ThetaAngleforMDCPlot
		InvNHeight2= "InvHeight2"+ThetaAngleforMDCPlot		
		NFWHM2= "FWHM2"+ThetaAngleforMDCPlot
		NPosition2= "Position2"+ThetaAngleforMDCPlot       	
		NHeight3= "Height3"+ThetaAngleforMDCPlot
		InvNHeight3= "InvHeight3"+ThetaAngleforMDCPlot		
		NFWHM3= "FWHM3"+ThetaAngleforMDCPlot
		NPosition3= "Position3"+ThetaAngleforMDCPlot
		
		NFWHMError2= "FWHMError2"+ThetaAngleforMDCPlot
		NPositionError2= "PosError2"+ThetaAngleforMDCPlot       	
		NFWHMError3= "FWHMError3"+ThetaAngleforMDCPlot
		NPositionError3= "PosError3"+ThetaAngleforMDCPlot		
		
			
		ENDIF		
		
		
	Duplicate/O Background, root:MDCFittedParameters:$NBackground
	Duplicate/O Height1, root:MDCFittedParameters:$NHeight1
	Duplicate/O Height1, root:MDCFittedParameters:$InvNHeight1	
	root:MDCFittedParameters:$InvNHeight1=1/root:MDCFittedParameters:$NHeight1
	
	
	Duplicate/O FWHM1, root:MDCFittedParameters:$NFWHM1
	Duplicate/O FWHMError1, root:MDCFittedParameters:$NFWHMError1	
	Duplicate/O Position1, root:MDCFittedParameters:$NPosition1
	Duplicate/O PositionError1, root:MDCFittedParameters:$NPositionError1	
	Duplicate/O Energy, root:MDCFittedParameters:$NEnergy
	
	
	       IF(NumofPeaks==2)
		Duplicate/O Height2, root:MDCFittedParameters:$NHeight2
		Duplicate/O Height2, root:MDCFittedParameters:$InvNHeight2
		root:MDCFittedParameters:$InvNHeight2=1/root:MDCFittedParameters:$NHeight2
		
		Duplicate/O FWHM2, root:MDCFittedParameters:$NFWHM2
		Duplicate/O FWHMError2, root:MDCFittedParameters:$NFWHMError2		
		Duplicate/O Position2, root:MDCFittedParameters:$NPosition2
        Duplicate/O PositionError2, root:MDCFittedParameters:$NPositionError2		
		
		ENDIF       	

	       IF(NumofPeaks==3)
		Duplicate/O Height2, root:MDCFittedParameters:$NHeight2
		Duplicate/O Height2, root:MDCFittedParameters:$InvNHeight2
		
		root:MDCFittedParameters:$InvNHeight2=1/root:MDCFittedParameters:$NHeight2
		
		Duplicate/O FWHM2, root:MDCFittedParameters:$NFWHM2
		Duplicate/O FWHMError2, root:MDCFittedParameters:$NFWHMError2
		Duplicate/O Position2, root:MDCFittedParameters:$NPosition2
		Duplicate/O PositionError2, root:MDCFittedParameters:$NPositionError2	       
		Duplicate/O Height3, root:MDCFittedParameters:$NHeight3
		Duplicate/O Height3, root:MDCFittedParameters:$InvNHeight3
		
	    root:MDCFittedParameters:$InvNHeight3=1/root:MDCFittedParameters:$NHeight3
	
		Duplicate/O FWHM3, root:MDCFittedParameters:$NFWHM3
		Duplicate/O FWHMError3, root:MDCFittedParameters:$NFWHMError3
		Duplicate/O Position3, root:MDCFittedParameters:$NPosition3
       Duplicate/O PositionError3, root:MDCFittedParameters:$NPositionError3
	
		ENDIF       	
	
       SetDataFolder Curr	

END



Proc DrawMDCDispersion()
       String Curr=GetDataFolder(1)
       String Theta, NBackground, NHeight1,InvNHeight1, NFWHM1, NFWHMError1,NPosition1, NPositionError1,NEnergy
       String NHeight2, InvNHeight2, NFWHM2, NFWHMError2, NPosition2, NPositionError2
       String NHeight3, InvNHeight3, NFWHM3, NFWHMError3, NPosition3, NPositionError3
	SetDataFolder root:MDCFittedParameters
	NHeight1="Ht1"+root:MDCSpectra:ThetaAngleforMDCPlot
	InvNHeight1="IvH1"+root:MDCSpectra:ThetaAngleforMDCPlot
	NPosition1="Psn1"+root:MDCSpectra:ThetaAngleforMDCPlot
	NPositionError1="PsEr1"+root:MDCSpectra:ThetaAngleforMDCPlot
	NFWHM1="FM1"+root:MDCSpectra:ThetaAngleforMDCPlot
	NFWHMError1="FMEr1"+root:MDCSpectra:ThetaAngleforMDCPlot
	NEnergy="Ey"+root:MDCSpectra:ThetaAngleforMDCPlot
	NHeight2="Ht2"+root:MDCSpectra:ThetaAngleforMDCPlot
	InvNHeight2="IvH1"+root:MDCSpectra:ThetaAngleforMDCPlot	
	NPosition2="Psn2"+root:MDCSpectra:ThetaAngleforMDCPlot
	NPositionError2="PsEr2"+root:MDCSpectra:ThetaAngleforMDCPlot
	NFWHM2="FM2"+root:MDCSpectra:ThetaAngleforMDCPlot
	NFWHMError2="FMEr2"+root:MDCSpectra:ThetaAngleforMDCPlot
	NHeight3="Ht3"+root:MDCSpectra:ThetaAngleforMDCPlot
	InvNHeight3="IvH3"+root:MDCSpectra:ThetaAngleforMDCPlot
	NPosition3="Psn3"+root:MDCSpectra:ThetaAngleforMDCPlot
	NPositionError3="PsEr3"+root:MDCSpectra:ThetaAngleforMDCPlot
	NFWHM3="FM3"+root:MDCSpectra:ThetaAngleforMDCPlot
	NFWHMError3="FMEr3"+root:MDCSpectra:ThetaAngleforMDCPlot	
	
		
//	String DispersionName="Dispersion"+root:MDCSpectra:ThetaAngleforMDCPlot
	String DispersionName="Disp"+root:MDCSpectra:ThetaAngleforMDCPlot
//	Print DispersionName
	Variable NoofPeaks=root:MDCSpectra:NumberofLorentzianPeaks
	
	
	 DoWindow $DispersionName
	 if(V_flag==0)
     Display/K=1 as "Dispersion"+root:MDCSpectra:ThetaAngleforMDCPlot
	 AppendToGraph/L=LHeight/B=BHeight $NHeight1 vs $NEnergy
	 
	 AppendToGraph/L=LPosition/B=BPosition $NPosition1 vs $NEnergy
	 ErrorBars $NPosition1 Y,wave=($NPositionError1,$NPositionError1)
	 
	 AppendToGraph/L=LFWHM/B=BFWHM $NFWHM1 vs $NEnergy
	 ErrorBars $NFWHM1 Y,wave=($NFWHMError1,$NFWHMError1)
	 
	 
	 AppendToGraph/R=RInvHeight/B=BHeight $InvNHeight1 vs $NEnergy
	 
	 ModifyGraph marker($InvNHeight1)=8
	 

	 	IF (NoofPeaks==2)
	 	AppendToGraph/L=LHeight/B=BHeight $NHeight2 vs $NEnergy
		AppendToGraph/L=LPosition/B=BPosition $NPosition2 vs $NEnergy
	        ErrorBars $NPosition2 Y,wave=($NPositionError2,$NPositionError2)
	        	        
	 	AppendToGraph/L=LFWHM/B=BFWHM $NFWHM2 vs $NEnergy
	 	ErrorBars $NFWHM2 Y,wave=($NFWHMError2,$NFWHMError2)
	 	
	 	AppendToGraph/R=RInvHeight/B=BHeight $InvNHeight2 vs $NEnergy
	 	
	 	
	 	ENDIF

	 	IF (NoofPeaks==3)
	 	AppendToGraph/L=LHeight/B=BHeight $NHeight2 vs $NEnergy
		AppendToGraph/L=LPosition/B=BPosition $NPosition2 vs $NEnergy
		ErrorBars $NPosition2 Y,wave=($NPositionError2,$NPositionError2)		
		
	 	AppendToGraph/L=LFWHM/B=BFWHM $NFWHM2 vs $NEnergy
	 	ErrorBars $NFWHM2 Y,wave=($NFWHMError2,$NFWHMError2)
	 		
	    AppendToGraph/R=RInvHeight/B=BHeight $InvNHeight2 vs $NEnergy 	
	 		 	
	 		 	
	 	AppendToGraph/L=LHeight/B=BHeight $NHeight3 vs $NEnergy
		AppendToGraph/L=LPosition/B=BPosition $NPosition3 vs $NEnergy
		ErrorBars $NPosition3 Y,wave=($NPositionError3,$NPositionError3)
		
	 	AppendToGraph/L=LFWHM/B=BFWHM $NFWHM3 vs $NEnergy
	 	ErrorBars $NFWHM3 Y,wave=($NFWHMError3,$NFWHMError3)
	 	
	 	AppendToGraph/R=RInvHeight/B=BHeight $InvNHeight3 vs $NEnergy
	 	
	 	ENDIF	 	
 



        ModifyGraph axisEnab(LHeight)={0.6666,1},axisEnab(LPosition)={0.3333,0.6666};DelayUpdate
        ModifyGraph axisEnab(LFWHM)={0,0.3333},axisEnab(RInvHeight)={0,0.333};DelayUpdate
        Modifygraph freePos(LHeight)={root:MDCSpectra:DispersionEnergyStart,BHeight};DelayUpdate
        ModifyGraph freePos(BHeight)={0,LHeight},freePos(LPosition)={root:MDCSpectra:DispersionEnergyStart,BPosition};DelayUpdate
        ModifyGraph freePos(BPosition)={0,LPosition},freePos(LFWHM)={root:MDCSpectra:DispersionEnergyStart,BFWHM};DelayUpdate
        ModifyGraph freePos(BFWHM)={0,LFWHM}, freePos(RInvHeight)={root:MDCSpectra:DispersionEnergyEnd,BFWHM}
        ModifyGraph standoff=0
        SetAxis BHeight  root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd 
        SetAxis BPosition  root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd 
        SetAxis BFWHM root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd 
//      SetAxis LHeight  root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd 
        SetAxis LPosition  root:MDCSpectra:DispersionMomentumStart,root:MDCSpectra:DispersionMomentumEnd 
//      SetAxis LFWHM root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd        
        ModifyGraph mirror=2
        ModifyGraph margin(left)=54,margin(bottom)=54,margin(top)=14,margin(right)=70;DelayUpdate
        ModifyGraph width=0,height=0, mode=4; DelayUpdate
        ModifyGraph marker($NHeight1)=19, mode($NHeight1)=0; DelayUpdate
        ModifyGraph marker($NPosition1)=19, mode($NPosition1)=3, msize($NPosition1)=2;DelayUpdate
        ModifyGraph marker($NFWHM1)=19, mode($NFWHM1)=3, msize($NFWHM1)=2;DelayUpdate
        ModifyGraph rgb($NHeight1)=(0,0,0), rgb($NPosition1)=(0,0,0), rgb($NFWHM1)=(0,0,0);DelayUpdate
        ModifyGraph width={Aspect,0.5}
        ModifyGraph tick=2
	        IF (NoofPeaks==2)
	        ModifyGraph marker($NHeight2)=19,marker($NPosition2)=5, marker($NFWHM2)=2;DelayUpdate
	        ModifyGraph rgb($NHeight2)=(65280,0,0), rgb($NPosition2)=(65280,0,0), rgb($NFWHM2)=(65280,0,0);DelayUpdate 
  	        ENDIF
	        IF (NoofPeaks==3)
	        ModifyGraph marker($NHeight2)=19,marker($NPosition2)=5, marker($NFWHM2)=2;DelayUpdate
	        ModifyGraph rgb($NHeight2)=(65280,0,0), rgb($NPosition2)=(65280,0,0), rgb($NFWHM2)=(65280,0,0);DelayUpdate 
	        ModifyGraph marker($NHeight3)=19,marker($NPosition3)=5, marker($NFWHM3)=2;DelayUpdate
	        ModifyGraph rgb($NHeight3)=(0,12800,52224), rgb($NPosition3)=(0,12800,52224), rgb($NFWHM3)=(0,12800,52224);DelayUpdate 
	        ENDIF        
               
        Label LHeight "\\Z10\\f01Height"
        Label LPosition "\\Z10\\f01Position"
        Label LFWHM "\\Z10\\f01FWHM"
        ModifyGraph lblPos(LHeight)=45
        ModifyGraph lblPos(LPosition)=45
        ModifyGraph lblPos(BFWHM)=45
        ModifyGraph lblPos(LFWHM)=45
        SetAxis/A
        ModifyGraph lblRot(RInvHeight)=180;DelayUpdate
        Label RInvHeight "\\Z14Inverse Height"
        ModifyGraph lblPos(RInvHeight)=50
        ModifyGraph noLabel(BHeight)=2,noLabel(BPosition)=2
        Legend/N=text1/F=0/A=LT
        Label BFWHM "\\Z12\\f01Energy Relative to E\\BF\\M\\Z12 (eV)"
        ModifyGraph zero(BFWHM)=3
        ModifyGraph width={Aspect,0.45}
        ModifyGraph height=425

                                 
        		DoWindow/C $DispersionName
	        	else
	        	DoWindow/F $DispersionName
	        		
	        		
        ModifyGraph axisEnab(LHeight)={0.6666,1},axisEnab(LPosition)={0.3333,0.6666};DelayUpdate
        ModifyGraph axisEnab(LFWHM)={0,0.3333},freePos(LHeight)={root:MDCSpectra:DispersionEnergyStart,BHeight};DelayUpdate
        ModifyGraph freePos(BHeight)={0,LHeight},freePos(LPosition)={root:MDCSpectra:DispersionEnergyStart,BPosition};DelayUpdate
        ModifyGraph freePos(BPosition)={0,LPosition},freePos(LFWHM)={root:MDCSpectra:DispersionEnergyStart,BFWHM};DelayUpdate
        ModifyGraph freePos(BFWHM)={0,LFWHM}
        SetAxis BHeight  root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd 
        SetAxis BPosition  root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd 
        SetAxis BFWHM root:MDCSpectra:DispersionEnergyStart,root:MDCSpectra:DispersionEnergyEnd 
        ModifyGraph mirror=2
        ModifyGraph margin(left)=54,margin(bottom)=54,margin(top)=14,margin(right)=24;DelayUpdate
        ModifyGraph width=0,height=0, mode=4
        ModifyGraph marker($NHeight1)=19,marker($NPosition1)=5, marker($NFWHM1)=2;DelayUpdate
        ModifyGraph rgb($NHeight1)=(0,0,0), rgb($NPosition1)=(0,0,0), rgb($NFWHM1)=(0,0,0);DelayUpdate
        Label LHeight "\\Z10\\f01Height"
        Label LPosition "\\Z10\\f01Position"
        Label LFWHM "\\Z10\\f01FWHM"
        ModifyGraph lblPos(LHeight)=45
        ModifyGraph lblPos(LPosition)=45
        ModifyGraph lblPos(BFWHM)=45
        ModifyGraph lblPos(LFWHM)=45
        ModifyGraph noLabel(BHeight)=2,noLabel(BPosition)=2
//      Legend/N=text1/F=0/A=LB
        Label BFWHM "\\Z12\\f01Energy Relative to E\\BF\\M\\Z12 (eV)"
        ModifyGraph zero(BFWHM)=3
        ModifyGraph height=520

	Endif  
	
	SetDataFolder Curr
  END

Function ExitMDCFitting(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	
	//Kill MDC Curves in root:MDCSpectra
	SetDataFolder root:MDCSpectra
	String ToBeKilledMDCList=WaveList("Dis*",";","DIMS:1")
       	Variable NoofKilledMDCList=ItemsinList(ToBeKilledMDCList,";")
       	String MDCCurve
	      Variable iMDC=0
	      Do
	      MDCCurve=StringFromList(iMDC,ToBeKilledMDCList,";")
	      KillWaves/Z  $MDCCurve
	      iMDC+=1
	      While(iMDC<NoofKilledMDCList)
	
	//Kill Fitted Curves in root:MDCSpectra
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	
	DoWindow/K More_Lorentzian_Fit_Panel
	
	SetDataFolder Curr
	
End

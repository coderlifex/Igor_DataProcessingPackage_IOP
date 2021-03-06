#pragma rtGlobals=1		// Use modern global access method.



Proc CleanProcessFolder()
String Curr

//Kill EDC Curves in Root:PROCESSEDIMAGESpectra
	SetDataFolder root:PROCESSEDIMAGESpectra
	String ToBeKilledEDCList=WaveList("*F*P*T*",";","DIMS:1")
	String ToBeKilledEnergyList=WaveList("E*F*P*T*",";","DIMS:1")
       Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       Variable NoofKilledEnergyList=itemsinList(ToBeKilledEnergyList,";")
            String EDCCurve, EnergyCurve
	     Variable iEDC=0
	     Do
	     EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	     KillWaves/Z  $EDCCurve
	     iEDC+=1
	     While(iEDC<NoofKilledEDCList)
	     
	     Variable iEnergy=0
	     Do
	     EnergyCurve=StringFromList(iEnergy,ToBeKilledEnergyList,";")
	     KillWaves/Z  $EnergyCurve
	     iEnergy+=1
	     While(iEnergy<NoofKilledEnergyList)
	     
	     
//Kill EDC Curves in Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG
	SetDataFolder Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG
	String ToBeKilledEDCList2=WaveList("*F*P*T*",";","DIMS:1")
	String ToBeKilledEnergyList2=WaveList("E*F*P*T*",";","DIMS:1")
       Variable NoofKilledEDCList2=ItemsinList(ToBeKilledEDCList2,";")
       Variable NoofKilledEnergyList2=itemsinList(ToBeKilledEnergyList2,";")
            String EDCCurve2, EnergyCurve2
	     Variable iEDC2=0
	     Do
	     EDCCurve2=StringFromList(iEDC2,ToBeKilledEDCList2,";")
	     KillWaves/Z  $EDCCurve2
	     iEDC2+=1
	     While(iEDC2<NoofKilledEDCList2)
	     
	     Variable iEnergy2=0
	     Do
	     EnergyCurve2=StringFromList(iEnergy2,ToBeKilledEnergyList2,";")
	     KillWaves/Z  $EnergyCurve2
	     iEnergy2+=1
	     While(iEnergy2<NoofKilledEnergyList2)	  	     
	     
	     
	     

SetDataFolder Curr
END



Proc CleanProcessFolder_Symmetrize()
String Curr

//Kill Energy Axis in Symmetrized EDC Curves in Root:PROCESSEDIMAGESpectra
	SetDataFolder root:PROCESSEDIMAGESpectra
	String ToBeKilledEnergyList=WaveList("Energy*",";","DIMS:1")
         Variable NoofKilledEnergyList=itemsinList(ToBeKilledEnergyList,";")
////         Print "NoofKilledEnergyList=", NoofKilledEnergyList
         String  EnergyCurve
	     Variable iEDC=0
  
	     Variable iEnergy=0
	     Do
	     EnergyCurve=StringFromList(iEnergy,ToBeKilledEnergyList,";")
	     KillWaves/Z  $EnergyCurve
	     iEnergy+=1
	     While(iEnergy<NoofKilledEnergyList)	     

SetDataFolder Curr
END




Proc InterpolateFermiLevel()
        String Curr=GetDataFolder(1)
        SetDataFolder root:FermiLevelFromAu
        	         IF (CorrectionFlag==1)
                 Interpolate/T=1/N=(NYImage)/Y=Fermi_Level_L/X=Fermi_Level_Lx Fermi_Level/X=Fermi_Angle
                 ENDIF  
         SetDataFolder Curr
                
End


Proc EDCDisplayModeSelection(ctrlName,popNum,popStr) : PopupMenuControl
//---------------------------------
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
	if (cmpstr(popStr,"EVEN")==0)
       root:PROCESS:EDCDisplayMode=0
       Print "EDCDisplayMode=", root:PROCESS:EDCDisplayMode, "Even Display"
	endif
	if (cmpstr(popStr,"unEVEN_up")==0)
       root:PROCESS:EDCDisplayMode=1
       Print "EDCDisplayMode=", root:PROCESS:EDCDisplayMode, "unEven_up Display"
	endif
	if (cmpstr(popStr,"unEVEN_down")==0)
       root:PROCESS:EDCDisplayMode=2
       Print "EDCDisplayMode=", root:PROCESS:EDCDisplayMode, "unEven_down Display"
	endif	
	if (cmpstr(popStr,"EVENSymmetrized")==0)
       root:PROCESS:EDCDisplayMode=3
       Print "EDCDisplayMode=", root:PROCESS:EDCDisplayMode, "EVENSymmetrized Display"
	endif
	if (cmpstr(popStr,"unEVENSymmetrized_up")==0)
       root:PROCESS:EDCDisplayMode=4
       Print "EDCDisplayMode=", root:PROCESS:EDCDisplayMode, "unEVENupSymmetrized Display"
	endif	
	if (cmpstr(popStr,"unEVENSymmetrized_down")==0)
       root:PROCESS:EDCDisplayMode=5
       Print "EDCDisplayMode=", root:PROCESS:EDCDisplayMode, "unEVENdownSymmetrized Display"
	endif	
		
	SetDataFolder Curr
End


Proc ProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	pauseupdate;silent 1
	String Curr=GetDataFolder(1)
	Variable EDCDisplay=root:PROCESS:EDCDisplayMode
	
	IF (EDCDisplay==0)
       EVENProcessedSpectra(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==1)
       unEVENupProcessedSpectra(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==2)
       unEVENdownProcessedSpectra(ctrlName,popNum,popStr)
       EndIF       
 	IF (EDCDisplay==3)
       EVENSymmetrizedSpectra(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==4)
       unEVENupSymmetrizedSpectra(ctrlName,popNum,popStr)
       EndIF  
     	IF (EDCDisplay==5)
       unEVENdownSymmetrizedSpectra(ctrlName,popNum,popStr)
       EndIF     
	
	CleanProcessFolder()
	
	
	SetDataFolder Curr
END


	
////Not Used so far
Function EVEN_EDC_Display(Image2DName,Offset,SpecBind,EnergyStart,EnergyEnd)
String Image2DName
Variable Offset,SpecBind,EnergyStart,EnergyEnd

	Variable ImageNameLength=strlen(Image2DName)
	Variable Positionoft=strsearch(Image2DName,"t",0)
//	String   ThetaAngleForImage=Image2DName[Positionoft-2,ImageNameLength-1]

    Print "Image2DName=", Image2DName
    String   ThetaAngleForImage=Image2DName


	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
       Execute "CleanProcessFolder()"
	

       WAVE NImage=$Image2DName
        
  	    Variable nx, ny
	    Variable xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+Image2DName 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
               Variable ii=0
      	         Do
        		  ReferenceEnergy[ii]=xmin+xinc*ii
        		  ii=ii+1
       	      While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              

              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0=Image2DName+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]

                 
                 String Energy0="E"+Image2DName+"0"
                 Make/O/N=(nx) $Energy0
                 WAVE EnergyAxis0=$Energy0
                 Duplicate/O  ReferenceEnergy EnergyAxis0

                 IF (FermiCorrectionFlag==1)
                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
                 ELSE
                 EnergyAxis0=ReferenceEnergy
                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                
              DoWindow $Image2DName
	          IF(V_flag==0)
                 Display  EDCC vs EnergyAxis0 as Image2DName
        	         DoWindow/C $Image2DName
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43
	           
	          Do
                 PlotName=Image2DName+num2str(i)
                 EnergyName="E"+Image2DName+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname


                   EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                  EDCSpectra/=SpecBind
                  
                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF

                  EDCSpectra+=Offset*i
                  AppendToGraph EDCSpectra vs EnergyAxis
	          //i=i+SpecBind
	          i=i+1
	           While(i<ny) 
	           
	           
	           
	             ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
                 ModifyGraph width=0
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
                 ShowInfo        
	           
	           
	           
	            		
	        ELSE

	        DoWindow/F $Image2DName
	        	       
           
	          Do
                 PlotName=Image2DName+num2str(i)
                 EnergyName="E"+Image2DName+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname


                   EDCSpectra=0 
                	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)

                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
	           //i=i+SpecBind
	           i=i+1
	           While(i<ny) 
	            		

        	ENDIF 
                


End



//Function EVENProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

        SetDataFolder Root:PROCESSEDIMAGESpectra 
	
	String Curr=GetDataFolder(1)
	
	String NImage=popStr
       NVar Offset=root:PROCESS:SpectraOffset
       NVar SpecBind=root:PROCESS:SpectraBind
       NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
       NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd	
       
       
      SetDataFolder Root:PROCESSEDIMAGESpectra          
       
      EVEN_EDC_Display(NImage,Offset,SpecBind,EnergyStart,EnergyEnd)
       
End




Function EVENProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl

	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
   //// print "EDCShowMode=", EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"EE"+popStr
    Endif
    ////Print WindowProcImage

   
	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
//	String   ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
    String   ThetaAngleForImage=popStr
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
    Execute "CleanProcessFolder()"
	

        WAVE NImage=root:PROCESS:$popStr
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
        
        
//      Display; Appendimage NImage
       
        SetDataFolder Root:PROCESSEDIMAGESpectra 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+popStr
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
                Variable ii=0
      	         Do
        		     ReferenceEnergy[ii]=xmin+xinc*ii
        		     ii=ii+1
       	         While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              

////          Print "FermiCorrectionFlag=", FermiCorrectionFlag             
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
//               String   PlotName0=popStr+"0"
                 String   PlotName0="EE"+popStr+"0"                
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 Setscale/I x, xmin, xmax, EDCC

                 
////////               String Energy0="E"+popStr+"0"
//////                 String Energy0="E"+popStr+"0"                 
//////                 Make/O/N=(nx) $Energy0
//////                 WAVE EnergyAxis0=$Energy0
//////                 Duplicate/O  ReferenceEnergy EnergyAxis0

//////                 IF (FermiCorrectionFlag==1)
//////                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
//////                 ELSE
//////                 EnergyAxis0=ReferenceEnergy
//////                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
//                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l    
	                                     
                
                
               DoWindow $WindowProcImage
               DoWindow/K $WindowProcImage
//	           IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
//////                  AppendToGraph EDCC vs EnergyAxis0
////////                AppendToGraph EDCC vs ReferenceEnergy
//                 AppendToGraph EDCC    //2012.06.16 remove              
                      
                 
                  EndIF                  
                                
                 
                 
        	      DoWindow/C $WindowProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43
	          
	          
	          	          
	           
	          Do
                 PlotName="EE"+popStr+num2str(i)
//               EnergyName="E"+popStr+num2str(i)
//////           EnergyName="E"+popStr+num2str(i)                 
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName           //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////           WAVE EnergyAxis=$Energyname


                   EDCSpectra=0 
//                  	k=i
					k=i+round(SpecBind/2)-1
                 	j=0
                 	
                 	Do
                 	
////20071019 remove SpecBind
////               	EDCSpectra+=NNImage[p] [k+Round(SpecBind/2)]
                 	EDCSpectra+=NNImage[p] [k] 
////20071020 add specbind back because this is a wayo to add spectra on both sides 
////                	EDCSpectra+=NNImage[p] [k+Trunc(SpecBind/2)]
                 	               	
                 	k-=1    //2012.06.16 change"k-=j" to "k-=1"
                 	j+=1
                 	
                 	While (j<SpecBind)
                 	
                     EDCSpectra/=SpecBind
                     EDCSpectra+=Offset*i
                     Setscale/I x, xmin, xmax, EDCSpectra
        
//////                  IF (FermiCorrectionFlag==1)                
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
// //////               EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF
//////                  EDCSpectra+=Offset*i
                  
                  
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
                                  IF ((i/EDC_Int-Round(i/EDC_Int))==0)                                    
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
////////////                  AppendToGraph EDCSpectra vs ReferenceEnergy
                              AppendToGraph EDCSpectra                          
                              
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                                  IF ((i/EDC_Int-Round(i/EDC_Int))==0)
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
         //                         IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
/////////                     AppendToGraph EDCSpectra vs ReferenceEnergy
                              AppendToGraph EDCSpectra
                              
                                   EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
  
                  
//	           i=i+SpecBind
			    i=i+1
	           While(i<ny) 
	           
	             ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
                 ModifyGraph width=0
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
                 ShowInfo    
	           
	           	           
	            		
//	        ELSE

//	        DoWindow/F $WindowProcImage
	        	       
           
//	          Do
//                 PlotName="EE"+popStr+num2str(i)
//               EnergyName="E"+popStr+num2str(i)
//////           EnergyName="E"+popStr+num2str(i)                 
//                 EDCName=PlotName
//                 Make/O/N=(nx) $EDCName           //////, $Energyname
//                 WAVE EDCSpectra=$EDCName
//////           WAVE EnergyAxis=$Energyname


//                   EDCSpectra=0 
//                  	k=i
//                 	j=0
//                 	Do
////20071019 remove SpecBind
////               	EDCSpectra+=NNImage[p] [k+Round(SpecBind/2)]
//                 	EDCSpectra+=NNImage[p] [k] 
////20071020 add specbind back because this is a wayo to add spectra on both sides 
////                	EDCSpectra+=NNImage[p] [k+Trunc(SpecBind/2)]


                 	               	
                 	
//                 	j+=1
//                 	k-=1
//                 	While (j<SpecBind)
                 	
//                     EDCSpectra/=SpecBind
//                     EDCSpectra+=Offset*i
//                     Setscale/I x, xmin, xmax, EDCSpectra
        
                  
	          // i=i+SpecBind
//	          i=i+1
//	           While(i<ny) 
	            		

//        	ENDIF 
                
         //  Execute "CleanProcessFolder()"		   
	     //  Execute "CleanProcessFolder_Symmetrize()"



	        SetDataFolder Curr  
	       
	        End
	        
	        

Function unEVENupProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"EU"+popStr
    Endif
////Print WindowProcImage

   

	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
    Execute "CleanProcessFolder()"
	

        WAVE NImage=root:PROCESS:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:PROCESSEDIMAGESpectra 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode
        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
            Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
               Variable ii=0
     	       Do
        		  ReferenceEnergy[ii]=xmin+xinc*ii
        		  ii=ii+1
       	      While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="EU"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 
                 Setscale/I x, xmin, xmax, EDCC
               
//////                 String Energy0="E"+ProcImage+"0"
//////                 Make/O/N=(nx) $Energy0
//////                 WAVE EnergyAxis0=$Energy0
//////                 Duplicate/O  ReferenceEnergy EnergyAxis0

//////                 IF (FermiCorrectionFlag==1)
//////                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
//////                 ELSE
//////                 EnergyAxis0=ReferenceEnergy
//////                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
//                 //Variable i=SpecBind
                  Variable i=0
	          Variable j
	          Variable k
	          Variable l   
	                  
	                           
                
              DoWindow $WindowProcImage
              DoWindow/K $WindowProcImage
//	          IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
//////                  AppendToGraph EDCC vs EnergyAxis0
//////                  AppendToGraph EDCC vs ReferenceEnergy
                        AppendToGraph EDCC
                       
                  EndIf                      
                               
                 
        	      DoWindow/C $WindowProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43


              Make/O/N=(nx) PreviousEDC, EDCDifference
              PreviousEDC=EDCC
              EDCDifference=0
	          Variable EDCDifferenceMin, EDCDifferenceMax
	          Variable iMin
	          Variable EDCDifferenceOffset
	          
	     DO
                 PlotName="EU"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname
                 

                   EDCSpectra=0 
                  //	k=i
                   k=i+round(SpecBind/2)-1
                 	j=0
                 	Do
                 	
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                   EDCSpectra/=SpecBind
                                    	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
                  IF (EDCDifferenceMin<0)
                  EDCDifferenceOffset=-EDCDifferenceMin
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra+=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
//////                  IF (FermiCorrectionFlag==1)
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                       
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF
                  
                  
                  EDCSpectra+=Offset*i
                  
                  Setscale/I x, xmin, xmax, EDCSpectra
                  
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
                                 // IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)      
                                 IF ((i/EDC_Int-Round(i/EDC_Int))==0)                            
                                  
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
//////                        AppendToGraph EDCSpectra vs ReferenceEnergy
                              AppendToGraph EDCSpectra
                              
                              
                                                
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        IF ((i/EDC_Int-Round(i/EDC_Int))==0)
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
//                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                     
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
//////                        AppendToGraph EDCSpectra vs ReferenceEnergy         
                              AppendToGraph EDCSpectra              
                                  EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF        
                                  
//	             i=i+SpecBind
	             i=i+1
	           
	     WHILE(i<ny) 
	     
	              
	             ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
                 ModifyGraph width=0
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
//               ModifyGraph noLabel(left)=2
                 ShowInfo
	     
	     
	     
	     

	            		
//	        ELSE
//	        DoWindow/F $WindowProcImage

//                 Make/O/N=(nx) PreviousEDC, EDCDifference
//                 PreviousEDC=EDCC
//                 EDCDifference=0
	          
//	    DO
//                 PlotName="EU"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
//                 EDCName=PlotName
//                 Make/O/N=(nx) $EDCName      //////, $Energyname
//                 WAVE EDCSpectra=$EDCName
//////           WAVE EnergyAxis=$Energyname
                 

  //                  EDCSpectra=0 
 //                 	k=i
 //                	j=0
 //                	Do
 //                	EDCSpectra+=NNImage[p] [k]
 //                	k-=1
  //               	j+=1
 //                	While (j<SpecBind)
                 	
  //                 EDCSpectra/=SpecBind
                 	
  //                 EDCDifference=EDCSpectra-PreviousEDC
                   
                   
                 //Find the minimum of EDCDifference 
 //                 EDCDifferenceMin=EDCDifference[0]
 //                 iMin=0
  //                DO
 //                 IF (EDCDifference[iMin]<EDCDifferenceMin)
//                  EDCDifferenceMin=EDCDifference[iMin]
 //                 ELSE
  //                ENDIF
 //                 iMin+=1                 
  //                While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
 //                 IF (EDCDifferenceMin<0)
  //                EDCDifferenceOffset=-EDCDifferenceMin
  //                ELSE
  //                EDCDifferenceOffset=0
 //                 ENDIF        
//                Print i, EDCDifferenceOffset                 
 //                 EDCSpectra+=EDCDifferenceOffset               
 ////                 if(mod(i,SpecBind)==0)               
  //                PreviousEDC=EDCSpectra
 //                 endif
                	
                 	
//////                  IF (FermiCorrectionFlag==1)   
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                  
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF
  //                EDCSpectra+=Offset*i
                  
  //                Setscale/I x, xmin, xmax, EDCSpectra
                  
//                AppendToGraph EDCSpectra vs EnergyAxis
	             // i=i+SpecBind
	//             i=i+1
	           
	           
	//        WHILE(i<ny) 
	        
	        
	//        ENDIF
	        
	       Execute "CleanProcessFolder()"		   
	       Execute "CleanProcessFolder_Symmetrize()"
	         
               
	        SetDataFolder Curr  
	       
	        End


Function unEVENdownProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"ED"+popStr
    Endif
    ////Print WindowProcImage

	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag

       Execute "CleanProcessFolder()"
	

        WAVE NImage=root:PROCESS:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:PROCESSEDIMAGESpectra 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
               Variable ii=0
      	      Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
         	 While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="ED"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 Setscale/I x, xmin, xmax, EDCC
                 
                 
                 
//////                 String Energy0="E"+ProcImage+"0"
//////                 Make/O/N=(nx) $Energy0
//////                 WAVE EnergyAxis0=$Energy0
//////                 Duplicate/O  ReferenceEnergy EnergyAxis0

//////                 IF (FermiCorrectionFlag==1)
//////                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
//////                 ELSE
//////                 EnergyAxis0=ReferenceEnergy
//////                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                    
                 DoWindow $WindowProcImage
                 DoWindow/K $WindowProcImage
	          //   IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
//////                  AppendToGraph EDCC vs EnergyAxis0
//////                  AppendToGraph EDCC vs ReferenceEnergy
                  AppendToGraph EDCC
                  
                       
                  EndIf     
                 
                 
                 
        	         DoWindow/C $WindowProcImage
	             Textbox/N=text0/F=0  ThetaAngleForImage
	             ModifyGraph margin(left)=43


                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	             Variable EDCDifferenceMin, EDCDifferenceMax
	             Variable iMin
	             Variable EDCDifferenceOffset
	          
	    DO
                 PlotName="ED"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0
                  //k=i 
                 	k=i+round(SpecBind/2)-1
                 	j=0
                 	Do                 	
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                  
                   EDCSpectra/=SpecBind	
                 	
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                 Print  i, EDCDifferenceMin,EDCDifferenceMax
                  
                  IF (EDCDifferenceMax>0)
                  EDCDifferenceOffset=EDCDifferenceMax
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra-=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
//////                  IF (FermiCorrectionFlag==1) 
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF
                  EDCSpectra-=Offset*i
                  
                  Setscale/I x, xmin, xmax, EDCSpectra
                  
                  
                  IF (EDCNumberMode==0)
                        
                             IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
      //                            IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                   
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis

//////                        AppendToGraph EDCSpectra vs ReferenceEnergy
                              AppendToGraph EDCSpectra
                              
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
                                 IF ((i/EDC_Int-Round(i/EDC_Int))==0)

//                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis

//////                        AppendToGraph EDCSpectra vs ReferenceEnergy
                              
                              AppendToGraph EDCSpectra
                  
                                   EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
                  
 //                 AppendToGraph EDCSpectra vs EnergyAxis
                  
                  
                  
                  
	         //	 i=i+SpecBind
	             i=i+1           
	           
	        WHILE(i<ny) 
	        
	        ModifyGraph zero(bottom)=3
            ModifyGraph mirror=2
//          ModifyGraph noLabel(left)=2
//		     ModifyGraph width={Aspect,0.8}
            ModifyGraph width=0
		    ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
	        
	        
	        

	            		
//	        ELSE
	//        DoWindow/F $WindowProcImage
	       
      //           Make/O/N=(nx) PreviousEDC, EDCDifference
       //          PreviousEDC=EDCC
       //          EDCDifference=0
	          
//	    DO
  //               PlotName="ED"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
  //               EDCName=PlotName
  //               Make/O/N=(nx) $EDCName      //////, $Energyname
  //               WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname
                 

  //                  EDCSpectra=0 
  //            	  	k=i
  //               	j=0
  //               	Do
   //              	EDCSpectra+=NNImage[p] [k]
  //               	k-=1
  //               	j+=1
  //               	While (j<SpecBind)
  //               	
  //                 EDCSpectra/=SpecBind
                 	
                 	
  //                 EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximumof EDCDifference 
  //                EDCDifferenceMin=EDCDifference[0]
  //                EDCDifferenceMax=EDCDifference[0]
  //                iMin=0
  //                DO
  //                IF (EDCDifference[iMin]<EDCDifferenceMin)
  //                EDCDifferenceMin=EDCDifference[iMin]
  //                ENDIF
  //                IF (EDCDifference[iMin]>EDCDifferenceMax)
  //                EDCDifferenceMax=EDCDifference[iMin]
  //                ENDIF                  
  //                iMin+=1                 
  //                While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
   //               IF (EDCDifferenceMax>0)
   //               EDCDifferenceOffset=EDCDifferenceMax
  //                ELSE
  //                EDCDifferenceOffset=0
  //                ENDIF        
//                Print i, EDCDifferenceOffset                 
  //                EDCSpectra-=EDCDifferenceOffset               
  //                if(mod(i,SpecBind)==0)               
  //                PreviousEDC=EDCSpectra
  //                endif
                  
                	
                 	
//////                  IF (FermiCorrectionFlag==1) 
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF
  //                EDCSpectra-=Offset*i
                  
 //                 Setscale/I x, xmin, xmax, EDCSpectra
                  
 //                 AppendToGraph EDCSpectra vs EnergyAxis
	            //  i=i+SpecBind
	//            i=i+1
	           	           
//	     WHILE(i<ny) 

	            		

  //      	ENDIF 
                

        Execute "CleanProcessFolder()"		   
	    Execute "CleanProcessFolder_Symmetrize()"


      
	        SetDataFolder Curr  
	       
	        End
	        
	        
	        
	        


//Function EDCSymmetrize(Wavex,Wavey)

Wave Wavex, Wavey
Variable NumofWave=Dimsize(Wavex,0)
//print Wavex[NumofWave]
//Print Wavex[0]
//Print NumofWave
//Variable StepofWavex=(Wavex[NumofWave]-Wavex[0])/(NumofWave-1)
//print StepofWavex

//Find number of points less than zero
Variable NumLess0=0
Variable i=0
Do
If (Wavex[i]<0)
NumLess0+=1
Else
Endif
i+=1
While (i<NumofWave)

//Print NumLess0

Make/O/N=(2*NumLess0)  OriWavex, OriWavey
Make/O/N=(2*NumLess0)  NOriWavex, NOriWavey

Variable j=0
Do
If (j<NumofWave)
OriWavex[j]=Wavex[j]
OriWavey[j]=Wavey[j]
Else
OriWavex[j]=0




j+=1
While (j<(2*NumLess0)

End






Function EVENSymmetrizedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"SE"+popStr
    Endif
////    Print WindowProcImage


	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String    ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
        Execute "CleanProcessFolder()"
	

        WAVE NImage=root:PROCESS:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
        
        
//      Display; Appendimage NImage
       
        SetDataFolder Root:PROCESSEDIMAGESpectra 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
                   
         XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
                Variable ii=0
      	         Do
        		    ReferenceEnergy[ii]=xmin+xinc*ii
        		    ii=ii+1
       	         While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              

//            Print "FermiCorrectionFlag=", FermiCorrectionFlag             
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="SE"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 Setscale/I x xmin, xmax, EDCC
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 
                 
                 String Energy0="E"+ProcImage+"0"
                 Make/O/N=(nx) $Energy0
                 WAVE EnergyAxis0=$Energy0
                 Duplicate/O  ReferenceEnergy EnergyAxis0

                 IF (FermiCorrectionFlag==1)
                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
                 ELSE
                 EnergyAxis0=ReferenceEnergy
                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                   
                
               DoWindow $WindowProcImage
               DoWindow/K $WindowProcImage
//	           IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
 //              AppendToGraph EDCC vs EnergyAxis0

                 WaveSymmetrize(EDCC,0)
                 duplicate/O EnWave EDCC
                 AppendToGraph EDCC
 
//               AppendToGraph WaveSymmetrize(EDCC,0)
 
                       
                 EndIf                   
                
              
              

                               
        	      DoWindow/C $WindowProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43
	          
	          
	          	          
	           
	          Do
                 PlotName="SE"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname
                 Setscale/I x xmin, xmax,EDCSpectra


                    EDCSpectra=0 
                  //	k=i
                  k=i+round(SpecBind/2)-1
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                  EDCSpectra/=SpecBind
                  
        
                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
                  
                
                
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra
                  
                             
                  
                  IF (EDCNumberMode==0)
                        
                       IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                        
             //           IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                          
                  
                        AppendToGraph EDCSpectra
                  
                        EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
                                  IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
//                                   IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
                        AppendToGraph EDCSpectra                      
                        
                  
                                   EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
  
                  
	           //	 i=i+SpecBind
	             i=i+1
	           While(i<ny) 
	            		
//	        ELSE
//
//	        DoWindow/F $WindowProcImage
	        	       
           
//	          Do
//                 PlotName="SE"+ProcImage+num2str(i)
//                 EnergyName="E"+ProcImage+num2str(i)
//                 EDCName=PlotName
//                 Make/O/N=(nx) $EDCName, $Energyname
//                 WAVE EDCSpectra=$EDCName
//                 WAVE EnergyAxis=$Energyname
//                 Setscale/I x xmin, xmax, EDCSpectra


//                    EDCSpectra=0 
//             	   	k=i
//                 	j=0
//                 	Do
                 	
//                 	EDCSpectra+=NNImage[p] [k]
//                 	k-=1
//                 	j+=1
//                 	While (j<SpecBind)
                 	
//                  EDCSpectra/=SpecBind	

//                  IF (FermiCorrectionFlag==1) 
//                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi              
//                  ELSE
//                  EnergyAxis=ReferenceEnergy
//                  ENDIF
                  
                
//                  WaveSymmetrize(EDCSpectra,0)
//                  Duplicate/O EnWave EDCSpectra
  
                  
//                  EDCSpectra+=Offset*i
	             // i=i+SpecBind
//	             i=i+1
//	              While(i<ny) 
	            		

//        	ENDIF 
                
//                 ModifyGraph zero(bottom)=3
//                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
//                 ModifyGraph width=0
//                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
//                 ShowInfo
                 
           Execute "CleanProcessFolder()"		   
	       Execute "CleanProcessFolder_Symmetrize()"
		               
                 
	        SetDataFolder Curr  
	       
	        End


Function unEVENupSymmetrizedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"SU"+popStr
    Endif
    ////Print WindowProcImage


	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
       Execute "CleanProcessFolder()"
	

        WAVE NImage=root:PROCESS:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:PROCESSEDIMAGESpectra 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode
        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
             XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
              Variable ii=0
      	       Do
        		  ReferenceEnergy[ii]=xmin+xinc*ii
        		  ii=ii+1
       	      While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="SU"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 Setscale/I x xmin, xmax, EDCC
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
               
                 String Energy0="E"+ProcImage+"0"
                 Make/O/N=(nx) $Energy0
                 WAVE EnergyAxis0=$Energy0
                 Duplicate/O  ReferenceEnergy EnergyAxis0

                 IF (FermiCorrectionFlag==1)
                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
                 ELSE
                 EnergyAxis0=ReferenceEnergy
                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l   
	                                     
                
              DoWindow $WindowProcImage
              DoWindow/K $WindowProcImage
	   //       IF(V_flag==0)

                 Display  as WindowProcImage  
                  
                IF(EDC_Start==0)                                                        
                WaveSymmetrize(EDCC,0)
                duplicate/O EnWave EDCC                
                AppendToGraph EDCC      
                EndIF  
                                   
        	        DoWindow/C $WindowProcImage
	            Textbox/N=text0/F=0  ThetaAngleForImage
	            ModifyGraph margin(left)=43

              Make/O/N=(nx) PreviousEDC, EDCDifference
              PreviousEDC=EDCC
              EDCDifference=0
	          Variable EDCDifferenceMin, EDCDifferenceMax
	          Variable iMin
	          Variable EDCDifferenceOffset
	          
	     DO
                 PlotName="SU"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 Setscale/I x xmin, xmax, EDCSpectra
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                  //	k=i
                  k=i+round(SpecBind/2)-1
                 	j=0
                 	Do                 	
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                   EDCSpectra/=SpecBind
                                   
                 	
                  EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
                  IF (EDCDifferenceMin<0)
                  EDCDifferenceOffset=-EDCDifferenceMin
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra+=EDCDifferenceOffset
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
                  IF (FermiCorrectionFlag==1)
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                       
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
                  

                                    
                  
                  IF (EDCNumberMode==0)
                        
                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
//                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                                  
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
                        AppendToGraph EDCSpectra
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
                                IF ((i/EDC_Int-Round(i/EDC_Int))==0)
//                                   IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
                        AppendToGraph EDCSpectra                      
                  
                                    EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF        
                                  
	             //	 i=i+SpecBind
	             i=i+1
	             
////	             display EDCSpectra
	             
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra         	             
	             
	 	           
	           
	       WHILE(i<ny) 

	            		
//	        ELSE
//	        DoWindow/F $WindowProcImage

//              Make/O/N=(nx) PreviousEDC, EDCDifference
//              PreviousEDC=EDCC
//              EDCDifference=0

	          
//	     DO
//                 PlotName="SU"+ProcImage+num2str(i)
//                 EnergyName="E"+ProcImage+num2str(i)
//                 EDCName=PlotName
//                 Make/O/N=(nx) $EDCName, $Energyname
//                 WAVE EDCSpectra=$EDCName
//                 Setscale/I x xmin, xmax, EDCSpectra
//                 WAVE EnergyAxis=$Energyname
                 

//                    EDCSpectra=0 
//                  	k=i
//                 	j=0
//                 	Do
//                 	EDCSpectra+=NNImage[p] [k]
//                 	k-=1
//                 	j+=1
//                 	While (j<SpecBind)
                 	
//                   EDCSpectra/=SpecBind
                                   
                 	
//                  EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
//                  EDCDifferenceMin=EDCDifference[0]
//                  EDCDifferenceMax=EDCDifference[0]                  
//                  iMin=0
//                  DO
//                  IF (EDCDifference[iMin]<EDCDifferenceMin)
//                  EDCDifferenceMin=EDCDifference[iMin]
//                  ENDIF
//                  IF (EDCDifference[iMin]>EDCDifferenceMax)
//                  EDCDifferenceMax=EDCDifference[iMin]
//                  ENDIF                
//                  iMin+=1                 
//                  While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
//                  IF (EDCDifferenceMin<0)
//                  EDCDifferenceOffset=-EDCDifferenceMin
//                  ELSE
//                  EDCDifferenceOffset=0
//                  ENDIF        
//                Print i, EDCDifferenceOffset                 
//                  EDCSpectra+=EDCDifferenceOffset               
//                  if(mod(i,SpecBind)==0)               
//                  PreviousEDC=EDCSpectra
//                  endif
                	
                 	
//                  IF (FermiCorrectionFlag==1)
//                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                       
//                  ELSE
//                  EnergyAxis=ReferenceEnergy
//                  ENDIF
//                  EDCSpectra+=Offset*i
                  

                                    
                  
//                  IF (EDCNumberMode==0)
//                        
//                                  IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
//                        AppendToGraph EDCSpectra
                  
  //                                EndIF
                  
    //              Else
 //                       IF(i>=EDC_Start)
 //                             IF (i<=EDC_End)
 //                       
 //                                 IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
 //                       AppendToGraph EDCSpectra                      
                  
   //                               EndIF
                       
     //                         EndIF
     //                   EndIf 
                  
    //              EndIF        
                                  
	             //	 i=i+SpecBind
	//             i=i+1
	             
    //              WaveSymmetrize(EDCSpectra,0)
    //              Duplicate/O EnWave EDCSpectra   
	     
	           
	//     WHILE(i<ny) 

	            		

    //    	ENDIF 
                
    //             ModifyGraph zero(bottom)=3
    //             ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
    //             ModifyGraph width=0
    //             ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
//               ModifyGraph noLabel(left)=2
     //            ShowInfo
                 
           Execute "CleanProcessFolder()"		   
	       Execute "CleanProcessFolder_Symmetrize()"            
                 
      
	        SetDataFolder Curr  
	       
	        End

     


Function unEVENdownSymmetrizedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"SD"+popStr
    Endif
    ////Print WindowProcImage

	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag

       Execute "CleanProcessFolder()"
	

        WAVE NImage=root:PROCESS:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:PROCESSEDIMAGESpectra 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
               Variable ii=0
      	         Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
         	 While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="SD"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 Setscale/I x, xmin, xmax, EDCC
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 
                 
                 
                 
                 String Energy0="E"+ProcImage+"0"
                 Make/O/N=(nx) $Energy0
                 WAVE EnergyAxis0=$Energy0
                 Duplicate/O  ReferenceEnergy EnergyAxis0

                 IF (FermiCorrectionFlag==1)
                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
                 ELSE
                 EnergyAxis0=ReferenceEnergy
                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                    
                 DoWindow $WindowProcImage
                 DoWindow/K $WindowProcImage
//	             IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                  
                      
                 WaveSymmetrize(EDCC,0)
                 Duplicate/O EnWave EDCC
                 AppendToGraph EDCC                           
                       
                       
                      
                       
                  EndIf     
                 
                 
                 
        	         DoWindow/C $WindowProcImage
	             Textbox/N=text0/F=0  ThetaAngleForImage
	             ModifyGraph margin(left)=43


                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	             Variable EDCDifferenceMin, EDCDifferenceMax
	             Variable iMin
	             Variable EDCDifferenceOffset
	          
	    DO
                 PlotName="SD"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 Setscale/I x, xmin, xmax, EDCSpectra
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                 //	k=i
                 k=i+round(SpecBind/2)-1
                 	j=0
                 	Do                 	
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                  
                   EDCSpectra/=SpecBind	
                 	
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print  i, EDCDifferenceMin,EDCDifferenceMax
                  
                  IF (EDCDifferenceMax>0)
                  EDCDifferenceOffset=EDCDifferenceMax
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra-=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
                  IF (FermiCorrectionFlag==1) 
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra-=Offset*i
                  IF (EDCNumberMode==0)
                        
                             IF ((i/EDC_Int-Round(i/EDC_Int))==0)
////                                   IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                  
                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
                                 IF ((i/EDC_Int-Round(i/EDC_Int))==0)
//                                   IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
                                   EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
                  
 //                 AppendToGraph EDCSpectra vs EnergyAxis
                  
                  
                  
                  
	           //	 i=i+SpecBind
	             i=i+1
	           
	           	             
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra   
	           
	           
	           
	     WHILE(i<ny) 

	            		
//	        ELSE
//	        DoWindow/F $WindowProcImage
	       
//                 Make/O/N=(nx) PreviousEDC, EDCDifference
//                 PreviousEDC=EDCC
//                 EDCDifference=0
	          
//	    DO
//                 PlotName="SD"+ProcImage+num2str(i)
//                 EnergyName="E"+ProcImage+num2str(i)
//                 EDCName=PlotName
//                 Make/O/N=(nx) $EDCName, $Energyname
//                 WAVE EDCSpectra=$EDCName
//                 Setscale/I x, xmin, xmax, EDCSpectra
//                 WAVE EnergyAxis=$Energyname
                 

//                    EDCSpectra=0 
//                 	k=i
//                 	j=0
//                 	Do
//                 	EDCSpectra+=NNImage[p] [k]
//                 	k-=1
//                 	j+=1
//                 	While (j<SpecBind)
                  
//                   EDCSpectra/=SpecBind	
                 	
                 	
//                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
//                  EDCDifferenceMin=EDCDifference[0]
//                  EDCDifferenceMax=EDCDifference[0]                  
//                  iMin=0
//                  DO
//                  IF (EDCDifference[iMin]<EDCDifferenceMin)
//                  EDCDifferenceMin=EDCDifference[iMin]
//                  ENDIF
//                  IF (EDCDifference[iMin]>EDCDifferenceMax)
//                  EDCDifferenceMax=EDCDifference[iMin]
//                  ENDIF                
//                  iMin+=1                 
//                  While (iMin<nx) 
                  
//                Print  i, EDCDifferenceMin,EDCDifferenceMax
                  
//                  IF (EDCDifferenceMax>0)
//                  EDCDifferenceOffset=EDCDifferenceMax
//                  ELSE
//                  EDCDifferenceOffset=0
 //                 ENDIF        
//                Print i, EDCDifferenceOffset                 
//                  EDCSpectra-=EDCDifferenceOffset               
//                  if(mod(i,SpecBind)==0)               
//                  PreviousEDC=EDCSpectra
//                  endif
                	
                 	
//                  IF (FermiCorrectionFlag==1) 
//                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
//                  ELSE
//                  EnergyAxis=ReferenceEnergy
//                  ENDIF
//                  EDCSpectra-=Offset*i
//                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
//                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                  
//                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
//                                  EndIF
                  
//                  Else
//                        IF(i>=EDC_Start)
//                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
  //                                 IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
//                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
//                                   EndIF
                       
 //                             EndIF
   //                     EndIf 
                  
 //                 EndIF       
                  
                  
 //                 AppendToGraph EDCSpectra vs EnergyAxis
                  
                  
                  
                  
	           //	 i=i+SpecBind
//	             i=i+1
	           
	           	             
//                  WaveSymmetrize(EDCSpectra,0)
//                  Duplicate/O EnWave EDCSpectra   
	           
	           
	           
//	     WHILE(i<ny) 

	            		

//        	ENDIF 
                
//                 ModifyGraph zero(bottom)=3
//                 ModifyGraph mirror=2
//               ModifyGraph noLabel(left)=2
//		   ModifyGraph width={Aspect,0.8}
//           ModifyGraph width=0
//		   ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
		   
           Execute "CleanProcessFolder()"		   
	       Execute "CleanProcessFolder_Symmetrize()"
		   
		   
      
	        SetDataFolder Curr  
	       
	        End
     
     
     
     
     
     
     
/////////////////////////////////////////////////////////////////////////////     
///////EDCs from the Corrected Dispersion Image   
/////////////////////////////////////////////////////////////////////////////     
     
    Proc EDCsFromDispersionImage(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	
	String Curr=GetDataFolder(1)
	Variable EDCDisplay=root:PROCESS:EDCDisplayMode
	
	IF (EDCDisplay==0)
       DEVENProcessedSpectra(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==1)
       DunEVENupProcessedSpectra(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==2)
       DunEVENdownProcessedSpectra(ctrlName,popNum,popStr)
       EndIF       
 	IF (EDCDisplay==3)
       DEVENSymmetrizedSpectra(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==4)
       DunEVENupSymmetrizedSpectra(ctrlName,popNum,popStr)
       EndIF  
    IF (EDCDisplay==5)
       DunEVENdownSymmetrizedSpectra(ctrlName,popNum,popStr)
    EndIF     
	
	
	CleanProcessFolder()
	
	SetDataFolder Curr
END




Function DEVENProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"EE"+popStr
    Endif
    ////Print WindowProcImage
    
    
	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
//	String    ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
    String    ThetaAngleForImage=popStr
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
    Execute "CleanProcessFolder()"
	

        WAVE NImage=root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
        
        
//      Display; Appendimage NImage
       
        SetDataFolder Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
        
        
        
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
                Variable ii=0
      	         Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	         While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              

////          Print "FermiCorrectionFlag=", FermiCorrectionFlag             
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="EE"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 
                 
//////                 String Energy0="E"+ProcImage+"0"
//////                 Make/O/N=(nx) $Energy0
//////                 WAVE EnergyAxis0=$Energy0
//////                 Duplicate/O  ReferenceEnergy EnergyAxis0

//////                 IF (FermiCorrectionFlag==1)
//////                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
//////                 ELSE
//////                 EnergyAxis0=ReferenceEnergy
//////                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                
                
               DoWindow $WindowProcImage
	           IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
//////                  AppendToGraph EDCC vs EnergyAxis0
                        AppendToGraph EDCC vs ReferenceEnergy
                       
                  EndIf                   
                
                
                 
                 
        	      DoWindow/C $WindowProcImage
	          Textbox/N=text0/A=LT/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43
	          
	          
	          	          
	           
	          Do
                 PlotName="EE"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname


                   EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k+Round(SpecBind/2)]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                  EDCSpectra/=SpecBind
                  
        
//////                  IF (FermiCorrectionFlag==1)                
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
///////                 ENDIF

                  EDCSpectra+=Offset*i
                  
                  
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
                              AppendToGraph EDCSpectra vs ReferenceEnergy
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
 //                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
                              AppendToGraph EDCSpectra vs ReferenceEnergy
                  
  //                                 EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
  
                  
	           //	 i=i+SpecBind
	             i=i+1
	           While(i<ny) 
	           
	             ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
                 ModifyGraph width=0
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
                 ShowInfo    
	           
	           	           
	            		
	        ELSE

	        DoWindow/F $WindowProcImage
	        	       
           
	          Do
                 PlotName="EE"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname


//                  EDCSpectra=0 
//             	   	k=i
//                 	j=0
//                 	Do
//               
//                 	EDCSpectra+=NNImage[p] [k]
//						k-=1
//                 	j+=1
//                 	While (j<SpecBind)
                 	
//                  EDCSpectra/=SpecBind	
                  
                   EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k+Round(SpecBind/2)]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                  EDCSpectra/=SpecBind         
                  

//////                  IF (FermiCorrectionFlag==1) 
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi              
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF

                  EDCSpectra+=Offset*i
	             // i=i+SpecBind
	             i=i+1
	              While(i<ny) 
	            		

        	ENDIF 
                

	        SetDataFolder Curr  
	       
	        End
	        
	        

Function DunEVENdownProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"ED"+popStr
    Endif
    ////Print WindowProcImage
    
    
    
	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
       Execute "CleanProcessFolder()"
	

        WAVE NImage=root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode
        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
               Variable ii=0
      	       Do
        		  ReferenceEnergy[ii]=xmin+xinc*ii
        		  ii=ii+1
       	      While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="ED"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
               
//////                 String Energy0="E"+ProcImage+"0"
//////                 Make/O/N=(nx) $Energy0
//////                 WAVE EnergyAxis0=$Energy0
//////                 Duplicate/O  ReferenceEnergy EnergyAxis0

//////                 IF (FermiCorrectionFlag==1)
//////                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
//////                 ELSE
//////                 EnergyAxis0=ReferenceEnergy
//////                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	          Variable j
	          Variable k
	          Variable l   
	                                  
                
              DoWindow $WindowProcImage
	          IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
                  AppendToGraph EDCC vs ReferenceEnergy
                       
                  EndIf                      
                               
                 
        	      DoWindow/C $WindowProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43


              Make/O/N=(nx) PreviousEDC, EDCDifference
              PreviousEDC=EDCC
              EDCDifference=0
	          Variable EDCDifferenceMin, EDCDifferenceMax
	          Variable iMin
	          Variable EDCDifferenceOffset
	          
	     DO
                 PlotName="ED"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname
                 

                   EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                   EDCSpectra/=SpecBind
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
                  IF (EDCDifferenceMin<0)
                  EDCDifferenceOffset=-EDCDifferenceMin
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra+=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
//////                  IF (FermiCorrectionFlag==1)
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                       
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF
                  
                  
                  EDCSpectra+=Offset*i
                  
                  
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                  
                                  
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
                              AppendToGraph EDCSpectra vs ReferenceEnergy
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
  //                                 IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                     
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
                              AppendToGraph EDCSpectra vs ReferenceEnergy
                  
   //                                EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF        
                                  
	             //	 i=i+SpecBind
	             i=i+1
	           
	           
	     WHILE(i<ny) 
	     
	              
	             ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
                 ModifyGraph width=0
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
//               ModifyGraph noLabel(left)=2
                 ShowInfo
	     
	     
	     
	     

	            		
	        ELSE
	        DoWindow/F $WindowProcImage

              Make/O/N=(nx) PreviousEDC, EDCDifference
              PreviousEDC=EDCC
              EDCDifference=0

	          
	     DO
                 PlotName="ED"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname
                 

                   EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                   EDCSpectra/=SpecBind
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
                  IF (EDCDifferenceMin<0)
                  EDCDifferenceOffset=-EDCDifferenceMin
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra+=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
//////                  IF (FermiCorrectionFlag==1)
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                       
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF
                  
                  
                  EDCSpectra+=Offset*i
                  
                                 
	            // i=i+SpecBind
	            i=i+1
	           
	           
	     WHILE(i<ny) 
	            		

        	ENDIF 
                
      
	        SetDataFolder Curr  
	       
	        End


Function DunEVENupProcessedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"EU"+popStr
    Endif
    ////Print WindowProcImage
    
	
	String Curr=GetDataFolder(1)
	
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag

       Execute "CleanProcessFolder()"
	

        WAVE NImage=root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
               Variable ii=0
      	         Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
         	 While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="EU"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 
                 
                 
                 
//////                 String Energy0="E"+ProcImage+"0"
//////                 Make/O/N=(nx) $Energy0
//////                 WAVE EnergyAxis0=$Energy0
//////                 Duplicate/O  ReferenceEnergy EnergyAxis0

//////                 IF (FermiCorrectionFlag==1)
//////                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
//////                 ELSE
//////                 EnergyAxis0=ReferenceEnergy
//////                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                
                 DoWindow $WindowProcImage
	             IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
//////                  AppendToGraph EDCC vs EnergyAxis0
                  AppendToGraph EDCC vs  ReferenceEnergy
                       
                  EndIf     
                 
                 
                 
        	         DoWindow/C $WindowProcImage
	             Textbox/N=text0/F=0  ThetaAngleForImage
	             ModifyGraph margin(left)=43


                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	             Variable EDCDifferenceMin, EDCDifferenceMax
	             Variable iMin
	             Variable EDCDifferenceOffset
	          
	    DO
                 PlotName="EU"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                 	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                  
                   EDCSpectra/=SpecBind	
                 	
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                 Print  i, EDCDifferenceMin,EDCDifferenceMax
                  
                  IF (EDCDifferenceMax>0)
                  EDCDifferenceOffset=EDCDifferenceMax
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra-=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
//////                  IF (FermiCorrectionFlag==1) 
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF

                  EDCSpectra-=Offset*i
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                   
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
                              AppendToGraph EDCSpectra vs ReferenceEnergy
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)

 //                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                  
//////                        AppendToGraph EDCSpectra vs EnergyAxis
                              AppendToGraph EDCSpectra vs ReferenceEnergy
                  
 //                                  EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
                  
 //                 AppendToGraph EDCSpectra vs EnergyAxis
                  
                  
                  
                  
	           //	 i=i+SpecBind
	             i=i+1
	           
	           
	        WHILE(i<ny) 
	        
	        ModifyGraph zero(bottom)=3
            ModifyGraph mirror=2
//          ModifyGraph noLabel(left)=2
//		     ModifyGraph width={Aspect,0.8}
            ModifyGraph width=0
		    ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
	        
	        
	        

	            		
	        ELSE
	        DoWindow/F $WindowProcImage
	       
                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0

	          
	    DO
                 PlotName="EU"+ProcImage+num2str(i)
//////                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName      //////, $Energyname
                 WAVE EDCSpectra=$EDCName
//////                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                 	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                  
                   EDCSpectra/=SpecBind	
                 	
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                 Print  i, EDCDifferenceMin,EDCDifferenceMax
                  
                  IF (EDCDifferenceMax>0)
                  EDCDifferenceOffset=EDCDifferenceMax
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra-=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
//////                  IF (FermiCorrectionFlag==1) 
//////                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
////////                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
//////                  ELSE
//////                  EnergyAxis=ReferenceEnergy
//////                  ENDIF

                  EDCSpectra-=Offset*i
                 
                  
                  
	             // i=i+SpecBind
	             i=i+1
	             
	           
	           
	        WHILE(i<ny) 

	            		

        	ENDIF 
                

      
	        SetDataFolder Curr  
	       
	        End


//Function EDCSymmetrize(Wavex,Wavey)

Wave Wavex, Wavey
Variable NumofWave=Dimsize(Wavex,0)
//print Wavex[NumofWave]
//Print Wavex[0]
//Print NumofWave
//Variable StepofWavex=(Wavex[NumofWave]-Wavex[0])/(NumofWave-1)
//print StepofWavex

//Find number of points less than zero
Variable NumLess0=0
Variable i=0
Do
If (Wavex[i]<0)
NumLess0+=1
Else
Endif
i+=1
While (i<NumofWave)

//Print NumLess0

Make/O/N=(2*NumLess0)  OriWavex, OriWavey
Make/O/N=(2*NumLess0)  NOriWavex, NOriWavey

Variable j=0
Do
If (j<NumofWave)
OriWavex[j]=Wavex[j]
OriWavey[j]=Wavey[j]
Else
OriWavex[j]=0




j+=1
While (j<(2*NumLess0)

End






Function DEVENSymmetrizedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"SE"+popStr
    Endif
    ////Print WindowProcImage
	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String    ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
        Execute "CleanProcessFolder()"
	

        WAVE NImage=root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
        
        
//      Display; Appendimage NImage
       
        SetDataFolder Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
                   
                   XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
                Variable ii=0
      	         Do
        		    ReferenceEnergy[ii]=xmin+xinc*ii
        		    ii=ii+1
       	         While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              

//            Print "FermiCorrectionFlag=", FermiCorrectionFlag             
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="SE"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 Setscale/I x xmin, xmax, EDCC
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 
                 
                 String Energy0="E"+ProcImage+"0"
                 Make/O/N=(nx) $Energy0
                 WAVE EnergyAxis0=$Energy0
                 Duplicate/O  ReferenceEnergy EnergyAxis0

                 IF (FermiCorrectionFlag==1)
                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
                 ELSE
                 EnergyAxis0=ReferenceEnergy
                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                
                
               DoWindow $WindowProcImage
	           IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
 //              AppendToGraph EDCC vs EnergyAxis0

                 WaveSymmetrize(EDCC,0)
                 duplicate/O EnWave EDCC
                 AppendToGraph EDCC
 
//               AppendToGraph WaveSymmetrize(EDCC,0)
 
                       
                 EndIf                   
                
              
              

                               
        	   DoWindow/C $WindowProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43
	          
	          
	          	          
	           
	          Do
                 PlotName="SE"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname
                 Setscale/I x xmin, xmax,EDCSpectra


                    EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                  EDCSpectra/=SpecBind
                  
        
                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
                  
                
                
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra
                  
                             
                  
                  IF (EDCNumberMode==0)
                        
////                    IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                        
                        IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                          
                  
                        AppendToGraph EDCSpectra
                  
                        EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  
 //                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
                        AppendToGraph EDCSpectra                      
                        
                  
  //                                 EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
  
                  
	           //	 i=i+SpecBind
	             i=i+1
	           While(i<ny) 
	            		
	        ELSE

	        DoWindow/F $ProcImage
	        	       
           
	          Do
                 PlotName="SE"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname
                 Setscale/I x xmin, xmax, EDCSpectra


                    EDCSpectra=0 
             	   	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                  EDCSpectra/=SpecBind	

                  IF (FermiCorrectionFlag==1) 
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi              
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  
                
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra
  
                  
                  EDCSpectra+=Offset*i
	              //i=i+SpecBind
	              i=i+1
	              While(i<ny) 
	            		

        	ENDIF 
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
                 ModifyGraph width=0
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
                 ShowInfo
                 
                 
            Execute "CleanProcessFolder()"    
                 
                 
	        SetDataFolder Curr  
	       
	        End


Function DunEVENupSymmetrizedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"SU"+popStr
    Endif
    ////Print WindowProcImage
	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
       Execute "CleanProcessFolder()"
	

        WAVE NImage=root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG 
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode
        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
             XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
              Variable ii=0
      	       Do
        		  ReferenceEnergy[ii]=xmin+xinc*ii
        		  ii=ii+1
       	      While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="SU"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 Setscale/I x xmin, xmax, EDCC
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
               
                 String Energy0="E"+ProcImage+"0"
                 Make/O/N=(nx) $Energy0
                 WAVE EnergyAxis0=$Energy0
                 Duplicate/O  ReferenceEnergy EnergyAxis0

                 IF (FermiCorrectionFlag==1)
                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
                 ELSE
                 EnergyAxis0=ReferenceEnergy
                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l   
	                                  
                
              DoWindow $WindowProcImage
	          IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                          
//                AppendToGraph EDCC vs EnergyAxis0
                  
                WaveSymmetrize(EDCC,0)
                duplicate/O EnWave EDCC
                AppendToGraph EDCC      
              
                 EndIF                     
                               
                 
        	   DoWindow/C $WindowProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43


              Make/O/N=(nx) PreviousEDC, EDCDifference
              PreviousEDC=EDCC
              EDCDifference=0
	          Variable EDCDifferenceMin, EDCDifferenceMax
	          Variable iMin
	          Variable EDCDifferenceOffset
	          
	     DO
                 PlotName="SU"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 Setscale/I x xmin, xmax, EDCSpectra
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                   EDCSpectra/=SpecBind
                                   
                 	
                  EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
                  IF (EDCDifferenceMin<0)
                  EDCDifferenceOffset=-EDCDifferenceMin
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra+=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
                  IF (FermiCorrectionFlag==1)
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                       
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
                  

                                    
                  
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                                  
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
                        AppendToGraph EDCSpectra
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
 //                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
                        AppendToGraph EDCSpectra                      
                  
 //                                  EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF        
                                  
	             //	 i=i+SpecBind
	             i=i+1
	             
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra         	             
	             
	 	           
	           
	       WHILE(i<ny) 

	            		
	        ELSE
	        DoWindow/F $WindowProcImage

              Make/O/N=(nx) PreviousEDC, EDCDifference
              PreviousEDC=EDCC
              EDCDifference=0

	          
	     DO
                 PlotName="SU"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 Setscale/I x xmin, xmax, EDCSpectra
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                  	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                 	
                   EDCSpectra/=SpecBind
                                   
                 	
                  EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print i, EDCDifferenceMin
                  
                  IF (EDCDifferenceMin<0)
                  EDCDifferenceOffset=-EDCDifferenceMin
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra+=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
                  IF (FermiCorrectionFlag==1)
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                       
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
                  

                                    
                  
                  IF (EDCNumberMode==0)
                        
                                  IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
                        AppendToGraph EDCSpectra
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
                                  IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                  
//                      AppendToGraph EDCSpectra vs EnergyAxis
                        AppendToGraph EDCSpectra                      
                  
                                  EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF        
                                  
	             //	 i=i+SpecBind
	             i=i+1
	             
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra   
	     
	           
	     WHILE(i<ny) 

	            		

        	ENDIF 
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph width={Aspect,0.8}
                 ModifyGraph width=0
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
//               ModifyGraph noLabel(left)=2
                 ShowInfo
      
            Execute "CleanProcessFolder()"
      
      
	        SetDataFolder Curr  
	       
	        End


     


Function DunEVENdownSymmetrizedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String WindowProcImage=popStr
	
    SVar EDCPrefixName=	root:PROCESS:EDCNamePrefix

    NVar EDCShowMode=root:PROCESS:ShowEDCNumberMode
    ////print EDCShowMode
    
    If (EDCShowMode==1)
    WindowProcImage=EDCPrefixName+"_"+"SD"+popStr
    Endif
    ////Print WindowProcImage
	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag

       Execute "CleanProcessFolder()"
	

        WAVE NImage=root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG
        	
	    Variable/G nx, ny
	    Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
        
        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
        
        NVAR EDC_Start=root:PROCESS:ShowEDCNoStart
        NVAR EDC_End=root:PROCESS:ShowEDCNoEnd 
        NVar EDC_Int=root:PROCESS:ShowEDCEveryNumber
        NVar EDCNumberMode=root:PROCESS:ShowEDCNumberMode        
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, NNImage
        NVar AverageFermi=root:PROCESS:zerofermi
         
        XJZImginfo(NNImage)
              
            String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
               Variable ii=0
      	         Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
         	 While(ii<nx)  

              NVar NumberofYPoint=root:FermiLevelFromAu:NYImage
              NVar NumberofXPoint=root:FermiLevelFromAu:NXImage
              NumberofYPoint=ny
              NumberofXPoint=nx
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0="SD"+ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 Setscale/I x, xmin, xmax, EDCC
//               EDCC=NNImage[p] [0]*SpecBind
                 EDCC=NNImage[p] [0]
                 
                 
                 
                 
                 String Energy0="E"+ProcImage+"0"
                 Make/O/N=(nx) $Energy0
                 WAVE EnergyAxis0=$Energy0
                 Duplicate/O  ReferenceEnergy EnergyAxis0

                 IF (FermiCorrectionFlag==1)
                 EnergyAxis0=ReferenceEnergy-InterFermiLevel[0]+AverageFermi
                 ELSE
                 EnergyAxis0=ReferenceEnergy
                 ENDIF                 
                 
                 String PlotName, Energyname
                 String EDC
                 String EDCName
                 //Variable i=SpecBind
                  Variable i=0
	             Variable j
	             Variable k
	             Variable l                               
                
                 DoWindow $WindowProcImage
	             IF(V_flag==0)
//               Display  EDCC vs EnergyAxis0 as ProcImage
                 Display  as WindowProcImage  
                  
                  IF(EDC_Start==0)
                                  
                      
                 WaveSymmetrize(EDCC,0)
                 Duplicate/O EnWave EDCC
                 AppendToGraph EDCC                           
                       
                       
                       
                       
                  EndIf     
                 
                 
                 
        	         DoWindow/C $WindowProcImage
	             Textbox/N=text0/F=0  ThetaAngleForImage
	             ModifyGraph margin(left)=43


                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	             Variable EDCDifferenceMin, EDCDifferenceMax
	             Variable iMin
	             Variable EDCDifferenceOffset
	          
	    DO
                 PlotName="SD"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 Setscale/I x, xmin, xmax, EDCSpectra
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                 	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                  
                   EDCSpectra/=SpecBind	
                 	
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print  i, EDCDifferenceMin,EDCDifferenceMax
                  
                  IF (EDCDifferenceMax>0)
                  EDCDifferenceOffset=EDCDifferenceMax
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra-=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
                  IF (FermiCorrectionFlag==1) 
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra-=Offset*i
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                  
                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
 //                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
 //                                  EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
                  
 //                 AppendToGraph EDCSpectra vs EnergyAxis
                  
                  
                  
                  
	           //	 i=i+SpecBind
	             i=i+1
	           
	           	             
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra   
	           
	           
	           
	     WHILE(i<ny) 

	            		
	        ELSE
	        DoWindow/F $WindowProcImage
	       
                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	          
	    DO
                 PlotName="SD"+ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 Setscale/I x, xmin, xmax, EDCSpectra
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                 	k=i
                 	j=0
                 	Do
                 	EDCSpectra+=NNImage[p] [k]
                 	k-=1
                 	j+=1
                 	While (j<SpecBind)
                  
                   EDCSpectra/=SpecBind	
                 	
                 	
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  EDCDifferenceMax=EDCDifference[0]                  
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ENDIF
                  IF (EDCDifference[iMin]>EDCDifferenceMax)
                  EDCDifferenceMax=EDCDifference[iMin]
                  ENDIF                
                  iMin+=1                 
                  While (iMin<nx) 
                  
//                Print  i, EDCDifferenceMin,EDCDifferenceMax
                  
                  IF (EDCDifferenceMax>0)
                  EDCDifferenceOffset=EDCDifferenceMax
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra-=EDCDifferenceOffset               
                  if(mod(i,SpecBind)==0)               
                  PreviousEDC=EDCSpectra
                  endif
                	
                 	
                  IF (FermiCorrectionFlag==1) 
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i*SpecBind]+AverageFermi
//                EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi                                 
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra-=Offset*i
                  IF (EDCNumberMode==0)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
                                  IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                                  
                  
                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
                                  EndIF
                  
                  Else
                        IF(i>=EDC_Start)
                              IF (i<=EDC_End)
                        
////                              IF ((i/EDC_Int-Round(i/EDC_Int))==0)
  //                                 IF ((i/EDC_Int/SpecBind-Round(i/EDC_Int/SpecBind))==0)                                    
                  
                        AppendToGraph EDCSpectra
//                      AppendToGraph EDCSpectra vs EnergyAxis
                  
  //                                 EndIF
                       
                              EndIF
                        EndIf 
                  
                  EndIF       
                  
                  
 //                 AppendToGraph EDCSpectra vs EnergyAxis
                  
                  
                  
                  
	           //	 i=i+SpecBind
	             i=i+1
	           
	           	             
                  WaveSymmetrize(EDCSpectra,0)
                  Duplicate/O EnWave EDCSpectra   
	           
	           
	           
	     WHILE(i<ny) 

	            		

        	ENDIF 
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph noLabel(left)=2
//		   ModifyGraph width={Aspect,0.8}
          ModifyGraph width=0
		   ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
		   
		   
		   
		         Execute "CleanProcessFolder()"
		   
	      
	     SetDataFolder Curr 
	        
	        
	       END 
	       
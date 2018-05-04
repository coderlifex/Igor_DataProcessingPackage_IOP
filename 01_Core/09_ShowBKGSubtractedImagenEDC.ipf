#pragma rtGlobals=1		// Use modern global access method.

Proc  KillBGSubtractedEDC()

String Curr

       //Kill EDC Curves in Root:BackGroungSubtractedSpectra
	SetDataFolder root:BackGroundSubtractedSpectra
	String ToBeKilledEDCList=WaveList("*F*P*T*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	     Variable iEDC=0
	     Do
	     EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	     KillWaves/Z  $EDCCurve
	     iEDC+=1
	     While(iEDC<NoofKilledEDCList)
	    
SetDataFolder Curr
	     
End




Proc BackGroundSubtractedEDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	
	String Curr=GetDataFolder(1)
	
	KillBGSubtractedEDC()
	
	EDCDisplayModeSelection(ctrlName,popNum,popStr)
	
	Variable EDCDisplay=root:PROCESS:EDCDisplayMode
	
	IF (EDCDisplay==0)
       EVENBGSubtractedEDC(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==1)
       unEVENupBGSubtractedEDC(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==2)
       unEVENdownBGSubtractedEDC(ctrlName,popNum,popStr)
       EndIF       
 	IF (EDCDisplay==3)
       EVENSymmetrizedBGSubtractedEDC(ctrlName,popNum,popStr)
       EndIF
	IF (EDCDisplay==4)
       unEVENupSymmetrizedBGSubtractedEDC(ctrlName,popNum,popStr)
       EndIF  
     	IF (EDCDisplay==5)
       unEVENdownSymmetrizedBGSubtractedEDC(ctrlName,popNum,popStr)
       EndIF     
	
	SetDataFolder Curr
END

Function EVENBGSubtractedEDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String BGProcImage="BG_"+popStr
	
	String Curr=GetDataFolder(1)
	
       WAVE NImage=root:PROCESS:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:BackGroundSubtractedSpectra 
        	
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)

        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, BGImage
         
        XJZImginfo(BGImage)

                String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave BGReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		BGReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 
                String   PlotName0="BG_"+ProcImage+"0"
                String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=BGImage[p] [0]
                 
                NVar BGN=root:PROCESS:BGSubCurveNo
                String   BGReference="Ref_"+ProcImage
                String   BGSubRef=BGReference
                Make/O/N=(nx) $BGSubRef
                WAVE BG_Reference=$BGSubRef
                BG_Reference=BGImage[p] [BGN]


                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=SpecBind               
                
                 DoWindow $BGProcImage
	         if(V_flag==0)
	         EDCC-=BG_Reference
                 Display  EDCC vs BGReferenceEnergy as BGProcImage
        		DoWindow/C $BGProcImage
   	        Textbox/N=text0/F=0/A=MC BGProcImage
	        Textbox/C/N=text0/A=MT/X=5.00/Y=43.13 
	         
	         Do
                 PlotName="BG_"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=BGImage[p] [i]+Offset*i
                 EDCSpectra-=BG_Reference
                AppendToGraph EDCSpectra vs BGReferenceEnergy 
	        i=i+SpecBind
	        While(i<ny) 
	        
	            		
	        	else
	        		DoWindow/F $BGProcImage

                 EDCC-=BG_Reference	       
	         Do
                 PlotName="BG_"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=BGImage[p] [i]+Offset*i
                 EDCSpectra-=BG_Reference
	        i=i+SpecBind
	        While(i<ny) 		
	        	endif  
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
                 ModifyGraph noLabel(left)=2
      
	        SetDataFolder Curr  
	       
	        End	



Function  unEVENupBGSubtractedEDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage="BG_"+popStr
	String BGProcImageName="IMGBG_"+popStr	
	
	String Curr=GetDataFolder(1)
	
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
	
	Execute "BackGroundSubtractedImage(ctrlName,popNum,popStr) "

        WAVE NImage=root:BackGroundSubtractedImage:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:BackGroundSubtractedSpectra
        	
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
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
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0=ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=NNImage[p] [0]*SpecBind
                 
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
                 Variable i=SpecBind
	          Variable j
	          Variable k
	          Variable l                               
                
                 DoWindow $ProcImage
	          IF(V_flag==0)
                 Display  EDCC vs EnergyAxis0 as ProcImage
        	    DoWindow/C $ProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43


                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	          Variable EDCDifferenceMin, EDCDifferenceMax
	          Variable iMin
	          Variable EDCDifferenceOffset
	          
	    DO
                 PlotName=ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                	k=i
                 	j=0
                 	Do
                 	k-=j
                 	EDCSpectra+=NNImage[p] [k]
                 	j+=1
                 	While (j<SpecBind)
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
                  PreviousEDC=EDCSpectra
                	
                 	
                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
                  AppendToGraph EDCSpectra vs EnergyAxis
	           i=i+SpecBind
	           
	           
	     WHILE(i<ny) 

	            		
	        ELSE
	        DoWindow/F $ProcImage

                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	          
	    DO
                 PlotName=ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                	k=i
                 	j=0
                 	Do
                 	k-=j
                 	EDCSpectra+=NNImage[p] [k]
                 	j+=1
                 	While (j<SpecBind)
                  EDCDifference=EDCSpectra-PreviousEDC

                 //Find the minimum of EDCDifference 
                  EDCDifferenceMin=EDCDifference[0]
                  iMin=0
                  DO
                  IF (EDCDifference[iMin]<EDCDifferenceMin)
                  EDCDifferenceMin=EDCDifference[iMin]
                  ELSE
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
                  PreviousEDC=EDCSpectra
                	
                 	
                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra+=Offset*i
//                  AppendToGraph EDCSpectra vs EnergyAxis
	           i=i+SpecBind
	           
	           
	     WHILE(i<ny) 

	            		

        	ENDIF 
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
                 ModifyGraph width={Aspect,0.5}
                 ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
//               ModifyGraph noLabel(left)=2


	       DoWindow/K $BGProcImageName

      
	        SetDataFolder Curr  
	       
	        End


Function unEVENdownBGSubtractedEDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage="BG_" + popStr
	String BGProcImageName="IMGBG_"+popStr	
	
	String Curr=GetDataFolder(1)
	
	Variable ImageNameLength=strlen(popStr)
	Variable Positionoft=strsearch(popStr,"t",0)
	String ThetaAngleForImage=popStr[Positionoft-2,ImageNameLength-1]
	
	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag

	
	 Execute "BackGroundSubtractedImage(ctrlName,popNum,popStr) "

        WAVE NImage=root:BackGroundSubtractedImage:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage
       
        SetDataFolder Root:BackGroundSubtractedSpectra
        	
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
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
              
              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF
        
                 String   PlotName0=ProcImage+"0"
                 String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=NNImage[p] [0]*SpecBind
                 
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
                 Variable i=SpecBind
	          Variable j
	          Variable k
	          Variable l                               
                
                 DoWindow $ProcImage
	          IF(V_flag==0)
                 Display  EDCC vs EnergyAxis0 as ProcImage
        	    DoWindow/C $ProcImage
	          Textbox/N=text0/F=0  ThetaAngleForImage
	          ModifyGraph margin(left)=43


                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	          Variable EDCDifferenceMin, EDCDifferenceMax
	          Variable iMin
	          Variable EDCDifferenceOffset
	          
	    DO
                 PlotName=ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                	k=i
                 	j=0
                 	Do
                 	k-=j
                 	EDCSpectra+=NNImage[p] [k]
                 	j+=1
                 	While (j<SpecBind)
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
                  PreviousEDC=EDCSpectra
                	
                 	
                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra-=Offset*i
                  AppendToGraph EDCSpectra vs EnergyAxis
	           i=i+SpecBind
	           
	           
	     WHILE(i<ny) 

	            		
	        ELSE
	        DoWindow/F $ProcImage
	       
                 Make/O/N=(nx) PreviousEDC, EDCDifference
                 PreviousEDC=EDCC
                 EDCDifference=0
	          
	    DO
                 PlotName=ProcImage+num2str(i)
                 EnergyName="E"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName, $Energyname
                 WAVE EDCSpectra=$EDCName
                 WAVE EnergyAxis=$Energyname
                 

                    EDCSpectra=0 
                	k=i
                 	j=0
                 	Do
                 	k-=j
                 	EDCSpectra+=NNImage[p] [k]
                 	j+=1
                 	While (j<SpecBind)
                   EDCDifference=EDCSpectra-PreviousEDC

                 //Find the Minimum and Maximumof EDCDifference 
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
                  
                  IF (EDCDifferenceMax>0)
                  EDCDifferenceOffset=EDCDifferenceMax
                  ELSE
                  EDCDifferenceOffset=0
                  ENDIF        
//                Print i, EDCDifferenceOffset                 
                  EDCSpectra-=EDCDifferenceOffset               
                  PreviousEDC=EDCSpectra
                	
                 	
                  IF (FermiCorrectionFlag==1)                
                  EnergyAxis=ReferenceEnergy-InterFermiLevel[i]+AverageFermi
                  ELSE
                  EnergyAxis=ReferenceEnergy
                  ENDIF
                  EDCSpectra-=Offset*i
 //                 AppendToGraph EDCSpectra vs EnergyAxis
	           i=i+SpecBind
	           
	           
	     WHILE(i<ny) 

	            		

        	ENDIF 
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph noLabel(left)=2
		   ModifyGraph width={Aspect,0.5}
		   ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
		   
		   
	       DoWindow/K $BGProcImageName		   
		   
      
	        SetDataFolder Curr  
	       
	        End





























Function BackGroundSubtractedSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String BGProcImage="BG_"+popStr
	
	String Curr=GetDataFolder(1)
	
//Kill EDC Curves in Root:BackGroungSubtractedSpectra
	SetDataFolder root:BackGroundSubtractedSpectra
	String ToBeKilledEDCList=WaveList("*F*P*T*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	     Variable iEDC=0
	     Do
	     EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	     KillWaves/Z  $EDCCurve
	     iEDC+=1
	     While(iEDC<NoofKilledEDCList)
	

        WAVE NImage=root:PROCESS:$ProcImage
        NVar Offset=root:PROCESS:SpectraOffset
        NVar SpecBind=root:PROCESS:SpectraBind
        
//      Display; Appendimage NImage

       
        SetDataFolder Root:BackGroundSubtractedSpectra 
        	
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)

        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
 
        Duplicate/O/R=(EnergyStart,EnergyEnd)(ymin,ymax) NImage, BGImage
         
        XJZImginfo(BGImage)

                String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave BGReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		BGReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 
                String   PlotName0="BG_"+ProcImage+"0"
                String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=BGImage[p] [0]
                 
                NVar BGN=root:PROCESS:BGSubCurveNo
                String   BGReference="Ref_"+ProcImage
                String   BGSubRef=BGReference
                Make/O/N=(nx) $BGSubRef
                WAVE BG_Reference=$BGSubRef
                BG_Reference=BGImage[p] [BGN]


                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=SpecBind               
                
                 DoWindow $BGProcImage
	         if(V_flag==0)
	         EDCC-=BG_Reference
                 Display  EDCC vs BGReferenceEnergy as BGProcImage
        		DoWindow/C $BGProcImage
   	        Textbox/N=text0/F=0/A=MC BGProcImage
	        Textbox/C/N=text0/A=MT/X=5.00/Y=43.13 
	         
	         Do
                 PlotName="BG_"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=BGImage[p] [i]+Offset*i
                 EDCSpectra-=BG_Reference
                AppendToGraph EDCSpectra vs BGReferenceEnergy 
	        i=i+SpecBind
	        While(i<ny) 
	        
	            		
	        	else
	        		DoWindow/F $BGProcImage

                 EDCC-=BG_Reference	       
	         Do
                 PlotName="BG_"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=BGImage[p] [i]+Offset*i
                 EDCSpectra-=BG_Reference
	        i=i+SpecBind
	        While(i<ny) 		
	        	endif  
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
                 ModifyGraph noLabel(left)=2
      
	        SetDataFolder Curr  
	       
	        End	        
	        
Function BackGroundSubtractedImage(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String BGProcImageName="IMGBG_"+popStr
	String BGProcImage="BG_"+popStr
	String RotateBGImage="RBG_"+popStr
	String Curr=GetDataFolder(1)
	
	Duplicate/O  root:PROCESS:$ProcImage root:BackGroundSubtractedImage:$BGProcImage
	Duplicate/O  root:PROCESS:$ProcImage root:BackGroundSubtractedImage:$RotateBGImage	

	 SetDataFolder root:BackGroundSubtractedImage	
        WAVE BGImage= $BGProcImage
        WAVE RBGImage=$RotateBGImage
        Duplicate/O BGImage, TempBGImage

//	Display; Appendimage	TempBGImage
	
   	
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax
        XJZImginfo(TempBGImage)

               String ReferenceEnergyWave="BG_Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave BGReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		BGReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 
                String   PlotName0="BG_"+ProcImage+"0"
                String   EDC0=PlotName0
                Make/O/N=(nx) $EDC0
                WAVE EDCC=$EDC0
                EDCC=TempBGImage[p] [0]
                 
                                  
                NVar BGN=root:PROCESS:BGSubCurveNo
                String   BGReference="Ref_"+ProcImage
                String   BGSubRef=BGReference
                Make/O/N=(nx) $BGSubRef
                WAVE BG_Reference=$BGSubRef
                BG_Reference=TempBGImage[p] [BGN]


                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=1               
                
	         EDCC-=BG_Reference
	                         Variable k=0
                                  Do
                                  BGImage[k] [0]=EDCC[k]
                                  k=k+1
                                  While(k<nx)
	        
	        
	        
	         Variable ll 
	         Do
                 PlotName="BG_"+ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempBGImage[p] [i]
                 EDCSpectra-=BG_Reference
                               ll=0
                               Do
                               BGImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)
       	        i=i+1
	        While(i<ny) 
	        
	        
	        
             Duplicate/O BGImage RBGImage
             NVar DisplayMode=root:Process:ProIMGDisplayMode	        
             If (DisplayMode==1)
//           Duplicate/O BGImage RBGImage
		MatrixTranspose RBGImage
		Else
		Endif
		

                 DoWindow $BGProcImageName
                IF(V_flag==0)
                
                			 Display; Appendimage RBGImage                 
                			 ModifyImage $RotateBGImage ctab= {*,*,PlanetEarth,1}
                			 DoWindow/C $BGProcImageName              
 		
	          else
	          DoWindow/F $BGProcImageName
          
	          ENDIF           
	                  
         
              
                 
             //Kill EDC Curves in Root:BackGroungSubtractedImage
	     String ToBeKilledEDCList=WaveList("*F*P*T*",";","DIMS:1")
       	    Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
             String EDCCurve
	     Variable iEDC=0
	     Do
	     EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	     KillWaves/Z  $EDCCurve
	     iEDC+=1
	     While(iEDC<NoofKilledEDCList)
      
	    SetDataFolder Curr  
	       
	    End	
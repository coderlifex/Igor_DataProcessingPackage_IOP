#pragma rtGlobals=1		// Use modern global access method.


Function XJZMDCStackforDispersion(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String TempDisImage=popStr
	String MDCStack=popStr
	
	
	String Curr=GetDataFolder(1)
	
	SetDataFolder root:OriginalData
	String ReferenceMomentum="KRef_"+popStr
	String EnergryRefreence="ERef_"+popStr
	
	Variable LengthofName=strlen(popStr)
	String/G ThetaFromName=popStr[LengthofName-3,LengthofName]
	SVar TempImageName=root:MDCSpectra:TempMDCName
	TempImageName=popStr

	
//      WAVE OldImage=root:DispersionIMAGE:$TempDisImage
        WAVE OldImage=root:DispersionIMAGE:$popStr  
        NVar MDCOffset=root:MDCSpectra:MDCSpectraOffset   
        NVar SpecBind=root:PROCESS:SpectraBind
        
       NVar Energy_Start=root:MDCSpectra:DispersionEnergyStart
       NVar Energy_End=root:MDCSpectra:DispersionEnergyEnd
       NVar Momentum_Start=root:MDCSpectra:DispersionMomentumStart
       NVar Momentum_End=root:MDCSpectra:DispersionMomentumEnd

 //       Duplicate/O/R=(Momentum_Start,Momentum_End)(Energy_Start,Energy_End) OldImage, NImage


      SetDataFolder Root:MDCSpectra
      Duplicate/O/R=(Momentum_Start,Momentum_End)(Energy_Start,Energy_End) OldImage, NImage    
        
//    Display; Appendimage NImage

       
       SetDataFolder Root:MDCSpectra
       
       	String ToBeKilledList=WaveList("MDC*",";","DIMS:1")
       	Variable NoofKilledList=ItemsinList(ToBeKilledList,";")
       	String MDC
//	     Print ToBeKilledList
//	     Print NoofKilledList
	     Variable iMDC=0
	     Do
	     MDC=StringFromList(iMDC,ToBeKilledList,";")
	     KillWaves/Z  $MDC
	     iMDC+=1
	     While(iMDC<NoofKilledList)
	     
	      String ToBeKilledMDCKRef=WaveList("fit*",";","DIMS:1")
       	      Variable NoofKilledMDCKRef=ItemsinList(ToBeKilledMDCKRef,";")
       	      String MDCKRef
	      Variable iMDCKREf=0
	      Do
	      MDCKRef=StringFromList(iMDCKRef,ToBeKilledMDCKRef,";")
	      KillWaves/Z  $MDCKRef
	      iMDCKRef+=1
	      While(iMDCKRef<NoofKilledMDCKRef)
	     
	
       variable/G nx, ny
	   variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
 
//	        Make/O/N=(nx) ReferenceMomentumWave
	        Make/O/N=(nx) $ReferenceMomentum	        
                Variable ii=0
                WAVE RefMomentum=$ReferenceMomentum
      	        Do
        		RefMomentum[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
       	 	
//      	 	Edit ReferenceMomentumWave
       	 	
       	   Make/O/N=(ny) ReferenceEnergyWave
                Variable j=0
      	         Do
        		ReferenceEnergyWave[j]=ymin+yinc*j
        		j=j+1
       	  While(j<ny)
       	 	
 
                String   PlotName0=TempDisImage+"0"
                String   MDC0=PlotName0
                 Make/O/N=(nx) $MDC0
                 WAVE MDCC=$MDC0
                 MDCC=NImage[p] [0]
                 
                 String MDCName
                 Variable i=1                
                 
                 DoWindow $MDCStack
	          if(V_flag==0)
                 Display  MDCC vs RefMomentum as MDCStack
                 ModifyGraph rgb($MDC0)=(0,15872,65280)
                 ModifyGraph lsize($MDC0)=3
                 ModifyGraph width={Aspect,0.65}
                 ModifyGraph height=350
                 	Do
               		 MDCName=TempDisImage+num2str(i)
              		 Make/O/N=(nx) $MDCName
              		 WAVE MDCSpectra=$MDCName
             		 MDCSpectra=NImage[p] [i]+MDCOffset*i
               		 AppendToGraph MDCSpectra vs RefMomentum       
              		  i=i+1
	         	 While(i<ny)
                                 
        		DoWindow/C $MDCStack
	        	else
	        		DoWindow/F $MDCStack
                 	Do
               		 MDCName=TempDisImage+num2str(i)
              		 Make/O/N=(nx) $MDCName
              		 WAVE MDCSpectra=$MDCName
             		 MDCSpectra=NImage[p] [i]+MDCOffset*i
              		  i=i+1
	         	 While(i<ny)
	        	endif  
                 
                 Label bottom "\\Z18k  (\\F'Symbol'p\\F'Arial'/a)"
                 
                 String MDCStackBin=MDCStack+"_wBind"
                 DoWindow/K $MDCStackBin
                     
	        SetDataFolder Curr  
	        
END


Function XJZMDCStack_WithBind(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String TempDisImage=popStr
	String MDCStack=popStr+"_wBind"
	
	
	String Curr=GetDataFolder(1)
	SetDataFolder root:OriginalData
	String ReferenceMomentum="KRef_"+popStr
	String EnergryRefreence="ERef_"+popStr
	
	Variable LengthofName=strlen(popStr)
	String/G ThetaFromName=popStr[LengthofName-3,LengthofName]
	SVar TempImageName=root:MDCSpectra:TempMDCName
	     TempImageName=popStr

	
//      WAVE OldImage=root:DispersionIMAGE:$TempDisImage
        WAVE OldImage=root:DispersionIMAGE:$popStr  
        NVar MDCOffset=root:MDCSpectra:MDCSpectraOffset   
        NVar MDCBind=root:MDCSpectra:MDCBindNumber
        
       NVar Energy_Start=root:MDCSpectra:DispersionEnergyStart
       NVar Energy_End=root:MDCSpectra:DispersionEnergyEnd
       NVar Momentum_Start=root:MDCSpectra:DispersionMomentumStart
       NVar Momentum_End=root:MDCSpectra:DispersionMomentumEnd

 //       Duplicate/O/R=(Momentum_Start,Momentum_End)(Energy_Start,Energy_End) OldImage, NImage


      SetDataFolder Root:MDCSpectra
      Duplicate/O/R=(Momentum_Start,Momentum_End)(Energy_Start,Energy_End) OldImage, NImage    
        
//    Display; Appendimage NImage

       
       SetDataFolder Root:MDCSpectra
       
       	String ToBeKilledList=WaveList("D*",";","DIMS:1")
       	Variable NoofKilledList=ItemsinList(ToBeKilledList,";")
       	String MDC
//	Print ToBeKilledList
//	Print NoofKilledList
	     Variable iMDC=0
	     Do
	     MDC=StringFromList(iMDC,ToBeKilledList,";")
	     KillWaves/Z  $MDC
	     iMDC+=1
	     While(iMDC<NoofKilledList)
	     
	       String ToBeKilledMDCKRef=WaveList("KRef*",";","DIMS:1")
       	      Variable NoofKilledMDCKRef=ItemsinList(ToBeKilledMDCKRef,";")
              String MDCKRef
	      Variable iMDCKREf=0
	      Do
	      MDCKRef=StringFromList(iMDCKRef,ToBeKilledMDCKRef,";")
	      KillWaves/Z  $MDCKRef
	      iMDCKRef+=1
	      While(iMDCKRef<NoofKilledMDCKRef)

        	
	Variable/G nx, ny
	Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NImage)
 
//	        Make/O/N=(nx) ReferenceMomentumWave
	        Make/O/N=(nx) $ReferenceMomentum	        
                Variable ii=0
                WAVE RefMomentum=$ReferenceMomentum
      	        Do
        		RefMomentum[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
       	 	
//      	 	Edit ReferenceMomentumWave
       	 	
       	     Make/O/N=(ny) ReferenceEnergyWave
             Variable j=0
      	     Do
        		ReferenceEnergyWave[j]=ymin+yinc*j
        		j=j+1
       	    While(j<ny)
       	 	
 
                String   PlotName0=TempDisImage+"0"
                String   MDC0=PlotName0
                 Make/O/N=(nx) $MDC0
                 WAVE MDCC=$MDC0
                 MDCC=NImage[p] [0]*MDCBind
                 
                 String MDCName
                 Variable i=MDCBind  
                 Variable jj
                 Variable k             
                 
                 DoWindow $MDCStack
	          if(V_flag==0)
                 Display  MDCC vs RefMomentum as MDCStack
                 ModifyGraph rgb($MDC0)=(0,15872,65280)
                 ModifyGraph lsize($MDC0)=3
                 ModifyGraph width={Aspect,0.65}
                 ModifyGraph height=350
                 	Do
               		 MDCName=TempDisImage+num2str(i)
              		 Make/O/N=(nx) $MDCName
              		 WAVE MDCSpectra=$MDCName
              		 
              	     MDCSpectra=0 
                	     k=i
                 	jj=0
                 	Do
                 	k-=jj
                 	MDCSpectra+=NImage[p] [k]
                 	jj+=1
                 	While (jj<MDCBind)	 
              		 
                		 
                  MDCSpectra+=MDCOffset*i
               	 AppendToGraph MDCSpectra vs RefMomentum       
              	 i=i+MDCBind
	         	 While(i<ny)
                                 
        		DoWindow/C $MDCStack
	        	else
	        		DoWindow/F $MDCStack
                 	Do
               		 MDCName=TempDisImage+num2str(i)
              		 Make/O/N=(nx) $MDCName
              		 WAVE MDCSpectra=$MDCName
              		 
                   	MDCSpectra=0 
                  	k=i
                 	jj=0
                 	Do
                 	k-=jj
                 	MDCSpectra+=NImage[p] [k]
                 	jj+=1
                 	While (jj<MDCBind)	 
              		 
                		 
             		 MDCSpectra+=MDCOffset*i
//               	 AppendToGraph MDCSpectra vs RefMomentum       
              	 i=i+MDCBind
	         	 While(i<ny)
	        	endif  
                 
                 Label bottom "\\Z18k  (\\F'Symbol'p\\F'Arial'/a)"
                 
      
	        SetDataFolder Curr  
	        
END

proc ZWTShowMDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	pauseupdate;silent 1
	variable EStart=root:MDCSpectra:DispersionEnergyStart
	Variable EEnd=root:MDCSpectra:DispersionEnergyEnd
	Variable KStart=root:MDCSpectra:DispersionMomentumStart
	Variable KEnd=root:MDCSpectra:DispersionMomentumEnd
	Variable Offset=root:MDCSpectra:MDCSpectraOffset
	Variable Bind=root:MDCSpectra:MDCBindNumber
	variable PHIOffset=root:PROCESS:PhiOffset
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable ii//,jj
	
	Variable theta,phi//,omega,
	Newdatafolder/O root:MDCSpectra
	setdatafolder root:MDCSpectra
	String GraphN="MDC_"+popStr
	DoWindow/K $GraphN
	killwaves/A/Z
	//kill
	setdatafolder root:OriginalData
	//print tempwavename
	ii=0
	do
		//setdatafolder root:OriginalData
		if(stringmatch(ProcessedImage[ii],popStr))
			Theta=Theta_Angle[ii]
			PHI=Phi_Angle[ii]
			//print 1
			break
		endif
		ii=ii+1
	while(ii<Dimsize(ProcessedImage,0))
	
	setdatafolder root:Process
	Duplicate/O $popStr,root:MDCSpectra:TempImage
	setdatafolder root:MDCSpectra
	variable deltaE=deltax(TempImage)
	//print deltaE
	variable E0=leftx(TempImage)
	Make/O/N=(dimsize(TempImage,1)) AngleY,MDCIntensity,MDCKp
	AngleY=Dimdelta(TempImage,1)*x+Dimoffset(TempImage,1)
	AngleY=Phi-PhiOffset-AngleY
	//MDCIntensity=TempImage[100][p]
	String TempFullPath
	variable jj=0
	//variable halfBind=(bind+1)/2
	String TempMDCname,TempKName
	String tempFolderName="MDC_"+popStr
	//NewDataFolder/O/S root:MDCandMDCFitting:$tempFolderName
	//killwaves/A/Z
	
	
	Display/K=1/N=$GraphN
	
	ii=round((EStart-E0)/DeltaE)
	Variable temp=ii
	root:MDCSpectra:DispersionEnergyStart=ii*DeltaE+E0
	PauseUpdate;Silent 1
	//print EStart
	//Print EENd
	if(EStart<=EEnd)
	
		do
			if(ii>round((EEnd-E0)/DeltaE))
			//print "bb"
				root:MDCSpectra:DispersionEnergyEnd=(ii-(Bind+1)/2)*DeltaE+E0
				//print 1
				break
			endif
		
			setdatafolder root:MDCSpectra
			MDCIntensity=TempImage[ii][p]
			jj=1
			if(Bind-1!=0)
				//print "aa"
				do
					MDCIntensity+=TempImage[ii+jj][p]+TempImage[ii-jj][p]
					jj=jj+1
				while(jj<(Bind+1)/2)
			endif
			//TempMDCName=TempWaveName+"_MDC"+num2str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempMDCName=TempWaveName[3]+"_I"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempMDCName="MDCI_"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempMDCName=TempWaveName+"_MDC"+num2str(E0+ii*deltaE)+"meV"
			//print num2str((1000*(E0+ii*deltaE)))
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+":"+TempMDCName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			//Duplicate/O MDCIntensity,root:MDCandMDCFitting:$tempFolderName:$TempMDCName
			//Duplicate/O MDCIntensity,$TempFullPath
			Duplicate/O root:MDCSpectra:MDCIntensity,$TempMDCName
			setdatafolder root:MDCSpectra
			MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			//MDCKp=0.5118*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			//TempKName=TempWaveName+"_K"+num2Str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempKName=TempWaveName+"_K"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempKName="MDCK_"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+TempKName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			Duplicate/O root:MDCSpectra:MDCKp,$TempKName
			//Duplicate/O MDCKp,root:MDCandMDCFitting:$tempFolderName:$TempKName
			//Duplicate/O MDCKp,$TempFullPath
			//setdatafolder root:MDCandMDCFitting:$tempFolderName
			$TempMDCName+=(ii-round((EStart-E0)/DeltaE))*Offset
			//print TempMDCName
			//AppendToGraph/L=L_Fig12_/B=B_Fig12_ 'MDCI_-379.5meV' vs 'MDCK_44.5meV'
			appendtograph $TempMDCName vs $TempKName
			//ModifyGraph offset($TempMDCName)={0,(ii-round((EStart-E0)/DeltaE))*Offset}
		
			ii=ii+(Bind+1)/2
		While(1)
		
	endif
	
	if(EStart>EEnd)
		//DeltaE=-DeltaE
		do
			if(ii<round((EEnd-E0)/DeltaE))
				root:MDCSpectra:DispersionEnergyEnd=(ii+(Bind+1)/2)*DeltaE+E0
				//print 1
				break
			endif
		
			setdatafolder root:MDCSpectra
			MDCIntensity=TempImage[ii][p]
			jj=1
			if(Bind-1!=0)
				do
					MDCIntensity+=TempImage[ii+jj][p]+TempImage[ii-jj][p]
					jj=jj+1
				while(jj<(Bind+1)/2)
			endif
			//TempMDCName=TempWaveName+"_MDC"+num2str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempMDCName=TempWaveName[3]+"_I"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempMDCName="MDCI_"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempMDCName=TempWaveName+"_MDC"+num2str(E0+ii*deltaE)+"meV"
			//print num2str((1000*(E0+ii*deltaE)))
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+":"+TempMDCName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			//Duplicate/O MDCIntensity,root:MDCandMDCFitting:$tempFolderName:$TempMDCName
			//Duplicate/O MDCIntensity,$TempFullPath
			Duplicate/O root:MDCSpectra:MDCIntensity,$TempMDCName
			setdatafolder root:MDCSpectra
			//MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			MDCKp=0.5118*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			//TempKName=TempWaveName+"_K"+num2Str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempKName=TempWaveName+"_K"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempKName="MDCK_"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+TempKName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			Duplicate/O root:MDCSpectra:MDCKp,$TempKName
			//Duplicate/O MDCKp,root:MDCandMDCFitting:$tempFolderName:$TempKName
			//Duplicate/O MDCKp,$TempFullPath
			//setdatafolder root:MDCandMDCFitting:$tempFolderName
			$TempMDCName+=(ii-round((EStart-E0)/DeltaE))*Offset
			//print TempMDCName
			appendtograph $TempMDCName vs $TempKName
			//ModifyGraph offset($TempMDCName)={0,(ii-round((EStart-E0)/DeltaE))*Offset}
		
			ii=ii-(Bind+1)/2
		While(1)
	endif
	Label bottom "K\\B//\\M (\\F'symbol'p/\\F'ARial'a)"
	Label left "Intensity (A. U. )"
	SetAxis bottom KStart,KEnd
	TempMDCName="MDCI_"+num2str(round(10000*(E0+temp*deltaE)/5)/10*5)+"meV"
	TempKName="MDCK_"+num2Str(round(10000*(E0+temp*deltaE)/5)/10*5)+"meV"
	RemoveFromGraph $TempMDCName
	appendtograph  $TempMDCName vs $TempKName
	ModifyGraph lsize($tempMDCName)=3,rgb($TempMDCName)=(0,0,65280)
	setdatafolder root:MDCSpectra
	killwaves/A/Z
end

	
//end

Function XJZMDCStack_Eb_UnEven_Cor(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String TempDisImage=popStr
	String MDCStack=popStr+"_Eb_UnEven"
	
	
	String Curr=GetDataFolder(1)
	
	SetDataFolder Root:MDCSpectra
	
	
	Execute "CleanMDCSpectraFolder()"
	
	
	
//////(1a). Clean up the unused MDCs	
////	    String ToBeKilledList=WaveList("MDC*",";","DIMS:1")
////       	Variable NoofKilledList=ItemsinList(ToBeKilledList,";")
////       	String MDC
//////	    Print ToBeKilledList
//////	    Print NoofKilledList
////	     Variable iMDC=0
////	     Do
////	     MDC=StringFromList(iMDC,ToBeKilledList,";")
////	     KillWaves/Z  $MDC
////	     iMDC+=1
////	     While(iMDC<NoofKilledList)
	     
//////(1b). Clean up the fit files	     
	     
////	      String ToBeKilledMDCKRef=WaveList("fit*",";","DIMS:1")
////       	  Variable NoofKilledMDCKRef=ItemsinList(ToBeKilledMDCKRef,";")
////          String MDCKRef
////	      Variable iMDCKREf=0
////	      Do
////	      MDCKRef=StringFromList(iMDCKRef,ToBeKilledMDCKRef,";")
////	      KillWaves/Z  $MDCKRef
////	      iMDCKRef+=1
////	      While(iMDCKRef<NoofKilledMDCKRef)


	
	
	
//(2). From Dispersion Name find the Original Processed Name
	
	Variable LengthofName=strlen(popStr)
	String OriProcessedName=popStr[2,LengthofName]
	
//    Print	OriProcessedName
//    Display;AppendImage root:PROCESS:$OriProcessedName

    Duplicate/O root:PROCESS:$OriProcessedName TempAngleImage


    
    Variable nx, ny
	Variable xmin, xinc, xmax, ymin, yinc, ymax
	nx=DimSize(TempAngleImage, 0); 	ny=DimSize(TempAngleImage, 1)
	xmin=DimOffset(TempAngleImage,0);  ymin=DimOffset(TempAngleImage,1);
	xinc=round(DimDelta(TempAngleImage,0) * 1E6) / 1E6	
	yinc=round(DimDelta(TempAngleImage,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1);
	
////    Variable   DetPhimin=(ymin+ymax)/2-ymax
//// 	Variable   DetPhimax=(ymin+ymax)/2-ymin
 	
 	//On 2007/06/29 Change from (ymin+ymax)/2 into DetectorCenterAngle
 	
//// 	NVar DetectorCenAngle=root:PROCESS:DetectorCenterAngle
 	
//// 	Variable   DetPhimin=ymin
//// 	Variable   DetPhimax=ymax
 	
//// 	Print "DetPhiMin=", DetPhimin
 	
 			
//// 	SetScale/I y, DetPhimin, DetPhimax, TempAngleImage 
 	
 	/////Make the angle symmetrical so in the following it will not cause problem
    
    
    
//(3). Crop Porcessed Image along Energy axis, but not along the angle axis
       NVar Energy_Start=root:MDCSpectra:DispersionEnergyStart
       NVar Energy_End=root:MDCSpectra:DispersionEnergyEnd
       NVar Momentum_Start=root:MDCSpectra:DispersionMomentumStart
       NVar Momentum_End=root:MDCSpectra:DispersionMomentumEnd   
    
   Duplicate/O/R=(Energy_Start,Energy_End)(ymin,ymax) TempAngleImage, TemAngleDisImage 
////   Display;AppendImage TemAngleDisImage
   
   
    Variable Dnx, Dny
	Variable Dxmin, Dxinc, Dxmax, Dymin, Dyinc, Dymax
	Dnx=DimSize(TemAngleDisImage, 0); 	Dny=DimSize(TemAngleDisImage, 1)
	Dxmin=DimOffset(TemAngleDisImage,0);  Dymin=DimOffset(TemAngleDisImage,1);
	Dxinc=round(DimDelta(TemAngleDisImage,0) * 1E6) / 1E6	
	Dyinc=round(DimDelta(TemAngleDisImage,1)* 1E6) / 1E6
	Dxmax=xmin+xinc*(nx-1);	Dymax=ymin+yinc*(ny-1);   
  
    Print "Dny=", Dny
    Print "Dnx=", Dnx




//(4). Make Energy Reference Wave 

//	        Make/O/N=(nx) ReferenceMomentumWave
//	        Make/O/N=(nx) $ReferenceMomentum	        
//                Variable ii=0
//                WAVE RefMomentum=$ReferenceMomentum
//      	        Do
//        		RefMomentum[ii]=xmin+xinc*ii
//        		ii=ii+1
//       	 	While(ii<nx)
       	 	
//      	 	Edit ReferenceMomentumWave
       	 	
       	     Make/O/N=(Dnx) ReferenceEnergyWave
            Variable j=0
      	     Do
        		ReferenceEnergyWave[j]=Dxmin+Dxinc*j
        		j=j+1
       	    While(j<Dnx)



	
//(5). Find Phi in the Original Data

Variable iFindPhi=0
String RightName
NVar NoofAll2DFiles=root:OriginalData:NoofOriginalFile
Wave/T ProcessedIMG=root:OriginalData:ProcessedImage
Variable NDisPhi
NVar PhiOffset=root:PROCESS:PhiOffset
Wave Phi_Angle=root:OriginalData:Phi_Angle


Do

RightName=ProcessedIMG[iFindPhi]

If (cmpstr(RightName,OriProcessedName)==0)
NDisPhi=Phi_Angle[iFindPhi]
EndIF

iFindPhi+=1
While (iFindPhi<NoofAll2DFiles)

//Print "NDisPhi=", NDisPhi



String TemIntenName, TemKName

Variable iE, iA
Variable BEnergy
NVar PhotonE=root:PROCESS:PhotonEnergy
NVar WorkFunc=root:Process:WorkFunction
NVar LC=root:PROCESS:LatticeConstant


iE=0
Do

BEnergy=Dxmin + Dxinc*iE

TemIntenName="MDCIntensity"+Num2Str(iE)
TemKName="MDCMomentum"+Num2Str(iE)

Make/O/N=(Dny) $TemIntenName, $TemKName
Wave TempIntenName=$TemIntenName
Wave TempKName=$TemKName

Redimension  TempIntenName, TempKName

       iA=0
       Do
       TempIntenName[iA]=TemAngleDisImage[iE][iA]
       
       TempKName[iA]=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+BEnergy)*sin(3.1416/180*(-Dymin-Dyinc*iA+NDisPhi-PhiOffset))
       
       
       
       iA+=1
       While(iA<Dny)

iE+=1
While(iE<Dnx)


DoWindow $MDCStack



Variable ik=1
String MDCIntensity, MDCMomentum


	          If(V_flag==0)
              Display  MDCIntensity0 vs MDCMomentum0 as MDCStack
              ModifyGraph lsize(MDCIntensity0)=2,rgb(MDCIntensity0)=(0,15872,65280)
              ModifyGraph rgb(MDCIntensity0)=(0,15872,65280)
              ModifyGraph lsize(MDCIntensity0)=3
              ModifyGraph width={Aspect,0.65}
              ModifyGraph height=350

             Do
             
             MDCIntensity="MDCIntensity"+num2str(ik)
             MDCMomentum="MDCMomentum"+num2str(ik)
             
             AppendToGraph $MDCIntensity vs $MDCMomentum
             
             ik+=1
             While (ik<Dnx)
             
             
             
             DoWindow/C $MDCStack
	         Else
	        		
	         DoWindow/F $MDCStack
             
             EndIf
             
             Label bottom "\\F'Times New Roman'\\Z18k  (\\F'Symbol'p\\F'Arial'/a)"
             

  
////        NVar MDCOffset=root:MDCSpectra:MDCSpectraOffset   
/////        NVar MDCBind=root:MDCSpectra:MDCBindNumber
        
       

      	 	
 
////                String   PlotName0=TempDisImage+"0"
////                String   MDC0=PlotName0
////                 Make/O/N=(nx) $MDC0
////                 WAVE MDCC=$MDC0
////                 MDCC=TemAngleDisImage[p] [0]*MDCBind
                 
////                 String MDCName
 ////                Variable i=MDCBind  
////                 Variable jj
 ////                Variable k                          
                 
                 
////                 	Do
////                   MDCName=TempDisImage+num2str(i)
////              		 Make/O/N=(nx) $MDCName
////              		 WAVE MDCSpectra=$MDCName
              		 
////              	     MDCSpectra=0 
////                	     k=i
////                 	jj=0
////                 	Do
////                 	k-=jj
////                 	MDCSpectra+=TemAngleDisImage[p] [k]
////                 	jj+=1
////                 	While (jj<MDCBind)	 
              		 
                		 
////                  MDCSpectra+=MDCOffset*i
                  
                  
                  
////               	 AppendToGraph MDCSpectra vs RefMomentum       
////              	 i=i+MDCBind
////	         	 While(i<ny)
                                 
////        		DoWindow/C $MDCStack
////	        	else
////	        		DoWindow/F $MDCStack
////                 	Do
////               	 MDCName=TempDisImage+num2str(i)
 ////             		 Make/O/N=(nx) $MDCName
////              		 WAVE MDCSpectra=$MDCName
              		 
////                   MDCSpectra=0 
////                  	k=i
////                 	jj=0
////                 	Do
////                 	k-=jj
////                 	MDCSpectra+=TemAngleDisImage[p] [k]
////                 	jj+=1
////                 	While (jj<MDCBind)	 
              		 
////                		 
////                MDCSpectra+=MDCOffset*i
//               	 AppendToGraph MDCSpectra vs RefMomentum       
////              	 i=i+MDCBind
////	         	 While(i<ny)
////	        	 endif  
                 

                 
      
	        SetDataFolder Curr  
	        
END








Function XJZMDCStack_Eb_UnEven_Cor_ND(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String TempDisImage=popStr
	String MDCStack=popStr+"_Eb_UnEven"
	
	
	String Curr=GetDataFolder(1)
	
	SetDataFolder Root:MDCSpectra
	
	
	Execute "CleanMDCSpectraFolder()"
	
	
	
//////(1a). Clean up the unused MDCs	
////	    String ToBeKilledList=WaveList("MDC*",";","DIMS:1")
////       	Variable NoofKilledList=ItemsinList(ToBeKilledList,";")
////       	String MDC
//////	    Print ToBeKilledList
//////	    Print NoofKilledList
////	     Variable iMDC=0
////	     Do
////	     MDC=StringFromList(iMDC,ToBeKilledList,";")
////	     KillWaves/Z  $MDC
////	     iMDC+=1
////	     While(iMDC<NoofKilledList)
	     
//////(1b). Clean up the fit files	     
	     
////	      String ToBeKilledMDCKRef=WaveList("fit*",";","DIMS:1")
////       	  Variable NoofKilledMDCKRef=ItemsinList(ToBeKilledMDCKRef,";")
////          String MDCKRef
////	      Variable iMDCKREf=0
////	      Do
////	      MDCKRef=StringFromList(iMDCKRef,ToBeKilledMDCKRef,";")
////	      KillWaves/Z  $MDCKRef
////	      iMDCKRef+=1
////	      While(iMDCKRef<NoofKilledMDCKRef)


	
	
	
//(2). From Dispersion Name find the Original Processed Name
	
	Variable LengthofName=strlen(popStr)
	String OriProcessedName=popStr[2,LengthofName]
	
//    Print	OriProcessedName
//    Display;AppendImage root:PROCESS:$OriProcessedName

    Duplicate/O root:PROCESS:$OriProcessedName TempAngleImage


    
    Variable nx, ny
	Variable xmin, xinc, xmax, ymin, yinc, ymax
	nx=DimSize(TempAngleImage, 0); 	ny=DimSize(TempAngleImage, 1)
	xmin=DimOffset(TempAngleImage,0);  ymin=DimOffset(TempAngleImage,1);
	xinc=round(DimDelta(TempAngleImage,0) * 1E6) / 1E6	
	yinc=round(DimDelta(TempAngleImage,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1);
	
////    Variable   DetPhimin=(ymin+ymax)/2-ymax
//// 	Variable   DetPhimax=(ymin+ymax)/2-ymin
 	
 	//On 2007/06/29 Change from (ymin+ymax)/2 into DetectorCenterAngle
 	
//// 	NVar DetectorCenAngle=root:PROCESS:DetectorCenterAngle
 	
//// 	Variable   DetPhimin=ymin
//// 	Variable   DetPhimax=ymax
 	
//// 	Print "DetPhiMin=", DetPhimin
 	
 			
//// 	SetScale/I y, DetPhimin, DetPhimax, TempAngleImage 
 	
 	/////Make the angle symmetrical so in the following it will not cause problem
    
    
    
//(3). Crop Porcessed Image along Energy axis, but not along the angle axis
       NVar Energy_Start=root:MDCSpectra:DispersionEnergyStart
       NVar Energy_End=root:MDCSpectra:DispersionEnergyEnd
       NVar Momentum_Start=root:MDCSpectra:DispersionMomentumStart
       NVar Momentum_End=root:MDCSpectra:DispersionMomentumEnd   
    
   Duplicate/O/R=(Energy_Start,Energy_End)(ymin,ymax) TempAngleImage, TemAngleDisImage 
////   Display;AppendImage TemAngleDisImage
   
   
    Variable Dnx, Dny
	Variable Dxmin, Dxinc, Dxmax, Dymin, Dyinc, Dymax
	Dnx=DimSize(TemAngleDisImage, 0); 	Dny=DimSize(TemAngleDisImage, 1)
	Dxmin=DimOffset(TemAngleDisImage,0);  Dymin=DimOffset(TemAngleDisImage,1);
	Dxinc=round(DimDelta(TemAngleDisImage,0) * 1E6) / 1E6	
	Dyinc=round(DimDelta(TemAngleDisImage,1)* 1E6) / 1E6
	Dxmax=xmin+xinc*(nx-1);	Dymax=ymin+yinc*(ny-1);   
  
////    Print "Dny=", Dny
////    Print "Dnx=", Dnx




//(4). Make Energy Reference Wave 

//	        Make/O/N=(nx) ReferenceMomentumWave
//	        Make/O/N=(nx) $ReferenceMomentum	        
//                Variable ii=0
//                WAVE RefMomentum=$ReferenceMomentum
//      	        Do
//        		RefMomentum[ii]=xmin+xinc*ii
//        		ii=ii+1
//       	 	While(ii<nx)
       	 	
//      	 	Edit ReferenceMomentumWave
       	 	
       	     Make/O/N=(Dnx) ReferenceEnergyWave
            Variable j=0
      	     Do
        		ReferenceEnergyWave[j]=Dxmin+Dxinc*j
        		j=j+1
       	    While(j<Dnx)



	
//(5). Find Phi in the Original Data

Variable iFindPhi=0
String RightName
NVar NoofAll2DFiles=root:OriginalData:NoofOriginalFile
Wave/T ProcessedIMG=root:OriginalData:ProcessedImage
Variable NDisPhi
NVar PhiOffset=root:PROCESS:PhiOffset
Wave Phi_Angle=root:OriginalData:Phi_Angle


Do

RightName=ProcessedIMG[iFindPhi]

If (cmpstr(RightName,OriProcessedName)==0)
NDisPhi=Phi_Angle[iFindPhi]
EndIF

iFindPhi+=1
While (iFindPhi<NoofAll2DFiles)

//Print "NDisPhi=", NDisPhi



String TemIntenName, TemKName

Variable iE, iA
Variable BEnergy
NVar PhotonE=root:PROCESS:PhotonEnergy
NVar WorkFunc=root:Process:WorkFunction
NVar LC=root:PROCESS:LatticeConstant


iE=0
Do

BEnergy=Dxmin + Dxinc*iE

TemIntenName="MDCIntensity"+Num2Str(iE)
TemKName="MDCMomentum"+Num2Str(iE)

Make/O/N=(Dny) $TemIntenName, $TemKName
Wave TempIntenName=$TemIntenName
Wave TempKName=$TemKName

Redimension  TempIntenName, TempKName

       iA=0
       Do
       TempIntenName[iA]=TemAngleDisImage[iE][iA]
       
       TempKName[iA]=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+BEnergy)*sin(3.1416/180*(-Dymin-Dyinc*iA+NDisPhi-PhiOffset))
       
       
       
       iA+=1
       While(iA<Dny)

iE+=1
While(iE<Dnx)


DoWindow $MDCStack



Variable ik=1
String MDCIntensity, MDCMomentum


/////	          If(V_flag==0)
/////              Display  MDCIntensity0 vs MDCMomentum0 as MDCStack
/////              ModifyGraph lsize(MDCIntensity0)=2,rgb(MDCIntensity0)=(0,15872,65280)
/////              ModifyGraph rgb(MDCIntensity0)=(0,15872,65280)
/////              ModifyGraph lsize(MDCIntensity0)=3
/////              ModifyGraph width={Aspect,0.65}
/////              ModifyGraph height=350

/////            Do
             
/////             MDCIntensity="MDCIntensity"+num2str(ik)
/////             MDCMomentum="MDCMomentum"+num2str(ik)
             
/////             AppendToGraph $MDCIntensity vs $MDCMomentum
             
/////             ik+=1
/////             While (ik<Dnx)
             
             
             
/////             DoWindow/C $MDCStack
/////	         Else
	        		
/////	         DoWindow/F $MDCStack
             
/////             EndIf
             
/////             Label bottom "\\F'Times New Roman'\\Z18k  (\\F'Symbol'p\\F'Arial'/a)"
             

  
////        NVar MDCOffset=root:MDCSpectra:MDCSpectraOffset   
/////        NVar MDCBind=root:MDCSpectra:MDCBindNumber
        
       

      	 	
 
////                String   PlotName0=TempDisImage+"0"
////                String   MDC0=PlotName0
////                 Make/O/N=(nx) $MDC0
////                 WAVE MDCC=$MDC0
////                 MDCC=TemAngleDisImage[p] [0]*MDCBind
                 
////                 String MDCName
 ////                Variable i=MDCBind  
////                 Variable jj
 ////                Variable k                          
                 
                 
////                 	Do
////                   MDCName=TempDisImage+num2str(i)
////              		 Make/O/N=(nx) $MDCName
////              		 WAVE MDCSpectra=$MDCName
              		 
////              	     MDCSpectra=0 
////                	     k=i
////                 	jj=0
////                 	Do
////                 	k-=jj
////                 	MDCSpectra+=TemAngleDisImage[p] [k]
////                 	jj+=1
////                 	While (jj<MDCBind)	 
              		 
                		 
////                  MDCSpectra+=MDCOffset*i
                  
                  
                  
////               	 AppendToGraph MDCSpectra vs RefMomentum       
////              	 i=i+MDCBind
////	         	 While(i<ny)
                                 
////        		DoWindow/C $MDCStack
////	        	else
////	        		DoWindow/F $MDCStack
////                 	Do
////               	 MDCName=TempDisImage+num2str(i)
 ////             		 Make/O/N=(nx) $MDCName
////              		 WAVE MDCSpectra=$MDCName
              		 
////                   MDCSpectra=0 
////                  	k=i
////                 	jj=0
////                 	Do
////                 	k-=jj
////                 	MDCSpectra+=TemAngleDisImage[p] [k]
////                 	jj+=1
////                 	While (jj<MDCBind)	 
              		 
////                		 
////                MDCSpectra+=MDCOffset*i
//               	 AppendToGraph MDCSpectra vs RefMomentum       
////              	 i=i+MDCBind
////	         	 While(i<ny)
////	        	 endif  
                 

                 
      
	        SetDataFolder Curr  
	        
END


Proc CleanMDCSpectraFolder()

	String Curr=GetDataFolder(1)


    SetDataFolder Root:MDCSpectra
	
	
//(1a). Clean up the unused MDCs	
	    String ToBeKilledList=WaveList("MDC*",";","DIMS:1")
       	Variable NoofKilledList=ItemsinList(ToBeKilledList,";")
       	String MDC
//	    Print ToBeKilledList
//	    Print NoofKilledList
	     Variable iMDC=0
	     Do
	     MDC=StringFromList(iMDC,ToBeKilledList,";")
	     KillWaves/Z  $MDC
	     iMDC+=1
	     While(iMDC<NoofKilledList)
	     
//(1b). Clean up the fit files	     
	     
	      String ToBeKilledMDCKRef=WaveList("fit*",";","DIMS:1")
       	  Variable NoofKilledMDCKRef=ItemsinList(ToBeKilledMDCKRef,";")
          String MDCKRef
	      Variable iMDCKREf=0
	      Do
	      MDCKRef=StringFromList(iMDCKRef,ToBeKilledMDCKRef,";")
	      KillWaves/Z  $MDCKRef
	      iMDCKRef+=1
	      While(iMDCKRef<NoofKilledMDCKRef)

	 SetDataFolder Curr  
	 
End	 
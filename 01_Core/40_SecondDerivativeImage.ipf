#pragma rtGlobals=1		// Use modern global access method.



////////////////////////////EDC secondDerivativeImage
proc EDCDisperionFrom2DerivativeZWT(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
    variable   SmoothTimes=root:PROCESS:EDCSmoothingTimes	        
    String SecondDImage="EDC"+num2str(SmoothTimes)+popStr	
    String Notation=popStr    
    Variable PFlag=root:PROCESS:ProcessedImageFlag
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Newdatafolder/O root:EKImage_Interpolated
	NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a
	Killwaves/A/Z
	Setdatafolder root:OriginalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName,GraphN
	string PopStr1="EK"+popStr
	
	
	pauseupdate;silent 1
	ii=0
	do
		if(stringmatch(PopStr,ProcessedImage[ii]))
		Setdatafolder root:OriginalData
			
			TempPhi=Phi_Angle[ii]
			if(tempPhi>90)
			tempPhi=180+tempPhi
			endif
			
			tempWavename=ProcessedImage[ii]
			EKName="EK"+tempWaveName
			GraphN="Image"+tempWaveName
			setdatafolder root:EKImage_Interpolated:Pi_over_a 
			duplicate/O root:PROCESS:$TempWaveName,tempImage
			Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
			Make/O/N=(Dimsize(tempImage,0)) EE
			
			PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
			MinE=leftx(TempImage)
			MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			SetScale/I x MinE,MaxE,"", EE
			EE=x
			MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=0.5118*LatticeConstant/pi*MaxK
			MinK=0.5118*LatticeConstant/pi*MinK
			SetScale/I x MinK,MaxK,"", KK
			Variable DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
			print deltaK
			kk=x
			Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
			jj=0
			Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
			PhiAngle=tempPhi-PhiOffset-PhiAngle
			do
				MDCIntensity=TempImage[jj][p]
				MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
				Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
				lowKn=round((MDCKp[0]-kk[0])/deltaK)
				HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				//tempMDC[0,highkn-1]=NaN
				//tempMDC[lowkn+1,dimsize(tempMDC,0)]=NaN
				//lowKn=round((MDCKp[0]-kk[0])/deltaK)
				//HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				tempMDC[0,highkn-1]=tempMDC[highkn]
				tempMDC[lowkn+1,dimsize(tempMDC,0)]=tempMDC[lowkn]
				$EKName[][jj]=TempMDC[p]
				SetScale/I x minK,maxk,"", $EKName
				if(tempPhi>90)
				SetScale/I x -minK,-maxk,"", $EKName
				endif	
				
				SetScale/I y minE,maxE,"", $EKName
				jj=jj+1
			while(jj<Dimsize(TempImage,0))
//			dowindow/K $GraphN
//			Display/N=$GraphN
//			AppendImage $EKName;
//			ModifyImage $EKName ctab= {*,*,PlanetEarth,1}
//			ModifyGraph fStyle=1,fSize=14,axThick=1.5,standoff=0;
//			Label left "\Z20E-E\\BF \\M(eV)";DelayUpdate
//			Label bottom "\Z10k\\B// \\M(\\F'Symbol'p/\\F'Arial'a)"
//			ModifyGraph tick=2
//			ModifyGraph margin(left)=50, margin(bottom)=45, margin(top)=7,margin(right)=7
//			ModifyGraph width=226.772
//			ModifyGraph height=425.197
//			ModifyGraph zero(left)=4
			Duplicate/o $popStr1, root:DispersionFrom2ndDerivative:EDC2ndD:$SecondDImage
			setdatafolder root:EKImage_Interpolated:Pi_over_a
			killwaves/A/Z
			
			Break
		endif
		ii=ii+1
	while(ii<loops)
	NewDatafolder/O root:DispersionFrom2ndDerivative
	NewDatafolder/O/S root:DispersionFrom2ndDerivative:EDC2ndD

	//string PopStr1="EK"+popStr
	//GraphN="S"+SecondDImage
	GraphN="S2D"+SecondDImage
//	Duplicate/O root:EKImage_Interpolated:Pi_over_a:$popStr1, root:DispersionFrom2ndDerivative:EDC2ndD:$SecondDImage
	SetDataFolder root:DispersionFrom2ndDerivative:EDC2ndD
	pauseupdate;silent 1
	
	differentiate/Dim=1 $SecondDImage
	differentiate/Dim=1 $SecondDImage
	smooth/E=2/Dim=1 smoothtimes,$SecondDImage
	wavestats/Q $SecondDImage
	$SecondDImage=$SecondDImage/abs(V_min)
    DoWindow $GraphN
    if(V_flag==0)
    Display/N=$GraphN          
	AppendImage $SecondDImage
	Textbox/N=text0/F=0/A=MT Notation  
    ModifyImage $SecondDImage ctab= {-0.5,0,PlanetEarth,1}
    ModifyGraph standoff=0
    ModifyGraph zero(left)=3
    Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
    ModifyGraph width=180
    ModifyGraph height={Aspect,1.8}
    ModifyGraph margin(left)=26
    ModifyGraph margin(right)=5
    ModifyGraph margin(top)=5
    else
    DoWindow/F $GraphN      
    endif      
	KillWaves/A/Z

END

proc MDCDisperionFrom2DerivativeZWT(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
    variable   SmoothTimes=root:PROCESS:MDCSmoothingTimes	        
    String SecondDImage="MDC"+num2str(SmoothTimes)+popStr	
    String Notation=popStr    
    Variable PFlag=root:PROCESS:ProcessedImageFlag
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Newdatafolder/O root:EKImage_Interpolated
	NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a
	Killwaves/A/Z
	Setdatafolder root:OriginalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName,GraphN
	string PopStr1="EK"+popStr

	
	pauseupdate;silent 1
	ii=0
	do
		if(stringmatch(PopStr,ProcessedImage[ii]))
		Setdatafolder root:OriginalData
			
			TempPhi=Phi_Angle[ii]
			tempWavename=ProcessedImage[ii]
			//EKName="EK"+tempWaveName+"_PiOvera"
			//GraphN="Image"+tempWaveName+"PiOvera"
			
				if(tempPhi>90)
				tempPhi=180+tempPhi
				endif
			EKName="EK"+tempWaveName
			GraphN="Image"+tempWaveName
			
			setdatafolder root:EKImage_Interpolated:Pi_over_a 
			duplicate/O root:PROCESS:$TempWaveName,tempImage
			Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
			Make/O/N=(Dimsize(tempImage,0)) EE
			
			PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
			MinE=leftx(TempImage)
			MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			SetScale/I x MinE,MaxE,"", EE
			EE=x
			MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=0.5118*LatticeConstant/pi*MaxK
			MinK=0.5118*LatticeConstant/pi*MinK
			SetScale/I x MinK,MaxK,"", KK
			Variable DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
			print deltaK
			kk=x
			Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
			jj=0
			Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
			PhiAngle=tempPhi-PhiOffset-PhiAngle
			do
				MDCIntensity=TempImage[jj][p]
				MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
				Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
				lowKn=round((MDCKp[0]-kk[0])/deltaK)
				HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				tempMDC[0,highkn-1]=tempMDC[highkn]
				tempMDC[lowkn+1,dimsize(tempMDC,0)]=tempMDC[lowkn]
				$EKName[][jj]=TempMDC[p]
				SetScale/I x minK,maxk,"", $EKName
				if(tempPhi>90)
				SetScale/I x -minK,-maxk,"", $EKName
				endif
				
				SetScale/I y minE,maxE,"", $EKName
				jj=jj+1
			while(jj<Dimsize(TempImage,0))
//			dowindow/K $GraphN
//			Display/N=$GraphN
//			AppendImage $EKName;
//			ModifyImage $EKName ctab= {*,*,PlanetEarth,1}
//			ModifyGraph fStyle=1,fSize=14,axThick=1.5,standoff=0;
//			Label left "\Z20E-E\\BF \\M(eV)";DelayUpdate
//			Label bottom "\Z20k\\B// \\M(\\F'Symbol'p/\\F'Arial'a)"
//			ModifyGraph tick=2
//			ModifyGraph margin(left)=50, margin(bottom)=45, margin(top)=7,margin(right)=7
//			ModifyGraph width=226.772
//			ModifyGraph height=425.197
//			ModifyGraph zero(left)=4
			Duplicate/O $popStr1, root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage
			setdatafolder root:EKImage_Interpolated:Pi_over_a
			killwaves/A/Z
			
			Break
		endif
		ii=ii+1
	while(ii<loops)
	
	NewDatafolder/O root:DispersionFrom2ndDerivative
	NewDatafolder/O/S root:DispersionFrom2ndDerivative:MDC2ndD

	//string PopStr1="EK"+popStr+"_PiOVera"
	
	GraphN="S2D"+SecondDImage
	
	SetDataFolder root:DispersionFrom2ndDerivative:MDC2ndD
	pauseupdate;silent 1
	differentiate/Dim=0 $SecondDImage
	differentiate/Dim=0 $SecondDImage
	smooth/E=2/Dim=0 smoothtimes,$SecondDImage
	wavestats/Q $SecondDImage
	$SecondDImage=$SecondDImage/abs(V_min)

    DoWindow $GraphN
    if (V_flag==0)
    Display/N=$GraphN          
	AppendImage $SecondDImage
	Textbox/N=text0/F=0/A=MT Notation  
    ModifyImage $SecondDImage ctab= {-0.5,0,PlanetEarth,1}
    ModifyGraph standoff=0
    ModifyGraph zero(left)=3
    Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
    ModifyGraph width=180
    ModifyGraph height={Aspect,1.8}
    ModifyGraph margin(left)=26
    ModifyGraph margin(right)=5
    ModifyGraph margin(top)=5
    else
    DoWindow/F $GraphN
    endif
                
	KillWaves/A/Z

END


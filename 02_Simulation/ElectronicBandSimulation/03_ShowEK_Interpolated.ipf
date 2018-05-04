#pragma rtGlobals=1		// Use modern global access method.

Proc GetEKImage1OverA_XJZIOP(ctrlName,popNum,popStr):PopupMenuControl
	String CtrlName
	Variable PopNum
	String PopStr
	Variable PFlag=root:PROCESS:ProcessedImageFlag
	//Variable AStart=root:TempVariable:LoadingR4000Data:AngleStart
	//Variable AEnd=root:TempVariable:LoadingR4000Data:AngleEnd
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Variable GetALLEK=root:PRocess:GetALLEKV
	Newdatafolder/O root:EKImage_Interpolated
	NewDatafolder/O/S root:EKImage_Interpolated:one_over_A
	//Killwaves/A/Z
	//NewDatafolder/O/S root:EKImage:Pi_over_a
	//Killwaves/A/Z
	Setdatafolder root:OriginalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName,GraphN
	GraphN=PopStr
	String AttachName=popstr
	pauseupdate;silent 1
	ii=0
	do
		if(stringmatch(PopStr,ProcessedImage[ii]))
			
	//do
		Setdatafolder root:OriginalData
		//if(ProcessFlag[ii]==PFlag)
			//jj=jj+1
			
			TempPhi=Phi_Angle[ii]
			
			if(TempPhi>90)
			TempPhi=180+TempPhi
			endif
			
			
			tempWavename=ProcessedImage[ii]
			EKName="EK"+tempWaveName+"1A"
			GraphN=tempWaveName+"1A"
			setdatafolder root:EKImage_INterpolated:one_over_A
			duplicate/O root:PROCESS:$TempWaveName,tempImage
			Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
			Make/O/N=(Dimsize(tempImage,0)) EE
			
			PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
			MinE=leftx(TempImage)
			MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			//print MinE,MaxE
			SetScale/I x MinE,MaxE,"", EE
			EE=x
			MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			//print MaxK
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			//print MaxK
			MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			//print MaxK,minK
			MaxK=0.5118*MaxK
			MinK=0.5118*MinK
			//print min
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
				MDCKp=0.5118*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
				
				//print EE[jj]
				//hh=0
				//do
				Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
				lowKn=round((MDCKp[0]-kk[0])/deltaK)
				HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				tempMDC[0,highkn-1]=NaN
				tempMDC[lowkn+1,dimsize(tempMDC,0)]=NaN
				//tempMDC[0,round(MDCKp[0]/deltaK]=0
				//tempMDC[round(MDCKp[0]/deltaK]=0
				reverse TempMDC
				$EKName[][jj]=TempMDC[p]
				
				//SetScale/I x minK,maxk,"", $EKName
				SetScale/I x maxK,mink,"", $EKName
				if(TempPhi>90)
				SetScale/I x -maxK,-mink, $EKName
				endif
				
				SetScale/I y minE,maxE,"", $EKName
				//While(hh<Dimsize(TempImage,1))
				jj=jj+1
			while(jj<Dimsize(TempImage,0))
			
			attachName=EKName
			PopStr=EKName
			
			Break
		endif
		ii=ii+1
	while(ii<loops)
	setdatafolder root:EKImage_Interpolated:one_over_A
	dowindow/K $GraphN
	Display/N=$GraphN
	AppendImage $PopStr;//DelayUpdate
	ModifyImage $PopStr ctab= {*,*,PlanetEarth,1}
	ModifyGraph fStyle=1,fSize=18,axThick=1.5,standoff=0;//DelayUpdate
	Label left "E-E\\BF \\M(eV)";DelayUpdate
	Label bottom "K\\B// \\M(1/A)"
	ModifyGraph tick=2
	ModifyGraph margin(left)=60,margin(bottom)=45, margin(top)=7,margin(right)=7
	ModifyGraph width=180
//	ModifyGraph height=180
    ModifyGraph height={Aspect,1.8}
	ModifyGraph zero(left)=4
	Textbox/N=text0/F=0  AttachName
	if(GetallEK==0)
	setdatafolder root:EKImage_Interpolated:One_over_a
	killwaves/A/Z
	endif
	//print lowkn,highkn
	
end

Proc GetEKImagePiovera_XJZIOP(ctrlName,popNum,popStr):PopupMenuControl
	String CtrlName
	Variable PopNum
	String PopStr
	Variable PFlag=root:PROCESS:ProcessedImageFlag
	//Variable AStart=root:TempVariable:LoadingR4000Data:AngleStart
	//Variable AEnd=root:TempVariable:LoadingR4000Data:AngleEnd
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Variable GetALLEK=root:PRocess:GetALLEKV
	
	//String EKPiList=root:TempVariable:LoadingR4000Data:EKPiList
	//String EKAList=root:TempVariable:LoadingR4000Data:EKAList
	Newdatafolder/O root:EKImage_Interpolated
	//NewDatafolder/O/S root:EKImage:'1_over_A'
	//Killwaves/A/Z
	NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a
	//Killwaves/A/Z
	Setdatafolder root:OriginalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName,GraphN
	GraphN=PopStr
	String AttachName=popstr
	pauseupdate;silent 1
	ii=0
	if(GetAllEK==0)
	do
		if(stringmatch(PopStr,ProcessedImage[ii]))
			
	//do
		Setdatafolder root:OriginalData
		//if(ProcessFlag[ii]==PFlag)
			//jj=jj+1
			
			TempPhi=Phi_Angle[ii]
			
			if(TempPhi>90)
			TempPhi=180+TempPhi
			endif
			
			tempWavename=ProcessedImage[ii]
			//EKName=tempWaveName+"_PiOvera"
			//GraphN=tempWaveName+"PiOvera"
			//EKName=tempWaveName
			GraphN=tempWaveName+"PoA"//+"PA"
			EKName=tempWaveName+"PA"
			//GraphN=tempWaveName
		
			setdatafolder root:EKImage_Interpolated:Pi_over_a 
			duplicate/O root:PROCESS:$TempWaveName,tempImage
			Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
			Make/O/N=(Dimsize(tempImage,0)) EE
			
			PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
			//MinE=leftx(TempImage)
			MinE=dimoffset(TempImage,0)
			//MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			MaxE=dimoffset(Tempimage,0)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			//print MinE,MaxE
			//SetScale/I x MinE,MaxE,"", EE
			SetScale/I x MinE,MaxE, EE
			EE=x
			MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			//print MaxK
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)-1])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)-1])))
			MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			//print MaxK
			MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)-1])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)-1])))
			//print MaxK,minK
			MaxK=0.5118*LatticeConstant/pi*MaxK
			MinK=0.5118*LatticeConstant/pi*MinK
			//print min
	
			SetScale/I x MinK,MaxK,KK
			Variable DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
			//print deltaK
			kk=x
			Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
			jj=0
			Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
			PhiAngle=tempPhi-PhiOffset-PhiAngle
			//variable kkk=0
			do
				MDCIntensity=TempImage[jj][p]
				MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
				
				
				Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
				lowKn=round((MDCKp[0]-kk[0])/deltaK)
				HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				tempMDC[0,highkn-1]=NaN
				tempMDC[lowkn+1,dimsize(tempMDC,0)-1]=NaN
				
				
				//if(abs(EE[jj]+0.004)<=0.001)
				//display tempMDC
				//display MDCIntensity
				//abort
				//endif
				reverse TempMDC
				$EKName[][jj]=TempMDC[p]
				//SetScale/I x minK,maxk, $EKName
				SetScale/I x maxK,mink, $EKName
				//SetScale/I x -maxK,-mink, $EKName
				if(TempPhi>90)
				SetScale/I x -maxK,-mink, $EKName
				endif
				
				SetScale/I y minE,maxE, $EKName
			
				jj=jj+1
			while(jj<Dimsize(TempImage,0))
		
			
			attachName=EKName
			PopStr=EKName
			Break
		endif
		ii=ii+1
	while(ii<loops)
	endif
	setdatafolder root:EKImage_Interpolated:Pi_over_a
	print GraphN
	dowindow $GraphN
	if(V_flag==0)
	Display; AppendImage $popStr
	DoWindow/C $GraphN

	ModifyImage $PopStr ctab= {*,*,PlanetEarth,1}
	ModifyGraph fStyle=1,fSize=18,axThick=1.5,standoff=0;//DelayUpdate
	Label left "E-E\\BF \\M(eV)";DelayUpdate
	Label bottom "K\\B// \\M(\\F'Symbol'p/\\F'Arial'a)"
	ModifyGraph tick=2
	ModifyGraph margin(left)=60,margin(bottom)=45, margin(top)=7,margin(right)=7
	ModifyGraph width=198.425
	ModifyGraph height={Aspect,1.8}
//	ModifyGraph width=226.772
//	ModifyGraph height=425.197
	ModifyGraph zero(left)=4
	Textbox/N=text0/F=0  AttachName
	else
	DoWindow/F $GraphN
	endif
	if(GetallEK==0)
	setdatafolder root:EKImage_Interpolated:Pi_over_a
	killwaves/A/Z
	endif
	
	
	//print lowkn,highkn
	
end
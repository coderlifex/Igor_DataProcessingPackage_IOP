#pragma rtGlobals=1		// Use modern global access method.

function KxKyImage_RemoveTrace_XJZIOP(CtrlName):ButtonControl
	String CtrlName
	nvar PFlag=root:PROCESS:ProcessedImageFlag
	setdatafolder root:OriginalData
	variable loops=dimsize(ProcessFlag,0)
	variable ii=0
	String TraceKx,TraceKy
	do
		setdatafolder root:OriginalData
		wave ProcessFlag=ProcessFlag
		wave/T ProcessedImage=ProcessedImage
		if(PFlag==ProcessFlag[ii])
			TraceKx=ProcessedImage[ii]+"_Kx"
			TraceKy=ProcessedImage[ii]+"_Ky"
			RemoveFromGraph/Z $TraceKy
			//setdatafolder root:IntegratedImage:Trace
			//appendtograph $TraceKy vs $TraceKx
		endif
		ii=ii+1
	while(ii<loops)
end

function KxKyImage_Trace_XJZIOP(CtrlName):ButtonControl
	String CtrlName
	nvar PFlag=root:PROCESS:ProcessedImageFlag
	setdatafolder root:OriginalData
	variable loops=dimsize(ProcessFlag,0)
	variable ii=0
	String TraceKx,TraceKy
	do
		setdatafolder root:OriginalData
		wave ProcessFlag=ProcessFlag
		wave/T ProcessedImage=ProcessedImage
		if(PFlag==ProcessFlag[ii])
			TraceKx=ProcessedImage[ii]+"_Kx"
			TraceKy=ProcessedImage[ii]+"_Ky"
			setdatafolder root:IntegratedImage:Trace
			appendtograph $TraceKy vs $TraceKx
//			ModifyGraph mode($TraceKy)=3;DelayUpdate
			ModifyGraph rgb($TraceKy)=(34816,34816,34816);DelayUpdate
//			ModifyGraph msize($TraceKy)=1
		endif
		ii=ii+1
	while(ii<loops)
end

function KxKyImage_XJIOP(CtrlName):ButtonControl
	String CtrlName
	Variable ii=0
	Variable jj=0
	//pauseupdate;Silent 1
	//variable now=ticks
	nvar PFlag=root:PROCESS:ProcessedImageFlag
	nvar IStart=root:PROCESS:IntegrationStart
	nvar IEND=root:PROCESS:IntegrationEnd
	nvar AStart=root:PROCESS:CropStart
	nvar AEnd=root:PROCESS:CropEnd
	nvar PhotonEnergy=root:PROCESS:PhotonEnergy
	nvar WorkFunction=root:PROCESS:WorkFunction
	nvar LatticeConstant=root:PROCESS:LatticeConstant
	nvar PhiOffset=root:PROCESS:PhiOffset
	nvar ThetaOffset=root:PROCESS:ThetaOffset
	nvar OmegaOffset=root:PROCESS:OmegaOffset
	nvar IntEstart=root:PROCESS:IntegrationStart
	nvar IntEEnd=root:PROCESS:IntegrationEnd
	nvar KxStart=root:PROCESS:KxStart
	nvar KxEnd=root:PROCESS:KxEnd
	nvar KyStart=root:PROCESS:KyStart
	nvar KyEnd=root:PROCESS:KyEnd
	nvar PnKx=root:PROCESS:KxPointNumber
	nvar PnKy=root:PROCESS:KyPointNumber
	svar NamePrefixImage=root:PROCESS:SWImageName
	nvar InteFactor=root:PROCESS:InteFactor
	Variable DIMX
	
	nvar edc2d=root:PROCESS:edc2d
	nvar mdc2d=root:PROCESS:mdc2d
	nvar   SmoothTimes=root:PROCESS:MDCSmoothingTimes
	pnKy=round(abs(pnkx*(KyEnd-KyStart)/(KxEnd-KxStart)))
	//root:PROCESS:KyPointNumber=pnKy
	String TempWaveName
	setdatafolder root:OriginalData
	wave ProcessFlag=ProcessFlag
	wave/T ProcessedImage=ProcessedImage
	
	variable loops=Dimsize(ProcessFlag,0)
	do
		if(ProcessFlag[ii]==PFlag)
			jj=jj+1
			tempWavename=ProcessedImage[ii]
		endif
		ii=ii+1
	while(ii<Dimsize(ProcessFlag,0))
	
	setdatafolder root:PROCESS
	DimX=dimsize($TempWaveName,1)
	
	//MinA=Dimoffset($TemWaveName,1)
	//MaxA=TemYStart+(Dimsize($TemWaveName,1)-1)*DimDelta($TemWaveName,1)
	//duplicate $TempWaveName,TempWave
	//MatrixTranspose TempWave
	//NewDatafolder/O/S root:IntegratedImage
	//print Dimoffset($TempWaveName,1)
	make/O/N=(DIMX,jj) IntThetaPhiImage1
	SetScale/P x Dimoffset($TempWaveName,1),DimDelta($TempWaveName,1),"",IntThetaPhiImage1
	//copyscale
	matrixtranspose IntThetaPhiImage1
	ii=0
	jj=0
	variable kkk=0
	do
		setdatafolder root:OriginalData
		wave IntensityScale=IntensityScale
		
		//print 1
		if(ProcessFlag[ii]==PFlag)
			TempWavename=ProcessedImage[ii]
			setdatafolder root:PROCESS
			duplicate/O $tempWaveName,temp2DImage
			//temp2DImage*=root:OriginalData:IntensityScale[ii]
			temp2DImage*=IntensityScale[ii]
			if(edc2d)
				//duplicate/O $tempWaveName,temp2DImage
				differentiate/Dim=0 temp2DImage
				differentiate/Dim=0 temp2DImage
				smooth/E=2/Dim=0 smoothtimes,temp2DImage
			endif
			if(mdc2d)
				//duplicate/O $tempWaveName,temp2DImage
				differentiate/Dim=1 temp2DImage
				differentiate/Dim=1 temp2DImage
				smooth/E=2/Dim=1 smoothtimes,temp2DImage
			endif
			duplicate/O/R=(IStart,IEnd)(AStart,AEnd) temp2Dimage,tempImage
			//print Istart,Iend
			Integrate/DIM=0 tempImage
			Make/O/n=(Dimsize(tempImage,1)) temp1DWave
			//setscale
			temp1DWave=tempImage[dimsize(tempImage,0)-1][p]
			//IntThetaPhiImage[p][ii]=Tem1DWave
			//matrixtranspose tempImage
			//deletePoints 0,
			//IntThetaPhiImage[ii][q]=tempImage[dimsize(tempImage,0)-1][q]
			
			//IntThetaPhiImage1[jj][q]=temp1Dwave[p]
			kkk=0
			do
			IntThetaPhiImage1[jj][kkk]=temp1Dwave[kkk]
			kkk+=1
			while(kkk<Dimsize(tempImage,1))
			jj=jj+1
			
		endif
		ii=ii+1 
		setdatafolder root:OriginalData
	while(ii<loops)
	setdatafolder root:PROCESS
	killwaves tempImage,Temp1DWave,temp2Dimage
	//abort
	//killwaves/Z IntThetaPhiImage
	//setdatafolder root:ProcessedImage
	matrixtranspose IntThetaPhiImage1
	NewDatafolder/O/S root:IntegratedImage
	NewDatafolder/O/S root:IntegratedImage:Trace
	Killwaves/A/Z
	setdatafolder root:IntegratedImage
	duplicate/O root:PROCESS:IntThetaPhiImage1,IntThetaPHiImage


	
	
	setdatafolder root:PROCESS
	killwaves/Z IntThetaPhiImage1
	
	Variable DeltaKx=(KxEnd-KxStart)/(PnKx-1)
	Variable DeltaKy=(KyEnd-KyStart)/(PnKy-1)
	Variable K0=0.5118*LatticeConstant/3.1416*Sqrt(PhotonEnergy-WorkFunction)
	setdatafolder root:IntegratedImage
	String Name1=num2Str(round(abs(1000*IntEstart)))
	if(IntEStart<0)
		Name1="N"+num2Str(round(abs(1000*IntEstart)))
	endif
	String Name2=num2Str(round(abs(1000*IntEEnd)))
	if(IntEEnd<0)
		Name2="N"+num2Str(round(abs(1000*IntEEnd)))
	endif
	String KxKyImage="F"+num2str(Pflag)+NamePrefixImage+"KxKyImage_"+Name1+"meV_"+Name2+"meV"
	if(edc2d)
		KxKyImage="F"+num2str(Pflag)+NamePrefixImage+"EDC2DKxKyImage_"+Name1+"meV_"+Name2+"meV"
	endif
	if(mdc2d)
		KxKyImage="F"+num2str(Pflag)+NamePrefixImage+"MDC2DKxKyImage_"+Name1+"meV_"+Name2+"meV"
	endif
	//endif
	killwaves/z $KxKyImage
	Make/O/N=(PnKx,Pnky) $KxKyImage
	SetScale/I x KxStart,KxEnd,"", $KxKyImage
	SetScale/I y KyStart,KyEnd,"", $KxKyImage
	wave kxkyimg=$KxKyImage
	kxkyimg=0
	Make/O/N=(Dimsize(IntThetaPHiImage,0)) PhiAngle,tempPhiAngle,Kx,Ky,RKx,RKy,RKx1,RKy1
	PhiAngle=DimDelta(IntThetaPHiImage,0)*x+Dimoffset(IntThetaPHiImage,0)
	Variable DimsizePhi=Dimsize(PhiAngle,0)
	ii=0
	jj=0
	Variable kk,hh,MK,Mkx,Mky,mm
	Variable tempTheta,TempOmega,tempPhi,tempTheta1,TempOmega1,tempPhi1,key
	key=99
	String TraceKx,TraceKy
	do
		setdatafolder root:OriginalData
		wave Theta_Angle=Theta_Angle
		wave Omega_Angle=Omega_Angle
		wave Phi_Angle=Phi_Angle
		if(ProcessFlag[ii]==PFlag)
			TraceKx=ProcessedImage[ii]+"_Kx"
			TraceKy=ProcessedImage[ii]+"_Ky"
			TempTheta=Theta_Angle[ii]-ThetaOffset
			TempOmega=Omega_Angle[ii]-OmegaOffset
			tempPhi=Phi_Angle[ii]
			setdatafolder root:IntegratedImage
			tempPhiAngle=tempPhi-PhiOffset-PhiAngle
			Ky=K0*sin(3.1416/180*tempTheta)*cos(3.1416/180*(tempPhiAngle)) 
        	Kx=K0*sin(3.1416/180*(tempPhiAngle))  
			RKy=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+TempOmega*3.1416/180) 
			RKx=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+TempOmega*3.1416/180)
			
			setdatafolder root:IntegratedImage:Trace
			duplicate/O root:IntegratedImage:Rkx $TraceKx
			duplicate/O root:IntegratedImage:Rky $TraceKy
			
			setdatafolder root:IntegratedImage
			RKx=round((Rkx-KxStart)/DeltaKx)
			RKy=round((Rky-KyStart)/DeltaKy)
			//setdatafolder root:OriginalData:Experiment_Notes
			//TempTheta=Theta_Angle[ii]-ThetaOffset
			//TempOmega=Omega_Angle[ii]-OmegaOffset
			//tempPhi=Phi_Angle[ii]
			
			
			kk=0
			do
				if(kxkyimg[Rkx[kk]][Rky[kk]]==0)
					kxkyimg[Rkx[kk]][Rky[kk]]=IntThetaPHiImage[kk][jj]
				endif
				if(kxkyimg[Rkx[kk]][Rky[kk]]!=0)
					kxkyimg[Rkx[kk]][Rky[kk]]=(IntThetaPHiImage[kk][jj]+kxkyimg[Rkx[kk]][Rky[kk]])/2
				endif
				kk=kk+1
			while(kk<Dimsize(tempPhiAngle,0))
			//$KxKyImage[][
			hh=ii+1
			setdatafolder root:OriginalData
			do
				if(ProcessFlag[hh]==PFlag)
					TempTheta1=Theta_Angle[hh]-ThetaOffset
					TempOmega1=Omega_Angle[hh]-OmegaOffset
					tempPhi1=Phi_Angle[hh]
					setdatafolder root:IntegratedImage
					tempPhiAngle=tempPhi-PhiOffset-PhiAngle
					Ky=K0*sin(3.1416/180*tempTheta1)*cos(3.1416/180*(tempPhiAngle)) 
        			Kx=K0*sin(3.1416/180*(tempPhiAngle))  
					RKy1=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+TempOmega1*3.1416/180) 
					RKx1=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+TempOmega1*3.1416/180)
					RKx1=round((Rkx1-KxStart)/DeltaKx)
					RKy1=round((Rky1-KyStart)/DeltaKy)
					kk=0
					//do
					//	$KxKyImage[Rkx1[kk]][Rky1[kk]]=IntThetaPHiImage[kk][jj+1]
					//	kk=kk+1
					//while(kk<Dimsize(tempPhiAngle,0))
					break
				endif
				hh=hh+1
			while(hh<loops)
			if(hh<loops)
				//MKx=max(abs(Rkx1[0]-Rkx[0]),abs(RKx1[DimsizePhi]-RKx1[DimsizePhi]))
				//MKy=max(abs(Rky1[0]-Rky[0]),abs(RKy1[DimsizePhi]-RKy1[DimsizePhi]))
				RKx=abs(Rkx1-Rkx)
				Rky=abs(Rky1-Rky)
				MKx=MaxValueof1DWave(Rkx)
				MKy=MaxValueof1DWave(Rky)
				MK=round(InteFactor*max(MKx,MKy))
				//print Mk
				mm=1
				if(TempTheta1-TempTheta!=0)
					if(TempPHi1-TempPhi!=0)
						Key=22
					endif
					//if(TempOmega1-TempOmega!=0)
					//	Key=22
					//endif
				endif
				//if(TempPHi1-TempPhi!=0)
					//if(TempPHi1-TempPhi==0)
					//	Key=22
					//endif
					//if(TempOmega1-TempOmega!=0)
					//	Key=22
					//endif
				//endif
				kk=0
				if(key==22)
					do
						if(kxkyimg[Rkx[kk]][Rky[kk]]==0)
							kxkyimg[Rkx[kk]][Rky[kk]]=IntThetaPHiImage[kk][jj]
						endif
						if(kxkyimg[Rkx[kk]][Rky[kk]]!=0)
							kxkyimg[Rkx[kk]][Rky[kk]]=(IntThetaPHiImage[kk][jj]+kxkyimg[Rkx[kk]][Rky[kk]])/2
						endif
						kk=kk+1
					while(kk<Dimsize(tempPhiAngle,0))
				endif
				if(Key!=22)
				if(MK>1)
					do
						setdatafolder root:OriginalData
						TempTheta=mm*(Theta_Angle[hh]-Theta_Angle[ii])/MK-ThetaOffset+Theta_Angle[ii]
						TempOmega=mm*(Omega_Angle[hh]-Omega_Angle[ii])/MK-OmegaOffset+Omega_Angle[ii]
						tempPhi=mm*(Phi_Angle[hh]-Phi_Angle[ii])/MK+Phi_Angle[ii]
						setdatafolder root:IntegratedImage
						tempPhiAngle=tempPhi-PhiOffset-PhiAngle
						Ky=K0*sin(3.1416/180*tempTheta)*cos(3.1416/180*(tempPhiAngle)) 
        				Kx=K0*sin(3.1416/180*(tempPhiAngle))  
						RKy=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+TempOmega*3.1416/180) 
						RKx=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+TempOmega*3.1416/180)
						RKx=round((Rkx-KxStart)/DeltaKx)
						RKy=round((Rky-KyStart)/DeltaKy)
						kk=0
						//if(RKx>=0)
						//if(RKy>0)
						do
							if(kxkyimg[Rkx[kk]][Rky[kk]]==0)
								kxkyimg[Rkx[kk]][Rky[kk]]=(IntThetaPHiImage[kk][jj+1]-IntThetaPHiImage[kk][jj])*mm/MK+IntThetaPHiImage[kk][jj]
							endif
							if(kxkyimg[Rkx[kk]][Rky[kk]]!=0)
								kxkyimg[Rkx[kk]][Rky[kk]]=((IntThetaPHiImage[kk][jj+1]-IntThetaPHiImage[kk][jj])*mm/MK+IntThetaPHiImage[kk][jj]+kxkyimg[Rkx[kk]][Rky[kk]])/2
							endif
							//$KxKyImage[Rkx[kk]][Rky[kk]]=(IntThetaPHiImage[kk][jj+1]-IntThetaPHiImage[kk][jj])*mm/MK+IntThetaPHiImage[kk][jj]
							kk=kk+1
						while(kk<Dimsize(tempPhiAngle,0))
						//endif
						mm=mm+1
					while(mm<MK)
				endif
				
				endif
			endif
			jj=jj+1
		endif
		key=100
		ii=ii+1
	While(ii<loops)
	Setdatafolder root:IntegratedImage
	//ii=0
	//do
	//	$KxKyImage[ii] = $KxKyImage[ii]==0 ? NaN : $KxKyImage[ii]
	//	ii=ii+1
	//While(ii<numpnts($KxKyImage))
	//String GraphN=NamePrefixImage+"KxKyImage"//+num2Str(round(1000*IntEstart))+"meV"+num2Str(round(1000*intEend))+"meV"
	String TempESNAme,TempEEName
	if(intEStart<0)
		tempESName="N"+num2Str(-round(1000*IntEstart))+"meV"
	else
	   tempESName=num2Str(round(1000*IntEstart))+"meV"
	endif
	if(intEEnd<0)
		tempEEName="N"+num2Str(-round(1000*IntEEnd))+"meV"
	else
		tempEEName=num2Str(round(1000*IntEEnd))+"meV"
	endif
	String GraphN="XYImage"+"F"+num2str(Pflag)+NamePrefixImage+tempESName+"to"+TempEEName
	
	if(edc2d)
		GraphN="EDC2DXYImage"+"F"+num2str(Pflag)+NamePrefixImage+tempESName+"to"+TempEEName
	endif
	if(mdc2d)
		GraphN="MDC2DXYImage"+"F"+num2str(Pflag)+NamePrefixImage+tempESName+"to"+TempEEName
	endif
	//print graphn
	
	variable temp
	if(InteFactor==10)
		ii=0
		do
		duplicate/O $KxKyImage,tempImage
		ImageRotate/O/A=60 tempImage
		ImageRotate/O/A=-60 tempImage
		temp=(abs(cos((60)/180*pi))+abs(sin((60)/180*pi)))^2
		SetScale/I x temp*KxStart,temp*KxEnd,"", TempImage
		SetScale/I y temp*KyStart,temp*KyEnd,"", TempImage
		Duplicate/O/R=(KxStart,KxEnd)(KyStart,KyEnd) TempImage,$KxKyImage
		ii=ii+1
		print ii
		while(ii<5)
		
	endif
	killwaves/Z tempImage
	Dowindow/K $GraphN
	Display/K=1/N=$GraphN
	AppendImage $KxKyImage
	ModifyImage $KxKyImage ctab= {*,*,PlanetEarth,1}
	ModifyGraph width={Aspect,1}
	if(edc2d)
	ModifyImage $KxKyImage ctab= {*,0,PlanetEarth,0}	
	endif
	if(mdc2d)
	ModifyImage $KxKyImage ctab= {*,0,PlanetEarth,0}	
	endif
	ModifyGraph margin(left)=45,margin(bottom)=45,margin(top)=7,margin(right)=7
	killwaves/Z PhiAngle,TempPhiANgle,Kx,Ky,Rkx,Rky,Rkx1,Rky1
	TextBox/C/N=text0/F=0/A=MC num2Str(round(1000*IntEstart))+"meV~"+num2Str(round(1000*IntEEnd))+"meV"
	TextBox/C/N=text0/X=25.00/Y=35.00
	ModifyGraph tick=2,fStyle=1,fSize=16,axThick=1.5,standoff=0;DelayUpdate
	Label left "\Z18k\By\M (\\F'Symbol'p/\\F'Arial'a)";DelayUpdate
	Label bottom "\Z18k\Bx\M (\\F'Symbol'p/\\F'Arial'a)"
	SetAxis Bottom KxStart,KxEnd
	SetAxis Left KyStart,KyEnd
//print (ticks-now)/60	
end
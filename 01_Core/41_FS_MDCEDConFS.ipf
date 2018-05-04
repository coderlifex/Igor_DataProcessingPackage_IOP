#pragma rtGlobals=1		// Use modern global access method.
Proc FSMDCEDC_ZWTIOP()
	Pauseupdate;Silent 1
	dowindow/F FSMDCEDC_Panel_ZWTIOP
	if(V_Flag==0)
	variable Flag=root:PROCESS:ProcessedImageFlag
	
	NewDatafolder/O root:SchematicFermiSurface
	String TemPathData="F"+num2Str(Flag)
	NewDatafolder/O/S root:SchematicFermiSurface:$TemPathData
	
	Variable/G HoleNum
	NewDataFolder/O/S root:TempVariable
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	Newdatafolder/O/S root:TempVariable:$TemPath
	setdatafolder root:SchematicFermiSurface:$TemPathData
	if(!exists("Phi_Angle"))
	
	make/O/T/N=0 OriginalImage,ProcessedImage
	Make/O/N=0 Theta_Angle,Phi_Angle,Omega_Angle,Temperature2D,ProcessFlag,KfPoint1,Kfpoint2,Kfpoint3,Kx1,Ky1,kx2,ky2,kx3,ky3//g,EDCOrder,MDCFlag,MDCOrder
	setdatafolder root:TempVariable:$TemPath
	Make/T/O/N=0 AllWaves
	Make/O/N=0 SelWaves
	endif
	
	setdatafolder root:TempVariable:$TemPath
	Variable/G PeakNum
	Variable/G NEStart
	Variable/G NEEnd
	Variable/G AutoCheck
	variable/G MDCBind
	Variable/G MDCOffset
	Variable/G EDCOffset
	Variable/G EDCBind
	Variable/G MDCEnergy
	if(PeakNum==0)
		PeakNum=1
		NEStart=-0.4
		NEEnd=-0.3
		MDCBind=1
		EDCBind=1
	endif
	Variable/G Mapping_R//=1
	Variable/G TemperatureD_R//=0
	if(Mapping_R==TemperatureD_R)
		Mapping_R=1
		TemperatureD_R=0
	endif
	//print Mapping_R,TemperatureD_R
	
	setdatafolder root:OriginalData
	String tempWaveName,temp1,temp2
	variable ii,DIM,jj,kk,hh
	DIM=Dimsize(ProcessFlag,0)
	ii=0
	
	//print 1
	do
		
		//print 1
		setdatafolder root:OriginalData
		if(ProcessFlag[ii]==Flag)
			hh=0
			kk=0
			//print 1
			setdatafolder root:SchematicFermiSurface:$TemPathData
			if(Dimsize(ProcessedImage,0)!=0))
			//print 1
			do
			setdatafolder root:OriginalData
			temp1=ProcessedImage[ii]
			//if
			setdatafolder root:SchematicFermiSurface:$TemPathData
			temp2=ProcessedImage[hh]
			if(stringmatch(temp1,temp2))
				kk=1
			endif
			
			//print 1
			hh=hh+1
			while(hh<dimsize(ProcessedImage,0))
			endif
			if(kk!=1)
			insertpoints Dimsize(OriginalImage,0),1,OriginalImage,ProcessedImage,Theta_Angle,Phi_Angle,Omega_Angle,Temperature2D,ProcessFlag,KfPoint1,Kfpoint2,KfPoint3,Kx1,Ky1,kx2,ky2,kx3,ky3//,EDCFlag,EDCOrder,MDCFlag,MDCOrder
			OriginalImage[Dimsize(OriginalImage,0)-1]=root:OriginalData:OriginalImage[ii]
			ProcessedImage[Dimsize(OriginalImage,0)-1]=root:OriginalData:ProcessedImage[ii]
			Theta_Angle[Dimsize(OriginalImage,0)-1]=root:OriginalData:Theta_Angle[ii]
			Phi_Angle[Dimsize(OriginalImage,0)-1]=root:OriginalData:Phi_Angle[ii]
			Omega_Angle[Dimsize(OriginalImage,0)-1]=root:OriginalData:Omega_Angle[ii]
			Temperature2D[Dimsize(OriginalImage,0)-1]=root:OriginalData:Temperature2D[ii]
			ProcessFlag[Dimsize(OriginalImage,0)-1]=root:OriginalData:ProcessFlag[ii]
			//EDCflag[Dimsize(EDCFlag,0)-1]=Dimsize(EDCFlag)
			//MDCflag[Dimsize(MDCFlag,0)-1]=Dimsize(MDCFlag)
			setdatafolder root:TempVariable:$TemPath
			insertpoints Dimsize(AllWaves,0),1,AllWaves,SelWaves
			Allwaves[Dimsize(allWaves,0)-1]=root:OriginalData:ProcessedImage[ii]
			SelWaves=0
			endif
		endif
		ii=ii+1
	while(ii<DIM)
	//print 1
	//endif
	setdatafolder root:SchematicFermiSurface:$TemPathData
	//MDCOrder=x
	//EDCOrder=x
	setdatafolder root:TempVariable:$TemPath
	//selWaves[0]=1
	FSMDCEDC_Panel_ZWTIOP()
	//print 1
	ListBox ALLWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	CheckBox Mapping,value= Mapping_R
	CheckBox TemperatureD,value= TemperatureD_R
		if(Mapping_R)
			SetVariable NEStart,Disable=1
			SetVariable NEEnd, Disable=1
		endif
		if(TemperatureD_R)
			SetVariable NEStart,Disable=0
			SetVariable NEEnd, Disable=0
		endif
		if(!AutoCheck)
			checkbox CheckAuto,value=0
			checkbox mapping, disable=1
			checkbox TemperatureD, disable=1
			button GetKf_B, disable=1
		endif
	endif
end

Window FSMDCEDC_Panel_ZWTIOP():Panel
	PauseUpdate;Silent 1
	NewPanel/K=1/W=(800,0,1150,353) as "Fermi Surface, MDC and EDC on Fermi Surface"
	ModifyPanel fixedSize=1,framestyle=1
	variable Flag=root:PROCESS:ProcessedImageFlag
	//String TemPath_pe="F"+num2Str(Flag)
	String TemPath_PeakNum="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":PeakNum"
	String Tempath_NEStart="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":NEStart"
	String Tempath_NEEnd="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":NEEnd"
	String Tempath_Hole="root:SchematicFermiSurface:F"+num2str(Flag)+":HoleNum"
	DrawText 180,20,"Select for MDCs or EDCs:"
	ListBox ALLWaves_L frame= 4,pos={180,20},size={165,330}
	SetVariable PeakNum, Pos={5,5},Value=$TemPath_PeakNum,limits={1,10,1},size={150,15},title="Fermi Surface Sheets"//,proc=SelectPeakNum_FS
	Button SetTable_B,pos={5,25},size={100,25},title="Set Table",proc=SetTable_FS
	Button Refresh_B,pos={110,25},size={60,25},title="Refresh",proc=Refresh_FS
	
	GroupBox AutoGetPN,pos={3,55},size={170,105},title="Auto Get K\BF\M PN"
	GroupBox AutoGetPN,font="Arial",fSize=10,fStyle=2
	CheckBox Mapping,pos={5,70},size={50,14},proc=SelectFS_Radio,title="No Shift"
	CheckBox Mapping,value= 1,mode=1//,help={"Such as mapping, or no shift temperature dependence"}
	CheckBox TemperatureD,pos={5,90},size={50,14},proc=SelectFS_Radio,title="Shift"//,help={"Temperature dependence with no perfect sample orientation"}
	CheckBox TemperatureD,value= 0,mode=1
	Button Help_B,pos={80,75},size={30,25},title="?",proc=HelpForGetPN_FS
	Button FitAll_B,pos={115,75},size={50,25},title="FitAll",proc=FitAllImage_MDC_ZWT
	SetVariable NEStart, Pos={5,110},Value=$TemPath_NEStart,limits={-1,1,0.1},size={80,15},title="EStart"
	SetVariable NEEnd, Pos={90,110},Value=$TemPath_NEEnd,limits={-1,1,0.1},size={80,15},title="E End"
	Button GetKf_B,pos={15,130},size={100,25},title="Get K\BF\M PN",proc=GetKFPN_FS
	CheckBox CheckAuto,pos={120,130},size={50,14},proc=CheckAutoFS_Radio,title="Auto",Value=1
	
	GroupBox GetKxKy,pos={3,165},size={170,65},title="Calculating Fermi surface"
	GroupBox GetKxKy,font="Arial",fSize=10,fStyle=2
	SetVariable HoleNum, Pos={5,180},Value=$Tempath_Hole,size={100,15},title="Holes",disable=2//,limits={-1,2,0.1}
	Button CalculatingKxky_B,pos={5,200},size={100,25},title="Calculate Kx-Ky",proc=CalcuKxKy_FS//,valueColor=(65535,0,0)
	
	GroupBox MDConFermiSurface,pos={3,235},size={170,55},title="MDC on Fermi surface"
	GroupBox MDConFermiSurface,font="Arial",fSize=10,fStyle=2
	String Tempath_MDCBind="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":MDCBind"
	String Tempath_MDCOffset="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":MDCOffset"
	String Tempath_MDCEnergy="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":MDCEnergy"
	SetVariable MDCBind, Pos={5,250},Value=$Tempath_MDCBind,size={60,15},title="Bind",limits={1,21,2}//,disable=2
	SetVariable MDCOffset, Pos={70,250},Value=$Tempath_MDCOffset,size={100,15},title="Offset"//,limits={1,20,1}
	SetVariable MDCEnergy, Pos={70,270},Value=$Tempath_MDCEnergy,size={100,15},title="Energy",limits={-1,1,0.001}
	Button GetMDC_FS,pos={5,267},size={60,20},title="Get MDC",proc=GetMDConFS_FS
	//setvariable MDCprefix,pos={70,290},Value=$Tempath_MDCPrefix,size={100,15}
	
	GroupBox EDConFermiSurface,pos={3,295},size={170,55},title="EDC on Fermi surface"
	GroupBox EDConFermiSurface,font="Arial",fSize=10,fStyle=2
	String Tempath_EDCBind="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":EDCBind"
	String Tempath_EDCOffset="root:TempVariable:SchematicFermiSurface"+"_F"+num2str(Flag)+":EDCOffset"
	SetVariable EDCBind, Pos={5,310},Value=$Tempath_EDCBind,size={60,15},title="Bind",limits={1,21,2}
	SetVariable EDCOffset, Pos={70,310},Value=$Tempath_EDCOffset,size={100,15},title="Offset"//,limits={1,20,1}
	Button GetEDC_FS,pos={5,327},size={60,20},title="Get EDC",proc=GetEDConFS_FS
	Button GetSyEDC_FS,pos={70,327},size={45,20},title="SyEDC",proc=GetSyEDConFS_FS
	Button GetDFEDC_FS,pos={120,327},size={45,20},title="DFEDC",Proc=GetDFEDConFS_FS
end

proc GetDFEDConFS_FS(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	String TemPathData="F"+num2Str(Flag)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	String Datafolder="root:SchematicFermiSurface:"+TemPathData+":DFermiFuncEDC"
	newdatafolder/O :DFermiFuncEDC
	setdatafolder Datafolder
	killwaves/A/Z
	setdatafolder root:TempVariable:$TemPath
	variable tempOffset=EDCoffset
	variable tempBind=EDCBind
	Variable MaxIntensity
	variable ii,jj
	ii=0
	do
		if(selWaves[ii])
			break
		endif
		ii=ii+1
	while(ii<dimsize(SelWaves,0))
	jj=dimsize(SelWaves,0)-1
	do
		if(selWaves[jj])
			break
		endif
		jj=jj-1
	while(ii>=0)
	String GraphN="F"+num2Str(Flag)+"DFEDConFermiSurface"+num2str(ii)+num2Str(jj)
	dowindow/K $graphN
	Display/K=1/N=$GraphN
	Variable KFPN,Temperature
	String TempDataName,TempEDCName,TempName
	ii=0
	setdatafolder root:TempVariable:$TemPath
	do
		if(SelWaves[ii])
			variable offsets=ii
			break
		endif
		ii=ii+1
	while(ii<Dimsize(AllWaves,0))
	ii=0
	do
		TempDataName=AllWaves[ii]
		if(Selwaves[ii])
			setdatafolder root:SchematicFermiSurface:$TemPathData
			KFPN=KfPoint1[ii]
			Temperature=Temperature2D[ii]
			TempEDCName="EDCDF_"+TempDataName+"_"+num2str(KFPN)
			setdatafolder root:PROCESS
			make/O/N=(dimsize($TempDataName,0)) $TempEDCName
			$TempEDCName=$TempDataName[p][KFPN]
			jj=1
			do	
				if(TempBind==1)
					BreaK
				endif
				$TempEDCName+=$TempDataName[p][KFPN-jj]+$TempDataName[p][KFPN+jj][p]
				jj=jj+1
			while(jj<(tempBind+1)/2)
			$TempEDCName/=TempBind
			$TempEDCName+=(ii-offsets)*TempOffset
			SetScale/P x Dimoffset($TempDataName,0),Dimdelta($TempDataName,0),"", $TempEDCName
			if(MaxValueof1DWave($TempEDCName)>MaxIntensity)
			MaxIntensity=MaxValueof1DWave($TempEDCName)
			endif
			$TempEDCName*=exp(11594.2*x/Temperature)+1
			tempName="root:SchematicFermiSurface:"+TemPathData+":DFermiFuncEDC:"+TempEDCName
			duplicate/O $TempEDCName,$tempName
			setdatafolder Datafolder//root:SchematicFermiSurface:$TemPathData:MDC
			appendtoGraph/W=$GraphN $TempEDCName
			
			setdatafolder root:PROCESS
			killwaves/Z $TempEDCName
		endif
		ii=ii+1
		setdatafolder root:TempVariable:$TemPath
	while(ii<Dimsize(AllWaves,0))
	ModifyGraph fSize=14
	ModifyGraph mirror=2
	ModifyGraph margin(left)=85,margin(bottom)=57
	ModifyGraph zero(bottom)=3,zeroThick(bottom)=2
	Label bottom "E-E\\BF\\M (eV)"
	Label left "EDC Intensity (Arb. Units)"
	SetAxis left 0,MaxIntensity*1.2
	settable_FS("SetTable_B")
	setdatafolder root:SchematicFermiSurface:$TemPathData
	killwaves/A/Z
	killwindow Cuts_on_Fermi_Surface
	//setdatafolder root:SchematicFermiSurface:$TemPathData
end

proc GetSyEDConFS_FS(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	String TemPathData="F"+num2Str(Flag)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	String Datafolder="root:SchematicFermiSurface:"+TemPathData+":SymmetrizedEDC"
	newdatafolder/O :SymmetrizedEDC
	setdatafolder Datafolder
	killwaves/A/Z
	setdatafolder root:TempVariable:$TemPath
	variable tempOffset=EDCoffset
	variable tempBind=EDCBind
	variable XStart,XEnd,tempPN1,TempPN2
	variable ii,jj
	
	ii=0
	do
		if(selWaves[ii])
			break
		endif
		ii=ii+1
	while(ii<dimsize(SelWaves,0))
	jj=dimsize(SelWaves,0)-1
	do
		if(selWaves[jj])
			break
		endif
		jj=jj-1
	while(ii>=0)
	String GraphN="F"+num2Str(Flag)+"SyEDConFermiSurface"+num2str(ii)+num2Str(jj)
	dowindow/K $graphN
	Display/K=1/N=$GraphN
	Variable KFPN
	String TempDataName,TempEDCName,TempName
	ii=0
	do
		if(SelWaves[ii])
			variable offsets=ii
			break
		endif
		ii=ii+1
	while(ii<Dimsize(AllWaves,0))
	ii=0
	do
		TempDataName=AllWaves[ii]
		if(Selwaves[ii])
			setdatafolder root:SchematicFermiSurface:$TemPathData
			KFPN=KfPoint1[ii]
			TempEDCName="EDCS_"+TempDataName+"_"+num2str(KFPN)
			setdatafolder root:PROCESS
			make/O/N=(dimsize($TempDataName,0)) $TempEDCName//,tempx
			$TempEDCName=$TempDataName[p][KFPN]
			jj=1
			do	
				if(TempBind==1)
					BreaK
				endif
				$TempEDCName+=$TempDataName[p][KFPN-jj]+$TempDataName[p][KFPN+jj][p]
				jj=jj+1
			while(jj<(tempBind+1)/2)
			$TempEDCName/=TempBind
			
			SetScale/P x Dimoffset($TempDataName,0),Dimdelta($TempDataName,0),"", $TempEDCName//,tempx
			//tempx=x
			XStart=ceil((leftx($TempEDCName))/dimdelta($TempEDCName,0))*dimdelta($TempEDCName,0)
			
			XEnd=floor((rightx($TempEDCName)-dimdelta($TempEDCName,0))/dimdelta($TempEDCName,0))*dimdelta($TempEDCName,0)
			//print
			//print (rightx($TempEDCName)
			TempPN1=(XEnd-XStart)/dimdelta($TempEDCName,0)
			TempPN2=(-XStart-XEnd)/dimdelta($TempEDCName,0)
			//print XStart,XEnd
			//make/O/N=((XEnd-XStart)/dimoffset($TempEDCName,0)+;1) XWave1,XWave2
			make/O/N=(-2*XStart/dimdelta($TempEDCName,0)+1) SyEDC,TempEDC1,TEmpEDC2
			SetScale/I x XStart,-XSTart,"", SyEDC,TempEDC1
			SetScale/I x -XStart,XStart,"", TempEDC2
			//Xwave1=x
			//Xwave2=x
			//TempEDC1=0
			//TempEDC2=0
			//Interpolate2/T=2/E=2/I=3/X=XWave1/Y=TempEDC1 $TempEDCName
			Interpolate2/T=2/E=2/I=3/Y=TempEDC1/J=0 $TempEDCName
			Interpolate2/T=2/E=2/I=3/Y=TempEDC2/J=0 $TempEDCName
			TempEDC1[tempPN1,dimsize(TempEDC1,0)]=0
			TempEDC2[0,TempPN2]=0
			SyEDC=TempEDC1+TempEDC2
			duplicate/O SyEDC,$TempEDCName
			$TempEDCName+=(ii-offsets)*TempOffset
			killwaves/Z TempEDC1,TempEDC2,SyEDC
			//SetScale/P x Dimoffset($TempDataName,0),Dimdelta($TempDataName,0),"", $TempEDCName
			tempName="root:SchematicFermiSurface:"+TemPathData+":SymmetrizedEDC:"+TempEDCName
			duplicate/O $TempEDCName,$tempName
			setdatafolder Datafolder//root:SchematicFermiSurface:$TemPathData:MDC
			appendtoGraph/W=$GraphN $TempEDCName
			
			setdatafolder root:PROCESS
			killwaves/Z $TempEDCName
		endif
		ii=ii+1
		setdatafolder root:TempVariable:$TemPath
	while(ii<Dimsize(AllWaves,0))
	ModifyGraph fSize=14
	ModifyGraph mirror=2
	ModifyGraph margin(left)=85,margin(bottom)=57
	ModifyGraph zero(bottom)=3,zeroThick(bottom)=2
	Label bottom "E-E\\BF\\M (eV)"
	Label left "EDC Intensity (Arb. Units)"
	settable_FS("SetTable_B")
	setdatafolder root:SchematicFermiSurface:$TemPathData
	killwaves/A/Z
	killwindow Cuts_on_Fermi_Surface
	//setdatafolder root:SchematicFermiSurface:$TemPathData
end

proc GetEDConFS_FS(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	String TemPathData="F"+num2Str(Flag)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	String Datafolder="root:SchematicFermiSurface:"+TemPathData+":OriginalEDC"
	newdatafolder/O :OriginalEDC
	setdatafolder Datafolder
	killwaves/A/Z
	setdatafolder root:TempVariable:$TemPath
	variable tempOffset=EDCoffset
	variable tempBind=EDCBind
	variable ii,jj
	ii=0
	do
		if(selWaves[ii])
			break
		endif
		ii=ii+1
	while(ii<dimsize(SelWaves,0))
	jj=dimsize(SelWaves,0)-1
	do
		if(selWaves[jj])
			break
		endif
		jj=jj-1
	while(ii>=0)
	String GraphN="F"+num2Str(Flag)+"OEDConFermiSurface"+num2str(ii)+num2Str(jj)
	dowindow/K $graphN
	Display/K=1/N=$GraphN
	Variable KFPN
	String TempDataName,TempEDCName,TempName
	ii=0
	do
		if(SelWaves[ii])
			variable offsets=ii
			break
		endif
		ii=ii+1
	while(ii<Dimsize(AllWaves,0))
	ii=0
	do
		TempDataName=AllWaves[ii]
		if(Selwaves[ii])
			setdatafolder root:SchematicFermiSurface:$TemPathData
			KFPN=KfPoint1[ii]
			TempEDCName="EDC_"+TempDataName+"_"+num2str(KFPN)
			setdatafolder root:PROCESS
			make/O/N=(dimsize($TempDataName,0)) $TempEDCName
			$TempEDCName=$TempDataName[p][KFPN]
			jj=1
			do	
				if(TempBind==1)
					BreaK
				endif
				$TempEDCName+=$TempDataName[p][KFPN-jj]+$TempDataName[p][KFPN+jj][p]
				jj=jj+1
			while(jj<(tempBind+1)/2)
			$TempEDCName/=TempBind
			$TempEDCName+=(ii-offsets)*TempOffset
			SetScale/P x Dimoffset($TempDataName,0),Dimdelta($TempDataName,0),"", $TempEDCName
			tempName="root:SchematicFermiSurface:"+TemPathData+":OriginalEDC:"+TempEDCName
			duplicate/O $TempEDCName,$tempName
			setdatafolder Datafolder//root:SchematicFermiSurface:$TemPathData:MDC
			appendtoGraph/W=$GraphN $TempEDCName
			
			setdatafolder root:PROCESS
			killwaves/Z $TempEDCName
		endif
		ii=ii+1
		
		setdatafolder root:TempVariable:$TemPath
	while(ii<Dimsize(AllWaves,0))
	ModifyGraph fSize=14
	ModifyGraph mirror=2
	ModifyGraph margin(left)=85,margin(bottom)=57
	ModifyGraph zero(bottom)=3,zeroThick(bottom)=2
	Label bottom "E-E\\BF\\M (eV)"
	Label left "EDC Intensity (Arb. Units)"
	settable_FS("SetTable_B")
	setdatafolder root:SchematicFermiSurface:$TemPathData
	killwaves/A/Z
	killwindow Cuts_on_Fermi_Surface
	//setdatafolder root:SchematicFermiSurface:$TemPathData
end

proc GetMDConFS_FS(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	String TemPathData="F"+num2Str(Flag)
	Variable PhiOffset=root:PROCESS:PhiOffset
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable WorkFunction=root:PROCESS:WorkFunction
	
	setdatafolder root:SchematicFermiSurface:$TemPathData
	String TempDataName=ProcessedImage[0]
	setdatafolder root:PROCESS
	variable temDIM=Dimsize($TempDataName,1)
	//print temDim
	Variable TemOffset=Dimoffset($TempDataName,1)
	variable temDelta=Dimdelta($TempDataName,1)
	String Datafolder="root:SchematicFermiSurface:"+TemPathData+":MDC"
	setdatafolder root:SchematicFermiSurface:$TemPathData
	newdatafolder/O/S :MDC//Datafolder//root:SchematicFermiSurface:$TemPathData:MDC
	killwaves/A/Z
	setdatafolder root:SchematicFermiSurface:$TemPathData
	Make/O/N=(temDIM) AngleY,AngleY1
	AngleY1=temDelta*x+temOffset
	
	Variable Phi
	setdatafolder root:TempVariable:$TemPath
	variable ii,jj,PE
	ii=0
	do
		if(selWaves[ii])
			break
		endif
		ii=ii+1
	while(ii<dimsize(SelWaves,0))
	jj=dimsize(SelWaves,0)-1
	do
		if(selWaves[jj])
			break
		endif
		jj=jj-1
	while(ii>=0)
	variable tempOffset=MDCoffset
	variable tempBind=MDCBind
	Variable tempEnergy=MDCEnergy
	//String TempName
	String MDCKp,MDCI,tempName
	String GraphN="F"+num2Str(Flag)+"MDConFermiSurface"+num2str(ii)+num2Str(jj)
	//str2num(ii)
	//str2num(jj)
	
	//dowindow/K $graphN
	
	Display/K=1/N=$GraphN
	//if(V_flag)
	//	GraphN="F"+num2Str(Flag)+"MDConFermiSurface"+"N"
	//endif
	//dowindow/F $graphN
	//if(V_Flag)
	//Variable jj,PE
	ii=0
	do
		if(SelWaves[ii])
			TempDataName=AllWaves[ii]
			setdatafolder root:SchematicFermiSurface:$TemPathData
			Phi=Phi_Angle[ii]
			AngleY=PHi-PhiOffset-AngleY1
			if(tempENergy<0)
			MDCKp="MDCKN"+num2str(round(-tempEnergy*1000))+"meV_"+TempDataName
			MDCI="MDCIN"+num2str(round(-TempEnergy*1000))+"meV_"+TempDataName
			else
			MDCKp="MDCK"+num2str(round(tempEnergy*1000))+"meV_"+TempDataName
			MDCI="MDCI"+num2str(round(TempEnergy*1000))+"meV_"+TempDataName
			endif
			make/O/N=(dimsize(AngleY1,0)) $MDCKp
			$MDCKp=0.5118*sqrt(PhotonEnergy-WorkFunction+tempEnergy)*sin(AngleY*pi/180)
			tempName="root:SchematicFermiSurface:"+TemPathData+":MDC:"+MDCKp
			duplicate/O $MDCKp,$tempName//root:SchematicFermiSurface:$TemPathData:MDC
			setdatafolder root:SchematicFermiSurface:$TemPathData
			killwaves/Z $MDCKp 
			setdatafolder root:PROCESS
			make/O/N=(dimsize($TempDataName,1)) $MDCI
			PE=round((tempEnergy-leftx($TempDataName))/dimdelta($TempDataName,0))
			$MDCI=$TempDataName[PE][p]
			jj=1
			do
				if(TempBind==1)
					Break
				endif
				$MDCI+=$TempDataName[PE-jj][p]+$TempDataName[PE+jj][p]
				jj=jj+1
			while(jj<(tempBind+1)/2)
			$MDCI/=tempBind
			$MDCI+=ii*tempOffset
			TempName="root:SchematicFermiSurface:"+TemPathData+":MDC:"+MDCI
			duplicate/O $MDCI,$tempName
			//movewave $MDCI,root:SchematicFermiSurface://$TemPathData:
			//setdatafolder root:SchematicFermiSurface
			//movewave $MDCI,$TemPathData:
			//setdatafolder root:SchematicFermiSurface:$TemPathData//:MDC
			//movewave $MDCI,:MDC:
			setdatafolder Datafolder//root:SchematicFermiSurface:$TemPathData:MDC
			appendtoGraph/W=$GraphN $MDCI vs $MDCKp
			//setdatafolder root:SchematicFermiSurface:$TemPathData:MDC
		endif	
			setdatafolder root:TempVariable:$TemPath
		ii=ii+1
	while(ii<dimsize(AllWaves,0))
	ModifyGraph mirror=2
	ModifyGraph margin(bottom)=57
	ModifyGraph margin(left)=71
	Label bottom "Momentum (1/A)"
	Label left "MDC Intensity (Arb. Units)"
	ModifyGraph fSize=14
	setdatafolder root:PROCESS
	String KillList=WaveList("*", ";", "DIMS:1" )
	Variable WaveNum=ItemsInList(KillList,";")
	ii=0
	do
		TempDataName=StringFromList(ii,KillList,";")
		killwaves/Z $TempDataName
		ii=ii+1
	while(ii<WaveNum)
	settable_FS("SetTable_B")
	setdatafolder root:SchematicFermiSurface:$TemPathData
	killwaves/A/Z
	//killwindow Cuts_on_Fermi_Surface
end

function CheckAutoFS_Radio(name,value)
	String name
	variable value
	if(Value==0)
		checkbox mapping, disable=1
		checkbox TemperatureD, disable=1
		button GetKf_B, disable=1
	endif
	if(Value==1)
		checkbox mapping, disable=0
		checkbox TemperatureD, disable=0
		button GetKf_B, disable=0
	endif
	nvar Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	setdatafolder root:TempVariable:$TemPath
	nvar AutoCheck
	AutoCheck=value
end

proc CalcuKxKy_FS(CtrlName):Buttoncontrol
	String CtrlName
	pauseupdate;silent 1
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Variable ThetaOffset=root:PROCESS:ThetaOffset
	Variable OmegaOffset=root:PROCESS:OmegaOffset
	
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	setdatafolder root:TempVariable:$TemPath
	variable temPeakNum=PeakNum
	String TemPathData="F"+num2Str(Flag)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	
	//String TemPathData="F"+num2Str(Flag)
	String TempDataName=ProcessedImage[0]
	setdatafolder root:PROCESS
	variable temDIM=Dimsize($TempDataName,1)
	Variable TemOffset=Dimoffset($TempDataName,1)
	variable temDelta=Dimdelta($TempDataName,1)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	Make/O/N=(temDIM) AngleY
	AngleY=temDelta*x+temOffset
	//AngleY=TempPhi-PhiOffset-AngleY
	//movewave AngleY
	Variable K0=0.5118*LatticeConstant/Pi*Sqrt(PhotonEnergy-WorkFunction)
	variable TempKy,TempKx
	variable ii
	do
		//if(temPeakNum==1)
			TempKx=K0*sin(pi/180*(Phi_Angle[ii]-PhiOffset-AngleY[KFPoint1[ii]]))
			TempKy=K0*sin(pi/180*(Theta_Angle[ii]-ThetaOffset))*cos(pi/180*(Phi_Angle[ii]-PhiOffset-AngleY[KFPoint1[ii]]))
			ky1[ii]=sqrt(TempKy*TempKy+TempKx*TempKx)*sin((atan2(TempKy,TempKx))+(Omega_Angle[ii]-OmegaOffset)*Pi/180)
			kx1[ii]=sqrt(TempKy*TempKy+TempKx*TempKx)*cos((atan2(TempKy,TempKx))+(Omega_Angle[ii]-OmegaOffset)*Pi/180)
	//print graphn
		//endif
		if(temPeakNum==2)
			TempKx=K0*sin(pi/180*(Phi_Angle[ii]-PhiOffset-AngleY[KFPoint2[ii]]))
			TempKy=K0*sin(pi/180*(Theta_Angle[ii]-ThetaOffset))*cos(pi/180*(Phi_Angle[ii]-PhiOffset-AngleY[KFPoint2[ii]]))
			ky2[ii]=sqrt(TempKy*TempKy+TempKx*TempKx)*sin((atan2(TempKy,TempKx))+(Omega_Angle[ii]-OmegaOffset)*Pi/180)
			kx2[ii]=sqrt(TempKy*TempKy+TempKx*TempKx)*cos((atan2(TempKy,TempKx))+(Omega_Angle[ii]-OmegaOffset)*Pi/180)
		endif
		if(temPeakNum==3)
			TempKx=K0*sin(pi/180*(Phi_Angle[ii]-PhiOffset-AngleY[KFPoint3[ii]]))
			TempKy=K0*sin(pi/180*(Theta_Angle[ii]-ThetaOffset))*cos(pi/180*(Phi_Angle[ii]-PhiOffset-AngleY[KFPoint3[ii]]))
			ky3[ii]=sqrt(TempKy*TempKy+TempKx*TempKx)*sin((atan2(TempKy,TempKx))+(Omega_Angle[ii]-OmegaOffset)*Pi/180)
			kx3[ii]=sqrt(TempKy*TempKy+TempKx*TempKx)*cos((atan2(TempKy,TempKx))+(Omega_Angle[ii]-OmegaOffset)*Pi/180)
		endif
		ii=ii+1
	while(ii<Dimsize(ProcessedImage,0))
		Variable PFlag=root:PROCESS:ProcessedImageFlag
		Variable IntEstart=root:PROCESS:IntegrationStart
		Variable IntEEnd=root:PROCESS:IntegrationEnd
		String NamePrefixImage=root:PROCESS:SWImageName
		Variable edc2d=root:PROCESS:edc2d
		Variable mdc2d=root:PROCESS:mdc2d
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
	if(temPeakNum==1)
		Dowindow/F $GraphN
		if(V_Flag==1)
			removefromgraph/z ky1
			appendtograph Ky1 vs Kx1
			ModifyGraph mode=3,marker=8
			if(temPeakNum==2)
				removefromgraph/z ky2
				appendtograph Ky2 vs Kx2
				ModifyGraph mode=3,marker=8
			endif
			if(temPeakNum==3)
				removefromgraph/z ky3
				appendtograph Ky3 vs Kx3
				ModifyGraph mode=3,marker=8
			endif
			
		else
			dowindow/K KxKy
			Display/K=1/N=KxKy Ky1 vs Kx1
			ModifyGraph mode=3,marker=8
			if(temPeakNum==2)
				removefromgraph/z ky2
				appendtograph Ky2 vs Kx2
				ModifyGraph mode=3,marker=8
			endif
			if(temPeakNum==3)
				removefromgraph/z ky3
				appendtograph Ky3 vs Kx3
				ModifyGraph mode=3,marker=8
			endif
		endif
		make/O/D/N=5 C
		C[0]=0.89
		C[1]=0.002
		C[2]=0.002
		C[3]=0.0004
		C[4]=0.0012
		duplicate/O Kx1,rr
		duplicate/O Kx1,theta
		rr=sqrt((1-Kx1)^2+(1-Ky1)^2)
		theta=atan((1-Ky1)/(1-kx1))
		dowindow/K rr_theta
		display/K=1/N=rr_Theta
		appendtograph rr vs theta
		SetAxis bottom 0,2*pi
		Funcfit/X=1/N=1/Q=1/ODR=0/NTHR=0/H="00000" FSFitting C rr /X=Theta /D
		killwindow rr_Theta
		make/O/N=5000 Fit_Kx,Fit_Ky
		SetScale/I x 0,2*pi,"", Fit_Kx,Fit_Ky
		Fit_kx=1-(C[0]+C[1]*cos(4*x)+C[2]*cos(8*x)+C[3]*cos(12*x)+C[4]*cos(16*x))*cos(x)
		Fit_Ky=1-(C[0]+C[1]*cos(4*x)+C[2]*cos(8*x)+C[3]*cos(12*x)+C[4]*cos(16*x))*sin(x)
		dowindow/F $GraphN
		removefromgraph/Z Fit_Ky
		if(V_Flag==1)
		appendtograph/w=$GraphN Fit_Ky vs Fit_Kx
		else
		appendtograph/w=KxKy Fit_Ky vs Fit_Kx
		endif
		ModifyGraph rgb(Fit_Ky)=(0,0,0)
		ModifyGraph lsize(Fit_Ky)=2
		ReorderTraces Ky1,{Fit_Ky}
		Variable/G HoleNum=1-2*(1-integrate1D(IntegrateFSFitting,0,pi/2))
	endif
	//print integrate1D(IntegrateFSFitting,0,pi/2)
	settable_FS("SetTable_B")
	setdatafolder root:SchematicFermiSurface:$TemPathData
	killwaves/A/Z
	killwindow Cuts_on_Fermi_Surface
	//setdatafolder root:TempVariable:$TemPath
	//
end

Proc HelpForGetPN_FS(CtrlName):ButtonControl
	String CtrlName
	DoWindow/F HelpforselectPN
	if (V_Flag==0)
		String txt
		NewNotebook/W=(100,100,600,400)/F=1/N=HelpforselectPN
		Notebook HelpforselectPN, showruler=0, backRGB=(45000,65535,65535)
		
		Notebook HelpforselectPN, fstyle=0, text="¡ñWhen you do Fermi surface mapping, select 'No Shift' radio button.\r\r"
		
		Notebook HelpforselectPN, fstyle=0, text="¡ñWhen you do temperature dependence experiments, sometimes the orientation of the sample is not very perfect when warming the sample. you can select 'Shift' radio button to reduce the error of the selection of Fermi momentum. This method calls for a reference at higher energy where dispersion should not evolve with temprature.\r\r"
		
		Notebook HelpforselectPN, fstyle=0, text="¡ñIf you have any problem, please contact",fstyle=1, text=" WTZero@gmail.com\r\r"
	
	endif
end

Proc GetKFPN_FS(CtrlName):ButtonControl
	String CtrlName
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	setdatafolder root:TempVariable:$TemPath
	variable temPeakNum=PeakNum
	Variable PNMode=Mapping_R
	Variable EStart=NEStart
	Variable EEnd=NEEnd
	
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable WorkFunction=root:PROCESS:WorkFunction
	variable PHIOffset=root:PROCESS:PhiOffset
	Variable KStart=root:MDCSpectra:DispersionMomentumStart
	Variable KEnd=root:MDCSpectra:DispersionMomentumEnd
	
	//variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPathData="F"+num2Str(Flag)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	variable DIM=Dimsize(ProcessFlag,0)
	Variable DeltaE,E0,TempPhi,tempKStart,TempKEnd,tempPN
	String TempDataName,TempMDCI,TempMDCK
	
	Variable w0,w1,w2,w3,w4,w5, w6, w7, w8, w9, w10
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
	setdatafolder root:PROCESS
	Make/O co_OnePeak={w0, w1, w2,w3,w4}
    Make/O co_TwoPeak={w0, w1, w2,w3,w4,w5,w6,w7}     
    Make/O co_ThreePeak={w0, w1, w2,w3,w4,w5,w6,w7,w8,w9,w10}   
    Redimension/D co_OnePeak;DelayUpdate
    Redimension/D co_TwoPeak;DelayUpdate
    Redimension/D co_ThreePeak
    Variable jj
	variable ii=0
		
	if(PNMode)
	do
		setdatafolder root:SchematicFermiSurface:$TemPathData
		TempDataName=ProcessedImage[ii]
		TempPHi=Phi_Angle[ii]
		setdatafolder root:PROCESS
		deltaE=Deltax($TempDataName)
		E0=Leftx($TempDataName)
		E0=round(-E0/DeltaE)
		//print TempDataName
		TempMDCI="TempMDCI"+num2str(ii)
		TempMDCK="TempMDCK"+num2str(ii)
		Make/O/N=(dimsize($TempDataName,1)) AngleY,$TempMDCI,$TempMDCK
		AngleY=Dimdelta($TempDataName,1)*x+Dimoffset($TempDataName,1)
		AngleY=TempPhi-PhiOffset-AngleY
		
		$TempMDCK=0.5118*sqrt(PhotonEnergy-WorkFunction)*sin(AngleY*pi/180)
		$TempMDCI=$TempDataName[E0][p]
		//if(PNMode)
		display/K=1 $TempMDCI vs $tempMDCK
		if(KStart>$TempMDCK[dimsize($TempMDCK,0)-1])
			findlevel/Q $TempMDCK,KStart
			tempKStart=round(V_LevelX)
		else 
			tempKStart=Dimsize($TempMDCK,0)-1
		endif
		if(KEnd<$TempMDCK[0])
			findlevel/Q $TempMDCK,KEnd
			tempKEnd=round(V_LevelX)
		else
			tempKEnd=0
			//print "aa"
		endif
		
		if(temPeakNum==1)
			
				FuncFit/N=1/Q=1 XJLorentzianFit_OnePeak co_OnePeak $TempMDCI [tempKStart,TempKEnd] /D /X=$TempMDCK
				findlevel/Q $TempMDCK,co_OnePeak[3]
				tempPN=round(V_LevelX)
				setdatafolder root:SchematicFermiSurface:$TemPathData
				KfPoint1[ii]=tempPN	
			//print PNMode
		endif
		if(temPeakNum==2)
		FuncFit/N=1/Q=1 XJLorentzianFit_TwoPeak co_TwoPeak $TempMDCI [tempKStart,TempKEnd] /D /X=$TempMDCK
		findlevel/Q $TempMDCK,co_TwoPeak[3]
		tempPN=round(V_LevelX)
		setdatafolder root:SchematicFermiSurface:$TemPathData
		KfPoint1[ii]=tempPN
		setdatafolder root:PROCESS
		findlevel/Q $TempMDCK,co_TwoPeak[7]
		tempPN=round(V_LevelX)
		setdatafolder root:SchematicFermiSurface:$TemPathData
		KfPoint2[ii]=tempPN
		endif
		if(temPeakNum==3)
		FuncFit/N=1/Q=1 XJLorentzianFit_ThreePeak co_ThreePeak $TempMDCI [tempKStart,TempKEnd] /D /X=$TempMDCK
		findlevel/Q $TempMDCK,co_ThreePeak[3]
		tempPN=round(V_LevelX)
		setdatafolder root:SchematicFermiSurface:$TemPathData
		KfPoint1[ii]=tempPN
		Setdatafolder root:PROCESS
		findlevel/Q $TempMDCK,co_ThreePeak[7]
		tempPN=round(V_LevelX)
		setdatafolder root:SchematicFermiSurface:$TemPathData
		KfPoint2[ii]=tempPN
		Setdatafolder root:PROCESS
		findlevel/Q $TempMDCK,co_ThreePeak[10]
		tempPN=round(V_LevelX)
		setdatafolder root:SchematicFermiSurface:$TemPathData
		KfPoint3[ii]=tempPN
		endif
		//endif
		ii=ii+1
	while(ii<DIM)
	endif
	if(!PNMode)
		String ODispersion="F"+num2str(Flag)+"_Dispersion"
		String SDispersion="F"+num2str(Flag)+"_ShiftDispersion"
		dowindow/K $ODispersion
		dowindow/K $SDispersion
		setdatafolder root:SchematicFermiSurface:$TemPathData
		TempDataName=ProcessedImage[0]
		TempPHi=Phi_Angle[0]
		setdatafolder root:PROCESS
		deltaE=Deltax($TempDataName)
		E0=Leftx($TempDataName)
		E0=round(-E0/DeltaE)
		//print TempDataName
		TempMDCI="TempMDCI"+num2str(0)
		TempMDCK="TempMDCK"+num2str(0)
		Make/O/N=(dimsize($TempDataName,1)) AngleY,$TempMDCI,$TempMDCK
		AngleY=Dimdelta($TempDataName,1)*x+Dimoffset($TempDataName,1)
		AngleY=TempPhi-PhiOffset-AngleY
		
		$TempMDCK=latticeConstant/pi*0.5118*sqrt(PhotonEnergy-WorkFunction)*sin(AngleY*pi/180)
		//$TempMDCI=$TempDataName[E0][p]
		//duplicate
	
	
		Display/K=1/N=$ODispersion
		Display/K=1/N=$SDispersion
		setdatafolder root:SchematicFermiSurface:$TemPathData
		Variable KF//,K
		ii=0
		jj=0
		do
			if(Temperature2D[ii]>jj)
				jj=Temperature2D[ii]
				//kk=ii
			endif
			ii=ii+1
		while(ii<DIM)
		String TemPosition="Psn1"+ProcessedImage[jj]
		String TempE="Ey"+ProcessedImage[jj]
		setdatafolder root:MDCFittedParameters
		findlevel/Q $TempE,0
		tempPN=round(V_LevelX)
		KF=$TemPosition[TempPN]
		//setdatafolder root:SchematicFermiSurface:$TemPathData
		Variable TempPNStart,TempPNEnd,K_Ref,K_temp//,KF_Temp
		findlevel/Q $TempE,EStart
		TempPNStart=round(V_LevelX)
		findLevel/Q $TempE,EEnd
		TempPNEnd=round(V_LevelX)
		K_Ref=sum($TemPosition,TempPNStart,TempPNEnd)/(abs(TempPNEnd-TempPNStart)+1)
		//print tempPNStart,TempPNEnd
		ii=0
		do
			setdatafolder root:SchematicFermiSurface:$TemPathData
			TemPosition="Psn1"+ProcessedImage[ii]
			TempE="Ey"+ProcessedImage[ii]
			setdatafolder root:MDCFittedParameters
			K_temp=sum($TemPosition,TempPNStart,TempPNEnd)/(abs(TempPNEnd-TempPNStart)+1)
			AppendToGraph/W=$ODispersion $TempE vs $TemPosition
			AppendtoGraph/W=$SDispersion $TempE vs $TemPosition
			ModifyGraph/W=$SDispersion offset($TempE)={(-K_temp+K_Ref),0}
			setdatafolder root:PROCESS
			//print $TempMDCK
			//print K_Temp-K_Ref,KF
			findlevel/Q $TempMDCK,(KF+K_Temp-K_Ref)
			//print round(V_LevelX)
			setdatafolder root:SchematicFermiSurface:$TemPathData
			KfPoint1[ii]=round(V_LevelX)
			//KF_Temp=K_
			ii=ii+1
		while(ii<DIM)	
	endif
	//print jj
end

Function SelectFS_Radio(name,value)
	String name
	Variable value	
	nvar Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	setdatafolder root:TempVariable:$TemPath
	
	nvar Mapping_R
	nvar TemperatureD_R

	
	strswitch (name)
		case "Mapping":
			Mapping_R= 1
			TemperatureD_R=0
			break
		case "TemperatureD":
			Mapping_R= 0
			TemperatureD_R=1
			break

	endswitch
	CheckBox Mapping,value= Mapping_R
	CheckBox TemperatureD,value= TemperatureD_R
	if(Mapping_R)
			SetVariable NEStart,Disable=1
			SetVariable NEEnd, Disable=1
		endif
	if(TemperatureD_R)
		SetVariable NEStart,Disable=0
		SetVariable NEEnd, Disable=0
	endif

End

proc Refresh_FS(CtrlName):ButtonControl
	String CtrlName
	Pauseupdate;Silent 1
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPathData="F"+num2Str(Flag)
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	setdatafolder root:OriginalData
	String tempWaveName,temp1,temp2
	variable ii,DIM,jj,kk,hh
	DIM=Dimsize(ProcessFlag,0)
	ii=0
	
	//print 1
	do
		
		//print 1
		setdatafolder root:OriginalData
		if(ProcessFlag[ii]==Flag)
			hh=0
			kk=0
			//print 1
			setdatafolder root:SchematicFermiSurface:$TemPathData
			if(Dimsize(ProcessedImage,0)!=0))
			//print 1
			do
			setdatafolder root:OriginalData
			temp1=ProcessedImage[ii]
			//if
			setdatafolder root:SchematicFermiSurface:$TemPathData
			temp2=ProcessedImage[hh]
			if(stringmatch(temp1,temp2))
				kk=1
			endif
			
			//print 1
			hh=hh+1
			while(hh<dimsize(ProcessedImage,0))
			endif
			if(kk!=1)
			insertpoints Dimsize(OriginalImage,0),1,OriginalImage,ProcessedImage,Theta_Angle,Phi_Angle,Omega_Angle,Temperature2D,ProcessFlag,KfPoint1,Kfpoint2,KfPoint3,Kx1,Ky1,kx2,ky2,kx3,ky3//,EDCFlag,EDCOrder,MDCFlag,MDCOrder
			OriginalImage[Dimsize(OriginalImage,0)-1]=root:OriginalData:OriginalImage[ii]
			ProcessedImage[Dimsize(OriginalImage,0)-1]=root:OriginalData:ProcessedImage[ii]
			Theta_Angle[Dimsize(OriginalImage,0)-1]=root:OriginalData:Theta_Angle[ii]
			Phi_Angle[Dimsize(OriginalImage,0)-1]=root:OriginalData:Phi_Angle[ii]
			Omega_Angle[Dimsize(OriginalImage,0)-1]=root:OriginalData:Omega_Angle[ii]
			Temperature2D[Dimsize(OriginalImage,0)-1]=root:OriginalData:Temperature2D[ii]
			ProcessFlag[Dimsize(OriginalImage,0)-1]=root:OriginalData:ProcessFlag[ii]

			setdatafolder root:TempVariable:$TemPath
			insertpoints Dimsize(AllWaves,0),1,AllWaves,SelWaves
			Allwaves[Dimsize(allWaves,0)-1]=root:OriginalData:ProcessedImage[ii]
			SelWaves=0
			endif
		endif
		ii=ii+1
	while(ii<DIM)
	//print 1
	//endif
	setdatafolder root:SchematicFermiSurface:$TemPathData
	//MDCOrder=x
	//EDCOrder=x
	setdatafolder root:TempVariable:$TemPath
	//selWaves[0]=1
End

Proc SetTable_FS(CtrlName):ButtonControl
	String CtrlName
	
	variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPath="SchematicFermiSurface"+"_F"+num2str(Flag)
	setdatafolder root:TempVariable:$TemPath
	variable temPeakNum=PeakNum
	//String TableName="Cuts_on_Fermi_Surface"
	Dowindow/K Cuts_on_Fermi_Surface
	//variable Flag=root:PROCESS:ProcessedImageFlag
	String TemPathData="F"+num2Str(Flag)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	Edit as "Cuts_on_Fermi_Surface"
	AppendtoTable KfPoint1
	if(tempeaknum==1)
	AppendToTable  Theta_Angle,Temperature2D,Kx1,ky1,Phi_Angle,Omega_Angle,OriginalImage,ProcessedImage,ProcessFlag//,EDCFlag,MDCFlag
	endif
	if(tempeaknum==2)
	AppendToTable  KfPoint2,Theta_Angle,Temperature2D,Kx1,ky1,Kx2,ky2,Phi_Angle,Omega_Angle,OriginalImage,ProcessedImage,ProcessFlag//,EDCFlag,MDCFlag
	endif
	if(tempeaknum==3)
	AppendToTable  KfPoint2,Kfpoint3,Theta_Angle,Temperature2D,Kx1,ky1,Kx2,ky2,kx3,ky3,Phi_Angle,Omega_Angle,OriginalImage,ProcessedImage,ProcessFlag//,EDCFlag,MDCFlag
	endif
	//EDCFlag=x
	//MDCFlag=x
	DoWindow/C Cuts_on_Fermi_Surface
end

//Proc SelectPeakNum_FS(CtrlName)
Function FSFitting(C,x)
	Wave C
	variable x
	return C[0]+C[1]*cos(4*x)+C[2]*cos(8*x)+C[3]*cos(12*x)+C[4]*cos(16*x)
end

Function IntegrateFSFitting(x)
	//Wave C
	variable x
	nvar Flag=root:PROCESS:ProcessedImageFlag
	String TemPathData="F"+num2Str(Flag)
	setdatafolder root:SchematicFermiSurface:$TemPathData
	wave C
	return (C[0]+C[1]*cos(4*x)+C[2]*cos(8*x)+C[3]*cos(12*x)+C[4]*cos(16*x))^2/2
end
#pragma rtGlobals=1		// Use modern global access method.

Proc DeConvolveWave()
	PauseUpdate;Silent 1
	String DataFolderName=GetDatafolder(1)
	DoWindow/F DeConvolveWave_Panel
	if(V_Flag==0)
		NewDataFolder/O root:TempVariable
		NewDataFolder/O/S root:TempVariable:DeConvolveWave
		String/G root:TempVariable:DeConvolveWave:FilterString
		String/G root:TempVariable:DeConvolveWave:DataFolderName=DataFolderName
		Variable/G root:TempVariable:DeConvolveWave:FilterDIMS
		Variable/G root:TempVariable:DeConvolveWave:ShowProcess
		//if(Resolu)
		Variable/G root:TempVariable:DeConvolveWave:Resolutionx
		Variable/G root:TempVariable:DeConvolveWave:Resolutiony
		Variable/G root:TempVariable:DeConvolveWave:Tolerance
		if(FilterDIMS==0)
			FilterDIMS=1
			Resolutionx=0.01
			Resolutiony=0.1
			Tolerance=0.001
		endif
		make/T/O/N=0 AllWaves
		make/O/N=0 SelWaves
		String DIMSs="DIMS:"+num2str(FilterDIMS)
		setdatafolder DataFolderName
		String WaveNameList=WaveList("*",";",DIMSs)
		Variable WaveNum=ItemsinList(WaveNameList,";")
		SetDataFolder root:TempVariable:DeConvolveWave
		String2FileNameWave(WaveNameList,DataFolderName)
		DeConvolveWave_Panel()
		ListBox ALLWaves_L listWave=AllWaves,mode=9,selWave=selWaves
		if(DIMSIze(SelWaves,0))
		SelWaves[0]=1
		endif
		SetDataFolder DataFolderName
		//CreatResolutionWave_Deconvolve()
	endif
	
	
end

Window DeConvolveWave_Panel():Panel
	PauseUpdate;Silent 1
	NewPanel/K=1/W=(800,100,1110,320) as "DeConvolving Wave"
	ModifyPanel fixedSize=1,framestyle=1
	DrawText 3,18,"Waves in Current Folder"
	
	SetVariable Filter_V,pos={3,200},size={90,15},title="Filter"
	SetVariable Filter_V,value=root:TempVariable:DeConvolveWave:FilterString,proc=StringFiltedWaves_DeConvolve
	
	SetVariable Filter_DIMS,pos={94,200},size={80,15},title="DIMS",limits={1,2,1}
	SetVariable Filter_DIMS,value=root:TempVariable:DeConvolveWave:FilterDIMS,proc=DIMSFiltedWaves_DeConvolve
	
	ListBox ALLWaves_L frame= 4,pos={1,20},size={175,150}
	//ListBox SelectedWave_L frame= 4,pos={226,20},size={175,300}
	
	SetVariable Resolutionx,Pos={185,20},size={120,15},Title="Resoltuion X",Limits={0,100,0.005},value=root:TempVariable:DeConvolveWave:Resolutionx,proc=CreatResolutionWave_Deconvolve
	variable FilterDIMS=root:TempVariable:DeConvolveWave:FilterDIMS
	SetVariable Resolutiony,Pos={185,40},size={120,15},Title="Resolution Y",Limits={0,1000,0.1},value=root:TempVariable:DeConvolveWave:Resolutiony,Disable=2-FilterDIMS,proc=CreatResolutionWave_Deconvolve
	Button DisplayWave_B,Pos={88,173},size={80,20},title="Display",Proc=DisplayWave_DeConvolve
	SetVariable Tolerance,Pos={187,95},size={120,20},title="Tolerance",value=root:TempVariable:DeConvolveWave:Tolerance,Limits={0,1,0.01}
	CheckBox ShowProcess_C,Pos={185,115},size={20,50},title="Show Processing",Value=root:TempVariable:DeConvolveWave:ShowProcess,proc=ShowProcess_DeConvolve
	Button DeConvolve_B,Pos={205,140},size={80,20},title="DeConvolve",Proc=DeConvolve_Iterate
	
	
	Button Refresh,Pos={6,173},size={80,20},title="Refresh",Proc=Refresh_DeConvolve
end

Proc DeConvolve_Iterate(CtrlName):ButtonControl
	String CtrlName
	String TemDataFolder=root:TempVariable:DeConvolveWave:DataFolderName
	Setdatafolder root:tempVariable:DeConvolveWave
	Variable tempTolerance=root:TempVariable:DeConvolveWave:Tolerance
	Variable DIMS=root:TempVariable:DeConvolveWave:FilterDIMS
	Variable IFShowProcess=root:TempVariable:DeConvolveWave:ShowProcess
	if(!IFShowProcess)
		PauseUpdate;Silent 1
	Endif
	//String aa="aa"
	//if(stringmatch(TemDataFolder,"root:"))
		String Temp=TemDataFolder+"Gaussian_Resolution"
	//else
	//	String Temp=TemDataFolder+":"+"Gaussian_Resolution"
	//endif
	variable ii=0
	do
		if(SelWaves[ii]>0)
			Break
		endif
		ii=ii+1
	while(ii<Dimsize(SelWaves,0))
	String TempWaveName=AllWaves[ii]
	//TempWaveName=
	//print temp
	Duplicate/O Gaussian_Resolution,$Temp
	setdatafolder TemDataFolder
	String DeConvolvedWave=TempWaveName+"_DC"
	String Difference=TempWaveName+"_Dif"
	String DeConvolvedConvolved=TempWaveName+"_DCC"
	Duplicate/O $TempWaveName, $DeConvolvedWave,TempDeConvolvedWave,TempWave,$Difference,$DeConvolvedConvolved//,TempWave1//,TempWave2
	String GraphN1="Difference_of_DeConvolve"
	//String GraphN2="The
	variable tempvalue,tempValue1,tolerValue
	ii=0
	if(DIMS==1)
		dowindow/K $GraphN1
		Display/N=$GraphN1 $Difference
		//AutoPositionWindow $GraphN1
		String GraphN2=TempWaveName+"G_DC"//"_DeConvolved"
		//doWindow/K $GraphN2
		//Display/N=$GraphN2
		//AutoPositionWindow $GraphN2
		do
			TempValue1=TempValue
			TempWave=$DeConvolvedWave
			Convolve/A Gaussian_Resolution, tempDeConvolvedWave
			tempDeConvolvedWave=$TempWaveName/tempDeConvolvedWave
			Convolve/A Gaussian_Resolution,tempDeConvolvedWave
			$DeConvolvedWave=$DeConvolvedWave*tempDeConvolvedWave
			//$DeConvolvedWave/=1000000
			TempDeConvolvedWave=$DeConvolvedWave
			TempWave=(TempWave-TempDeConvolvedWave)^2
			//TempWave2=TempWave^2
			 tempvalue=sum(TempWave)//sum(TempWave2)
		 	TolerValue=abs(TempValue-TempValue1)/tempValue
			 if(TolerValue<=tempTolerance)
		 		break
			 endif
			 
			ii=ii+1
		//print TempTolerance
		//print tolerValue
			$DeConvolvedConvolved=$DeConvolvedWave
			convolve/A Gaussian_Resolution, $DeConvolvedConvolved
			$DeConvolvedConvolved*=deltax($DeConvolvedConvolved)
			$difference=$DeConvolvedConvolved-$tempWaveName
		while(ii)
		doWindow/K $GraphN2
		Display/N=$GraphN2 $TempWaveName,$DeConvolvedWave,$DeConvolvedConvolved
		//appendtograph $TempWaveName,$DeConvolvedWave,$DeConvolvedConvolved
		AutoPositionWindow $GraphN2
		ModifyGraph mode($TempWaveName)=3,marker($TempWaveName)=8;DelayUpdate
		ModifyGraph lsize($DeConvolvedWave)=3;DelayUpdate
		ModifyGraph rgb($DeConvolvedWave)=(0,12800,52224);DelayUpdate
		ModifyGraph rgb($DeConvolvedConvolved)=(0,39168,0)
		ModifyGraph lsize($DeConvolvedConvolved)=3
		Legend/C/N=text0/A=MC
		Legend/C/N=text0/J/F=0/B=1
		Legend/C/N=text0/J/X=-25.00/Y=40.00
	Endif
	ii=0
	if(DIMS==2)
		if(ifshowprocess)
		dowindow/K $GraphN1
		Display/N=$GraphN1 
		AppendImage $Difference
		ModifyImage $Difference ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$Difference
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		String GraphN2=TempWaveName+"G_DC"
		String GraphN3=TempWaveName+"G_DCC"
		String GraphN4=TempWaveName+"G_O"
		
		DoWindow/K $GraphN2
		Display/N=$GraphN2
		AutoPositionWindow $GraphN2
		AppendImage $DeConvolvedWave
		ModifyImage $DeConvolvedWave ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$DeConvolvedWave
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		
		DoWindow/K $GraphN4
		Display/N=$GraphN4
		//AutoPositionWindow/m=1/R=$GraphN2 $GraphN4
		AutoPositionWindow $GraphN4
		AppendImage $TempWaveName
		ModifyImage $TempWaveName ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$TempWaveName
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		
		
		
		DoWindow/K $GraphN3
		Display/N=$GraphN3
		AutoPositionWindow/m=1/R=$GraphN1 $GraphN3
		AppendImage $DeConvolvedConvolved
		ModifyImage $DeConvolvedConvolved ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$DeConvolvedConvolved
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		endif
		//Display
		do
			TempValue1=TempValue
			TempWave=$DeConvolvedWave
			MatrixConvolve Gaussian_Resolution, tempDeConvolvedWave
			tempDeConvolvedWave=$TempWaveName/tempDeConvolvedWave
			MatrixConvolve Gaussian_Resolution,tempDeConvolvedWave
			$DeConvolvedWave=$DeConvolvedWave*tempDeConvolvedWave
			//$DeConvolvedWave/=1000000
			TempDeConvolvedWave=$DeConvolvedWave
			TempWave=(TempWave-TempDeConvolvedWave)^2
			//TempWave2=TempWave^2
			 tempvalue=sum(TempWave)//sum(TempWave2)
		 	TolerValue=abs(TempValue-TempValue1)/tempValue
			 if(TolerValue<=tempTolerance)
		 		break
			 endif
			ii=ii+1
			//print tolervalue
			if(IFShowProcess)
				$DeConvolvedConvolved=$DeConvolvedWave
				Matrixconvolve Gaussian_Resolution, $DeConvolvedConvolved
				$DeConvolvedConvolved=$DeConvolvedConvolved*deltax($DeConvolvedConvolved)*DimDelta($DeConvolvedConvolved,1)
				$difference=$DeConvolvedConvolved-$tempWaveName
			endif
		//print TempTolerance
		//print tolerValue
		while(ii)
		//if(!IFSHowProcess)
			//$DeConvolvedConvolved=$DeConvolvedWave
			//Matrixconvolve Gaussian_Resolution, $DeConvolvedConvolved
			//$DeConvolvedConvolved=$DeConvolvedConvolved*deltax($DeConvolvedConvolved)*DimDelta($DeConvolvedConvolved,1)
			//$difference=$DeConvolvedConvolved-$tempWaveName
		//endif
		//doWindow/K $GraphN2
		//AppendImage/N=$GraphN2
		//AutoPositionWindow $GraphN2
		if(!ifshowprocess)
		dowindow/K $GraphN1
		Display/N=$GraphN1 
		AppendImage $Difference
		ModifyImage $Difference ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$Difference
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		String GraphN2=TempWaveName+"_DeCon"
		String GraphN3=TempWaveName+"_Conag"
		String GraphN4=TempWaveName+"_Org"
		
		DoWindow/K $GraphN3
		Display/N=$GraphN3
		AutoPositionWindow $GraphN3
		AppendImage $DeConvolvedWave
		ModifyImage $DeConvolvedWave ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$DeConvolvedWave
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		
		DoWindow/K $GraphN4
		Display/N=$GraphN4
		//AutoPositionWindow/m=1/R=$GraphN2 $GraphN4
		AutoPositionWindow $GraphN4
		AppendImage $TempWaveName
		ModifyImage $TempWaveName ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$TempWaveName
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		
		
		
		DoWindow/K $GraphN2
		Display/N=$GraphN2
		AutoPositionWindow/m=1/R=$GraphN1 $GraphN2
		AppendImage $DeConvolvedConvolved
		ModifyImage $DeConvolvedConvolved ctab= {*,*,PlanetEarth,1}
		ModifyGraph margin(left)=85
		ColorScale/C/N=text0/X=-35/Y=-10 image=$DeConvolvedConvolved
		ModifyGraph width=226.772
		ModifyGraph height={Aspect,0.8}
		endif
		
	Endif
	killwaves Gaussian_Resolution,TempDeConvolvedWave,TempWave
	Beep
	Beep
	Beep
end

Proc DisplayWave_DeConvolve(CtrlName):ButtonControl
	String CtrlName
	String TemDataFolder=root:TempVariable:DeConvolveWave:DataFolderName
	Variable DIMS=root:TempVariable:DeConvolveWave:FilterDIMS
	Setdatafolder root:tempVariable:DeConvolveWave
	variable ii=0
	do
		if(SelWaves[ii]>0)
			Break
		endif
		ii=ii+1
	while(ii<Dimsize(SelWaves,0))
	String TempWaveName=AllWaves[ii]
	SetDataFolder TemDataFolder
	String GraphN="Wave_for_Convolving"
	Dowindow/K $GraphN
	Display/N=$GraphN
	if(DIMS==1)
		 AppendtoGraph $TempWaveName
	else
		AppendImage $TempWaveName;DelayUpdate
		ModifyImage $TempWaveName ctab= {*,*,PlanetEarth,1}
	endif
end

Proc CreatResolutionWave_Deconvolve(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	Variable VarNum
	String VarStr
	String VarName
	String DataFolderName=root:TempVariable:DeConvolveWave:DataFolderName
	Setdatafolder root:TempVariable:DeConvolveWave
	Variable Resolutionx=root:TempVariable:DeConvolveWave:Resolutionx
	//Variable Resolutiony=root:TempVariable:DeConvolveWave:Resolutiony
	Variable DIMS=root:TempVariable:DeConvolveWave:FilterDIMS
	variable ii=0
	do
		if(SelWaves[ii]>0)
			Break
		endif
		ii=ii+1
	while(ii<Dimsize(SelWaves,0))
	String TempWaveName=AllWaves[ii]

	SetDataFolder DataFolderName
	Variable Deltaxx=deltax($TempWaveName)
	variable temDIMx=round(Resolutionx/Deltaxx)
	SetdataFolder root:TempVariable:DeconvolveWave
	//Print DIMS
	String GraphN="Resolution_Function"
	DoWindow/K $GraphN
	
	if(DIMS==1)
		Make/O/N=(4*temDIMx+1) Gaussian_Resolution
		SetScale/I x -2*TemDIMX*Deltaxx,2*TemDIMX*Deltaxx,"", Gaussian_Resolution;DelayUpdate
		//Gaussian_resolution=exp(-x^2/2/(resolutionx/2.3548)^2)/2.506628274631000502415765284811/(resolutionx/2.3548)
		Gaussian_Resolution=Resolution_Gaussian(Resolutionx,Resolutiony,x,y,DIMS)
		Display/N=$GraphN Gaussian_Resolution
		//appendtograph Gaussian_Resolution
		Label bottom "\\u#2\\Z16E (meV)"
		ModifyGraph tick=2,mirror=1,fSize=14,axThick=1.5,standoff=0
	endif
	if(DIMS==2)
		Variable Resolutiony=root:TempVariable:DeConvolveWave:Resolutiony
		//print temDImx
		SetDataFolder DataFolderName
		Variable Deltayy=DimDelta($TempWaveName,1)
		SetdataFolder root:TempVariable:DeconvolveWave
		Variable temDIMy=round(ResolutionY/Deltayy)
		
		Make/O/N=(4*temDIMx+1,4*temDIMy+1) Gaussian_Resolution
		SetScale/I x -2*TemDIMX*Deltaxx,2*TemDIMX*Deltaxx,"", Gaussian_Resolution;DelayUpdate
		SetScale/I y -2*TemDIMy*Deltayy,2*TemDIMy*Deltayy,"", Gaussian_Resolution;DelayUpdate
		Gaussian_Resolution=Resolution_Gaussian(Resolutionx,Resolutiony,x,y,DIMS)
		Display/N=$GraphN
		AppendImage Gaussian_Resolution
		Label bottom "\\u#2\\Z14E (meV)"
		Label left "\\Z14Angle (бу)"
		ModifyGraph tick=2,fSize=14,axThick=1.5,standoff=0,axRGB=(65535,65535,65535)

	endif
	
	
	SetDataFolder DataFolderName
end

Proc ShowProcess_DeConvolve(Name,Value)
	String Name
	Variable Value
	Variable/G root:TempVariable:DeConvolveWave:ShowProcess=Value
end

Proc StringFiltedWaves_DeConvolve(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	Variable VarNum
	String VarStr
	String VarName
	String DataFolderName=root:TempVariable:DeConvolveWave:DataFolderName
	setdatafolder DataFolderName
	Variable DIMS=root:TempVariable:DeConvolveWave:FilterDIMS
	String WaveNameList=Filter_String(VarStr,DIMS)
	setdatafolder root:TempVariable:DeConvolveWave
	string2FileNameWave(WaveNameLIst,DataFolderName)
	
	SetDataFolder DataFolderName
end

Proc DIMSFiltedWaves_DeConvolve(CtrlName,VarNum,VarStr,VarName):setvariableControl
	String CtrlName
	Variable VarNum
	String VarStr
	String VarName
	Variable DIMS=VarNum
	String DataFolderName=root:tempVariable:DeConvolveWave:DataFolderName
	setdatafolder DataFolderName
	String WaveNamelist=Filter_DIMS(DIMS)
	setdatafolder root:tempVariable:DeConvolveWave
	String2FileNameWave(WaveNameList,DataFolderName)
	Setvariable Resolutiony,Disable=2-DIMS
	//CheckBox ShowProcess_C,Disable=DIMS-1
	//root:tempVariable:DeConvolveWave:ShowProcess=2-DIMS
	if(Dimsize(SelWaves,0))
	SelWaves[0]=1
	endif
	setdatafolder DataFolderName
end

Proc Refresh_DeConvolve(CtrlName):ButtonControl
	String CtrlName
	//String DataFolderName=GetDataFolder(1)
	String/G root:TempVariable:DeConvolveWave:DataFolderName//=DataFolderName
	Variable DIMS=root:TempVariable:DeConvolveWave:FilterDIMS
	String WaveNameList=RefreshZWT(DIMS)
	root:TempVariable:DeConvolveWave:DataFolderName=GetDataFolder(1)
	setdatafolder root:tempVariable:DeConvolveWave
	String2FileNameWave(WaveNameList,DataFolderName)
	if(Dimsize(SelWaves,0))
	SelWaves[0]=1
	endif
	setdatafolder DataFolderName
	CreateBrowser
end
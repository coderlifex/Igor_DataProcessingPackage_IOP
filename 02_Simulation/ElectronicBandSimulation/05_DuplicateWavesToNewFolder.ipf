#pragma rtGlobals=1		// Use modern global access method.
Proc DuplicateWavesinNewFolder()
	PauseUpdate;Silent 1
	String DataFolderName=GetDatafolder(1)
	DoWindow/F DuplicateWaves_Panel
	if(V_Flag==0)
		NewDatafolder/O root:TempVariable
		NewDatafolder/O/S Root:TempVariable:DuplicateData
		String/G root:TempVariable:DuplicateData:RootString
		String/G root:TempVariable:DuplicateData:FilterString_Duplicate
		String/G root:TempVariable:DuplicateData:DataFolderName=DataFolderName
		Variable/G root:TempVariable:DuplicateData:FilterDIMS_Duplicate
		make/T/O/N=0 SelectedWaves,allwaves,DataPathA,DataPathS
		make/O/N=0 sselWaves,selWaves
		if(Stringmatch(RootString,""))
			RootString="root:"
			FilterDIMS_Duplicate=1
		endif
		
		String DIMSs="DIMS:"+num2str(FilterDIMS_Duplicate)
		setdatafolder DataFolderName
		String WaveNameList=WaveList("*",";",DIMSs)
		Variable WaveNum=ItemsinList(WaveNameList,";")
		setdatafolder root:Tempvariable:DuplicateData
		String2FileNameWave(WaveNameList,DataFolderName)
		DuplicateWaves_Panel()
		ListBox ALLWaves_L listWave=AllWaves,mode=9,selWave=selWaves
		//ListBox SelectedWave_L listWave=AllWaves,mode=9,selWave=selWaves
		ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
		SetDataFolder DataFolderName
	endif
end

Window DuplicateWaves_Panel():Panel
	PauseUpdate; Silent 1
	
	NewPanel/K=1/W=(800,100,1250,520) as "Duplicating Waves to New Folder"
	ModifyPanel fixedSize=1,framestyle=1
	DrawText 1,18,"Waves in Current Folder"
	DrawText 224,18,"Waves for Duplicating"
	
	//
	SetVariable Filter_V,pos={1,360},size={100,15},title="Filter"
	SetVariable Filter_V,value=root:TempVariable:DuplicateData:FilterString_Duplicate,proc=StringFiltedWaves_Duplicate
	
	SetVariable Filter_DIMS,pos={102,360},size={80,15},title="DIMS",limits={1,3,1}
	SetVariable Filter_DIMS,value=root:TempVariable:DuplicateData:FilterDIMS_Duplicate,proc=DIMSFiltedWaves_Duplicate

	
	Button AddWave_B,pos={180,140},size={20,20},proc=AddWaves_Duplicate,title=""
	Button AddWave_B,picture= ProcGlobal#ADDButton
	Button DeleteWave_B,pos={180,165},size={20,20},proc=DeleteWaves_Duplicate,title=""
	Button DeleteWave_B,picture= ProcGlobal#DeleteButton
	
	
	Button Up_B,pos={410,133},size={20,20},proc=UPWave_Duplicate,title=""
	Button Up_B,picture= ProcGlobal#UpButton
	Button Down_B,pos={410,172},size={20,20},proc=DownWave_Duplicate,title=""
	Button Down_B,picture= ProcGlobal#DownButton
	
	ListBox ALLWaves_L frame= 4,pos={1,20},size={175,300}
	ListBox SelectedWave_L frame= 4,pos={226,20},size={175,300}
	
	//variable/G root:TempVariable:DuplicateData:InputScale_Check
	//CheckBox InputScale_C,Pos={2,327},size={20,50},title="Input Scale",proc=InputScale_Combine,value=root:TempVariable:Combine1Dto2D:InputScale_Check
	
	Button Refresh,Pos={95,323},size={80,20},title="Refresh",Proc=Refresh_Duplicate
	Button Clear_Duplicate,Pos={320,323},size={80,20},title="Clear",Proc=Clear_Duplicate
	
	//Variable/G root:TempVariable:Combine1Dto2D:InverseAxisv_Combine
	//CheckBox InverseAxis_C,Pos={226,395},size={20,50},title="Swap X and Y Axes",proc=InverseAxis_Combine,value=root:TempVariable:Combine1Dto2D:InverseAxisv_Combine
	
	//GroupBox SetScale_G,pos={18,342},size={110,55},title="Set Scale",Disable=1
	//GroupBox SetScale_G,font="Arial",fSize=10,fStyle=2
	
	
	//ariable/G root:TempVariable:Combine1Dto2D:StartScale_Combine
	//variable/G root:TempVariable:Combine1Dto2D:EndScale_Combine
	//SetVariable StartScale_V,pos={23,357},size={100,20},title="Start",value=root:TempVariable:Combine1Dto2D:StartScale_Combine
	//SetVariable StartScale_V,limits={-10000,10000,1},Disable=1
	//SetVariable EndScale_V,pos={23,377},size={100,20},title="End ",value=root:TempVariable:Combine1Dto2D:EndScale_Combine
	//SetVariable EndScale_V,limits={-10000,10000,1},Disable=1
	
	//String/G root:TempVariable:Combine1Dto2D:ColorTable_Combine="PlanetEarth"
	//Colortable="
	//PopupMenu ColorPop_P,pos={226,345},size={50,15},proc=ColorPopMenu_Combine,title=""
	//PopupMenu ColorPop_P,mode=7,popColor= (0,65535,65535),value= "*COLORTABLEPOP*"//,value=root:TempVariable:ColorTable_Combine
	Button Duplicate_B,pos={345,393},size={80,20},proc=DuplicateWave_Button,title="Duplicate"
	Button Duplicate_B,font="Arial",fStyle=1
	
	
	SetVariable Root_V,pos={226,372},size={200,20},title="Input data folderl"
	SetVariable Root_V,value=root:TempVariable:DuplicateData:RootString//,proc=FiltedWaves_Combine
	
	//DrawText 226,338,"Color Table"
	
end

Proc DuplicateWave_Button(CtrlName):ButtonControl
	String CtrlName
	String TemDataFolder=root:TempVariable:DuplicateData:RootString
	//setdata
	if(!Stringmatch(TemDataFolder,"root"))
		NewDataFolder/O $TemDataFolder
	endif
	String DataFolderName,tempDataName,temp
	setdatafolder root:TempVariable:DuplicateData
	Variable ii,size
	size=DimSize(SelectedWaves,0)
	ii=0
	Do
		setdatafolder root:TempVariable:DuplicateData
		DataFolderName=DataPaths[ii]
		tempDataName=SelectedWaves[ii]
		setDataFolder DataFolderName
		//Duplicate/O $tempDataName, temData
		temp=TemDataFolder+":"+tempDataName
		//print TemDataFolder
		//MoveWave temData,$Temp//:$tempDataName
		//print temp
		Duplicate/O $tempDataName,$temp
		//killwaves/z temData
		
		ii=ii+1
	While(ii<size)
	
	
	DataFolderName=root:tempVariable:DuplicateData:DataFolderName
	setdatafolder DataFoldername
end

Proc UPWave_Duplicate(CtrlName):ButtonControl
	String CtrlName
	setdatafolder root:TempVariable:DuplicateData
	UPWave(SelectedWaves,sselWaves,DataPathS)
	String DataFolderName=root:tempVariable:DuplicateData:DataFolderName
	setdatafolder DataFoldername
end

Proc DownWave_Duplicate(CtrlName):ButtonControl
	String CtrlName
	setdatafolder root:TempVariable:DuplicateData
	DownWave(SelectedWaves,sselWaves,DataPathS)
	String DataFolderName=root:tempVariable:DuplicateData:DataFolderName
	setdatafolder DataFoldername
end

Proc Clear_Duplicate(CtrlName):ButtonControl
	String CtrlName
	SetDataFolder root:TempVariable:DuplicateData
	make/T/O/N=0 SelectedWaves,DataPathS
	make/O/N=0 sselWaves
	String DataFolderName=root:tempVariable:DuplicateData:DataFolderName
	setdatafolder DataFoldername
	CreateBrowser
end

Proc AddWaves_Duplicate(CtrlName):ButtonControl
	String CtrlName
	String DataFolderName=root:tempVariable:DuplicateData:DataFolderName
	setdatafolder root:tempVariable:DuplicateData
	
	ADDWave(AllWaves,SelWaves,SelectedWaves,sselWaves,DataPathA,DataPathS)
	setdatafolder DataFolderName
end

Proc DeleteWaves_Duplicate(CtrlName):ButtonControl
	String CtrlName
	String DataFolderName=root:tempVariable:DuplicateData:DataFolderName
	setdatafolder root:tempVariable:DuplicateData
	DeleteWave(AllWaves,SelWaves,SelectedWaves,sselWaves,DataPathA,DataPaths)
	Setdatafolder DataFolderName
end


Proc Refresh_Duplicate(CtrlName):ButtonControl
	String CtrlName
	//String DataFolderName=GetDataFolder(1)
	String/G root:TempVariable:DuplicateData:DataFolderName//=DataFolderName
	Variable DIMS=root:TempVariable:DuplicateData:FilterDIMS_Duplicate
	String WaveNameList=RefreshZWT(DIMS)
	root:TempVariable:DuplicateData:DataFolderName=GetDataFolder(1)
	setdatafolder root:tempVariable:DuplicateData
	String2FileNameWave(WaveNameList,DataFolderName)
	setdatafolder DataFolderName
	CreateBrowser
end

Proc DIMSFiltedWaves_Duplicate(CtrlName,VarNum,VarStr,VarName):setvariableControl
	String CtrlName
	Variable VarNum
	String VarStr
	String VarName
	Variable DIMS=VarNum
	String DataFolderName=root:tempVariable:DuplicateData:DataFolderName
	setdatafolder DataFolderName
	String WaveNamelist=Filter_DIMS(DIMS)
	setdatafolder root:tempVariable:DuplicateData
	String2FileNameWave(WaveNameList,DataFolderName)
	setdatafolder DataFolderName
end


Proc StringFiltedWaves_Duplicate(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	Variable VarNum
	String VarStr
	String VarName
	String DataFolderName=root:TempVariable:DuplicateData:DataFolderName
	setdatafolder DataFolderName
	Variable DIMS=root:TempVariable:DuplicateData:FilterDIMS_Duplicate
	String WaveNameList=Filter_String(VarStr,DIMS)
	setdatafolder root:TempVariable:DuplicateData
	string2FileNameWave(WaveNameLIst,DataFolderName)
	
	SetDataFolder DataFolderName
end
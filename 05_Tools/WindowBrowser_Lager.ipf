#pragma rtGlobals=1		// Use modern global access method.
menu "Tools"
"Window Browser", WinBrowser()
end

proc WinBrowser_ZWT()
	pauseupdate;silent 1
	String DataFolderName=GetDataFolder(1)
	DoWindow/F WinBrowser_ZWT_P
	if(V_Flag == 0)
		NewDataFolder/O/S root:TempVariable
		NewDataFolder/O/S root:TempVariable:WinBrowser
		variable/G CGraph
		variable/G CTable
		//variable/G CLayout
		//variable/G CNotebook
		//variable/G CProcedure
		variable/G columns
		String/G NWName
		if(!columns)
			columns = 5
			CGraph = 1
			CTable = 1
			//CLayout = 1
			//CNotebook = 1
			//CProcedure = 1
		endif
		//make/O/T/N=(5,columns) ListWaves
		//make/O/N=(5,columns) SelWaves
		 Refresh_WinBrowser_ZWT("")
		//Variable/G EStart
		//Variable/G MStart
		//Variable/G Slope
		WinBrowser_ZWT_P() 
	endif
	SetDataFolder DataFolderName
End

Window WinBrowser_ZWT_P() : Panel
	PauseUpdate; Silent 1
	//NewPanel/FLT=1/K=1/W=(800,0,1760,500) as "Window Browser"
	NewPanel/K=1/W=(800,0,1760,500) as "Window Browser"
	//NewPanel/FLT=1/K=1/W=(800,0,1420,500) as "Window Browser"
	//ModifyPanel fixedSize=0
	//SetActiveSubwindow _endfloat_
	//NewPanel/K=1/W=(800,0,1760,500) as "Window Browser"
	//setdatafolder root:TempVariable:WinBrowser
	Button Refresh,Pos={5,2},size={55,20},title="Refresh",proc=Refresh_WinBrowser_ZWT
	checkbox GraphW,Pos={65,5},size={30,20},title="Graph",proc=Refresh_GTW,variable=root:TempVariable:WinBrowser:CGraph
	checkbox TableW,Pos={125,5},size={30,20},title="Table",proc=Refresh_GTW,variable=root:TempVariable:WinBrowser:CTable
	//checkbox LayoutW,Pos={185,5},size={30,20},title="Layout",proc=Refresh_GTW,variable=root:TempVariable:WinBrowser:CLayout
	//checkbox NotebookW,Pos={185,5},size={30,20},title="Notebook",variable=root:TempVariable:WinBrowser:CNotebook
	//checkbox ProcedureW,Pos={265,5},size={30,20},title="Procedure",variable=root:TempVariable:WinBrowser:CProcedure
	setvariable Column,Pos={180,3},size={75,20},title="Column",variable=root:TempVariable:WinBrowser:Columns,proc=Column_WinBrowser_ZWT,limits={1,20,1}
	setvariable RNameWindow,Pos={260,3},size={330,20},title="\f02Rename Selected Window:",variable=root:TempVariable:WinBrowser:NWName,proc=ReName_WinBrowser_ZWT//,limits={1,20,1}
	ListBox/Z ZoomWin, pos={5,25},size={950,450},listwave=root:TempVariable:WinBrowser:ListWaves,selWave=root:TempVariable:WinBrowser:selWaves,special={1,200,0}
	//ListBox/Z ZoomWin, pos={5,25},size={610,450},listwave=root:TempVariable:WinBrowser:ListWaves,selWave=root:TempVariable:WinBrowser:selWaves,special={1,180,0}
	ListBox/Z ZoomWin, userColumnResize = 1, Proc = ShowWindow_WinBrowser_ZWT,mode=5
	Button Close0,Pos={5,480},size={50,20},title="\K(65280,0,0)Close",proc=CloseWindow_WinBrowser_ZWT
	Button Close1,Pos={900,480},size={50,20},title="\K(65280,0,0)Close",proc=CloseWindow_WinBrowser_ZWT
	Button Close2,Pos={600,3},size={50,20},title="\K(65280,0,0)Close",proc=CloseWindow_WinBrowser_ZWT
	Button HideAll,Pos={60,480},size={110,20},title="Hide All Windows",proc=HideAll_WinBrowser_ZWT
	Button ShowAll,Pos={175,480},size={110,20},title="Show All Windows",proc=ShowAll_WinBrowser_ZWT
	DrawText 310,498,"\f01Double click\f00 to show the graph, and \f01single click\f00 to hide the graph"
	
end

Proc CloseWindow_WinBrowser_ZWT(CtrlName) : ButtonControl
	String CtrlName
	killwindow WinBrowser_ZWT_P
end

proc ReName_WinBrowser_ZWT(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	String NWName = root:TempVariable:WinBrowser:NWName
	String DataFolderName = GetDataFolder(1)
	variable ii, jj
	setdatafolder root:TempVariable:WinBrowser
	ii = 0
	if(!stringmatch(NWName,""))
	do
		jj = 0
		do
			if(SelWaves[ii][jj])
				dowindow/F $ListWaves[ii][jj]
				renamewindow $Listwaves[ii][jj] $NWName
				ListWaves[ii][jj] = NWName
				root:TempVariable:WinBrowser:NWName = ""
				//Refresh_WinBrowser_ZWT("")
			endif
			jj = jj +1
		while( jj < Dimsize(SelWaves,1))
		ii = ii +1
	while(ii < Dimsize(SelWaves,0))
	endif
	SetDataFolder DataFolderName
end

proc ShowAll_WinBrowser_ZWT(CtrlName) : ButtonCtrol
	String CtrlName
	//String DataFolderName = GetDataFolder(1)
	//SetDataFolder root:TempVariable:WinBrowser
	//variable ii,jj
	String WinListS = ""
	WinlistS = Winlist("*",";","WIN:1")
	WinlistS = WinListS+Winlist("*",";","WIN:2")
	String WName
	variable ii = 0
	do
		WName  = StringFromList(ii,WinlistS,";")
		dowindow/F $WName
		ii = ii + 1
	while(ii < ItemsInList(WinListS,";"))
	//SetDataFolder DataFolderName
end

proc HideAll_WinBrowser_ZWT(CtrlName) : ButtonCtrol
	String CtrlName
	//String DataFolderName = GetDataFolder(1)
	//SetDataFolder root:TempVariable:WinBrowser
	//variable ii,jj
	String WinListS = ""
	WinlistS = Winlist("*",";","WIN:1")
	WinlistS = WinListS+Winlist("*",";","WIN:2")
	String WName
	variable ii = 0
	do
		WName  = StringFromList(ii,WinlistS,";")
		dowindow/HIDE=1 $WName
		ii = ii + 1
	while(ii < ItemsInList(WinListS,";"))
	//SetDataFolder DataFolderName
end

function ShowWindow_WinBrowser_ZWT(ctrlName,row,col,event) : ListboxControl
	String ctrlName     // name of this control
	Variable row        // row if click in interior, -1 if click in title
	Variable col        // column number
	Variable event      // event code
	pauseupdate;silent 1
	//String DataFolderName = GetDataFolder(1)
	String WName
	//setdatafolder root:TempVariable:WinBrowser
	wave/T Tem = root:TempVariable:WinBrowser:Listwaves
	WName = Tem[row][col]
	//print WName
	//print event
	if(!stringmatch("",WName))
		if(event == 3)
			dowindow/F $WName
		endif
		if(event == 1)
			dowindow/HIDE=1 $WName
		endif
	endif
	//if(event == 8)
		//wave/T Tem = root:TempVariable:WinBrowser
	//endif
	//SetDataFolder DataFolderName
End

Proc Column_WinBrowser_ZWT (ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	variable columns = root:TempVariable:WinBrowser:columns
	Refresh_WinBrowser_ZWT("")
End

proc Refresh_GTW(CtrlName,Value) : ListboxControl
	String CtrlName
	Variable Value
	if(stringmatch(CtrlName, "GraphW"))
		if(!Value)
			root:TempVariable:WinBrowser:CTable = 1
		endif
	endif
	if(stringmatch(CtrlName, "TableW"))
		if(!Value)
			root:TempVariable:WinBrowser:CGraph = 1
		endif
	endif
	//if(stringmatch(CtrlName, "LayoutW"))
	//	if(!Value)
	//		root:TempVariable:WinBrowser:CLayout = 1
	//	endif
	//endif
	
	Refresh_WinBrowser_ZWT("")
end

proc Refresh_WinBrowser_ZWT(CtrlName) : ButtonControl
	String CtrlName
	variable CGraph = root:TempVariable:WinBrowser:CGraph
	variable CTable = root:TempVariable:WinBrowser:CTable
	//variable CLayout = root:TempVariable:WinBrowser:CLayout
	//variable CNotebook = root:TempVariable:WinBrowser:CNotebook
	//variable CProcedure = root:TempVariable:WinBrowser:CProcedure
	variable columns = root:TempVariable:WinBrowser:columns
	String DataFolderName = Getdatafolder(1)
	String WinlistS = ""// = Winlist(""
	if(CGraph)
		WinlistS = Winlist("*",";","WIN:1")
	endif
	if(CTable)
		WinlistS = WinListS+Winlist("*",";","WIN:2")
	endif
	//if(CLayout)
	//	WinlistS = WinListS+Winlist("*",";","WIN:4")
	//endif
	//if(CNotebook)
	//	WinlistS = WinListS+Winlist("*",";","WIN:16")
	//endif
	//if(CProcedure)
	//	WinlistS = WinListS+Winlist("*",";","WIN:128")
	//endif
	//String WName
	Variable WinNum = ItemsInList(WinListS,";")
	//print winlistS
	Variable Rows = ceil(WinNum/Columns)
	setdatafolder root:TempVariable:WinBrowser
	make/O/T/N=(Rows,columns) ListWaves
	ListWaves = ""
	make/O/N=(Rows,columns) SelWaves
	//print winnum
	variable ii = 0
	do
		ListWaves[floor((ii)/Columns)][mod(ii,Columns)] = StringFromList(ii,WinlistS,";")
		ii = ii + 1
	while(ii < WinNum)
	//print winlists
	Setdatafolder DataFolderName
end
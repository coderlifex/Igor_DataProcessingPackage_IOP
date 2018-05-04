#pragma rtGlobals=1		// Use modern global access method.
//This procedure is used for combining selected 1D curves to a 2D image.

Proc SyFS_ZWT(CtrlName):ButtonControl
	String CtrlName
	PauseUpdate; Silent 1
	setdatafolder root:IntegratedImage
	String TemDatafolder=GetDataFolder(1)
	NewDataFolder/O root:TempVariable
	NewDataFolder/O/S root:TempVariable:SyFS
	variable/G KxStart
	variable/G KxEnd
	variable/G KyStart
	variable/G KyEnd
	variable/G AngleStart
	Variable/G AngleEnd
	String/G  DataFoldername=TemDatafolder
	DoWindow/F SyFS_ZWT_Panel
	SetDataFolder TemDatafolder
	if(V_Flag==0)

		String WaveNameList=WaveList("*",";","DIMS:2")
		Variable WaveNum=ItemsinList(WaveNameList,";")
		SetDatafolder root:TempVariable:SyFS
		make/T/O/N=0 SelectedWaves,allwaves//,DataPathA,DataPathS
//		make/O/N=0 sselWaves,selWaves
		//if(WaveNum==0)
		///	DoAlert 0, "Are you kidding me! Make sure you have at least 1D wave in this folder"
		//endif
		//Variable WaveNum=ItemsInList(WaveNameList,";")
		String2FileNameWave(WaveNameList,DataFolderName)
		SyFS_ZWT_Panel()
		ListBox ALLWaves_L listWave=AllWaves,mode=9,selWave=selWaves
//		ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
	endif
	SetDataFolder TemDatafolder
end

Window SyFS_ZWT_Panel():Panel
	PauseUpdate; Silent 1
	
	NewPanel/K=1/W=(800,100,1200,350) as "Symmetrizing Fermi Surface"
	ModifyPanel fixedSize=1,framestyle=1
	DrawText 1,18,"Select:"
	//DrawText 224,18,"1D Waves for Combining"
	

	
	ListBox ALLWaves_L frame= 4,pos={1,20},size={175,200}
	//ListBox SelectedWave_L frame= 4,pos={226,20},size={175,300}
	Button ShowFS_B,pos={245,20},size={80,20},proc=ShowFS_Button,title="Show"
	Button ShowFS_B,font="Arial",fStyle=1	
	
	Button Calculate_B,pos={230,95},size={120,25},proc=SymmetrizingZone_Button,title="Symmetrizing Zone"
	Button Calculate_B,font="Arial",fStyle=1	

	Button StartLine_B,pos={190,47},size={60,20},proc=CursorStart_SyFS,title="StartLine"
	Button StartLine_B,font="Arial",fStyle=1,disable=1
	Button EndLine_B,pos={190,67},size={60,20},proc=CursorEnd_SyFS,title="EndLine"
	Button Endline_B,font="Arial",fStyle=1,disable=1
	
	SetVariable KxStart,pos={260,50},size={60,15},disable=1,title="x"
	SetVariable KxStart,limits={-1,1,0.05},value=root:TempVariable:SyFS:KxStart
	SetVariable KxEND,pos={260,70},size={60,15},disable=1,title="x"
	SetVariable KxEND,limits={-1,1,0.05},value=root:TempVariable:SyFS:KxEND
	SetVariable KyStart,pos={330,50},size={60,15},disable=1,title="y"
	SetVariable KyStart,limits={-1,1,0.05},value=root:TempVariable:SyFS:KyStart
	SetVariable KyEND,pos={330,70},size={60,15},disable=1,title="y"
	SetVariable KyEND,limits={-1,1,0.05},value= root:TempVariable:SyFS:KyEnd
	setvariable AngleS,pos={220,125},size={120,15},disable=2,title="Angle Start",value=root:TempVariable:SyFS:AngleStart
	setvariable AngleE,pos={220,145},size={120,15},disable=2,title="Angle   End",value=root:TempVariable:SyFS:AngleEnd
	Button Refresh,Pos={95,225},size={80,20},title="Refresh",Proc=Refresh_SyFS


	String/G root:TempVariable:SyFS:ColorTable_SyFS="PlanetEarth"
	//Colortable="
	PopupMenu ColorPop_P,pos={190,195},size={50,15},proc=ColorPopMenu_SyFS,title=""
	PopupMenu ColorPop_P,mode=7,popColor= (0,65535,65535),value= "*COLORTABLEPOP*"//,value=root:TempVariable:ColorTable_Combine
	Button SyFS_B,pos={245,220},size={80,25},proc=SymmetrizeFS_Button,title="Symmetrize"
	Button SyFS_B,font="Arial",fStyle=1
	

	
	DrawText 190,190,"Color Table"
	
end

Proc SymmetrizingZone_Button(CtrlName):Buttoncontrol
	String CtrlName
	String DataFoldername=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:Tempvariable:SyFS
	KxStart=hcsr(A)
	KyStart=vcsr(A)
	KxEnd=hcsr(B)
	KyEnd=vcsr(B)
	make/O/N=3 SymmetrizeZonex,SymmetrizeZoney
	//print Kxstart
	variable Angle//AngleStart,AngleEnd
	if(KxStart!=0)
	Angle=180*atan(KyStart/KxStart)/pi
	endif
	if(KxStart==0)
		Angle=90
		if(KyStart<0)
		Angle=270
		endif
	endif
	if(KxStart>0)
		if(KyStart<0)
			Angle=360+Angle
		endif
	endif
	if(KxStart<0)
		//if(KyStart>0)
			Angle=180+Angle
		//if(KyStart<0)
			
		//endif
	endif
	if(Angle!=0)
		Angle=round(Angle/15)*15
	endif
	AngleStart=Angle
	//print Angle
	//////////////////////////////////////////
	if(KxEnd!=0)
	Angle=180*atan(KyEnd/KxEnd)/pi
	endif
	if(KxEnd==0)
		Angle=90
		if(KyEnd<0)
		Angle=270
		endif
	endif
	if(KxEnd>0)
		if(KyEnd<0)
			Angle=360+Angle
		endif
	endif
	if(KxEnd<0)
		//if(KyStart>0)
			Angle=180+Angle
		//if(KyStart<0)
			
		//endif
	endif
	if(Angle!=0)
		Angle=round(Angle/15)*15
	endif
	AngleEnd=Angle
	//print AngleStart,AngleEnd
	SymmetrizeZonex[1]=0
	SymmetrizeZoney[1]=0
	SymmetrizeZonex[0]=5*cos(AngleStart*pi/180)
	SymmetrizeZoney[0]=5*sin(AngleStart*pi/180)
	SymmetrizeZonex[2]=5*cos(AngleEnd*pi/180)
	SymmetrizeZoney[2]=5*sin(AngleEnd*pi/180)
	removefromgraph/Z SymmetrizeZoney
	AppendtoGraph SymmetrizeZoney vs SymmetrizeZonex
	ModifyGraph lsize(SymmetrizeZoney)=3,rgb(SymmetrizeZoney)=(65535,65535,65535)
	//variable ii=0
	//do
	//	if(SelWaves[ii]>0)
	//		Break
	//	endif
	//	ii=ii+1
	//while(ii<Dimsize(SelWaves,0))
	setdatafolder DataFoldername
	//String TempName=AllWaves[ii]
	
end

proc CursorStart_SyFS(CtrlName):ButtonControl
		String CtrlName
		String DataFoldername=root:Tempvariable:SyFS:DataFoldername
		setDatafolder root:TempVariable:SyFS
		Variable/G KxStart
		//nvar Kxend
		Variable/G KyStart
		//nvar KyEnd=KyEnd

		KxStart=hcsr(A)
		KyStart=vcsr(A)
		make/O/N=2 StartLinex,StartLiney
		if(KxStart>0)
		SetScale/I x 0,3,"", StartLinex
		StartLinex=x
		endif
		if(KxStart<0)
		SetScale/I x -3,0,"", StartLinex
		StartLinex=x
		endif
		if(KxStart!=0)
		StartLiney=StartLinex*KyStart/KxStart
		endif
		if(KxStart==0)
		StartLinex=0
		StartLiney=x
		endif
		RemoveFromGraph/Z Startliney 
		appendtograph Startliney vs StartLinex
		ModifyGraph lsize(StartLiney)=2,rgb(StartLiney)=(10752,51200,1024)
		//kxEnd=hcsr(B)
		//kyEnd=vcsr(B)
		setdatafolder DataFoldername

end

proc CursorEnd_SyFS(CtrlName):ButtonControl
		String CtrlName
		String DataFoldername=root:Tempvariable:SyFS:DataFoldername
		setDatafolder root:TempVariable:SyFS
		//nvar KxStart
		Variable/G Kxend
		//nvar KyStart
		Variable/G KyEnd//=KyEnd

		//KxStart=hcsr(A)
		//KyStart=vcsr(A)
		kxEnd=hcsr(A)
		kyEnd=vcsr(A)

		make/O/N=2 EndLinex,EndLiney
		if(KxEnd>0)
		SetScale/I x 0,3,"", EndLinex
		EndLinex=x
		endif
		if(KxEnd<0)
		SetScale/I x -3,0,"", EndLinex
		EndLinex=x
		endif
		if(KxEnd!=0)
		EndLiney=EndLinex*KyEnd/KxEnd
		endif
		if(KxEnd==0)
		EndLinex=0
		EndLiney=x
		endif
		RemoveFromGraph/Z Endliney 
		appendtograph Endliney vs EndLinex
		ModifyGraph lsize(EndLiney)=2,rgb(EndLiney)=(65535,65535,65535)
		setdatafolder DataFoldername
end


proc ShowFS_Button(CtrlName):ButtonControl
	String CtrlName
	String DataFoldername=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:TempVariable:SyFS
	//String TempName=selectedWaves[0]
	variable ii=0
	do
		if(SelWaves[ii]>0)
			Break
		endif
		ii=ii+1
	while(ii<Dimsize(SelWaves,0))
	String TempName=AllWaves[ii]
	//print TempName
	setdatafolder DataFoldername
	//display $TempName
	Display;AppendImage $TempName
	string ColorTable_SyFS=root:TempVariable:SyFS:ColorTable_SyFS
	ModifyImage $TempName ctab= {*,*,$ColorTable_SyFS,1}
	//ModifyGraph width={Plan,1,bottom,left}
	Variable KxStart=root:PROCESS:KxStart
	Variable KxEnd=root:PROCESS:KxEnd
	Variable KyStart=root:PROCESS:KyStart
	Variable KyEnd=root:PROCESS:KyEnd
	ModifyGraph width={Aspect,(KxEnd-KxStart)/(KyEnd-KyStart)}
	
	SetAxis bottom DimOffset($TempName,0),DimOffset($TempName,0)+Dimdelta($TempName,0)*(Dimsize($TempName,0)-1)
	SetAxis left DimOffset($TempName,1),DimOffset($TempName,1)+Dimdelta($TempName,1)*(Dimsize($TempName,1)-1)
	ShowInfo
end



proc SymmetrizeFS_Button(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
	//variable ii//,size
	String WaveName2D//=root:TempVariable:SyFS:Name_SyFS
	String DataFoldername=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:Tempvariable:SyFS
	variable ii=0,AS,AE
	AS=AngleStart
	AE=AngleEnd
	do
		if(SelWaves[ii]>0)
			Break
		endif
		ii=ii+1
	while(ii<Dimsize(SelWaves,0))
	String TempName=AllWaves[ii]
	//print TempName
	setdatafolder DataFoldername
	Variable xmax=max(abs(dimoffset($TempName,0)),abs(dimoffset($TempName,0)+dimdelta($TempName,0)*(dimsize($TempName,0)-1)))
	Variable ymax=max(abs(dimoffset($TempName,1)),abs(dimoffset($TempName,1)+dimdelta($TempName,1)*(dimsize($TempName,1)-1)))
	//print AS,AE
	String SyName=TempName+"_Sy"
	make/O/N=(2*xmax/dimdelta($TempName,0)+1,2*ymax/dimdelta($TempName,1)+1) $SyName
	$SyName=NaN
	variable cx,cy,zx,zy
	zx=(-dimoffset($TempName,0)/dimdelta($TempName,0))+1
	zy=(-dimoffset($TempName,1)/dimdelta($TempName,1))+1
	cx=xmax/dimdelta($TempName,0)+1
	cy=ymax/dimdelta($TempName,1)+1
	//setscale()
	SetScale/I x -xmax,xmax,"", $SyName;DelayUpdate
	SetScale/I y -ymax,ymax,"", $SyName
	variable jj,kk,temA,hh,tempAS,tempx,tempy
	kk=360/(AE-AS)
	
	ii=0
	jj=0
	hh=0
	if(kk==8)
		if(AS==0)
			do
				jj=0
				do
					if(abs(ii-cx)>=abs(jj-cy))
						$SyName[ii][jj]=$TempName[abs(ii-cx)+zx][abs(jj-cx)+zy]
						//tempx=jj-cy
						//tempy=ii-cx
					endif
					if(abs(ii-cx)<abs(jj-cy))
						$SyName[ii][jj]=$TempName[abs(jj-cx)+zy][abs(ii-cx)+zx]
						//tempx=jj-cy
						//tempy=ii-cx
					endif
					jj=jj+1
				while(jj<2*ymax/dimdelta($TempName,1)+1)
				ii=ii+1
			while(ii<2*xmax/dimdelta($TempName,0)+1)
		endif
		if(AS==45)
			do
				jj=0
				do
					if(abs(ii-cx)<abs(jj-cy))
						$SyName[ii][jj]=$TempName[abs(ii-cx)+zx][abs(jj-cx)+zy]
						//tempx=jj-cy
						//tempy=ii-cx
					endif
					if(abs(ii-cx)>=abs(jj-cy))
						$SyName[ii][jj]=$TempName[abs(jj-cx)+zy][abs(ii-cx)+zx]
						//tempx=jj-cy
						//tempy=ii-cx
					endif
					jj=jj+1
				while(jj<2*ymax/dimdelta($TempName,1)+1)
				ii=ii+1
			while(ii<2*xmax/dimdelta($TempName,0)+1)
		endif
		
	endif

	//do
	//	ii=10000
	//	jj=10000
	//	jj=0
	//	do
	//	TemA=atan2(jj-cy,ii-cx)+pi
	//	hh=floor(TemA*180/pi/(AE-AS))
//
//	tempAS=mod(TemA*180/pi,(AE-AS))
//
//		if(mod(hh,2)==1)
			//tempx=(sqrt((ii-cx)^2+(ii-cy)^2)*cos((AE-tempAS)*pi/180))
			//tempy=(sqrt((ii-cx)^2+(ii-cy)^2)*sin((AE-tempAS)*pi/180))
	//		tempx=jj-cy
	//		tempy=ii-cx
//
	//		$SyName[ii][jj]=$TempName[tempx+zx][tempy+zy]

	//	endif
	//	if(mod(hh,2)!=0)
	//	
//		endif
	//	//print ii,jj
	//	jj=jj+1
	//	while(jj<2*ymax/dimdelta($TempName,1)+1)
	//	ii=ii+1
	//while(ii<2*xmax/dimdelta($TempName,0)+1)
	Display;AppendImage $SyName
	string ColorTable_SyFS=root:TempVariable:SyFS:ColorTable_SyFS
	ModifyImage $SyName ctab= {*,*,$ColorTable_SyFS,1}
	setDatafolder DataFolderName
end

Proc ColorPopMenu_SyFS(ctrlName,popNum,popStr):PopupMenuControl
	String ctrlName
	variable popNum
	String popStr
	//print popstr
	//print popNum
	String/G root:TempVariable:SyFS:ColorTable_SyFS=popstr
	//ColorTable_Combine=popstr
	//String root:TempColorTable_Combine
	String DataFolderName=root:Tempvariable:SyFS:DataFoldername
	setDatafolder DataFolderName
end

Proc Refresh_SyFS(CtrlName):Buttoncontrol
	String CtrlName
	 variable DIMS=2
	 //setdatafolder root:Tempvariable:Combine1Dto2D
	String WaveNameList=Filter_DIMS(DIMS)
	
	root:TempVariable:SyFS:DataFolderName=GetDataFolder(1)
	String DataFolderName=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:Tempvariable:SyFS
	//variable/G root:TempVariable:Combine1Dto2D:InputScale_Check=Wave
	String2FileNameWave(WaveNameList,DataFolderName)
	
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	
	setDatafolder DataFolderName
	//CreateBrowser
end

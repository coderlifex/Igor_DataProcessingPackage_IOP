#pragma rtGlobals=1		// Use modern global access method.
//This procedure is used for combining selected 1D curves to a 2D image.

Proc SyFS_ZWT(CtrlName):ButtonControl
	String CtrlName
	string curr=getdatafolder(1)
	PauseUpdate; Silent 1
	Newdatafolder/O/S root:IntegratedImage
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
	setdatafolder curr
	Refresh_SyFS(CtrlName)
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
	setvariable AngleS,pos={220,125},size={120,15},limits={0,360,15},title="Angle Start",value=root:TempVariable:SyFS:AngleStart,proc=SelectStartAngle_Sy//,disable=2
	setvariable AngleE,pos={220,145},size={120,15},limits={0,360,15},title="Angle   End",value=root:TempVariable:SyFS:AngleEnd,Proc=SelectEndAngle_Sy//,disable=2
	Button Refresh,Pos={95,225},size={80,20},title="Refresh",Proc=Refresh_SyFS


	String/G root:TempVariable:SyFS:ColorTable_SyFS="PlanetEarth"
	//Colortable="
	PopupMenu ColorPop_P,pos={190,195},size={50,15},proc=ColorPopMenu_SyFS,title=""
	PopupMenu ColorPop_P,mode=7,popColor= (0,65535,65535),value= "*COLORTABLEPOP*"//,value=root:TempVariable:ColorTable_Combine
	Button SyFS_B,pos={245,220},size={80,25},proc=SymmetrizeFS_Button,title="Symmetrize"
	Button SyFS_B,font="Arial",fStyle=1
	

	
	DrawText 190,190,"Color Table"
	
end

Proc SelectStartAngle_Sy(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	variable VarNum
	String VarStr
	String VarName
	String DataFoldername=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:TempVariable:SyFS
	make/O/N=3 SymmetrizeZonex,SymmetrizeZoney
	removefromgraph/Z SymmetrizeZoney
	AppendtoGraph/L=IL/B=IB SymmetrizeZoney vs SymmetrizeZonex
	ModifyGraph lsize(SymmetrizeZoney)=3,rgb(SymmetrizeZoney)=(65535,65535,65535)
	variable AngleStart,AngleEnd
	AngleStart=VarNum
	AngleEnd=root:TempVariable:SyFS:AngleEnd
	SymmetrizeZonex[1]=0
	SymmetrizeZoney[1]=0
	SymmetrizeZonex[0]=5*cos(AngleStart*pi/180)
	SymmetrizeZoney[0]=5*sin(AngleStart*pi/180)
	SymmetrizeZonex[2]=5*cos(AngleEnd*pi/180)
	SymmetrizeZoney[2]=5*sin(AngleEnd*pi/180)
	setdatafolder DataFoldername
end

Proc SelectEndAngle_Sy(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	variable VarNum
	String VarStr
	String VarName
	String DataFoldername=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:TempVariable:SyFS
	make/O/N=3 SymmetrizeZonex,SymmetrizeZoney
	removefromgraph/Z SymmetrizeZoney
	AppendtoGraph/L=IL/B=IB SymmetrizeZoney vs SymmetrizeZonex
	ModifyGraph lsize(SymmetrizeZoney)=3,rgb(SymmetrizeZoney)=(65535,65535,65535)
	Variable AngleStart,AngleEnd
	AngleStart=root:TempVariable:SyFS:AngleStart
	AngleEnd=VarNum
	SymmetrizeZonex[1]=0
	SymmetrizeZoney[1]=0
	SymmetrizeZonex[0]=5*cos(AngleStart*pi/180)
	SymmetrizeZoney[0]=5*sin(AngleStart*pi/180)
	SymmetrizeZonex[2]=5*cos(AngleEnd*pi/180)
	SymmetrizeZoney[2]=5*sin(AngleEnd*pi/180)
	setdatafolder DataFoldername
end

Proc SymmetrizingZone_Button(CtrlName):Buttoncontrol
	String CtrlName
	String DataFoldername=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:Tempvariable:SyFS
	KxStart=hcsr(A)
	KyStart=vcsr(A)
	KxEnd=hcsr(B)
	KyEnd=vcsr(B)
	//setdatafolder DataFoldername
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
	if(AngleStart==360)
		AngleStart=0
	endif
	if(AngleEnd==0)
		AngleEnd=360
	endif
	//print AngleStart,AngleEnd
	SymmetrizeZonex[1]=0
	SymmetrizeZoney[1]=0
	SymmetrizeZonex[0]=5*cos(AngleStart*pi/180)
	SymmetrizeZoney[0]=5*sin(AngleStart*pi/180)
	SymmetrizeZonex[2]=5*cos(AngleEnd*pi/180)
	SymmetrizeZoney[2]=5*sin(AngleEnd*pi/180)
	removefromgraph/Z SymmetrizeZoney
	AppendtoGraph/L=IL/B=IB SymmetrizeZoney vs SymmetrizeZonex
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
	String GraphN="O"+TempName
	Dowindow/K/Z $GraphN
	//if(!V_Flag)
	Display/N=$GraphN
	AppendImage/L=IL/B=IB $TempName
	//AppendImage $TempName
	string ColorTable_SyFS=root:TempVariable:SyFS:ColorTable_SyFS
	ModifyImage $TempName ctab= {*,*,$ColorTable_SyFS,1}
	//ModifyGraph width={Plan,1,bottom,left}
	//print ColorTable_SyFS
	Variable KxStart=Dimoffset($TempName,0)
	Variable KxEnd=Dimoffset($TempName,0)+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
	Variable KyStart=Dimoffset($TempName,1)
	Variable KyEnd=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
	ModifyGraph width={Aspect,(KxEnd-KxStart)/(KyEnd-KyStart)}
	
	//XJZSecondBZ(ctrlName)
	SetAxis IB DimOffset($TempName,0),DimOffset($TempName,0)+Dimdelta($TempName,0)*(Dimsize($TempName,0)-1)
	SetAxis IL DimOffset($TempName,1),DimOffset($TempName,1)+Dimdelta($TempName,1)*(Dimsize($TempName,1)-1)
	ModifyGraph freePos(IL)={dimoffset($TempName,0),IB},freePos(IB)={dimoffset($TempName,1),IL}
	ModifyGraph mirror=2,fStyle=1,standoff=0
	Label IL "\\f01\\F'Times'\\Z18Ky//(\\F'symbol'p/\\F'Times'a)"
	Label IB "\\f01\\F'Times'\\Z18Kx//(\\F'symbol'p/\\F'Times'a)"
	ShowInfo
	//endif
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
	String SyName="Sy_"+TempName
	setdatafolder DataFoldername
	variable tempx,tempy
	tempx=Dimoffset($TempName,0)+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
	tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
	//print tempx,tempy
	variable kk=360/(AE-AS)
	if(AS>AE)
		kk=360/(AE+360-AS)
	endif
	Variable tempAS=AS
	AS=-AE+AS
	variable temp//1=1//,temp2=1
	Duplicate/O $TempName,$SyName
	tempx=max(abs(Dimoffset($TempName,0)),abs(Tempx))
	tempy=max(abs(Dimoffset($TempName,1)),abs(Tempy))
	variable tempxy=max(tempx,tempy)
	tempx=tempxy
	tempy=tempxy
	if(tempxy<1.01/cos(pi/4))
		tempx=1.01/cos(pi/4)
		tempy=1.01/cos(pi/4)
	endif
	insertpoints/M=0 0,(Dimoffset($TempName,0)+tempx)/Dimdelta($TempName,0),$SyName
	insertpoints/M=0 Dimsize($syName,0),(tempx-Dimoffset($TempName,0)-(Dimsize($TempName,0)-1)*Dimdelta($TempName,0))/dimdelta($tempName,0),$SyName
	insertpoints/M=1 0,(Dimoffset($TempName,1)+tempy)/Dimdelta($TempName,1),$SyName
	insertpoints/M=1 Dimsize($SyName,1),(tempy-Dimoffset($TempName,1)-(Dimsize($TempName,1)-1)*Dimdelta($TempName,1))/dimdelta($tempName,1),$SyName

	ii=0
	do
			Duplicate/O $SyName,TempImage2
			ImageRotate/Q/A=(-ii*AS-TempAS)/O TempImage2
			duplicate/O/R=[0,dimsize(tempimage2,0)-1][(dimsize(tempimage2,0)-1)/2,dimsize(tempimage2,0)-1] TempImage2,TempIMage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			duplicate/O TempImage,TempImage1
			ImageTransform Flipcols TempImage1
			TempImage1[][(dimsize(TempImage,1)-1)/2]=0
			TempImage=TempImage+TempImage1
			
			ImageRotate/Q/A=(ii*AS+TempAS)/O TempImage
			temp=(abs(cos((ii*AS+TempAS)/180*pi))+abs(sin((tempAS+ii*AS)/180*pi)))^2
			
			SetScale/I x -temp*Tempx,temp*Tempx,"", TempImage
			SetScale/I y -temp*Tempy,temp*Tempy,"", TempImage
			Duplicate/O/R=(-TempX,Tempx)(-Tempy,TempY) TempImage,$SyName
			//print ii
		ii=ii+1
	while(ii<kk-1)
	
	Killwaves/Z TempImage,TempImage1,TempImage2
	String GraphN="Sy"+TempName
	dowindow/K/Z $GraphN
	//if(!V_Flag)
	Display/N=$GraphN;AppendImage $SyName
	string ColorTable_SyFS=root:TempVariable:SyFS:ColorTable_SyFS
	ModifyImage $SyName ctab= {*,*,$ColorTable_SyFS,1}
	ModifyGraph width={Aspect,1}
	//endif
	setDatafolder DataFolderName
end


proc SymmetrizeFS_Button_OLD(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
	//variable ii//,size
	String WaveName2D//=root:TempVariable:SyFS:Name_SyFS
	String DataFoldername=root:Tempvariable:SyFS:DataFoldername
	setdatafolder root:Tempvariable:SyFS
	variable ii=0,AS,AE
	variable temp
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
	variable dimx,dimy
	dimx=2*xmax/dimdelta($TempName,0)+1
	dimy=2*ymax/dimdelta($TempName,1)+1
	make/O/N=(2*xmax/dimdelta($TempName,0)+1,2*ymax/dimdelta($TempName,1)+1) $SyName
	
	$SyName=NaN
	variable cx,cy,zx,zy
	zx=(-dimoffset($TempName,0)/dimdelta($TempName,0))+1
	zy=(-dimoffset($TempName,1)/dimdelta($TempName,1))+1
	cx=xmax/dimdelta($TempName,0)+1
	cy=ymax/dimdelta($TempName,1)+1
	SetScale/I x -xmax,xmax,"", $SyName;DelayUpdate
	SetScale/I y -ymax,ymax,"", $SyName
	variable jj,kk,temA,hh,tempAS,tempx,tempy
	//variable tempx,tempy
	kk=360/(AE-AS)
	if(AE-AS==45)
		if(AS/45==2)
			tempx=-Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(0,TempY) $TempName,TempIMage
			insertpoints/M=0 dimsize(TempImage,0),dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=-90/O TempImage
			matrixtranspose TempImage
			//ImageTransform Fliprows TempImage
		endif
		if(AS/45==3)
			tempx=-Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(0,TempY) $TempName,TempIMage
			insertpoints/M=0 dimsize(TempImage,0),dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=-90/O TempImage
			//matrixtranspose TempImage
		endif
		if(AS/45==4)
			tempx=-Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=-Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(-TempY,0) $TempName,TempIMage
			insertpoints/M=0 dimsize(TempImage,0),dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=-180/O TempImage
			matrixtranspose TempImage
		endif
		if(AS/45==5)
			tempx=-Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=-Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(-TempY,0) $TempName,TempIMage
			insertpoints/M=0 dimsize(TempImage,0),dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=-180/O TempImage
			//matrixtranspose TempImage
		endif
		if(AS/45==6)
			tempx=Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=-Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(-TempY,0) $TempName,TempIMage
			insertpoints/M=0 0,dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=-270/O TempImage
			matrixtranspose TempImage
		endif
		if(AS/45==7)
			tempx=Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=-Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(-TempY,0) $TempName,TempIMage
			insertpoints/M=0 0,dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=-270/O TempImage
			//matrixtranspose TempImage
		endif
		if(AS/45==0)
			//duplicate/O/R=
			tempx=Dimoffset($TempName,0)+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(0,TempX)(0,TempY) $TempName,TempIMage
			//if()
			insertpoints/M=0 0,dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			//endif
			//print dimsize(TempImage,1)
			matrixtranspose TempImage
			//ImageRotate/A=45/O TempImage
			//ImageTransform Fliprows TempImage
			//print dimsize(TempImage,1)
			//duplicate/O TempIamge1
			//print 1
		endif
		if(AS/45==1)
			tempx=Dimoffset($TempName,0)+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(0,TempX)(0,TempY) $TempName,TempIMage
			insertpoints/M=0 0,dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			//print dimsize(TempImage,1)
			//ImageRotate/A=45/O TempImage
			//print 2
		endif
		
			//insertpoints/M=0 0,dimsize(TempImage,0)-1,TempImage
			//insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=45/O TempImage
			if(!mod(Dimsize(TempImage,0),2))
			insertpoints/M=0 dimsize(TempImage,0),1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),1,TempImage
			endif
			//SetScale/I x -Tempx,Tempx,"", TempIMage
			//SetScale/I y -Tempy,Tempy,"", TempIMage
			//ImageRotate/A=45/O TempImage	
			
			TempImage[][0,(dimsize(TempImage,1)-1)/2-1]=0
			TempImage[(dimsize(TempImage,0)+1)/2,(dimsize(TempImage,1)-1)][]=0
			Duplicate/O TempImage,TempImage1//,aa
			TempImage1[(dimsize(TempImage,1)-1)/2]=0
			ImageTransform Fliprows TempImage1
			//Duplicate/O TempImage1//,bb
			TempImage=TempImage+TempImage1
			
			ImageRotate/A=-45/O TempImage
			//print dimsize
			if(!mod(Dimsize(TempImage,0),2))
			insertpoints/M=0 dimsize(TempImage,0),1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),1,TempImage
			endif
			
			TempImage[][0,(dimsize(TempImage,1)-1)/2-1]=0
			TempImage[0,(dimsize(TempImage,0)-1)/2-1][]=0
			Duplicate/O TempImage,TempImage1
			TempImage1[(dimsize(TempImage,0)-1)/2]=0
			//ImageRotate/v TempImage1
			ImageTransform Fliprows TempImage1
			TempImage=TempImage+TempImage1
			
			Duplicate/O TempImage,TempImage1
			TempImage1[][(dimsize(TempImage,1)-1)/2]=0
			ImageTransform Flipcols TempImage1
			//Imagerotate/h TempImage1
			TempImage=TempImage+TempImage1
			
			duplicate/O/R=[round(dimsize(TempImage,0)/4)-1,round(3*Dimsize(TempImage,0)/4)][round(dimsize(TempImage,1)/4)-1,round(3*Dimsize(TempImage,1)/4)] TempImage $SyName
			//$SyName[0,1]=0
			//$SyName[][0,1]=0
			//$Sy
			SetScale/I x -1*Tempx,1*Tempx,"", $SyName
			SetScale/I y -1*Tempy,1*Tempy,"", $SyName
			
			
		//endif
	endif
	if(AE-AS==90)
		if(AS==0)
			tempx=Dimoffset($TempName,0)+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(0,TempX)(0,TempY) $TempName,TempIMage
			//if()
			insertpoints/M=0 0,dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
		endif
		if(AS==90)
			tempx=-Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(0,TempY) $TempName,TempIMage
			insertpoints/M=0 dimsize(TempImage,0),dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			//ImageRotate/A=-90/O TempImage
			ImageTransform Fliprows TempImage
		endif
		if(AS==180)
			tempx=-Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=-Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(-TempY,0) $TempName,TempIMage
			insertpoints/M=0 dimsize(TempImage,0),dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),dimsize(TempImage,1)-1,TempImage
			ImageRotate/A=-180/O TempImage
			//matrixtranspose TempImage
		endif
		if(AS==270)
			tempx=Dimoffset($TempName,0)//+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=-Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			duplicate/O/R=(-tempx,0)(-TempY,0) $TempName,TempIMage
			insertpoints/M=0 0,dimsize(TempImage,0)-1,TempImage
			insertpoints/M=1 dimsize(TempImage,1),dimsize(TempImage,1)-1,TempImage
			//ImageRotate/A=-270/O TempImage
			ImageTransform Flipcols TempImage
			//matrixtranspose TempImage
		endif
		duplicate/O TempImage,TempImage1
		ImageTransform Fliprows TempImage1
		TempImage1[(dimsize(TempImage,0)-1)/2]=0
		TempImage=TempImage+TempImage1
		duplicate/O TempImage,TempImage1
		ImageTransform Flipcols TempImage1
		TempImage1[][(dimsize(TempImage,1)-1)/2]=0
		TempImage=TempImage+TempImage1
		Duplicate/O TempImage,$SyName
		SetScale/I x -1*Tempx,1*Tempx,"", $SyName
		SetScale/I y -1*Tempy,1*Tempy,"", $SyName
	endif
	if(AE-AS==180)
		//if(AS==0)
			//if(AS>=0&&AS<90)
			
			tempx=Dimoffset($TempName,0)+(Dimsize($TempName,0)-1)*Dimdelta($TempName,0)
			tempy=Dimoffset($TempName,1)+(Dimsize($TempName,1)-1)*Dimdelta($TempName,1)
			Duplicate/O $TempName,TempImage2
			ImageRotate/A=(-AS)/O TempImage2
			if(!mod(Dimsize(TempImage2,0),2))
			insertpoints/M=0 dimsize(TempImage2,0),1,TempImage2
			insertpoints/M=1 dimsize(TempImage2,1),1,TempImage2
			endif
			duplicate/O/R=[0,dimsize(tempimage2,0)][(dimsize(tempimage2,0)-1)/2,dimsize(tempimage2,0)-1] TempImage2,TempIMage
			insertpoints/M=1 0,dimsize(TempImage,1)-1,TempImage
			duplicate/O TempImage,TempImage1
			ImageTransform Flipcols TempImage1
			TempImage1[][(dimsize(TempImage,1)-1)/2]=0
			TempImage=TempImage+TempImage1
			
			ImageRotate/A=(AS)/O TempImage
			if(!mod(Dimsize(TempImage2,0),2))
			insertpoints/M=0 dimsize(TempImage2,0),1,TempImage2
			insertpoints/M=1 dimsize(TempImage2,1),1,TempImage2
			endif
			temp=(abs(cos(AS/180*pi))+abs(sin(AS/180*pi)))^2
			//if(temp==0)
			//	temp=1
			//endif
			//temp=1/temp
			SetScale/I x -temp*Tempx,temp*Tempx,"", TempImage
			SetScale/I y -temp*Tempy,temp*Tempy,"", TempImage
			Duplicate/O/R=(-TempX,Tempx)(-Tempy,TempY) TempImage,$SyName
	endif
	
	Killwaves/Z TempImage,TempImage1,TempImage2
	String GraphN="Sy"+TempName
	dowindow/K $GraphN
	//if(!V_Flag)
	Display/N=$GraphN;AppendImage $SyName
	string ColorTable_SyFS=root:TempVariable:SyFS:ColorTable_SyFS
	ModifyImage $SyName ctab= {*,*,$ColorTable_SyFS,1}
	//endif
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

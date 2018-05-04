#pragma rtGlobals=1		// Use modern global access method.
Proc PictureCreating()
	PauseUpdate; Silent 1
	String TemDatafolder=GetDataFolder(1)
	DoWindow/F PictureCreating_Panel
	if(V_Flag==0)
		NewDatafolder/O root:Tempvariable
		NewDatafolder/O root:Tempvariable:CreatingFig
		NewDatafolder/O root:FrameLine
		//NewDatafolder/O root:Tempvariable:CreatingFig:TempVariable
		String/G root:Tempvariable:CreatingFig:DataFolderName=TemDatafolder
		variable/G root:Tempvariable:CreatingFig:DIMs//=2
		variable/G root:Tempvariable:CreatingFig:Columns//=1
		Variable/G root:Tempvariable:CreatingFig:Rows//=1
		Variable/G  root:Tempvariable:CreatingFig:AutoStart
		Variable/G  root:Tempvariable:CreatingFig:AutoEnd
		variable temp=root:Tempvariable:CreatingFig:Columns
		if(temp==0)
			root:Tempvariable:CreatingFig:Columns=3
			root:Tempvariable:CreatingFig:Rows=1
			root:Tempvariable:CreatingFig:DIMs=2
			//root:Tempvariable:CreatingFig:AutoStart
			//root:Tempvariable:CreatingFig:AutoEnd
		endif
		variable Columns=root:Tempvariable:CreatingFig:Columns
		variable Rows=root:TempVariable:CreatingFig:Rows
		Variable DIMS=root:TempVariable:CreatingFig:DIMS
		
		String DIMSs="DIMS:"+num2str(DIMS)
		String WaveNameList=WaveList("*",";",DIMSs)
		Variable WaveNum=ItemsinList(WaveNameList,";")
		setdatafolder root:Tempvariable:CreatingFig
		String2FileNameWave(WaveNameList,TemDataFolder)
		
		
	 	PictureCreating_Panel(Columns,Rows,DIMS)
	 	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	 endif
	 Setdatafolder TemDatafolder
end
Window PictureCreating_Panel(Columns,Rows,DIMS):Panel
	Variable Columns,Rows,DIMS
	PauseUpdate; Silent 1
	NewPanel/K=1/W=(450,50,632+Columns*135,275+(Rows-1)*204) as "Creating Fig"
	String DataFolderName=root:Tempvariable:CreatingFig:DataFolderName
	setdatafolder root:Tempvariable:CreatingFig
	root:Tempvariable:CreatingFig:AutoStart=1
	root:Tempvariable:CreatingFig:AutoEnd=Columns
	ModifyPanel fixedSize=1,framestyle=1
	if(DIMS!=1)
		DrawText 1,32,"Select 2D Image from"
	endif
	//DrawText 1,32,"aaaaaaaaaaaaaaaaaaaaa"
	ListBox AllWaves_L,frame= 4,pos={1,34},size={175,170+(Rows-1)*204}
	if(DIMS==1)
		Duplicate/O AllWaves,AllWavesx
		Duplicate/O  selWaves, selWavesx
		Duplicate/O DataPathA,DataPathAx
		InsertPoints 0,1,AllWavesx
		AllWavesx[0]="_calculated_"
		InsertPoints 0,1,selWavesx
		selWavesx[0]=1
		//AllWavesx[0]="_calculated_"
		ListBox AllWaves_L,size={175,80+(Rows-1)*102}
		DrawText 1,32,"Select Y Waves from:"
		DrawText 1,125+(Rows-1)*102,"Select X Waves from:"
		ListBox XWaves,frame= 4,pos={1,125+(Rows-1)*102},size={175,80+(Rows-1)*102},listWave=AllWavesx,mode=9,selWave=selWavesx
		

		//make/T/O/N=(WaveNum) AllWavesx
		//make/O/N=(WaveNum) selWavesx
	endif
	
	String/G  root:Tempvariable:CreatingFig:Filter_CreatingFig
	
	SetVariable Filter_V,pos={61,206+(Rows-1)*204},size={68,15},title="Filter"
	SetVariable Filter_V,value=root:Tempvariable:CreatingFig:Filter_CreatingFig,proc=Filted_CreatingPicure
	SetVariable DIMS,pos={1,206+(Rows-1)*204},size={60,15},title="DIMS"
	SetVariable DIMS,value=root:TempVariable:CreatingFig:DIMS,proc=FilterDIMS_CreatingPicture,limits={1,3,1}
	Button Refresh, pos={130,205+(Rows-1)*204}, size={45,18},title="Refresh",proc=Refresh_CreatingPicture
//	Button Expand, Pos={200,10},size={50,20},title="Expand",Proc=Expand_CreatingPicture

	setVariable Columns, Pos={2,3},Size={80,20},title="Columns",value=root:Tempvariable:CreatingFig:Columns,limits={1,20,1},proc=ColumnsExpand_CreatingPicure
	setVariable Rows, Pos={90,3},Size={80,20},title="Rows",value=root:Tempvariable:CreatingFig:Rows,limits={1,20,1},proc=RowsExpand_CreatingPicture
	
	String/G  root:Tempvariable:CreatingFig:GraphName
	
	SetVariable GraphName,pos={180,206+(Rows-1)*204},size={105,15},title="Fig Name"
	SetVariable GraphName,value=root:Tempvariable:CreatingFig:GraphName//,proc=Filted_CreatingPicure
	Button AutoAxis, pos={290,205+(Rows-1)*204}, size={60,18},title="AutoAxis",proc=AutoAxis_CreatingPicture,help={"Automatic desigin the length and position of  Axis"}
	Button NewGraph, pos={355,205+(Rows-1)*204}, size={60,18},title="New Fig",proc=NewGraph_CreatingPicture,help={"Drawing the whiole fig"}
	Button ClearAll, pos={420,205+(Rows-1)*204}, size={60,18},title="ClearAll",proc=Clear_CreatingPicture,help={"Drawing the whole fig"}
	
	SetVariable AutoStart,pos={480,206+(Rows-1)*204},size={90,15},title="AutoStart",limits={1,20,1}
	SetVariable AutoStart,value=root:Tempvariable:CreatingFig:AutoStart,help={"Select  Autoaxis Start Column"}
	
	SetVariable AutoEnd,pos={570,206+(Rows-1)*204},size={90,15},title="AutoEnd",limits={1,20,1},help={"Select AutoAxis End Column"}
	SetVariable AutoEnd,value=root:Tempvariable:CreatingFig:AutoEnd
	//Button FramLine, pos={340,175+(Rows-1)*174}, size={55,18},title="FrameLine",proc=NewGraph_CreatingPicture
	//Button ZeroLine, pos={400,175+(Rows-1)*174}, size={50,18},title="ZeroLine",proc=NewGraph_CreatingPicture
	
	//variable/G root:Tempvariable:CreatingFig:TempVariable:Fig_1_1_LeftStart=0
	//variable/G root:Tempvariable:CreatingFig:TempVariable:Fig_1_1_LeftEnd=100
	//variable/G root:Tempvariable:CreatingFig:TempVariable:Fig_1_1_BottomStart=0
	//variable/G root:Tempvariable:CreatingFig:TempVariable:Fig_1_1_BottomEnd=100
	//string aa="cc"
	//Variable/G root:Tempvariable:CreatingFig:TempVariable:$"aa"
	//make/O/N=(10,10) start
	
	variable zz
	if(Exists("LeftStart"))
		if(Columns*Rows>Dimsize(LeftStart,0))
			zz=Dimsize(LeftStart,0)
			InsertPoints Dimsize(LeftStart,0), Columns*Rows-Dimsize(LeftStart,0),LeftStart,LeftEnd,BottomStart,BottomEnd,XStart,XEnd,YStart,YEnd,AxisName
			BottomEnd[zz,Columns*rows-1]=100
			LeftEnd[zz,Columns*rows-1]=100
		else
			DeletePoints Dimsize(LeftStart,0)-Columns*Rows, Dimsize(LeftStart,0)-Columns*Rows,LeftStart,LeftEnd,BottomStart,BottomEnd,XStart,XEnd,YStart,YEnd,AxisName
		endif
	else
		make/O/T/N=(Columns*Rows) AxisName
		make/O/N=(Columns*Rows) LeftStart
		LeftStart=0
		make/O/N=(Columns*Rows) LeftEnd
		LeftEnd=100
		make/O/N=(Columns*Rows) BottomStart
		BottomStart=0
		make/O/N=(Columns*Rows) BottomEnd
		BottomEnd=100
		
		make/O/N=(Columns*Rows) XStart
		make/O/N=(Columns*Rows) XEnd
		make/O/N=(Columns*Rows) YStart
		make/O/N=(Columns*Rows) YEnd

		//make/T/O/N=(10,Columns*Rows) DatafolderSave

	endif
	

	
	
	variable ii=1
	variable jj=1
	variable kk=0
	String temptitle
	String Tempname
	String tempName_ListBox
	String TempButtonAdd
	String tempButtonDelete
	String TempLeft_Start
	String TempLeft_End
	String TempBottom_Start
	String TempBottom_End
	String TempX_Start
	String TempX_End
	String TempY_Start
	String TempY_End
	String TemSelWaveName
	String TemsSelWaveName
	String TemSelWaveNamex
	String tempDatafolderName
	String TemShowListName
	String tempName_AxisName
	
	//variable StepRows,StepColumns
	//StepRows=Floor(100.5/Rows-0.5)
	//StepColumns=Floor(100.5/columns-0.5)
	
	//StepRows=(100.5/Rows-0.5)
	//StepColumns=(100.5/columns-0.5)
	
	//TempWaveName=Wavelist("SWaveNameFig_1_1",";","")
	do	
	         ii=1
		do
			
			temptitle="Fig-"+num2str(jj)+"-"+num2str(ii)
			//tempName="Fig_"+num2str(jj)+"_"+num2str(ii)
			tempName="Fig"+num2str(jj)+num2str(ii)
			TemSelWaveName="SWaveName"+tempName
			TemsSelWaveName="sSWaveName"+tempName
			TemSelWaveNamex="SWaveNamex"+tempName
			tempDatafolderName="Folderinfo"+tempName
			if(!Exists(TemSelWaveName))
				make/T/O/N=0 $TemSelWaveName
				make/T/O/N=0 $TemSelWaveNamex
				make/O/N=0 $TemsSelWaveName
				make/T/O/N=0 $tempDatafolderName
			endif
			
			
			GroupBox $tempName,Pos={180+135*(ii-1),0+204*(jj-1)},size={135,204},title=tempTitle,font="Arial",fSize=10,fStyle=2,disable=0
			tempName_Listbox=tempName+"_ListBox"
			ListBox $tempName_ListBox frame=1,pos={180+135*(ii-1),30+204*(jj-1)},size={135,85},disable=0,listWave=$TemSelWaveName,mode=9,selWave=$TemsSelWaveName
			tempName_AxisName=tempName+"_AxisN"
			Setvariable $tempName_AxisName,pos={182+135*(ii-1),12+204*(jj-1)},size={130,15},disable=0,value=AxisName[kk],title="\Z10Axis Name"
			TempButtonADD=tempName+"zAddButton"
			TempButtonDelete=tempName+"zDelelteButton"
			TemShowListName=TempName+"zShowList"
			Button $TempButtonAdd,Pos={183+135*(ii-1),116+204*(jj-1)},size={55,20},Proc=AddWave_CreatingPicture,title="Add",font="Arial",fStyle=1
			Button $TempButtonDelete,Pos={240+135*(ii-1),116+204*(jj-1)},size={55,20},Proc=DeleteWave_CreatingPicture,title="Remove",font="Arial",fStyle=1
			Button $TemShowListName,Pos={295+135*(ii-1),116+204*(jj-1)},size={20,20},Proc=ShowList_CreatingPicture,title="?",font="Arial",fStyle=1,help={"Show the wave list in this fig"}
			
			TempLeft_Start=tempName+"_LeftStart"
			TempLeft_End=tempName+"_LeftEnd"
			TempBottom_Start=tempName+"_BottomStart"
			TempBottom_End=tempName+"_BottomEnd"
			
			
			TempX_Start=tempName+"_XStart"
			TempX_End=tempName+"_XEnd"
			TempY_Start=tempName+"_YStart"
			TempY_End=tempName+"_YEnd"
			//if(LeftEnd[kk]==0)
			//	LeftEnd[kk]=(Rows-jj+1)*(StepRows+0.5)-0.5
			//endif
			//if(!LeftEnd[kk]==0)
			//	LeftStart[kk]=(Rows-jj)*(StepRows+0.5)
			//endif
			//if(!BottomStart[kk]==0)
			//	BottomStart[kk]=(ii-1)*(StepColumns+0.5)
		//	endif
			//if(!BottomEnd[kk]==0)
			//	BottomEnd[kk]=(ii)*(StepColumns+0.5)-0.5
			//endif
			
			
			setVariable $TempLeft_Start,Pos={183+135*(ii-1),138+204*(jj-1)},size={60,15},Value=LeftStart[kk],title="L",limits={0,100,0.5}
			setVariable $TempLeft_End,Pos={247+135*(ii-1),138+204*(jj-1)},size={55,15},Value=LeftEnd[kk],title="-",limits={0,100,0.5}
			DrawText 303+134*(ii-1),151+204*(jj-1),"%" 
			setVariable $TempBottom_Start,Pos={183+135*(ii-1),153+204*(jj-1)},size={60,15},Value=BottomStart[KK],title="B",limits={0,100,0.5}
			setVariable $TempBottom_End,Pos={247+135*(ii-1),153+204*(jj-1)},size={55,15},Value=BottomEnd[KK],title="-",limits={0,100,0.5}
			DrawText 303+135*(ii-1),169+204*(jj-1),"%" 
			
			setVariable $TempX_Start,Pos={183+135*(ii-1),168+204*(jj-1)},size={60,15},Value=XStart[kk],title="X"//,limits={0,100,0.5}
			setVariable $TempX_End,Pos={247+135*(ii-1),168+204*(jj-1)},size={55,15},Value=XEnd[kk],title="-"//,limits={0,100,0.5}
			setVariable $TempY_Start,Pos={183+135*(ii-1),183+204*(jj-1)},size={60,15},Value=YStart[KK],title="Y"//,limits={0,100,0.5}
			setVariable $TempY_End,Pos={247+135*(ii-1),183+204*(jj-1)},size={55,15},Value=YEnd[KK],title="-"//,limits={0,100,0.5}
			
			ii=ii+1 
			kk=kk+1
		While(ii<=Columns)
		jj=jj+1 

        while(jj<=Rows)
        

        
	setdatafolder DataFolderName
end 

Proc Clear_CreatingPicture(CtrlName):ButtonControl
	String CtrlName
	Pauseupdate;silent 1
	dowindow/K PictureCreating_Panel
	String DataFolderName=getdatafolder(1)
	//DeleteFolder/Z root:TempVariable:CreatingFig
	Setdatafolder root:TempVariable:CreatingFig
	Killwaves/A/Z
	PictureCreating()
	setdatafolder datafolderName
	Refresh_CreatingPicture("")
	//setdatafolder root:TempVariable:CreatingFig
	
	
end

Proc NewGraph_CreatingPicture(CtrlName):ButtonControl
	String CtrlName
	PauseUpdate; Silent 1
	Variable Columns=root:Tempvariable:CreatingFig:Columns
	Variable Rows=root:Tempvariable:CreatingFig:Rows
	String GraphName=root:Tempvariable:CreatingFig:GraphName
	String DataFolderName=root:Tempvariable:CreatingFig:DataFolderName
	//String TempLeft_Start
	//String TempLeft_End
	//String TempBottom_Start
	//String TempBottom_End
	String TempName
	String TemSelWaveName
	String TemWaveName
	//String TemsSelWaveName
	String TemSelWaveNamex
	String TemWaveNamex
	String tempDatafolderName
	String TemWaveFolder,TemFrameLineNamex,TemXZeroLineNamex,TemFrameLineNamey,TemXZeroLineNamey,TemYZeroLineNameY,TemYZerolineNameX
	variable TemXStart,TemYStart,TemXEnd,TemYEnd
	variable tTemXstart,tTemYstart,tTemXEnd,tTemYEnd
	
	String AxisName_Bottom
	String AxisName_Left
	String TemXAxis
	String TemYAxis
	if(stringmatch(GraphName,""))
		GraphName="NewFig"
		root:Tempvariable:CreatingFig:GraphName=GraphName
	endif
	Display as GraphName
	dowindow $GraphName
	variable ii,jj,kk,hh,tempsize
	kk=0
	jj=1
	do
		ii=1
		do
			//temptitle="Fig-"+num2str(jj)+"-"+num2str(ii)
			setdatafolder root:Tempvariable:CreatingFig
			tempName="Fig"+num2str(jj)+num2str(ii)
			//tempName="Fig_"+num2str(jj)+"_"+num2str(ii)//+"a"
			
			//print tempName
			TemSelWaveName="SWaveName"+tempName
			//TemsSelWaveName="sSWaveName"+tempName
			TemSelWaveNamex="SWaveNamex"+tempName
			tempDatafolderName="Folderinfo"+tempName
			AxisName_Bottom="B_"+tempName+"_"+AxisName[kk]
			AxisName_Left="L_"+tempName+"_"+AxisName[kk]
			
			//setdatafolder root:Tempvariable:CreatingFig
			tempsize=Dimsize($TemSelWaveName,0)
			//print tempsize
			//print 1
			//tempsize=0
			hh=0
			if(tempSize>0)
				do	
					//print 1
					setdatafolder root:Tempvariable:CreatingFig
					TemWaveName=$TemSelWaveName[hh]
					TemWaveNamex=$TemSelWaveNamex[hh]
					TemWaveFolder=$TempDatafolderName[hh]
					//TemBottomstart
					if(hh==1)
						tTemXStart=TemXStart
						tTemYStart=TemYStart
						tTemXEnd=TemXEnd
						tTemYEnd=TemYEnd
					endif
					
					setdatafolder TemWaveFolder
					if(stringmatch(TemWaveNamex,"2"))
						//AppendImage /W=$GraphName/B=AxisName_Bottom/L=AxisName_Left  $TemWaveName
						AppendImage/B=$AxisName_Bottom/L=$AxisName_Left  $TemWaveName
						ModifyImage $TemWaveName ctab= {*,*,PlanetEarth,1}
						TemXStart=leftx2D($TemWaveName)
						//print TemXStart
						TemXEnd=rightx2D($TemWaveName)
						TemYStart=Dimoffset($TemWaveName,1)
						TemYEnd=TemYStart+(Dimsize($TemWaveName,1)-1)*DimDelta($TemWaveName,1)
						//print  tembottomEnd
					else
						if(Stringmatch(TemWaveNamex,"_calculated_"))
							Appendtograph/B=$AxisName_Bottom/L=$AxisName_Left  $TemWaveName// vs $TemWaveNamex
							TemXStart=leftx($TemWaveName)
							TemXEnd=rightx($TemWaveName)-dimdelta($TemWaveName)
							TemYStart=MinValueof1DWave($TemWaveName)
							TemYEnd=MaxValueof1DWave($TemWaveName)
							//print TemYStart,TemYEnd
							else
							Appendtograph/B=$AxisName_Bottom/L=$AxisName_Left  $TemWaveName vs $TemWaveNamex
							ModifyGraph rgb($TemWaveName)=(65280,0,0)
							//print temwavenamex
							TemXStart=$TemWaveNamex[0]
							TemXEnd=maxValueof1DWave($TemWaveNamex)
							TemYStart=MinValueof1DWave($TemWaveName)
							TemYEnd=MaxValueof1DWave($TemWaveName)
						endif
						
					endif
					//if(hh>0)
					if(hh==0)
						tTemXStart=TemXStart
						tTemYStart=TemYStart
						tTemXEnd=TemXEnd
						tTemYEnd=TemYEnd
						//print tTemYEnd
					endif
						if(TemXStart<=tTemXStart)
							tTemXStart=TemXStart
						endif
						if(TemYStart<=tTemYStart)
							tTemYStart=TemYStart
						endif
						if(TemXEnd>=tTemXEnd)
							tTemXEnd=TemXEnd
						endif
						if(TemYEnd>=tTemYEnd)
							tTemYEnd=TemYEnd
						endif
					//endif
					hh=hh+1
					//print hh
				while(hh<tempsize)
				setdatafolder root:Tempvariable:CreatingFig
				if(XStart[kk]==XEnd[kk])
					XStart[kk]=tTemXStart 
					XEnd[kk]=tTemXEnd
				endif
				//print tTemXStart
				if(YStart[kk]==YEnd[kk])
					YStart[kk]=tTemYStart
					YEnd[kk]=tTemYEnd
				endif
				//print xStart[kk],xend[kk] 
			//	print ttemXstart
				ModifyGraph axisEnab($AxisName_Bottom)={BottomStart[kk]/100,BottomEnd[kk]/100}
				ModifyGraph axisEnab($AxisName_Left)={LeftStart[kk]/100,LeftEnd[kk]/100}
				ModifyGraph freePos($AxisName_Bottom)={YStart[kk],$AxisName_Left}
				ModifyGraph freePos($AxisName_Left)={XStart[kk],$AxisName_Bottom}
				SetAxis $AxisName_Bottom XStart[kk],XEnd[kk]
				SetAxis $AxisName_Left YStart[kk],YEnd[kk] 
				Label $AxisName_Bottom "\\u#2"
				Label $AxisName_Left "\\u#2"
				//temFrameLineNamex="FL_"+GraphName+tempName+"x"
				//temFrameLineNamey="FL_"+GraphName+tempName+"y"
				//TemXZeroLineNamex="XZL_"+GraphName+tempName+"x"
				//TemXZeroLineNameY="XZL_"+GraphName+tempName+"Y"
				//TemYZeroLineNamex="YZL_"+GraphName+tempName+"x"
				//TemYZeroLineNameY="YZL_"+GraphName+tempName+"Y"
				
				temFrameLineNamex="FL_"+tempName+"_"+AxisName[kk]+"x"
				temFrameLineNamey="FL_"+tempName+"_"+AxisName[kk]+"y"
				TemXZeroLineNamex="XZL_"+tempName+"_"+AxisName[kk]+"x"
				TemXZeroLineNameY="XZL_"+tempName+"_"+AxisName[kk]+"Y"
				TemYZeroLineNamex="YZL_"+tempName+"_"+AxisName[kk]+"x"
				TemYZeroLineNameY="YZL_"+tempName+"_"+AxisName[kk]+"Y"
				
				if(ii>1)
					ModifyGraph tick($AxisName_Left)=1,noLabel($AxisName_Left)=1
				else
					ModifyGraph tick($AxisName_Left)=2
				endif
				if(jj<Rows)
					ModifyGraph tick($AxisName_Bottom)=1,noLabel($AxisName_BOttom)=1
				else
					ModifyGraph tick($AxisName_Bottom)=2
					
				endif
				TemYAxis=AxisName_Left
				TemxAxis=AxisName_Bottom
				tTemXStart=XStart[kk]
				tTemXEnd=XEnd[kk]
				tTemYStart=YStart[kk]
				tTemYEnd=YEnd[kk]
				Setdatafolder root:frameLine
				Make/O/N=3 $temFrameLineNamex
				Make/O/N=3 $temFrameLineNamey
				Make/O/N=2 $temXZerolineNamex
				Make/O/N=2 $temXZeroLineNamey
				Make/O/N=2 $temYZerolineNamex
				Make/O/N=2 $temYZeroLineNamey
				//$temFrameLineNamex[0]=Xstart[kk]
				//$temFrameLineNamex[1,2]=XEnd[kk]
				//$temFrameLineNamey[0,1]=YEnd[kk]
				//$temFrameLineNamey[2]=YStart[kk]
				
				//$temXZerolineNamex=0
				//$temXZeroLineNamey[0]=YStart[kk]
				//$temXZeroLineNamey[1]=YEnd[kk]
				
				//$temYZeroLineNamex[0]=XStart[kk]
				//$temYZeroLineNameX[1]=XEnd[kk]
				//$temYZeroLineNamey=0
				
				$temFrameLineNamex[0]=tTemXstart
				$temFrameLineNamex[1,2]=tTemXEnd
				$temFrameLineNamey[0,1]=tTemYEnd
				$temFrameLineNamey[2]=tTemYStart
				
				$temXZerolineNamex=0
				$temXZeroLineNamey[0]=tTemYStart
				$temXZeroLineNamey[1]=tTemYEnd
				
				$temYZeroLineNamex[0]=tTemXStart
				$temYZeroLineNameX[1]=tTemXEnd
				$temYZeroLineNamey=0
				AppendToGraph/L=$TemYAxis/B=$TemXAxis $temFrameLineNamey vs $temFrameLineNamex
				ModifyGraph rgb($temFrameLineNamey)=(0,0,0)
				//ModifyGraph lstyle($temFrameLineNamey)=3
				
				ModifyGraph lsize($temFrameLineNamey)=1
				AppendToGraph/L=$TemYAxis/B=$TemXAxis $temXZeroLineNamey vs $temXZerolineNamex
				ModifyGraph lstyle($temXZeroLineNamey)=3
				
				ModifyGraph rgb($temXZeroLineNamey)=(0,0,0)
				
				AppendToGraph/L=$TemYAxis/B=$TemXAxis $temYZeroLineNamey vs $temYZerolineNamex
				ModifyGraph lstyle($temYZeroLineNamey)=3
				ModifyGraph rgb($temYZeroLineNamey)=(0,0,0)
				ModifyGraph standoff($TemXAxis)=0,freePos($TemXAxis)={tTemYStart,$TemYAxis}
				ModifyGraph standoff($TemYAxis)=0,freePos($TemYAxis)={tTemXStart,$TemXAxis}
				ModifyGraph rgb($temXZeroLineNamey)=(65535,65535,65535)
				ModifyGraph rgb($temYZeroLineNamey)=(65535,65535,65535)
			endif
			
		kk=kk+1
		ii=ii+1
		while(ii<=Columns)
		jj=jj+1
	while(jj<=Rows)
	ModifyGraph margin(bottom)=40
	ModifyGraph margin(left)=40
	ModifyGraph margin(top)=7,margin(right)=7
	ModifyGraph axThick=1
	setdatafolder root:Tempvariable:CreatingFig:DataFolderName
end

Proc AutoAxis_CreatingPicture(CtrlName)
	String CtrlName
	String DataFolderName=root:Tempvariable:CreatingFig:DataFolderName
	Variable Columns=root:Tempvariable:CreatingFig:Columns
	Variable Rows=root:Tempvariable:CreatingFig:Rows
	Variable AutoStart=root:Tempvariable:CreatingFig:Autostart
	Variable AutoEnd=root:Tempvariable:CreatingFig:AutoEnd
	setdatafolder root:Tempvariable:CreatingFig
	variable StepRows,StepColumns,ii,jj,kk
	variable tempall=BottomEnd[AutoEnd-1]-BottomStart[AutoStart-1]
	//print tempall
	Variable temBottom=BottomStart[AutoStart-1]
	StepRows=(100.5/Rows-0.5)
	StepColumns=((tempall+0.5)/(AutoEnd-Autostart+1)-0.5)
	//print stepcolumns
	jj=1
	kk=0
	do
		ii=1
		do
			LeftEnd[kk]=(Rows-jj+1)*(StepRows+0.5)-0.5
			LeftStart[kk]=(Rows-jj)*(StepRows+0.5)
			if(ii>=AutoStart&&ii<=AutoEnd)
				BottomStart[kk]=((ii-Autostart+1)-1)*(StepColumns+0.5)+temBottom
				BottomEnd[kk]=((ii-Autostart+1))*(StepColumns+0.5)-0.5+temBottom
				//print BottomStart[kk]
			endif
			ii=ii+1
			kk=kk+1
			while(ii<=Columns)
		jj=jj+1
	While(jj<=Rows)
	Setdatafolder DataFolderName
	
End

Proc ShowList_CreatingPicture(CtrlName):ButtonControl
	String CtrlName
	String DatafolderName=root:Tempvariable:CreatingFig:DataFolderName
	setdatafolder root:Tempvariable:CreatingFig
	String TempName=StringFromList(0,CtrlName,"z")
	string TableName="Wave List in "+TempName
	Edit as TableName
	String Temp="SWaveName"+tempName
	AppendToTable  $temp
	temp="SWaveNamex"+tempName
	AppendToTable  $temp
	temp="FolderInfo"+tempName
	AppendToTable  $temp
	Setdatafolder DatafolderName
end

Proc DeleteWave_CreatingPicture(CtrlName):ButtonControl
	String CtrlName
	String TempName=StringFromList(0,CtrlName,"z")
	String TemSelWaveName="SWaveName"+tempName
	String TemsSelWaveName="sSWaveName"+tempName
	String TemSelWaveNamex="SWaveNamex"+tempName
	//String TemsSelWaveNamex="sSWaveNamex"+tempName
	String tempDatafolderName="FolderInfo"+tempName
	Variable DIMS=root:Tempvariable:CreatingFig:DIMs	
	String DatafolderName=root:Tempvariable:CreatingFig:DataFolderName
	setdatafolder root:Tempvariable:CreatingFig
	//variable sizeselected=Dimsize($TemSelWaveName,0)
	//Duplicate/O $TemsSelWaveName,$TemsSelWaveNamex
	//Duplicate/O $TemsSelWaveName,tempselNamex,tempselpath
	Duplicate/O $TemsSelWaveName,tempselNamex
	Duplicate/O $tempDatafolderName,TempDataFolderNamex
	
	DeleteWave(AllWaves,selWaves,$TemSelWaveName,$TemsSelWaveName,DataPathA,$tempDatafolderName)
	
	DeleteWave(AllWaves,selWaves,$TemSelWaveNamex,tempselNamex,DataPathA,TempDataFolderNamex)
	///DeleteWave(AllWaves,selWaves,$TemSelWaveNamex,tempselNamex)
	//DeleteWave(AllWaves,selWaves,$tempDatafolderName,tempselpath)
	
	
	setdatafolder DatafolderName
end



Proc AddWave_CreatingPicture(CtrlName):ButtonControl
	String CtrlName
	String TempName=StringFromList(0,CtrlName,"z")
	String TemSelWaveName="SWaveName"+tempName
	String TemsSelWaveName="sSWaveName"+tempName
	String TemSelWaveNamex="SWaveNamex"+tempName
	//String TemsSelWaveNamex="sSWaveNamex"+tempName
	//String tempselNamex
	String tempDatafolderName="FolderInfo"+tempName
	Variable DIMS=root:Tempvariable:CreatingFig:DIMs	
	String DatafolderName=root:Tempvariable:CreatingFig:DataFolderName
	setdatafolder root:Tempvariable:CreatingFig
	variable sizeselected=Dimsize($TemSelWaveName,0)
	//Duplicate/O $TemsSelWaveName,$TemsSelWaveNamex
	Duplicate/O $TemsSelWaveName,tempselNamex
	Duplicate/O $tempDatafolderName,TempDataFolderNamex
	AddWave(AllWaves,selWaves,$TemSelWaveName,$TemsSelWaveName,DataPathA,$tempDataFolderName)
	
	//Variable temp=numpnts($TemSelWaveName)-numpnts($TemSelWaveNamex)
	//Variable temp=numpnts($TemSelWaveName)-numpnts($TemSelWaveNamex)
	Variable Temp
	//insertpoints Dimsize()
	if(DIMS==1)
		AddWave(AllWavesx,selWavesx,$TemSelWaveNamex,tempselNamex,DataPathAx,TempDataFolderNamex)
		 temp=numpnts($TemSelWaveName)-numpnts($TemSelWaveNamex)
		if(temp>0)
			DeletePoints 0,numpnts($TemSelWaveNamex)-sizeselected,$TemSelWaveNamex//,$TemsSelWaveNamex
			insertpoints 0,Dimsize($TemSelWaveName,0)-sizeselected,$TemSelWaveNamex//,$tempselNamex
			$TemSelWaveNamex[0,Dimsize($TemSelWaveName,0)-sizeselected-1]="_calculated_"
			//$TemsSelWaveNamex[0,Dimsize($TemSelWaveName,0)-sizeselected-1]=0
			//print 1
		endif	
	endif
	if(DIMS==2)
		insertpoints 0,Dimsize($TemSelWaveName,0)-sizeselected,$TemSelWaveNamex//,$TemsSelWaveNamex
		$TemSelWaveNamex[0,Dimsize($TemSelWaveName,0)-sizeselected-1]="2"
		//$TemsSelWaveNamex[0,Dimsize($TemSelWaveName,0)-sizeselected-1]=0
	endif
	//insertpoints 0,Dimsize($TemSelWaveName,0)-sizeselected,$tempDatafolderName
	//$tempDatafolderName[0,Dimsize($TemSelWaveName,0)-sizeselected-1]=DatafolderName
	
	
	setdatafolder DatafolderName
end


Proc ColumnsExpand_CreatingPicure(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	variable VarNum
	String VarStr
	String VarName
	String DatafolderName=root:Tempvariable:CreatingFig:DataFolderName
	variable DIMS=root:TempVariable:CreatingFig:DIMS
	variable Rows=root:TempVariable:CreatingFig:Rows
	DoWindow/K PictureCreating_Panel
	PictureCreating_Panel(VarNum,Rows,DIMS)
	setdatafolder root:Tempvariable:CreatingFig
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	setdatafolder DataFoldername
	
end

Proc RowsExpand_CreatingPicture(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	Variable VarNum
	String VarStr
	String VarName
	String DatafolderName=root:Tempvariable:CreatingFig:DataFolderName
	variable DIMS=root:TempVariable:CreatingFig:DIMS
	variable Columns=root:TempVariable:CreatingFig:Columns
	DoWindow/K PictureCreating_Panel
	PictureCreating_Panel(Columns,Varnum,DIMS)
	setdatafolder root:Tempvariable:CreatingFig
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	setdatafolder DataFoldername
	
end



Proc Refresh_CreatingPicture(CtrlName):ButtonControl
	String CtrlName
	String TemDatafolder=GetDataFolder(1)
	String/G root:Tempvariable:CreatingFIg:DataFolderName=TemDatafolder
	 variable DIMS=root:TempVariable:CreatingFig:DIMs
	 //setdatafolder root:Tempvariable:Combine1Dto2D
	String WaveNameList=RefreshZWT(DIMS)
	root:TempVariable:CreatingFig:DataFolderName=GetDataFolder(1)
	setdatafolder root:Tempvariable:CreatingFig
	//variable/G root:TempVariable:Combine1Dto2D:InputScale_Check=Wave
	String2FileNameWave(WaveNameList,temDatafolder)
	
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	if(DIMS==1)
		Duplicate/O AllWaves,AllWavesx
		Duplicate/O  selWaves, selWavesx
		Duplicate/O DataPathA,DataPathAx
		InsertPoints 0,1,AllWavesx
		AllWavesx[0]="_calculated_"
		InsertPoints 0,1,selWavesx
		selWavesx[0]=1
		ListBox XWaves listWave=AllWavesx,mode=9,selWave=selWavesx
	endif
	String DataFolderName=root:Tempvariable:CreatingFig:DataFoldername
	setDatafolder DataFolderName
	//CreateBrowser
end

Proc FilterDIMS_CreatingPicture(CtrlName,VarNum,VarStr,VarName):SetVariableControl
	String CtrlName
	Variable VarNum
	String VarStr
	String VarName
	variable DIMS=VarNum
	//print varnum
	Variable Columns=root:Tempvariable:CreatingFig:Columns
	Variable Rows=root:Tempvariable:CreatingFig:Rows
	String DatafolderName=root:Tempvariable:CreatingFig:DatafolderName
	DoWindow/K PictureCreating_Panel
	PictureCreating_Panel(Columns,Rows,DIMS)
	setdatafolder DatafolderName
	String WaveNameList=Filter_DIMS(DIMS)
	setdatafolder root:Tempvariable:CreatingFig
	String2FileNameWave(WaveNameList,DataFolderName)
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	if(DIMS==1)
		Duplicate/O AllWaves,AllWavesx
		Duplicate/O  selWaves, selWavesx
		Duplicate/O DataPathA,DataPathAx
		InsertPoints 0,1,AllWavesx
		AllWavesx[0]="_calculated_"
		InsertPoints 0,1,selWavesx
		selWavesx[0]=1
		ListBox XWaves listWave=AllWavesx,mode=9,selWave=selWavesx
	endif
	
	setdatafolder DatafolderName
end

proc Filted_CreatingPicure(CtrlName,VarNum,VarStr,varName):SetVariableControl
		String CtrlName
		Variable VarNum
		String VarStr
		String VarName
		String DatafolderName=root:Tempvariable:CreatingFig:DataFolderName
		setdatafolder DatafolderName
		variable DIMS=root:Tempvariable:CreatingFig:DIMS
		
		String WaveNameList=Filter_String(VarStr,DIMS)
		Setdatafolder root:Tempvariable:CreatingFig
		String2FileNameWave(WaveNameList,DataFolderName)
		ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
		if(DIMS==1)
			Duplicate/O AllWaves,AllWavesx
			Duplicate/O  selWaves, selWavesx
			InsertPoints 0,1,AllWavesx
			AllWavesx[0]="_calculated_"
			InsertPoints 0,1,selWavesx
			selWavesx[0]=1
			ListBox XWaves listWave=AllWavesx,mode=9,selWave=selWavesx
		endif
		setdatafolder DatafolderName
end

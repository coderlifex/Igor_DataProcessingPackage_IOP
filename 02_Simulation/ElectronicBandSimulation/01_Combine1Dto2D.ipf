#pragma rtGlobals=1		// Use modern global access method.

//This procedure is used for combining selected 1D curves to a 2D image.

Proc Combine1Dto2D()
	PauseUpdate; Silent 1
	String TemDatafolder=GetDataFolder(1)
	NewDataFolder/O root:TempVariable
	NewDataFolder/O/S root:TempVariable:Combine1Dto2D
	String/G  DataFoldername=TemDatafolder
	DoWindow/F Combine1Dto2D_Panel
	SetDataFolder TemDatafolder
	if(V_Flag==0)
		//String Filter="*"+root:TempVariable:Filter_Combine+"*"
		//print filter
		//String/G root:TempVariable:DIMS
		//DIMS=1

		String WaveNameList=WaveList("*",";","DIMS:1")
		Variable WaveNum=ItemsinList(WaveNameList,";")
		SetDatafolder root:TempVariable:Combine1Dto2D
		make/T/O/N=0 SelectedWaves,allwaves,DataPathA,DataPathS
		make/O/N=0 sselWaves,selWaves
		//if(WaveNum==0)
		///	DoAlert 0, "Are you kidding me! Make sure you have at least 1D wave in this folder"
		//endif
		//Variable WaveNum=ItemsInList(WaveNameList,";")
		String2FileNameWave(WaveNameList,DataFolderName)
		//variable ii=0
		//make/T/O/N=(WaveNum) AllWave
		//make/O/N=(WaveNum) selWave
		//selWave=0
		//do
		//	AllWave[ii]=StringFromList(ii,WaveNameList,";")
		//	ii=ii+1
		//while(ii<WaveNum)
		Combine1Dto2D_Panel()
		ListBox ALLWaves_L listWave=AllWaves,mode=9,selWave=selWaves
		//ListBox SelectedWave_L listWave=AllWaves,mode=9,selWave=selWaves
		ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
	endif
	SetDataFolder TemDatafolder
end

Window Combine1Dto2D_Panel():Panel
	PauseUpdate; Silent 1
	
	NewPanel/K=1/W=(800,100,1250,520) as "Combine 1D Curve to 2D Image"
	ModifyPanel fixedSize=1,framestyle=1
	DrawText 1,18,"Select 1D Waves"
	DrawText 224,18,"1D Waves for Combining"
	
	String/G root:TempVariable:Combine1Dto2D:Filter_Combine
	SetVariable Filter_V,pos={100,3},size={68,15},title="Filter"
	SetVariable Filter_V,value=root:TempVariable:Combine1Dto2D:Filter_Combine,proc=FiltedWaves_Combine
	
	//Button Add1DWave_B,pos={178,140},size={20,20},proc=Add1DWave//,title="A"
	Button Add1DWave_B,pos={180,140},proc=Add1DWave,title=""
	Button Add1DWave_B,picture= ProcGlobal#ADDButton//font="Arial",fStyle=1,picture= ProcGlobal#LeftButtom
	Button Delete1DWave_B,pos={180,165},size={20,20},proc=Delete1DWave,title=""
	Button Delete1DWave_B,picture= ProcGlobal#DeleteButton
	
	//DrawPict 198,144,1,1,ProcGlobal #Add1DWaveButton
	//DrawPict 198,169,1,1,ProcGlobal #Delete1DWaveButton
	//DrawPict 400,140,0.8,0.8,ProcGlobal #UpButton
	//DrawPict 400,166,0.8,0.8,ProcGlobal #DownButton
	Button Up_B,pos={410,133},size={20,20},proc=UP1DWave,title=""
	Button Up_B,picture= ProcGlobal#UpButton
	Button Down_B,pos={410,172},size={20,20},proc=Down1DWave,title=""
	Button Down_B,picture= ProcGlobal#DownButton
	
	ListBox ALLWaves_L frame= 4,pos={1,20},size={175,300}
	ListBox SelectedWave_L frame= 4,pos={226,20},size={175,300}
	
	variable/G root:TempVariable:Combine1Dto2D:InputScale_Check
	CheckBox InputScale_C,Pos={2,327},size={20,50},title="Input Scale",proc=InputScale_Combine,value=root:TempVariable:Combine1Dto2D:InputScale_Check
	
	Button Refresh,Pos={95,323},size={80,20},title="Refresh",Proc=Refresh_Combine
	Button Clear_Combine,Pos={320,323},size={80,20},title="Clear",Proc=Clear_Combine
	
	Variable/G root:TempVariable:Combine1Dto2D:InverseAxisv_Combine
	CheckBox InverseAxis_C,Pos={226,395},size={20,50},title="Swap X and Y Axes",proc=InverseAxis_Combine,value=root:TempVariable:Combine1Dto2D:InverseAxisv_Combine
	
	GroupBox SetScale_G,pos={18,342},size={110,55},title="Set Scale",Disable=1
	GroupBox SetScale_G,font="Arial",fSize=10,fStyle=2
	
	
	variable/G root:TempVariable:Combine1Dto2D:StartScale_Combine
	variable/G root:TempVariable:Combine1Dto2D:EndScale_Combine
	SetVariable StartScale_V,pos={23,357},size={100,20},title="Start",value=root:TempVariable:Combine1Dto2D:StartScale_Combine
	SetVariable StartScale_V,limits={-10000,10000,1},Disable=1
	SetVariable EndScale_V,pos={23,377},size={100,20},title="End ",value=root:TempVariable:Combine1Dto2D:EndScale_Combine
	SetVariable EndScale_V,limits={-10000,10000,1},Disable=1
	
	String/G root:TempVariable:Combine1Dto2D:ColorTable_Combine="PlanetEarth"
	//Colortable="
	PopupMenu ColorPop_P,pos={226,345},size={50,15},proc=ColorPopMenu_Combine,title=""
	PopupMenu ColorPop_P,mode=7,popColor= (0,65535,65535),value= "*COLORTABLEPOP*"//,value=root:TempVariable:ColorTable_Combine
	Button Combine_B,pos={345,393},size={80,20},proc=Combine1Dto2D_Button,title="Combine"
	Button Combine_B,font="Arial",fStyle=1
	
	String/G root:TempVariable:Combine1Dto2D:Name_Combine
	SetVariable Name_V,pos={226,372},size={200,20},title="2DWaveName"
	SetVariable Name_V,value=root:TempVariable:Combine1Dto2D:Name_Combine//,proc=FiltedWaves_Combine
	
	DrawText 226,338,"Color Table"
	
end

proc Combine1Dto2D_Button(CtrlName):ButtonControl
	String CtrlName
	variable ii//,size
	String WaveName2D=root:TempVariable:Combine1Dto2D:Name_Combine
	String DataFoldername=root:Tempvariable:Combine1Dto2D:DataFoldername
	String tempDatafolder
	if(stringmatch(WaveName2D,""))
		WaveName2D="Combined2DWave"
		root:TempVariable:Combine1Dto2D:Name_Combine=WaveName2D
	endif
	//print WaveName2D
	//wave tempWave
	//print dimsize($selectedWaves[0],0)
	//display tempwave
	ii=0
	setdatafolder root:TempVariable:Combine1Dto2D
	variable DIMS=DimSize(sselWaves,0)
	String TempName=selectedWaves[0]
	String TempPath
	setdatafolder  DataFoldername
	make/O/N=(Dimsize($TempName,0),DIMS) $WaveName2D
	do
		setdatafolder root:TempVariable:Combine1Dto2D
		TempName=selectedWaves[ii]
		TempPath=DataPathS[ii]
		setdatafolder TempPath
		duplicate/o $TempName,TempWave
		//$WaveName2D[][ii]=$selectedWaves[ii][p]
		setdatafolder  DataFoldername
		$WaveName2D[][ii]=tempWave[p]
		ii=ii+1
	while(ii<DIMS)
	tempWave=x
	SetScale/I x tempWave[0],TempWave[Dimsize(tempWave,0)],"", $WaveName2D
	KillWaves/Z tempWave
	variable InputScale_Check=root:TempVariable:Combine1Dto2D:InputScale_Check
	variable StartScale_Combine=root:TempVariable:Combine1Dto2D:StartScale_Combine
	variable EndScale_Combine=root:TempVariable:Combine1Dto2D:EndScale_Combine
	if(InputScale_Check)
		SetScale/I y StartScale_Combine,EndScale_combine,"", $WaveName2D
	endif
	variable InverseAxisv_Combine=root:TempVariable:Combine1Dto2D:InverseAxisv_Combine
	if(InverseAxisv_Combine)
		Matrixtranspose $WaveName2D
	endif
	string ColorTable_Combine=root:TempVariable:Combine1Dto2D:ColorTable_Combine
	Display as WaveName2D;AppendImage $WaveName2D;DelayUpdate
	ModifyImage $WaveName2D ctab= {*,*,$ColorTable_Combine,1}

	setDatafolder DataFolderName
end

Proc Down1DWave(CtrlName):ButtonControl
	String CtrlName
	setdatafolder root:Tempvariable:Combine1Dto2D
	DownWave(SelectedWaves,sselWaves,DataPathS)
	ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setDatafolder DataFolderName
end

Proc UP1DWave(CtrlName):ButtonControl
	String CtrlName
	setdatafolder root:Tempvariable:Combine1Dto2D
	UPWave(SelectedWaves,sselWaves,DataPathS)
	ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setDatafolder DataFolderName
end


Proc Add1DWave(CtrlName):ButtonControl
	String CtrlName
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setdatafolder root:Tempvariable:Combine1Dto2D
	//variable sizeold
	//sizeold=Dimsize(SelectedWaves,1)
	ADDWave(AllWaves,SelWaves,SelectedWaves,sselWaves,DataPathA,DataPathS)
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
	//String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	//setDatafolder DataFolderName
	
	//insertpoints 0,Dimsize(SelectedWaves,0)-sizeselected,DataPath
	//DataPath[0,Dimsize(SelectedWaves,0)-sizeselected]=DataFolderName
	
	setDatafolder DataFolderName
end

Proc Delete1DWave(CtrlName):ButtonControl
	String CtrlName
	setdatafolder root:Tempvariable:Combine1Dto2D
	//duplicate/O sselWaves,tempsselwaves
	DeleteWave(AllWaves,SelWaves,SelectedWaves,sselWaves,DataPathA,DataPaths)
	//DeleteWave(AllWaves,SelWaves,PathName,temsselWaves)
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setDatafolder DataFolderName
end

Proc InputScale_Combine(Name,Value)
	String Name
	Variable Value
	variable/G root:TempVariable:Combine1Dto2D:InputScale_Check=value
	//StrSwitch(Name)
	//	Case
	//EndSwitch
	setdatafolder root:Tempvariable:Combine1Dto2D
	if(Value==1)
		SetVariable StartScale_V,Disable=0
		SetVariable EndScale_V,Disable=0
		GroupBox SetScale_G,Disable=0
		//InputScale_Check=1
	else
		SetVariable StartScale_V,Disable=1
		SetVariable EndScale_V,Disable=1
		GroupBox SetScale_G,Disable=1
		//InputScale_Check=0
	endif
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setDatafolder DataFolderName
end

Proc InverseAxis_Combine(Name, Value)
	String Name
	Variable value
	Variable/G root:TempVariable:Combine1Dto2D:InverseAxisv_Combine=value
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setDatafolder DataFolderName
end
// PNG: width= 30, height= 17
Proc ColorPopMenu_Combine(ctrlName,popNum,popStr):PopupMenuControl
	String ctrlName
	variable popNum
	String popStr
	//print popstr
	//print popNum
	String/G root:TempVariable:Combine1Dto2D:ColorTable_Combine=popstr
	//ColorTable_Combine=popstr
	//String root:TempColorTable_Combine
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setDatafolder DataFolderName
end

Proc FiltedWaves_Combine(ctrlName,varNum,varStr,varName):setvariablecontrol
	String ctrlName
	Variable varNum
	String varStr
	String varName
	variable DIMS=1
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setdatafolder DatafolderName
       String WaveNameList=Filter_String(VarStr,DIMS)
       setdatafolder root:Tempvariable:Combine1Dto2D
       String2FileNameWave(WaveNameList,DataFolderName)
       ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	
	setDatafolder DataFolderName
end

Proc Refresh_Combine(CtrlName):Buttoncontrol
	String CtrlName
	 variable DIMS=1
	 //setdatafolder root:Tempvariable:Combine1Dto2D
	String WaveNameList=RefreshZWT(DIMS)
	
	root:TempVariable:Combine1Dto2D:DataFolderName=GetDataFolder(1)
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setdatafolder root:Tempvariable:Combine1Dto2D
	//variable/G root:TempVariable:Combine1Dto2D:InputScale_Check=Wave
	String2FileNameWave(WaveNameList,DataFolderName)
	
	ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	
	setDatafolder DataFolderName
	CreateBrowser
end

Proc Clear_Combine(CtrlName):ButtonControl
	String CtrlName
	//String CurrentDatafolder=GetDatafolder(1)
	Setdatafolder root:TempVariable:Combine1Dto2D:
	make/T/O/N=0 SelectedWaves,DataPathS
	make/O/N=0 sselWaves
	ListBox SelectedWave_L listWave=SelectedWaves,mode=9,selWave=sselWaves
	String DataFolderName=root:Tempvariable:Combine1Dto2D:DataFoldername
	setDatafolder DataFolderName
	CreateBrowser
end







// PNG: width= 114, height= 25
Picture AddButton
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!">!!!!:#Qau+!+LoSZN't*$#iF<ErZ1M_Z0ZH_Z@erW+5l.$;G5%6Vp
	TmDffo=BQ%i48OGifE,ol/Bl%>\!-m4g;g2?-pD,sMpLOk96J1e4QY_3Q+sX/pa:MLK&<[$%KFeb]`
	J'*T<YQ8\S4HYuK%13!SVZ9u.(EnUMMPGo<EqNO+5Ed%I<tALmJGN4]]YgJr6BT6%tG6)-B[GbC&g7
	lKfhEK+-02g`6#]C!Yn8a"<\9<bJIlq`;fo-"*o-?FKe"-!O$DA!W[2i/gM(MiW"PA:aT6D+HZZ^+q
	j&H!K^1Za=^H5'EH2k!3fD.A-r=$!!$h\HpT"WWXSspoLV4M!8+97g_TtCU)^-<!0%!ZR4(QN!^O?t
	?r_bU/-<W(!2-DY+ta#6XoX&U[PC>SJ@u*dG)f[d%mXM&J=/_TbQ&bF!WYS/'?pV%9EUqAd_F_>?Z:
	_/8-&_+bE^>=9@>U1\<YDZGOk7]iZ[<uCp?<8(F]o-$03;#Q^]358EU(Kc3s[Q)Yqdsr]!-(kN:jak
	%<dmn+=SnrbM"A,!I1?hu:9I!X&K7:=&C_?fgD#")u9]Y][]rWETAV<WHgjq->f2$(tH/d!GMGGrY^
	e*hK'%a?1I_$4@7/-"<R]0]S'Ts"iVPi/<'Xr'2>&gNr>hELK.\Xh^]arGc7`G-4`'kK<up0lHaK,Q
	>`;J,PBVdGd!f>V$VInQ:XX:a/WSH+?h86m9[;iY(L*1@ZHPr<\[3%03Ja:V]`6#IV`k^jb\P!fIOj
	dWPUUIe,.M)@MZ-&8*gTH1q:=PJ?pS5Uuj8c'P6d!!'[q(gO#((JMgS!!#E[JL[li#7SE_XM>=9_&^
	2((BS"L6pM/+^cW/p#3::S$DA<&5oEY;3nOSCYQGf:&XqYi[)"IV%HlX^>_23[(C"7aT#)>WL'[uKa
	9WGf+ZbDk@ZK(bc3P5SNW^P782QK[U`eoX'N$'naE"'XWBt?^>t?42/TMOcNEeaFOP@i!15c!e]LO]
	@J[/,Te,jbX\YpSgMT2<1d<%2U?%A68CXF'-*^,%^U8QC3k]LtII>X%pJC-(]ArPDO>`=G,@#7u(-H
	?m3j]FB@O#:Df=>tC<)o/%Rmg(0?MguK-#[W/q_JFgcO@NDH=@9#5lm&kM\d2@DK7ktr-R+bQ:UDEo
	')BIj@QLcU=@TA=mNEVpSg@\j%MN3580e\eP2o@F+XN4*8IJ+*8D?ZeUf4'QdL^,_9IB(eD9:Yq#dS
	u^+IA5"O:RFKP5EA=jL5ga`JEMI$)/\CUm)Ka2.]#6"Jq_G6CFLH;9c)3e-N(13hKSID4l&K02mY*'
	/Xj#--_np6d)8WUXd_[BkM/SBJ8Ul\d@2F*^uFBQdT[5#O1F9KCj?r%>G=Ea%0Yf)/C+:)5e=\))%C
	OV?PG8RE/>]f.n;5B:'3sDcKmhp*tG)Oie<%3gEa2I[0)r<)n!>5Lk%Z$WO0,&$'#;IATJ6ZV]\]$.
	K`keYsQh];[]kc;JjaO&4/"?_b>BrIXlU%C1_B7\GK,UJta4`YjaZ(</+@nQ8-/E`N;./8LVI@U$/6
	lqDR+q\s]3HV@@*F/iiRAs$\rk&JWH%`Yd3n2]0l9$SU*%F0;P""c_hZ.<ZlB!$Na2qiT3^=m&`EpX
	Y0le:fME1K7b/=lGpD*%E6$+`%+;7_ImgNCj-51=$-H0GY.b4Q8/h9eacD=jUr([CJ?n'N490Jj%nO
	;Vjh3+MI%OCRKiQta(Xn:]c!&^+k!Oi1q.d7L)\\0gX!BB(jo(HuH4D]E5f1u;g!CHQ$7BenG=`2(B
	5^+%<kCRSkHdBqAEbfn-ZgoT/0am>$JeXUEH@D:F-g\d%bV+$on8rGTca-PGFI*2\Z9pYOTQrZCOGu
	jT=f;qQp>jEs,D:Vd):`EK*%%B;IbI4@OS#sVPRr.$siY7G&dOFifDV?i3r9OdWRd:7G3VHnT-2)3L
	cQ14L&foObF?=kjFEPfNCiI&QUu=/JWPkdRkuVL:B;'C;o/.>]99@=0QZe]3;f/FiVf&,QbE_0-m^g
	iSe+KK*]:7TXfko6pbWWpnX8>UDRiBIT_`dHSo^MTWic33&SYqsT_XilP04&g.=^M!=*`',4-D&dBD
	91JM>N!3<HXJlu4_=K8klX,h4p%@&T81.X^*;Gt^*A*XI[PWir1<dIqTJhupqPd5neUaj"^hAI!Ta?
	qJJs*G")@u\"ITCh#;l[E"hOsl$pGCm$jdAG+**Q`^_cP\q-u59B.TM!(!6fQ'j;RQ0[(k;*nCp`L<
	g._&:SPpq+U%s[Kq]I7r4!k+))U\(\rIn.4R*Q0'Z<@;fm#$pFOmsjB;@m]oMWDWJnALgM40;G%[mk
	Cf5(Zm$kM8\>m&iG_c&_nWsl1'-mnOM<)V-`'&t;ErtN@RPUJpRT,SpA$4qKU:D*&l-@JDG<B"c=ce
	"jKpWL>Z9RH'+@8mX(f07kDG;,bnq<Kd:IW!lNM9:T\%#$mP3/<9Q1d2n4+0KmBSK;PFiH3D:Jr]gO
	Vs=m,P+W17+U4rce3<k/NK&cPanLH%;D-8/(ZJa.(;ua.k?emjE]m)ar?P"b4jsAq/c/^'l8RtdA+'
	HY##TD9J<=pGZu"hGdp;X86XM!he)lQq'-9!(4<fWYY_j6Ze2d4=n1Do^I>aM,E#J:G:kUU;S$C`C%
	0Q!b@o))QMjY>=Ai/iC3eV*N`(MXV56O0JladoWKbNJDQ`V8\RQ@_Q"3n`C7!IT<duS8Q!^V3XJi;s
	YXZ.bi`Al^eU7%8D;*_#9"2t1lU^?;lY`fu=hh.4]kTj`d"_$!XW-eijVqQD9&=Z`H><,5c*Ya<bl]
	h32=4Vl[]J6STf/\>HC]Okb?"SDX1,gr-JI%ch045;%YGc:45TFjm(B_VGZS[o7=FiHddD_CNuDIH]
	"dBVh7,t!:W8odH_l&op-nH9C34B1gonK-Z3bAG2N8bK3cO2MJ8a/2m@&7,E*=_$_Em;"-f:eKHfIr
	dU!CR2_p.),J%,(VlUZ:OdQ5-cX=^2aTKT!^n*#_*SK2#W8%uJ4Id]#O@s,gLO&qpGSL?Ykq;d-kj/
	6FcSt/V@4k,nTH1t#1R;6)*?+jl<c^m?;FRDi3?h_\6hWKr*n@W`4,55R$-+?OL4g$q<IW58E8?Z69
	lXfh6m8lEQFS&;n443NGJ,3oqeT9@;f.L@$H+i[dll3EO-J]ZO-+`dEG4t;>G7*b3gg,5eGd%%ZgAU
	:Aq@Dk@[/R=A^hr$)@)-0r_c[N=%LIo^rfmH3LZ-ZObX^2.7O*nRSKApm%2uqNABpCtVm<36ccU];s
	*<pOX68C=iqlBp=T$h@$i,_,^TMj]o5a<#WNSA',KCn=c?VSCVYmRAgO8P#n%.Ds]cWXjr':6Xo?mD
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!!.75tsWF!3qQ3qb`OW!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-
	Ksq!:!ql!'6JI!#KR:?c>J7!!Ptd6pXdsg>#iS9C#7cT:*Wu'jV,H.':!Y>_ib&61BHkq>d.D\5<s6
	$c+%@<>?T(W$&7$f#L,W!#9T!>".5&$W3p)>2S$`2GHl7],5FQS&Bd+[/&XOeP(!=^RX2OS2oa8EZB
	:FFL89Vi-)`K*t\VV6:aiP!9=k`9i4XaG\1Q";c?V?H$OFNE[VXMl#`\qUT:Gr+Hb+)fJkQ=^b?/s5
	\!4Yo^m6?C<C"jjQG]!aMKcjKT]8R9MS#C79[Z]cfZ5f*JG&*<)i('3fCt_]=Y,qlcE_u-kJ]NiS*#
	>rVc]eoJ?P5@mnu)gt^H1<E<.T&-;i"+q^nB1A-nCI`3bH)0jE(Vl._]bF+cdSt;OESXm0r[Cj/b]Y
	(mJ,a&G:JImRRiR?7S\(b1e;Zd$H(m.!H5M,5oR+'[==,u>1R.NIc&<K^>nT"+8KJ4$qGW_RUM[Plp
	e^;dL]Y'c"Q'Ii.$NOR;QK'sDn=iA`64Cc-VPZ*WZa-k\#_L'P1aWe7i:m+OQ3@8A_r9f6<)NA_p.@
	tNjVr_aj`s$($AHB+&P`l?Q=W9E5'W\!Z&r(fFaSRAdE%B0O6>]hQ^=%tN"#(c&N1SXWgGk!AB994M
	KHpH#[aR7YM\6pa-ql95R8fr_JasCYq4)i]Vti40c1="X&\[*63n`&;%t'bN@84*16ihR,ZEb(93kh
	obN0qcY2nM=%.bs`5(g\uhr"I9K1,l1RRH^k4=):"C*7;-CRn45<E5<3LV>g$gY:Hj$O]tg3B/uX1,
	9K;^'9BaZrR_@PK@ocE1h5->?b=&:8]3?,`,B=)Mc4MI!i".1c$q/G^)2;AIT35`8L"Km)-_.Q&pEB
	I7m4+Z0THLcLgaNNL>cXLr>?Rr)AYFA)*K;5lC5t,'aM!+Z,T\EFF$.DCuJ+`0-b3dE]#%Z0LUh/X_
	kK,'i.#_kPOl>[Li>$#-m'(Ddn0@Ouiak\rMo?EZstSPE6h=W+it-3B<1bX-8L:fg_r'$k0r[C*E](
	^KOJD(lf+Jhdb@]tGG5<fdST=tqi+GW\D`74Q-NVP[O#=qF$1d#d;mM9(#D!:TCF6UO4O55r;>,'bE
	uqYE6*S@5l7.[Cp.[SX<s2$tOjR-O3dMMmDQ_Ps>t(aZEcA"<N5>6R=&\[bS`WRL+5XK3,j$ee_XnF
	3)^Q1^c*J&PH`d<L"b.kfuFc"YT,nK9>4$NREF^0XuH.]*lB'bjeo3#iE`j(GgFbfg%e]O('F`5K-b
	O$k3:8S:Gu>i(/XRolJT36%JGb2S!s^PQVI.p<dVQAQSK3YI9?:,,Fq4:]NGe7'm7+XI#Nluhh\n+6
	?oG<?iT$\EoN7=R^brEc[OEcP(WrZ&t`/;k(VE;2T(7&9L%rS-(rhs^=8I)02%[mX^TMBn-nB4mER2
	7Z%-)"`-f*671%jS\lI$QFpAgC1uu1"'sK.s@/0_-eAsi-CokC!fAV7&6qclg3tSGB`fYqtoF6,>HY
	EJs$)MOt0?C'aOr.QBliDHOC/fb\$J/k2t@M=`SQRoCFcpaS6*/kk"E;lKX8(BsZJD#_L'POQ3j1NK
	&pW%@>9"p\V37PK-N7c],(M?Df2$-RYgcTqSp'2Dm@WkP<EKcBFG*K[A2s;iI^QG;l"gktid-<E1n@
	57[b@(_MKhTqnK[Xf\_;]/qbL8A%`]"%9]#3)*%=X0/U#8P-aJm4!pug[-LA.j0u&eC8$8g$l1*N=g
	XN!$_=X:^C+tR/d3e!(fUS7'8jaJc
	ASCII85End
End

// PNG: width= 153, height= 34
Picture DeleteButton
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!">!!!!:#QOi)!6Bj?2uipY$#iF<ErZ1J'*&"?'*/*%S/;5+!uYf?6Vp
	TmDffo=BQ%i48OGifE,ol/Bl%>\!-m4-?soSaki1[G,f%2l:fL?R*on.U&K.F\I\)+MJXM(?JUr@q0
	tFg00d+8eJUr@q00_+T!<[_]`k][2^qanlf?qRZQ%:d-RTrZg_SEs+J:W9f-mc8\R=TqJ$NgJuH?i(
	J#m19>$j-Ta85aUs#m19>!<WFV89ROc1BR_h$NgJE:J#:i#m183K6)K-APm&c7Yu_jV5:#?@nM2JW^
	:Z9ECjn_Z%?UpEdgkOISjQGC'k%F"4Reb"pP9<Qi%I"pVb9<"[c3g"tG7]a=%5an3MjR5]UR9)2,uM
	^qd`.^nA[)a&'m^MW"T21h.6[4N=9mL.i%MQ^BXt)k$0#fW`S0AS02!]uoKU[Y\:DI3s^L7jfZ7B/:
	>[<uX(WpI$&OSu'*>]SH96q4@+X$O@'?(3C4;,h+6D."#,B?'JE4X&tlOVta;L'M2`TUJ_iT]$aAbk
	/`;"$-Jg(mnrROjAijc1dsDs77lUKl;k;^F[$=<NOPARZmKOcl<*?Zl+YS-U-IP.`\>QVdTFrm\&ge
	^_e(FCq^j9K'<QY`/SnC'7I4.C^=keq\F"OWl'V'KQ`[FVh,_*?oiU:ccte4,6D)62bPYE:Y7K8(\2
	WVRnG//MU!LTi6nh%:7O^bFa10)X`T>(J,g9$=S9-[bGq)a]>e3X!<+].]XR&)1p[X^BeI-a3Mi20`
	+"hhC-;j2/;-5i^l>6.N>.qNBqFM.:)Lj[b[%t1VCV/FHf]h5BhL2o#U!LHfDSj,Es!Km'Bq9QZ3q&
	$cRBpKgR\MaLADY$(>RSFb/RJ?pWPc"Jb9*lD?IcX`k$$S`:$Z_81t^<_q8$+4D,[onf]g"`eK0aal
	2-J_:d<TXkk,P&URR=&T;XpKjL"ZL/a$Zj[pSoP.IQc+Wts<Qh%79QHL'mfoXd'Nq`Hk-aRo#fVi&f
	4^(>\FopY\Nh:nRj90[h#<:K_>f=Z%jIcUP,n@SJA[sqEXrrW6N^E&4'Dc'^=!!!.75tsWF!3qQ3qb
	`OW!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c>J7!!5Y^6pXdsg:Z!2BG3ZG
	#Oqb?44;]Q(b/PlGS-2*c*J5P_+T^E_%[K.'@aol/WF-1P%mf]N$(9=Jo))q7R[G5.c)ZM6)th:C=*
	eqd@+l0+$1N%VCnF19G"e5S`Roh^Kl$G/X7B:bs?\EO7ft`3`8n&L%mY57S5c^:$dQB2hYFfit;06Q
	VN+qhSMu(.5<T"aFZq@9Y-'[FS<]A?(S3GWkEbIJrp[Q[TW0*M*i$0B&:fK-FS*8/Sc87B>$)MNKbP
	nYs<bVfj7Zh\L8>WDP?>393bI3/**$XbnQ@0'gtGX%o/>R?m[Sc<gec"'!W!ZZ*?Xo8Ru]*]1+t'Nr
	?-oNO,VU_"Q=:iJt_E_A49->"t'IX%)00gWGhfh6ha!UDoG43lC*;RjGqM<\''Z4OJY_q-/%O&eFVV
	(aM"@!W^X^8sKnC@n<`t9T+c/^cnK'p.Slie5<6u5`:L#TJLjcl$<H"O3]F/eXh?C<;lJ-1s*[)PK]
	ohmmj[<R>k!en;:**U/@dgX_`7PLlIp6o+)>HbJQ'5p0op]%+OGGoqeA9r&k/erO$q,G&F%-\'eWUW
	io%?'iK?cB#!X(+iQRAZHL[[7S6)?$Qk]es3f1'MU5_&8t4Q]W[4Ql,=tmJ`Lg-Rc'5`&3qMC4cjW1
	EFSE_f=&7\^jXn`IjN;+T:`:d'1A>,l8]SCPTA8WNJ&C/H2k!0Lrtp\/(#$[j=?G_**KBu'B-eppr1
	WhFe6o*O$ijJ6"X!E??2=O$!!#SZ:.26O@"J
	ASCII85End
End

// PNG: width= 101, height= 50
Picture DownButton
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!!l!!!!F#QOi)!&*)")uos=$#iF<ErZ1J'*&"?'*/*%S/;5+!uYf?6Vp
	TmDffo=BQ%i48OGifE,ol/Bl%>\!-m4-?soSaki1[G,f%2l:fL?R*on.U&K.F\I\)+MJXM(?JUr@q0
	tFg00d+8eJUr@q00_+T!<[_]`k][2^qanlf?qRZQ%:d-RTrZg_SEs+J:W9f-mc8\R=TqJ$NgJuH?i(
	J#m19>$j-Ta85aUs#m19>!<WFV89ROc1BR_h$NgJE:J#:i#m183K6)K-APm&c7Yu_jV5:#?@nM2JW^
	:Z9ECjn_Z%?UpEdgkOISjQGC'k%F"4Reb"pP9<Qi%I"pVb9<"[c3g"tG7]a=%5an3MjR5]UR9)2,uM
	^qd`.^nA[)a&'m^MW"T21h.6[4N=9mL.i%MQ^BXt)k$0#fW`S0AS02!]uoKU[Y\:DI3s^L7jfZ7B/:
	>[<uX(WpI$&OSu'*>]SH96q4@+X$O@'?(3C4;,h+6D."#,B?'JE4X&tlOVta;L'M2`TUJ_iT]$aAbk
	/`;"$-Jg(mnrROjAijc1dsDs77lUKl;k;^F[$=<NOPARZmKOcl<*?Zl+YS-U-IP.`\>QVdTFrm\&ge
	^_e(FCq^j9K'<QY`/SnC'7I4.C^=keq\F"OWl'V'KQ`[FVh,_*?oiU:ccte4,6D)62bPYE:Y7K8(\2
	WVRnG//MU!LTi6nh%:7O^bFa10)X`T>(J,g9$=S9-[bGq)a]>e3X!<+].]XR&)1p[X^BeI-a3Mi20`
	+"hhC-;j2/;-5i^l>6.N>.qNBqFM.:)Lj[b[%t1VCV/FHf]h5BhL2o#U!LHfDSj,Es!Km'Bq9QZ3q&
	$cRBpKgR\MaLADY$(>RSFb/RJ?pWPc"Jb9*lD?IcX`k$$S`:$Z_81t^<_q8$+4D,[onf]g"`eK0aal
	2-J_:d<TXkk,P&URR=&T;XpKjL"ZL/a$Zj[pSoP.IQc+Wts<Qh%79QHL'mfoXd'Nq`Hk-aRo#fVi&f
	4^(>\FopY\Nh:nRj90[h#<:K_>f=Z%jIcUP,n@SJA[sqEXrrW6N^E&4'Dc'^=!!!.75tsWF!3qQ3qb
	`OW!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c>J7!!61m6pXdsg?b-OCD/uJ
	a1lP9;U*$9'Z>Vo4bSts$A/6\$;9k2[-!O-'WLV!pS(2T$asg>&u9bM.>fNE+f2`7*kZ9@Q^!"JM20
	g3r+\.)b]qc7\i\#O!d`'P4l1tgSXo5^fj-Z2I<j7k*:o(7RTs(cX5eBQ"c1KCB0=%;BB"\r)%S[(8
	-1&/oCj7+:Ofqq@stDR5/+%8q#aM"W0u?.ktZbIl?>c5ao5P#e)&]JM#]E/h6X-M>H6li\7!f9P\JJ
	$/arMO&$e2>M#'u<,!BiglX7+efblIJd402`PZ*O^KbQsQ4<DLm<h%KQP`1FD&eSW2.f_:(C)-f2<N
	RkbJ7-;t4?+#pgTG.".5QPf=ipbIN_nQNmJn[Y\:B:k#_6.+[I=D0N5.7<.)7`E%T7h$,f&pL@]VH<
	)Jf:UDueP%CFu*pb=cGnn#R6LOalEr(]^L+Rsm-Bc(=*8+TK:n(jiWH,qUdgKXE2"E!N7Il=pj2g>8
	rgrEd(-(]q;*cc+*R2J4sjV.(d:Q!p>0Ng_+,e)\u7)a0J]:iJN1>&9jrg!_V)%kR=KKb;l?btVGu*
	ZkDbB6>Z9A/5o,c]5_Lq8PGsh>o(\:d"@!"F>c[:'Z_4UN_(>=HaXtjoRM1VcpC`,j!rsrBqB6lS[r
	,kG\<6$V.ucVDle5Ucn6?VL<%PrV*;KdWJQY\^OVq:4V6#]t*Wt9;\<Y27(MaBtYWrIF#jV>AsXC3g
	G$HpV0>P+4S6ig,mDk#V8G;j95Gl!#0GWkFmC>%KHJ/!(fUS7'8jaJc
	ASCII85End
End

// PNG: width= 101, height= 50
Picture UpButton
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!!l!!!!F#Qau+!/8jRQN.!c$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
	TmDffo=BQ%i48OGifE,ol/Bl%>\!-m4g;g2?-pD,sMpLOk96J1e4QY_3Q+sX/pa:MLK&<[$%KFeb]`
	J'*T<YQ8\S4HYuK%13!SVZ9u.(EnUMMPGo<EqNO+5Ed%I<tALmJGN4]]YgJr6BT6%tG6)-B[GbC&g7
	lKfhEK+-02g`6#]C!Yn8a"<\9<bJIlq`;fo-"*o-?FKe"-!O$DA!W[2i/gM(MiW"PA:aT6D+HZZ^+q
	j&H!K^1Za=^H5'EH2k!3fD.A-r=$!!$h\HpT"WWXSspoLV4M!8+97g_TtCU)^-<!0%!ZR4(QN!^O?t
	?r_bU/-<W(!2-DY+ta#6XoX&U[PC>SJ@u*dG)f[d%mXM&J=/_TbQ&bF!WYS/'?pV%9EUqAd_F_>?Z:
	_/8-&_+bE^>=9@>U1\<YDZGOk7]iZ[<uCp?<8(F]o-$03;#Q^]358EU(Kc3s[Q)Yqdsr]!-(kN:jak
	%<dmn+=SnrbM"A,!I1?hu:9I!X&K7:=&C_?fgD#")u9]Y][]rWETAV<WHgjq->f2$(tH/d!GMGGrY^
	e*hK'%a?1I_$4@7/-"<R]0]S'Ts"iVPi/<'Xr'2>&gNr>hELK.\Xh^]arGc7`G-4`'kK<up0lHaK,Q
	>`;J,PBVdGd!f>V$VInQ:XX:a/WSH+?h86m9[;iY(L*1@ZHPr<\[3%03Ja:V]`6#IV`k^jb\P!fIOj
	dWPUUIe,.M)@MZ-&8*gTH1q:=PJ?pS5Uuj8c'P6d!!'[q(gO#((JMgS!!#E[JL[li#7SE_XM>=9_&^
	2((BS"L6pM/+^cW/p#3::S$DA<&5oEY;3nOSCYQGf:&XqYi[)"IV%HlX^>_23[(C"7aT#)>WL'[uKa
	9WGf+ZbDk@ZK(bc3P5SNW^P782QK[U`eoX'N$'naE"'XWBt?^>t?42/TMOcNEeaFOP@i!15c!e]LO]
	@J[/,Te,jbX\YpSgMT2<1d<%2U?%A68CXF'-*^,%^U8QC3k]LtII>X%pJC-(]ArPDO>`=G,@#7u(-H
	?m3j]FB@O#:Df=>tC<)o/%Rmg(0?MguK-#[W/q_JFgcO@NDH=@9#5lm&kM\d2@DK7ktr-R+bQ:UDEo
	')BIj@QLcU=@TA=mNEVpSg@\j%MN3580e\eP2o@F+XN4*8IJ+*8D?ZeUf4'QdL^,_9IB(eD9:Yq#dS
	u^+IA5"O:RFKP5EA=jL5ga`JEMI$)/\CUm)Ka2.]#6"Jq_G6CFLH;9c)3e-N(13hKSID4l&K02mY*'
	/Xj#--_np6d)8WUXd_[BkM/SBJ8Ul\d@2F*^uFBQdT[5#O1F9KCj?r%>G=Ea%0Yf)/C+:)5e=\))%C
	OV?PG8RE/>]f.n;5B:'3sDcKmhp*tG)Oie<%3gEa2I[0)r<)n!>5Lk%Z$WO0,&$'#;IATJ6ZV]\]$.
	K`keYsQh];[]kc;JjaO&4/"?_b>BrIXlU%C1_B7\GK,UJta4`YjaZ(</+@nQ8-/E`N;./8LVI@U$/6
	lqDR+q\s]3HV@@*F/iiRAs$\rk&JWH%`Yd3n2]0l9$SU*%F0;P""c_hZ.<ZlB!$Na2qiT3^=m&`EpX
	Y0le:fME1K7b/=lGpD*%E6$+`%+;7_ImgNCj-51=$-H0GY.b4Q8/h9eacD=jUr([CJ?n'N490Jj%nO
	;Vjh3+MI%OCRKiQta(Xn:]c!&^+k!Oi1q.d7L)\\0gX!BB(jo(HuH4D]E5f1u;g!CHQ$7BenG=`2(B
	5^+%<kCRSkHdBqAEbfn-ZgoT/0am>$JeXUEH@D:F-g\d%bV+$on8rGTca-PGFI*2\Z9pYOTQrZCOGu
	jT=f;qQp>jEs,D:Vd):`EK*%%B;IbI4@OS#sVPRr.$siY7G&dOFifDV?i3r9OdWRd:7G3VHnT-2)3L
	cQ14L&foObF?=kjFEPfNCiI&QUu=/JWPkdRkuVL:B;'C;o/.>]99@=0QZe]3;f/FiVf&,QbE_0-m^g
	iSe+KK*]:7TXfko6pbWWpnX8>UDRiBIT_`dHSo^MTWic33&SYqsT_XilP04&g.=^M!=*`',4-D&dBD
	91JM>N!3<HXJlu4_=K8klX,h4p%@&T81.X^*;Gt^*A*XI[PWir1<dIqTJhupqPd5neUaj"^hAI!Ta?
	qJJs*G")@u\"ITCh#;l[E"hOsl$pGCm$jdAG+**Q`^_cP\q-u59B.TM!(!6fQ'j;RQ0[(k;*nCp`L<
	g._&:SPpq+U%s[Kq]I7r4!k+))U\(\rIn.4R*Q0'Z<@;fm#$pFOmsjB;@m]oMWDWJnALgM40;G%[mk
	Cf5(Zm$kM8\>m&iG_c&_nWsl1'-mnOM<)V-`'&t;ErtN@RPUJpRT,SpA$4qKU:D*&l-@JDG<B"c=ce
	"jKpWL>Z9RH'+@8mX(f07kDG;,bnq<Kd:IW!lNM9:T\%#$mP3/<9Q1d2n4+0KmBSK;PFiH3D:Jr]gO
	Vs=m,P+W17+U4rce3<k/NK&cPanLH%;D-8/(ZJa.(;ua.k?emjE]m)ar?P"b4jsAq/c/^'l8RtdA+'
	HY##TD9J<=pGZu"hGdp;X86XM!he)lQq'-9!(4<fWYY_j6Ze2d4=n1Do^I>aM,E#J:G:kUU;S$C`C%
	0Q!b@o))QMjY>=Ai/iC3eV*N`(MXV56O0JladoWKbNJDQ`V8\RQ@_Q"3n`C7!IT<duS8Q!^V3XJi;s
	YXZ.bi`Al^eU7%8D;*_#9"2t1lU^?;lY`fu=hh.4]kTj`d"_$!XW-eijVqQD9&=Z`H><,5c*Ya<bl]
	h32=4Vl[]J6STf/\>HC]Okb?"SDX1,gr-JI%ch045;%YGc:45TFjm(B_VGZS[o7=FiHddD_CNuDIH]
	"dBVh7,t!:W8odH_l&op-nH9C34B1gonK-Z3bAG2N8bK3cO2MJ8a/2m@&7,E*=_$_Em;"-f:eKHfIr
	dU!CR2_p.),J%,(VlUZ:OdQ5-cX=^2aTKT!^n*#_*SK2#W8%uJ4Id]#O@s,gLO&qpGSL?Ykq;d-kj/
	6FcSt/V@4k,nTH1t#1R;6)*?+jl<c^m?;FRDi3?h_\6hWKr*n@W`4,55R$-+?OL4g$q<IW58E8?Z69
	lXfh6m8lEQFS&;n443NGJ,3oqeT9@;f.L@$H+i[dll3EO-J]ZO-+`dEG4t;>G7*b3gg,5eGd%%ZgAU
	:Aq@Dk@[/R=A^hr$)@)-0r_c[N=%LIo^rfmH3LZ-ZObX^2.7O*nRSKApm%2uqNABpCtVm<36ccU];s
	*<pOX68C=iqlBp=T$h@$i,_,^TMj]o5a<#WNSA',KCn=c?VSCVYmRAgO8P#n%.Ds]cWXjr':6Xo?mD
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!!.75tsWF!3qQ3qb`OW!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-
	Ksq!:!ql!'6JI!#KR:?c>J7!!R(.6pXdsg=07g81RCKSXF:>;>b,:Ld+uiLtIO>.jHGJ&P49::pCRK
	"I1A@(7IQ_5q=IFM-qL*Z*7%-6NUHp&M4\)"U.=_'@#qlfjqg+pr7TK2,8UF`*:;D]6eSDgcK`JhLV
	;kT4MSF='&J(X/h,PJF(Nu\(b^W8Wm%QXf/1#>?fk7fDmqbq"XX2cql\AL(G+/$=iGsqfd4,>$>*g7
	O,ni6AR?#!72+"c2IkH+G;GgGB\7*9hiOC_Z55_q>(!frQ<8Tp0A^ac\KEsrr2oMg"?En$)/jEI(mn
	O:7KL_&B\FiK#-C(iShVh_<pWlcf](XBk_?ubDHt,'p$D]cd-fZGH7aDA6CN!P]1qpW[LJXD_I4oNC
	G(ESF_CFqY^8mW2MD>c't2l%hB0s,pdDFD%OQd//F/_ph:>=WiE'q.($Imp\t.u-n$7(8jN_+KZRcq
	j5WLi,YaMPI!faID%-m^Pa@`CTaN#3#Xor"qtp9VlYA6W!5KF%M@tn<<E7RC<d/bseS76-3B9,]8uE
	t,dd-47,SD8J$3c,sA?)XZ8Wpnt5R859#(#8$H<i.ia5\?CC@3:!"@4^[NT?Nn,n^Ma<=qReDmNWLB
	!^0*[6d#D#Z8f46BNFS5;_tb1%oiS$O[=BJAoLHmHnaG8/DK@87*b/:]LK^b@NT$!<?`<g#[8E0<..
	.&7J70nG`[mn9VcH;cE>9aiR,8a.l;e8"qW&MZc&Fo($gMOa08:)Y*0a5mTUp%kE^neC9`7lQnaX:N
	7:Jq2!5q$L.EGq"QgS*YisJI&n8L\i)K+Qd1FCS"#o-Q^8X*U*3,F<?Mil3#ifbal.1A!WelXFZQ'/
	M^8Ii`F<gJSNQI`L-g"L&XL7@cu->a<,/L*h2$27S[Gl55=3oOf)@'Q+"5'&Iio<\Of&ej.rT$3L5-
	FR2Ea5%h;(2e"I@r;5C]8rShS/A2)UeQSt;OphAV5=FJEr'H'o)DXK5reR[BHb:u=Et-^6O<YWG?eU
	QnQ^Q17'sPk1B5D5MOm;PLa69ic"ef8"1=bQ"H:&h74ACc0,V[J5CG/!mOf(k8c(MM.^1LZsY[LU!_
	:/TuiY\O,mgd<\]`$%og@Z\tN&Z=lCX1guen3rK5mP\i/FbPMH)I\,En"[;"@3'TY-S^)&\)-N757@
	b)!Ym%M;>L(O>`lH-uIfFU2#(K/'o($gEG4tLt14OTI:g^mo[Kf5q'ZK4sAcP(p;j/Ve\h,U2#DPR=
	p%<G-_#!nR-ksfo?<0mYr=792'1K1"Tn,8)^:p0RRFSkXKgP,DbJqOkc6BTK6JlYAX?>bu<[<1JXl5
	M*a;glPqSoEF.uIeaID,%R6pj=o.#MQ*[$EL<W@fR@9K2;G$RN$4&B$9BNK&qURhIXb@:NdlJV_9SZ
	7Hq'#)mOWR7sGTUkul:GIuZK3Y^X-3IZh*j5efjWDinl"I]`67A7aW4NW44BqCrhj70Y$A0MI%!._)
	LZ7HY;hCT,/BJ^Wa7$>Zf+FJlC6(io)p@bu)2o"6W=''TmHV5_8?)M9;@k7n;/B_*r=,B>>Vl(m^%W
	?3$?!LW6<`ZrI]OZ.'BeUC`nbCAR9m(T$?XKEN8VMa/]"5He7G6AIl0.=j5<gO9^mVrofj`3:1-Ifb
	[^NUS%hD#5hr!<%%hE5SIXQXhp:Sph1mXAjN/W^SNfF/@$3^U.d:d6.BeUB/>$=f<7?^nsK9k&H&99
	`M%Yl8EM^8uBEqo'G]<eX%#j0dlf\k[1H]F^_e:.Q#S/<V`.>ts5z8OZBBY!QNJ
	ASCII85End
End





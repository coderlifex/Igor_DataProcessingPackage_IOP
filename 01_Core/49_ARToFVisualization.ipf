#pragma rtGlobals=1		// Use modern global access method.
#include <All Gizmo Procedures>
static StrConstant backtaskname="autoshowmovie"
///beta1.6

proc visualize_artofdata()
silent 1
string curr=getdatafolder(1)

//dowindow/F VisualizeARToFData

	variable versionnum
	string str="VisualizeARToFData"
	versionnum=igorprocedureversion(str)
	
	DoWindow/F $str
	
	if(V_flag)
	if(!versionnum)
	dowindow/K $str
	DoWindow/F $str
	endif
	endif

if(V_Flag==0)
	newdatafolder/O/S root:ARToFData
	Variable/G  PhotonEnergy=NumVarOrDefault("root:ARToFData:PhotonEnergy",6.994)
	Variable/G  WorkFunction=NumVarOrDefault("root:ARToFData:WorkFunction",4.3)
	Variable/G  LatticeConstant=NumVarOrDefault("root:ARToFData:LatticeConstant",3.8)
	Variable/G  RotationAngle=NumVarOrDefault("root:ARToFData:RotationAngle",0)
	Variable/G  ThetaAngle=NumVarOrDefault("root:ARToFData:ThetaAngle",0)
	Variable/G  PhiAngle=NumVarOrDefault("root:ARToFData:PhiAngle",0)
	Variable/G  DetectorAngle=NumVarOrDefault("root:ARToFData:DetectorAngle",30)
    Variable/G  BZShowMode=NumVarOrDefault("root:ARToFData:BZShowMode",0)
    Variable/G  degreeormomentum=NumVarOrDefault("root:ARToFData:degreeormomentum",0)
    Variable/G  Energywindow=NumVarOrDefault("root:ARToFData:Eenergywindow",10)
    Variable/G  kxstart=NumVarOrDefault("root:ARToFData:kxstart",0)
    Variable/G  kxend=NumVarOrDefault("root:ARToFData:kxend",0)
    Variable/G  kystart=NumVarOrDefault("root:ARToFData:kystart",0)
    Variable/G  kyend=NumVarOrDefault("root:ARToFData:kyend",0)
    Variable/G  kxpntnum=NumVarOrDefault("root:ARToFData:kxpntnum",0)
    Variable/G  kypntnum=NumVarOrDefault("root:ARToFData:kypntnum",0)
    Variable/G  bindingenergy=NumVarOrDefault("root:ARToFData:bindingenergy",0)
    Variable/G	 artof_flag=NumVarOrDefault("root:ARToFData:artof_flag",0)
    Variable/G	 bindingnumEDC=NumVarOrDefault("root:ARToFData:bindingnumEDC",0)
    Variable/G	 bindingnumMDC=NumVarOrDefault("root:ARToFData:bindingnumMDC",0)
    Variable/G	 smoothnumEDC=NumVarOrDefault("root:ARToFData:smoothnumEDC",0)
    Variable/G	 smoothnumMDC=NumVarOrDefault("root:ARToFData:smoothnumMDC",0)
    Variable/G	 savewaveornot=NumVarOrDefault("root:ARToFData:savewaveornot",0)
    Variable/G	 holdimageornot=NumVarOrDefault("root:ARToFData:holdimageornot",0)
	Variable/G  holdintensityimage=NumVarOrDefault("root:ARToFData:holdintensityimage",0)
	Variable/G  setcutkx_s=NumVarOrDefault("root:ARToFData:setcutkx_s",0)
	Variable/G  setcutky_s=NumVarOrDefault("root:ARToFData:setcutky_s",0)
	//Variable/G  setcutkx_e=NumVarOrDefault("root:ARToFData:setcutkx_e",0)
	//Variable/G  setcutky_e=NumVarOrDefault("root:ARToFData:setcutky_e",0)
	//Variable/G  cursorornot=NumVarOrDefault("root:ARToFData:cursorornot",0)
	Variable/G  arrowsornot=NumVarOrDefault("root:ARToFData:arrowsornot",0)
	Variable/G  deltaenergy=NumVarOrDefault("root:ARToFData:deltaenergy",0)
	Variable/G  lowcolorz=NumVarOrDefault("root:ARToFData:lowcolorz",0)
	Variable/G  highcolorz=NumVarOrDefault("root:ARToFData:highcolorz",0)
	Variable/G  inverseornot=NumVarOrDefault("root:ARToFData:inverseornot",0)
	Variable/G  costomizeenergystart=NumVarOrDefault("root:ARToFData:costomizeenergystart",0)
	Variable/G  costomizeenergyend=NumVarOrDefault("root:ARToFData:costomizeenergyend",0)
	Variable/G  costomizeenergy=NumVarOrDefault("root:ARToFData:costomizeenergy",0)
	Variable/G  offsettheta=NumVarOrDefault("root:ARToFData:offsettheta",0)
	Variable/G  offsetomega=NumVarOrDefault("root:ARToFData:offsetomega",0)
	Variable/G  offsetphi=NumVarOrDefault("root:ARToFData:offsetphi",0)
	variable/G	 orithetastart=NumVarOrDefault("root:ARToFData:orithetastart",0)
	variable/G	 orithetaend=NumVarOrDefault("root:ARToFData:orithetaend",0)
	variable/G	 oriphistart=NumVarOrDefault("root:ARToFData:oriphistart",0)
	variable/G	 oriphiend=NumVarOrDefault("root:ARToFData:oriphiend",0)
	variable/G	 thetaangle1=NumVarOrDefault("root:ARToFData:thetaangle1",0)
	variable/G	 ktolerance=NumVarOrDefault("root:ARToFData:ktolerance",0)
	variable/G	 cal2dareaornot=NumVarOrDefault("root:ARToFData:cal2dareaornot",0)
	variable/G	 adjustoffset=NumVarOrDefault("root:ARToFData:adjustoffset",0)
	variable/G	 EDCkxpos=NumVarOrDefault("root:ARToFData:EDCkxpos",0)
	variable/G	 EDCkypos=NumVarOrDefault("root:ARToFData:EDCkypos",0)
	variable/G	 EkimageEDCkpos=NumVarOrDefault("root:ARToFData:EkimageEDCkpos",0)
	variable/G	 EkimageMDCEpos=NumVarOrDefault("root:ARToFData:EkimageMDCEpos",0)
	variable/G	 kxkyposcursor=NumVarOrDefault("root:ARToFData:kxkyposcursor",0)
	variable/G	 kpathpntnum=NumVarOrDefault("root:ARToFData:kpathpntnum",0)
	variable/G	 lomegaoffset1=NumVarOrDefault("root:ARToFData:lomegaoffset1",0)
	variable/G	 lomegaoffset2=NumVarOrDefault("root:ARToFData:lomegaoffset2",0)
	variable/G	 lthetaoffset1=NumVarOrDefault("root:ARToFData:lthetaoffset1",0)
	variable/G	 lthetaoffset2=NumVarOrDefault("root:ARToFData:lthetaoffset2",0)
	variable/G	 lphioffset1=NumVarOrDefault("root:ARToFData:lphioffset1",0)
	variable/G	 lphioffset2=NumVarOrDefault("root:ARToFData:lphioffset2",0)
	
	variable/G	pauseornot=NumVarOrDefault("root:ARToFData:pauseornot",0)
	//Variable/G  stopautoshowflag=NumVarOrDefault("root:ARToFData:stopautoshowflag",0)
	//Variable/G  stopmovieflag=NumVarOrDefault("root:ARToFData:stopmovieflag",0)
	Variable/G  framespersecond=NumVarOrDefault("root:ARToFData:framespersecond",10)
	string/G arbdispersion_pre=strVarOrDefault("root:ARToFData:arbdispersion_pre","")
	string/G kpathnodes=strVarOrDefault("root:ARToFData:kpathnodes","")
	string/G artofdatanamelist
	string/G namestrfor3D
	string/G choosecolortablename=strVarOrDefault("root:ARToFData:choosecolortablename","PlanetEarth")
	make/O/T/N=0 artofdatanamelist4listbox
	
	
	newdatafolder/O/S root:ARToFData:MDCFit
	variable/G	 MDCstackoffset=NumVarOrDefault("root:ARToFData:MDCFit:MDCstackoffset",0)
	variable/G	 MDCstackbindingnum=NumVarOrDefault("root:ARToFData:MDCFit:MDCstackbindingnum",0)
	variable/G	 MDCstackEstart=NumVarOrDefault("root:ARToFData:MDCFit:MDCstackEstart",0)
	variable/G	MDCstackEend=NumVarOrDefault("root:ARToFData:MDCFit:MDCstackEend",0)
	variable/G	MDCstackKstart=NumVarOrDefault("root:ARToFData:MDCFit:MDCstackKstart",0)
	variable/G	MDCstackKend=NumVarOrDefault("root:ARToFData:MDCFit:MDCstackKend",0)
	
	variable/G	 FittingLorentznum=NumVarOrDefault("root:ARToFData:MDCFit:FittingLorentznum",1)
	variable/G	 Fittingbackground1=NumVarOrDefault("root:ARToFData:MDCFit:Fittingbackground1",0)
	variable/G	 fittingheight1=NumVarOrDefault("root:ARToFData:MDCFit:fittingheight1",0)
	variable/G	fittingfwhm1=NumVarOrDefault("root:ARToFData:MDCFit:fittingfwhm1",0)
	variable/G	fittingposition1=NumVarOrDefault("root:ARToFData:MDCFit:fittingposition1",0)
	variable/G	Fittingbackground2=NumVarOrDefault("root:ARToFData:MDCFit:Fittingbackground2",0)
	variable/G	fittingheight2=NumVarOrDefault("root:ARToFData:MDCFit:fittingheight2",0)
	variable/G	fittingfwhm2=NumVarOrDefault("root:ARToFData:MDCFit:fittingfwhm2",0)
	variable/G	fittingposition2=NumVarOrDefault("root:ARToFData:MDCFit:fittingposition2",0)
	
	variable/G	energynearEF=NumVarOrDefault("root:ARToFData:MDCFit:energynearEF",0)
	variable/G	energyfarEF=NumVarOrDefault("root:ARToFData:MDCFit:energyfarEF",0)
	string/G EKImagenamelist
	
	make/O/T/N=0 fittednamelist
	
	setdatafolder root:ARToFData
	
	VisualizeARToFData()
	string ctrlname=""
	variable check=0,tabNum
	refreshartofdata(ctrlName)
	fromcut2artof(ctrlName,check)
	disableholdornot(ctrlName,check)
	disablesliderornot(ctrlName,check)
	usingarrowornot(ctrlName,check)
	cusorsornot(ctrlName,check)
	adjustoffsetornot(ctrlName,check)
	dispersionandfit(ctrlName,tabnum)
	disablepauseandstop()
	//loretznum("",1,"","")
endif

end


Window VisualizeARToFData() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(219,78,1004,493) as "VisualizeARToFData:Beta2.0"
	ModifyPanel fixedSize=1, frameStyle=1
	SetDrawLayer UserBack
	SetDrawEnv fname= "@Arial Unicode MS"
	DrawText 467,381,"LowZ"
	SetDrawEnv fname= "@Arial Unicode MS"
	DrawText 469,408,"HigZ"
	SetDrawEnv linefgc= (26112,26112,26112)
	DrawLine 511,77,769,77
	SetDrawEnv linefgc= (26112,26112,26112)
	DrawLine 511,172,769,172
	SetDrawEnv linefgc= (26112,26112,26112)
	DrawLine 514,249,768,249
	SetDrawEnv fname= "@Arial Unicode MS"
	DrawText 170,262,"Offset"
	SetDrawEnv linefgc= (26112,26112,26112)
	DrawLine 171,136,301,136
	SetDrawEnv linefgc= (26112,26112,26112)
	DrawLine 172,242,283,242
	SetDrawEnv linefgc= (26112,26112,26112)
	DrawLine 513,296,768,296
	DrawRect 508,301,774,368
	DrawOval -0.595376884422111,0.072964824120603,-0.555376884422111,0.112964824120603
	DrawOval -0.253668341708543,0.26391959798995,-0.213668341708543,0.30391959798995
	SetDrawEnv arrow= 1
	SetDrawEnv save
	SetDrawEnv arrowlen= 5,arrowfat= 0.8
	DrawLine 262,275,271,275
	SetDrawEnv arrowlen= 5,arrowfat= 0.8
	DrawLine 262,294,271,294
	SetDrawEnv arrowlen= 5,arrowfat= 0.8
	DrawLine 262,314,271,314
	SetVariable photonenergy,pos={177,28},size={125,20},bodyWidth=80,title="\\f01\\F'@Arial Unicode MS'\\f02\\f01h\\M\\F'symbol'u\\M\\F'Times' \\f01(eV)"
	SetVariable photonenergy,value= root:ARToFData:PhotonEnergy
	SetVariable workfunction,pos={165,49},size={137,20},bodyWidth=80,title="\\F'@Arial Unicode MS'\\f03W\\f01(eV)"
	SetVariable workfunction,value= root:ARToFData:WorkFunction
	SetVariable latticeconstant,pos={177,70},size={125,20},bodyWidth=80,title="\\F'@Arial Unicode MS'\\f02\\f01a\\M\\f01(A)"
	SetVariable latticeconstant,value= root:ARToFData:LatticeConstant
	SetVariable brilliouinzone,pos={173,91},size={129,20},bodyWidth=80,title="\\f01\\F'@Arial Unicode MS'BZSize"
	SetVariable brilliouinzone,limits={0,4,1},value= root:ARToFData:BZShowMode
	SetVariable omega,pos={181,140},size={110,18},title="\\f01\\F'@Arial Unicode MS'\\M\\F'symbol'w"
	SetVariable omega,value= root:ARToFData:RotationAngle
	SetVariable phi,pos={181,199},size={110,18},title="\\f01\\F'@Arial Unicode MS'\\M\\F'symbol'j"
	SetVariable phi,value= root:ARToFData:PhiAngle
	SetVariable detecterangle,pos={164,112},size={138,20},bodyWidth=80,title="\\f01\\F'@Arial Unicode MS'Detector"
	SetVariable detecterangle,value= root:ARToFData:DetectorAngle
	SetVariable theta,pos={182,160},size={110,18},title="\\f01\\F'@Arial Unicode MS'\\M\\F'symbol'q"
	SetVariable theta,value= root:ARToFData:ThetaAngle
	Button ShowMomentumMap,pos={168,330},size={144,19},proc=showmomentummap,title="GetMappingArea"
	Button ShowMomentumMap,font="@Arial Unicode MS"
	ListBox artofdata,pos={4,26},size={152,342},proc=ListBoxProc1,frame=4
	ListBox artofdata,listWave=root:ARToFData:artofdatanamelist4listbox,mode= 1
	ListBox artofdata,selRow= 0
	Button creatcut,pos={386,112},size={62,20},proc=creatcut,title="GetKPath"
	Button creatcut,font="@Arial Unicode MS"
	Button showEkimage,pos={327,132},size={100,20},proc=getdispersion,title="GETDispersion"
	Button showEkimage,font="@Arial Unicode MS"
	Button showintensityvsk,pos={685,118},size={40,40},proc=showintensityvsk,title=""
	Button showintensityvsk,font="@Arial Unicode MS",picture= ProcGlobal#drawFS
	Slider energypostion,pos={517,178},size={249,51},proc=getintensityvsK_arbE
	Slider energypostion,limits={-0.338,0.0620001,0.002},value= 0,live= 0,vert= 0,ticks= 10
	GroupBox group0,pos={160,10},size={157,349},title="GetMomentumMap"
	GroupBox group0,font="@Arial Unicode MS",frame=0
	SetVariable bindingenergy,pos={513,32},size={120,20},proc=usingarrowstodraw,title="\\Z10\\F'@Arial Unicode MS'\\f01E\\BB\\M(eV)"
	SetVariable bindingenergy,limits={-10,10,0.01},value= root:ARToFData:bindingenergy
	Button refreshartofdata,pos={5,371},size={34,34},proc=refreshartofdata,title=""
	Button refreshartofdata,font="@Arial Unicode MS"
	Button refreshartofdata,picture= ProcGlobal#refreshbutton
	Button gettrial,pos={69,3},size={83,20},proc=gettrialdata,title="TrialData"
	Button gettrial,font="@Arial Unicode MS"
	SetVariable Ewindow,pos={512,57},size={125,16},title="\\Z10\\f01\\F'symbol'D (\\F'Arial'\\f01 meV)"
	SetVariable Ewindow,value= root:ARToFData:Energywindow
	SetVariable kxstart,pos={513,89},size={80,18},title="\\Z10\\F'@Arial Unicode MS'kx_S"
	SetVariable kxstart,value= root:ARToFData:kxstart
	SetVariable kxend,pos={514,109},size={80,18},title="\\Z10\\F'@Arial Unicode MS'kx_E"
	SetVariable kxend,value= root:ARToFData:kxend
	SetVariable kxstart1,pos={598,89},size={80,18},title="\\Z10\\F'@Arial Unicode MS'ky_S"
	SetVariable kxstart1,value= root:ARToFData:kystart
	SetVariable kxstart2,pos={598,108},size={80,18},title="\\Z10\\F'@Arial Unicode MS'ky_E"
	SetVariable kxstart2,value= root:ARToFData:kyend
	SetVariable kxnum,pos={515,138},size={80,18},title="\\Z10\\F'@Arial Unicode MS'kx#"
	SetVariable kxnum,value= root:ARToFData:kxpntnum
	SetVariable kynum,pos={600,137},size={80,18},title="\\Z10\\F'@Arial Unicode MS'ky#"
	SetVariable kynum,value= root:ARToFData:kypntnum
	CheckBox artof_flag,pos={8,6},size={48,14},proc=fromcut2artof,title="ARToF"
	CheckBox artof_flag,variable= root:ARToFData:artof_flag
	GroupBox group2,pos={504,8},size={275,403},title="GetIntensityVSMomentum"
	GroupBox group2,font="@Arial Unicode MS",frame=0
	SetVariable bindingnumEDC,pos={406,168},size={89,18},title="\\Z10\\F'@Arial Unicode MS'Bind#"
	SetVariable bindingnumEDC,value= root:ARToFData:bindingnumEDC
	Button getarbEDC,pos={325,167},size={78,20},proc=getarbEDC,title="GETEDC"
	Button getarbEDC,font="@Arial Unicode MS"
	SetVariable bindingnumMDC,pos={406,206},size={89,18},title="\\Z10\\F'@Arial Unicode MS'Bind#"
	SetVariable bindingnumMDC,value= root:ARToFData:bindingnumMDC
	Button getarbMDC,pos={325,207},size={79,20},proc=getarbMDC,title="GETMDC"
	Button getarbMDC,font="@Arial Unicode MS"
	SetVariable smoothnumEDC,pos={388,302},size={104,18},title="\\Z10\\F'@Arial Unicode MS'Smooth#"
	SetVariable smoothnumEDC,value= root:ARToFData:smoothnumEDC
	Button getarbEDC2nd,pos={327,301},size={60,23},proc=getEDC2nd,title="EDC2nd"
	Button getarbEDC2nd,font="@Arial Unicode MS"
	SetVariable smoothnumMDC,pos={389,323},size={104,18},title="\\Z10\\F'@Arial Unicode MS'Smooth#"
	SetVariable smoothnumMDC,value= root:ARToFData:smoothnumMDC
	Button getarbMDC2nd,pos={327,323},size={60,22},proc=getMDC2nd,title="MDC2nd"
	Button getarbMDC2nd,font="@Arial Unicode MS"
	CheckBox savewaveornot,pos={642,58},size={53,16},proc=disableholdornot,title="\\F'@Arial Unicode MS'Save?"
	CheckBox savewaveornot,variable= root:ARToFData:savewaveornot
	CheckBox holdimage,pos={448,114},size={51,16},proc=disableEDCMDC,title="\\F'@Arial Unicode MS'Hold?"
	CheckBox holdimage,variable= root:ARToFData:holdimageornot
	Button clearEKImage,pos={432,132},size={50,20},proc=clearEKImage,title="Clear"
	Button clearEKImage,font="@Arial Unicode MS"
	CheckBox holdintensityimageornot,pos={700,59},size={44,16},disable=2,proc=disablesliderornot,title="\\F'@Arial Unicode MS'Hold"
	CheckBox holdintensityimageornot,variable= root:ARToFData:holdintensityimage
	SetVariable setcutkx_s,pos={324,60},size={80,18},proc=setcutkx_start,title="\\Z10\\F'@Arial Unicode MS'Kx"
	SetVariable setcutkx_s,limits={-3,3,0.02},value= root:ARToFData:setcutkx_s
	SetVariable setcutky_s,pos={410,59},size={80,18},proc=setcutky_start,title="\\Z10\\F'@Arial Unicode MS'Ky"
	SetVariable setcutky_s,limits={-3,3,0.02},value= root:ARToFData:setcutky_s
	CheckBox arrowsornot,pos={519,229},size={212,16},proc=usingarrowornot,title="\\F'@Arial Unicode MS'Use Up/Down Arrow or Creat Movie"
	CheckBox arrowsornot,variable= root:ARToFData:arrowsornot
	SetVariable deltaenergy,pos={638,35},size={105,18},disable=2,title="\\f01\\Z10\\F'@Arial Unicode MS'Inc(meV)"
	SetVariable deltaenergy,value= root:ARToFData:deltaenergy
	Button intensityvskmovie,pos={589,374},size={35,35},disable=2,proc=intensityvskmovie,title=""
	Button intensityvskmovie,font="@Arial Unicode MS"
	Button intensityvskmovie,picture= ProcGlobal#newmovieicon
	Button playintensityvskmovie,pos={633,373},size={35,35},disable=2,proc=playintensityvskmovie,title=""
	Button playintensityvskmovie,font="@Arial Unicode MS"
	Button playintensityvskmovie,picture= ProcGlobal#playmovieicon
	Slider lowzcolorz,pos={329,366},size={135,19},proc=setlowcolorz
	Slider lowzcolorz,limits={-130.619,261.238,0.653095},value= 0,vert= 0,ticks= 0
	Slider highcolorz,pos={330,391},size={135,19},proc=sethighcolorz
	Slider highcolorz,limits={0,653.095,1.63274},value= 130.39680480957,vert= 0,ticks= 0
	PopupMenu choosecolortable,pos={171,368},size={117,20},bodyWidth=117,proc=choosecolortable
	PopupMenu choosecolortable,mode=15,popvalue="",value= #"\"*COLORTABLEPOPNONAMES*\""
	CheckBox inverseornot,pos={172,392},size={58,16},proc=inversecolortable,title="\\F'@Arial Unicode MS'Inverse"
	CheckBox inverseornot,variable= root:ARToFData:inverseornot
	SetVariable autoEstart,pos={510,306},size={90,18},disable=2,title="\\Z10\\f01\\F'@Arial Unicode MS'EStart"
	SetVariable autoEstart,limits={-0.338,0.0620001,0.002},value= root:ARToFData:costomizeenergystart
	SetVariable autoEend,pos={607,306},size={80,18},disable=2,title="\\Z10\\f01\\F'@Arial Unicode MS'End"
	SetVariable autoEend,limits={-0.338,0.0620001,0.002},value= root:ARToFData:costomizeenergyend
	CheckBox costomizeErange4movie,pos={692,307},size={77,16},disable=2,title="\\F'@Arial Unicode MS'Customize"
	CheckBox costomizeErange4movie,variable= root:ARToFData:costomizeenergy
	Button autoshow,pos={547,331},size={32,33},disable=2,proc=autoshow,title=""
	Button autoshow,picture= ProcGlobal#AutoshowPlay
	SetVariable framespersecond,pos={511,385},size={70,20},disable=2,title="\\f01\\F'@Arial Unicode MS'Fram"
	SetVariable framespersecond,limits={1,60,1},value= root:ARToFData:framespersecond
	Button kxkystacks,pos={708,382},size={65,25},proc=kxkystacks,title="\\F'@Arial Unicode MS'KxKyStack"
	Button kxkystacks,font="@Arial Unicode MS"
	SetVariable offsettheta,pos={163,284},size={55,18},disable=2,proc=sycthetaoffset,title="\\f01\\F'@Arial Unicode MS'\\M\\F'symbol'q"
	SetVariable offsettheta,limits={-90,90,0.1},value= root:ARToFData:offsettheta
	SetVariable offsetomega,pos={163,265},size={55,18},disable=2,proc=sycomegaoffset,title="\\f01\\F'@Arial Unicode MS'\\M\\F'symbol'w"
	SetVariable offsetomega,limits={-180,180,0.5},value= root:ARToFData:offsetomega
	SetVariable offsetphi,pos={163,303},size={55,18},disable=2,proc=sycphioffset,title="\\f01\\F'@Arial Unicode MS'\\M\\F'symbol'j"
	SetVariable offsetphi,limits={-90,90,0.1},value= root:ARToFData:offsetphi
	Button addtrace,pos={694,79},size={65,20},proc=gettraces,title="\\F'@Arial Unicode MS'TRACE"
	Button removetraces,pos={694,98},size={65,20},proc=removetraces,title="\\F'@Arial Unicode MS'RemTr"
	Button getcusors,pos={325,35},size={75,22},proc=getcusors,title="\\F'@Arial Unicode MS'AddKNodes"
	Button getarbKEDC,pos={531,254},size={90,20},proc=getkxkyEDC,title="\\F'@Arial Unicode MS'EDC(Kx,Ky)"
	Button getEDCstack,pos={327,262},size={90,20},proc=getEDCstack,title="\\F'@Arial Unicode MS'EDCStack"
	SetVariable ktolerance,pos={535,276},size={87,18},title="\\Z10\\F'@Arial Unicode MS'RKbind"
	SetVariable ktolerance,value= root:ARToFData:ktolerance
	Button CalcutsArea,pos={168,220},size={143,19},proc=calcutsarea,title="CalMappingArea"
	Button CalcutsArea,font="@Arial Unicode MS"
	SetVariable theta1,pos={182,179},size={110,18},title="\\f01\\F'@Arial Unicode MS'\\M\\F'symbol'q1"
	SetVariable theta1,value= root:ARToFData:thetaangle1
	CheckBox adjustoffset,pos={208,246},size={83,16},proc=adjustoffsetornot,title="\\F'@Arial Unicode MS'AdjustOffset"
	CheckBox adjustoffset,variable= root:ARToFData:adjustoffset
	SetVariable EDCkxpos,pos={645,254},size={80,18},proc=EDCspotkxpos,title="\\Z10\\F'@Arial Unicode MS'Kx"
	SetVariable EDCkxpos,limits={-3,3,0.01},value= root:ARToFData:EDCkxpos
	SetVariable EDCkypos,pos={646,274},size={80,18},proc=EDCspotkypos,title="\\Z10\\F'@Arial Unicode MS'Ky"
	SetVariable EDCkypos,limits={-3,3,0.01},value= root:ARToFData:EDCkypos
	SetVariable EkimageEDCKpos,pos={329,187},size={100,18},proc=EkimageEDCkposAdjust,title="\\Z10\\F'@Arial Unicode MS'Kpos"
	SetVariable EkimageEDCKpos,limits={-3,3,0.001},value= root:ARToFData:EkimageEDCkpos
	SetVariable EkimageMDCEpos,pos={328,227},size={100,18},proc=EkimageMDCKposAdjust,title="\\Z10\\F'@Arial Unicode MS'Epos"
	SetVariable EkimageMDCEpos,limits={-3,3,0.001},value= root:ARToFData:EkimageMDCEpos
	TabControl Dispersion,pos={320,8},size={183,352},proc=dispersionandfit
	TabControl Dispersion,font="@Arial Unicode MS",tabLabel(0)="Dispersion"
	TabControl Dispersion,tabLabel(1)="FittingDis",value= 0
	SetVariable MDCstackoffset,pos={326,58},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Offset"
	SetVariable MDCstackoffset,value= root:ARToFData:MDCFit:MDCstackoffset
	SetVariable MDCstackbindingnum,pos={412,57},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Bind#"
	SetVariable MDCstackbindingnum,value= root:ARToFData:MDCFit:MDCstackbindingnum
	SetVariable MDCstackEstart,pos={327,77},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Estart"
	SetVariable MDCstackEstart,value= root:ARToFData:MDCFit:MDCstackEstart
	SetVariable MDCstackEend,pos={411,77},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Eend"
	SetVariable MDCstackEend,value= root:ARToFData:MDCFit:MDCstackEend
	SetVariable MDCstackKstart,pos={327,96},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Kstart"
	SetVariable MDCstackKstart,value= root:ARToFData:MDCFit:MDCstackKstart
	SetVariable MDCstackKend,pos={412,97},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Kend"
	SetVariable MDCstackKend,value= root:ARToFData:MDCFit:MDCstackKend
	SetVariable FittingLorentznum,pos={325,142},size={100,18},disable=1,proc=loretznum,title="\\Z10\\F'@Arial Unicode MS'Lorentz#"
	SetVariable FittingLorentznum,limits={1,2,1},value= root:ARToFData:MDCFit:FittingLorentznum
	SetVariable Fittingbackground1,pos={326,165},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'BKGD"
	SetVariable Fittingbackground1,value= root:ARToFData:MDCFit:Fittingbackground1
	SetVariable fittingheight1,pos={408,164},size={85,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Height"
	SetVariable fittingheight1,value= root:ARToFData:MDCFit:fittingheight1
	SetVariable fittingfwhm1,pos={325,183},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'FWHM"
	SetVariable fittingfwhm1,value= root:ARToFData:MDCFit:fittingfwhm1
	SetVariable fittingposition1,pos={407,184},size={85,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Position"
	SetVariable fittingposition1,value= root:ARToFData:MDCFit:fittingposition1
	SetVariable Fittingbackground2,pos={325,209},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'BKGD"
	SetVariable Fittingbackground2,value= root:ARToFData:MDCFit:Fittingbackground2
	SetVariable fittingheight2,pos={409,208},size={85,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Height"
	SetVariable fittingheight2,value= root:ARToFData:MDCFit:fittingheight2
	SetVariable fittingfwhm2,pos={326,227},size={80,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'FWHM"
	SetVariable fittingfwhm2,value= root:ARToFData:MDCFit:fittingfwhm2
	SetVariable fittingposition2,pos={410,227},size={85,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'Position"
	SetVariable fittingposition2,value= root:ARToFData:MDCFit:fittingposition2
	Button MDCStacks,pos={330,119},size={79,18},disable=1,proc=MDCStacks,title="\\F'@Arial Unicode MS'MDCStack"
	Button MDCfitting,pos={332,245},size={150,20},disable=1,proc=MDCfitting,title="\\F'@Arial Unicode MS'Fit"
	SetVariable energyfarEF,pos={327,313},size={85,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'FarEF"
	SetVariable energyfarEF,value= root:ARToFData:MDCFit:energyfarEF
	SetVariable energynearEF,pos={416,315},size={85,18},disable=1,title="\\Z10\\F'@Arial Unicode MS'NearEF"
	SetVariable energynearEF,value= root:ARToFData:MDCFit:energynearEF
	Button showdispersion,pos={330,35},size={150,20},disable=1,proc=showdispersion,title="\\F'@Arial Unicode MS'ShowDispersion"
	Button ShowfittedDispersion,pos={333,278},size={150,20},disable=1,proc=showfitteddispersion,title="GetFittedDispersion"
	Button ShowfittedDispersion,font="@Arial Unicode MS"
	Button ShowImageEnergy,pos={331,334},size={150,20},disable=1,proc=showimageenergy,title="GetSelfEnergy"
	Button ShowImageEnergy,font="@Arial Unicode MS"
	Button showcutpos,pos={412,118},size={80,20},disable=1,proc=showcutpos,title="\\F'@Arial Unicode MS'ShowcutPos"
	Button symmetrizeFS,pos={730,119},size={36,36},proc=SyFS_ZWT,title=""
	Button symmetrizeFS,picture= ProcGlobal#symmetrizeFS
	Button help2dto3D,pos={760,3},size={20,20},proc=help2dto3d,title="\\f01\\Z15\\F'@Arial Unicode MS'?"
	Button Pouse,pos={614,330},size={32,33},disable=2,proc=pauseshow,title=""
	Button Pouse,picture= ProcGlobal#PauseB
	Button Stop,pos={679,330},size={32,33},disable=2,proc=stopshow,title=""
	Button Stop,picture= ProcGlobal#stopB
	PopupMenu kpntpos,pos={409,36},size={88,20},bodyWidth=70,proc=chooseknodes,title="\\F'@Arial Unicode MS'K#"
	PopupMenu kpntpos,mode=1,popvalue="KPnt1",value= #"kpathnodes"
	Button clearknodes,pos={322,81},size={77,20},proc=clearknodes,title="\\F'@Arial Unicode MS'ClearKnodes"
	SetVariable kpathpntnum,pos={325,114},size={60,16},title="#"
	SetVariable kpathpntnum,value= root:ARToFData:kpathpntnum
	CheckBox colorscalelowzero,pos={301,370},size={24,14},proc=disablelowcolorz,title="0"
	CheckBox colorscalelowzero,value= 0
	CheckBox colorscalehighzero,pos={302,391},size={24,14},proc=disablehighcolorz,title="0"
	CheckBox colorscalehighzero,value= 0
	Button ShowKNodesInfor,pos={399,81},size={100,20},proc=editknodesinfor,title="\\F'@Arial Unicode MS'EditKNodesInfor"
	Button delete3dwave,pos={42,373},size={34,34},proc=delete3dwaves,title=""
	Button delete3dwave,font="@Arial Unicode MS",picture= ProcGlobal#deletebuttonjxw
	TitleBox drawfs,pos={687,154},size={34,16},title="\\F'@Arial Unicode MS'GetFS"
	TitleBox drawfs,frame=0
	TitleBox symmfs,pos={731,153},size={40,16},title="\\F'@Arial Unicode MS'SymFS"
	TitleBox symmfs,frame=0
	SetVariable version,pos={8,422},size={70,16},value= _STR:"2011-08-18"
	Button edittable,pos={120,372},size={32,32},proc=edit3ddatatable,title=""
	Button edittable,font="@Arial Unicode MS",picture= ProcGlobal#tabledit
	Button edittable1,pos={85,372},size={32,32},proc=saveparameter,title=""
	Button edittable1,font="@Arial Unicode MS",picture= ProcGlobal#savebutton
	SetVariable offsetomega1,pos={218,266},size={43,16},disable=2,title=" "
	SetVariable offsetomega1,value= root:ARToFData:lomegaoffset1
	SetVariable offsetomega2,pos={272,266},size={43,16},disable=2,title=" "
	SetVariable offsetomega2,value= root:ARToFData:lomegaoffset2
	SetVariable offsetomega3,pos={218,286},size={43,16},disable=2,title=" "
	SetVariable offsetomega3,value= root:ARToFData:lthetaoffset1
	SetVariable offsetomega4,pos={273,285},size={43,16},disable=2,title=" "
	SetVariable offsetomega4,value= root:ARToFData:lthetaoffset2
	SetVariable offsetomega5,pos={218,306},size={43,16},disable=2,title=" "
	SetVariable offsetomega5,value= root:ARToFData:lphioffset1
	SetVariable offsetomega6,pos={273,305},size={43,16},disable=2,title=" "
	SetVariable offsetomega6,value= root:ARToFData:lphioffset2
EndMacro




Function refreshartofdata(ctrlName) : ButtonControl
	String ctrlName
			setdatafolder root:ARToFData
			svar artofdatanamelist
          wave/T artofdatanamelist4listbox
			//svar imagelist
			variable ii,itemnum
			artofdatanamelist=wavelist("*",";","DIMS:3")
			itemnum=itemsinlist(artofdatanamelist)
			redimension/N=(itemnum) artofdatanamelist4listbox
			ii=0
			do
			artofdatanamelist4listbox[ii]=stringfromlist(ii,artofdatanamelist)
			//print stringfromlist(ii,artofdatanamelist)
			ii+=1
			while(ii<itemnum)
	
			ListBox artofdata,listWave=root:ARToFData:artofdatanamelist4listbox
			creat3dtable()
End



Function creatcut(ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:ARToFData
	///nvar artof_flag
	//nvar cursorornot=root:ARToFData:cursorornot
	//nvar setcutkx_s=root:ARToFData:setcutkx_s
	//nvar setcutky_s=root:ARToFData:setcutky_s
	nvar kpathpntnum=root:ARToFData:kpathpntnum
	
	wave tmpx=root:ARToFData:KPathpnt_x
	wave tmpy=root:ARToFData:KPathpnt_y
	
	if((!waveexists(tmpx))||(!waveexists(tmpy)))
	abort "No nodes for K path existed!!"
	endif
	//nvar setcutkx_e=root:ARToFData:setcutkx_e
	//nvar setcutky_e=root:ARToFData:setcutky_e
	
	variable kpathlengthnum,totallength=0,currlength,currentlengthnum
	variable ii,iimax,x1,y1,x2,y2
	iimax=dimsize(tmpx,0)
	

	
	make/O/N=0 Rkx_wave,Rky_wave
	

	ii=1
	do
	x1=tmpx[ii-1]
	y1=tmpy[ii-1]
	x2=tmpx[ii]
	y2=tmpy[ii]
	totallength+=sqrt((x2-x1)^2+(y2-y1)^2)
	ii+=1
	while(ii<iimax)
	
	ii=1
	do
	x1=tmpx[ii-1]
	y1=tmpy[ii-1]
	x2=tmpx[ii]
	y2=tmpy[ii]
	currlength=sqrt((x2-x1)^2+(y2-y1)^2)
	currentlengthnum=round((currlength/totallength)* kpathpntnum)
	//print currentlengthnum
	//print x1,y1,x2,y2
	catchkpath(x1,y1,x2,y2,currentlengthnum)
	ii+=1
	while(ii<iimax)
   
	
	//print cutlength///////////////
	//redimension/N=(cutlength) Rkx_wave,Rky_wave
	removefromgraph/Z Rky_wave
	//appendtograph/W=MomentumMap Rky_wave vs Rkx_wave
	appendtograph Rky_wave vs Rkx_wave
	ModifyGraph mode(Rky_wave)=3,marker(Rky_wave)=8,msize(Rky_wave)=2

End

function catchkpath(x1,y1,x2,y2,knum)
variable x1,y1,x2,y2,knum

variable kpathpntnum=knum

variable  xstart,ystart,xend,yend,xinc,yinc,ii,kk,xx,yy,currentlen
wave Rkx_wave=root:ARToFData:Rkx_wave
wave RKy_wave=root:ARToFData:Rky_wave

currentlen=dimsize(Rkx_wave,0)
redimension/N=(currentlen+knum) Rkx_wave,Rky_wave

xstart=x1
ystart=y1

xend=x2
yend=y2

	xinc=(xend-xstart)/kpathpntnum
	yinc=(yend-ystart)/kpathpntnum
	
	if((xend-xstart)!=0)
		kk=(yend-ystart)/(xend-xstart)
		ii=0
		do
			xx=xstart+ii*xinc
			yy=kk*(xx-xstart)+ystart
			//inter_z=interp2D(tmp,xx,yy)
			//if(inter_z>0.9)
			Rkx_wave[ii+currentlen]=xx
			Rky_wave[ii+currentlen]=yy
			//cutlength+=1
			//endif
			ii+=1
		while(ii<kpathpntnum)
	endif
	
	if((xend-xstart)==0)
		ii=0
		do
			yy=ystart+ii*yinc
			xx=xstart
			//inter_z=interp2D(tmp,xx,yy)
			//if(inter_z>=0.9)
			Rkx_wave[ii+currentlen]=xx
			Rky_wave[ii+currentlen]=yy
			//cutlength+=1
			//endif
			ii+=1
		while(ii<kpathpntnum)
	endif
end


Function showmomentummap(ctrlName) : ButtonControl
	String ctrlName

setdatafolder root:ARToFData
nvar artof_flag
if(artof_flag==1)

nvar PhotonE=root:ARToFData:PhotonEnergy
nvar WorkFunc= root:ARToFData:WorkFunction
nvar LC=root:ARToFData:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
nvar RAngle=root:ARToFData:RotationAngle
nvar Theta0=root:ARToFData:ThetaAngle
nvar Phi0=root:ARToFData:PhiAngle
nvar DetectorAngle0=root:ARToFData:DetectorAngle
nvar artofflag=root:MomentumMap:ARToFFlag
nvar BZShowmode=root:ARToFData:BZShowMode
nvar fromline2artof=root:MomentumMap:fromline2artof

	///offset由3D程序面板设定///2011-08-13 by JXW
	nvar thetaoffset=root:ARToFData:offsettheta
	nvar omegaoffset=root:ARToFData:offsetomega
	nvar phioffset=root:ARToFData:offsetphi
	//offsettheta=thetaoffset
	//offsetomega=omegaoffset
	//offsetphi=phioffset
 	///offset由3D程序面板设定
 	
 	///将offset反映入3D数据
 	
 	offset3D(thetaoffset,phioffset)///2011-08-13 by JXW

dowindow/F MomentumMapArea
variable xmin,xinc,ymin,yinc

if(BZShowmode==0)

make/O/N=(200,200) artof_area=0
xmin=-1
ymin=-1
xinc=0.01
yinc=0.01

setscale/I x,-1,1,artof_area
setscale/I y,-1,1,artof_area

endif 

if((BZShowmode==1)||(BZShowmode==2))

make/O/N=(400,400) artof_area=0
xmin=-2
ymin=-2
xinc=0.01
yinc=0.01

setscale/I x,-2,2,artof_area
setscale/I y,-2,2,artof_area

endif

variable RK0=K0*sin(3.1416/180*(DetectorAngle0/2))



variable k_o=K0*cos(3.1416/180*(DetectorAngle0/2))
variable kx=K_o*sin(3.1416/180*Phi0)
variable ky=K_o*sin(3.1416/180*Theta0)*cos(3.1416/180*Phi0)
variable kz=K_o*cos(3.1416/180*Theta0)*cos(3.1416/180*Phi0)

variable Rkx=sqrt(kx*kx+ky*ky)*cos((atan2(ky,kx))+RAngle*pi/180)
variable Rky=sqrt(kx*kx+ky*ky)*sin((atan2(ky,kx))+RAngle*pi/180)
variable Rkz=kz
//print Rkx,Rky,"RRR"
variable xx,yy,zz
variable ii=0,jj=0
do
	jj=0
	do
		
		xx=xmin+ii*xinc
		yy=ymin+jj*yinc
		
		if(Rkz!=0)
		zz=Rkz-(Rkx*xx+Rky*yy-Rkx*Rkx-Rky*Rky)/Rkz
			
			if((xx*xx+yy*yy+zz*zz)<=K0*K0)	
		    artof_area[ii][jj]=1
		
		    endif
		endif
		
		if(Rkz==0)
		
			if((Rkx==0)&&(Rky!=0))
		
		    	if(abs(yy-Rky)<=0.01)
		    		if(xx*xx<=K0*K0-yy*yy)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		    
		    if((Rkx!=0)&&(Rky==0))
		    	
		    	if(abs(xx-Rky)<=0.01)
		    		if(yy*yy<=K0*K0-xx*xx)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		    
		    if((Rkx!=0)&&(Rky!=0))
		    
		    	if(abs(Rkx*xx+Rky*yy-Rkx*Rkx-Rky*Rky)<=0.01)
		    		if((xx*xx+yy*yy)<=K0*K0)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		endif
		    
		
		
	jj+=1
	while(jj<400)
	ii+=1
while(ii<400)


//string ctrlName=""
	
	if(BZShowmode==0)
	if((V_Flag==0)||(fromline2artof==0))
		dowindow/K MomentumMapArea
		Display/K=1 as "Momentum Map";AppendImage artof_area
		XJZSecondBZ(ctrlName)
		ModifyImage artof_area ctab= {*,*,Terrain256,1}
		ModifyGraph standoff=0
		ModifyGraph rgb=(0,0,0)
		ModifyGraph lsize=1
		ModifyGraph fStyle=1
		ModifyGraph width={Aspect,1}
		Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		ModifyGraph width=368.504,height=368.504
		dowindow/C MomentumMapArea
		fromline2artof=0
	endif
	
	RemoveFromGraph/Z Hexy
	SetAxis bottom -1,1 
    SetAxis left -1,1  
	endif

	if(BZShowmode==1)
	if((V_Flag==0)||(fromline2artof==0))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage artof_area
	XJZSecondBZ(ctrlName)
	ModifyImage artof_area ctab= {*,*,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	SetAxis bottom -2,2 
    SetAxis left -2,2 
	endif
	
    IF (BZShowmode==2)    
	if((V_Flag==0)||(fromline2artof==0))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage artof_area
	XJZSecondBZ(ctrlName)
	ModifyImage artof_area ctab= {*,*,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	XJZThirdBZ(ctrlName)      
	ModifyGraph rgb(Hexy)=(0,65280,0) 
    ModifyGraph lsize(Hexy)=2  
    
	SetAxis bottom -2,2 
    SetAxis left -2,2 	                              
    ENDIF
	

endif

if(artof_flag==0)
cut2d_area()

endif

end

function CalARToFMappingArea()

nvar PhotonE=root:ARToFData:PhotonEnergy
nvar WorkFunc= root:ARToFData:WorkFunction
nvar LC=root:ARToFData:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
nvar RAngle00=root:ARToFData:RotationAngle
nvar Theta00=root:ARToFData:ThetaAngle
nvar Phi00=root:ARToFData:PhiAngle
nvar DetectorAngle0=root:ARToFData:DetectorAngle
nvar artofflag=root:MomentumMap:ARToFFlag
nvar BZShowmode=root:ARToFData:BZShowMode
nvar fromline2artof=root:MomentumMap:fromline2artof

	///offset由3D程序面板设定///2011-08-13 by JXW
	nvar thetaoffset=root:ARToFData:offsettheta
	nvar omegaoffset=root:ARToFData:offsetomega
	nvar phioffset=root:ARToFData:offsetphi
	//offsettheta=thetaoffset
	//offsetomega=omegaoffset
	//offsetphi=phioffset
 	///offset由3D程序面板设定
 	
 	///将offset反映入3D数据
 	
 	offset3D(thetaoffset,phioffset)///2011-08-13 by JXW
 	
 	variable RAngle=Rangle00-omegaoffset
 	variable Theta0=Theta00-thetaoffset
 	variable Phi0=Phi00-phioffset///将offset反映入mapping范围
 	
 		
dowindow/F MomentumMapArea
variable xmin,xinc,ymin,yinc

if(BZShowmode==0)

make/O/N=(200,200) artof_area=0
xmin=-1
ymin=-1
xinc=0.01
yinc=0.01

setscale/I x,-1,1,artof_area
setscale/I y,-1,1,artof_area

endif 

if((BZShowmode==1)||(BZShowmode==2))

make/O/N=(400,400) artof_area=0
xmin=-2
ymin=-2
xinc=0.01
yinc=0.01

setscale/I x,-2,2,artof_area
setscale/I y,-2,2,artof_area

endif

variable RK0=K0*sin(3.1416/180*(DetectorAngle0/2))



variable k_o=K0*cos(3.1416/180*(DetectorAngle0/2))
variable kx=K_o*sin(3.1416/180*Phi0)
variable ky=K_o*sin(3.1416/180*Theta0)*cos(3.1416/180*Phi0)
variable kz=K_o*cos(3.1416/180*Theta0)*cos(3.1416/180*Phi0)

variable Rkx=sqrt(kx*kx+ky*ky)*cos((atan2(ky,kx))+RAngle*pi/180)
variable Rky=sqrt(kx*kx+ky*ky)*sin((atan2(ky,kx))+RAngle*pi/180)
variable Rkz=kz
//print Rkx,Rky,"RRR"
variable xx,yy,zz
variable ii=0,jj=0
do
	jj=0
	do
		
		xx=xmin+ii*xinc
		yy=ymin+jj*yinc
		
		if(Rkz!=0)
		zz=Rkz-(Rkx*xx+Rky*yy-Rkx*Rkx-Rky*Rky)/Rkz
			
			if((xx*xx+yy*yy+zz*zz)<=K0*K0)	
		    artof_area[ii][jj]=1
		
		    endif
		endif
		
		if(Rkz==0)
		
			if((Rkx==0)&&(Rky!=0))
		
		    	if(abs(yy-Rky)<=0.01)
		    		if(xx*xx<=K0*K0-yy*yy)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		    
		    if((Rkx!=0)&&(Rky==0))
		    	
		    	if(abs(xx-Rky)<=0.01)
		    		if(yy*yy<=K0*K0-xx*xx)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		    
		    if((Rkx!=0)&&(Rky!=0))
		    
		    	if(abs(Rkx*xx+Rky*yy-Rkx*Rkx-Rky*Rky)<=0.01)
		    		if((xx*xx+yy*yy)<=K0*K0)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		endif
		    
		
		
	jj+=1
	while(jj<400)
	ii+=1
while(ii<400)

end


Function getdispersion(ctrlName) : ButtonControl
	String ctrlName

	setdatafolder root:ARToFData
	nvar artof_flag

	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	nvar RAngle=root:ARToFData:RotationAngle
	nvar Theta0=root:ARToFData:ThetaAngle
	nvar Phi0=root:ARToFData:PhiAngle
	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	nvar/Z omegaoffset=root:PROCESS:OmegaOffset
	svar choosecolortablename=root:ARToFData:choosecolortablename
	//variable RK0=K0*sin(3.1416/180*(DetectorAngle0/2))
	
	wave/Z theta_angle=root:OriginalData:Theta_Angle
	wave/Z phi_angle=root:OriginalData:Phi_Angle
	wave/Z omega_angle=root:OriginalData:Omega_Angle
	wave/Z processflag=root:OriginalData:ProcessFlag

	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	nvar artofflag=root:MomentumMap:ARToFFlag
	nvar BZShowmode=root:ARToFData:BZShowMode
	nvar fromline2artof=root:MomentumMap:fromline2artof

	nvar/Z processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar/Z thetaoffset=root:PROCESS:ThetaOffset
	nvar/Z phioffset=root:PROCESS:PhiOffset
	//nvar/Z omegaoffset=root:PROCESS:OmegaOffset
	nvar omegaoffset=root:ARToFData:offsetomega
	
	////adding Lienear offset 
	nvar lomegaoffset1=root:ARToFData:lomegaoffset1
	nvar lomegaoffset2=root:ARToFData:lomegaoffset2
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2
	
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	variable lthetainter=(lthetaoffset1*orithetaend-lthetaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lthetacof=(lthetaoffset2-lthetaoffset1)/(orithetaend-orithetastart)
	
	variable lphiinter=(lphioffset1*orithetaend-lphioffset2*orithetastart)/(orithetaend-orithetastart)
	variable lphicof=(lphioffset2-lphioffset1)/(orithetaend-orithetastart)
	
	variable lomegainter=(lomegaoffset1*orithetaend-lomegaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lomegacof=(lomegaoffset2-lomegaoffset1)/(orithetaend-orithetastart)
	////adding Lienear offset 	
	
	variable ii,omega,phiangle,datapntnum
	datapntnum=dimsize(processflag,0)
	
	ii=0
	if(artof_flag==0)
	do
		if(processedimageflag==processflag[ii])
		omega=omega_angle[ii]
		phiangle=phi_angle[ii]
		break
		endif
		ii+=1
	while(ii<datapntnum)
	omega=omega-omegaoffset
	endif
	
	if(artof_flag==1)
	omega=Rangle-omegaoffset
	endif
	
	wave Rky_wave,Rkx_wave
	variable pntnum
	pntnum=dimsize(Rky_wave,0)
	
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	
	variable Emin,Einc,Elength,Ebinding
	Emin=dimoffset($tmp[V_Value],2)
	Einc=dimdelta($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	//print tmp[V_Value]
	//print Emin,Einc,Elength,Emin+(Elength-1)*Einc
	string/G Sanglex,Sangley,Eanglex,Eangley
	variable/G Sx,Sy,Ex,Ey
	variable jj=0,xx,yy,ee
	
	nvar holdimageornot=root:ARToFData:holdimageornot
	
	string EKImageArbCutname
	if(holdimageornot==1)
	EKImageArbCutname="EKImageArbCut"+num2str(itemsinlist(wavelist("EKImageArbCut*",";","DIMS:2"))+1)
	else
	EKImageArbCutname="EKImageArbCut"
	endif
	
	
	
	
	make/O/N=(pntnum,Elength) $EKImageArbCutname=0
	
	wave EKImageArbCut=$EKImageArbCutname
	variable kx,ky,theta,phi,interp_value
	
	ii=0
	jj=0
	
	///----fix phi>90 bug
	variable vv
	nvar v1=root:ARToFData:oriphiend
	nvar v2=root:ARToFData:oriphistart
	vv=min(abs(v1),abs(v2))
	///----fix phi>90 bug
	
	do
	ee=Emin+jj*Einc
		ii=0
		do
		xx=Rkx_wave[ii]
		yy=Rky_wave[ii]
		
		kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
		ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
		
		///需要修改调整
		////考虑能量对动量的修正
		K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
		
		if(artof_flag==0)
		phi=-asin(kx/K0)
		endif
		if(artof_flag==1)
		phi=asin(kx/K0)
		endif
		
		theta=asin(ky/K0/cos(phi))
	
		theta=theta*180/pi
		phi=phi*180/pi
		
		///---fix phi>90 bug
		if(vv>90)
		phi=-(180+phi)
		endif
		
		//if(ii==0)
			
		//	sprintf Sanglex,"%.2f",xx
			//Sanglex=num2str(xx)
		//	Sx=xx
		//	sprintf Sangley,"%.2f",yy
			//Sangley=num2str(yy)
		//	Sy=yy
		//	endif
		
		//jj=0
		//do
		//ee=Emin+jj*Einc
		//EKImageArbCut[ii][jj]=interp3D($tmp[V_Value],phi,theta,ee)
		//jj+=1
		//while(jj<Elength)
		if(!artof_flag)
				theta=(theta+lthetainter+lthetacof*thetaoffset)/(1-lthetacof)//+thetaoffset
				phi=phi+lphiinter+lphicof*(theta+thetaoffset)
		endif
		
		EKImageArbCut[ii][jj]=interp3D($tmp[V_Value],phi,theta,ee)
		ii+=1
	while(ii<pntnum)
	jj+=1
while(jj<Elength)
	
			
			sprintf Sanglex,"%.2f",Rkx_wave[0]
			//Sanglex=num2str(xx)
			Sx=Rkx_wave[0]
			sprintf Sangley,"%.2f",Rky_wave[0]
			//Sangley=num2str(yy)
			Sy=Rky_wave[0]
			
			sprintf Eanglex,"%.2f",Rkx_wave[pntnum-1]
			//Sanglex=num2str(xx)
			Ex=Rkx_wave[pntnum-1]
			sprintf Eangley,"%.2f",Rky_wave[pntnum-1]
			//Sangley=num2str(yy)
			Ey=Rky_wave[pntnum-1]
	
	string Scutinfor="("+Sanglex+","+Sangley+")"
	string Ecutinfor="("+Eanglex+","+Eangley+")"
	

	
	wave tmpx=root:ARToFData:KPathpnt_x
	wave tmpy=root:ARToFData:KPathpnt_y
	if(!waveexists(tmpx))
	abort "No nodes for K path existed!!"
	endif
		
	variable iimax,x1,y1,x2,y2,totallength
	iimax=dimsize(tmpx,0)

	ii=1
	do
	x1=tmpx[ii-1]
	y1=tmpy[ii-1]
	x2=tmpx[ii]
	y2=tmpy[ii]
	totallength+=sqrt((x2-x1)^2+(y2-y1)^2)
	ii+=1
	while(ii<=iimax)
		
	
	setscale/P y,Emin,Einc,EKImageArbCut
	setscale/I x,0,totallength,EKImageArbCut

	////debug
	//print Sx,Sy,Ex,Ey
	//print sqrt((Ey-Sy)^2+(Ex-Sx)^2)
	svar choosecolortablename=root:ARToFData:choosecolortablename
	
	if(holdimageornot==0)
	dowindow/K EKImageARToF
	display/K=1; appendimage EKImageArbCut
	choosecolortable(ctrlName,0,choosecolortablename)
	//ModifyImage EKImageArbCut ctab= {*,*,$choosecolortablename,1}
	ModifyGraph standoff=0
	//ModifyGraph fStyle=1
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	ModifyGraph tick(bottom)=2,noLabel(bottom)=0
	//TextBox/C/N=text1/X=-45/Y=-58/F=0/A=MC "\\f01\\Z15"+Scutinfor
	//TextBox/C/N=text2/X=40/Y=-58/F=0/A=MC "\\f01\\Z15"+Ecutinfor
	//ModifyGraph width=283.465,height=396.85
	Label bottom "\\F'Times'\\Z18K//(\\F'symbol'p/\\F'Times'a)"
	addkpntinfor(EKImageArbCut)
	dowindow/C EKImageARToF
	
	endif
	
	if(holdimageornot==1)
	//dowindow/K EKImageARToF
	display/K=1; appendimage EKImageArbCut
	choosecolortable(ctrlName,0,choosecolortablename)
	//ModifyImage $EKImageArbCutname ctab= {*,*,$choosecolortablename,1}
	ModifyGraph standoff=0
	//ModifyGraph fStyle=1
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	ModifyGraph tick(bottom)=2,noLabel(bottom)=0
	//TextBox/C/N=text1/X=-45/Y=-58/F=0/A=MC "\\f01\\Z15"+Scutinfor
	//TextBox/C/N=text2/X=40/Y=-58/F=0/A=MC "\\f01\\Z15"+Ecutinfor
	//ModifyGraph width=283.465,height=396.85
	Label bottom "\\F'Times'\\Z18K//(\\F'symbol'p/\\F'Times'a)"
	addkpntinfor(EKImageArbCut)
	//dowindow/C EKImageARToF
	endif

	
//if(artof_flag==0)
//dispersion2D()
//endif
	
//print RK0///for dubug
End

function addkpntinfor(w)
wave w

//nvar kpathnodes=root:ARToFData:kpathnodes
string kpathnodes
wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y
if(!waveexists(tmpx))
abort "No nodes for K path existed!!"
endif

variable v1=0,ii,iimax,ymin,yinc,ymax
variable x1,y1,x2,y2

ymin=dimoffset(w,1)
yinc=dimdelta(w,1)
ymax=ymin+(dimsize(w,1)-1)*yinc

iimax=dimsize(tmpx,0)
ii=1
do
x1=tmpx[ii-1]
y1=tmpy[ii-1]
x2=tmpx[ii]
y2=tmpy[ii]
v1+=sqrt((x2-x1)^2+(y2-y1)^2)

SetDrawEnv xcoord= bottom,ycoord= left
drawline v1,ymin,v1,ymax
ii+=1
while(ii<=iimax)

ii=0
v1=0
do
if(ii>0)
x1=tmpx[ii-1]
y1=tmpy[ii-1]
x2=tmpx[ii]
y2=tmpy[ii]
v1+=sqrt((x2-x1)^2+(y2-y1)^2)
endif
SetDrawEnv xcoord= bottom,ycoord= left,fstyle= 1,fsize= 15,textxjust= 1
kpathnodes="P"+num2str(ii+1)
drawtext v1,ymin,kpathnodes
ii+=1
while(ii<iimax)

end

Function gettrialdata(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:ARToFData
	make/O/N=(100,100,200) Trial_ARToF=0
	
	nvar detectorangle=root:ARToFData:DetectorAngle
	nvar theta=root:ARToFData:thetaangle
	nvar phi=root:ARToFData:phiangle
	
	setscale/I x,(-16+phi),(16+phi),Trial_ARToF
	setscale/I y,(-16+theta),(16+theta),Trial_ARToF
	
	//setscale x,-16,16,Trial_ARToF
	//setscale y,-16,16,Trial_ARToF
	setscale/I z,-0.3,0.1,Trial_ARToF
	
	variable xmin,xinc,xlength,ymin,yinc,ylength,Emin,Einc,Elength
	variable kx,ky,Ebinding
	
	xmin=dimoffset(Trial_ARToF,0)
	xinc=dimdelta(Trial_ARToF,0)
	xlength=dimsize(Trial_ARToF,0)
	
	ymin=dimoffset(Trial_ARToF,1)
	yinc=dimdelta(Trial_ARToF,1)
	ylength=dimsize(Trial_ARToF,1)
	
	Emin=dimoffset(Trial_ARToF,2)
	Einc=dimdelta(Trial_ARToF,2)
	Elength=dimsize(Trial_ARToF,2)
	
	variable ii=0,jj=0,kk=0
	do
		jj=0
		do
			kx=xmin+ii*xinc-phi
			ky=ymin+jj*yinc-theta
			kk=0
			do
				Ebinding=Emin+kk*Einc
				if((kx*kx+ky*ky)<=detectorangle*detectorangle/4)
				//A(k,w)*f(w) assume ek=0.1-0.01778*k^2,ImE=0.01,ReE=0,T=25K. This is not true in real case but for demonstration
				Trial_ARToF[ii][jj][kk]=0.01/((Ebinding-0.1+0.0017777777778*(kx*kx+ky*ky))^2+0.0001)/(1+exp(11594*Ebinding/20))///trialdata 1
				
				//assume ek=0.0013888*k^2-0.2
				//Trial_ARToF[ii][jj][kk]=0.01/((Ebinding+0.2-0.001388888888*(kx*kx+ky*ky))^2+0.0001)/(1+exp(11594*Ebinding/20))///trialdata 2		
				endif
				kk+=1
			while(kk<Elength+1)
		jj+=1
		while(jj<ylength+1)
	ii+=1
	while(ii<xlength+1)
	

End

Function showintensityvsk(ctrlName) : ButtonControl
	String ctrlName
	//variable en
	variable now=ticks
	dispersionandfit(ctrlName,0)
	TabControl Dispersion,win=VisualizeARToFData,value=0
	setdatafolder root:ARToFData
	
	nvar adjustoffset=root:ARToFData:adjustoffset
	
	nvar artof_flag
	
	///产生KxKy区域
	if(artof_flag)
	CalARToFMappingArea()
	else
	calcuts2D_area()
	endif
	///产生KxKy区域
	
	////adding Lienear offset 
	nvar lomegaoffset1=root:ARToFData:lomegaoffset1
	nvar lomegaoffset2=root:ARToFData:lomegaoffset2
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2
	
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	variable lthetainter=(lthetaoffset1*orithetaend-lthetaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lthetacof=(lthetaoffset2-lthetaoffset1)/(orithetaend-orithetastart)
	
	variable lphiinter=(lphioffset1*orithetaend-lphioffset2*orithetastart)/(orithetaend-orithetastart)
	variable lphicof=(lphioffset2-lphioffset1)/(orithetaend-orithetastart)
	
	variable lomegainter=(lomegaoffset1*orithetaend-lomegaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lomegacof=(lomegaoffset2-lomegaoffset1)/(orithetaend-orithetastart)
	////adding Lienear offset 	
	
	nvar savewaveornot=root:ARToFData:savewaveornot
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	
	nvar kxstart=root:ARToFData:kxstart
	nvar kxend=root:ARToFData:kxend
	nvar kystart=root:ARToFData:kystart
	nvar kyend=root:ARToFData:kyend
	nvar kxpntnum=root:ARToFData:kxpntnum
	nvar kypntnum=root:ARToFData:kypntnum
	nvar bindingenergy=root:ARToFData:bindingenergy
	nvar Energywindow=root:ARToFData:Energywindow
	nvar rotationangle=root:ARToFData:RotationAngle
	svar choosecolortablename=root:ARToFData:choosecolortablename
	
	if(artof_flag==0)
	wave tmp_area=root:ARToFData:cuts2d_area
	endif
	
	if(artof_flag==1)
	wave tmp_area=root:ARToFData:artof_area
	endif
	
	nvar savewaveornot=root:ARToFData:savewaveornot
	nvar holdintensityimage=root:ARToFData:holdintensityimage

	string intensityvsk_name
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	string prestr
	prestr=tmp[V_Value]
	if(savewaveornot==1)
		
		sprintf intensityvsk_name,"%.0f",abs(bindingenergy)*1000
		if(bindingenergy<0)
			intensityvsk_name=prestr[0,1]+"IntensityVSK_N"+intensityvsk_name+"meV"
		endif
		
		if(bindingenergy>=0)
			intensityvsk_name=prestr[0,1]+"IntensityVSK_P"+intensityvsk_name+"meV"
		endif
	endif
	
	if(savewaveornot==0)
		intensityvsk_name="IntensityVSMomentum"
	endif
	
	make/O/N=(kxpntnum,kypntnum) $intensityvsk_name=0
	setscale/I x,kxstart,kxend,$intensityvsk_name
	setscale/I y,kystart,kyend,$intensityvsk_name
	
	wave tmpwave=$intensityvsk_name
	variable ii=0,jj=0,kk=0,deltaE,Emin,Elength,Emax,xmin,xinc,ymin,yinc,xx,yy,ee
	
	xmin=kxstart
	xinc=(kxend-kxstart)/(kxpntnum-1)
	ymin=kystart
	yinc=(kyend-kystart)/(kypntnum-1)
	
	
	deltaE=dimdelta($tmp[V_Value],2)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*deltaE
	slider energypostion,win=VisualizeARToFData,limits={Emin,Emax,deltaE}
	slider energypostion,win=VisualizeARToFData,value=bindingenergy
	////限定自定义movie以及aotushow的能量调节范围
	SetVariable autoEstart,win=VisualizeARToFData,limits={Emin,Emax,deltaE}
	SetVariable autoEend,win=VisualizeARToFData,limits={Emin,Emax,deltaE}
	////限定自定义movie以及aotushow的能量调节范围
	
	//wave theta_angle=root:OriginalData:Theta_Angle
	//wave phi_angle=root:OriginalData:Phi_Angle
	wave/Z omega_angle=root:OriginalData:Omega_Angle
	wave/Z processflag=root:OriginalData:ProcessFlag
	wave/Z phi_angle=root:OriginalData:Phi_Angle
	//nvar DetectorAngle0=root:ARToFData:DetectorAngle
	//nvar artofflag=root:MomentumMap:ARToFFlag
	//nvar BZShowmode=root:ARToFData:BZShowMode
	//nvar fromline2artof=root:MomentumMap:fromline2artof

	nvar/Z processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar/Z thetaoffset=root:PROCESS:ThetaOffset
	nvar/Z phioffset=root:PROCESS:PhiOffset	
	nvar/Z omegaoffset=root:ARToFData:offsetomega
	
	variable omega,phiangle,datapntnum
	
	if(artof_flag==0)
	datapntnum=dimsize(processflag,0)
	ii=0
	do
		if(processedimageflag==processflag[ii])
		omega=omega_angle[ii]
		phiangle=phi_angle[ii]
		break
		endif
		ii+=1
	while(ii<datapntnum)
	omega=omega-omegaoffset
	endif
	
	if(artof_flag==1)
	omega=rotationangle-omegaoffset
	endif
	
	//print omega
	variable inter_sum,Estart=bindingenergy-Energywindow/2000
	variable kx,ky,theta,phi
	
		
	xinc=(kxend-kxstart)/(kxpntnum-1)
	yinc=(kyend-kystart)/(kypntnum-1)	
	
	
	variable value1
	

	variable vv,K00
	nvar v1=root:ARToFData:oriphiend
	nvar v2=root:ARToFData:oriphistart
	vv=min(abs(v1),abs(v2))>90
	//K00=0.5118*LC/3.1416
	K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+bindingenergy)
	//variable aa=0,bb=0//for debug
	variable theta1
	ii=0
	if(artof_flag==0)
	do
		xx=xmin+ii*xinc	
			jj=0
			do	
				yy=ymin+jj*yinc
				
				if(interp2D(tmp_area,xx,yy))
				

				
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
				
				phi=-asin(kx/K0)
				theta=asin(ky/K0/cos(phi))*180/pi
						
				phi=phi*180/pi
		
				///----fix phi>90 bug
				if(vv)
				phi=-(180+phi)
				endif
				///----fix phi>90 bug
			
				//theta=theta+lthetainter+lthetacof*theta

				theta=(theta+lthetainter+lthetacof*thetaoffset)/(1-lthetacof)//+thetaoffset
				phi=phi+lphiinter+lphicof*(theta+thetaoffset)
				//phi=(phi+lphiinter)/(1-lphicof)
				
					inter_sum=0;ee=Estart//kk=0;
					do

						value1=interp3D($tmp[V_Value],phi,theta,ee)
						if(savewaveornot) ////消除白边	
							inter_sum+=(numtype(value1))?0:value1
						else 
							inter_sum+=value1
						endif
						//kk+=1
						ee+=deltaE
					while(ee<=(bindingenergy+Energywindow/2000))
					tmpwave[ii][jj]=inter_sum

				endif
			jj+=1
			while(jj<kypntnum)
		ii+=1
	while(ii<kxpntnum)
	endif
	//print theta,phi
	//print lthetainter+lthetacof*8
	ii=0
	
	if(artof_flag==1)
	do
		xx=xmin+ii*xinc	
			jj=0
			do	
				yy=ymin+jj*yinc
				if(interp2D(tmp_area,xx,yy))
				
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
				
				phi=asin(kx/K0)						
				theta=asin(ky/K0/cos(phi))*180/pi
				phi=phi*180/pi
						
				///----fix phi>90 bug
				if(vv)
				phi=-(180+phi)
				endif
				///----fix phi>90 bug
				//theta=(theta+lthetainter)/(1-lthetacof)+thetaoffset
				//phi=phi+lphiinter+lphicof*theta

					inter_sum=0;ee=Estart;//kk=0
					do
					
						///考虑Eb对动量的修正
						//ee=Estart+kk*deltaE
						//K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
						//K0=K00*Sqrt(PhotonE-WorkFunc+ee)

						
						value1=interp3D($tmp[V_Value],phi,theta,ee)
						if(savewaveornot) ////消除白边	
							inter_sum+=(numtype(value1))?0 : value1
						else 
							inter_sum+=value1
						endif
						//kk+=1
						ee+=deltaE
					while(ee<=(bindingenergy+Energywindow/2000))
					
					tmpwave[ii][jj]=inter_sum

				endif
			jj+=1
			while(jj<kypntnum)
		ii+=1
	while(ii<kxpntnum)
	endif

	
	string Ebinfor
	sprintf Ebinfor,"Eb=%.1fmeV",bindingenergy*1000
	
	duplicate/O tmpwave imagetoshow
	
	
	//string ctrlName=""
	//if(adjustoffset==0)
	
	if(holdintensityimage==0)
	dowindow/K IntensityVSK
	//print "here"
	display/K=1;appendimage imagetoshow
	
	XJZSecondBZ(ctrlName)
	SetAxis bottom kxstart,kxend
	SetAxis left kystart,kyend
	ModifyGraph width={Aspect,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	ModifyGraph width=396.85,height=396.85
	choosecolortable(ctrlName,0,choosecolortablename)
	//ModifyImage imagetoshow ctab= {*,*,$choosecolortablename,1}
	Label left "\\f01\\F'Times'\\Z18Ky//(\\F'symbol'p/\\F'Times'a)"
	Label bottom "\\f01\\F'Times'\\Z18Kx//(\\F'symbol'p/\\F'Times'a)"
	dowindow/C IntensityVSK
	TextBox/W=IntensityVSK/C/N=Ebinfor/A=LT/X=3.43/Y=6.00/F=0/A=MC "\\f01\\Z15"+Ebinfor
	

	setwindow IntensityVSK hook(myhook)=changeEB_mouse	////Change FS using mouse wheel by JXW 2011-07-18
	endif
	
	if(holdintensityimage==1)
	dowindow/K IntensityVSK
	display/K=1;appendimage tmpwave
	//string ctrlName=""
	
	XJZSecondBZ(ctrlName)
	SetAxis bottom kxstart,kxend
	SetAxis left kystart,kyend
	ModifyGraph width={Aspect,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	ModifyGraph width=396.85,height=396.85
	choosecolortable(ctrlName,0,choosecolortablename)
	//ModifyImage $intensityvsk_name ctab= {*,*,$choosecolortablename,1}
	Label left "\\f01\\F'Times'\\Z18Ky//(\\F'symbol'p/\\F'Times'a)"
	Label bottom "\\f01\\F'Times'\\Z18Kx//(\\F'symbol'p/\\F'Times'a)"
	//dowindow/C IntensityVSK
	TextBox/C/N=Ebinfor/A=LT/X=3.43/Y=6.00/F=0/A=MC "\\f01\\Z15"+Ebinfor
	endif
	
	//endif
	//print (ticks-now)/60

End

////Change FS using mouse wheel
function changeEB_mouse(s)

STRUCT WMWinHookStruct &s

dowindow VisualizeARToFData
if(V_flag)
string ctrlName=""
string curr=getdatafolder(1)
setdatafolder root:ARToFData
svar choosecolortablename=root:ARToFData:choosecolortablename

	controlinfo/W=VisualizeARToFData artofdata
	if(!cmpstr("fittednamelist",S_Value))
	return 0
	endif
	wave/T tmp=root:ARToFData:$S_Value
	//print tmp[V_Value]
	//print wavedims($tmp[V_Value])
	
	string prestr
	prestr=tmp[V_Value]
	//print prestr
	variable deltaE,Emin,Elength,Emax
	
	if(!waveexists($tmp[V_Value]))
	return 0
	endif
	
	deltaE=dimdelta($tmp[V_Value],2)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*deltaE
	
	nvar bindingenergy=root:ARToFData:bindingenergy
	bindingenergy+=deltaE*s.wheelDy
	if(bindingenergy<=Emax&&bindingenergy>=Emin)
	switch(s.eventcode)
		case 22:
		usingarrow(bindingenergy)
		choosecolortable(ctrlName,0,choosecolortablename)
		break
	endswitch
	endif
setdatafolder curr
endif
end
////Change FS using mouse wheel

Function showintensityvsk_adjustoffset()
	String ctrlName=""
	//variable en
	dispersionandfit(ctrlName,0)
	TabControl Dispersion,win=VisualizeARToFData,value=0
	setdatafolder root:ARToFData
	
	nvar adjustoffset=root:ARToFData:adjustoffset
	
	nvar artof_flag
	///产生KxKy区域
	if(artof_flag)
	CalARToFMappingArea()
	else
	calcuts2D_area()
	endif
	///产生KxKy区域
	
	///产生KxKy区域
	//calcuts2D_area()
	///产生KxKy区域
	//nvar artof_flag
//if(artof_flag==0)
//getintensity2D()
//endif
	nvar savewaveornot=root:ARToFData:savewaveornot
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	
	nvar kxstart=root:ARToFData:kxstart
	nvar kxend=root:ARToFData:kxend
	nvar kystart=root:ARToFData:kystart
	nvar kyend=root:ARToFData:kyend
	nvar kxpntnum=root:ARToFData:kxpntnum
	nvar kypntnum=root:ARToFData:kypntnum
	nvar bindingenergy=root:ARToFData:bindingenergy
	nvar Energywindow=root:ARToFData:Energywindow
	nvar rotationangle=root:ARToFData:RotationAngle
	svar choosecolortablename=root:ARToFData:choosecolortablename
	
	////adding Lienear offset 
	nvar lomegaoffset1=root:ARToFData:lomegaoffset1
	nvar lomegaoffset2=root:ARToFData:lomegaoffset2
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2
	
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	variable lthetainter=(lthetaoffset1*orithetaend-lthetaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lthetacof=(lthetaoffset2-lthetaoffset1)/(orithetaend-orithetastart)
	
	variable lphiinter=(lphioffset1*orithetaend-lphioffset2*orithetastart)/(orithetaend-orithetastart)
	variable lphicof=(lphioffset2-lphioffset1)/(orithetaend-orithetastart)
	
	variable lomegainter=(lomegaoffset1*orithetaend-lomegaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lomegacof=(lomegaoffset2-lomegaoffset1)/(orithetaend-orithetastart)
	////adding Lienear offset 	
	
	if(artof_flag==0)
	wave tmp_area=root:ARToFData:cuts2d_area
	endif
	
	if(artof_flag==1)
	wave tmp_area=root:ARToFData:artof_area
	endif
	
	nvar savewaveornot=root:ARToFData:savewaveornot
	nvar holdintensityimage=root:ARToFData:holdintensityimage
	string intensityvsk_name
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	string prestr
	prestr=tmp[V_Value]

	if(savewaveornot==1)
		
		sprintf intensityvsk_name,"%.0f",abs(bindingenergy)*1000
		if(bindingenergy<0)
			intensityvsk_name=prestr[0,1]+"IntensityVSK_N"+intensityvsk_name+"meV"
		endif
		
		if(bindingenergy>=0)
			intensityvsk_name=prestr[0,1]+"IntensityVSK_P"+intensityvsk_name+"meV"
		endif
	endif
	
	if(savewaveornot==0)
		intensityvsk_name="IntensityVSMomentum"
	endif
	
	make/O/N=(kxpntnum,kypntnum) $intensityvsk_name=0
	setscale/I x,kxstart,kxend,$intensityvsk_name
	setscale/I y,kystart,kyend,$intensityvsk_name
	
	wave tmpwave=$intensityvsk_name
	variable ii=0,jj=0,kk=0,deltaE,Emin,Elength,Emax,xmin,xinc,ymin,yinc,xx,yy,ee
	
	xmin=kxstart
	xinc=(kxend-kxstart)/(kxpntnum-1)
	ymin=kystart
	yinc=(kyend-kystart)/(kypntnum-1)
	
	
	deltaE=dimdelta($tmp[V_Value],2)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*deltaE
	slider energypostion,win=VisualizeARToFData,limits={Emin,Emax,deltaE}
	slider energypostion,win=VisualizeARToFData,value=bindingenergy
	SetVariable autoEstart,win=VisualizeARToFData,limits={Emin,Emax,deltaE}
	SetVariable autoEend,win=VisualizeARToFData,limits={Emin,Emax,deltaE}

	wave/Z omega_angle=root:OriginalData:Omega_Angle
	wave/Z processflag=root:OriginalData:ProcessFlag
	wave/Z phi_angle=root:OriginalData:Phi_Angle


	nvar/Z processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar/Z thetaoffset=root:PROCESS:ThetaOffset
	nvar/Z phioffset=root:PROCESS:PhiOffset
	//nvar/Z omegaoffset=root:PROCESS:OmegaOffset
	
	nvar/Z omegaoffset=root:ARToFData:offsetomega
	
	variable omega,phiangle,datapntnum
	
	if(artof_flag==0)
	datapntnum=dimsize(processflag,0)
	ii=0
	do
		if(processedimageflag==processflag[ii])
		omega=omega_angle[ii]
		phiangle=phi_angle[ii]
		break
		endif
		ii+=1
	while(ii<datapntnum)
	omega=omega-omegaoffset
	endif
	
	if(artof_flag==1)
	omega=rotationangle-omegaoffset
	endif
	
	//print omega
	variable inter_sum,Estart=bindingenergy-Energywindow/2000
	variable kx,ky,theta,phi
	
		
	xinc=(kxend-kxstart)/(kxpntnum-1)
	yinc=(kyend-kystart)/(kypntnum-1)	
	
	variable value1
	//print tmp[V_Value]
	///----fix phi>90 bug
	variable vv
	nvar v1=root:ARToFData:oriphiend
	nvar v2=root:ARToFData:oriphistart
	vv=min(abs(v1),abs(v2))>90
	K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+bindingenergy)
	///----fix phi>90 bug
	
	ii=0
	
	do
		xx=xmin+ii*xinc
		jj=0
			do	
				yy=ymin+jj*yinc
				if(interp2D(tmp_area,xx,yy)>0.5)
				
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
				/////需要修改调整
				if(artof_flag==0)
				phi=-asin(kx/K0)
				endif
				if(artof_flag==1)
				phi=asin(kx/K0)
				endif
				/////需要修改调整
						
				theta=asin(ky/K0/cos(phi))
	
				theta=theta*180/pi
			
				phi=phi*180/pi
				
				///---fix phi>90 bug
				if(vv)
				phi=-(180+phi)
				endif
				if(!artof_flag)
				theta=(theta+lthetainter+lthetacof*thetaoffset)/(1-lthetacof)//+thetaoffset
				phi=phi+lphiinter+lphicof*(theta+thetaoffset)
				endif
				
					//print "here"///dubug
					inter_sum=0;ee=Estart
					do
								
						value1=interp3D($tmp[V_Value],phi,theta,ee)
						if(savewaveornot==1) ////消除白边	
							inter_sum+=(numtype(value1)==2)?0 : value1
						else 
							inter_sum+=value1
						endif
						ee+=deltaE
					while(ee<=(bindingenergy+Energywindow/2000))
					tmpwave[ii][jj]=inter_sum
					//if(tmpwave[ii][jj]==NaN)
					//	tmpwave[ii][jj]=0
					//endif
				endif
			jj+=1
			while(jj<kypntnum)
		ii+=1
	while(ii<kxpntnum)
	
	string Ebinfor
	sprintf Ebinfor,"Eb=%.1fmeV",bindingenergy*1000
	
	duplicate/O tmpwave imagetoshow
	
	
End

function getzvalue(xx,yy,ee,datawave)//return the interplated value of 3D CCD data
	variable xx,yy,ee
	wave datawave
	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	nvar RAngle=root:ARToFData:RotationAngle
	nvar Theta0=root:ARToFData:ThetaAngle
	nvar Phi0=root:ARToFData:PhiAngle
	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	
	variable RK0=K0*sin(3.1416/180*(DetectorAngle0/2))
	variable k_o=K0*cos(3.1416/180*(DetectorAngle0/2))
	
	variable kx=K_o*sin(3.1416/180*Phi0)
	variable ky=K_o*sin(3.1416/180*Theta0)*cos(3.1416/180*Phi0)
	variable kz=K_o*cos(3.1416/180*Theta0)*cos(3.1416/180*Phi0)
	
	variable Rkx=sqrt(kx*kx+ky*ky)*cos((atan2(ky,kx))+RAngle*pi/180)
	variable Rky=sqrt(kx*kx+ky*ky)*sin((atan2(ky,kx))+RAngle*pi/180)
	variable Rkz=kz
	
	variable zz,projected_r,rel_omega,xx1,yy1,xxr,yyr
	
		if(Rkz!=0)
			zz=Rkz-(Rkx*xx+Rky*yy-Rkx*Rkx-Rky*Rky)/Rkz
			projected_r=sqrt((zz-Rkz)^2+(yy-Rky)^2+(xx-Rkx)^2)
			rel_omega=atan(yy/xx)
			
			//if(projected_r>RK0) ///for dubug
			//print "projected>RK0 erros"///for dubut
			//endif///for debug
			
			if((xx>=0)&&(yy>=0))
			rel_omega=rel_omega
			endif
			
			if((xx>=0)&&(yy<0))
			rel_omega=rel_omega+2*pi
			endif
			
			if((xx<0)&&(yy>=0))
			rel_omega=rel_omega+pi
			endif
			
			if((xx<0)&&(yy<0))
			rel_omega=rel_omega+pi
			endif
			
			xx1=projected_r*cos(rel_omega-RAngle*pi/180)
			yy1=projected_r*sin(rel_omega-RAngle*pi/180)
			
			xxr=atan(xx1/k_o)*180/pi
			yyr=atan(yy1/k_o)*180/pi
		endif
		
		if(Rkz==0)
		//This case is not neccessary really
		endif
		
		return interp3D(datawave,xxr,yyr,ee)
	
end



Function getintensityvsK_arbE(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	
	controlinfo/W=VisualizeARToFData Dispersion
	if(V_Value)
	dispersionandfit(ctrlName,0)
	TabControl Dispersion,win=VisualizeARToFData,value=0
	endif
	
	setdatafolder root:ARToFData
	nvar artof_flag=root:ARToFData:artof_flag
	nvar bindingenergy//=root:ARToF:bindingenergy
	nvar savewaveornot=root:ARToFData:savewaveornot
	svar choosecolortablename=root:ARToFData:choosecolortablename
	nvar inverseornot=root:ARToFData:inverseornot
	dowindow/F IntensityVSK
	if(V_Flag==1)
	//if(event %& 0x1)	// bit 0, value set
	
	bindingenergy=sliderValue
	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	
	nvar kxstart=root:ARToFData:kxstart
	nvar kxend=root:ARToFData:kxend
	nvar kystart=root:ARToFData:kystart
	nvar kyend=root:ARToFData:kyend
	nvar kxpntnum=root:ARToFData:kxpntnum
	nvar kypntnum=root:ARToFData:kypntnum
	nvar bindingenergy=root:ARToFData:bindingenergy
	nvar Energywindow=root:ARToFData:Energywindow
	nvar holdintensityimage=root:ARToFData:holdintensityimage
	nvar rotationangle=root:ARTofData:rotationangle
	
	////adding Lienear offset 
	nvar lomegaoffset1=root:ARToFData:lomegaoffset1
	nvar lomegaoffset2=root:ARToFData:lomegaoffset2
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2
	
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	variable lthetainter=(lthetaoffset1*orithetaend-lthetaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lthetacof=(lthetaoffset2-lthetaoffset1)/(orithetaend-orithetastart)
	
	variable lphiinter=(lphioffset1*orithetaend-lphioffset2*orithetastart)/(orithetaend-orithetastart)
	variable lphicof=(lphioffset2-lphioffset1)/(orithetaend-orithetastart)
	
	variable lomegainter=(lomegaoffset1*orithetaend-lomegaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lomegacof=(lomegaoffset2-lomegaoffset1)/(orithetaend-orithetastart)
	////adding Lienear offset 	
	
	if(artof_flag==0)
	wave tmp_area=root:ARToFData:cuts2d_area
	endif
	
	if(artof_flag==1)
	wave tmp_area=root:ARToFData:artof_area
	endif
	
	wave imagetoshow=root:ARToFData:imagetoshow
	
	
	
	
	variable ii=0,jj=0,kk=0,deltaE,Emin,Elength,Emax,xmin,xinc,ymin,yinc,xx,yy,ee
	
	xmin=kxstart
	xinc=(kxend-kxstart)/(kxpntnum-1)
	ymin=kystart
	yinc=(kyend-kystart)/(kypntnum-1)
	
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	
	deltaE=dimdelta($tmp[V_Value],2)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*deltaE
	slider energypostion,win=VisualizeARToFData,limits={Emin,Emax,deltaE}
	
	//wave theta_angle=root:OriginalData:Theta_Angle
	//wave phi_angle=root:OriginalData:Phi_Angle
	wave/Z omega_angle=root:OriginalData:Omega_Angle
	wave/Z processflag=root:OriginalData:ProcessFlag

	//nvar DetectorAngle0=root:ARToFData:DetectorAngle
	//nvar artofflag=root:MomentumMap:ARToFFlag
	//nvar BZShowmode=root:ARToFData:BZShowMode
	//nvar fromline2artof=root:MomentumMap:fromline2artof

	nvar processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar thetaoffset=root:PROCESS:ThetaOffset
	nvar phioffset=root:PROCESS:PhiOffset
	//nvar omegaoffset=root:PROCESS:OmegaOffset
	nvar omegaoffset=root:ARToFData:offsetomega
	
	variable omega,datapntnum
	
	if(artof_flag==0)
	datapntnum=dimsize(processflag,0)
	ii=0
	do
		if(processedimageflag==processflag[ii])
		omega=omega_angle[ii]
		break
		endif
		ii+=1
	while(ii<datapntnum)
	omega=omega-omegaoffset
	endif
	
	if(artof_flag==1)
	omega=rotationangle-omegaoffset
	endif
	//print omega
	variable inter_sum,Estart=bindingenergy-Energywindow/2000
	variable kx,ky,theta,phi
	
		
	xinc=(kxend-kxstart)/(kxpntnum-1)
	yinc=(kyend-kystart)/(kypntnum-1)	
	variable value1
	
	///----fix phi>90 bug
	variable vv,K00
	nvar v1=root:ARToFData:oriphiend
	nvar v2=root:ARToFData:oriphistart
	vv=min(abs(v1),abs(v2))>90
	//K00=0.5118*LC/3.1416
	K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+bindingenergy)
	///----fix phi>90 bug
	//print tmp[V_Value]
	ii=0
	if(artof_flag==0)
	do
		xx=xmin+ii*xinc	
			jj=0
			do	
				yy=ymin+jj*yinc
				if(interp2D(tmp_area,xx,yy))
				
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
				
				phi=-asin(kx/K0)
				theta=asin(ky/K0/cos(phi))*180/pi
						
				phi=phi*180/pi
		
				///----fix phi>90 bug
				if(vv)
				phi=-(180+phi)
				endif
				///----fix phi>90 bug				
				
				
				theta=(theta+lthetainter+lthetacof*thetaoffset)/(1-lthetacof)//+thetaoffset
				phi=phi+lphiinter+lphicof*(theta+thetaoffset)
					inter_sum=0;ee=Estart//kk=0;
					do

						///考虑Eb对动量的修正
						//ee=Estart+kk*deltaE
						//K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
						//K0=K00*Sqrt(PhotonE-WorkFunc+ee)
						
						
						value1=interp3D($tmp[V_Value],phi,theta,ee)
						if(savewaveornot) ////消除白边	
							inter_sum+=(numtype(value1))?0:value1
						else 
							inter_sum+=value1
						endif
						//kk+=1
						ee+=deltaE
					while(ee<=(bindingenergy+Energywindow/2000))
					imagetoshow[ii][jj]=inter_sum

				endif
			jj+=1
			while(jj<kypntnum)
		ii+=1
	while(ii<kxpntnum)
	endif
	
	ii=0
	
	if(artof_flag==1)
	do
		xx=xmin+ii*xinc	
			jj=0
			do	
				yy=ymin+jj*yinc
				if(interp2D(tmp_area,xx,yy))
				
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
				
				phi=asin(kx/K0)						
				theta=asin(ky/K0/cos(phi))*180/pi
				phi=phi*180/pi
						
				///----fix phi>90 bug
				if(vv)
				phi=-(180+phi)
				endif
				///----fix phi>90 bug
				//theta=(theta+lthetainter)/(1-lthetacof)+thetaoffset
				//phi=phi+lphiinter+lphicof*theta
				
					inter_sum=0;ee=Estart;//kk=0
					do
					
						///考虑Eb对动量的修正
						//ee=Estart+kk*deltaE
						//K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
						//K0=K00*Sqrt(PhotonE-WorkFunc+ee)
						
						
						value1=interp3D($tmp[V_Value],phi,theta,ee)
						if(savewaveornot) ////消除白边	
							inter_sum+=(numtype(value1))?0 : value1
						else 
							inter_sum+=value1
						endif
						//kk+=1
						ee+=deltaE
					while(ee<=(bindingenergy+Energywindow/2000))
					
					imagetoshow[ii][jj]=inter_sum

				endif
			jj+=1
			while(jj<kypntnum)
		ii+=1
	while(ii<kxpntnum)
	endif

string Ebinfor
sprintf Ebinfor,"Eb=%.1fmeV",bindingenergy*1000

if(holdintensityimage==0)
TextBox/W=IntensityVSK/C/N=Ebinfor/A=LT/X=3.43/Y=6.00/F=0/A=MC "\\f01\\Z15"+Ebinfor
endif

if(holdintensityimage==1)
TextBox/C/N=Ebinfor/A=LT/X=3.43/Y=6.00/F=0/A=MC "\\f01\\Z15"+Ebinfor
endif
	
choosecolortable(ctrlName,0,choosecolortablename)
	
	
	return 0
	//endif
	endif

	
//if(artof_flag==0)

//getintensity2d_arbE(sliderValue)

//endif
//ModifyImage/W=IntensityVSK imagetoshow ctab= {*,*,choosecolortablename,inverseornot}
//choosecolortable(ctrlName,0,choosecolortablename)

End

function usingarrow(slidervalue)

variable slidervalue
setdatafolder root:ARToFData
	nvar artof_flag=root:ARToFData:artof_flag
	nvar bindingenergy//=root:ARToF:bindingenergy
	nvar savewaveornot=root:ARToFData:savewaveornot
	dowindow IntensityVSK
	if(V_Flag==1)
	//if(event %& 0x1)	// bit 0, value set
	
	bindingenergy=sliderValue
	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	
	nvar kxstart=root:ARToFData:kxstart
	nvar kxend=root:ARToFData:kxend
	nvar kystart=root:ARToFData:kystart
	nvar kyend=root:ARToFData:kyend
	nvar kxpntnum=root:ARToFData:kxpntnum
	nvar kypntnum=root:ARToFData:kypntnum
	nvar bindingenergy=root:ARToFData:bindingenergy
	nvar Energywindow=root:ARToFData:Energywindow
	nvar holdintensityimage=root:ARToFData:holdintensityimage
	nvar rotationangle=root:ARTofData:rotationangle
	
	////adding Lienear offset 
	nvar lomegaoffset1=root:ARToFData:lomegaoffset1
	nvar lomegaoffset2=root:ARToFData:lomegaoffset2
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2
	
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	variable lthetainter=(lthetaoffset1*orithetaend-lthetaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lthetacof=(lthetaoffset2-lthetaoffset1)/(orithetaend-orithetastart)
	
	variable lphiinter=(lphioffset1*orithetaend-lphioffset2*orithetastart)/(orithetaend-orithetastart)
	variable lphicof=(lphioffset2-lphioffset1)/(orithetaend-orithetastart)
	
	variable lomegainter=(lomegaoffset1*orithetaend-lomegaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lomegacof=(lomegaoffset2-lomegaoffset1)/(orithetaend-orithetastart)
	///adding Lienear offset
	
	if(artof_flag==0)
	wave tmp_area=root:ARToFData:cuts2d_area
	endif
	
	if(artof_flag==1)
	wave tmp_area=root:ARToFData:artof_area
	endif
	
	wave imagetoshow=root:ARToFData:imagetoshow
	
	
	
	
	variable ii=0,jj=0,kk=0,deltaE,Emin,Elength,Emax,xmin,xinc,ymin,yinc,xx,yy,ee
	
	xmin=kxstart
	xinc=(kxend-kxstart)/(kxpntnum-1)
	ymin=kystart
	yinc=(kyend-kystart)/(kypntnum-1)
	
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	
	deltaE=dimdelta($tmp[V_Value],2)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*deltaE
	slider energypostion,win=VisualizeARToFData,limits={Emin,Emax,deltaE}
	
	//wave theta_angle=root:OriginalData:Theta_Angle
	//wave phi_angle=root:OriginalData:Phi_Angle
	wave/Z omega_angle=root:OriginalData:Omega_Angle
	wave/Z processflag=root:OriginalData:ProcessFlag

	//nvar DetectorAngle0=root:ARToFData:DetectorAngle
	//nvar artofflag=root:MomentumMap:ARToFFlag
	//nvar BZShowmode=root:ARToFData:BZShowMode
	//nvar fromline2artof=root:MomentumMap:fromline2artof

	nvar processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar thetaoffset=root:PROCESS:ThetaOffset
	nvar phioffset=root:PROCESS:PhiOffset
	//nvar omegaoffset=root:PROCESS:OmegaOffset
	nvar omegaoffset=root:ARToFData:offsetomega
	
	variable omega,datapntnum
	
	if(artof_flag==0)
	datapntnum=dimsize(processflag,0)
	ii=0
	do
		if(processedimageflag==processflag[ii])
		omega=omega_angle[ii]
		break
		endif
		ii+=1
	while(ii<datapntnum)
	omega=omega-omegaoffset
	endif
	
	if(artof_flag==1)
	omega=rotationangle-omegaoffset
	endif
	//print omega
	variable inter_sum,Estart=bindingenergy-Energywindow/2000
	variable kx,ky,theta,phi
	
		
	xinc=(kxend-kxstart)/(kxpntnum-1)
	yinc=(kyend-kystart)/(kypntnum-1)	
	variable value1
	
	///----fix phi>90 bug
	variable vv,K00
	nvar v1=root:ARToFData:oriphiend
	nvar v2=root:ARToFData:oriphistart
	vv=min(abs(v1),abs(v2))>90
	//K00=0.5118*LC/3.1416
	K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+bindingenergy)
	///----fix phi>90 bug
	//print tmp[V_Value]
	ii=0
	if(artof_flag==0)
	do
		xx=xmin+ii*xinc	
			jj=0
			do	
				yy=ymin+jj*yinc
				if(interp2D(tmp_area,xx,yy))
				
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
				
				phi=-asin(kx/K0)
				theta=asin(ky/K0/cos(phi))*180/pi
						
				phi=phi*180/pi
		
				///----fix phi>90 bug
				if(vv)
				phi=-(180+phi)
				endif
				///----fix phi>90 bug
				theta=(theta+lthetainter+lthetacof*thetaoffset)/(1-lthetacof)//+thetaoffset
				phi=phi+lphiinter+lphicof*(theta+thetaoffset)		
				
					inter_sum=0;ee=Estart//kk=0;
					do

						///考虑Eb对动量的修正
						//ee=Estart+kk*deltaE
						//K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
						//K0=K00*Sqrt(PhotonE-WorkFunc+ee)
						
						
						value1=interp3D($tmp[V_Value],phi,theta,ee)
						if(savewaveornot) ////消除白边	
							inter_sum+=(numtype(value1))?0:value1
						else 
							inter_sum+=value1
						endif
						//kk+=1
						ee+=deltaE
					while(ee<=(bindingenergy+Energywindow/2000))
					imagetoshow[ii][jj]=inter_sum

				endif
			jj+=1
			while(jj<kypntnum)
		ii+=1
	while(ii<kxpntnum)
	endif
	
	ii=0
	
	if(artof_flag==1)
	do
		xx=xmin+ii*xinc	
			jj=0
			do	
				yy=ymin+jj*yinc
				
				if(interp2D(tmp_area,xx,yy))
				
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
				
				phi=asin(kx/K0)						
				theta=asin(ky/K0/cos(phi))*180/pi
				phi=phi*180/pi
						
				///----fix phi>90 bug
				if(vv)
				phi=-(180+phi)
				endif
				///----fix phi>90 bug
				
				//theta=(theta+lthetainter)/(1-lthetacof)+thetaoffset
				//phi=phi+lphiinter+lphicof*theta	
					inter_sum=0;ee=Estart;//kk=0
					do
					
						///考虑Eb对动量的修正
						//ee=Estart+kk*deltaE
						//K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
						//K0=K00*Sqrt(PhotonE-WorkFunc+ee)
						
						
						value1=interp3D($tmp[V_Value],phi,theta,ee)
						if(savewaveornot) ////消除白边	
							inter_sum+=(numtype(value1))?0 : value1
						else 
							inter_sum+=value1
						endif
						//kk+=1
						ee+=deltaE
					while(ee<=(bindingenergy+Energywindow/2000))
					
					imagetoshow[ii][jj]=inter_sum

				endif
			jj+=1
			while(jj<kypntnum)
		ii+=1
	while(ii<kxpntnum)
	endif

string Ebinfor
sprintf Ebinfor,"Eb=%.1fmeV",bindingenergy*1000

if(holdintensityimage==0)
TextBox/W=IntensityVSK/C/N=Ebinfor/A=LT/X=3.43/Y=6.00/F=0/A=MC "\\f01\\Z15"+Ebinfor
endif

if(holdintensityimage==1)
TextBox/C/N=Ebinfor/A=LT/X=3.43/Y=6.00/F=0/A=MC "\\f01\\Z15"+Ebinfor
endif
	
	endif
end

Function intensityvskmovie(ctrlName) : ButtonControl
	String ctrlName

	controlinfo/W=VisualizeARToFData Dispersion
	if(V_Value)
	dispersionandfit(ctrlName,0)
	TabControl Dispersion,win=VisualizeARToFData,value=0
	endif
dowindow/F IntensityVSK

if(!V_Flag)
abort "No FS image for movie present. Use GetFS to creat a FS."
endif

setdatafolder root:ARToFData
if(V_Flag==1)

try	
	nvar bindingenergy=root:ARToFData:bindingenergy
	nvar deltaenergy=root:ARToFData:deltaenergy
	nvar costomizeenergy=root:ARToFData:costomizeenergy
	nvar costomizeenergystart=root:ARToFData:costomizeenergystart
	nvar costomizeenergyend=root:ARToFData:costomizeenergyend
	nvar framespersecond=root:ARToFData:framespersecond
	svar choosecolortablename=root:ARToFData:choosecolortablename
	
	variable Emin,Einc,Elength,ii=0,Emax,Edelta
	Edelta=deltaenergy
	
	if(costomizeenergy==0)
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	Einc=dimdelta($tmp[V_Value],2)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*Einc
	endif
	
	if(costomizeenergy==1)
	Emin=costomizeenergystart
	Emax=costomizeenergyend
	endif
	
	//if(framespersecond<5)
	//framespersecond=5
	//endif
	newmovie/Z/A/F=(framespersecond) as "IntensityVSMomentum"
	//print V_flag
	if(V_flag==-1)
	return 0
	//closemovie
	//abort
	endif
	
	bindingenergy=Emin
	if(Emin<=Emax)
		Edelta=deltaenergy
		ii=0
	
		do
		
		slider energypostion,win=VisualizeARToFData,value=bindingenergy
		usingarrow(bindingenergy)
		choosecolortable(ctrlName,0,choosecolortablename)
		doupdate
		AddMovieFrame
		ii+=1
		bindingenergy=Emin+ii*Edelta/1000
		while(bindingenergy<=Emax)
	endif
	
	if(Emin>=Emax)
		Edelta=-deltaenergy
		ii=0
	
		do
		
		slider energypostion,win=VisualizeARToFData,value=bindingenergy
		usingarrow(bindingenergy)
		choosecolortable(ctrlName,0,choosecolortablename)
		doupdate
		AddMovieFrame
		ii+=1
		bindingenergy=Emin+ii*Edelta/1000
	
		while(bindingenergy>=Emax)
	endif
		
	closemovie	

catch
closemovie
endtry
	
endif


End

Function playintensityvskmovie(ctrlName) : ButtonControl
	String ctrlName
		playmovie/Z
	
			if(V_flag==-1)
			abort
			endif
			

	
	
End

Function choosecolortable(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	//wavename
	//print popStr
	string curr=getdatafolder(1)
	nvar inverseornot=root:ARToFData:inverseornot
	nvar lowcolorz=root:ARToFData:lowcolorz
	nvar highcolorz=root:ARToFData:highcolorz
	svar choosecolortablename=root:ARToFData:choosecolortablename
	choosecolortablename=popStr
	
	string imagenameslist
	imagenameslist=imagenamelist("",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("",imagenameslist)////////
	
	
	
	
	//--//tmpstr=stringfromlist(0,imagenameslist)
	
	//--//if(!waveexists($tmpstr))
				
	//--//	return NaN
	//--//	   endif
	//print tmpstr
	//--//wave tmp=$tmpstr
	variable intensitymin,intensitymax//,ii,jj,xlength,ylength
	//xlength=dimsize(tmp,0)
	//ylength=dimsize(tmp,1)
	//ii=0
	//jj=0
	//do
	//	do
	//	intensitymin=tmp[ii][jj]
	//	intensitymax=tmp[ii][jj]
	//	if(cmpstr("NaN",num2str(intensitymin))&&cmpstr("NaN",num2str(intensitymax)))
	//	break
	//	endif
	//	ii+=1
	//	while(1)
		
	//	if(cmpstr("NaN",num2str(intensitymin))&&cmpstr("NaN",num2str(intensitymax)))
	//	break
	//	endif
	//	jj+=1
	//while(1)
	
	//ii=0
	//jj=0
	//do
	//	jj=0
	//	do
			//if(cmpstr("NaN",num2str(tmp[ii][jj])))
	//		if(tmp[ii][jj]>=intensitymax)
	//		intensitymax=tmp[ii][jj]
	//		endif
			
	//		if(tmp[ii][jj]<=intensitymin)
	//		intensitymin=tmp[ii][jj]
	//		endif
			//endif
	//	jj+=1
	//	while(jj<ylength)
	//ii+=1
	//while(ii<xlength)
	//print tmpstr
	//print intensitymin,intensitymax,xlength,ylength
	intensitymin=wavemin(tmp)
	intensitymax=wavemax(tmp)
	
	variable lowzero,highzero
	
	
	
	//print lowcolorz,highcolorz
	variable inc
	inc=2*(highcolorz-lowcolorz)/400
	Slider  lowzcolorz,win=VisualizeARToFData,limits={5*lowcolorz-highcolorz,2*highcolorz-lowcolorz,inc}
	
	inc=(5*highcolorz-lowcolorz)/400
	Slider  highcolorz,win=VisualizeARToFData,limits={lowcolorz,highcolorz*5,inc}
	Slider lowzcolorz,win=VisualizeARToFData,value=intensitymin
	if(lowzero==1)
	Slider lowzcolorz,win=VisualizeARToFData,value=0
	endif
	Slider highcolorz,win=VisualizeARToFData,value=intensitymax
	if(highzero==1)
	Slider highcolorz,win=VisualizeARToFData,value=0
	endif
	//ModifyImage $tmpstr ctab= {*,*,$popStr,inverseornot}
	
	controlinfo/W=VisualizeARToFData colorscalelowzero
	lowzero=V_Value
	controlinfo/W=VisualizeARToFData colorscalehighzero
	highzero=V_Value
	
	lowcolorz=intensitymin
	if(lowzero==1)
	lowcolorz=0
	endif
	
	highcolorz=intensitymax
	if(highzero==1)
	highcolorz=0
	endif
	ModifyImage $imagenameslist ctab= {lowcolorz,highcolorz,$popStr,inverseornot}
	setdatafolder curr

End

Function setlowcolorz(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	
	nvar lowcolorz=root:ARToFData:lowcolorz
	nvar highcolorz=root:ARToFData:highcolorz
	nvar inverseornot=root:ARToFData:inverseornot
	svar choosecolortablename=root:ARToFData:choosecolortablename
	
	string imagenameslist
	imagenameslist=imagenamelist("",";")
	string tmpstr
	tmpstr=stringfromlist(0,imagenameslist)
	//wave tmp=root:ARToFData:$tmpstr
	

	
	ModifyImage $tmpstr ctab= {slidervalue,highcolorz,$choosecolortablename,inverseornot}
	lowcolorz=slidervalue
	//ModifyImage $tmpstr ctab= {slidervalue,*,PlanetEarth256,1}
	if(event %& 0x1)	// bit 0, value set

	endif

	return 0
End

Function sethighcolorz(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	
	nvar lowcolorz=root:ARToFData:lowcolorz
	nvar highcolorz=root:ARToFData:highcolorz
	nvar inverseornot=root:ARToFData:inverseornot
	svar choosecolortablename=root:ARToFData:choosecolortablename
	
	string imagenameslist
	imagenameslist=imagenamelist("",";")
	string tmpstr
	tmpstr=stringfromlist(0,imagenameslist)
	
	//print inverseornot	
	ModifyImage $tmpstr ctab= {lowcolorz,slidervalue,$choosecolortablename,inverseornot}
	highcolorz=slidervalue
	if(event %& 0x1)	// bit 0, value set

	endif

	return 0
End


////edited by JXW 20110317
function autoshow(ctrlname):ButtonControl
string ctrlname
	
	controlinfo/W=VisualizeARToFData Dispersion
	if(V_Value)
	dispersionandfit(ctrlName,0)
	TabControl Dispersion,win=VisualizeARToFData,value=0
	endif

variable periodInTicks=60
enablepauseandstop()
CtrlNamedBackground $backtaskname, proc=autoshowasmovie, period=periodInTicks, start

end

function stopshow(ctrlname):ButtonControl
string ctrlname
nvar pauseornot=root:ARToFData:pauseornot
CtrlNamedBackground $backtaskname, stop
disablepauseandstop()
pauseornot=0

end

function pauseshow(ctrlname):ButtonControl
string ctrlname
nvar pauseornot=root:ARToFData:pauseornot
//string backtaskname="aotushowmovie"
CtrlNamedBackground $backtaskname, stop
pauseornot=1
end

function enablepauseandstop()

Button Pouse,win=VisualizeARToFData,disable=0
Button Stop,win=VisualizeARToFData,disable=0

end
function disablepauseandstop()

Button Pouse,win=VisualizeARToFData,disable=2
Button Stop,win=VisualizeARToFData,disable=2
end

Function autoshowasmovie(s) 
	
	STRUCT WMBackgroundStruct &s
nvar pauseornot=root:ARToFData:pauseornot
svar choosecolortablename=root:ARToFData:choosecolortablename
///////////////////////////////
variable t1,tr

tr=startmstimer
String ctrlName=""
	//dowindow/F IntensityVSK
	dowindow IntensityVSK
	setdatafolder root:ARToFData
if(V_Flag==1)
	
	nvar bindingenergy=root:ARToFData:bindingenergy
	nvar deltaenergy=root:ARToFData:deltaenergy
	nvar costomizeenergy=root:ARToFData:costomizeenergy
	nvar costomizeenergystart=root:ARToFData:costomizeenergystart
	nvar costomizeenergyend=root:ARToFData:costomizeenergyend
	
	variable Emin,Einc,Elength,ii=0,Emax,Edelta
	Edelta=deltaenergy
	
	if(costomizeenergy==0)
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	Einc=dimdelta($tmp[V_Value],2)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*Einc
	endif
	
	if(costomizeenergy==1)
	Emin=costomizeenergystart
	Emax=costomizeenergyend
	endif
	
	if(pauseornot==0)
	bindingenergy=Emin-deltaenergy/1000
	pauseornot=1
	endif
	
	//newmovie as "IntensityVSMomentum"
	if(Emin<=Emax)
		Edelta=deltaenergy
		//ii=0----------
	
		//do-----------
		//bindingenergy=Emin+ii*Edelta/1000--------------
		bindingenergy+=Edelta/1000
		if(bindingenergy>Emax)
		bindingenergy-=Edelta/1000
		stopshow(ctrlname)
		endif
		slider energypostion,win=VisualizeARToFData,value=bindingenergy
		usingarrow(bindingenergy)
		choosecolortable(ctrlName,0,choosecolortablename)
		doupdate
		//AddMovieFrame
		//ii+=1-----------
		//while(bindingenergy<=Emax)-------------

	endif
	
	if(Emin>=Emax)
		Edelta=-deltaenergy
		//ii=0------------
	
		//do---------------
		//bindingenergy=Emin+ii*Edelta/1000--------------
		bindingenergy+=Edelta/1000
		
		if(bindingenergy<Emax)
		bindingenergy-=Edelta/1000
		stopshow(ctrlname)
		endif
		
		slider energypostion,win=VisualizeARToFData,value=bindingenergy
		usingarrow(bindingenergy)
		choosecolortable(ctrlName,0,choosecolortablename)
		doupdate
		//AddMovieFrame
		//ii+=1----------------------
		//while(bindingenergy>=Emax)------------

		
	endif

endif

	t1=stopmstimer(tr)
	t1=t1/1000000*60
	
	if(t1<50)
	t1=40
	endif
	s.nextRunTicks=s.curRunTicks+1.2*t1
	return 0
End


Function kxkystacks(ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:ARToFData
	nvar deltaenergy=root:ARToFData:deltaenergy
	nvar inverseornot=root:ARToFData:inverseornot
	nvar costomizeenergystart=root:ARToFData:costomizeenergystart
	nvar costomizeenergyend=root:ARToFData:costomizeenergyend
	nvar costomizeenergy=root:ARToFData:costomizeenergy
	svar choosecolortablename=root:ARToFData:choosecolortablename
	variable Einc,Emin,Elength,Emax,Energy,EnergyStart
	
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	
	if(!waveexists($tmp[V_Value]))
		return 0
	endif
	
	Einc=dimdelta($tmp[V_Value],2)
	//if(costomizeenergy==0)
	Emin=dimoffset($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	Emax=Emin+(Elength-1)*Einc
	//endif
	
	Energystart=Emin
	
	if(costomizeenergy==1)
	Emin=costomizeenergystart
	Emax=costomizeenergyend
	endif
	
	variable ii_start,ii_end
	//if(Emin<Emax)
		ii_start=round((Emin-Energystart)/Einc) 
		ii_end=round((Emax-Energystart)/Einc) 
	//endif
	
	
	
	string cmd,namestr
	variable delta_ii,ii=0,jj=0
	
	if(deltaenergy<=20)
		delta_ii=round(50/Einc/1000)
	else
		delta_ii=round(deltaenergy/Einc/1000)
	endif
	
	if(Emin>Emax)
		delta_ii=-delta_ii
	endif
	
	sprintf cmd,"newgizmo/i/K=1/N=KxKyStack"
	execute cmd

	ii=ii_start
	print Emin,Emax
	if(Emin<=Emax)
	do
		Energy=Emin+Einc*(ii-ii_start)
		if(Energy<=0)
		sprintf namestr,"KxKy_N%.0fmeV",-Energy*1000
		endif
		
		if(Energy>0)
		sprintf namestr,"KxKy_P%.0fmeV",Energy*1000
		endif
		
		sprintf cmd,"AppendToGizmo Surface=%s,name=%s",tmp[V_Value],namestr
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={ srcMode,32}",namestr
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={surfaceCTab,%s}",namestr,choosecolortablename
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={InversesurfaceCTab,%d}",namestr,inverseornot
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={surfaceCTABScaling,4}",namestr
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={ plane,%d}",namestr,ii
		Execute cmd
		
		sprintf cmd,"ModifyGizmo modifyObject=%s property={calcNormals,1}",namestr
		Execute cmd
	
		sprintf cmd,"ModifyGizmo setDisplayList=-1,object=%s",namestr
		Execute cmd
		
		if(ii==ii_start)
		sprintf cmd,"AppendToGizmo Axes=BoxAxes, name=Axes0"
		Execute cmd
		sprintf cmd,"ModifyGizmo ModifyObject=Axes0,property={visible,1}"
		Execute cmd
		endif
		
		ii+=delta_ii
	while(Energy<=Emax)
	endif	
	
	ii=ii_start
	if(Emin>Emax)
	do
		Energy=Emin+Einc*(ii-ii_start)
		if(Energy<=0)
		sprintf namestr,"KxKy_N%.0fmeV",-Energy*1000
		endif
		
		if(Energy>0)
		sprintf namestr,"KxKy_P%.0fmeV",Energy*1000
		endif
		
		sprintf cmd,"AppendToGizmo Surface=%s,name=%s",tmp[V_Value],namestr
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={ srcMode,32}",namestr
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={surfaceCTab,%s}",namestr,choosecolortablename
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={InversesurfaceCTab,%d}",namestr,inverseornot
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={surfaceCTABScaling,4}",namestr
		Execute cmd
		
		sprintf cmd,"ModifyGizmo ModifyObject=%s property={ plane,%d}",namestr,ii
		Execute cmd
		
		sprintf cmd,"ModifyGizmo modifyObject=%s property={calcNormals,1}",namestr
		Execute cmd
	
		sprintf cmd,"ModifyGizmo setDisplayList=-1,object=%s",namestr
		Execute cmd
		
		if(ii==ii_start)
		sprintf cmd,"AppendToGizmo Axes=BoxAxes, name=Axes0"
		Execute cmd
		sprintf cmd,"ModifyGizmo ModifyObject=Axes0,property={visible,1}"
		Execute cmd
		endif
		
		ii+=delta_ii
	while(Energy>=Emax)
	endif	
		
	
End

Function inversecolortable(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	svar choosecolortablename=root:ARToFData:choosecolortablename
	
	variable popnum
	choosecolortable(ctrlName,popNum,choosecolortablename)

End


Function disableEDCMDC(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar holdimageornot=root:ARToFData:holdimageornot
	if(holdimageornot==0)
	button getEDCstack,win=VisualizeARToFData,disable=0
	button getarbEDC,win=VisualizeARToFData,disable=0
	button getarbMDC,win=VisualizeARToFData,disable=0
	button getarbEDC2nd,win=VisualizeARToFData,disable=0
	button getarbMDC2nd,win=VisualizeARToFData,disable=0
	setvariable bindingnumEDC,win=VisualizeARToFData,disable=0
	setvariable bindingnumMDC,win=VisualizeARToFData,disable=0
	setvariable smoothnumEDC,win=VisualizeARToFData,disable=0
	setvariable smoothnumMDC,win=VisualizeARToFData,disable=0
	endif
	
	if(holdimageornot==1)
	button getEDCstack,win=VisualizeARToFData,disable=2
	button getarbEDC,win=VisualizeARToFData,disable=2
	button getarbMDC,win=VisualizeARToFData,disable=2
	button getarbEDC2nd,win=VisualizeARToFData,disable=2
	button getarbMDC2nd,win=VisualizeARToFData,disable=2
	setvariable bindingnumEDC,win=VisualizeARToFData,disable=2
	setvariable bindingnumMDC,win=VisualizeARToFData,disable=2
	setvariable smoothnumEDC,win=VisualizeARToFData,disable=2
	setvariable smoothnumMDC,win=VisualizeARToFData,disable=2
	endif

End



Function setcutkx_end(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	creatcut(ctrlName)
End



Function setcutky_end(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	creatcut(ctrlName)
End

Function getcusors(ctrlName) : ButtonControl ////To add point for creating k path
	String ctrlName
	nvar setcutkx_s=root:ARToFData:setcutkx_s
	nvar setcutky_s=root:ARToFData:setcutky_s
	svar kpathnodes=root:ARToFData:kpathnodes
	//nvar setcutkx_e=root:ARToFData:setcutkx_e
	//nvar setcutky_e=root:ARToFData:setcutky_e
	
	setcutkx_s=xcsr(A)
	setcutky_s=vcsr(A)
	variable kpntnum
	//setcutkx_e=xcsr(B)
	//setcutky_e=vcsr(B)
	wave tmpx=root:ARToFData:KPathpnt_x
	wave tmpy=root:ARToFData:KPathpnt_y
	
	if(!waveexists(tmpx))
	make/N=0 root:ARToFData:KPathpnt_x
	wave tmpx=root:ARToFData:KPathpnt_x
	endif
	
	if(!waveexists(tmpy))
	make/N=0 root:ARToFData:KPathpnt_y
	wave tmpy=root:ARToFData:KPathpnt_y
	endif
	
	kpntnum=dimsize(tmpx,0)
	
	if(kpntnum>0)
		//if(abs(setcutkx_s-tmpx[kpntnum-1])>=0.01||abs(setcutky_s-tmpy[kpntnum-1])>=0.01)
		
		redimension/N=(kpntnum+1) tmpx,tmpy
		
		kpathnodes=kpathnodes+";KPnt"+num2str(kpntnum+1)
		
		SetDrawEnv/W=IntensityVSK xcoord= bottom,ycoord= left,linefgc= (65280,0,0),fillfgc= (65280,0,0)
		DrawOval/W=IntensityVSK -0.01+setcutkx_s,-0.01+setcutky_s,0.01+setcutkx_s,0.01+setcutky_s
		//endif
	else 
	redimension/N=(kpntnum+1) tmpx,tmpy
	kpathnodes="KPnt"+num2str(kpntnum+1)
	SetDrawEnv/W=IntensityVSK xcoord= bottom,ycoord= left,linefgc= (65280,0,0),fillfgc= (65280,0,0)
		DrawOval/W=IntensityVSK -0.01+setcutkx_s,-0.01+setcutky_s,0.01+setcutkx_s,0.01+setcutky_s
	
	endif
	
	tmpx[kpntnum]=setcutkx_s
	tmpy[kpntnum]=setcutky_s
	
	PopupMenu kpntpos,mode=1,popvalue="",value= #"kpathnodes"
	
	
End

Function chooseknodes(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr


wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y

nvar setcutkx_s=root:ARToFData:setcutkx_s
nvar setcutky_s=root:ARToFData:setcutky_s



controlinfo/W=VisualizeARToFData kpntpos

setcutkx_s=tmpx[V_Value-1]
setcutky_s=tmpy[V_Value-1]


drawknodes()

SetDrawEnv/W=IntensityVSK xcoord= bottom,ycoord= left,linefgc= (0,0,0),fillfgc= (0,0,0)
DrawOval/W=IntensityVSK -0.01+setcutkx_s,-0.01+setcutky_s,0.01+setcutkx_s,0.01+setcutky_s


End

Function setcutkx_start(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y
//nvar setcutkx_s=root:ARToFData:setcutkx_s
nvar setcutky_s=root:ARToFData:setcutky_s

controlinfo/W=VisualizeARToFData kpntpos
tmpx[V_Value-1]=varNum

drawknodes()
SetDrawEnv/W=IntensityVSK xcoord= bottom,ycoord= left,linefgc= (0,0,0),fillfgc= (0,0,0)
DrawOval/W=IntensityVSK -0.01+varNum, -0.01+setcutky_s,0.01+varNum,0.01+setcutky_s


End

Function setcutky_start(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y	
nvar setcutkx_s=root:ARToFData:setcutkx_s
//nvar setcutky_s=root:ARToFData:setcutky_s

controlinfo/W=VisualizeARToFData kpntpos
tmpy[V_Value-1]=varNum

drawknodes()
SetDrawEnv/W=IntensityVSK xcoord= bottom,ycoord= left,linefgc= (0,0,0),fillfgc= (0,0,0)
DrawOval/W=IntensityVSK -0.01+setcutkx_s,-0.01+varNum,0.01+setcutkx_s,0.01+varNum

	
End

Function clearknodes(ctrlName) : ButtonControl
	String ctrlName
	
wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y

	
	if(!waveexists(tmpx))
	make/O/N=0 root:ARToFData:KPathpnt_x
	wave tmpx=root:ARToFData:KPathpnt_x
	endif
	if(!waveexists(tmpy))
	make/O/N=0 root:ARToFData:KPathpnt_y
	wave tmpy=root:ARToFData:KPathpnt_y
	endif
	
redimension/N=0 tmpx,tmpy
	
svar kpathnodes=root:ARToFData:kpathnodes
kpathnodes=""
//PopupMenu kpntpos,mode=1,popvalue="",value= #"kpathnodes"

drawaction/W=IntensityVSK delete
removefromgraph/Z/W=IntensityVSK Rky_wave

End

Function editknodesinfor(ctrlName) : ButtonControl
	String ctrlName

wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y

	
	if(!waveexists(tmpx))
	make/O/N=0 root:ARToFData:KPathpnt_x
	wave tmpx=root:ARToFData:KPathpnt_x
	endif
	if(!waveexists(tmpy))
	make/O/N=0 root:ARToFData:KPathpnt_y
	wave tmpy=root:ARToFData:KPathpnt_y
	endif
	
variable iimax
iimax=dimsize(tmpx,0)
dowindow/K/Z KNodesInfor
creatknodesinfortable(iimax)


End

function creatknodesinfortable(v)
variable v

string ktext,kpntx,kpnty
variable left,top,right,bottom0,bottom1,ii
bottom0=30*v

wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y
//Window Panel0() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel/K=1/W=(300,200,560,250+bottom0) //as "KNodesInfor"
	ModifyPanel fixedSize=1, frameStyle=1
	SetDrawLayer UserBack
	ii=0
	do
	ktext="KPnt"+num2str(ii+1)
	kpntx=ktext+"_x"
	kpnty=ktext+"_y"
	DrawText 95,30,"kx"
	DrawText 195,30,"ky"
	DrawText 15,50+ii*30,ktext
	print tmpx[v-ii-1],tmpy[v-ii-1]
	SetVariable $kpntx,pos={55,35+ii*30},size={100,20},proc=ff,value= _NUM:tmpx[ii]
	SetVariable $kpnty,pos={155,35+ii*30},size={100,20},proc=ff,value=_NUM:tmpy[ii]
	ii+=1
	while(ii<v)
	dowindow/C KNodesInfor
//EndMacro

end

function ff(ctrlName,varNum,varStr,varName):SetVariableControl//change kpathnodes value according the input value in the above table

	String ctrlName
	Variable varNum
	String varStr
	String varName

wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y
variable iipos,pos
string strpos
pos=strsearch(ctrlName,"_",0)
strpos=ctrlName[4,pos]
iipos=str2num(strpos)

if(!cmpstr(ctrlName[strlen(ctrlName)-1],"x"))
print ctrlName,ctrlName[strlen(ctrlName)-1],iipos
tmpx[iipos-1]=varNum
endif

if(!cmpstr(ctrlName[strlen(ctrlName)-1],"y"))
tmpy[iipos-1]=varNum
endif

drawknodes()
end



function drawknodes()

variable ii,iimax,kx,ky
wave tmpx=root:ARToFData:KPathpnt_x
wave tmpy=root:ARToFData:KPathpnt_y

ii=0
iimax=dimsize(tmpx,0)

drawaction/W=IntensityVSK delete
ii=0
do
kx=tmpx[ii]
ky=tmpy[ii]
SetDrawEnv/W=IntensityVSK xcoord= bottom,ycoord= left,linefgc= (65280,0,0),fillfgc= (65280,0,0)
DrawOval/W=IntensityVSK -0.01+kx,-0.01+ky,0.01+kx,0.01+ky
ii+=1
while(ii<iimax)

end

Function adjustoffsetornot(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	nvar adjustoffset=root:ARToFData:adjustoffset
	nvar artof_flag=root:ARToFData:artof_flag
	
	if(adjustoffset==1)
	setvariable offsetomega,win=VisualizeARToFData,disable=0
	setvariable offsettheta,win=VisualizeARToFData,disable=0
	setvariable offsetphi,win=VisualizeARToFData,disable=0
	
	if(!artof_flag)
	SetVariable offsetomega1,win=VisualizeARToFData,disable=0
	SetVariable offsetomega2,win=VisualizeARToFData,disable=0
	SetVariable offsetomega3,win=VisualizeARToFData,disable=0
	SetVariable offsetomega4,win=VisualizeARToFData,disable=0
	SetVariable offsetomega5,win=VisualizeARToFData,disable=0
	SetVariable offsetomega6,win=VisualizeARToFData,disable=0
	else
	SetVariable offsetomega1,win=VisualizeARToFData,disable=2
	SetVariable offsetomega2,win=VisualizeARToFData,disable=2
	SetVariable offsetomega3,win=VisualizeARToFData,disable=2
	SetVariable offsetomega4,win=VisualizeARToFData,disable=2
	SetVariable offsetomega5,win=VisualizeARToFData,disable=2
	SetVariable offsetomega6,win=VisualizeARToFData,disable=2
	endif
	endif
	
	if(adjustoffset==0)
	setvariable offsetomega,win=VisualizeARToFData,disable=2
	setvariable offsettheta,win=VisualizeARToFData,disable=2
	setvariable offsetphi,win=VisualizeARToFData,disable=2
	SetVariable offsetomega1,win=VisualizeARToFData,disable=2
	SetVariable offsetomega2,win=VisualizeARToFData,disable=2
	SetVariable offsetomega3,win=VisualizeARToFData,disable=2
	SetVariable offsetomega4,win=VisualizeARToFData,disable=2
	SetVariable offsetomega5,win=VisualizeARToFData,disable=2
	SetVariable offsetomega6,win=VisualizeARToFData,disable=2
	endif
End

Function EDCspotkxpos(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	nvar kxkyposcursor=root:ARToFData:kxkyposcursor
	kxkyposcursor=1
	getkxkyEDC(ctrlName)
	kxkyposcursor=0
End

Function EDCspotkypos(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:ARToFData:kxkyposcursor
	kxkyposcursor=1
	getkxkyEDC(ctrlName)
	kxkyposcursor=0

End

Function EkimageEDCkposAdjust(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:ARToFData:kxkyposcursor
	kxkyposcursor=1
	getarbEDC(ctrlName)
	dowindow/F VisualizeARToFData
	kxkyposcursor=0
End

Function EkimageMDCKposAdjust(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:ARToFData:kxkyposcursor
	kxkyposcursor=1
	getarbMDC(ctrlName)
	dowindow/F VisualizeARToFData
	kxkyposcursor=0
End


Function help2dto3d(ctrlName) : ButtonControl
	String ctrlName
	
	displayhelptopic/Z "2Dto3D transition and 3D data processing"
	if(V_Flag)
	abort "No help file for 2Dto3D present! Please ask the author to fix it!"
	endif
End

Function edit3ddatatable(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData
	nvar artof_flag=root:ARToFData:artof_flag
	
	if(creat3dtable()) 
	if(artof_flag)
	edit/K=1 ThreeDDataNameT,PhotonEnergyT,WorkFuncT,LatticConsT,Omega4ARToFT,Theta4ARToFT,Phi4ARToFT,OmegaOffsetT,ThetaOffsetT,PhiOffsetT
	endif
	if(!artof_flag)
	edit/K=1 ThreeDDataNameT,PhotonEnergyT,WorkFuncT,LatticConsT,OmegaOffsetT,ThetaOffsetT,PhiOffsetT,LinearOffThetaS,LinearOffThetaE,LinearOffPhiS,LinearOffPhiE
	endif
	endif
End

function creat3dtable()
	
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData
	
	controlinfo/W=VisualizeARToFData artofdata
	if(!cmpstr("fittednamelist",S_Value))
	setdatafolder curr
	return 0
	endif
	
	wave/T tmp=$S_Value
	
	variable itemsnum,ii
	itemsnum=dimsize(tmp,0)
	
	if(!waveexists(LinearOffPhiE))
	make/O/T/N=(itemsnum) ThreeDDataNameT
	make/O/N=(itemsnum) PhotonEnergyT,WorkFuncT,LatticConsT,Omega4ARToFT,Theta4ARToFT,Phi4ARToFT,OmegaOffsetT,ThetaOffsetT,PhiOffsetT,LinearOffThetaS,LinearOffThetaE,LinearOffPhiS,LinearOffPhiE
	ii=0
	do
		ThreeDDataNameT[ii]=tmp[ii]
		ii+=1
	while(ii<itemsnum)
	else
	redimension/N=(itemsnum) ThreeDDataNameT,PhotonEnergyT,WorkFuncT,LatticConsT,Omega4ARToFT,Theta4ARToFT,Phi4ARToFT,OmegaOffsetT,ThetaOffsetT,PhiOffsetT,LinearOffThetaS,LinearOffThetaE,LinearOffPhiS,LinearOffPhiE
	ii=0
	do
		ThreeDDataNameT[ii]=tmp[ii]
		ii+=1
	while(ii<itemsnum)
	endif
	
	setdatafolder curr
	return 1
end

Function saveparameter(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData
	nvar artof_flag=root:ARToFData:artof_flag	
	
	creat3dtable()
	
	controlinfo/W=VisualizeARToFData artofdata
	if(!cmpstr("fittednamelist",S_Value))
	setdatafolder curr
	return 0
	endif
	wave/T tmp=$S_Value
	
	wave/T  ThreeDDataNameT=ThreeDDataNameT
	wave PhotonEnergyT=PhotonEnergyT
	wave WorkFuncT=WorkFuncT
	wave LatticConsT=LatticConsT
	wave Omega4ARToFT=Omega4ARToFT
	wave Theta4ARToFT=Theta4ARToFT
	wave Phi4ARToFT=Phi4ARToFT
	wave OmegaOffsetT=OmegaOffsetT
	wave ThetaOffsetT=ThetaOffsetT
	wave PhiOffsetT=PhiOffsetT
	
	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	nvar RAngle=root:ARToFData:RotationAngle
	nvar Theta0=root:ARToFData:ThetaAngle
	nvar Phi0=root:ARToFData:PhiAngle
	
	wave LinearOffThetaS=LinearOffThetaS
	wave LinearOffThetaE=LinearOffThetaE
	wave LinearOffPhiS=LinearOffPhiS
	wave LinearOffPhiE=LinearOffPhiE
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2

	nvar thetaoffset=root:ARToFData:offsettheta
	nvar omegaoffset=root:ARToFData:offsetomega
	nvar phioffset=root:ARToFData:offsetphi
	
	variable ii,itemsnum
	itemsnum=dimsize(ThreeDDataNameT,0)
	if(artof_flag)
	ii=0
	do
		if(!cmpstr(tmp[V_Value],ThreeDDataNameT[ii]))
		PhotonEnergyT[ii]=PhotonE
		WorkFuncT[ii]=WorkFunc
		LatticConsT[ii]=LC
		Omega4ARToFT[ii]=RAngle
		Theta4ARToFT[ii]=Theta0
		Phi4ARToFT[ii]=Phi0
		OmegaOffsetT[ii]=omegaoffset
		ThetaOffsetT[ii]=thetaoffset
		PhiOffsetT[ii]=phioffset
		endif
		ii+=1
	while(ii<itemsnum)
	endif
	
	if(!artof_flag)
	ii=0
	do
		if(!cmpstr(tmp[V_Value],ThreeDDataNameT[ii]))
		PhotonEnergyT[ii]=PhotonE
		WorkFuncT[ii]=WorkFunc
		LatticConsT[ii]=LC
		//Omega4ARToFT[ii]=RAngle
		//Theta4ARToFT[ii]=Theta0
		//Phi4ARToFT[ii]=Phi0
		OmegaOffsetT[ii]=omegaoffset
		ThetaOffsetT[ii]=thetaoffset
		PhiOffsetT[ii]=phioffset
		LinearOffThetaS[ii]=lthetaoffset1
	    LinearOffThetaE[ii]=lthetaoffset2
	    LinearOffPhiS[ii]=lphioffset1
	    LinearOffPhiE[ii]=lphioffset2
		endif
		ii+=1
	while(ii<itemsnum)
	endif

End

Function ListBoxProc1(ctrlName,row,col,event) : ListBoxControl
	String ctrlName
	Variable row
	Variable col
	Variable event	//1=mouse down, 2=up, 3=dbl click, 4=cell select with mouse or keys
					//5=cell select with shift key, 6=begin edit, 7=end
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData
	nvar artof_flag=root:ARToFData:artof_flag	
	
	controlinfo/W=VisualizeARToFData artofdata
	if(!cmpstr("fittednamelist",S_Value))
	setdatafolder curr
	return 0
	endif
	wave/T tmp=$S_Value
	
	wave/T  ThreeDDataNameT=ThreeDDataNameT
	wave PhotonEnergyT=PhotonEnergyT
	wave WorkFuncT=WorkFuncT
	wave LatticConsT=LatticConsT
	wave Omega4ARToFT=Omega4ARToFT
	wave Theta4ARToFT=Theta4ARToFT
	wave Phi4ARToFT=Phi4ARToFT
	wave OmegaOffsetT=OmegaOffsetT
	wave ThetaOffsetT=ThetaOffsetT
	wave PhiOffsetT=PhiOffsetT
	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	nvar RAngle=root:ARToFData:RotationAngle
	nvar Theta0=root:ARToFData:ThetaAngle
	nvar Phi0=root:ARToFData:PhiAngle

	wave LinearOffThetaS=LinearOffThetaS
	wave LinearOffThetaE=LinearOffThetaE
	wave LinearOffPhiS=LinearOffPhiS
	wave LinearOffPhiE=LinearOffPhiE
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2

	nvar thetaoffset=root:ARToFData:offsettheta
	nvar omegaoffset=root:ARToFData:offsetomega
	nvar phioffset=root:ARToFData:offsetphi
	
	variable ii,itemsnum
	itemsnum=dimsize(ThreeDDataNameT,0)
	if(artof_flag)
	ii=0
	do
		if(!cmpstr(tmp[V_Value],ThreeDDataNameT[ii]))
		if(PhotonEnergyT[ii])
		PhotonE=PhotonEnergyT[ii]
		WorkFunc=WorkFuncT[ii]
		LC=LatticConsT[ii]
		RAngle=Omega4ARToFT[ii]
		Theta0=Theta4ARToFT[ii]
		Phi0=Phi4ARToFT[ii]
		omegaoffset=OmegaOffsetT[ii]
		thetaoffset=ThetaOffsetT[ii]
		phioffset=PhiOffsetT[ii]
		endif
		endif
		ii+=1
	while(ii<itemsnum)
	endif
	
	if(!artof_flag)
	ii=0
	do
		if(!cmpstr(tmp[V_Value],ThreeDDataNameT[ii]))
		if(PhotonEnergyT[ii])
		PhotonE=PhotonEnergyT[ii]
		WorkFunc=WorkFuncT[ii]
		LC=LatticConsT[ii]
		//RAngle=Omega4ARToFT[ii]
		//theta0=Theta4ARToFT[ii]
		//Phi0=Phi4ARToFT[ii]
		omegaoffset=OmegaOffsetT[ii]
		thetaoffset=ThetaOffsetT[ii]
		phioffset=PhiOffsetT[ii]
		lthetaoffset1=LinearOffThetaS[ii]
	   lthetaoffset2=LinearOffThetaE[ii]
	    lphioffset1=LinearOffPhiS[ii]
	   lphioffset2=LinearOffPhiE[ii]
	   endif
		endif
		ii+=1
	while(ii<itemsnum)
	endif
	setdatafolder curr
	return 0
End

// JPEG: width= 137, height= 46
Picture AutoShowPlay
	ASCII85Begin
	s4IA0!"_al8O`[\!W`9l!([(is5=9>7<iNY!!#_f!%IsK!!iQ0!>5A7!!!!"!!*'"!?(qA!!!!"!!!
	".!?2"B!!!!"!!!"6!@RpM!!!!"!!3-#!AOQU!!!!=!!!">!AXWV!!!!5!!!"ZLM6_k!!!!"!!!"p!
	!!#G!"/XS!!"AX!"/XS!!"AX6"FnCAKXf_Dffo=BQ%i46W5c`=(uP_Dg-7&1,(F;3\WNS0fU:12``]
	N3]/Ym!!!!$TE,#p!!!!"!!*'"TE5)r!!!!"!!!"2TE>/s!!!!"!!!!Cz!!!!'!<W<(!!!!"!!WE'!
	?(qA!!!!"!!!$@!?2"B!!!!"!!!$H!@RpM!!!!"!!3-#!W`9(!!!!"!!!$P!Wi?)!!!!"!!!:%z!!!
	!i!!!!"!!!!i!!!!"s4IA0!"_al8O`[\!WW3k!([(is6Tdp6"FnCAR@f!!!3,f!"M;*Ddm8XA:OX[!
	!3,S!/(=\#RC\B#Rh"G$kWjS$P=*a$k*X](_[Pt',)2p$k*OQ$k*^V$k*OQ$k*OQ$k*OQ$k*OQ$k*O
	Q$k*OQ$k*OF%1<OQ%LisZ%M0<a%Ls0e%LrsY'G1`^$k*OV&I]'V$k*OV$k*OQ$k*OQ$k*OQ$k*OQ$k
	*OQ$k*OQ$k*OQs1eUH#QQ%KAci&X!!3`5!tbS6h#IQX#QM^C56(Za"T\W)!<E3$z!!!*$!<NB-"pYD
	?$4?k7!<iK)!<E3%z!!!!"!!36*"U52;#mq%O!!*3'!s/T,"U>5;"To/h!<<05!sBb[0a0j?@1si)J
	MIEDOeK$H,:""%_.#2WEe;\+#:5O3nDWnIF#=`-Z@aJlP>l']_P;32(Xc=CAb*0\_p`bgo0t*lUkQ1
	@`73l?V7":mjn2YdG(u<[[`6n\p,>KCB6T,tVmj^ukP#Pg!WiB("9\f0"U52:"pHjb!!3`7+YaT45u
	D'1+qk,8JWUY?YsK\O;UOti,\#_QJs&K"'k;;AnKeATU9]CV-8iZg7$CTF(M#s72KWNio!="edrj^B
	7[0^&[$ASZjRf:V`RX)C<b?N0QDV+1f&lZR2b-q^GDDN_\&\O&!"8r1!!3`7&HG#qli+?kDZ,Sue*n
	40NiRMN26Qcj0`-9FpAY-N<IT8QZ<bs@K?]r_0&4LZ;TCbSL[nT.c'10dgJMi]ZZ:)4Xf$<Pp:AUHC
	?K1lA,.[PXBc@e^4f'ZV^9ntlCCL^=geU!$(#Q+91'IGGd33k(/5HPMhd/2c_!+3V\UIA"H<p&(CpG
	BR;Oat47LL^D]4DXk>Z*n[-"N`lGqMX]!A@#SU'5KmNT;kp^K=2[?Y=jL3rq#2YR.Nf723u]j%3'/s
	K#3B;n;7]pcG-J*?n4[^k7g7<V_i8$]t=_rKQE4BSo/j'E@UbSg"\ahp:q(sDV:Z1WmUiUe1_F#$%.
	S:*MG)t^59r>OAh!.TLn2D7#S*Fl9qLRU*jT1r)W3*>TkFgQBX@;V?\f:DpA>@O^Q=NKfo@U55Xo@%
	]INN[]irMLe<!%u9sQ)F;)!j8HO/&Sd?@ij5^c>7ClNS7(-Z7AFUC?#2DRbd71=g$*CN0_6Vp-[EG8
	,DE"3\@IO?'"863b$*2G@+R(IZ'ccZZ#[Z^[91pVc`eje1`geM)fh@;m_"9U\RoNVuHa$>fK,ug0ON
	lT/;f/i9Hjqo\\AspAKcpp&010qJj8ro<,:i_lWOC*&+ID:$Il<0Z1?r#OgD\pXQnS'gMEO`1s>;rg
	!K`2Rad7S=u0;r!qU]f`(s$qdB(s\tR\0K2'W#*`@0WVQ928HahYFD4g&69:c'/bFYioFj@VHX:N.i
	I?cbU@H9H"<8m_VhFm,4[4Y`l<;MYu<Vi7Edr>KG9op?EincT&q^u-F<AlT"UEPYtenA7G%L;-ZT(\
	eZfGFKi^TQ*ch#(9Wr%LV6gu?K0;k<oIcaBCCrr>F_:\Zc5R8K5]/\)_c50fj+BskX4lE\'kD#V=TF
	+<M4,cC[hbH6fDTOPZ+ijmQ@4<7@k;nqT6EW.Rt],s,W`dcLK;u5nS?R!.PHI#?bh+dD*m!?K$CV\]
	u\l_.c>fQcJ><VudiP3en2]nu1;-ee^-1%Yj(4&b.%Kj'2Q(eQ1LO^;.!.Vh+3"I[d)3@O07OS)ZW-
	-Fgr?nHIj+9'BIZ(.5"f)&Xbui<WI5U/4R0(Y$JBdL7g>2t'gKXTAWgh'JkQ9?3\+OAilR#7rCTH\n
	5HJD\"2Ob8poaPl+7roUI?aa3`Zl>\jkrkuJ*2(\8EAoF1nbqjoR+iQLPp$j?_n]:ASfVoHe2tYCNo
	a\\kf9UDYhCErr@\XrhX`:!*d1;rmS`]hO<$IRt0=Z=7f\m?uEoTbk`o6%fZM6BD'lFZM_?dZ>"HKR
	C!SI=dn`ZSK&#eeVcDV,klD2TEf,]qS-D%I3-)TQ@WHWarBcRhplB<rVjdu?$!)KeMHU;AKr5!!,NR
	;+.lsRqF<)pDnasHD9d9i]Z]1&>iL6tk9>$7%\_H/`XbhJf!pjUgA5rErY$L%n8/+)_(>Td#(frd@b
	NF4VFTi/rJPl<:pB%urr=dRjVC<c6iI[iog*mc5,RuGI9?H!\FJi(W;$7fI8@9N!8G8VrepD!c$H5k
	G>$+=SOK-)5l)#Ce$KYT\CQ+Yofo"Jr$"a]O#K-2!eZW'F(hPc\`Pd=DsodaX3U^PrFa(72HO3:)f)
	+01*<:K3c3XIQ2^heF'3eaq/6ef]$,r:6X=2[TRS>0"'oc0ZAMcMDm[K*edJ)0r.['T1P]2#*mI+Rh
	#@@$bAk"@gR/eP]50^1\bP&^F2lcqXlm.!l'Ha">ui`NL<DcAWr8"9BCgSer#KJsVuP0;<TLo%rrD.
	RJ)p$Im2,EPr=&[/o(8.9r4uu@PeE,FrgR9e:S^5:TB94ciVrmGVtn*#hr[.lj89Gc+7:eJdRQ7?N*
	e+.;W5C1:\.S9addk7^Zg1H!29Dm-$XH&2FjU=qEo^u5PD#NTC)XY+a[#7n+da6q*1MKbPl"3rrDQ'
	knhVo,cBq(M=nX_7CW*urma6#rrCTakh")d,c@N]rdEZsTDM@\ch9Sb]ds"arr=urr0d2,m4\+Xr=&
	ZlnFVlBohnHE<0C2[g&LFL[SUXUFDl56Df?gT/hd8b6:jlS,ldoF!!!Q1zzz!!!!Y6:jlS0)ttP!!#
	X`!!*'j!!!!izz!!!#G!WW3c!WW3#z!!!!9!rr=3!WW3#!Ped;!3cS+!!*'1-NO3`CisUqzz!'!;:9
	`sb_z&-,6$!!!$"!WYak!!!$"!]WM<9`udCz%KHJ/z!!!!`J,fR/6:jlS%0-A.!!!-%!!%7'6:jlS)
	#sX:!!!-%!!"'"6:jlRo)Jaj!!!<*z!!!!"!'!;:9`te'z!<<*Z6:jm!&-)\1!!!?+!<<*"z!]WM<9
	`t%gz8,t;TAcMi3Ch@8Z"onW'!!!$"04ner!<Ag]RK*Nlz!<=kT!!!$"=o\O&"onW'!!!$"2#mUV!<
	=\O!!!3'z!B<D;9`t.jzDu]n<s8W-!s8W-!s8W-!s8W-!s8W-!rr_Hb!!!$!s8W-!s8W-!s8W-!s8W
	-!s8W-!rr_Hb!!!$!s8W-!s8W-!s8W-!s8W-!s8W-!rr_Hb!!!$!s8W-!s8W-!s8W-!s8W-!s8W-!r
	r_Hb!'!;:9`tFrz!WW<^6:jlS!WW3#!!!9)z!!!!Y6:jlS0E;(Q!!!-&!<E3\6:jlS/H>bN!!!3'!<
	<*""?8_>9`t_%z&-)\1!<<*$5QCcc5QCca!'!;:9`uL;z"98E%!'!;:9`u@7!!!!$56(Z`"onW'zz+
	ohTCAcMf2"_T;u#FLkY/H@L*!!!$"zzzz!!!$"zz!!$U2!!"2Czzz!!!!"zzzz!!!!1!!!!"z!!$nZ
	Chs(O!!3-#!!ZnNF`(`2:L\'K!!!!"z!!#o,F>3aq!!E9%!!#u:E$/t8DJ&qLz!!#](Aoqj-DJ&qLz
	!!#?-Df'</DJ&qL!$VCC!!#o0BQS'/DJ&qL!+l32!![L\Bk(^q<btHN!!!!":L\'K!!!!"z!!RF[Bk
	(]S!!!W3!!!7FCh[Bj8ORB5DJ&qLz!!d.WDfp"j6u6dZB)ho3z#&eNrB5)6pDKTdr!!!Er;f$/XAP[
	>\B5)5`!!!I:F`_OlASu("@<?'kz<-`FoASuX-!!!!+78n#:@qAVbE+K"L!!#T-B-70S!!ZnNF`(`2
	:L\'K!!!!"z!!#o,F>3aq!!E9%!!#u:E$/t8DJ&qLz!!#](Aoqj-DJ&qLz!!#?-Df'</DJ&qL!$VCC
	!!#o0BQS'/DJ&qL!+l32!!@@aCfEi*;ucmu!<<*"!!!":F_kkn79ELh!!!$"z!)7NIAQ2*#;ucmu!<
	<*"!!!43CiiWbB2h<%;ucmu!<<*"!!!L=ASc0^AU&;gF%B8)9O_pYC]OM9!!m(GCi!'^G]ZnR=B#8#
	!!*'"!!!!*BQ%p;6#:7JDIm^.D#aP9%n0E5Bk(^FDfU.iCh[O"!!!!(A7]@]F_l."!!!=KATDlYCh[
	O"ASuX-!!!!078n#:@qA\PEcaT`BkM;`!!!77AS,@nCifXW!"37K6Z6dZE`@='AS#b%D#aP9&OfW7B
	k(^@7mh32DfSg&E+K"L!!#c4DIieJ!"!acE)1UuF(KH0Df01fz!!!@BAS-$[F`_\9FDPl5B)ho3z$t
	=-sFDl"lF`_\9FDPl5B)ho3z$Z]roBQR$mFE;#8Ci=3(z!'!;:9`ujEz$ig8-!C-&Rz!'!;:9`u.1z
	"98E%"?8_>9`tk)!!!!)D#aP9!<<*"AcMf2+ohTD1]RM(kPtSg;#hF5!WUgPhuF<\7S-&L!<N6$8,u
	0\!<;Ed$peEB@V&n69`P4omJm__A8bpg!+^T[!!!'"gAlm,$j[+E#m^qG#n.CR$4@F\%h&jW'c7St'
	b_5t&I]'V$k*OV$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ!=]DE%1WgY%Ls$a%Lrs_'FkT_%MTK
	`$k*OQ&J5E[$k*OQ&I]'V$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ%0+*C&I8@\!+l<6+ohZV!<Wo7s4
	mYX!!iPB!C$Pa!<iK)!<E3%z!!!!$!!*-("U52;#mq%@!!*6(!<E3%!<<*"z!<<0'"9eu7#RLhG&-)
	_6!<WB+!X/f5#R(;=1B@IW&H`.Z&hsPU;.1+^EIfkL'To)o66d`j;Scfu1ie2q6O+p#;t/c9@rjLCU
	9]Cu7$CS\7DbgA2AaeAiaq\eKYu8]j7>_fPba#?Q,M25oVJt7e`HI)Ap/opVRFLqk4U`(=(c`4Q`%=
	5fB;l?!!33&!X&W."9eu7#6k>h!<<05"!KB3"@5mnE?Z&"14bQ%Ts6p/_,A\M1F-GgEe9HA;\`e`2"
	;jr(8A*e#:;=FdR99uUDIH0<Anr1ipsF/_p`bgo1"t?Ks[,`eE$7u[Dg\Xoi>[JL6e^F`n';G-T=Os
	B6T,tVmj_Hg&MN`!<<05!tbMt!:0WmrGMRo=jujWglAF^G;ZQ"'eoN5HhRI>i)P5PiNcb=3eP\J:G1
	GC]2H[/MMLb*Nm3eIrnC:f9=&YZHEF)f\b<V]:MT')4_+:=V6!r5e\6`-=JmIr>3_YMCK\(OOpRImq
	Fa0k/9nFYP86k+@uH,!aj6S;Co8$m5Qm&W%i5`TVjVEW`&mJ5Qu<mud-"A@rj:gjTBaJKXLb^;l(*+
	Zg?p/tI/".4caB$Lm=ouf!&jQN!7u_K._T&[oe)J%Y%O_%^qH2Gqg[i0!4KGpTga-*i(()h[DV%\8N
	^+\`oCA<MTct0@EHDN0,Vn+5-ad9YMo*pSoZYQH^oLHH5lLXYl,Knrr@Oupbjcal5aB<FbcGBnt/WO
	qD_UFF`k'95@JDqJ(L7k!*`p7Dck*HQ==-aiq(W=R>nCsjSbu!rr=[kZB_?\IfcdNeLSPFc=7pI3R2
	GYp5Rd"XKj?HA8:-&JstN\=';]PoSf*Nr:WM/^IS.`eiGCbDI&=g4Z[&l=Ee+VIt!<Hn$?s/)o(d_e
	u)XHUXUtV?&:Rdj&<=6Oe__PO/N!X>?o086eYiA_k/cMqV^Y04S7ObUA"P@de3QapA/dDHLn;Cou!m
	(],WN+Inf0kqCogqqZlTEB_U&hr=qQjil%Ul>lL#g!&h;.Z^d_R8,NkS;:tmKeGEYH<P"mT0nW3G%3
	ADjUo(3^.=8PV_el%1*_W('Hcr"_i-!>WdB!kpb'fO6l!`X5el:W*Xkl_8rj=@a?W?l_F]J:/2UcXJ
	h+`tNJ)]<C\,.d_SlI['m\:qcWn(iei=6+TP+MB>Y1OQh>/.5j;r%:QY5BtCp>"ZMfi+I@NR,#)VuH
	`aqG6lCQ^L^9AhCP1m68gh>A:LYMs@U\RV_u@=`])YM'T#!d*&PO`Lp\T8)h)/=?IU&SQ!;g(NKF,?
	b7CAb/Sq\\Pr@loj8oURsNCUW812;m-K&705JAXp:=?iRp<u4Z!0Bk!9(]@/iOlNAl2id$RP/>i>-`
	8/Ihlhp6D?Xc\I#hPlQ<MF#X[`bScL9DFQ#Nc_u!4Xo0WE#NLCl14G.[@0NG*3mCdQl?tPPH'n`YmX
	WRM0&#.bS_IBHQE$Fq)X%7RqR?-11[?A\8SbBk9L#Uhl3"iu=ST&sq]GH;COMHI!6-6#j5o2nl@7uB
	"\@_:Ai-2%X7Ue_SVN,@*FGW^:1\7dY'\c7HY[j)"M.C-eo(?)8H/[BZi6eCrr?9;WrCJaVV[cmf:.
	<HPZRK\qI"3ZT?R-`FUnEO#A<_]R^2k(/@&u4R$k;o*EeiuXIU==J(9H:Rj@`MJ=m-[fD<6hl$XVdf
	p71t'$;0]Z/=)ErVc`7k$<&0=4K+oc"/+?Y5iAWP96E*&c,!KMf6>a*Gs)EQFtDtnm(1(Pij64ljf`
	?1<'i"YL^4G^"W=*KDlN.cgYcN!5U5d!!\$W@Ue%CrME*K2uSYYDc!\"D>sSjWoY!c<C?`tTCkKr4$
	KP6p3g'AJ[k78*2rW1VL;7JrrCfgRJr-:/'WC;#'W_`31WL0L-YSGf@.);n@7%uJ+Z$sX8F/6I?-<K
	%g%BGR<*&@]Xd/^n8IbWqQ%p@[JaaVlS_gN/K8JuOtn,Sh`>W/q3Cs[=`[_kq>"q>bdu#RZpS,/MkG
	PIEW]TaQElBMlYj/LFOghkj8=Wh,r:<\Q6+:>!8RSS-HgD<J(pA+Uq:G-W4D]\<HH125HX+WZg!g'=
	^>&`nV54NO/i/>he2P0^\f*d,cC[ioi:(f?iL,f97Q$jJ*e'Ehu*u_>4V<Lnbg48:R&PR6iNQ^oM;8
	Ije([:\`*Pg7&TjqT\nlrRcF;Vr#b>[QI88^b`#mZohsb``_Z2+J'"41g:um#rrAbm!$ul18iB29U\
	[?,QTt2Aq4I'S!$Q\beF32K^\L*dqoetKNrK+K^ZcQ[.3thVV2=l[r^F<m#QE7<R/[0:^Za:p#pcFG
	ao6_G9:u)Ur6P($OM*1B>5nR]Du?$qJ*eo]ci":O6LaW1;tX$]j]%CAs4IB36:jlS+TMKB!!$"!!!!
	$#!!!!0!'pTq!,hjH!+c-Q!)NZ/!,hjZ!,hjY!,)@N!,qo<!##>u!+Z(J!+Gq>!$D8<!,)@N!-A3Z!
	-8-R!,hjV!$D8/!)ikR!!!!"!'!;:9`tY#z#65#0!!!$#!<;!gc"M3@E&oX*DK@F=A8bpg/n8g:06g
	oE0/5(50*"+!G]7)$CLqT1@V'1dDET34]>#O4Bk0@N=#E]+9lNI2BPC"`Eb/0q:/k_LCL]A8,!S764
	Ero3D/a?'FC?;:D/=*23d<e3@:X:cANF^M3c/GM@4rfIGWL(dE-,kY,!faX@V$Za9i)s"DfTD31bLL
	7@k]\s+>bu/1,h*M1,(7%9lFnl7V-$O0f^@30JGF.1,:mI0KLmI+<VdL+<VdL,!I,3Eb&cC;FEtsG\
	q87F#n>PAj%>OFEDI_0/%NnG:n(q/oPcC0/5II3A3'A0/>:7Eb&c6F*VYF@<aAAF!Dkm+?X[TAi`=k
	F(96)E-,f4DBNt1Aia@0Dfp.b+sJ.SD/=*23b2_`,%u(?E&oX*E-62;/oPcC04\QGASbppASuU20/5
	(60-VN`D/=*23d>(P4X+Q]FDs8o05bh`@:X:cAM.J2D(g-BE%`pu0J=UmG\q87F#nPSE(s%i,%u(?E
	&oX*DK@F=A8bpg/n8g:06goE0/5(505YPZ+s;,ICi4;TF*(;kAj%>OFEDI_0/%3a/n&:/@V%0%Df%.
	P@;mkS/her"<-`Fo02cA&Dfp)1AQ!)O,9e7TD/=*23cJbNFDl56Df@i`BQS?83\N.(F"Um3Ddm91@r
	H3;E+j03Df]T1E%`pu0J=UmG\q87F#nDWAnF1MBQS?83\N.(F"Um3Ddm91@rH3;FD5?!0/5(50-VN`
	D/=*23b<PMAj%>OFEDI_0/%3a/n&:/@V%0%Df%.=G\LbC0eP.5+s:E+3bE;ND..NL,&(n&B4W`2E+N
	Z++F%=63^[q!@<?F.<,Z\k4X*1&Ddm9#:hXchDf]T1E$.MH1E]b5DId[0F!;`O@;n7pEb/[$AOKsKA
	N_4m0JP:60K:X=3)hUk3\iNQ2)6[93'&`I+s;,=E&p^3A8,Y$6t(1K4X)X80ek763%ZjE<&$<m1,M$
	L1+P%<3\W63+F%=63_a1-@:Weg@74OGAN_4m0JP:60K:X=3)hUk3\iNQ2)6[93'&`I+s;,=E(s%f6u
	QRXD.RU,8OP]cF`hD/3\rcc7Q3"[2`F&j3CPVV0g[`V0L7Za0etFB1c\#_7Nrt"@;nq83_=41FCB&s
	AP#9Q,'A$BA3)_*1,V!Z779($6TIRh0el!P2_[NW5qt,K3&EWb2+Ac4E+j03Df]T1E&p@)Ci=>gDe*
	EB+u:DcE+j03Df]T1E&pQX6VqfAAnc'm4X+rF7m\=i77/sf3ArcI1+k:*+E2"4FDl56Df@a.BleB7E
	d9el+s:uAAnF)"EbT*&FCB9*Df.]^0d7`^BkCs<=Ai^ODesQ<Bl@lP+u_820JG160eb:80HqW]BkCs
	<=]/gPDesQ<Bl@lP+u_820JG160eb:80HqW]BkCs<;IsofCisi6Df/QmBllK^1*Ri_BkCs<:186YG%
	F'UB4Z.+4X)X=2CpU@2_6^A3%QgB3@lpD1+Y1>1b:C@2_6^D1b:L?0J#(;0e>(>1+Y1?1Ft:A2CpX<
	0e>+83%Qj?3@m$C3@m$D1+Y482CpUB0J"t<0e>(=1+Y482(UO<2(UO>1c$mK5r:na6S^MV5rU\g0KC
	mE2+0bs0JbFB1H%'Y3B9J]+s:HABkBD&Bm=3*=@?k?ASuR'Df.]^0eb@,+D#e3Ai`b&G\(\o6tpLLD
	KBN1DET1"1a4&RG\LbN6Z6dZE`6pc@q@eI0d7`OG\LbN:186YG%F'UB4Z.+4X)[?3&WTE1b^pJ0J#%
	73ArTC1H.$D0e>+>0etL81b^pJ1+Y793ArZE1H.0G0J#%73Ar]F1H%3N2_6aC3&W`I1G^jD1b:F=1c
	%'A1Gh'K0J#":3&NHB1Gh'K2(UO?3&NTF1H.*K2_6aD1H.9E1H.*K3@lsF1H7'>1H.*L0e>+>1H7-@
	1H.*L1Ft=@1H73B1H.*L2(UOB1H79D1H.*M2Cp[>1cR9B1bggH1b:I<1cRBE1bggH2_6d?1cRHG1bg
	gI1+Y7:1c[?C1bggI2(UR=2_m?D1bgpE3@m!A2`!-=1bh!M2(UR=3B/oJ1bh!M2_6d?3B/uL1bh!M3
	@m!A3B8cE1bh!N0e>.93B8iG1bh!N1Ft@;3B8oI1bh!N2(UR=3B8uK1bpa>2CpO51+Y752(UX:2_6p
	>3@lm=/28k10et:71Ft7;/29"50fCR;2_6[C/2An11,:C91Ft:</2B(61,^[=2_6^D/2JtA3(62'7R
	T0o1c@6G3&3?J1ds5g6pisi75dS(75Q\b,!I,3G[YPc9fb[REbT].A4CTXD'3nA;IsH$Bl8!6@;]Rd
	8OP]cF`hD/3\rQ]7Q3"[2`F&j3CPVV0g[`V0L7Za0etFB1c\#_7NrsrFAc[^3b3/=F_t]-F@ek`,'A
	$BA3)M&7Rf<j2`EZ^6TIRh0el!P2_[NW5qt,K3&EWb2+AcC4s2s@Eb&cC6tLFLEbTK7Bl@lQ+?V;tA
	7dl#6q0?_4>1q?G\qD:ATV?E+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+?Vl5E+*6lATT&+DIbmSG9T78s5FGh8OGjP:f:(Y8PDPQ!<E0#$qO'+DJoRf!!$kRFE1
	8L66KB5=s+'q!!3-,!!WEX!!$G;F)XiP7T9?f!!#SZ6QgGJ7m[1Uzzzp=93Ezdk+*e+<UXazzzzzzz
	zzzz!"i^[Ec_9]!Diar!&J.sF(51M!JCFQ!,Qk$E-)'[!Up'h!#/mXE-)'[!X&K'!#0HU=]te*!Z1n
	;!#0'J=]te*!\=<O!#/mE=]te*!^H_c!#/s\DI`_I!`T."!,uIcA7PZ?!lP'=!/Pf@ARkc@"&&[p!/
	>Z2ATn+S"4R;N!$lB'D.rtM"8Dir!#09]@<2DK":P81!$lYt@qYiB">BfU!"<mI;F:Ea"?ZYa#Rk?F
	;F:Ea"?ZYa#Rk0A;F:Ea"?ZYa#RkfdG]Woc!!#B)E-ZJ<B4uB0-t=\K0f_6R+@p'fCh7^1/PokcCLM
	6o+@C'aE+*X0!!$P@F(51Mz!"s?N7m\=i77/sf3ArcI1+k9]zz!!!XQ;Fa%r8OZ!)0f_-M/M\q5zzz
	zzzzzzzzz!!$,(=s*eFzo2,Jg!!!!"(<fl`=s*eFzzz!!$,(=s*eFzDk[433;!7O"-?Vf=s*eFz@[R
	2r[tOe^(tr(p=s*eFz,bP,;%tjo_[a/JqF(51Mz!#A-p6Qg&aFDs8o06_Va/nnm,/n8Ppzz!!!d+77
	/22FEDI_0/%NnG:mT@@kM8)zzzzzzzzzzz!!$P@F(51Mz!%pi36Qe9A3ArcI1+k:(6tKt=F_l.B;Fa
	%r@rH1%F`JUGE+*6f+>"^W;Fa%Rzz!!"WC77/1U0f_-M/M\q5+@KdQ@<HC.+At]r+Cf>+Dfp(CF)YP
	tAKWQIF&GLpzzzzz!!$P@F(51Mz!%_#ZAn?!oDI[6#<bZ,hBl7Q+6Z6jQBln'-DBNY2+A#!h2DI3M2
	D$[:0`V1Rzz/5g%kATD@"@q?c`Bk;L&DJ((ZDf0*"FD5Z2+DG^98OZ!)0f_-M/M\q5zzzzzz!!%1VA
	Tn+S!!!!4V#C?.?S2<icP-?]mE>P5'+4dB>b1oq!!-2)=s*eF!!!!m$!%%&!!!"#+6RKP@<2DKz!!*
	'"zzzz!fm<]!!74UB-70S!!#Aa<$5[nEcqE_z"98E%!!N?0!"T&D!#YbX!$_Il!%e1+!&jm>!'gNQ!
	(m5e!)rr$!+#Y8!,)@L!-/'`!.4ct!/:K3!0@2G!1En[!2KUo!3Q=-!4Ms@!5SZT!6YAh!7_)(!8mk
	=!:'XS!;6Ei!<E3+!=]&C!>tn[!@7as!AX[8!BpNQ!DEMl!EfG2!G;FN!HeEj!J:E2!KmJP!MKOn!O
	2[9!PnfY!RUr$!T=(D!V-9f!WrK4!Yb\V![[t%!]U6I!_WSo!aPk?!c\9f!e^W8!gj%`!iuI3!l4r]
	!n@A1!p]p\!rrE2!u:t^""aU7"%*/d"'Pe="*+Km",[2H"/5n#"1eTT"4IA1"7--c"9nuB"<[h!"?Q
	`W"B>S7"E=Qn"H3JP"K2I3"N1Gl"Q9LQ"TAQ6"WR[r"ZcfY"]tq@"a:-)"dT=h"gnNQ"k<e<"ni-)"
	r7Cj"uc`W#$D.F#($Q5#+Yt%#/CGj#3,p\#6tJO#:g$B#>YS5#BU3*#FPgu#JUMl#NZ3c#R^n[#VlZ
	T#[.LO#_E>J#c\0E#gs"A#l=o>#pfm=#u:k<$$ci<$)@m=$-rq>$2Y&A$7?0D$<.@I$@rPO$Ea`T$J
	Z![$O[=d$TSSl$Y^!!$^_=+$ci_7$i(2D$n;ZQ$sX3`%#tao%)<;)%.ao;%42NL%9a3_%?:ms%DrY3
	%JUDH%PA5_%V-'!%\!s:%akjT%g`am%m^_4%sebP&$lem&*si6&1.rU&7H-!&=X6A&D%Kd&JGa2&Pj
	!U&W@=%&]kXK&dK$r&k*FD&qgmm'#P@B'*Amm'13FC'8$so'?(XH'F#7!'M0!R'T3[-'[@E^'bV6<'
	il&o'q5rO(#Ti0(+'eg(2ObI(:"_,(A\gf(I8jK(Prs2(Xa,o(`O;W(hFPA(p=e,)#>*m)+>EY)3Gf
	G);Q26)CcY&)L!*k)T<W])\a5Q)e0hE)mUF:*!.*0*)[c'*2=Lt*;(<n*Ch,h*LRqc*UFg_*^Cc]*g
	@_[*pFa[+$Lc\+-[k^+6js`+@.,d+IF:i+RgNo+\3c!+e^()+o<H2,#oh=,-N3H,75YT,A&0b,Jk\p
	,Te:+,^^l<,haON,rd2a-'opu-2/`6-<DOL-FY>c-Q"4&-[I/@-ep*Z-pK,".&&->.0_4\.;LB'.F9
	OG.Q&\h.[qp6.fq4Z.qpN)/(#mO/3,8!/>=]I/IX3s/Tr_H/`A;t/kdmL0"3J$0-i2S09Ip.0E*X_0
	PiG=0\\;p0hO0P0tK+11+G%h17L&K1CZ-01Oh3j1\!:P1hAM81tXZ!2,,r`28V6L2E*O72Qet&2^C=
	i2k2hY3#">K3/fi<3<_E03Ia'%3Vb]o3cmEg3q#-^4)6pX46SdS4CpXN4QARK4^gLI4lALH5%$RI52
	\XK5@HdN5N4pQ5\*-W5j(E^6#&]e61.&n6?5E#6MEi.6[_>;6j#hI7#FCX71r$h7@H[%7Nt<77]T#J
	7l<e`8&.Y!84uL98CpER8Rk>k8ao>28ps=M9+4Hl9:AN59I`_V9Y*q"9hJ-D:#&Ji:2Wh9:B40^:Qn
	T1:a](Z:qKR/;,C,Z;<Cb2;LDB_;\N):;lWdi<'jQF<81D$<HV<Y<Y&59<iK-o=%$,Q=5[16=FF;p=
	W1FW=h%W?>#nh(>4l)g>ErFS>W#c@>h31.?$KYs?5d-d?G0\V?X[<J?j0q>@&dW4@8C=+@J+)$@[po
	s@maamA*[YjA<^WhANaUfA`mYgAs-ciB0BmkBBa(oBU3>uBgZU'C%5q/C7f88CJS`DC]A3PCp.[]D.
	%4kDA$i&DT$H7Dg63JE%>m^E8Y^sEKtP5E_CGMErg>fF1?<+FDu?GFXVBdFl@L-G+3[MG?/poGS,1<
	Gg(F_H&6h0H:E4WHN\\*Hbt.RI"?\(I6i:TIK=n,I_pRZItW=5J4G-gJI6sDJ^&d#Js(`XK3*]:KH5
	_rK]@bVKr]q<L2r%#LHC9`L]iNJLsCi5M4'5"MI_UeM_L'TMu8NDN67,7NL5_*Nb4<sO#E&jO9UeaO
	OfOYOf4ETP'W;OP>.7LPTZ3JPk:5JQ-#=KQCjKNQZ\YQQqWmWR3\2^RJ`LeRamloS$/>%S;Ed1SRe;
	>Sj8mMT,jP^TDG3pT\,r.Tsg[BU6_PYUNWEpUfO;3V)Y<NVAc=iVZ!E1Vr4LOW5PYoWMum;WfO1^X*
	(K-XB_jRX[K;$Xt?fMY84="YQ1nMYj/K$Z.?3RZGNq-Z`^Y][%+N;[>MBn[X#=N[qN8/\66>h\OsEL
	\i[L2].U^n]HOqW]bS5A^'_T-^Akro^\,B]_!JmM_;iC>_V;t1_plV%`6Q=p`Q6%g`l#h_a1o\YaLo
	VUagoPRb.#PPbI5VPbdG\Qc*bhTcF2%Xca_=^d(7UedD"$nd_XC#e&Km/eB?B;e^;rJf%ASZfAP:lf
	]_")g%!d>gABWTg]cJjh%8D.hAkCHh^RHdi&9N,iC)YKi`"jkj(%-8jE'D[jb2b*k*G0PkGdZ#ke-.
	Ll-S^"lK.>Nlhg%'m1J`UmO7M1mm-?cn6#2AnT+1"nr3/Xo;D4;oYU8tp"oCZpA=TAp_ik*q)J2jqH
	*OVqfhrCr0[F3rOVu$rnRNjs8W,e!"M;*Ddm8XA3^+p!!3,S!/(=Q!<E3%!<E3%!<E3%!<E3%!<E3%
	!<E3%!<E3%!<E3%!<E3%!<E3%!<E6'!WiE)!WiE)!WrN,!s8W-!s8W+!<E3%!<E3%!<E6'!<N<)!s8
	W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-s1eUH#QQ%KAci&G!!3`5!
	tbS6h#IQX%KF?IU&Y/n"p+l-zz!!!60"pG,9!t#)1!"/f-!!WN+!<E0#z!!!!'"U"o4!XJf5!"')F!
	!30'"9AT,!WrN,!X8sR!<N?+&HrdO+U8Z)!!k:n5r'Z"#uO#)@3dWF;K77)@Z_s(Ts=)61i`p@_9k+
	fiDVXdnWKV7<-(Jt2b.@+<E<0>ZGP&LnmmApPD!MBZbt8P.6(r2FXfC484cEU=^#HOBkhg8G^4UhL5
	1SAMNjBlQ^F20UnsrdW2Zf([C3QS\[o_u`lH0Bb1+tmf@\d1jQ5OekiqC)p%J.Tq>(['!W`B)"9\f1
	"9\i3"pJiE!Ws#;+VFr5"ooh\5u@kB@2*\e6@gAD'iL`7(,H9%,f.kqEpsn(Ji"d:;]'"4nY3<92&T
	@O7:[bQF+]ZGFMcJcnl97D<]>\cUU.kej7=]<Pbb\)eE$7eV7":mjn1#l=(XF8L6e^F`n';GB6T,tV
	mj^ukP%MLBR#?#W49q$kkI/0=_W/<RAma=g$/;^3_ERjHA\/k]#ralqZ#7L$j-M1!YGMH!'^J9j8$%
	]!&l"n8Lh1Ca$5U]@gUlH1]&[&S!Oe?c\f:0qk\W<VQR*A%qkU9@d</t3=!XW:t.pd^qil</lCkGRV
	J9`=:<>7j;pSC4i#nR!-`;0Nm]U"C"O&\+Z/cbS[5!j"c,#Z6SOQ!bP*Ytp;<6XhY3qu.og#38.R6"
	J?K+neC6=R!&G1a<6iP*I";#9Q,mi=Q2^h,HZS7+G:tfG21&[d]/)GGW5F&-Z:`d*[FDflUB/p_/8P
	A^$F&MPb_eNHbh$p)S@S"$[sYdh,O>`Hh>Sj@lQo?L+@Jgb#*OC:n`uXVoCnFB9:N(pCJJT1A_QEk7
	q\\7"6V*B1EW3]4VVl!0#r+IrBX8JmZk!B094`>8J7naFEE!$hL/=aVQ#NRNd5A_2JWa*==h1rlB5g
	k(KX((5rmd"ZM*U-[s0NN*l\a]`GUD8+#)*)Oo6CmW'(`5Qb8pTCj2#fBC;Y[GepCi]9R8r]g5e#RN
	LaTI0el`l2L`7O6<.h]3DXc-cL#d)7_KVcYW:j>7\"8CZVM7j00DY?0@KPVo<MdO7EL9&PnGA1IJ^Q
	j@WSbf1/Jp$!efQjQV_rZ7Cbql$G@1aYB@PA@RfgQO<fIJFR"pLP_f1A1%FD#"Vck81i3'B799VpC.
	>S]j&NmbmLkQPMo1?'-<lN>]DK]fVqn.+a+=o@)"l$L\Z.9"b1]=N#<YZREK07fj.8$HZE;4h>On;f
	igGZX<u3-R[m8bkn]kFC<WPMASQTn/t.*Q=W&H==?!=3lUif-q2+^dk2(!REr:d_?/sO`0-thZHtVX
	pdCMC!X>]K%8"*%tG3+p)A8rR#ZSHO<19EuOiNB5==]Dab1f9Nh4kI7nMpXURDUp`(gD`JkC@4N6TD
	R`Wl>o%.GR<d[m_?F3I_-]376k:^a=7;Wk5P>2]!3?4T?_B;-c'*7LW4NZp"qte^*s!]&;$O!mCpHZ
	eF*>:O<%na@gj)VLTC:o0i@o0hEqTD)3qZ(jJp9QC+"n%\q3EMcZSZbDl!1tco&QW@ek?UB^Km2^0[
	p)dJfEfXeXWjFi%P@ED<qm)5@pc2)[</91[G;aQcaRZpJ_Ap[5`GQsVI1S+k.!Slsjf-V&),oC1f"&
	BIg:Z`*S'AG\mX:N#+N'%=\-GQ.N[bPgDP'NqBlbmjtr<9*)8NP'DE)Tb:*+*I"P(G4"g5<2ngqho6
	#2qI-+R-uWg=de)M\Z.N&2+)G&/;?r>)Nt*'+fT+h2^dLopI"[DI,atJn8iVJB6jZn2m2Au39NcTHu
	e\XbI[R(W-9"7,`53QAfd"TAMQ?FXXg<,'!Tu)]'9;1KJ^'DOm7Mrf=K^$B`A&o/r/>6b?)*$QnHk?
	Hb2))kpF5_T$mDi9j<Vsrr?^+QKR%M7qD#SKp0\PWBrLd@rlRYD,id_804@.]//'@0qJ]MA+s<qs3N
	AT?'/@K*Kf2#0)&XeA[cU#IbNYLO&(n:G+)Z3<lLN,gYFfoEUudrO^^5X=^\LVd3,Z1!Jo6$^4ptfY
	hNt8hX$:9O/]ihWKk-<PMdNl`Y8s-q=Vke]Y?A^F)SXZk2'W5]/GuO=Hgp+$Hi#61):Vs*F+*bhY8b
	0^27]clcJQXq78IR6X\t5`X?Q?g8)Yf:o6T?O3(q410NlnPrm0RVMT"3NG7@CNQp:<[jtpkG!4F3]t
	1r>fISqj/g.]-*`4(gFJC=>7T8#88M!m>L7UOYp*\K5S)*J@S*p$!lKZg_c/O`s&4Tr'/$X@7_(MI4
	"BLT-lJXuQjbL\`OhVJXC9efEDLZs.eC9q7IqrlqC2uC.=Pi0Cgf4,W+g\4\?4:uA[-lkR1X0_4'QR
	!\S>jghUg&!!K=gBK>=q6(o?_q(8'O,Gb:<,hpES<CGkT9o-JbaeVd\+D]RUcNqKRYQJWHUW/T@lJH
	D`EX4!/A.D7Pk(W253P4//1A&XK.WB^'7^+HSrt7R76Lah&!?d3=1N]tK@`9++J:cL5\aLcq$AD&eF
	X'l[-5fQ$+rdi<qQmTW`TB6OL&2]G7i@X@*g+R))(?YDIYd$qU1@;l/GT39L#gXETPeU*=WiO?f9PO
	[tZOIf(0b'3/Qjl>cHgTF+DM75D7_/4%t-BJa6MX,+Rn!I>)hKGIIFP>EJD6>.A^:kPOYNJZm$aadZ
	]'VRkk^nY4D]GEr#nT6a.eJ$N!-CEUq-3E6B(VDUcK=iogs0>PIWI6-gJ:)&l!iC,3fK:[FB'1s9SF
	KAWN-:G7tORBL&lE.6#T4U*3Y`ZaueYpa2H,=:7jNVqWbX?VQQmXCjO.T]3^@0nk*sB8rUo:/M/f'-
	Ee%'9dj1;85rsR](]0.fQ:)\N-08bE@b7/H;&'QVMD40T2J\:ej.#)W.e6d:_'S'>PpY9\ju*_P^C/
	"nP3HQ?2S`R3l<-3b*1oBAiNda,Enkdp76*nbOm,8.k2mtWqe0*V9cf(RYll-d):;*?Kf2lThU^*)g
	_Yp_aH95bT>W=OuUjaa$l05;IZDG.Fb*UV+Q8)$X>9np[5`G_I"[?Om_bn\-:[F(3eV*Z"iJNdB`^p
	fMc4`4,517;5^"hC2S>W0j#;?RIr8,Y(iGI_UUBH+*I"ZlKm?'S\X@Y>6D0S`c#JX*";Dcj=n34(KZ
	=G3#^<uJBLAe'GVZ*.s2sk1T)YF#]G1Xh%X^gg"VF`pIB8seg@+Z_0iTT]t`'Dk6.qh)dBuOQacZ)F
	EPn"ScCUhPM>klX17A%ORajko)<KEFmd$Ed38C:'9ML=Q&b.2\<79p8n[mB8+,)F=2d<4l0;!pSEnt
	l2,$KZ.6iXUf5Np-,ZY^^"S@&q%DiRlgV-LQh8:^FUeUE)WuD0)C;7!5\LHsl_f92SkI=REE=jJ*nk
	PJJ8Ne@h*huBV^7^N>[\Wp'K]m!%=0I'P0Pt,*rrCX6Gm<!r[W0'cpj7NTo-V)9./s:n2#dRKEB;77
	\g=Q.m6'ke9&3_O!7eRBl?qXkDa+rM/4$d,lC+H&j9KV!F]aU#<:(UZI9m9b/?iiWPI#IDnDl8_#[&
	E%2E`:garB$4eHp4:EZ_Yng!-g,mN=FFZrA`hO:]Z(`Y8P;T15iYo]qO6hf8VVjR,TkkAH`XNq-/K[
	>_-e;8RK!U+,\3):.eNXW'?SY\CQbDEPD\@^$G^*RA#]LBiT(Vnq;"YKBl,N\:tQY4>NMnF4]\VcI8
	)"Ahn,nq@O\V7!q\cf)m$?-dS+:^ai5-DmY(V"N#-ZH)6SgT0P?&gWV$E>f06#oJdC&)g]G;<S6Nrr
	>geG3\<4[*e<q3fJ2ga?>6_5%&2oWaTR98$"e8ZZkF&VG`aW?Sst9lpl4DQ1Lj=)/maeBYB=Ek$DKO
	+>natg"fH([#E.W0LoDYja/G"hHK%>^2Z`;Z@XtUN01-&q%.k`TB'p^>5nTb0@lB(okWm]gj<:U@q`
	s@f@^s1]ksD4j6+J&5D;1HAG`j?.4I25FU[rTA#qTHM`]U=\3rY:n9qPEn]=Ejnsq-OOHPM@)Zh(S:
	EKJd]$ZH!+3Y-8b:`\L?0-b*9Li"?F82aTHoks]<DQn-?83/%0HJ9HX6Ae]-u6:uD.WjGiJ9sc`tWj
	^A2?gF^"%IP2cjm1[mU(mQBGhFA`$/N!^+ebRM4C85-W0'\\l*L[&m6nN)WC`Sn+BnoahYFpI9(1DE
	eqLlmd4+3d*F(M1HdtG@i-eqXJNCn(i>oU^(sbT29o\f_H#umbYn9rG/^DV.6,X\ahK&`DKV_q2BJL
	NC:;shHm"96UsQRohunE2Eq)k]$hJkXT&8VNi;ceT@pi'WHuEt0%oPa``f*p[^Tg22$X!8eCCp\L\P
	-r(7cMEDsXehq-([A;'fcE/5G\41-.Y2pJ`QjGoberoXW1.9iF^91qBd=h%I^b%"?h-+gu]&1/j9aD
	AdYjE8k8+-e._>IXV*sFoTmp^ZT&'YIbHdFtW[f^%%S#k'InQG#VFdO-I=>Z*@;sXnfFb[O3(iM#RH
	e$a+ZU3[q*g:+nK6EO;rflpa/tae_]?=__&RSns3cbLtcpj5d3&ff-dgQS)WGTJ[Q4+9LJ@0sCbu;3
	=,d#m<.JHfaVL]_[r,c-*[7Rr%-4V2/-^KG)-WGR5(JiNm]hb`"e1QWl%oncQA0%c6$k]b0)ThZL0r
	%[nqLp5>u\k$)cODQ6BUX,7=/kD':L8L0Q8!k+gIN+8G:RTS2l]:mEgYiUm^O)Nj6Xd8&W,d]>S-4!
	<rUuVSj#mZ"_TFoa$mG"g#EdM\N0Y4sO0'<7JM!Bf)RXsN0!FQai&d&`m9%h@u3+R;C1j%*$-'h-0_
	$iZt,dPMX_%7A.R@;pdPO/7<U6fcMe7>'L#H?V]rI^ha\&1%Q,b!h9jkS'Uj\en::K@Ys\%e5qDLXK
	LaMU_9.mLFj(Z9?GT&]87+in+IHhRb4=Gra8*f\BXKsshIh%?F/jR[IEpt`DKo/f_?rr?n/-9$:\mf
	qSPhg*C-Xa%2?'<."+d+11=JI[LodA14)=aNsY6<iEjY@p(g]3F#bAEHN3K$#DN'J:g[Y-]VFUfCo'
	g_Hd55c>(\D0u39J!GY6XQcmoh;9&'HXCT:LA8<fWj]ZBm5\a5DJ`.il"Oh9d,t<kelO>Y*!-'>E&9
	GA<k=u!-7:H9Yt/;uXf[k.&$3D/8F0CQm@K1%Wp5S1QgC;pn*[QbY+j3Y9%M.-^N4P#:9Kb-IS,59M
	4DDFV522mlD0DN;)UKZ8MGB8Sd?"T](\MQk2/8\Gj[]6m,#:4cau,ZI]9BSqknSuneqDFR]LOP<981
	H>+3*`I&#o>8JiZJ;ucpmm_.'+j2XO]rrC;]f:qInN*A'4IrCdERP`h\[S"BerC)OBQc@e'\MnXN'b
	jkNDpY.kA"pTso$Tu#oG#cuCd$C]hZ!Q`r0t8&&cAnho&X,aH"gs3qPip3kTLndr1a0>(@b1^FS(PQ
	&_GHLg3DHo;4PG6H6pG8NCS?mYB?X2b"dc]+,PER5>;!?g<J3^Vb9.q[^QA]I1KD'?8dC(&9!SlhGm
	EO;sk':6Kj_?I\b7t,]QUc9b`JFrp/AESZgn`n_Dg!G&OuS-aNVV3J=,3?5G!A>IQ?!-c=ul6N+&0j
	XTO<`lBK3b$ditG4eI5\bGO*cs;^6h&Du-mJacO4*P`6Y0,UDMi68ZENub@gT,gAgm#8U8%3ZU-9:W
	SY+kA1j\hD1-#%"X3747CYB@6C:]CD=me,kKj^n#>Q118%EIT[7Pe1_2CVRF1Ru026mpC4H<-H:&mA
	tfX>Rp2N/g7^LILHEM9V,WKG`'bn;ah)>EOb4J)r5kEs3olchn&Ph4J1g0rr?UpfH9hSTD5t=rr?SN
	rr?Wbrr<+85O>0F!:8bG!)`ar2Xg!^aFEVW^[bak5NJ7&rrBP.!*9Z*c@>ioEFAeHQ$\)^!0X7rrmU
	gNHDrQMJ+G`[YPjVsr*OH9p@hAYOe;+u0DH.Z!)6hja8Tu@p+5C!q'X;a!%X*@q.P7dq=GNb?hZ`Kq
	,=g'!6[V(Dp,>ahbO1Obc'j"q3Kq.jmCt$PJ?]=5N:9hrr=h;rli.Qf727%O)V!q=$fElFmcY?rr@`
	uJ&en"^[9W[nRnj$!4&3r!4(8W!'+Ed!+aX[!*4%6>Q4\m\+f=(erAE#r]eV>r-VlAE0("@'E2N$q8
	*(2*s_b6hs14Ak2$"5YBBL&r_GcP7GBKph<Fq>""+$J[q^E:JH#V"FC4QWrrBfdrr>,fq7CQoleP`_
	^NJtErrDl.rrC^fDpS<)fD52kmH$S+:B(=`%_)AnrL\T2WW)sfrr(H[q1nZ>r-t,!q"T?uk5PGT:S7
	5%5L'f7pV6(Orr>pr!&hOfYB@Ilr$K2X/3Dnkh.clh(-'(qRD8*u5L7`,fgYo@ft[Oe.fTM?HJ\VP]
	%Z?)](]S3f`
	ASCII85End
End




// JPEG: width= 137, height= 46
Picture PauseB
	ASCII85Begin
	s4IA0!"_al8O`[\!W`9l!([(is5=8t7<iNY!!#_f!%IsK!!iQ0!>5A7!!!!"!!*'"!?(qA!!!!"!!!
	".!?2"B!!!!"!!!"6!@RpM!!!!"!!3-#!AOQU!!!!=!!!">!AXWV!!!!5!!!"ZLM6_k!!!!"!!!"p!
	!!#G!"/XS!!"AX!"/XS!!"AX6"FnCAKXf_Dffo=BQ%i46W5c`=(uP_Dg-7&1,(F;3\WNS0fU:12``]
	P3]/Ym!!!!$TE,#p!!!!"!!*'"TE5)r!!!!"!!!"2TE>/s!!!!"!!!!Cz!!!!'!<W<(!!!!"!!WE'!
	?(qA!!!!"!!!$@!?2"B!!!!"!!!$H!@RpM!!!!"!!3-#!W`9(!!!!"!!!$P!Wi?)!!!!"!!!9[z!!!
	!i!!!!"!!!!i!!!!"s4IA0!"_al8O`[\!WW3k!([(is6Tdp6"FnCAR@f!!!3,f!"M;*Ddm8XA:OX[!
	!3,S!/(=\#RC\B#Rh"G$kWjS$P=*a$k*X](_[Pt',)2p$k*OQ$k*^V$k*OQ$k*OQ$k*OQ$k*OQ$k*O
	Q$k*OQ$k*OF%1<OQ%LisZ%M0<a%Ls0e%LrsY'G1`^$k*OV&I]'V$k*OV$k*OQ$k*OQ$k*OQ$k*OQ$k
	*OQ$k*OQ$k*OQs1eUH#QQ%KAci&X!!3`5!tbS6h#IQX#QM^C56(Za"T\W)!<E3$z!!!*$!<NB-"pYD
	?$4?k7!<iK)!<E3%z!!!!"!!36*"U52;#mq%O!!*3'!s/T,"U>5;"To/h!<<05!sBb[0a0j?@1si)J
	MIEDOeK$H,:""%_.#2WEe;\+#:5O3nDWnIF#=`-Z@aJlP>l']_P;32(Xc=CAb*0\_p`bgo0t*lUkQ1
	@`73l?V7":mjn2YdG(u<[[`6n\p,>KCB6T,tVmj^ukP#Pg!WiB("9\f0"U52:"pHjb!!3`7+YaT45u
	D'1+qk,8JWUY?YsK\O;UOti,\#_QJs&K"'k;;AnKeATU9]CV-8iZg7$CTF(M#s72KWNio!="edrj^B
	7[0^&[$ASZjRf:V`RX)C<b?N0QDV+1f&lZR2b-q^GDDN_\&\O&!"8r1!!3`7&HG#qli+?kDZ,Sue*n
	40NiRMN26Qcj0`-9FpAY-N<IT8QZ<bs@K?]r_0&4LZ;TCbSL[nT.c'10dgJMi]ZZ:)4Xf$<Pp:AUHC
	?K1lA,.[PXBXK_T`3Q`aL#=<q?/[NCs.Xjmap[)**BK*`[<GH1i/1%ic9='q6OWlYuh(H"2i*qo6R!
	J\Ao0L__tr9C*,g6;4m^6R_"!L+'u8<b,_C^kDO,cMXg;r2"*WZ<L:-3n,1qprr?@)!(_m+cqW<tcE
	HQM?uq$+F<QETV=WcYI\B2R<p#P2Y\e@SpJ.;2=[[p.&rGSO3.4FRB$H',j1ZCk+:7&;rrCigZ1WmU
	iUe1_F#$%.S:*MG)t^59r>OAh!.TLn2D7#S*Fl9qLRU*jT1r)W3*>TkFgQBX@;V?\f:DpA>@O^Q=NK
	fo@U55Xo@%]INN[]irMLe<!%u9sQ)2j=GO8_0bWf%S%Vq[!JL2>o(1@rQZ8HX9_+eh?/$.?8qF4+br
	d,gS?_dR@lQ$bl[k>_o*h>#q/3C&;^V<4_pY!%S%H$m@CKh>7TucN0]fk%1>D<t`J[/SH%F"P6pAY+
	AF#imZZJ*M=dcW<Hhe=Yk.J8hR3dKu)[70K[&#JUgoBl21IeDl0?gEJMlZP6r=T4f=-hLi&D>"Lt[a
	FQEGPWe=mDXoP<4VrXrbZO;B/r=-O8'a0UTsh!WV40nX)sD#el:9*mV<d",je/t=5[!NDm>&O5LMZ\
	48ei>4^5_fSTgi2++ogT.W<bQaE+G^_tRBJQdbnJ>e1pDWeVCii8D'lHZOB4o%5PH2a?'/gp4YuoVV
	9)k@#;m;6d<9KL(AhDsX9tYc$fq"oeR'YNrSqpHKED^C1^f[lC\%<9Jb+F7!W)rrCFFPPu";k#>npM
	f)!G:U@!#g21b;qQ-kIRm4..>i5D;8La\dbH6fDTOPZ+ijmQ@4<7@k;nqT6F8dh"];OhA`Xhp"9C'(
	;I#@K3lTI;(FZ74EZ0MP+Y6/^sl!X@)EuXtpD"mr0LAq6E\En+0Ru^j-#:]#>i>-`8+?4U1C=*/s_B
	K6u'n>/PS-PD+AjJ-u7OS)ZJ((#Sir9!%hsbji!7ec%3>R6P:N[HG/GelWL>2',,E0?r`%[fA/,oTM
	riG71ABAO;FaY]ooo,G,GTTR#(#PWnrep/^ZCgp1m4aC>8*5qq+0f_bb]1WIjG8XV:3I[1\937bD)m
	lf2S&9^V<tDBp_)i*U"R'D$O?S=TD-marGMJ4qbIQgH>?_kD?G&Z?dWZRJ\)PE1[)6r48^+kf3W:;N
	6E9IBm#egZk=B^RdFNE&E`umWueT=Z;5[@$356t5GT1ne^hcka8Z.<??Ocb"$\H]l[S3TX&[^HXZ7/
	-eWk9&(MR`gGn,&kh>,2V56n.[SABp.lSi/1qF?t,=?kbbD>_ER!8s.cP^&S(MgoH'q@3H)@boeg/3
	-pab\FnJBC"41rYiQJ[]`)3eD?eCWunQ)*^)lU*rc5Ic`-WQqfhWrd=-dp[oC/gl$7bhl4!;?62!E:
	Ve@12ENK*,l@1lskG5$(]$ZS?]a/kQO8=C;Dm.LAon#Ed/,ZSUh;);8gO4>`AR/m>Iktl39:>`KIVK
	>fH.i"'e9/<i[uf0">:k+=#.;3;,r(0ZQ6+:>!8RSS-HgD<J(pA+Uq:G-W4D]\<HH125HX+WZg!g'=
	^>&`nV54NO/i/>he2P0^\f*d,cC[ioi:(f?iL,f97Q$jJ*e'Ehu*u_>4V<Lnbg48:R&PR6iNQ^oM;8
	Ije([:\`*Pg7&TjqT\nlrRcF;Vr#b>[QI88^b`#mZohsb``_Z2+J'"41g:um#rrAbm!$ul18iB29U\
	[?,QTt2Aq4I'S!$Q\beF32K^\L*dqoetKNrK+K^ZcQ[.3thVV2=l[r^F<m#QE7<R/[0:^Za:p#pcFG
	ao6_G9:u)Ur6P($OM*1B>5nR]Du?$qJ*eo]ci":O6LaW1;tX$]j]%CAs4RG>%[Kq)Dffo=BQ%i41G1
	?]3'p22"=4$J!!!!1zzzz3'p22">9`T!!!!k$3:/-8,rVi8,rVizzciO1I5QUoczz(]sa<A-)`2!!0
	k;!!'5+!!!$"%jqAXCi"63zz!!"uF8PK<Sz!"]-$!!!!"!!3-k!!!!"!!5,H8PK=7z!"Ju/zz5C`_6
	3'p22":Y>2!!!!%!!!"D3'p22";q1>!!!!%!!!!?3'p22"7lKm!!!!*zz!<>)G8PK<pz!!*'"3'p22
	-P-7X!!!!+!!*'"z!!5,H8PK<[z!([)CAnD#D!,Q7Z!!WE'!!!!"!&%qr!!*(nR@4*[z!!*'T!!!!"
	!*T@&!!WE'!!!!"!&X`V!!*'O!!!!'z!!,&G8PK<^z!,qo<s8W-!s8W-!s8W-!s8W-!s8W-!s8N2bz
	s8W-!s8W-!s8W-!s8W-!s8W-!s8N2bzs8W-!s8W-!s8W-!s8W-!s8W-!s8N2bzs8W-!s8W-!s8W-!s
	8W-!s8W-!s8N2b!!"uF8PK<fz!!3-&3'p22"9JQ'!!!!)zz3'p22">BfU!!!!%!<E3%3'p22">'TR!
	!!!'!!*'"!!G8J8PK<nz!"],1!!*'"!^H_c!^H_c!!"uF8PK=/z!!E9%!!"uF8PK=+z"$Zbc!!WE'z
	z!$VCC!+l32!!R!bBEsol!%e1*!!!!"zzzz!!!!"zz!!!"2!!!!Czzzz!<<*"zzzz&-)\1!<<*"!!!
	":F_kjo!!!'#!!!44Dfor.F&-7[@fQK/!<<*"!!!!s@rsF*!!!-%!!!!uDf?h8Df01fz!!!!mAS-%#
	Df01fz!!!!cFDl#4Df01f!!"2C!!!!sB4uC'Df01f!!$U2!!!4ECh[BjF&m*NErZ1?!Dd0>@fQK/!<
	<*"!!!1DCh[Bj!!!!3!!!!(F)5Q#AP#:+Df01fz!!!7:Ec6)>8ORB5DJ&qLz!![@^BkM-tASuX-!!!
	!-78n#:@qAGVBkM-t!!!!.@<H[17qHRLEaa'$A,lT0!*"5_AS#b%D#aP9$:Rm0Bk(^RH#R<p!!!!jD
	.ask!!!44Dfor.F&-7[@fQK/!<<*"!!!!s@rsF*!!!-%!!!!uDf?h8Df01fz!!!!mAS-%#Df01fz!!
	!!cFDl#4Df01f!!"2C!!!!sB4uC'Df01f!!$U2!!!+DEbn]D=B#8#!!*'"zDKTc3<(0ng!!!!"z!!#
	`7B4Y%2=B#8#!!*'"!!!!'@;L$b@:rP.=B#8#!!*'"!!!!/@qBIm<+U;r8TRF%9h]#7DeoFS!!!:7A
	Sc0^AU&;r79ELh!!!$"z$#"6tH9l@]B5V9uF_q*Y!"VLsCh[Bj88iNp6#:7JD?'Y:#@qCX@<HC.!!!
	!*G%G]96#:7JDIm^.D#aP9%n0E5Bk(^TATDlYCh[O"!!!!(A7]@]F_l."!!!C9B1$TRDfSg&E+NTuF
	_q*Y!"hXuCh[Bj6:XC]Ci=>nH#R<p!!!!oDf0+d!!!=IDfAKpFE;#8Ci=3(z!!!!+Ch74#:N^c#ATV
	a,DJ&qLz!"<=TFEDG<:N^c#ATVa,DJ&qLz!"3g]B4uB_F`_\9FDPl5B)ho3!!"uF8PK=9z!"8i-!!,
	=Rz!!"uF8PK=%z!!E9%!!G8J8PK<rz#Yk@"!!*'"!+l32!$VCC!AjcV.-LX2#VlAs!!3,Ps53kg8k)
	BA!!*-$!([)\!!*&d!";/(Ddm9b6VRO]s6]js6"FnCAH67k!!!!"s4[O,!"9,=#RLbF#mh"P$OR7R'
	b:]]%i#op',;/o(_I/b$k*OQ&I]'V$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$ipeF$OmRT&.T0]'FkT
	_'GM#e%Ls0b$k*OQ$kX'[$k*OQ$kWmV$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k30O!"fJ:+ol3W!?
	qLF&HMtG!WUsU"98],_uW(&!!*6(!<E3%!<<*"z!rr?'"9eu7#RLhG!<<-(!<E3%!<E0#z!!*'$!sA
	c3#7(VC$P3:="9AT+"9J`3"pbA7$o7na!YGM;+VHL55uD&(,&r/h"r*2nYsKZ\'iMkW1Gj-(d6e-bP
	#Ll/nRHVt(8A*e-:F%sA4=A1F>ar`<T7T\Z\66FFlW'_-^:E\[$ASZjRf:V`RX)C<b?N0QDV+1f&lZ
	b7os>ILR4pJa4KMK&HDk6!<NB,!sAc3#6tG:2$![Y&Ha12&d1Kt@<!J)"YtXk'VVcu,Jd:*n1u>!iG
	sO56W4_0F#<D5"r<r=K*N_\_U:i9<217?79)6fA`E9eKYu8]j7>a)UkQ1@`73l?V7":mjn2YdG(u<[
	[`6n\p*Vdh=(c`4Q`%=5s4RG]!s&B'&H`UF561$K[f(+BN`jj#(u1.PHZq?Mq@t^]I=(\f!8pk+HJu
	/8e2i6,SPLlna1G6i3/WL^=cUak2u_Q/DG.<VEdFjcFh.4WcqeE>Aj'Z"/>]FPh#j>Lf>kt>?g.=h2
	5>!2Lu%LNkcGh,Z/WbN0F9RPN[j%/H&VR*AN6qs!lY8Z`P_:nSoM9\&F[Lp@D$=s6_.)HqU:nEJ#aY
	tZKfT5VKM'[CUf8loADIo51W`#[MeQ3gY;`.?2jmqLQBeVh#bm*lbQtMKj/XBLMNaXjLK`57<V_oOm
	K;hE;90&Sh+#4KKp0,iNP:i9/'u&L/?pE)3,gGijf!ggqL&dLTf\/*hIF.6$o,M4F.t=XK_XAg&D&%
	J+toT2sMDnYB>Vi1\./4:AQqPmWEZZGX#VRQ[dVXrr?84X`%=_l]u!cPiD;`ELDfiHfY.'+TDEo`j1
	l+d(4Gg?D,M,;pl.kT'(YO)rMK?'r/&lEPB7`DY5N]f4XqL94.[F+mWL1rH%9F(=orIa7ULE0k2arY
	H>RS7F(Y\\,?cnp>p'o&*fk0lFFSkffNDm(e'"]?0VmCp?qYS!%DtLo^&m;bSS^j0Tk7,/L`.AOjuL
	<l+aVpmJ@Ejlh^5?o](Dnk?VH\LKWqd3+5qgS'rbW@>A^n&)XhCn#L[/.Y$j)M+:OUr@@kaDEhbo6R
	\#j*PS;RrrB%l_<S(CO&FP.fEL\Y)rN"/8PN:E;YP+7L>+r@4I8/-pQn$I_!@P8UKAUjPkuqKd_j.I
	XJs,3>J-<OrG#TK*:Kn_(TH?N[jQNDG67?f/_E!HgUl7H^9I7,oZZK,)a.''Y@WAQLJMjTUo1Gpla?
	us!*6;h[8clb(+[-.&\YY5ZF3`qJ"q)PBBfErd/K7.%41.9AQaq/7QXDPW)hVhDdrREY9o`'Yh!(:q
	Vk'qs3SrkNl@Z#^IR:oe6"gR;k6k%l5+O@042>hkC:J^qLqT.\(,k`nnm\U3hpgV_m?W6"MLu@DqaG
	`qJC9mqSd:Frr@fR!(aWdDP`h`?%WA2m&K"[H;>YCGX#rj"D>Rq#SIl%i45?_Qd02/0d]@;qp0c@T0
	M?8!$U7hGQ.Zn]l5tIK3V2p(A06TnK!A=lt.K$^5^&bT/J5"!*9*#k'^d^Be=IU.>RSTSNqEA9-4o+
	T4@kYm;K;&pr)PRM98?NOcUZiDZS(%`ZsQ#M*=[X*\FmEI["\0Q*WBZmp2dWXl&mdl+WkE]B]h0r!f
	:me^FD6qQ'Kh$Cc?W>@)1LG#;VoC[$D^&q;_$[F@;9*M:qiCs7j^*3s:$R!H%O*Eeiu@6+t^rrB)@Z
	UqGuG>JVHG'uTN)>_n7a+251!2s4HeEm?&0?WU1lJ/F?ebZC.(1bs\Fa4d;D68'nGP0efauqroW:c[
	sL"#?H?K:lPRFt\,iGrf5`r?%sQ6;E:R'qp&Bp&6$rr?NagXIc7>CXk3^P?Iff]2rL^\YCB6tb$+T$
	OGZYW!Ud6^8_m!4:(Op:pKKo0:WOKmC.,^s;1iIq7gQoJ/`+4AVkg+5q4@r9rp#4'1U@Vp`0(O0$##
	GasikJ@TU%ceJ,E5N"'iY?]o>>H6G+Go($tAb:I.CS"1erC;<O%Jb;&q.%os\XBpgei-ebGo?mp^I]
	_+LKg&cbs_Wfrr=ChEOUGPR2)O0Cd4l/pto(m`n!AVkI._]Q[;k@<\j3"b<CuerK#iKo7"IP*GHdss
	3^L>jM,(%!9Hk'jR.Nb(\HV`%/sH$oTShC_.HK-]oPP[RpYe`Ud*t5k#]+Prr>Hbq7iT[k!,<pr"&]
	ImOsmS7lSYN?RteIiP3B.o2U:^S:B8-l$`R3U&P*=G]HD78#<!W6[k@dp8@_YmJd/0HV`/[q%ga@5G
	.hrraUug!:[bf(X=HTVs:+8otUJp\,$@/eN]H$!7ejJf?O[JVl%T8IG[\iqb@"7p-4YP/,WTN!&nio
	RIl!r0D*Th%/rT_oTE/G;G6+NP#MD63'p22"<daF!!!"!!!!!"!<<*"%felqA,pNJ@K9s>+954<BE2
	rNF9$4ZEr]kRDZF_V!!!Z45lbEqDZF5HAH3hQ:]P//DZFkZDZFhYBE2rNDu_!\6NC$b1B7CT!<>)G8
	PK<lz!!`K0!!!!"!<E/Y&'\d0FDs8o05bh`@:X:cAM.J2D(g-BE%`pu0J<Dg5Bq-U@r#Xt+C\npBl6
	'Xn%6=Y+DG@L,$-Wr0MQLRAS>dKH?*RqH;7FLH>@"NA0O6%+?Xm0G\qD:ATV?'G\q87F#nP/,%5##@
	V%T<F#n/LFC?gH+F#qlD/aT44X*1&Ddm9#=A;U76Z7!V+>b]*/RpIj2BXh7/i#@D2_m'<+AHcl+@]p
	O+>Gl!1,(C@+>P]51b^sE3$9=d+<VdL+<iul4E=tE3`8@8+F%a>DK@jZA7dtKBQS?83\N.1GBYZ`1G
	3TdB.ku"3B8`H1+tC</TPB6/TZ2TFCBDGDK@$H4s2t.A7dkjATM@%BlJ0.Df-\<A7dl2@W-C24X)'m
	G\q87F#miA4X+Q]FDs8o05u&SCbBXHB.me*04es2D.RU,F"]7#0eX^nG\q87F#nPSE'5CYFEDI_0/%
	3a/n&:/@V%0%Df%.P@;mkS/heq&+F%a>DK@j`@;nq84X+Q]FDs8o05bh`@:X:cAM.J2D(g-BE%`pu0
	J@9[0-VN`D/=*23cfC@AS+(LBQS?83\N.(F"Um3Ddm91@rH3;G[YPE0eP.5F&[F(AM6qmF)Q2A@qAP
	LAg8KBG\q87F#n8RDffo=BQ%iQ,%u(?E&oX*DK@F=A8bpg/n8g:05tTCFDl56Df@?a/heq&+F%a>DK
	@j\BkCs?,%u(?E&oX*DK@F=A8bpg/n8g:06Co?AhPkk0J=UmG\q87F#mlWBkBLPBQS?83\N.(F"Um3
	Ddm91@rH3;AU%p$0/5(50-VNL@le4?Ec#6,4X+TW@:s.)C2d`s+s;,=E&p@,ART\!E`?sqCcrt.A8b
	pg+Ac`iFDl56Df?gd;_oOtBl7I"GB4rNG[YPP6ZQaHFCdjKFCdTZ1,(F;/MK.90fW,e2``]P3]/ZC0
	K;*I0HqWa@;n8%De*QoGsl(_AN_4m0JP:60K:X=3)hUk3\iTS2)6[93'&`I+s;,=E&p^)FCA]gFC@R
	GFCdTZ1,(F;/MK.90fW,e2``]P3]/ZC0K;*I0HqWa@;nq83^dmrF_t]-F@ek`,'A$BA3*(I7PmP%1,
	h-Z6TIRh0el!P2_[NW5qt,K3&EWb2+Ac4G[YPc9fbj`F*(i.@qA5"4X,#kBk07m0Ldlf6o$\[6UNk&
	0JP:K2)d3T3'f8S0K:mL7Q!XZ+E2"4FDl56Df@a)Des?49lFQR4X)[++E2"4FDl56Df@a/6UO[jDe<
	^"AN_5Y;Fa%r8OZ!)0f_-M/M\q5+s:i<Dffo=BQ%iN883-eDfU+d+sJ.OBkCs<:NC/\DKK</Bl@lP+
	u(8aFD5?!3`o9kF)Pl;FD5Z24X)g?0JG170/5.70JF[nFD5?!3a#?lF)Pl;FD5Z24X)g?0JG170/5.
	70JF[nFD5?!3`9O1DesQ<Bl@lhDJ=2U+u1>bFD5?!3_j+*Bm+&UBkM!uF?Lg'2)[!@2)d'A2)m-B2*
	!3C2DQg=2`*'@2`E9C3&E0D1GC@;1GLF93&3$?3&<*@3ArEE0JP+70fU^?0f^dB1-$mC1GUL;0K(I;
	2_Zd<2_cj=2_lp?0JtC;0f:L<1GgmC4#f,W6UERg6UWgh75dRh3&<Q^2E!<G3As2`77K0l2'O/SG\L
	bN:hb/cCfj)>D.RU+Bl@lP+u(c,+s:HABkBD&Bm=3*=[Zt@ASuR'Df.]^1Gg9uAU%p$3^[h%DfScq@
	:Nk3+u(8aAU%p$3_j+*Bm+&UBkM!uF?Lg(2E3TO/2T%@2D?[=0KD$G/2K4>1,1=92_d'C/2T%@2DQg
	?0KD$I/2K4B0eb.80KD$J/2K1D2E*0C2E3TS/2K(=1GgX=1GgmH/2K+B2)$R;1cR?J/2K+B2)Qp@1c
	R?N/2K4@2`E9D2`!BP/2K4@2`WEF2`!EI/2K4@3&)s?2`!EK/2K4@3&<*A2`!EM/2K4@3&N6C2`!EO
	/2K4@3ArEF0f1jG/2T(<3&E0C0f1jJ/2T(<3&`BF0f1jL/2T(<3AN-B0f1mH/2T(<3Ai?E0fLjI/2T
	(?1-$mB0fLmB/2T(A3&N6D0f_3O/2T(A3&`BF0f_3Q/2T(A3&rNH0f_6J/2T(A3AE'A0f_6L/2T(A3
	AW3C0f_6N/2T(A3Ai?E0f_6P/2T+90fCR:/2Ab5/2\t:/2o+>/3,790J"q5/28n20f(@81b:@=/29%
	60fLX<3%Qg=/2At31,CI:1b:C>/2B+71,ga>3%Qj>4#fYr77K[(2`*EN0K:gF1c.WX6UX:%1.=)i7R
	]-f66\T94Et:R9hdZ:ATDL.ARn8NDf$V<FAc[^3b`JQFCB&sAP#9Q,'A$BA3)J(1GpsK0f(aU6TIRh
	0el!P2_[NW5qt,K3&EWb2+Ac4F*(;kAiaI@@s)X"DKJH<4X,#kBk07[2D[3H3AE<K6UNk&0JP:K2)d
	3T3'f8S0K:mL7Q!XZ00UL@061T83^dP#@rc:&FD5Z24s2s@Eb&cC;FEu<+?V<%3d>L\D.Rft4s1sj+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Wd2G]7)$CLqT1ASu$A
	,'P4q56'UN=@kkI?VjWr7S-9B!!**#!";ClBl7hj&-)]IDKKns7m\>#=]upQc2[nG#lk/00`V2^@rl
	T`;as^d!!!!j77/2=;Fa%Rzzz!;=tD!<<*"!7NMj:`pk\zzzzzzzzzzz!!!U@E,p%#!!,mr!!"fcAT
	M>]!!.`Q!!$hZFDu=%!!2Qh!!!^BCN+@q!!39'!!!^R=BSf-!!3u;!!!^G=BSf-!!4\O!!!^B=BSf-
	!!5Cc!!!^DD/Nka!!6+"!!$tKD.I/W!!:(=!!%guF_,(`!!>mp!!%asBk;Jg!!C^N!!"9\F_tgm!!D
	ur!!!^MARTW[!!E]1!!"9dARfBR!!FtU!!!FJ<)Q'`!!GCa!!j!G<)Q'`!!GCa!!j!B<)Q'`!!GCa!
	!j!TAU&:s!!!!dDfBuBBkM+$+=L_K+>Gl:3$:b'GALi4F=g<t@r#LnA0=6XD/`p$GlRhTATM>]z!!!
	XQ;Fa%r8OZ!)0f_-M/M\q5zz!!!!3F&GLp+A#!h2DI3M2D$[:0`V1Rzzzzzzzzzzz!!!"$=]upJz!:
	s%f!<<*"!>`m]=]upJzzz!!!"$=]upJz!,nS3!''WO!!A<b=]upJz!+M>r!4RX^!#XEl=]upJz!$n3
	;!"X__!4L3aATM>]z!!!d+77/22FEDI_0/%NnG:mT@@kM8)zz!!!!78OYuhBQS?83\N.1GBYZRARd?
	&BE/#4zzzzzzzzzz!!!"0ATM>]z!!"WC77/1U0f_-M/M\q5+@KdQ@<HC.+At]r+Cf>+Dfp(CF)YPtA
	KWQIF&GLpzz!!!!O8OYuh2DI3M2D$[:0d&kqAmoguF<FIO66KcVCi=H:+EML1@q?c7+ELFN63$uczz
	zz!!!"0ATM>]z!!"QJAS,LoASu!h+BE2fGA1r-+@C'bA8-."Df-\3DBMM>6T-YZ2E!-B/hm>+zz!%_
	#ZAn?!oDI[6#<bZ,hBl7Q+6Z6jQBln'-DBNY2+A#!h2DI3M2D$[:0`V1Rzzzzz!!!"BBk;Jgz';YU-
	'ONHm&C2$j"7=;4";;.C"'hDt!!!%%=]upJz9F4`":]LIq=!-UBARTW[z!!!$"zzzz!!82]!!!(ABk
	JOg!!!!d;H+cKF`MX*z!!E9%!!!0&$31S:'EB!N*WRDb-ibh!1&s653rhMG70#p[:B4>o=TDb.@fU0
	BD#eSVG6!!jJH1E)MZAh=PlR6QT)bYeW;s($Z2h?6]E#bJ`W40^ciDSrgAp.3jT+THn,W.^qZ-]u#6
	>87'*/sO*s!Yg.fhC+2uu2D70-'_;?9o$?iam@D?4k\Hi\j#MZJtARK9)_W<'7)\H0MIaT9cif`C%4
	klL>Uq>pa#$j%+E*<IPh0*4*75ls[\<!$>,B**&SH3/a$NWPRLU&qCt[K=8Hb6$2qhu`3Go`G0r$Nh
	.H+Tj:u3!2MM:BOc&Acm&UIKPH0Q33i`Xol6;`rjcmhui<Jq#gm)'*KE\/He-<8-Doq@g$cSIKYT4R
	KTPl[KOMOdfeV4n-&^o%0[^T.g7s;8Hi3"B*EJ_L'<kHV?O@2`<FcqjTY>^"pPhI-O)L68-W3$C'K"
	hN!>gWY6McHd0AV8o`k^,)$_Ys4U4af@0^lZL'O+OX9ZKFdKek=p]q65*saV-7L30'D?th"Q3aJr^'
	N-mk6Uqk&.'Wh3XJRgA-mMfNsVTg\d?[hjU(ek&IKlm4UP-qC'oM!QjTu'`<tB-o*Yp6+q$C=;%%(G
	J.%_PYRAM[i=#Gi&e$5u6O[3.FUX9=V[U?LfaRH]%1OWn5Rgm+F:F6>W=?`Sh@95i'+QW)8If8@Ih%
	qX[LU^qmLKU7,nE9P?4V>mQ4L;4cO]@R#nSEp6P*Z;ILqt[\Id@(oaqiL0bI1nD%V^=WY*>bkRn+5-
	5&`[A.jP.UCtHWitDM.,83EX@hXJ.U_C]\jV.n5-PT,dC(uR?XVB%pn.cQN1_j%+GSQ\_]bTH@!u<4
	!8JZ+XNu##:ee\)u*>_!XAJ^1>Xr#M&pD=hd5T"&LMAWN6eJS-#+;mTcCDi6P[i+!?"<&a.;&XWsSf
	5Qdll-WX3u_ZKMAri?g)L/6.ND>+HQ8e#bT-9r*Z[`kE#k>e_]A(b(*5^^C*&T\^)lM\'-BC[BciQ]
	^E;_`'d,dbC`o)f`$"Om*$IirFWmG%c6<'/-R)P7Jg.BBh'37O3$W#[PU"$in0B)$9dG*3X!HCF#ph
	PWBI/uka!LI,-RMnALF0JWkU.2p8LJg3X!c[N%4FFhE@@P0e0tSN3%8VlSLMo8!\-&WBI]K$cRT&I2
	CiJlSL`)="Y;YbDChM5f.@C_5qR73X"E9_(+r95JhFMbmOoh==tc!ka"REG2)&i#UbLOX&i!!5Jhah
	knhM[M@ksN/e2%Oi7PfNM\23Y3.l:foSi#(W'/`KALGcq+rAHSmE]1'Ykr0kH?oOT7f/OI(:cOCna>
	jDa690NU]K,dK2EGq@Z9%G9/N[`0W]TE,-Tks&Ucd[#,!B?tTfq<t+?j0sTK_9u+[9C"U-IX&,=#d)
	VEj<1.7%]7X?l8@0LBeH[6jUT3^\<_^dJ8m7mr5&c:&@7<CN?FhF8\YB1Apkn4,?+HUkkB"\;9WO\"
	(q*D'a4WCcSO2bJKj`(LM3;bNQPi_1gqE_O&=!_l9]P>0h-,u/>Q[nd!"8PbOGh,#IqEDX8E##S2oR
	o/<G0iEBsa&<XM?W3t'p/F@XO&Xk6-rkCi_H%1J>ZRh)pK'aaP#pRD03EX)b?5`dBj%rL#?k/3VHWX
	s79c$]j]jZJL0W;8-XCt&a^,llCgOe^%praPZX<rE=(&%9r*`B0U1*_(8Re3!n7+gqQXf>l5\-*il"
	*"hP%Efg4_Bjhk\!%kP@s,n5A6?rltJh$RVD;,88=c3pM3Q?Vec<K=)>'W#]3sd\S`$tCMq(/*cH:A
	d;UUTL2c'j3cUF)n8_0BVK2cZ?$!Mt'Qe;9b]P=VKlu?t5'EE=pifb_ZZm(,DKsBN.X?krkB]UDV0`
	>l@sc(?+aeigiI+"?Tmd#k@Xc1D,CbArja]jOW.>;,COs`^0S5I>oRg4t\qD)WJ:us:7tn!u%Yf"Yf
	7uGCT83W+Bo(&k1PqNVreb6Db)7s3QAb["@uSQi0o_Q[s,L]OcAslESra/<DNNG35EVn-&X%I'j-*3
	$[Zho!MNmau?^8a!1mXc#$C>n%i0[3*\="V1OI?$8BU[J@6CY0K*1VkUpRPicd[i^qY+H`,MkBj=Bq
	X+P8"mAc-DHg$#,?@:k+l%Ra/(blWMUT2Ml-HNDPuEk;Q.O52lWdV*3,(#!ipIEl)\-kd&f^<\?7Ed
	Ts#68Mm*2cFg1/9@'S:g9<uF@34#cp-+'2M'=E_+!Od9^n@*)?i4)q"dCDl[_R_h?[C\''Vn=1cS%T
	QMO1kt8KYIK$HGB-gE5:hVB>NWF?c(R8=MrY,;8gc!9?"ul7`N?d6-$a]4ik:X3m"qT36J_R2TrPQ2
	9`JQ29iPS2U8bW2p]"\3RG@b4OLmk5LRBs7+90*8^tr6:=[bC<S#gS>h@odAD$,!Ct\@4G1uiJJD:=
	`MVSj"QJNV<U>IEWYM_=s^#;B<bi2R\gZ)f(lf<-Jr8iUo%H`u>+6TWe1?cC87d8:b>O(>9E9mDfL@
	#T?SF.fn[-p9Kbj\a(jmdB]s72-?)=scu2"\ZX;"`]=D>*l$MYJ(aW;/FKa8/m6kPKK$#Q0tf.K-jW
	9E*`HD?'Y9mJm__A8bpg!+\=p!!!'"gAlm,!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E
	3%!<E3%!<E3&!WiE)!WiE)!WiH+!s8W-!s8W-!<E3%!<E3%!<E3&!W`?(!s8W-!s8W-!s8W-!s8W-!
	s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-"96.:&I8@\!+l<6&HDkE!<Wo7s4mYX!"JtH!MTP
	o!!WK,!<<*"z!!!!(#R1G8#m1M9!<<K.!!!3*!<E3$zz"pG,3#6G/3#lk;?&-)b4!sAW,!s/Q,!s/Z
	5FTDOG";(eM"sF3b+ohm''L=K!'a[`((1AIE(K,7((h/UR6_UdS-8]`M)8X]X-fIu^K(5"u6r\4r7Q
	3hI-rj;L)R@6.ippW4FH_AhUU.kej!cs"o5uNC3_2h7=BSg?BPD4)GBeCZKnbA=M2IO_QC!u,R\ZdW
	Vl6Sp['d?O\@K2h`Q#s>ai`,`f%8R-g>qAXkNM0qo_%qPq"aau!!30'!X&W."U"r2"pP6J!<N?8"<e
	B]0a7V%'1#J#11:l:#XX(eOVLcf@MUa+Yp@056ZVZ4iIWm4P#E3-7.I"W-8cZ?2FV.($?Li`7WcMqi
	pp)\F]LGSKqkule)U$K)O.&)`73l?Q)1n-e`HHP7os:^G(u<[[`6n\p1JT)Q`%=5fB;m!=D2r8R&IO
	9f]`)j8QfbQM4(?Rak>qS.QU1*C3kc+Wk-@,lMCP7!"8r1!!3`7&HG#qf]2e6rr=u"p.6aBpW#LYqd
	Trdh_Y-[!1T;gK$T=bqYR+8rhcj%)\6TTWab8WE]FBGf20scK>><#7kR['B:<S(8luJF46.GJhEA[1
	rr@7[e;hs2)JRh:OWcRPpmnab!<n9:+[[rDrQFpg@.qL)jPKX/eLOX.Kh)_)dt"V*(t@%lVuSUbVc:
	s^aF&O6+dL,d:R1q[+FA1j2Kpf2oeh)'1V5G&ri!__bd'jnh6kbE>,),L(bBJ)9a\,a4Nr[FPK_X"R
	[gqT^UJU&![I%<\D@-5DX/TEarj)E4U.'t=Rk^G]^tl\pIh!YA8=qSQY"n9F@Tu@('E_K%5T)tTKO!
	.kUsnu]_t,mRI6?Dln=CPg.;pSPB:nqnD8RlOJ]"9WK)7=FuF+F"^!=i\E]5jA/A<:;F*>!rNc._G.
	2]KGojs:8&]A##9PYIOcfSb8#SQ_EgOG1l>1[,cY)[CkBOhCA%S"DOhF%`<14omOF7Dpe`m)6/<Atd
	g:LRrFsk7Ijr(]agWs^0(0_<SqJ52k`oF9@MI#D1WMd^P]oV^gNtG0JgG;4-WoQcU%G+*CNsT);:up
	l%S['c&53[DQF3-/-lX[Mgl^%tZg48^$-\mPS"_8t^5R'b[:e31b^Lqua[.b"6dCic)CX!3oU6FP0#
	88/Q=^5r$P1Za71a.#Ora<K(qM4ljF9R/;G)R:ZbF-ObT\3UDeU)=?Fl!#,g"BOib,cr7^m^fjA*Fc
	#L2+r0:1\0f<\BheQWY1NL0-C9JEof[r:u3@bN@Z!VfM]lmp4u*HS6[h_L-"[/^_-jj/b0,1.Rd*I!
	4V8D.IW*]<a84__S>_?K&&fMHNoc1c/'pJN_Vr.#ZJ76Z1I5i7f2;]5$b&G+\Zn[-D]oF*J#Z+7?nV
	qgQ.!\4&YkX2lamlK8*Ef=J4/LS)k1jsRuNc\KMa*qeDT0>8k7!"aaSGjW5^ajfbY!0A44Jn#3(>DK
	9V+#-Xkj5*-09c95)p>i6p/SZYjP.H67rQfWS[r8)<7F3p,)e/Vi#AELGn\/>34jj7ohQ<R-EHT-+g
	Mort.N+urE&BO2(e[EI$HVL3e$MG\A,#E)esKes5F_DkT:T3@`@"/o/bAJliXj116*mN`?"Eh&jA0[
	OitBhW\Te&N`ln>>fG%JehouW9DH,ZXUQ)p/\JiRUNZWE3Wu!A7gHR]%F8Ll2A2i*%^R4IAj]S#->I
	gakCGeJ#DCgN<E#Oo=Y9BlX^GdOt](\Sd7==+jcgZ!r;J1:X]f3+Xg,S7bb^=I"Xin<Q0;s(12'e&O
	N+O,lFCd3hVl_JIMA!/FD7]!5'SJ<M[?9a*rR\X85A:&s4"c<GJ'1p$J!_k;fR(4dS`qK;CnB)Mh+_
	+6)ufnNpQk!tHUhW6m=gbI8uY-8G%5T3S8D7ik=?Yc?+VoEXYHCRW+5R.li5<a1gQ5Jh]7j9+"m:nC
	Lstnb'r($SW?R/W-4V7:KGH'WS?5fZ>oJ.9T`dB[om+DFO;58D#oIB:VMR10<j2I*o?7E&s'$+:T9V
	lackX)@`B)mbk^qRhn6]^hfE_IS*&R<5J&h>qH/s);@:S=oeI9toGq.+^qYH(o1*3_#4RPWrrCI;os
	J?X%ge;pgQCYCb\(\[F([VGM4Z(ZoJi5%_\qsFZak9t1^/"#ja43p^"g%*]lmb_(M[7%M5*BB#t+eh
	VE$fX!C/d4)"r1Aqu43S7l9Z)o,4i\(0KU($cMQ\0psNP]'2N74)2d2id`(s#N1#2p\5E85%qE=$4?
	a>8%g\mI<rMNC2oNk9oGRA_.B@Dg^fL(WZ7RVA*P@m74U]T7ZVt6amIF1Ogk4U\,1V4D/`1r+eQ]J#
	FP[r,LSkXe=inm3?s%Z>;+gupU@IjYIa,F4rrIjcQ_)!WiVNW(u-sZ_Zt$0b='c?6*3]m5Oo%hmG6$
	rEca/qYoF8:VQ%JpkYt_H>)Kg8&D,=^K21L`L7;k=6!I[PjLrjUdrVk-g[?<sAT8YZ,+\sC&4c(HoJ
	u+_a;aR/[;L/S:e]'Bg,dCjf-`ih97#&/BK>%uS%:dlDuTg0=jN,_e$a>JH]G/c\&Jl@na"5WSk>9j
	GO&>lj6gg>Y";EG[l3ioD/H^.O:P-ElYTAbQs7kmG+IN4g=`KCXsAn=^)N?@k>&VsZu-8_m5nqDJr+
	Pe*2%Ta&3W6-oQC-BI!/;Ph]XZo+M5;QC.srNgq013\S:SRk->QYp>%8U4Z*F->.Q[>XK8G'M%ukK7
	hfOkc9OiNkf9Iae)/<B?Hi4HnoNiW8%^1cir2&:m#%fkh2g7:=62A.p+@YtH[&NKC3*@]R&%aK`p6j
	'U15IB6q(+60=pmWDr05'E*IsDD7Sc(WSAEtF)IPPOfkKL8o3DZ>;KW>YC?tP^E#V6H",BL$?W]Ea1
	D"2?GuY0]CR*Yjo/9;a"*@T1*8'H5#'U<KiGoL3\I%=f'c;I;F;)&U2>4[P.9d^qoAN2W-/%I8&'37
	N'>Ua)hW8"D5WD?3\%8N\@2+[`lTFYNu]ik.n,,dEtfisdaC9^Q3].;Cd%[!F`O&-r2M.0J!0g3(&A
	.Uh@aHUrr=;khGfbEV]iC@TWd'l*IipCcL)!Q0_F%uMJTX;$uJO=,^P8M3Pc?7-`c.9pI#8^K7$[lp
	oE7SDMkIN%DJe$g3\$f?oMXd-7gKI$=1TXn?"ij$oN0llVg5VMj[ei+c:M:2O%ZNIFl'1I?E4;Ml?A
	?EqS!1U-uhFZg5<>e9g?]Y#cQH]_[u(p(qgncLRP,1s(s9pl2>ak[BSD.J!'/D/XRb^]2\)qgT9@lA
	_'hlE%LY%/3A,pNK-qg1aX-4V$`A:"Pp$guUCe7`HlAM!`f55(t7_(KL\2HeT"H%E$r7:n$4X.TrQA
	np%2S"6aL7Y`?7Cm`r^iA+&Ni<nD=',e*>>Q2F3:,t8rN9@CPIO"RlCrr@`IjaW0[#KiG:CGC!5*^2
	,LcX'PS(*Dl>a5=O\Y;,U)5Os]hom$.pT60s;VWCQu8lJaLJ(cmJ5KBk(Qh^XThG[J^f=rUO4iON6@
	IF?4rrBj4](7(0n4%67cg#=rlHFZ\PjNSkeMlf/EO=LcS]&3V2:rkR)0YA2nk>h%=%^97-ra:dVNOt
	*fiC)Zh#7?KQVR0ZiW@_m=D+jT/A$eNTu&b[^`T!//(;1;]"1CK1jcZkUE*G,%q0:8Ql@A%Qs(/clO
	N!Wh>"[_PblkGbtgHK&`&9)I-Gt^>Os).04N_IQ^Dt&%:Ge$G>me/,;Pn8&_C5I?HQQ_QFVK`S5O#O
	TT+`%,\j-(6lrNNq%.1?+oK3#jZ%Zil42?k>^p>p^X(L2!2!e-*qc`r`2^R*o2#@![%HogLA7]<^XL
	N\2:=(sj&"f`pKm/Z09WrE3e$o#&fshB4jVo^_W0jLqf>9*omUarId>f(/uIq$bnfMmPqpc]]kk=FI
	NV.KnIn697jlk*55.$\W4%tk?*T9D6BfWWWrA^npKm(<o^:]npRb70]DC-iHHHkrNc2[O.R'd-8q$T
	?Fh/[>$GR,C/H/V5ht"=Gq*"el[<OaU'('W'Uc$K5Fmc1iq=eM+5Nh+Wjn,2;*S++lj84*RkV$`NFS
	kf=lX%T+aR9&ZV9WN/C78J6V9O1\ka!s%A+m\-%C=LIP+71%E6GokLD'`o5,X^aoC(L^YQ*%U^ZT&'
	YIbHdFtW[f^%%S#k'InQG#VFdO-I=>Z*@;sXnfFb[O3(iM#RHe$a+ZU3[q*g:+nK6EO;rflpa/tae_
	]?=__&RSns3cbLtcpj5d3&ff-dgQS)WGTJ[Q4+9LJ@0sCbu;3=,d#m<.JHfaVL]_[r,c-*[7Rr%-4V
	2/-^KG)-WGR5(JiNm]hb`"e1QWqbDq&A-QBnG0GI"(NYn[CE#@+'N1hJr4;pohS3mWqK9X/$FKNgCV
	`)#N#HCF=Y)g8ouSOtoii-bR$[DWPbTO)Ni\f#r)c'<2p`Z@sQVJh'NF9"10&'cgb$ft;Ar-FW*D/_
	0::G<"&6//g:n"BL1WJKQZ;3+=peU%oqj)gA<gSL]cgNl]"XQ>3Pm]8N`Jh:YC1]u\`LWTpC\aP]Kb
	d.jK;U5E[FoMa!c9-gP(TtRFt@bBeu@cf23U>52KXTcTjepmfc1W"[((uu),#>SIk)r+XCgoY5&chi
	`GX';V;X@WPP;RBm6.PSo!-_juF\%e5qDLXKLaMU_9.mLFj(Z9?GT&]87+in+IHhRb4=Gra8*f\BXK
	sshIh%?F/jR[IEpt`DKo/f_?rr?n/,Rs2!]Gkr3IHN0P[GoNB:8U%L6Wi>;"?Ic[7ZiI?AaM`W$#bQ
	Gp4M&1[Crs0:1UYD/>?PB6K4/#lU$Ws7929/_-2fY$@ol,f>#SNq,fSucC4&^h=6+&[J%Y^Di:*"X)
	%B7e!=*Zk1&aXQBmFL%WCCpATF`C^`W:Q6Wpg4WYEljEqF,]L)N,,fiJa]bJ(?F_sbn+k[*&IWS&/\
	b4tu:hq`!P>=G.;FfgnoNoTGaNE%gB=WD<X%8pW<L4^^>4.q!Xj"`HS#DPj.G=Fd^h)fJWQJX0855t
	W>4f,Ntf=CUaB(cop;t',PLu158:"?nMRF0/p9X(OBZCVpX;bgZd85Xa=.h@*ph'`1doP_fXS,L#*7
	f7&UFkr,2=Xs2YhKtEfZ8:hWX.dX7ZW1qXmG?4/<sIHt_!NF<gH3TIbtNj1.XHs+O*0m"]>FRJ-LQH
	'Ik5%+\Q:@h>$<YpWdDlL#Y+AL.)1X.]Mml34X3]iFnD0sSi;E=B.tspM/]RA;;V<<h.[PnMk[i0i_
	OF9e"7no_tB@2dF?;:f\BH'^7VKRV]Utb9fDk4%I6k3/32u%^lE+W2+O4Rb3K4R1f>ebqlb+4hHqeI
	<c9#MZMPGcpQoshI`:VQL+^-r3M#o7XPCE5;og:TgA,_hZf7jJ<=M'h7(#F3qap84H_BhRG/ne(L$`
	%lpBG-6r]pC6m)l=Z4p)0'nW(WVc1P44::,94<X/q%[2D#oCip^`=$f98TVk8B7YW45*p_Wuj4"#.a
	Lf-3X8,nG\#"I!c.l[M-flu7lC.20F_9Wn/\BWjD:KZ3Z9)hDn^dlT[*+8Bo:LX9Ocq/[%3?_"FB$X
	So:0\Z)TMMXli5Gkj57HB?TatDp&>#'5M.(Om@X0aao;?OF8l5Og]%6TC-V'[rrDEGrr>pr!&j<4J&
	m--<58!2i]lLlnc&Turr?+1UX"Ah!-)EH!0qn^rrA4[_>_p^>^EA&K7EJS2R!(BBDc+VTD&"Tq2q<=
	1,&D7rr>c#n]1WHl1Q[kTD9kVrr=R1&,Bmg@JTO4jBqXF5P\6frrC5,qesZ]Wo$SO!6hD-TD=f1n`B
	/qq3/Sb.R2qE:&b2KkPi]?q:C,F/rstL;cc:U^NJtP=oSJU,_*k@YeTSW?h%d.rrB?rrrB@Wrr>&dr
	r?T[rr?)<q-3k!S%&.[^"/1t(]HYCBDd-anSjQgaqObb2u1;i!$;IES)<N2!9W,9qlb/7lMaRDp-m^
	hrnZi=!!=SJ!4Q]mb^f]nJ95/gE;opQKDtp5?hq<PId>fnDngG_WrE(p^&J)c(2qOrGLuZcJ*l>^p.
	kVfn.)r*hu00so;V`iS,WB<](q-T:],^15PY#'io^7@p.q=P+[=6_q"MPihZ!RQrr=sjqlb.S^\fFn
	r[^.krnV;g!#@Q/m$YWT\3J<eJ([9j!85-e!%S!Ko6T9lf=K]!hn&Phs4I
	ASCII85End
End


// JPEG: width= 137, height= 46
Picture StopB
	ASCII85Begin
	s4IA0!"_al8O`[\!W`9l!([(is5=8W7<iNY!!#_f!%IsK!!iQ0!>5A7!!!!"!!*'"!?(qA!!!!"!!!
	".!?2"B!!!!"!!!"6!@RpM!!!!"!!3-#!AOQU!!!!=!!!">!AXWV!!!!5!!!"ZLM6_k!!!!"!!!"p!
	!!#G!"/XS!!"AX!"/XS!!"AX6"FnCAKXf_Dffo=BQ%i46W5c`=(uP_Dg-7&1,(F;3\WNS0fU:12``]
	O3]/bp!!!!$TE,#p!!!!"!!*'"TE5)r!!!!"!!!"2TE>/s!!!!"!!!!Cz!!!!'!<W<(!!!!"!!WE'!
	?(qA!!!!"!!!$@!?2"B!!!!"!!!$H!@RpM!!!!"!!3-#!W`9(!!!!"!!!$P!Wi?)!!!!"!!!9>z!!!
	!i!!!!"!!!!i!!!!"s4IA0!"_al8O`[\!WW3k!([(is6Tdp6"FnCAR@f!!!3,f!"M;*Ddm8XA:OX[!
	!3,S!/(=\#RC\B#Rh"G$kWjS$P=*a$k*X](_[Pt',)2p$k*OQ$k*^V$k*OQ$k*OQ$k*OQ$k*OQ$k*O
	Q$k*OQ$k*OF%1<OQ%LisZ%M0<a%Ls0e%LrsY'G1`^$k*OV&I]'V$k*OV$k*OQ$k*OQ$k*OQ$k*OQ$k
	*OQ$k*OQ$k*OQs1eUH#QQ%KAci&X!!3`5!tbS6h#IQX#QM^C56(Za"T\W)!<E3$z!!!*$!<NB-"pYD
	?$4?k7!<iK)!<E3%z!!!!"!!36*"U52;#mq%O!!*3'!s/T,"U>5;"To/h!<<05!sBb[0a0j?@1si)J
	MIEDOeK$H,:""%_.#2WEe;\+#:5O3nDWnIF#=`-Z@aJlP>l']_P;32(Xc=CAb*0\_p`bgo0t*lUkQ1
	@`73l?V7":mjn2YdG(u<[[`6n\p,>KCB6T,tVmj^ukP#Pg!WiB("9\f0"U52:"pHjb!!3`7+YaT45u
	D'1+qk,8JWUY?YsK\O;UOti,\#_QJs&K"'k;;AnKeATU9]CV-8iZg7$CTF(M#s72KWNio!="edrj^B
	7[0^&[$ASZjRf:V`RX)C<b?N0QDV+1f&lZR2b-q^GDDN_\&\O&!"8r1!!3`7&HG#qli+?kDZ,Sue*n
	40NiRMN26Qcj0`-9FpAY-N<IT8QZ<bs@K?]r_0&4LZ;TCbSL[nT.c'10dgJMi]ZZ:)4Xf$<Pp:AUHC
	?K1lA,.[PXBU)`T]Gd#gA7mf2:=ibS-^L[9Ep3GLDE!s`91/iP:_#ralYDAc'75,F9rZq_o9O-Y<L`
	OLj.gI0]"YtU!BU_rFsM^5Lkgu=`n:UdlR*>[G42qq=#;HT5,q"gC3iUD=.?'Y5\Kt7-[!9F"hR8bP
	OXYD'O,S)Hq<FV&GW>oa34T[ks.WK567_\ob49bn=GdqnR19[h`6H]Ynhr+4651e%t^<X?D%DT_.iD
	Opg(*l/U.JV.GGGf$F6jrrBm?H,!2A*IFkMfq4N*C3S(Ba)e;`UVZg8CqK\Zn+tcRCO3uj>dG(0V\b
	qoN6H-ch^@eO#PiO#PcNUbVqolZ>DGS7a#Fkqmbft8SJGWKUTcUr^;3N]odd,qBDP(j?iGBqlX-FcF
	6ah^f!d9PocBYY@k9^FXhVV>cM-#$r=.ZXj_K8B6Ht.l19u6.`t/(<j7?t:Fc:R'C*g&)D*(u8;sQf
	NFS!t2C5^j?+%t5YkM,7@rThb?^Xit%f'I@mZ2HVY:[#\+g[$#sD55uhn+9TZ!8EDENi@*r=8^e-Ia
	2tg;'59hI7IfI!)r9;eQ1u>p+j&_F3%hrR6+T8R]jN'mb_L`[XY)u/pI-[/pb!Xf/i@iYWi@Ap/KqG
	LQL\%;hseMGqZ)le@B]rqLtAA$aV>nmK4GY*Plg1Dl)4;EnuG2k.SU)bd"elmLH3Fm4%o!JUc4NqX%
	9Gcc(e1_ZXmpc7H)_3T'&UqcWcFoKT/O!/!jgPo3V3gQ@NFm-5=oRp4OZX"2;hcg3NU2u^=M8q6lfb
	H6fDTOPZ+ijmQ@4<7@k;nqT6DuMD20uc+W0=@pke8)rA5UF$cmM#MkWdT'eYE<-c]k=6BDPm2PG!06
	"[GYp!>q@'lY%)r`Xe,OmnDEIH&%F`>XG[tKNE2!3F5[\A1b\bC/AbZ+F#pNs1%F8nI=(9<DCp8E2g
	*=Jof7sMKU4dSf!I(ZaKulFH`F]dlOb04>5nS'riG71ABAO;FaY]ooo,G,GTTR#(#PWnrep/^ZCgp1
	@2SS)2_2Rg-@B(D8<Fgm41X!g[c,d5;7,IdbhD6nG*fYHJ)EtpqN7+5?%0,&NN>=QZ),G@EIuc`rU$
	YaqVCgGp7<!Wo[^I`g]m,>^S9?/"*PshB@1LnGPF6aY.Vd:]p?C%)!\<+`OPUNYA*KI*4(L-:No>:!
	-We(fiZL5F0/qU"Hm!i"7KPZe1tgG1Fgs;F`4_/28cpVEG8Rjg&)HYFpCk0).NoL=6j*^hX,_P_>aK
	AO_=GIJ)HWBK0_%C0l7^*dj+K(rl)LYW*")KrrAG:HPZ>,R7#hS[?e)C4odPY($MaqS($'`A+g,ea/
	F$RhtEK251ff7DZ4;F0@6m[lF7_f0.c)T)Z:Y,oH!o@cp,BW=FQ`hOo4<ji=])Uc-"%Q6eQN#f*Mos
	";$#tc9Ao&d;N?8ULS*TeAaJTa:9/Z>9j!fP;3WMr"<_Lb?9ln*GtKeY+!An\GlOQ[\Td>lZ0nrW1Y
	*%jOnE/n,%/M[$PWbobTh3lE5Bca7[+=epT=BCFcF)?81&FdIgkOqs=<#fDbi'XX'/2!<:I><TLo%r
	rD.RJ)p$Im2,EPr=&[/o(8.9r4uu@PeE,FrgR9e:S^5:TB94ciVrmGVtn*#hr[.lj89Gc+7:eJdRQ7
	?N*e+.;W5C1:\.S9addk7^Zg1H!29Dm-$XH&2FjU=qEo^u5PD#NTC)XY+a[#7n+da6q*1MKbPl"3rr
	DQ'knhVo,cBq(M=nX_7CW*urma6#rrCTakh")d,c@N]rdEZsTDM@\ch9Sb]ds"arr=urr0d2,m4\+X
	r=&ZlnFVlBohnHE<0C2[g&LFLH;J9nFDl56Df?gT/hd8b6:jlS,ldoF!!!Q1zzz!!!!Y6:jlS0)ttP
	!!#Xk!!*'j!!!!izz!!!#G!WW3c!WW3#z!!!!9!rr=3!WW3#!Ped;!3cS+!!*'1-NO3`CisUqzz!'!
	;:9`sb_z&-,6$!!!$"!WYak!!!$"!]WM<9`udCz%KHJ/z!!!!`J,fR/6:jlS%0-A.!!!-%!!%7'6:j
	lS)#sX:!!!-%!!"'"6:jlRo)Jaj!!!<*z!!!!"!'!;:9`te'z!<<*Z6:jm!&-)\1!!!?+!<<*"z!]W
	M<9`t%gz8,t;TAcMi3Ch@8Z"onW'!!!$"04ner!<Ag]RK*Nlz!<=kT!!!$"=o\O&"onW'!!!$"2#mU
	V!<=\O!!!3'z!B<D;9`t.jzDu]n<s8W-!s8W-!s8W-!s8W-!s8W-!rr_Hb!!!$!s8W-!s8W-!s8W-!
	s8W-!s8W-!rr_Hb!!!$!s8W-!s8W-!s8W-!s8W-!s8W-!rr_Hb!!!$!s8W-!s8W-!s8W-!s8W-!s8W
	-!rr_Hb!'!;:9`tFrz!WW<^6:jlS!WW3#!!!9)z!!!!Y6:jlS0E;(Q!!!-&!<E3\6:jlS/H>bN!!!3
	'!<<*""?8_>9`t_%z&-)\1!<<*$5QCcc5QCca!'!;:9`uL;z"98E%!'!;:9`u@7!!!!$56(Z`"onW'
	zz+ohTCAcMf2"_T;u#FLkY/H@L*!!!$"zzzz!!!$"zz!!$U2!!"2Czzz!!!!"zzzz!!!!1!!!!"z!!
	$nZChs(O!!3-#!!ZnNF`(`2:L\'K!!!!"z!!#o,F>3aq!!E9%!!#u:E$/t8DJ&qLz!!#](Aoqj-DJ&
	qLz!!#?-Df'</DJ&qL!$VCC!!#o0BQS'/DJ&qL!+l32!![L\Bk(^q<btHN!!!!":L\'K!!!!"z!!RF
	[Bk(]S!!!W3!!!7FCh[Bj8ORB5DJ&qLz!!d.WDfp"j6u6dZB)ho3z#&eNrB5)6pDKTdr!!!Er;f$/X
	AP[>\B5)5`!!!I:F`_OlASu("@<?'kz<-`FoASuX-!!!!+78n#:@qAVbE+K"L!!#T-B-70S!!ZnNF`
	(`2:L\'K!!!!"z!!#o,F>3aq!!E9%!!#u:E$/t8DJ&qLz!!#](Aoqj-DJ&qLz!!#?-Df'</DJ&qL!$
	VCC!!#o0BQS'/DJ&qL!+l32!!@@aCfEi*;ucmu!<<*"!!!":F_kkn79ELh!!!$"z!)7NIAQ2*#;ucm
	u!<<*"!!!43CiiWbB2h<%;ucmu!<<*"!!!L=ASc0^AU&;gF%B8)9O_pYC]OM9!!m(GCi!'^G]ZnR=B
	#8#!!*'"!!!!*BQ%p;6#:7JDIm^.D#aP9%n0E5Bk(^FDfU.iCh[O"!!!!(A7]@]F_l."!!!=KATDlY
	Ch[O"ASuX-!!!!078n#:@qA\PEcaT`BkM;`!!!77AS,@nCifXW!"37K6Z6dZE`@='AS#b%D#aP9&Of
	W7Bk(^@7mh32DfSg&E+K"L!!#c4DIieJ!"!acE)1UuF(KH0Df01fz!!!@BAS-$[F`_\9FDPl5B)ho3
	z$t=-sFDl"lF`_\9FDPl5B)ho3z$Z]roBQR$mFE;#8Ci=3(z!'!;:9`ujEz$ig8-!C-&Rz!'!;:9`u
	.1z"98E%"?8_>9`tk)!!!!)0`V1R!<<*"AcMf2+ohTD1]RM(kPtSg'`]'N!WUgPhuF<\7S-&L!<N6$
	8,u0\!<;Ed$peEB@V&n69`P4omJm__A8bpg!+^T[!!!'"gAlm,$j[+E#m^qG#n.CR$4@F\%h&jW'c7
	St'b_5t&I]'V$k*OV$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ!=]DE%1WgY%Ls$a%Lrs_'FkT_%
	MTK`$k*OQ&J5E[$k*OQ&I]'V$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ%0+*C&I8@\!+l<6+ohZV!<Wo
	7s4mYX!!iPB!C$Pa!<iK)!<E3%z!!!!$!!*-("U52;#mq%@!!*6(!<E3%!<<*"z!<<0'"9eu7#RLhG
	&-)_6!<WB+!X/f5#R(;=1B@IW&H`.Z&hsPU;.1+^EIfkL'To)o66d`j;Scfu1ie2q6O+p#;t/c9@rj
	LCU9]Cu7$CS\7DbgA2AaeAiaq\eKYu8]j7>_fPba#?Q,M25oVJt7e`HI)Ap/opVRFLqk4U`(=(c`4Q
	`%=5fB;l?!!33&!X&W."9eu7#6k>h!<<05"!KB3"@5mnE?Z&"14bQ%Ts6p/_,A\M1F-GgEe9HA;\`e
	`2";jr(8A*e#:;=FdR99uUDIH0<Anr1ipsF/_p`bgo1"t?Ks[,`eE$7u[Dg\Xoi>[JL6e^F`n';G-T
	=OsB6T,tVmj_Hg&MN`!<<05!tbMt!:0WmrGMRo=jujWglAF^G;ZQ"'eoN5HhRI>i)P5PiNcb=3eP\J
	:G1GC]2H[/MMLb*Nm3eIrnC:f9=&YZHEF)f\b<V]:MT')4_+:=V6!mL&"r"VL>)L*D)Ka/9:Q;7`(U
	AhUPBUIGf8cG7?]<JD9:ork09.M`H2D$'>qf,^99`U@u,?fRkW\V&#%:Ici%S&>sHl#Y??!Z<RX##`
	O4JiGkphIGFrY#bM*I"rb_'&!3Z>%UdXK4<-'a4XipT//Su_RfG[q:O/3b[a7TciZF;ZOAV4cRa1?A
	tiQW!D=8TdPlF.O6r4Ksg>p%IVimYa:O/tKo&"rRdR?@s5j6>UNhkan>kgn)Wqu6Z4Z$F)\lQ(>R4P
	??kqJ(6%_T-_uXeW`0$Z*HS]^P^O'l/-87pNA5m&(YkRuGR.Hf$4<3=#A'23b/t,H'AJ1L#W%R`@B(
	3UYf_]U]gH'r.ujEk]@aDY5N]f4XqL94.[F+mWL1rH%9F(=orIa7ULE0k2arYH>RS7F(Y\\,?cnp>p
	(;rBeb][kb79!lkiKo&K=U/Tm"sMeXQA*c3uD&l\*`Wc[j]Iqjnrp)crZp#k)o`r55K]"ci,Ze"J^_
	Qj%uVGHEn%bp=l^MTb'<q#Z[rrCf3&rrr4qH*UKgj[OhL/B&^4+0V/rr?!bK@O#g"nj^[$$40t#FRY
	WP+&SiV=*5N%CUb^GqO=:mk/pqJ_)sO7^,)^.J?`uV2(/q=]:+D[s9X)qUE&u:&9R4=pqYe%djE=Ii
	Z@H]l0b%drO8uOQO6mU!0dS&FL%-.IAS\m=Bc;X8;3`4jV*)n&#9HD9a]7Pr[ach"t7NJ+Pt$rr@[C
	H'K7J@b[$*e*Q?7[[ULR^8id+VU+TdQT+oRP"L6(d*&PO`Lp\T8)h)/=?IU&SQ!;g(N9:+F"tZm>q`
	Uf\(#32*'bg^G4$%ATW3E`qQH#f9tb2;<,ST.G'6#VQaPagqct`p9s.uU=KS1p!:\n1(D"#<DQJa6f
	Srpj9QT/(\hl)<(G*F.^2l?>8MTbpnU5cM2Jt*p$TE4P"nam7)haP>g=EVa.EJk7id7];[d+MGpfd[
	t<rT2_I:UH6/TlIjL\6Us5^4AD*u3\*A,_DRDmH#1`*jMRn2Dl2HR=,Fc:F'9XZO)GGdcS]qGFW^<m
	9:\]loaN[t!=/U\^+>79tAKFcEId\$;dL!HE_Bao1V-W;>?C=8&4#2Y>S/]\E_XU;*GSdfXb=rb'Vo
	W-A"u5H_Z=k.R(pRi(FoXMq^C%BjL8Eu_NCZ;5[8$356t^"HN4BlgCd=p1!n!!D[r4k)6&ZSO)^4*>
	JMa#1cE/obT.^Y/MsqK<*?lPX1;VcW1h8D``^3l1gr$'Alq2LjYNItL$<0emM\rmN+a)udgg\#<DL[
	f6>peU&)*f9o"_G.!X@c9;4f(DZ/8qO>seojd\"j2\*=UYkd5ofh"-!,hdKqCg4!2<q[hh(L><oc!c
	KJb0u^%a[GW@p"2LJ!'ZjJ)M#=m*3\mHUHJ-*7kK,%Km>lCX,,VjjA!QGGAYa("C5_[)`^rS6I67bE
	F[kXo&fGZHHC36QL%;(p9=IkICNl,.=;EE9hP^fr1P_TB+[C2XgNa,.*\RL\2HJ)sXSNg;im!p==XI
	mqXGR`a1@PB@6BZZ2<neDqG!hK<6D`rrE)Hoi:(f?iL,f97Q$jJ*e'Ehu*u_>4V<Lnbg48:R&PR6iN
	Q^oM;8Ije([:\`*Pg7&TjqT\nlrRcF;Vr#b>[QI88^b`#mZohsb``_Z2+J'"41g:um#rrAbm!$ul18
	iB29U\[?,QTt2Aq4I'S!$Q\beF32K^\L*dqoetKNrK+K^ZcQ[.3thVV2=l[r^F<m#QE7<R/[0:^Za:
	p#pcFGao6_G9:u)Ur6P($OM*1B>5nR]Du?$qJ*eo]ci":O6LaW1;tX$]j]%CAs4IB36:jlS+TMKB!!
	$"!!!!$#!!!!0!'pTq!,hjH!+c-Q!)NZ/!,hjZ!,hjY!,)@N!,qo<!##>u!+Z(J!+Gq>!$D8<!,)@N
	!-A3Z!-8-R!,hjV!$D8/!)ikR!!!!"!'!;:9`tY#z#65#0!!!$#!<;!gc"M3@E&oX*DK@F=A8bpg/n
	8g:06goE0/5(50*"+!G]7)$CLqT1@V'1dDET34]>#O4Bk0@N=#E]+9lNI2BPC"`Eb/0q:/k_LCL]A8
	,!S764Ero3D/a?'FC?;:D/=*23d<e3@:X:cANF^M3c/GM@4rfIGWL(dE-,kY,!faX@V$Za9i)s"DfT
	D31bLL7@k]\s+>bu/1,h*M1,(7%9lFnl7V-$O0f^@30JGF.1,:mI0KLmI+<VdL+<VdL,!I,3Eb&cC;
	FEtsG\q87F#n>PAj%>OFEDI_0/%NnG:n(q/oPcC0/5II3A3'A0/>:7Eb&c6F*VYF@<aAAF!Dkm+?X[
	TAi`=kF(96)E-,f4DBNt1Aia@0Dfp.b+sJ.SD/=*23b2_`,%u(?E&oX*E-62;/oPcC04\QGASbppAS
	uU20/5(60-VN`D/=*23d>(P4X+Q]FDs8o05bh`@:X:cAM.J2D(g-BE%`pu0J=UmG\q87F#nPSE(s%i
	,%u(?E&oX*DK@F=A8bpg/n8g:06goE0/5(505YPZ+s;,ICi4;TF*(;kAj%>OFEDI_0/%3a/n&:/@V%
	0%Df%.P@;mkS/her"<-`Fo02cA&Dfp)1AQ!)O,9e7TD/=*23cJbNFDl56Df@i`BQS?83\N.(F"Um3D
	dm91@rH3;E+j03Df]T1E%`pu0J=UmG\q87F#nDWAnF1MBQS?83\N.(F"Um3Ddm91@rH3;FD5?!0/5(
	50-VN`D/=*23b<PMAj%>OFEDI_0/%3a/n&:/@V%0%Df%.=G\LbC0eP.5+s:E+3bE;ND..NL,&(n&B4
	W`2E+NZ++F%=63^[q!@<?F.<,Z\k4X*1&Ddm9#:hXchDf]T1E$.MH1E]b5DId[0F!;`O@;n7pEb/[$
	AOKsKAN_4m0JP:60K:X=3)hUk3\iQR2)Qm<3'&`I+s;,=E&p^3A8,Y$6t(1K4X)X80ek763%ZjE<&$
	<m1,V*M2(L@?3\W63+F%=63_a1-@:Weg@74OGAN_4m0JP:60K:X=3)hUk3\iQR2)Qm<3'&`I+s;,=E
	(s%f6uQRXD.RU,8OP]cF`hD/3\a)[2)@6I1H.Zg3CPVV0g[`V0L7Za0etFB1c\#_7Nrt"@;nq83_=4
	1FCB&sAP#9Q,'A$BA3)J"1GpsK0f(aU6TIRh0el!P2_[NW5qt,K3&EWb2+Ac4E+j03Df]T1E&p@)Ci
	=>gDe*EB+u:DcE+j03Df]T1E&pQX6VqfAAnc'm4X+rF7m\=i77/sf3ArcI1+k:*+E2"4FDl56Df@a.
	BleB7Ed9el+s:uAAnF)"EbT*&FCB9*Df.]^0d7`^BkCs<=Ai^ODesQ<Bl@lP+u_820JG160eb:80Hq
	W]BkCs<=]/gPDesQ<Bl@lP+u_820JG160eb:80HqW]BkCs<;IsofCisi6Df/QmBllK^1*Ri_BkCs<:
	186YG%F'UB4Z.+4X)X=2CpU@2_6^A3%QgB3@lpD1+Y1>1b:C@2_6^D1b:L?0J#(;0e>(>1+Y1?1Ft:
	A2CpX<0e>+83%Qj?3@m$C3@m$D1+Y482CpUB0J"t<0e>(=1+Y482(UO<2(UO>1c$mK2`WWM1,;<g2)
	IZX1.!cN3'fnf6UjL17R]^!0K;ES+s:HABkBD&Bm=3*=@?k?ASuR'Df.]^0eb@,+D#e3Ai`b&G\(\o
	6tpLLDKBN1DET1"1a4&RG\LbN6Z6dZE`6pc@q@eI0d7`OG\LbN:186YG%F'UB4Z.+4X)[?3&WTE1b^
	pJ0J#%73ArTC1H.$D0e>+>0etL81b^pJ1+Y793ArZE1H.0G0J#%73Ar]F1H%3N2_6aC3&W`I1G^jD1
	b:F=1c%'A1Gh'K0J#":3&NHB1Gh'K2(UO?3&NTF1H.*K2_6aD1H.9E1H.*K3@lsF1H7'>1H.*L0e>+
	>1H7-@1H.*L1Ft=@1H73B1H.*L2(UOB1H79D1H.*M2Cp[>1cR9B1bggH1b:I<1cRBE1bggH2_6d?1c
	RHG1bggI1+Y7:1c[?C1bggI2(UR=2_m?D1bgpE3@m!A2`!-=1bh!M2(UR=3B/oJ1bh!M2_6d?3B/uL
	1bh!M3@m!A3B8cE1bh!N0e>.93B8iG1bh!N1Ft@;3B8oI1bh!N2(UR=3B8uK1bpa>2CpO51+Y752(U
	X:2_6p>3@lm=/28k10et:71Ft7;/29"50fCR;2_6[C/2An11,:C91Ft:</2B(61,^[=2_6^D/2JtA3
	(62'7RT0o1c@6G3&3?J1ds5g6pisi75dS(75Q\b,!I,3G[YPc9fb[REbT].A4CTXD'3nA;IsH$Bl8!
	6@;]Rd8OP]cF`hD/3]T,S2)drm6oRG"3CPVV0g[`V0L7Za0etFB1c\#_7NrsrFAc[^3b3/=F_t]-F@
	ek`,'A$BA3)_01,V!Z779($6TIRh0el!P2_[NW5qt,K3&EWb2+AcC4s2s@Eb&cC6tLFLEbTK7Bl@lQ
	+?V;tA7dl#6q0?_4>1q?G\qD:ATV?E+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+?Vl5E+*6lATT&+DIbmSG9T78s5FGh8OGjP:f:(Y8PDPQ!<E0#$qO'+DJoRf!!
	$kRFE18L66KB5=s+'q!!3-,!!WEX!!$G;F)XiP7T9?f!!#SZ6QgGJ7m[1Uzzzp=93Ezdk+*e+<UXaz
	zzzzzzzzzz!"i^[Ec_9]!Diar!&J.sF(51M!JCFQ!,Qk$E-)'[!Up'h!#/mXE-)'[!X&K'!#0HU=]t
	e*!Z1n;!#0'J=]te*!\=<O!#/mE=]te*!^H_c!#/s\DI`_I!`T."!,uIcA7PZ?!lP'=!/Pf@ARkc@"
	&&[p!/>Z2ATn+S"4R;N!$lB'D.rtM"8Dir!#09]@<2DK":P81!$lYt@qYiB">BfU!"<mI;F:Ea"?ZY
	a#Rk?F;F:Ea"?ZYa#Rk0A;F:Ea"?ZYa#RkfdG]Woc!!#B)E-ZJ<B4uB0-t=\K0f_6R+@p'fCh7^1/P
	okcCLM6o+@C'aE+*X0!!$P@F(51Mz!"s?N7m\=i77/sf3ArcI1+k9]zz!!!XQ;Fa%r8OZ!)0f_-M/M
	\q5zzzzzzzzzzzz!!$,(=s*eFzo2,Jg!!!!"(<fl`=s*eFzzz!!$,(=s*eFzDk[433;!7O"-?Vf=s*
	eFz@[R2r[tOe^(tr(p=s*eFz,bP,;%tjo_[a/JqF(51Mz!#A-p6Qg&aFDs8o06_Va/nnm,/n8Ppzz!
	!!d+77/22FEDI_0/%NnG:mT@@kM8)zzzzzzzzzzz!!$P@F(51Mz!%pi36Qe9A3ArcI1+k:(6tKt=F_
	l.B;Fa%r@rH1%F`JUGE+*6f+>"^W;Fa%Rzz!!"WC77/1U0f_-M/M\q5+@KdQ@<HC.+At]r+Cf>+Dfp
	(CF)YPtAKWQIF&GLpzzzzz!!$P@F(51Mz!%_#ZAn?!oDI[6#<bZ,hBl7Q+6Z6jQBln'-DBNY2+A#!h
	2DI3M2D$[:0`V1Rzz/5g%kATD@"@q?c`Bk;L&DJ((ZDf0*"FD5Z2+DG^98OZ!)0f_-M/M\q5zzzzzz
	!!%1VATn+S!!!!4V#C?.?S2<icP-?]mE>P5'+4dB>b1oq!!-2)=s*eF!!!!m$!%%&!!!"#+6RKP@<2
	DKz!!*'"zzzz!fm<]!!74UB-70S!!#Aa<$5[nEcqE_z"98E%!!N?0!"T&D!#YbX!$_Il!%e1+!&jm>
	!'gNQ!(m5e!)rr$!+#Y8!,)@L!-/'`!.4ct!/:K3!0@2G!1En[!2KUo!3Q=-!4Ms@!5SZT!6YAh!7_
	)(!8mk=!:'XS!;6Ei!<E3+!=]&C!>tn[!@7as!AX[8!BpNQ!DEMl!EfG2!G;FN!HeEj!J:E2!KmJP!
	MKOn!O2[9!PnfY!RUr$!T=(D!V-9f!WrK4!Yb\V![[t%!]U6I!_WSo!aPk?!c\9f!e^W8!gj%`!iuI
	3!l4r]!n@A1!p]p\!rrE2!u:t^""aU7"%*/d"'Pe="*+Km",[2H"/5n#"1eTT"4IA1"7--c"9nuB"<
	[h!"?Q`W"B>S7"E=Qn"H3JP"K2I3"N1Gl"Q9LQ"TAQ6"WR[r"ZcfY"]tq@"a:-)"dT=h"gnNQ"k<e<
	"ni-)"r7Cj"uc`W#$D.F#($Q5#+Yt%#/CGj#3,p\#6tJO#:g$B#>YS5#BU3*#FPgu#JUMl#NZ3c#R^
	n[#VlZT#[.LO#_E>J#c\0E#gs"A#l=o>#pfm=#u:k<$$ci<$)@m=$-rq>$2Y&A$7?0D$<.@I$@rPO$
	Ea`T$JZ![$O[=d$TSSl$Y^!!$^_=+$ci_7$i(2D$n;ZQ$sX3`%#tao%)<;)%.ao;%42NL%9a3_%?:m
	s%DrY3%JUDH%PA5_%V-'!%\!s:%akjT%g`am%m^_4%sebP&$lem&*si6&1.rU&7H-!&=X6A&D%Kd&J
	Ga2&Pj!U&W@=%&]kXK&dK$r&k*FD&qgmm'#P@B'*Amm'13FC'8$so'?(XH'F#7!'M0!R'T3[-'[@E^
	'bV6<'il&o'q5rO(#Ti0(+'eg(2ObI(:"_,(A\gf(I8jK(Prs2(Xa,o(`O;W(hFPA(p=e,)#>*m)+>
	EY)3GfG);Q26)CcY&)L!*k)T<W])\a5Q)e0hE)mUF:*!.*0*)[c'*2=Lt*;(<n*Ch,h*LRqc*UFg_*
	^Cc]*g@_[*pFa[+$Lc\+-[k^+6js`+@.,d+IF:i+RgNo+\3c!+e^()+o<H2,#oh=,-N3H,75YT,A&0
	b,Jk\p,Te:+,^^l<,haON,rd2a-'opu-2/`6-<DOL-FY>c-Q"4&-[I/@-ep*Z-pK,".&&->.0_4\.;
	LB'.F9OG.Q&\h.[qp6.fq4Z.qpN)/(#mO/3,8!/>=]I/IX3s/Tr_H/`A;t/kdmL0"3J$0-i2S09Ip.
	0E*X_0PiG=0\\;p0hO0P0tK+11+G%h17L&K1CZ-01Oh3j1\!:P1hAM81tXZ!2,,r`28V6L2E*O72Qe
	t&2^C=i2k2hY3#">K3/fi<3<_E03Ia'%3Vb]o3cmEg3q#-^4)6pX46SdS4CpXN4QARK4^gLI4lALH5
	%$RI52\XK5@HdN5N4pQ5\*-W5j(E^6#&]e61.&n6?5E#6MEi.6[_>;6j#hI7#FCX71r$h7@H[%7Nt<
	77]T#J7l<e`8&.Y!84uL98CpER8Rk>k8ao>28ps=M9+4Hl9:AN59I`_V9Y*q"9hJ-D:#&Ji:2Wh9:B
	40^:QnT1:a](Z:qKR/;,C,Z;<Cb2;LDB_;\N):;lWdi<'jQF<81D$<HV<Y<Y&59<iK-o=%$,Q=5[16
	=FF;p=W1FW=h%W?>#nh(>4l)g>ErFS>W#c@>h31.?$KYs?5d-d?G0\V?X[<J?j0q>@&dW4@8C=+@J+
	)$@[pos@maamA*[YjA<^WhANaUfA`mYgAs-ciB0BmkBBa(oBU3>uBgZU'C%5q/C7f88CJS`DC]A3PC
	p.[]D.%4kDA$i&DT$H7Dg63JE%>m^E8Y^sEKtP5E_CGMErg>fF1?<+FDu?GFXVBdFl@L-G+3[MG?/p
	oGS,1<Gg(F_H&6h0H:E4WHN\\*Hbt.RI"?\(I6i:TIK=n,I_pRZItW=5J4G-gJI6sDJ^&d#Js(`XK3
	*]:KH5_rK]@bVKr]q<L2r%#LHC9`L]iNJLsCi5M4'5"MI_UeM_L'TMu8NDN67,7NL5_*Nb4<sO#E&j
	O9UeaOOfOYOf4ETP'W;OP>.7LPTZ3JPk:5JQ-#=KQCjKNQZ\YQQqWmWR3\2^RJ`LeRamloS$/>%S;E
	d1SRe;>Sj8mMT,jP^TDG3pT\,r.Tsg[BU6_PYUNWEpUfO;3V)Y<NVAc=iVZ!E1Vr4LOW5PYoWMum;W
	fO1^X*(K-XB_jRX[K;$Xt?fMY84="YQ1nMYj/K$Z.?3RZGNq-Z`^Y][%+N;[>MBn[X#=N[qN8/\66>
	h\OsEL\i[L2].U^n]HOqW]bS5A^'_T-^Akro^\,B]_!JmM_;iC>_V;t1_plV%`6Q=p`Q6%g`l#h_a1
	o\YaLoVUagoPRb.#PPbI5VPbdG\Qc*bhTcF2%Xca_=^d(7UedD"$nd_XC#e&Km/eB?B;e^;rJf%ASZ
	fAP:lf]_")g%!d>gABWTg]cJjh%8D.hAkCHh^RHdi&9N,iC)YKi`"jkj(%-8jE'D[jb2b*k*G0PkGd
	Z#ke-.Ll-S^"lK.>Nlhg%'m1J`UmO7M1mm-?cn6#2AnT+1"nr3/Xo;D4;oYU8tp"oCZpA=TAp_ik*q
	)J2jqH*OVqfhrCr0[F3rOVu$rnRNjs8W,e!"M;*Ddm8XA3^+p!!3,S!/(=Q!<E3%!<E3%!<E3%!<E3
	%!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E6'!WiE)!WiE)!WrN,!s8W-!s8W+!<E3%!<E3%!<E6'!<
	N<)!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-s1eUH#QQ%KAci&G
	!!3`5!tbS6h#IQX%KF?IU&Y/n"p+l-zz!!!60"pG,9!t#)1!"/f-!!WN+!<E0#z!!!!'"U"o4!XJf5
	!"')F!!30'"9AT,!WrN,!X8sR!<N?+&HrdO+U8Z)!!k:n5r'Z"#uO#)@3dWF;K77)@Z_s(Ts=)61i`
	p@_9k+fiDVXdnWKV7<-(Jt2b.@+<E<0>ZGP&LnmmApPD!MBZbt8P.6(r2FXfC484cEU=^#HOBkhg8G
	^4UhL51SAMNjBlQ^F20UnsrdW2Zf([C3QS\[o_u`lH0Bb1+tmf@\d1jQ5OekiqC)p%J.Tq>(['!W`B
	)"9\f1"9\i3"pJiE!Ws#;+VFr5"ooh\5u@kB@2*\e6@gAD'iL`7(,H9%,f.kqEpsn(Ji"d:;]'"4nY
	3<92&T@O7:[bQF+]ZGFMcJcnl97D<]>\cUU.kej7=]<Pbb\)eE$7eV7":mjn1#l=(XF8L6e^F`n';G
	B6T,tVmj^ukP%MLBR#?#W49q$kkI/0=_W/<RAma=g$/;^3_ERjHA\/k]#ralqZ#7L$j-M1!YGMH!'^
	J9j8$%]!&l"n8Lh1Ca$5U]@gUlH1]&[&S!Oe?c\f:0qk\W<VQR*A%qkU9@d</t3=!XW:t.pd^qil</
	lCkGRVJ9`=:<>7j;pSC4i#nR!-`;0Nm]U"C"O&\+Z/cbS[5!j"c,#Z6SOQ!bP*Ytp;<6XhY3qu.og#
	38.R6"J?K+neC6=R!&G1a<6iP*I";#9Q,mi=Q2^h,HZS7+G:tfG21&[d]/)GGW5F&-Z:`d*[FDflUB
	/p_/8PA^$F&MPb_eNHbh$p)S@S"$[sYdh,O>`Hh>Sj@lQo?L+@Jgb#*OC:n`uXVoCnFB9:N(pCJJT1
	A_QEk7q\\7"6V*B1EW3]4VVl!0#r+IrBX8JmZk!B094`>8J7naFEE!$hL/=aVQ#NRNd5A_2JWa*==h
	1rlB5gk(KX((5rmd"ZM*U-[s0NN*l\a]`GUD8+#)*)Oo6CmW'(`5Qb8pTCj2#fBC;Y[GepCi]9R8r]
	g5e#RNLaTI0el`l2L`7O6<.h]3DXc-cL#d)7_KVcYW:j>7\"8CZVM7j00DY?0@KPVo<MdO7EL9&PnG
	A1IJ^Qj@WSbf1/Jp$!efQjQV_rZ7Cbql$G@1aYB@PA@RfgQO<fIJFR"pLP_f1A1%FD#"Vck81i3'B7
	99VpC.>S]j&NmbmLkQPMo1?'-<lN>]DK]fVqn.+a+=o@)"l$L\Z.9"b1]=N#<YZREK07fj.8$HZE;4
	h>On;figGZX<u3-R[m8bkn]kFC<WPMASQTn/t.*Q=W&H==?!=3lUif-q2+^dk2(!REr:d_?/sO`0-t
	hZHtVXpdCMC!X>]K%8"*%tG3+p)A8rR#ZSHO<19EuOiNB5==]Dab1f9Nh4kI7nMpXURDUp`(gD`JkC
	@4N6TDR`Wl>o%.GR<d[m_?F3I_-]376k:^a=7;Wk5P>2]!3?4T?_B;-c'*7LW4NZp"qte^*s!]&;$O
	!mCpHZeF*>:O<%na@gj)VLTC:o0i@o0hEqTD)3qZ(jJp9QC+"n%\q3EMcZSZbDl!1tco&QW@ek?UB^
	Km2^0[p)dJfEfXeXWjFi%P@ED<qm)5@pc2)[</91[G;aQcaRZpJ_Ap[5`GQsVI1S+k.!Slsjf-V&),
	oC1f"&BIg:Z`*S'AG\mX:N#+N'%=\-GQ.N[bPgDP'NqBlbmjtr<9*)8NP'DE)Tb:*+*I"P(G4"g5<2
	ngqho6#2qI-+R-uWg=de)M\Z.N&2+)G&/;?r>)Nt*'+fT+h2^dLopI"[DI,atJn8iVJB6jZn2m2Au3
	9NcTHue\XbI[R(W-9"7,`53QAfd"TAMQ?FXXg<,'!Tu)]'9;1KJ^'DOm7Mrf=K^$B`A&o/r/>6b?)*
	$QnHk?Hb2))kpF5_T$mDi9j<Vsrr?^+QKR%M7qD#SKp0\PWBrLd@rlRYD,id_804@.]//'@0qJ]MA+
	s<qs3NAT?'/@K*Kf2#0)&XeA[cU#IbNYLO&(n:G+)Z3<lLN,gYFfoEUudrO^^5X=^\LVd3,Z1!Jo6$
	^4ptfYhNt8hX$:9O/]ihWKk-<PMdNl`Y8s-q=Vke]Y?A^F)SXZk2'W5]/GuO=Hgp+$Hi#61):Vs*Eh
	jIhgul,o4o;ZF'DFdm;B\mgC#6c_:E/gGl3;.X!aI[;4N`ATZ,rhUF?Wn4NA_t'$Rh!O\oBL./16Cl
	tnrB8[dAZD6mMRgnQi.AO*2l:8VV.-)q#sGS3Qd8U[H4^Mf_48%d_^mhYUt2K"Y`b,lmNN4QBr.9Zm
	Y(1P2@!!AZ,YE==W2n1mNVROlkVf$=1oo8;(4PPd5D<bEARG6C$[f%-gb>r,QX"l[r3guRe.l?C[5o
	5hHfIQ:9N"tGM]FN!+qu5EU2T9`S-.DX&k!Y>ST7em*U]rfWXU,^VW<7TqqkE[(-$$H_bu+($Sa9B3
	).\S5Os_uf`lQ-S(/`n`d\%L!<!QYmO?4P%mVTS"TrFlEi-.=A:*2,UU=%E=<P]f4^5g,MG:)Z5gI-
	o+g@k7smWKA8SXnWpGn><QLtXj'n1*@J5@MU+cV\m/DnD=c\_:=T1G7^$lRYh:SHKrblV)`"kD)BAk
	kTqIrdAEC4)[mIcW0BoYD1pO2G_As*^Y-%="3%/?^Hha]5G/*4so(>cNU_bfU>&g4tEbC2ni^=4*fP
	(IFDtDWOB=".f/pX<kk1dln6\q0'fn3S"^69c+J(JkTiFcr2\5Kpm'2F_r[M5@!YIRAMCVF^1/+McK
	+^8Gg@]u%=u;\*;LS-eFZ&-1)'Iu+bg>KoU."nFZLXh;Vm@Y\6@5>.GV2VeB(#I40GTa;@-ZmR]Brd
	C)UiEKgK4&HH<FXnl!FPJ-M-DR%QADf!4sUlWdcZg/V7VNpX[F.3PAA)^@/1gUi'/$"BijHL82(X2J
	VK?<I4-C90^"7k]m!4_haZKtZ*L%<a,A4l;Y%V_@VDr]+5S@?C:r8b-c**%IftajG5-::GO\qN;\\P
	nRr`I$M`MkMAGJ7749B@QjUlFC7#^'cF+H#Ai=4@%/g>b[L4j#)-A%BRbhLX/W>uROI!o%4j/4;]L+
	CPn`$C4o;F*YRLj.(%-?\W?oZ6MsHfOKTu!iD&k7Ngpmc,>*_G&;o)ffCEE/26KG)0_$P'6Tl4jule
	PL#c#8O;TAokND<AD[Z?!H<_3C_3@Q,Xkh4&dk77iTXB9K66q&!g]D-N'm._5tC.Oem\"2[[BUEcCR
	m]/igG';m14ji&uFc!&Z0OHC-mr.k?q8"SH`n'TBV="58h&URLVgo43AG6!IC@4,"A3>`s]YBq?h0Z
	@*d38C:'9ML=Q&b.2\<79p8n[mB8+,)F=2d<4l0;!pSEntl2,$KZ.6iXUf5Np-,ZY^^"S@&q%DiRlg
	V-LQh8:^FUeUE)WuD0)C;7!5\LHsl_f92SkI=REE=jJ*nkPJJ8Ne@h*huBV^7^N>[ZURiK_KZi!+*L
	n59`!\DgQ>k54C^h[l6`6hTTT10ptYY[m&<<`=0up/Sso>FUU8k#p>Ypef^/AP>@?):`%taDnhoejd
	YJ8jEj1-nX!6%6\u1b,Rb\=&.]AiZo#pt\l@6=4!uuSnm+_OL@R>]('0:0K'E@+)O,hD"365"T`5!I
	roEA#Zg_&W_dtn?B$s[l]!l]sD7`=:j2FYuSD;kROQ/$^9LT@I;H;d52:])A"E>Zl`Yq=RB^Dug[@:
	La5I`hS@^))uGEKu092SOrVIhZX!"LCCi]udHpQGOVDGP'Dg,Z?G;`065.+B`m+O[9a[4K8C!VZ!fY
	FjucDTHDDZ;\k#O"FWf!mI?8?tPj!=Hd;uj$Rn_#N%l(ke4n<Y9(6>Y\br'MRoLu2tOg,RHZ6N]j84
	\7r:)0[Z7+'=7Ql1Clar&-7YBd'9VSjjK.24]r@6me/-A*4F7[rLuj$KHNm^G,FU8pgprc=G6eXcT(
	[A,lE)9dT?Io!><-$4?+6-1IrCiTBIog9LSH,0Ujb]QY)E*$p<Lh6rr>7VI(S-UiARM:ip32Sg=Ue-
	i5nmVZ.6IM,mG9s(PQ&Xa^M!*^F'LHEDDPZB9bkVW^fKe/rt>7WkYl$h\AL[PKJ%YaN!7[o[?iBj=B
	t2#*+FqNg_klU8kB!U:rT9WM#(U41cuBJk6(%](]Pj5EHnJK%up=hRfZdPD:Zt2\0YHY($V>V_.Vq9
	HI\hD@D7I+\f.-RXBiRVE#kH!`d:UFmb-J;g!9GMf_2+R;"!S[U&O?&0oEoM4m)-PNrXLH^m1I>>!E
	ufYp7P8`iUpIo-4CYB4P@[shf[^N"CFCHl-mlos4l?GF]s/*>Dla5SfMcOGuXf?>HM+bl1&:@biT:6
	d^YrR\XW7Upd4XYVs5*53Z%p-)CiPGNlC*KnH\bRJCmI2,^s2)SY[>s3Rs<7=f7iK;NFZB.A]^NJtO
	X8[A"[B_`HcRclb)m]d\l#t*IFoKq;<c.2g/lmTF\`i?<7Sb1[QF_rVW?3@GU<HOSLsanKGs$#B7<K
	[;h,'#,jEH)hdcW=S2,,`+dcS/?FA!J#1&G>QL=tg5a\G/#\7ONF_hiqHT2WpAq=j<jfDj:(^ZT&'Y
	IbHdFtW[f^%%S#k'InQG#VFdO-I=>Z*@;sXnfFb[O3(iM#RHe$a+ZU3[q*g:+nK6EO;rflpa/tae_]
	?=__&RSns3cbLtcpj5d3&ff-dgQS)WGTJ[Q4+9LJ@0sCbu;3=,d#m<.JHfaVL]_[r,c-*[7Rr%-4V2
	/-^KG)-WGR5(JiNm]hb`"e1QW>HS;<K@Z.CZAJ42VBcO^PB5btVLfOVjmu<(D*geWDQ7,]0DH?pcE+
	@@D@$Kq@UFQb-8a=#Nj9nZ[.#R&pn?d#TkA_YJBNp=lPt2iB]_G;R3-.^X"Ub(+3iGTS,UDZ1np6e/
	n7Sq1V'hFa\t$<;g7Vo[1CVoF:+W0.=u^=4s'<d-T$$Bf'&"4ZfBVaZPcP`99h(n:S!&q33lrL)rfJ
	!Tj"dd>BCMqJq]Vo<<BYJU2I@M@OFh]t2j7PB5Kk\CcO]gL2XNA.g*hE.GgH5rMoKqB<mkh]rdhS8H
	WAB+(]rSZG'g[@.8Q*1sO_K@TX3Z?$O0Hng`)DmC79.t#]BM3_51[PFRGADP>bacdccricQie>>sQ.
	CX0e;C>BH\/XCa;"`)/['YnO7KMnQ(9e`Hb8;B%r:QnOP^j4eQ1;e]r*EcmEMW`*A&iY3ZR%tg</MS
	6\%Dh#)9I!f2O2p`9$46.1A%U[BcqYop:)?[C^*-peBAN[P$Ong&7&c>>hb!%J/(TKnlV\rIqQJ88f
	diGACbi.cGsY!*q`[$#")4AX]'5TlbAD^!\@#dBpV+,U;WTNgs;1S,!!`W;M#:?Kb\in^.77!:sF&k
	dh;b(<i`7gZGB1NAjULP-B)D;.;#On[A#V:#/;C72FD-oI(V[kcX`/[#odM"Z5fi%s@<L^V^!N-LQH
	'Ik5%+\Q:@h>$<YpWdDlL#Y+AL.)1X.]Mml34X3]iFnD0sSi;E=B.tspM/]RA;;V<<h.[>hS"[I/ic
	f3=FLTAOW&itFiKg2i]pt't(TP*^'1fqQH??UaXbI0Wabm0UUm#:jVJch4$@;PNS1D@cpI0h1C+84S
	RgBXC7c[HG0Or3P:d]U,pKm0u>t3o14-sl.`l-UnMgG(TnZ5trb3McUKrj(amrd]g-VYZ:g:2C(YH)
	6rjd`&Cdmb6Yjc201*p_X!=4@0LaLf-3X8,nG\#"I!c.l[M-flu7lC.20F_9Wn/\BWjD:KZ3Z9)hDn
	^dlT[*+8Bo:LX9Ocq/[%3?_"FB$XSo:0\Z)TMMXli5Gkj57HB?TatDp&>#'5M.(Om@X0aao;?OF8l5
	Og]%6TC-V'[rrDEGrr>pr!&j<4J&m--<58!2i]lLlnc&Turr?+1UX"Ah!-)EH!0qn^rrA4[_>_p^>^
	EA&K7EJS2R!(BBDc+VTD&"Tq2q<=1,&D7rr>c#n]1WHl1Q[kTD9kVrr=R1&,Bmg@JTO4jBqXF5P\6f
	rrC5,qesZ]Wo$SO!6hD-TD=f1n`B/qq3/Sb.R2qE:&b2KkPi]?q:C,F/rstL;cc:U^NJtP=oSJU,_*
	k@YeTSW?h%d.rrB?rrrB@Wrr>&drr?T[rr?)<q-3k!S%&.[^"/1t(]HYCBDd-anSjQgaqObb2u1;i!
	$;IES)<N2!9W,9qlb/7lMaRDp-m^hrnZi=!!=SJ!4Q]mb^f]nJ95/gE;opQKDtp5?hq<PId>fnDngG
	_WrE(p^&J)c(2qOrGLuZcJ*l>^p.kVfn.)r*hu00so;V`iS,WB<](q-T:],^15PY#'io^7@p.q=P+[
	=6_q"MPihZ!RQrr=sjqlb.S^\fFnr[^.krnV;g!#@Q/m$YWT\3J<eJ([9j!85-e!%S!Ko6T9lf=K]!
	hn&Phs4I
	ASCII85End
End


// PNG: width= 161, height= 54
Picture drawFS
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!"D!!!!I#Qau+!4mucEW?(>$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
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
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c
	>J7!"qRh6pXdsg?b;U<)Zl4a+$*pF%Ahg+@1fG70+-6ZiYiff(Yrl;+m1Z3`rd+#IRmG3k&Csdb:[]
	G%p7_lD(dk[G'"GQ,6(o%hNJQ5lqZ)+qOf!n+ZFDS9+^$Y>m)kYKPeQhd9OPm%$rG2`lA9pM^'u+\<
	;qO8o)B#1ebV>Qd>TrJulsphuBY&>?e)\#[6G;_B:#f2E`-I=8e60#qu02ocqpd-;BlJ7L'(,ZH\O5
	Ks3f2`HMGKaEIM]6E`Ck.%e41r97(TIg-XDJ4#IfnGO3V@<^Q`F+mHZHiX5QkYAM5_qYCd%BqQFZQ)
	DC,Hh:3h7lQ.a$Z++2]cnSR,Q+*#oqL&-u)H%1Wl&B:dk[cia=M@"ur,oa^ikYNV5u_B1=((r?M9lY
	k_5#$usk^Cu46Vt_&2H@[mRI:NU7I)UcAkJ>M2NmhMo?+Y9^VP^5cUOu=>3ue_oT+:p6ZP`a(3]\`?
	.LZL`S'CYQ]qM-nUIUA?91op("OAWcd[f^n!goK>=W_I#"[h4DOm^-k2-kZ9_,q9oQ4K\`S(U*V:6p
	7VGD!kPEQ8[?r[&Nor0Mfp'lKlYFL7Ae>q.BV,R>S@-71o?hViFl`5IJN@NLSS^Q$3ABk_;GkicEZ=
	S;@[9he>].Ws%,3KkgdL1c]C4t[hNbNg'^>m"Wt6ofOH,Y=Q>_q8NJ]*Xt\eQ%$a,Y9;-Mel*ED?Ni
	ld73,+5Jul3(DISEjlILDF@\$NP9ei<hJP6@]5)>i=FABIg=l8fgR"D!Hg&g"%)\Z&mUKk9)[L'',[
	9N@Z*+iuIP;NuFV#=bhT6%`OS#c&@MZpe7qeM7D#tKgEhg).A`9]sc=pA5d+=[[&B',%#@oS-!&QSl
	>-6ASW2TXlr:'4FSeoj3B?m#,E<=2NTV.t)d*VR_p_>;[ctKe!MYe7LE+c?@Ve[F`A;sgQ5S+*H%b)
	5r\.IN'7F<lGI'WbRi#3FR"W)ms$-ma#.VGe`pn#X)*_Pcn8k`G"mr8!eg%tPk%)XPE.OYu<5nIU=A
	OT$V]kfG\g?5)XY#;7sr;?25I;<W!<%:%Tm[W`[AS'u1C"%*CEh5$&a70<@(<i4)l_BM)HG%U"Z4)*
	So@dc*[(XpX9:`TXO8O!I8cqY*RC8H-dFmdbL**4O?SPil4?ES>iKBH(SrXEJi9H;;jR?7)QfO/1YG
	)70Fm7>NiPUFP<E5"q0k/7f-*q71k4*['Kq`3t='(a/j,&bTc-FV[aiQ9*9Lbe^]Y(nf\bXgY>MHW*
	T0.D)_-hMV>_4*(Za5jZPAqT2m-K+YlQ?2[L$RE+r^VpF62*#PXGIolRgfAfXIA"(d"r?N#`erm'$>
	iI1B8H5O!cY/%Jg"ZrJSui/6`edj\ArOdFdluqeVHm.(!0[!$Do2PY*6e8khlKl'WJ*'bqW*MW8qH5
	_)1pTMR$pRnY":]`8!.7\_\$4h\50oZW^Z:Q9_nkg?E1WX0=c<)ci0o?KE8)&\KT*F0e_DMesNqh&q
	.?dfg=$q(!onKXa&&Y9q/DP7+'m#m29DBWr5>7@5/E4DS7HeNPAa0]-di?#FTA_<[e3\0o^;C>>RRi
	U7lD9L)E&rX_MkK`1.3+B/FA25GW-%5XSV[1_oWN*J<3'TXbhqoNrn^c:Bfs>=leS5kXQ(".frquR:
	7udk/_Pb2?5CYiseC<!lSNHT"[;5Brc!.PgdGrhl5'`Y:!Z#\)B_(kTIouqm45?#`[kJ9K_!"L(+9;
	E,&+IOc1BH:(P_1ItYE<n(]^Y)q@C>8@/V;NDaoG7B>>(a=&eYgj1tp*;.o@"'\Qnahcel'A:TpN>#
	\)r?RCdY0iph7GQRb$T\@oR=0em[lQn`/`AIB;,lqZXiaE>,NiSib0L#2P];^dk8<W88EeiXKC\6^u
	',+9)=7tq(r!I+WRoui?+6-gJ;S[LO<=p3tK+AHh7kRHRSA6s5a6@\OE(N"#+=]nl/JNtb%&'P2-Q-
	(t"ekDJeKuILMPtDJ&8kVg\?G5&[QRBWRJDApb'L`ZK'3-NI`F=s%V<ca:T/:7[pF!k)9ZM71#"AFd
	"TSNFoNip9UF+:rXO6goUE[)YoJaUe"-4LXENX>7a7[pi_lQo)O<Ht44<!kd7(70r`n]?S\Qn">dc,
	G^9dZ'rT3j7DG0jIo=M9$'8kKGSa_Yd0[+jsJT[dd!;>Ho^K)d%T;LsTNoVjsGi$GkI<?T^>5q`CH%
	AXZ_?+IH)KeEFPat]nq.NXX0R*i'?[;+C#ATG=dV,B;n%^4Jg>?`V?8:&Qu%\B/^T-#'oc!mpr)]NW
	P)iis<NK*r:rkIUp,.+)HdG$hnEP4,8C3EXuMf2/!*mdFYf)oH8-7On-T/(\.AXB^7S8(u$':6l_5(
	*-U\TrIGR@0H`*?@>/E?&n7DN9d=O,Jop.[AiO2@%RAE8cCLX,W*uD.mUeg[-V[bA+Fg/=)\[BE">m
	o<%?T]2Ds'&7)XD%.8[DY85fPlN?$=L5$ecWs>g?//jVY2j,+N?u=kBk[m6k59fNXrBr9)#6tL3V57
	T;2DB#W@3LQJ@PAWSREXW/?l5cmlVSAh*Ral`r7]lYU8+KU37mD:*^4srq=<X4Q'F7sc/itS(j>B)]
	aYo=":#23RYq/r<Sp,UqstYuJDn9\i7Il(\u'=K=\Vrtdt60[2D&16CY)V-!asrjEmYEuco&ufftQ*
	T[Qku)HG'DUAfa'Z0I%g;[^PnDar#jR4*Jj6ofAX=TB0a$C3m0j!*HL87:p/omG#+pB!]\B_K!5fWG
	2+ph#RNWO6%Pc^^5t,BXN#Y!U'T(%j^E5eu[t@0"Q9I0IqY_3a:O:[)#ir&W.u%"5qO#As;!6j:@5u
	YZFq/Qr^7F(^qr2CLEoCZtPS*XY)7[a"Ya'okH<%O2l>,e1'9R.[=a(R@I#bA7XbbjmLj1X0T&%o&\
	'/FkPgF1c.&Uh7GU#0sNem%0-qB)*2e[S(?Y5fLoY4lS%q\NY;k=WkqKZk5=$E#Ur)BC:i'G3eGW[!
	!)X,=DR<D[#j8:#kH?OL`je&dA'\ke]jRB6UF-9bMBI8$]a8:2Jr<QRr9thF1^6@M56f;i9+ku[9BW
	]L4k5u`l:3*kSYZ?k09AC:7TDKb>YIlQ'IUs*m\@P*Bnl'Q\=XaqnJUD"!&!mC5DlG,<F4*C/\^(Q\
	Q'cYpT3_U\t)/eWIEh>dff3&,KF?!8q-aYq![(;97eq3.o&/80i5d]Y;+0[pj!rT)IW'+',ROIJNGF
	.[=1==-o&3EF38Wkj7Z#a^gNrOUMHS$$)S3B3nnNG':=9ACB^a.[A.gZ^j*tk'j>6474c)K+8G0Q"W
	S>FUi&V>r23+Q#A6Yrb%#2Y3=B+X/LJcFb[Oim!]&M:%)ZCKVX@qFDH^U&J5TnNQ,G4oT?3%BQih!\
	U!dYNCK[>-uRnSR@g+dH1U/'D7*EFm5`KQ!%n7^B4oP[2_Qj=:oDcJ]QeGO\8g]XT4bL`]lG2UBG,;
	I&P6Xn/QSFF:FDkSJ";c`2e?#nn_)ojqV*+ZhXOeKReolDC:2WqU"]De>!hKDI8CVH;7*[9Z\LBlK9
	;@]PF%UP*?G+G\)/YLMW;a<B4YZ1IqgYSZs#&@7dJSIpQrL?qt@h@^nj\jQC!pS(DjjcqWe@r*9\XA
	TuB[H)_Ym>b)`4B=q)j/UqV/>$:==42Zit6qLKS'YYmT-_9i[n*t$\aM:jsdmJ`U"DZ/qf^Q1pD^T4
	c>(3"B'p\m!RZ>[B3?j*4+2>JhoN:o5]d*U-$GOBF\>_g3?PtI)Z57R[O(GC7:q<&jtc0FtJK>DO'o
	P#qERuri<D;-s0SR,2l+qtA!$:R6H5takoe>ZBE9q0/]E&8J-C2,4,RS+3F:8]ldN=?=+(G8rPHM$F
	CP:'osfreVm?@(k4^2kA/RL31Mh2Yn<jrS=(X./h`+pP:tmnM84CM)DD"MgST[?mUJXLZfY;aNtVKF
	h/\o3PBVUA%qQ*%9ls,D/E(.fo5HX6&Ya-\oCMjm<Y,oF0*ok4U?J>[6(;ZY(3q)Ff`,\T[@DLVpsi
	EiZ4?(,'",If4SneU$8qN?<ZJZ)t.QCc:U$3kO4>PEWoIo8AK`BJ`n(A`\XU)sha[a5a^ZrH_jZTL^
	=P#U2/b('_VJm<c<[h5[NV1RUp_^#%^eXBN$Sj72Kl]6DJd1&^*0hg=h*?[bTio(S`MZs<AOnBKB[*
	AAXVrqnL(BNXZD$fQps@oTYlD7b@na#r:a!=@\>K3crhJ$+kH-o;fLgm_:T&jC_`I'Z?F)WD*([+2Z
	!9kAB5G4`FhE&\iJ>i+8kN+#g[8P)TL9NG10MPA)/`<chW=0>f-XK6NS>Y_3GB;]\g2]@ZE77D;Zh/
	9^bk2nFebk^knZe9/s<pOq@*=bS)5esI(ZX=@"p@e4/Vb`dU-4IdC(5p5n+\>S6<j,`:DX,`NrT,46
	cY16RH`-h4D3X`Y5TgV-NL8f<US7`:r;S;No:7*9#ABR!UC(fE+RL9c!07RSnH4<J2#tdG&1u$7K[g
	A;i!Y08c^=#;[)r@(CQT*Y+>[WRctG8<XfX"/8gKRQKEU2kq#'sZ;Q811FK3l+NCIEaffU=:D]SIel
	aLfiDJsG0MoF_rND!&C7o@cJZaI0Ibaps:#/MlB/H"b1T3O"8d:cLY<+`Jim</R3MoG7Xp\N']oHo\
	.F-*MlF1-Q%9:"hVCY4N':c(+`=qSZIgaWE?&1flHRt3j/3X*#;?rDQt%fcUZ+2Fn1nf)?HdYs/$nC
	-1f@7e83<rqIUAY4g?O&&DA]70^)FEDVQIJp-DVj'fMfk`R79YM,IX4?KU\\)6%KgMK^ks7U$^5bl6
	e)Tu>jmlp%NqmS^QqV+<H?ssdr*[$@YIC7#Jg<pC_dU%/]j<?`P"[3d7\bq]2/3+rg95/!<Ht#i2p(
	pP$_/)GMURnXB*'4UR<7Hd\%kjmb7-9XE#B3(!&\oggpE\j`_3*"&<d=#1?0el,d'5f1VtLd4!e7?q
	s9j8c'tV/WI1nMX/kW2]20miM+#nEeHgd%-5;%S9IA5%1iD*YnbtS=S=FuicCN,#8qB5]FQh)IUnj>
	aIMi@1SM4J=Bk]#J+<HTalh)G-6DMq5/m!FJ][+gpQi$OZ)@KZWs3@hb9<6s;;T8\,2+D9Pl]fS:JL
	#e@#G*%,r4qHH3$)V#,67f1YZU:=6#>VKQ<I1tA\hI*EF)?o^K;*KS:2I`lur9BK*Ul$],)4uQB71^
	C!rg$bfnAX:>\HO0Gnmmh<fB`V5<S:^Y`,<@Pf"@_o"-5\od>n26Bmu(DjQ&ku&3a#K*)fA]hT,lUj
	fC0asgR-o;j%:8_#='GNuoMMaA5c2bB1<[uc'Vn(^%nip`B6#I&)E0$DR"UY7P"G%Wtpqt8gP@A`;4
	2H@V^[86S,'ar4b<MNs]ZAG#Fj27,r6`=Fn2qc<`JYO*8kKp/7VcdTH$MD9&3c?s$jML)H0r#keui<
	EF?5[ZV,jWc&4@k/e^`1N^m$9HVGEi@lRc)>gn:=5cT_6M=/noi;V>kEPK?Kn:>WHu+,r`/(miZl+a
	PNWLQq8[p;S8B)kmJN?pg.idb2_rlih@7JYl?h"_n,Bd=BCD1_>c@**)"Q+V4s4Mls4c*BSG/Pa!9r
	_WUOTFLj^[84cAj3cq=(,d+5Mb\FP[.*?'U;%u_s8t%kfEY$cSIHQo^Q51/K-km#n=A5XAq0`2:n`(
	o.$&YI0iDTMMna?\!!EW+-NB+\L<fP`qM(0DI3#+A1FhtigaaD#O;DX%4_&*m=nDo0DM!!i3NCMrO]
	=YYc7ZJH+()DWI868ko<E3%4BIJb4Hp1m]OZYOqnP!pO"8HY#Q`S>Za9Vo2g3.c:aQMJqKiBO]N/T#
	R;Q3Xhd8W4igjo`*&;7WoN^VOZBF09pT%\^C2^;9O2)6qmn"k0Q#ab,ZT7rk3+MUS=]?pS]idV.4^*
	FSN/8FDVz8OZBBY!QNJ
	ASCII85End
End


// PNG: width= 161, height= 54
// PNG: width= 145, height= 49
Picture symmetrizeFS
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!"8!!!!E#Qau+!94S\RfEEg$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
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
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c
	>J7!#d(R6pXdsg:V`WCg>T*hRVCbgfa(3qiI<k3Q#.X,Z:KfMDV_Cf&h44@6Y!?Jil7F5Z-J4[1/QA
	m6aaXkQCZOJY5Qig5-q3cb!XZ<[<S;`C4$dUppqJkNr)[h5u03R?IN;4A.?Mq-u*GgiGZNn,AXApH&
	Uh=Va-taHS1Sq0+bm*UFd7C]KN;9M\G3&r?u4/qCu,DVVaa9I=+ki<9L=*blnsBR&i7nug1%Mo6\2`
	nYJ+md;^F0Rj*94W][5l$NW87j3uu_!1G,94aQc+8<d<aWs;P0F[sb85(@o1ef2#nureTLRh8:5nQr
	`9YO,]`>V;M5gl_6Jc>"?Wmti<%$sR4L1/6d1'BlEJ`&91=05LH#V)*3/B\e9"W2uJ6K.[2NkFu/3t
	I&.c&f].S-qeaR9Tq4M!$l,[7mA@KR`]Tg$SM+ol[IiMd]^=(5p.@9he?CM8]5cH+Vo#oD('K$\^pP
	=NkB`rAi]E7^LjSlpe@d=(H(T>:2dL6>8!=!!!KsPAE86VO!AF"=iIQ:NSC]B-27D%)YK.d:0B%rA5
	FPKgMJ4.b/:A?neN[X7,/W9ZHPqrsPSI__Ao70UKt&5O7Y$oD*d==QH]n=tTLC6mCT1\c,a5J&\#e7
	<1DW]X-X(h/kM3(qV?l)QDZFiJp;])bhsY>E*S"i4(.9>F==$np,HW6#41(_NA/m(i*'l+)4mAF?5s
	f?b(2G,SDsm2B%QEPK@q7gc:G9!s!T-PumU(]uT/Q\QgbR.h[\D\8Xa9<Z@%<7pn$58>K._cThH"+G
	e%W7[(sDd*V:AM_FMcmBJ5>qWk?:e^\MTD`aLb\(_p[7%S\d)3%*q2Obf-SSL(RIj`i4T=WKhY#e4`
	\!P]oiM\i.'G7X9D5TH0BsZ;F.0%^sds'Bo"4<KtcdO9V?SC:/`KL1j9`jg4"(`gCq=;]^oD*cPDsu
	iNk3hYT//B`M$4m?bc-67hb\$J7mdA$3`9-2o2OePtBo,<S91qnh"IVr\LWpm4IJ-erQTKH]i7cnR_
	r6D>,.Us=AQ]M$A+8X*RiIa=AdaC391qo79fFp,s7IB&p>>g(;e;]6U/K(i:VHf/#_4Bn?!^e1KqeO
	jF`3<72k''@pEH1oE%`4*7O$N+$%pV#c/$'()!CM9N",cUB:j:#;EGqL1mQV4AQGpr@9ERr&-+6h.#
	*R+PIQ/C:K+CQn))jQ64d[PGdsr\:Ekq&XK7)miD:r`G.V0"c=A\GCMW`nhI<b&r:8$`K7g5*X-#pu
	T?eT?F9hl^Z7IBk=I-'iX"K_H!5RdTa4c$Yj704SYG3L,3]];U0HcKKlum_8*"E)Q*fgOlOE<Os[^K
	3b'[11\X095u4?U9h]GqE:oD/=C_hZ!Z<N/r@G';6G6o%iCIX#oT`SbC$kT4Fqc[$4qFQ*#toeZao!
	+72V=9\bEfV6j.EpgWA1Q1RgZ##G3JN"4(8OR\Jh<W*OO'4C@J/VDi&.8J9X&>>mrSHV@:/7>E1k3*
	Hp@[G=ZRq&Z-t'Gd%j!h]'FM=X[a]'"7\cY*$31&l&:u#e*cGFo5Ur&U]QqubE6pG4c"82_LdIdpE8
	\P$n1^K\kEnS5PbKRlATr<@_VoH0:JX0HT:VWt\QhIpYd:ZWH[EB$V.F=R8152/]mEhYe*6Q%#I+C5
	_9gPj6mB0jrOUJBjKNkkSkLKsl00'))oHZcVWhj'MI@>rdk&\FYHJ04JO>2&j`7n9[r+3s:9do[p6n
	r+bN;F1?V\lEg]-s*_6t[:+l8-TcEuk7/.09+"J?ZS03aei]FKj#0'$;F]^(Wt<AJ9hg!j!)DDt.t#
	:e7B9sZqjWfa]&,'@DH%UeG4hp[-EWiN,efZ;J9RH]QbM/1_G*Be^*&rG,geK$l'*.f<%VG!a`\Qfo
	.`;fn%ajf2(/eX#<Vl)6XX/i;MC:+t>L<o#b!(s(cWDl2]'S7HbU/k;q()@['h7AkDV.c;]GjsXJ'.
	9#:A[u';S=I6<p$0W>#`!QrlraUG(l%!MO@l>LJ;/f5cH]1i=?JZ,Md`!pAC>5#HG(B?E<&8/==f_0
	#_G;Q7$?Wjio8D7d]H`_dciU3ZMjb#VbWdL+UIQ[k^9jbUo"'SL!?f5k-nT%OV#:qLj&)04H,?<?mh
	IJNFoc01'#,]#MWpHogb4"6IA]/rUK]G3\c)eN!U9*KaP^Q66+%"in:Hi?ntL+ZpH8<X5c^!GkQr`a
	$4_3eB#_PVk8EaqtBDLV#gW&#(m%E5S-mC'O38WeS5g+Kd)XmA7QsN9"EbqL1,CSH3OQXp,/DmlfF?
	U5nIqCgYm+I;Q4-1f[A2'3]c!LgWMa*iPL;4-Vo3\_$@Gfhl^"\!!&Y;-^@:I#g2?%%Yo[`:BWtR3,
	p,XMg7E+L10rTqM'c\\J<9KZHM@hYTsj<e*1s8SXE0+_\sI5)]Tjq<d'c8i5;[o9n*_i(rjUFoD+YE
	(e4#j0FVSM7=Q`*Om#I!p1!Q.Ysbo,#/GC1Q;]4o'Oh&-,aZglM`$ZVAQ"$XreJI%\^>*;a:u7[d(,
	if(%5JQ`GrQ"[l5@hj#EW&V;?_%I2#+QQA&a,)NE>"f5j8;&.$3`Z!+8a@9BX4oDAJiXd8S?Cc5KK(
	3r%!daHRfbRDBC?!U_m9rlh0Y-+o4UTHd(kj.Pm6m<h;.$[E<qsM'EMK8,)%YlVOMb#,QaGiZa,Y90
	c;QWt_*fj'o_f;2TQukAp-kpngT&";IYhIjd.>h$&<;UV">7q0Rg$T(3o0_=P)=bQ(iiU1bGUeE`-j
	.A-Yp`DRG9"?#(,s!7=Jc,:8'idXGA#K4K*U*](>Xms/[\3u&IeK0E<-T6iqO2Cm=4`E=WpMq=l3c:
	qjEnI.#).?+$SK5fpU)s5PaB(SXgc(5nF0m-qZ+YB=$:'GOJ:&:N()eEW1=LdNsgjdam"#hqp)L8A&
	94hsVpa;Bh7%e`u\pnUh&WqL$"dYt._+8(0X;!+9>JUpIB`PKA4Ed768[4'WbuBj.?2V:4\J`PpT@D
	`\pKmL<I5FNJ>W\$`UQ%Ls*SiUcjHJH1J%;Q5Zu5<_%dkk"W@q)h)C4<>"5!<(A!:,#oA7FS_)4EKh
	XV/iD)d=>g*g8lKlBPM+2,-,"ON=J`<?RYFJHkFXWQRX7T+7!]Hh"#7d65lgk/effBELf[>X4R)()\
	/=DIn[%7,*@S5"cf[+3c-Pf%NIG>$jLY-^2:8]E?+_!]`8%p80e`P;Q3WBHTOf^$O[=nb:425KgMJ6
	X0#F'<ibWPl1l"8-5)/g6D=5Nq<q^F_r8_Z8XmsO&.&2_5Kg?!Tb,97A2;80gu@<;bHaa:;C7U,eS:
	SuVUt/2qYD8_(uHMla+,IKBPM+"e`Ep!X&=dB.M6H=)QH:'pB&`1.ZlAl./Z=/h9R_Prp-WVp:l'&[
	&;%<fDkHOJ7_4e7Ylc,VFHbMlYu3FdjZ>qdM-1L)%JLT%sN,;)FX'Rk*XKXf@SW`\$t122hk`jQ&6[
	iKgLpJkI7n.17:fa'KU6n`+uQip5<;U67`nerV"t^04(0=S<V4YHp1o:<;,tV:_^=BYlOhI8Q)Ne2D
	d6mXk*4>Fpu80UbA4^/h\krD/JZM8L+qF;OP_i[^W_%R7nk=)'9rMj,H!Hrpub?`T!Nglt>e#pYOEL
	PY<D;#QtKgU:\%,,g!0j/IkFI:mfL>S'BO?h9B*^IBd(Z;4lXs]_%!DE&92en\O)Unc!E_)#s-*JM+
	9KFYCD3Z,>VnKREd-HS64o7rrsU7]s9!l!1JiX3!arCOQ/2I-%=n>@"$qosC*A%s=\RQ!blGm18W>,
	%Fp'4;?atFntUi`PoeoWFW89`lH-mHG/!J5'6"M<%=H-RYjS0>-0]Pc2)fOVpeeN<eJ5]e*3YVW`#h
	[p%m.8:QLNrlLfHEO#JsT-56f^d:aX6=C#34-kll<iP@kEj,ZE2>$<BkMe9<ke>ZAMXgYdNH"^k^/s
	f@-9Z5t2%a422\m2C1V%O%:>V6g];70S%X4<e*IJW$HP=D;Z6'1X,E?*#/Z.RpihWjC+>V<4\X8>pk
	/5iQ&Rc5RMbiuC=*G0nY^bAI1#!N#9P,_PrKiljYAEdd5Huefo"s>(DID*0qYE6NtnhZkFG^4-fS^2
	SeeY*3;:JW!a+b1d+%m$1m]Wl[q\65e1pJ&A$.]$#lX4;O_fJ0d;NF<[A0G"@Q&6,W.E#^eR$n"iBF
	?5sC.k;6h`96`G_r7l*Z.@LW4*U*lX49`d_Qp74UDY-q7hEUJZ&F[%g$SJ`=0BpB\%6XW;CR`!1c7.
	]3,q9[dI;BCR\h56iqc#%NpH@a%Vp?8=X4XImHoVFiR-'#f%/E_\[cI_)@D1#QIY<o:I"e7MP=.Por
	4j\R[]fDieoJ`Z0j\3T81Oa@Z=Q:a<2l*.#PeO"Afd5!!!e;eX.7D24I;O`7?>oA1.]`RUJ'G3<g^j
	G`&:7Q2q8!!!!95+Y_+q9Efs[7$7^=ViemS3&?:t;Q7%"V+!#'F05bc0NS?1$ra-)`*tGe&=b=kr1Y
	U>e*4BjKjbgaA[tSh0QA9s(5jW,8ks!TD[iA<<%;a'Dc\>$*#=,Kgan1gWmrSS7FUlm(5?6;<]6FY=
	dEW%:1eQq7YY>LWDkhs<[\[Z=SFBZ6N@Y7h#?emqTWTH:3Y[=5,QO>=`UU?:*^Op-)(`8I=-H@`8d?
	:RR4OraVUR1cmn,Hs80cbba#4uKhRIVg,29XU+]8[U*>Pj.lV@J'FNqqYsaa3o8R3L&;2=N0>IF*G'
	:=#Za7?Y]iZhC`F>*)L#Y,q5u+?Lil-g(MKX)`Ci!qOp%ltZcIpn(E&c'aG6id3$AD`e7M(7/DYJB<
	V,Ab3c"8`!DcO1N6;c7obEo-(VRj@MH@(![\XZbQf'.:H\8f.:**--Bf>bgb<ibWQlC+97NCKZC!/&
	*1PtK#)n_W,ocf^M6A.&bQ*fm4(/jG/75:0hNO9t]-#(g7$*t$i:F4V:emJ8$c1:?K*gNL)[4C5a,!
	J#UaV<;TYW\5?=@<CH*;"#bfX*bVT8Qm;R(L_#;;nP0)0P=a"GPESL![qeAkheKeg8($#hcL,Ucfao
	qeS95PH$OIPe*m$$UX;u=['Hu8.[;[r$O25H4[$!`rqad[MH[-2l`IW_U!W5qY!Sgi(ks.=JO$HR^-
	4>/A%13fd3t%8(ks%pI/)pQUCTs:m$gkQeWuPgf@JNc?>heC/eeX#$O`4l"[S5h38E'7p#_`^g?j'K
	9(gZ*rm^E2]3HtV9ZFB><%>k,Ht?l#H?smOBdjs[$3UD=_k),4M6X<?cFUb@EAA6=l:FI.KiOI\a6h
	+catuK'&?D&=eOjC$(,$Fr1-uUK,c`2mO:_\n,*GK-$ft<8m>F`sP1)"JLilT^9b:2hAuX6]Fir/r2
	R.f,*R.G6Qao`+iGa$(*gUB\jYB+5#(qJ<g!.c9[9?k:eWS$"Jfn[3)1nMh0PIjt&HnMnSh?AQ8u5F
	f<m0TF]j>V2(p$d(+7"k#$AIm7m6i/'Za8]bH9!O57&&<!!<Cm/gIe<J<i`(GB`p`elg%sr%L.R1c-
	6NGbg+LS==TS.-Bf;U#*[/>Ze6Ddk^9EGk)F$)h''+2X4:rc[[k6:S>L!AMMWXtn_Ws]5<XT*Kd;@g
	Hi,aY6kQq0-*+GR<iKbIZM^b9N`d:c4Q0g+S$.uS^0K(.jj0M:WE2ZX2B=oB<0#j7*[F='4J$#eBX?
	A_P2+^BaQN.Gb@2<#Ze:q!qIqQe-BlP:+M]9Cc9+fJe&]VOq"Qh@cfZdmEk+lmFFSf?^q]s%rKbQ9%
	j$mq,jB8-8u5F$CMU=]h:U@.'FL@ag2+4hkKgWG[Lr_*8u4kJcor5&U'?8/aX<]CET.+U@6U<E_dXI
	[^VBf*-_?.5@c;9./sgW[s/h/)P-96e]7Jd@AQ^u($Irge?EYs4C*JeiW)joE_1fUhT#S>L_]9hI]s
	-f1p9up22&\=Rrfc.r[/aG'-&i6l9N(qG_o_P>g\"q2]nBksD`%HCrmh2P^@,O1<,-l2?7qSbj7.@V
	:(RPgitOq%Q6d0#A27:t@q.20]RKf?O2pSPl]]G$%1Nb9UTn")8u5G!?7uqJ6D74>TE"8acP@<5F1I
	g[@VKXpHuMRmL*`&*g"BMn8em9'ipjNH,2(#r&s6(k[+T8BH[@\hgqYVF\$oG<<*Ci=qYGN`3ODtl=
	=ar96J61@_ocLF(5o$"\X=tHmZX$;:^ama?bfI$PYs+sgtR1ag[aUgp9r_6o2-rs!s"QF:Pn[VXn7O
	N<LR?8*.R\O!@.X$,5#ueJB*:N==KO7nGJ,b-N3Aq';\<(/gV8Q_.JZ>Kcs4'XfehpmdB'ohUL'IdR
	u5Z&2ZO59p-bf&6sIB80eh)"N)q=3Z8qV4$#FrEs7WF__;LRiP*%?_83tFrU+kk4$+]ZEf,qD^?cY)
	.k<,&QR`m]2DmA*o#`H_J>oLsY)MDhYuE3<8u5db#(iN1k2uP00oGPtI'-00lg#K.)S11`,)<#Dl-e
	fQQ^s4F^@MgB^mleGh`ghpX#nKONO%5JXH:Z`5!)rbnC8O\1n!THZb1DThB&h;GW*FLX"t-g>RlI\F
	M<p:0m][\%msNP^[-r5j%5[?D'nY3eNCD)e>j8r+b!pH@lKPjl"IXc3Utk]r\bT%%LrsU"9O4lE9u5
	^:akE!qh7AqaN002-KBml#(uO=o4r,W[9=#.d6o/Z!8ot1UX<moCiIFaB?m$(a5`:Q`+l^"j)M4oX/
	i:R@JK-<X7*h'INT1=*#un:gh8Mc5CVDVpN'GH@q.!RMBgj@p!1h,XfnpL4c!c.b*@9$MX'm2]6E^a
	-2E6&(W,-M,SFg/DGDGioCMQ!8_2MFUC5pLY#K]Hb#FA%rTdP2]m-L9_qV5-_71KJM-1UK@0hImU3h
	J?8qP`=pSu-!.2FT?M5AWZmb"(mGaC]b-q"%8>_!t'>bst*L34DK:V4SLYC0i`o>Xtpnu\=@5Ps6LZ
	dmLPEq89_\Qo,h5Q&?4[I1Ms,n^O)+Nq(\Gl5R@)c!;plPOY2Rm8+#==aFP*fl*:GV5=-8J2$MgY5A
	ajKW48Uf-Hq`.Zrahq?[;)N@B_93dRDbN2g.>\RthK-5urkArdCV,GED7AJ7Gf<2[?DQ[EQ[C,+:\H
	Ds7pV66C4J>T=bN3KH)?=/Q@"9NEnaUV0>^l(o[Dg,(h;)@9.`,$srP=[n*9jENnG!!6(PWF4!!*pg
	8i;cC=d#X"(]j^8IX1h.>P;kk0?+/fM'SV:RWOuJ8absLro'(,IrkHWX$MF_#Qt,8!%-Vs;"X3`4p:
	re6.#Ga]$js2ml2:s_a@V0QBTm4cCEj8Y<X5g>R:Cl8u6-3Al_r5?l6&IX4u:Z&;`dZK-;:s:JOXd!
	;cQgpj>9WC?DBtXk)XsAo@IuZY,&KLYZi,T?lullSBH=gb[8>pDio2a)Ol/6P,JQ,UOib<``?G#Vm<
	Xfka\7''XMLA28H%k"Piki8>a@cMNCnXf\]`RuLY;q<+AGV,Fq;]4d++$399GWU?CQIT'Dm0J&Ip!Q
	99sWW2J(NV/iJN5n;2Qpn2Xb@UKI<A#'@)X:@/!Ilfomsk:5IoiOMN7/>Ke0kg9>6+`n2j[\j!-fp?
	e_^#%j4\Di+^?EH(5jt)1L+?9&r@/&BkqKWV,CRi\\>e,F*$s,[;0rtrQ(*G>]OLrDnid\4qIk=jmr
	EMrpLm;ItORo-s2e[kOUWNhOL41Y?%]o`b]R3:T)YA!/nhEd*T#-\U!l5eV/^2Oc^6,5k#oIr_a:1.
	@!N%;Yd4cqbS+fC?93@.Zqj0>[12X'NTjdhe%0*o^G<mjp=Mt\m'Z/C64-WSQ;.3f-V9!jTKScn:?]
	SCPuBerD2?>,*>tYQ:N9bPET7qen?mQcCAT_BsHF[6D<nVf3Zp>1b]>R[9A@'0fqIDm+ASgcH`,WTn
	bca'oU$tTo^CQM2@'mXesS3Zs)k-F6>SF3YiMJE?'JgNAkr?*<\YJf$)@^f\"i-!s_:c8,q51d.b'c
	k)*fLeoh?+I_<!iN:[(mjkFu<FsG+N99XY2]D8<&G)1q!liu7ZE-n@*TMb[/G=pH<f9=<e;cAn%AFa
	t-PEV3rlg"[>1c7-23HE&S2AZ^SNK"C%@0Qo?*oYPkK4B1P3LNQ!2`I5NAuF+'rVH2HN=C_4dbNV?3
	]c!IfU0kD\<M%+kg;VS"[25&\i<F_npb"AV_dRB:9.=r"T>qK:UKHLi6ORKk2tghk<kr)6m<3K">)2
	WB@!/t9\2gQh7>I&2\usZ,n^NFa(oI+Hg\H-^Ai<=&ah#-,+2*5f=m]A3Ig,:X5euc&jH>&Ae]a]6;
	oY-r:R7CN?H<'Ie4k95X5n!@j80UW?`+5?iB7k#_N!8-U/1MKq(n_N*#=]3a&LPLVfuh-nrbrO+T_n
	>Nka+KgGgXYXYC5Hjk&d^go3?=9aE:Tbr1L9:cJW/A_S3j1dLneIpdn1'iJV1bA:Hn9T4TSPl>J8KR
	WG<%8W,4T-'5.[>limghMZhZ-`ER9E0rGaAC1!!#SZ:.26O@"J
	ASCII85End
End


// PNG: width= 121, height= 41
Picture FSbutton
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!"&!!!!?#Qau+!$_T;0)ttP$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
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
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c
	>J7!"Vdq6pXdsg9b!uGSB8*4u4*KUD_m)9<oigCj_@^*2>c8Y[bmom/Z[?#"TOYQ\=12P224;Z;"`]
	34hnjq9c%lD0JWGZ_f@##W0mfPU5GN)]0P.CqsH3`Y[=6KWL)M\rAPp>kWpc>8Sdc".r)5k'PAn^%9
	OnRJ6XiZ@Daa7o(M]dM)^9!!!!=TN[_AJCkAX!ZZS(!oUF>l%B`NIV+]EJJKTp,_m9(M3RQ$k?FCER
	o'kg&1#!8o/o;M%)^"m0h;Qa71"PO#(pl580j?Yag"r!/M/OZh_IupYu,rb+(/RZPm>Bu'6s#$5nX0
	3+ufV-.#a.:!To,l!_EB&1WO2`&Ron1k]mTS=I'DO_hm(@dh1c$U8U(pH(LXl/<rgfNgi8W.*M2l0V
	lR!&kpO/'68nZK*T<s((lKqYh;AG3$dE$"s)%]Thn9(Ol/3jGi^^lb9I*X;%uH3%S;gO;:Oe#bo^O3
	!?M7;+?'J:.Gt@0m34MnO8R&e&Oj^7&SJ7s\hE!.[6Q&@!9iCE(nsBZ3Kl-[4cSKHS.Vl(qp@nUmGG
	ZC.4OMDQ*[d%hLGS(IJ`_0V:%=>!eJ/UpB/5/@7Fnd]me$L+gUa>SrLMa#teIXo)a*3("R5KBMhG)"
	_GsYptD'7.o:?HM._>:;.8$0$>^n&nH[q6o*L,fN/W]qX&]B*JbA?\f@JMR<)bu]Z;;r+(^sDE<D/Z
	2NQ#@Bf<-tJ$igk%,2oC`Ia!D_Mr3gfQ3.*tW,cb5T1V&<]>+7c0s'B+>*Q)?Z'c'E"DuB`*2(*j+l
	EG+!!lPCnFuG-b#[(XM1e:sL&>caV)i,cmIQNk:QM7N+H_3-HspPrjP-T[?r3h%2OhtOn`8cl/6K-L
	ZEb*3d2P#^n2uaSLe&eK7\]s6j*49m9jV-I78X>BS3(q4FEB>c,paB:`g_lg/=&mebnK5B3\hJgZSg
	qBF-!?MU.oAoj/Ihi'Jc*IdL2/f#e7&?b'mDq!?9pM[s*?_-gu5Noj;UDEf7[jWi*Td1$b-kF^HlMT
	mPuW)NAO`XDp:l&rD9Qg"+_T"@5^.;gNc$_r7iSm6&_8kn&\>cTV$XQ7Z;V04*Gcf6?5m#m<QR*G"j
	.eUrL,1ef@Gn^oQ(MAL,NggMK_]rrdPdrN""2o!Y=0N\o79r8,^P-fq`02,U:dg4tYa/:erM^*K.dV
	4EjVkug.eGDg)UQ6L0"6,nc`GTqrLFX/MGX@FNBnI\8aF&,HC^`b[SND$r='%m9&\HlEZ7JFA(l%/7
	ju,+UNf8oN%)]A%NoLCsBJ^VIa&*P9a^k);ob9i7*%-k>.Olo+CtRZd\SO0n;Q3X$9BQU;(;Vk7ci\
	6B:;Q)Kl*"qW^hT\ND-(ud=U2YemU:.pdp8<.=K\=(Le4oqLtU-8"d'WL2^0UhB?h*J.]@kZjG.NN2
	EY>hbKbOh`(^:U!!n2'1sPW>6UO4`FnM=hHN<!jfs;lbW2HQ6@^0USg?Ij9OsIB>Z=o]HESTMlpj>9
	-<dX5f[5aH1E-V!:bo8TZ*$$'5G3p2BdhG5>P334ZTV1dEh;&D<e8%K?,Wr[O'QW^J\TE_'XpKl"A"
	M:QPYNp,eX;W?RM39njoU_o,;\Z-*)X8tn]pr+_Ff+ZRB`rC77L,q+]iK0'Bs@%!Dp$(24MpQN/Skb
	iq7TuTVSAO.[B/Wj9,MbVpfqcmbR0nl>S_QQ'EYZaTMZ2H?smLAnG(EQGHrgFQa9f+@S^f>IJ?&R7p
	MXoYV2(ZremL/ji5icP'nAZ1/n3)-!bn9r0jV9O1S!]#<$_l?6ej@XC]kn$F)'7#(AK5mKbY$)0X;h
	,_=1n"^XaIR.O[*i>5PPGQ%h**Rgci0Jiiq!mA'ioS@MbN8<mr;93S/hmcuS=Ehf>$>-7lZ>1-*5?q
	!G"tfXX0960P%7!MKjLriZ=F8-&5&eie>Z@u/M.L7r-0q@>IQYR+4ngYCJ=4p*K44Y\%Ik=9B<^NJb
	rVDQ/G`c``kOF>`2(g[r\C\9hI9dQ(649)9jWnHj/rnEYfN)TpY2[QQZ-q/5iNWc^qV8S""%?Vl$?*
	rV"u@VfQZjXK\q5['\=lYoGcE"NPMRk@pBF96(HY??tXtjQ,B[(GGLVpZLZ"Yq17[^k!BJ.[S>dg/$
	l<1H&=Hp;(N+_71I);<XMOJfXkM_3lB7:@:.Q.MB6gfJ#>Yd_o*Z<UU.,l/f*)rr'K/k^\T#^tAk7`
	*X-A@q0!jI.4t("UfpuTZcHVH2d0`ZOFa-`F=Zl')uJFK>G[OaWj<9Pa.M^p!m,m^V?\Ea(i$=YM\L
	L1O=QDfDt^HN'J419:N*Q3YBham^ro7*kpighfQZe)k[e\Rm+P&s8#Xf+'3(Flo7%K$5hs$jl"Y<Pg
	sM[=k77C2Dd7p/?@<973[l5@d3+?kjRsf#XY<6\6Q0e=0CWFjFkG0rr2ooXkin`7PQ6C6:_<3R3)Ho
	A3?7FMC]&m>bC:cM%$E)Ts5P)$uF`/i@3u5JnY4Nj(#P\^!DS=k_:9l+@+df6jgc?,S_X/L10Te'Ld
	e3L.!5J5Tgm`*(1@6\@@p'Bog;ej1%^X)B'Md8P*>-#!ie/_h@d(r*dT!2BmhdOl1:_&.h*`-\W*?M
	g7ce`?560&87#q5XCYBiCSPRa<Rr=N^<T-`(rff^]B0:'HmI9bAEqL3%M$i0(*`>f?#]Ta)S@d9VG:
	=`F=uUBq"0DNoRXZQU_T4IX7aS'+0HbLDc#+PPh*DceW<nn)he`p#R*YUK)2BdTu\L*,1*"5#A!CK8
	neI_I]uiR;0RGUf,t,#i.*C`ajo0U>L6AL1053<!5L+*)B1!MVn-'Unl;]cI($:O[uiqfeSTJ.#QGd
	1^q9p-lRq1io5C;G@4N@2IDgncoXJrfP7"tU?CnO2s5%_]8@ML^tW;<)VCJdhd6mJ"M[Y7Cq=S&m\V
	Wh;Fk8NWutj6iLqD1Mc3PQ3K>%"*aZI%D(lh!GW[fW5PaB("U,'AZ^I\)YLe\@=BSd0='(_j/5Ai2_
	_CH)V&pB5\c3pU_r(A3KMhNa%d%$K?BLf-Z/IRGm<]r-2r=1:UO8sO4]\\th48m:m<Nigi>WlKKhtY
	M[P`$j>laSlJ-ggPn\l;SZ'`dJbK\:;[r*3XP4eM@.[>mgBng%C-76Z?E@_m[[;/iiHFh/WZ.nXL"U
	/eQqq//`4O66Vji<.%/fjugT<NemFPfRf@5U#sh7eoSk6ah6Ss-?bqSOsb>ZjPr*DdVWN(;("Y<\hQ
	h2Q>8[8:b,isK>E?\=5gK0OW0*IIPKIGokrqYL&-*;=\?]tM,@jlIaZf%&<iN<r$N"@9^"qWg25Y-5
	%4['UOfEIo=]e'g`0;-dJ`_^[l?bd3<F!7nmn^Nu7@HJGN77t#$n3s5.=6ainbI&<_nFTmt038dKD*
	F6ct03A,q#cU^<ifu0GnHZ)74;l;j&5`ibJ"!<SK?4_8hr%R:<pneUfAlD>@^2f-VU%L,Hsg?T['Xp
	_?pLpIa#=Qh7Uo:m&HE(>Jcc5fgq7o2,*D*^HCj;d/m[2fhEF+e50)SGG0I:7..Z>@T7C7!r:t0Xr\
	J35LAZi-h,V+"4Bh7*8SE;nBn]!o5c.gk=aNfpBnsGQP"VTM]A7VK51TR*=12A!QYjrk!filQ#iA")
	<i^Z;^%YJUebSh"CMR\j#7"*??,(hOa)R`"p/uc),Q9T,]m=g3AAi:BMaX<=rr,!'m^0I4lZB`)m-K
	E6(LFUj+YMM]k]lH]"iZD.g[B)@9`K@Ps+TIsbKV%L%l?[B@jHb/U+(#GX?P6%N=Jaj4[.Vm,6"`1p
	FW(44I%PjjicnTN7+1sHR6at4aGI60prioT?`)*;4mH7:G3#*11,/bSLBB`fWi>12Rg*%SN1a<)N>p
	HP*(m3C"&r>NXi\Wme(n<]=Ya_DdQkD:ahROjXDW-,pakhY?qM7R\j@CQVsg,cH_GgN[U/b-+dub0F
	RH;r:m9\*sO/A<Wt9_%^A5jHfBXDL^%^nD>Eur/'CaHfeatfo=m&(RLfS]U='*?C!$*[40,/<]u"J(
	DP.'"nh[;I`m[jF3-X''\cRYV!/\)(gc.8QaKhm<,[spMo]ahEq%/BNb0.t$8kKA@(`4*o==g^Z%)]
	;G-kqY1QS2^[DV[@U<bo%pXB$iCP0msm@^-2m_PX3-naUT-_f5F[H,>M[#R2CO&2]s_V`*j8UKd/Cf
	[_VOGg5i<b=mGk6URRe^B'^R(n`V!=MV]Q(Cu+5-04=;QZd8kpo<_cW+G:E4"U3W^'9em('"VM#nqs
	"[Pj#;(l!l:UDf,(p[6jkKnTMGp[6kgf%0Wf_JpRAo+XVN2)SB7<pFe<q"Nn@ji_PN>9]2WqWXoq_o
	)#gq87SU.huA,7.DSPJ*4#0SuH&0JL9G8*t.eU!fSdMDeA_a_rL7JT)dJOX,82MQ#^inGI&FV`ke:-
	[&-:m^V?$<!eHT#Pg%?FPKEI@1X?>\_S_->+#n4iVWg'U1OGt7@'HK(7A3PFc"=Xqmr18)@e'6g\BS
	Vq=n_hqqKOa@d]idA`=Qo+>S4QZm@V.3YYL'7rN5:E#D%r\\@pSD!'geIg_\=TLPhurnjr;+n%<o*q
	SG[/AH<0k,`rS9<%8FbCc7bR,hfM5LY(joWMqn!k"K$=c_2T_2RU!%>-6Am_EsYaG4O_9TqNX?>gDq
	'bHctH4Ees+lAc$%M?.LH9E;;%5cZdMr?9JHHaF\RG8OAQk(=Z4Sj3=L(JKP0rN/imDJk3'BRD/Rh;
	/%L)fLDIiBSOTaN=r$%:*7Fd:h%mo>TlMC:-)W@6QAT*2%%c#_9>"m)6p4KJ<=R,No:\@J4[K$5\>K
	"tjf&&-PRpNs#N83A0GI<=T4GP'NXkR$^^NeO#sKr\.j8;U74gg*b*@hr=\>&jV0FQ4O$E!=_6./tb
	0H$-@udQM6VY1asl1,Y=$VjDoP*'UiUd3N`cVOSHW]IU+%6^b[Jt:$Zo4"lf?pr-neK,fc@;1D-7?z
	8OZBBY!QNJ
	ASCII85End
End




Function disablelowcolorz(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	svar choosecolortablename=root:ARToFData:choosecolortablename
	if(checked)
	Slider lowzcolorz,win=VisualizeARToFData,disable=2
	else
	Slider lowzcolorz,win=VisualizeARToFData,disable=0
	endif
	choosecolortable(ctrlName,0,choosecolortablename)
End

Function disablehighcolorz(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	svar choosecolortablename=root:ARToFData:choosecolortablename
	if(checked)
	Slider highcolorz,win=VisualizeARToFData,disable=2
	else
	Slider highcolorz,win=VisualizeARToFData,disable=0
	endif
	choosecolortable(ctrlName,0,choosecolortablename)
End

Function delete3dwaves(ctrlName) : ButtonControl
	String ctrlName
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	//print tmp[V_Value][0]
	string prestr
	prestr=tmp[V_Value]
	killwaves/Z $prestr
	refreshartofdata(ctrlName)
End



// PNG: width= 137, height= 46
Picture deletebuttonjxw
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!"2!!!!C#Qau+!$ZMH:B1@p$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
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
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c
	>J7!"_1_6pXdsg?`!W>SL8J^K&elc-f<FRggRd,!lYci#iqE1^PdEk/G8LhKqiD3,0`!`43iU8OOH:
	O@c/nY"26X0>En3Ru.!I?o/aQ,GK^A719M/L..bdB'H2%WdE(hE1t]<#\`5,\Y$I6Dq2D]J%#A;eI2
	GNJ$"'#ln<jAh.eB$rV*I\jp-=cg=k9Yr-XFAo&)o<Xk#:@cEt!eNNe2]aN4.1@W#1GIWOk3_e/L>X
	1^>R%o/a,a,Z]RHe*!kH[C+?e`mA_ipu3Sg"G'GmHlZs/2/c>@@3a8Qsg*g<`PtS4@62i+'"'+V`Wq
	\hfcFb+bU\mS,2V!s1.C%EKSXY3M4u@/hScJ4aT*1Npc83:S5qTar1NpQ@8,)a#7egUf8g6^%)$ro2
	/@^!<E4rmVHTO=h]9/?XFmA#QUToUL/<.Q2(.LdCnmMiJ$+64^E*j.kG*.i!FFJO1WMQfPL#[?IAOX
	'g`0;i\=$A4ad&O7D]HDDp>4NgpqK=:/9+1oB1CjfBIB4RI"fQ$O[=u1G]=\#U)NjS"!VY:sdan=/S
	fa3l5/.TsJCXVPg?Tk2mQjL4FdSNTRCAlL!tE[r*2q8H8a@#nnZ@\ol3Bcd)c4=30)6DXMl9&%6qn\
	Ym(+r:`GSj/\9/.4T2]Y[TfLR9jpr/,GY]0Z24Prci>j[U73>k<7i;Ki0d[1.RBH4aHTD6HEgs()7Q
	A1c3.h`-?QQ%;YmdRlC*9pJ\`#;JBTLU0=Z7"JMWe,WRlQj1&Md<*!&6n\uN"+P?)Tb0%kiOqOlt)\
	Nc=F=/4W,9rtr]Nk@Q)&X;-(+,;=Mi3L93h;=mcg[$!c),^an6AI^,DBNq].@f^Wr(dYF'tdjfMti;
	d=YdJfg"D4"<s+grsJFm2u41XA\eOM6F+5GHWXk)SNF;ncQ;p#@m#&-jN,E`M\e%$KnZL*.[T(!]68
	%,CF_8+__A@#YsCZA4O4*0`ji+O/1rPmW37'IL3;h5p%J)'KEOU1oCGUH8\&j$L*-b1@::dXp[-_%S
	"!&8$\Ap0*#oV*6O:LF]=GJ;P`u:S"_fe3RbE4F9Q2s$X@]Jii<hmW""5GMWn;=-Shd^<D9Y:T<!E,
	P8,d>?r4EPIh]Vc^<Zul7_GA!&!X8XX#o`!j0>CEE()!;Ld(5aN['VYQ4WS$+cPI3,P*hV-#Z2ua"U
	,&Q+X(=i@#T<rfMP[M-@Ur3M@'k)Vg)&AD)Rm:Ct@qFc6>q/e&I@d)]K`qbIG0rVkg+:'FHcX\!ia(
	PK>XqdNii(QX>2eq!_]hKWhRt@U^P)Z=4l:bN0HR($!;noCMRcK4KAD-`cfc*mI:_Td<QbOksskSlg
	7Ni?cB%R8mn6(l4EfRY0r*8F$HaE0kN>L\Ren*01++!WWFdd4PQtrk!)NKF;,*`Pjo^lu4p('JEg#h
	k[%n!$Hsa4Km.G55OK<lKW,qq9Yg&q>'i\1?6E9O,/T'"9A]C]fp5_//Ka*NZ>TYrAmrGj1+12A<fb
	5#Qi?D8u8i#[$9\UKMYfSR93H;\8cM.&r?a$9M`V]9OD/ar;#q3:7UMdQjgl3(&ZNuYlLH;FdbgP<E
	=[tKCK)o19Rf/Y>_EcX*ri1rd9d#I1TZGpH":?WNZ[3!?qLP+:Q=NpR.i=X!KO3M_ZcIb1k[_Uni[8
	I`@<a*ZcAS+OIX9(b6;Xio8sjTV+rE/fd'!:rH#/<[T.<YUh<a`NlSiAkPci$OdGcOlGQe=&Dh'1`A
	B7MiWo0#mh1aPK$dIF)u8<Y?W^;\8``>H2ta#>XCaYc'"e;o0!'"6P$#jVMZ8_%[,4gX5U0lc[,7%2
	CAV>!$24D"@+ICP-Rcn<VW;LX/N]Xiu!F\%kpMSR\s0=KL)X@@K=r6a$'-62KO*-:fLE$A]pCDYct*
	*VqUN])?M)u&rEEZUZ9L^.i+%s#)GU>84lMFo(!EY@9M/jYq0.i0I8%,DA@-hqXn]BD3$mW.)Ra5<N
	*V?_q=AMCY,^H1c.`K')GO#9T2`E'*LT`%migfeZN5lqQB0L5Ss::M3DViUee.;?ih=cO?pMZOA-k3
	1@>HE+iI%A+CHQ.YP(Kr:tZ!P!^I;.,XLX[b!0J#Hd%:FC\m\f#7_a;kietHXCPJ"@2M=e#T:t[^:q
	>OnaZ&8mXcRc//oNIX&LQSN'DaeoXj'Nh0K&"rR'$?"U,'Q]3TMSd@Fi(R9m'-$k1&k$\G&#l!3^e=
	k:jBD:PXdUJk<rfsLKL01rC65!RHHNFa+5J,fQNKReT+AP<U)hfTqB_6PaZ3Pu-p<ra[Y)B!8M?ZX4
	XAK)R-2f77oPK@9D@qjp6<MEpMh;)@?>,p'9_SX1.a;V:#5etPr^HAM%6HH<8]*\oRVb`p[%H&dh@2
	Osn%mTsl!!rr<FMB6[iG`VcY^r\LdFgb(_Y\+T1)GARA>5]oKQUZ&-[0&41@^_Zi%<o4MAH:'0g32-
	q:aScZW"p$TQG@#DV220iGc`S`OYa^%3M(a-3fJIOt=doh7@`>''m3eHgeXd^A5bpZphqg`Y`3B6m>
	69=gl)[J*"h<dF$?OD9Fq7ZMn6,d";9W;Vg2D'-mu2iWT;`!I'i03oS%#AAuLWo^[@G$R+Tsl[.^6&
	WK8$jiS=0k?Up%(e^]'d/g4%4O:37[;,&Q+bVaif^S76cX+8/Z)aqK,sl<?j>]mK6.=W%H1Qd0CQu7
	irm=[Q,Ph7BIYbU8/`gY'+FjG'!?bpgmhe:m;!W%3s4bQcqri^0;X+,ToBY`.042H[n*_o5gY&o$Vm
	BR/M\e%,LkrQB.Ilru>-7Mjl-fun_TU,\Z9l'BM,'u#lPD-VFJ$IC-XM,P4ZN)O)FI6&:!U%se_lHI
	70p:h`6<Zdlb;Ne*60X9\?Mm/kL-2"rVc]E&Y.[:l=7<X(G&Z"(Dh:F;Wc2kj5]/u>[6(6e0L/IL>k
	Wdq"sqA?+T\-k@H%?P0n[U=s#C;YO<n,l=UY05X<[]M$*qa0EH`g![7:I=_hg=[Vab)+hbS&QS2_6l
	KVgqAm!PrkB%dR!4Hh'hU'V7#Uq8SX0&LHH*SjAA2<iMo\:g)H(Q-BqpA8oOG%&d4?d]IF'q69&HFQ
	tRm6rcJqC.jSpP%&j1^7t4O7s%]%(1B:j4^`9O1q0+tXG8U--0&]KA8;q`Z@K3B9+WIJ4bADN&R>>F
	Vr^S;EriC<aoDlKIHAB?77ToD;=-D''%%!0(7[oQZ?0+Zu._.1lX`KE)Pt>^,SIeP"+lSbK-X7RdT!
	DJ0Cm)B'M0(?Wh'7BItQ2)R7<p[5^Be@tqYlXRtqM6oXH;GE]CPo6N70N8AZA7]=02`KUrA=Y;H7lI
	L^*"IW5!Q6_:n$LqT\Wk-"fblbl"bY>*Jf>ZSYC3[bm2fa"j,ZFMbKFsEM'F5i?)WLaa'joEL1tOCI
	cm8GBVRWRWi;tCqsCl3k=DFI]jC0ik2mjVr(76gr-?V[4Z@<9*"uj`Zg%EQXt]Tldk278bT3V0Hb%f
	41>lMi&C@M5#TuHa&;1>q"G3(['s(\$7b#0Np=ns#Csi#!*ZhSkZ!tDE_;\-PSZfN2[dMt`f4M@K/>
	Ao7j4.4<V;P6>U8+J@)@b$ac?5OY_V*c/Q2UUS%n1=Pa?Fug@q52>JOfg/mc0_:p9\>&>lXmN5tn-*
	nUDRm2?MYVC-W=R+:uo.gqJlYV"<0^Od3Isj2UNC]>[-1V:(`u(kk:B7gP>$$%gOPdSa.J-i/Y_#QS
	i@p?f?GH>A2C-To_iq<"16mHrp#&J5V+JUq8T6)F5Ip/Y-lfPEHY<_/!W%)_GbZ_sh'C*^n"p[)6fc
	@.>T%OZS6bn!WZ!X&_>83jXeC!,C1[80!`77WCB'2FK\5Qm/KA6_XfV3b7AQ'W,8LK2?-1iD!P`G2f
	<=/)F`I!g<0C/-Vp%1W9oK+InYrG-1a.Hbe=c"JqGAnDs@`aP_1hS!,5Zso!%>&AM/\7cM;(h[Gm/m
	c3#WiCqO!F/f*M*uCRi5).^,+;hD+hN!an$tq!MM&ehL$VC5RKFg3-N_41e;9<2o?O#mQt:2J`ij^M
	D]RXs!gX6K&'?no5etRifi`NO%#T$B[&0b!MoNdSMoKt<i#Wp\bEaa/BJfV[m>Hm\]70^i$id"7C:.
	70FdI7Kq!g.QcA3ZlI!kR4]pRWpg!TBPbC+eeQRl:FIf9,CW[a4S,dK`k%hM(oG5Et"G5Gn=d9"p0Q
	:U'[iI7]t<_57U!>lZ,JQ3hUk?eq8U*ouJDVis8Vi3cUJfm>fFYj)O#r'^'55pu5L<dsr`[=QRF<7d
	n"pX@73fL?8#f5J=Unsn:'FNP8Cu;ri2)VeQ\sbNWcB5_Nc'k>sF+&K8TgOU*#D[W=hPDa.fk_$3/;
	T1@U>$`=r:/"TbdtBsmd=uUW>ro;2)Y'cLEECqmMub#gtflm_rJeS!^I#GkfH)4Ukd_P$kRgi#U-'$
	APUCZf:3?f(-=r&XS_9)heE^"0q:LZ"_?-K+5QTB45=$KQ=[tO_^uWsF`fP^*4dufeG(OpXO-3R57\
	8A-94)SkP>&RI&0_4\NA./M\[n52Jq0PP96>j=&;_D1$1H5b*4>s.Ou9A6:cKOr5+-qSaW"$@7!X]b
	dhfX"@7!NGGce;l#\FWY&o,dq(lQO6kVL3.<+:B*t&Gt<lq8=4R>fF$l1SBj$RJXAM5Er\stEu;Y9$
	?;N$&$ak$*J+2`4(ps2!_UU^1?7[Zq.F66/m;L.s#<ViT1))&VX5'QGMR58IcgF("[`Dol:==b5E6o
	&iGbbq%YC02&V_h<f#:Ra8E]Y&Xiq!e@c!Be\,V!,!G5!E[pBg^eEC:2bUF69j;[FNdVG^=[^H$O8`
	]NKQYb/4X;)Lnj"qWHHSHeJW)(]Xi),1P]<STO'/eMuq%7I\1O::-NN53)>'+hpSi$cseJ/H#G;cY8
	XYUN5qdaY1<r_?b>lJoK_fM70k$p$:4f_/d"r0Gk9A5"rKm9mJ;5EZFiMl`YY[G`6TO;,L2.DXOfAb
	<eQ`a##G*)8#IKDk:pC>_X'qA72p/5OT%URQ2i)K&&&AbK!@hlg*kXEcOR\e8"ZR9q+TUiguIRiQ0<
	iY-5$qbN/`^E&cFM=YgbJYqP6WSHf.Bs49rjDbdPCak!</4n8.HqPQc3J,b'%#7Lfh<%?_4D4@H$kC
	\k:lI;fG]KDKkQS)R4R$dYA*lX)nXBk[p%ipD5=W=h5d(f2Q^h99f2J(#FQe.A7m^dArK$e7R8bp+b
	A<u'n>@6jG=673nC2.MSp%>/_iW1Wpa^d<![9DsML$W/^kkb;[!/lSmZNf[MZ2ak)!(fUS7'8jaJc
	ASCII85End
End

// PNG: width= 141, height= 47
Picture newmovieicon
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!"5!!!!D#Qau+!#QreB)ho3$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
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
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c
	>J7!#X9Y6pXdsg<=kgFAm>Yrk16Lqn=q%PB8*f\hAT@CdP*8q!!=:K#8pf"2Y>!)1hSi3hj\R3eACW
	%Od5X]+klFMGiY1.FNW9(V27kRO6:*PIpko\EEXXj,=O=^ZYOO^N.WEc#_b)^3Q@FI6JICBc?dH3#W
	_TCMITH*fi]58P)KNX49tC;ls*@`lA#?=D"o8hS"82Vc+iR,pju(om2D2+d^C4io4&kf"Z\VHs5s>f
	!1sDidh+<T?m1Vr<@mTUJX(C*j&I+D-Btb\GE\W"@^_a55WQ9ZT\3PZO2EGbaC9SmHrB"9bRkf?EY/
	sTZ)g*a2c7#-<N*!T/^hbX/g$UN#<3>&RU%dF`hj"N#=FI;Q8RB-V8@;_M&jF)?8[(d,XEA+#\#le_
	&MLdr\;Yj.H=Xj.HALZE:6EBZTc)O%nB<mltdL(lmYKYE#lmYt^]GQ'[id1lWX!NZC1k*BH#@50dCZ
	8^_4W^&@ZZ(G8tfoiQ[XJ'4-02fIQKBptcpIJ`_dr:.h&USH%5Jfr(Ra*6q)FnFnFTAB8Vg`8J"C&e
	1="@:KnIIcILFmIoQla,"rN?I;Q4&)!*D)=tRPZ2SRnBS55%mc;:)`Mq`G1&57Ek0c)?XHc3`$G':O
	$CASk*ml%XJi/!U1nr*Y$IAH?2?E\"@6k\]Xb2JNi)&++RnN_Dk8q.K"9Cdgq7LY[UmXJ'c.\81k#/
	giLeL6.X0LJQgERW1)QfAN;i+C46tIGi,iGE+?_VPm+M!LqXs='T>0f4Ilg9OF@jT,^]&B=YK>tp\)
	4?iX:,;c*fjsg[V_p<T-ai\j7*Ne%DDc;ldr=I5C<*?AnGXJ9++JCDnPUpfkgYkZ1dS>pYC&NTd]4#
	qtKI1F7A*R*612`O54^2Zt\"BZY+43\<3)C`]U91hKnMerVKC2S_<pS_hNRt)sqaqAS(84^A:TK[qB
	N9*ZLk)._6ELhVrQa%1V-5EI$Gh;bba5^3qB3?G6'i-$/M0\PoD$Gs!.WgO8;4TfmbrGeIFae`q6;b
	KJ':$4;NCLM<2`\od269q+\:m-O(DZY%I3LK.Sar9:,O10A27SCtW)]A)_]fk_.RUTUcf`>;llT#uc
	s)jW-a*Xi6)(<ajc.kqHBDMOh97k'>lk<I;-rq\Yq#946GM_EAX?G/rR&:;(j5lcOif!-sMk\))%4a
	,5Ir!O=DqYe40<PL1:\rEHJe+RUIbuRbA1N2,4"@63p>+1qM=0>fmnTY=k+A(#Eo*l-<p%S1_!3gY6
	g?.P[Oc^6Nd:b3N.Olp>(<c%:?FtB_YcuLCp\4CTQBda6i=CG-qu&L7P9fDeq^iRVDf79/!,L/e)&O
	4Slg*#7[Fs6df<8OoIc8E('bqI]VrpUI;MkN.?bVtnPVQZ6SAt^C"Fsn\7=brhq"VA.X33S;c>8ijm
	;QH*,qgWY`mq-ASi34iVb\sN\<%g=MP@7[]fLZBHkqWo@2P$b(l!%@>TSqb3]aibc^k@P*^iIeNfK-
	#<`WgDAJGpp4Y>7(M\kR%SI7^p#_H-]?Ca)tVF2Uo;3\n+Ze9^iIscYA^juSHDr-G2MmM1*p[6in)N
	B]U!!!!`*e5BS]6EStG[ige!'[$UXj-e,5Q>*")h9%2"9BJI`+"EmV(O@%\9RP%YV<a[UT^Yr]lE)e
	q"Vd^LAE2h?4K+9Qcmq:hnN^D&fer=H?p,*8P`,P&;86g_D'2CYnRP!?E_+_iI]$X&I8ME0)+qubL`
	n&e*H[S52U+_C:2b,YqQTeXf^EbAP4]o[+jsm,9ojJ0(o$f*"IbKB!YSjWDjcV*IZtfNIcW]KgL?bk
	aaeZ/ml>o<i[MZ8Ol:+a^f]ah,RP.BsgDg)[Z]fhgBK'DF1X*aJYte_q@10eAbs+#(o4D%R5+$prb>
	:RPi8F2WcuIq@j3qPa5YElEW0&+(CJ"PpI_&@2O1VhS$ULpL[uJ;%tlI3;DU%?gc^[oB+;eC:-)c4h
	[_iB'n<[++<dD5Tm#/YMZWs97D?(eS;4cW<jT'.9d>dlg!clHga+]ai*.W//HFJM\eVQi.K4>08mg/
	ace):I/'qMYjg#56Sb(2\[hODf3V[iCmiggXfACInpe*DjF2.?,b&Z/_[grs]QeSi`#0&?mAmEcSN)
	)tn,&.5fWgV_S?lhP,tTdA/4-2]Uo%`.!j9#hH>Dit[H$;]g=lDMo;SmqNfB$8D/K74P>>F9QcWbnS
	'CE:s#p^?l07HQNupT,jN-,eF7]"pY?\X/aX<\p'GQ'?3.:Yq2/Cc.&G5JN_pGY<.OsH<iu^F1FR\5
	)JUrC%eC:(]SmAsO\Ql:/P9q"Z'n,l9LXW.sJ)Q(t8kVh7HgeWa?[RtYLn(!*<NB.,"G5@]g*^i0P#
	QA';^)h1]mIe9r\6,^<@$^Ts8@oj-VhmW4a[(\HWs^$hVYkZ@TMd*Fkc?>)73SDF6C9Q@KBZ7G06&k
	>V;qZYq>T"_Ig-j0O.dbW_b+,P*,eF-n[.Gq0[`Y+>5BD+;!>>FfW-dRo-l\bEo-(VG\,I@^-%;JOZ
	F!lg"q,Ms0Km'+0HfmbNM(3&s!ebN7TpIG8YKHbJ8rF66#iddlu"g=k7Frpc&M=0I)7PujhVR6jabS
	';-;5c<'?%hI\[r]'<M#;%nF,D`t7XsQ:p6)TWb\ONX"b('/tB521]*VQ0,M0JiAe^^MfkKR>Ir3c1
	h9Glp@1`O=d2Ob?qVB$Nl%5Ar_`PP<frVc[AP=[BnO,]-ec0!9?2qr/WoB4F]*"E7+8kVgf>V8b"(5
	p.@Z)H4<Oc^4U!2NLAMP:B.KRu'F5)p`kL1))C*@WEd17?APoenW`CtuO_,g#Z@cOUHonT_^pdSa\:
	*?,s`mHlbJ$qq$A#Qt\A\Ql;XES')4,S\B`*^;sc'FLsAWj5eu1!KU9)fN7BQD;J28p&(gfPkn)X4;
	q5%+LGN\'6h*eL&kuf(SeI(_"Dl&.`bY)'0j]oD'elJfr.pn\enAa5__Z3%lqGc">kDF!j1:?`@"bN
	fNi*oXN^pSPEh&=JeldrqY`L+$Fp,,p`_H+KsB9g.H5d5nLpfJfo_5Th$I"q0XGZk2tg+e`uJPYNP$
	/Bsh-!ZI.&sK>Cs#=E8G&cC[=NqXeKS_&s9pT"s1On0jXD%0ggGOH8EIQcnpp:pjJA1`D!q5GUqFqV
	;AK`908a@W:6;O2n,3T$(]95C^ekK3.d53VMgGq$7TA"9Ka(/=4OK;3]8cqYbk$RuO/@==dK&PphO8
	SNBoReOE"tE]>%o_h$jXh/4;V+.kZ@Eb8qGq"XWC))Hl\+HGKU@!OjU/shK)(l-!8"9JuIO2o^_1^J
	]ok2tt%qT-`K5+h:c3_>JS)]K_<+#fT]H$O\K]tO7;q$\&:=:@E\,K=^CJmaWeT[e';N"Ch6,Y@!#F
	inbu/L)$m`TFu<'ZGKL027(*0D3OFEUUR3+c::GJm]AK;"AV<h*Rfs+:&a@A[,>],9rW&USFRq"=5B
	A5'li,5nK/L,aD"!qti)VK-1F"J4YqOBsh-"_a0GrM#G0WG)Ja4Jfm#mcLC=BEcNpqj"LnR>V<53S!
	0&bhqsJ;#bTG0bN1lM4j;Uf5u;TBEc,c4+:t1ol3UYQoD*Vn#t`MY,o@K'Ze8e!UbN9+/$%Um9gXOF
	J69>9&tt=^WoC*\HY[Dp8nFs&/A?5j0MT.b!X&KQoRVo<;rr%FGBYtS_Z0\P0`6u]r57jnqYbjqQg8
	`Sj5T(8_o#V.f#Yp'Ci&J;rVP3K>BfGd0aNAERV(3"@LrYC!!!:V8u8i"ZP/(%MP>bjiIM(9Cc7d7l
	Xd;pUSG`E_Z^*-?XI/,6GhoXJ%gC1qG0?SPkbIuMZl=ONrX^TL;cc]Y-kYFJp79G&;9+sSVLpA%UdH
	d^&iHeA7`Cf&L!'mSkd`K%)^,GI5krhKTdcJ.4j6U_^pOr-O(!s30(&iC8k/^O[pmXiph7CQ0Qr&>8
	iL`il-g8Nq<)E3HO?(jmiQ_(ARk-f%/ELVPXG#%\,V)ma7e"0FS<lJl&[R//F,;@:<SRYum\ri&K"1
	orVH-A2;ii?[kc]"ARA:k09)\,l.93DRXt3E3QXREo4TZ2f@DaD/FtL80eg2mQkj'F>/M?6mTrd>.I
	m(P+YdS%gt/r![(^Al>J)]Iq&;,BbMe5e8Bc'P7sRSQ<$p_.MhV?rqL!*<bOBU&<$@35!P9Z6m@cFl
	W#>InaZ,nOi["c7n#kGe`rs+,X.h2_m%JM>I8(k\T?pNb=F0"2`3J7A?smpBBSF>2Dm>uKu23AHp40
	)/2ini;Q81/o,.r@PtI=)Os1SIRA)2[-n$]#rl\[J;H?gFPK@!3>.@i*Zt[u)/mR&]fZ7[273^.>MF
	+;,2`BCCCj&:fs(Q;NF1IfTBldN3kJW5@OC^\uk2n7B9r[2igU7j;SPuH3>/'pjrr-5p:+[6>',"b(
	.pLP==bq4@kZT)?84Z9*)NApPS]g,,AnK3IEi[a5j`3.41;<_\gUasWUX<1C<$[SsHp4/tVZT4]-Bi
	RpFVtSl%Yk])Q<LD6]A5ZC0.&"m3B;@uBF'3_N/S159P1P3+:)/bI!KF?l+MH<F?84g5PuXfao$V&7
	\^QR`DW\BVl*$;QOAMaa!IV7lc-q:K0_aHOm$nlG5DhB!_-[[<bk$S*f39Nd67C$IisrS??dX>C)s@
	Y0.0=B5!B/N!1N'Dp9m_b1aU(hVq#Oq?8&XuWn$CcelG9;P*1ukP*4I6G!eVa=]sFrM%e@ddcSfDGO
	![,R\l:4PF;6i@^5"Vk(4]m$<C82(dS^^^L&6!0j)8"ONhAb,UC=Ka)a51Y-+qeio5e.-gGfbFmIV,
	o[-/_$n!;G5S.J8g[002H?qU\_pDo(e,"H8":5\DTMS$;***IM#Qb\I'e4>_Nt:'\IGO)X7n9%N/GR
	P@rfc$j^h,rjM'`3&3][K4p7\:X`"9J;LkpRif]dKU'GVB!k'"A)K*#Wlo6S+En)%c_=@l(UB!XKD,
	pa*.80eh)7)CKr?EZ:>/M0@AR7nq?M<oCI8WkQg$:,5aa$W]<L1-&<<)Z_J@9@PjntS^9+sS<5!+<f
	3!!'%!Wglg3F*@(5m\6F"\X^IffI0/h@:<"cQd+th.13k1!65,,CY7G!/sT%mP,=M0eXF`'_'#H#`E
	THf]7$cp^/Ld=KmjfTiG]tc,6nDW8<QrQeHA/ldg8H?1eg'&cCppTJO#<aR-=3h=0>fmom0=Z;aj-o
	n`.Zl<ia&E0H,oo@Y#YhOH@i@f12"">V9Zo=Mr%o+:'`)N&#@_g^+W@nG2ts.ot;=[^`iW`l?"sVbV
	AXFt/bLVV\#eCL;ZBXKTrD&:dq)92V(q1&un+8HL.DN'"-OkGUosNK)31l"9A>q\95?daI](h.k`Pl
	0e\),U:2D\g[a^^l0-eg=k84_4Xm]<iK%=*?C+1b1)$lku9-t$ADsRd\VeWM'A)'BJ_%`-P$UoYZS!
	nlthqZ'fspI=gQi9gAHCaO2o`6FRAJ_5@G]@ic$kf17;B"0.\Zub0#l>V,:)eg"G&LSXgse-o3Y8+s
	Q$g50@rm9f9C[qu*le+:&L=DJt"i!rtaj,Y922@)26]lOtBHRPX-WS=E#WYu7]aH0M0]cT\s\FL3PO
	0D@[PC]75mjlKXIerc(,#_LLRe(`X3R@T!V8JFTBMFpE1TI<F7<oZ0B;Q1cERPSSOEcUa?nF55DF.^
	VMbfRs5#(qj<SXuG0e'm@IGaQoH;3W2Zq"T)GfVBof-Bk]:XD-.\AS5Y"FEGa!5G&P'-ZGEA3su&cq
	teMf(6FrHpSd\7`tJRUJ0[F4+Jhtid5Ve.!?;>*4!,:JBda=%1guB'V$7#T4$3>=nkgm%q>'j:e^Yp
	:lLfImc.::i_6?_aZqdMl8kPg+C4(EAV55Im0bM;W%)^A^4Zd/nN6n%7'7;unn`%Mf<E1H)L51P2^#
	#W`VOt*0_SXaLdMQo^iPUG0X%6+;V+[0'daF_4k*_;nG92gSC=TuO[uNUdIl-T&,IFeNp+D7,cnkkk
	*.u'QQ%j@j5^e%u8`J^fW;lqjp@_NeSQrVi'no!E<;F%/Y*>08#7hl'n\l=%If&N6=gL^m8e;,V+Gd
	qoKS>-Qp\1F2HMR-nR$\_U9#YDK91hgr`l<K-qqm/gSc%frA2G4LB(M?rIX0nhL"WeF=&rA5>V6;6?
	l7I.1kUF5(l!J1br87k;Qn]Yg$JV1n!hSa'e<<=U@IjL!be#4"G.](a5c\l/N*S34$(">S"&.aQr#?
	AO7^b%[JfM@+"o8%&['Sc/a[\'(K$E40Vl.aI/!R1>;_j_"@8%h>runlB#foPN!TFL"UV6[MBI`$k@
	8VLCc6W&*Xos!?8"SUWMukC]j;fm*'Sapac[r%/M/5>^@]iH#_LRWei#BC;%s`[(%qLrcguCoR[T[d
	kK[r#\om8cV>oBlg=k88L5$6Bnb`:/]%5H`k&S"O*;B@/JNt>82-$R'alW(<7uf_+giL]4ZZPG0Jfs
	@ElPg`\E#dJE[0md''T#6&c-=:i+()X'mFns`)&Ee`!-#u*qc_4W1dqRfS.1*a0F01O4;gq)9'W@R&
	5#n02XR;SJ>.RtG5aoNQ)oj:DCt^rn>3nAjO3Januf-9*2fZ/?(o`dN/fsFS_G%piSCnWf7-cP%3%3
	u-jmkr==bd)U:e-doB+:YSPH695'ZRiW2OD(mbNh_eCiN#o&Rp0_SXd":M46Mc(@4mVJ3*]b%@uTU8
	%R7In<5Rh7Il4Y?nnSbo39Pq!V>R^AI?Vi#n*$'*n_W2Z*C?^Yc8(6YpS?7\f55l8j=fnD:j*R3Su!
	Ocb8$%i,or?Fk5--73?PU.$aE1Hnf<<"t4a'bqHBDr,m;jd.oBfH?O(s$o_Q5!h-u;\"QqaZ*gM\E*
	FSYOCAJNoRGg+>u%Ii]HVW!'p]@_u^]jI.,7n^)@bC?l<gkE+/Y1gpPPW1Ng9F)!2rsp[6ifjlM7R1
	:3N0DuZZ],X";]U*t^^_;T?d6=EM[$]:[@Oc^K8AS#GD4aZn]_hXYJR7qID^#%SWGDek`++F!Y[C%k
	R4'S[`"p0@UWiFY$<^*.jH1U0MJqF"n*.oQ(b7+XXMoCk$A5%Qp`5J;sb/e[MGr_Wp/shKj-jIk0[<
	?\8AS5Xk1`@&s+$=epf%(%Wi;3-4QRl;1YJ^GA!2h..msD`7R0nHE<E(5F,]>3F4[&KB/-nXVRM7eW
	bFMk"8Q/g9^Mg/(%QO<:/>lMpUk,\\GINa2K$Tbe!hNfH-C;&>XdW<f:_49Ro1N@92)Y'\[;06VQm>
	7S5`hD%H2$a_"Uc*M=KFb1OHu2UlI;erP*5\<H5&fse'hC%?Hp\'0FTls1pjZu5nF_O*klIDZC*L]-
	7:0*B&R50o/.Eq#_FI^:73l6XK67.il)>W`/,-\?+SP8eF`7h6Nf]<P*37jgBPPLA*UJ/ZrC"(J0:f
	<BF5(RB$Qp7R[VC\Edp9jV55FQ?YP^>B0n-LjoQFH/SZg5DX+MDloft'NU>SBpQ^/rq)l)X.@QWd1&
	]Y)P:'-16'*?`(5p_rff;#OaPh(^+sLK*@\TWmruL$),;CqCbaC72ObflK%)W\j&kYbgNZ:(-h;-=L
	>C*t(JtQ,E<b5fPQqSj/<r5f?6W)@pEmZ]q'FKO\i=kUUkic[o7>4&Oj1`LP`a62rjiEQ/,9nEb/M1
	kL4!GjM_m!3KGpOsk.krc@=_rOB`*=o28WjM5025WCbN4%eqo,M([6[Sid*jf)=5.&-JL?SRDPonHR
	kS9fo]aitHMrL''+>(t6m;qWBDeT.]m;P%&AuE'j5]19?r3cM8L+qJ<,+1VN(,&`L7Lj\$IM.aHu.N
	DalRPG//F#YJKRL.Gdp)6&.4-8hO9t)XOV&S,103"s(MS2BmS=pFgoPoV0lGj(5@U":RsOHUX:cN]3
	;=;ThtY6R4rXZqXsICcPm8s]j;cm&RdL7R0P>[Mk=aG%e7@/Zd1fC%hI:XofAWr/hSb316TUcM8eK3
	,U8DJl0e!-`l:K-7\`k\jDqe!,2r':s%Dg#i](h`=p4tY5To"TGe^PA+!6Gro(d[QPmbu>%R'gK!:*
	ptU4r%Dr;Zft!(fUS7'8jaJc
	ASCII85End
End

// PNG: width= 141, height= 47
Picture playmovieicon
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!"5!!!!D#Qau+!#QreB)ho3$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
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
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c
	>J7!"?2*6pXdsg?`!YCfOP[hJ9=&pHJ?J#rq'U0U\"fQltt$QiUeqEV!/[4;=#0<(Ra&<Q^@PWZ"h^
	UhLR,rlD8k9bSsQ'L`;(#s\?'O@TLdnDI-=3Wm6Zle!OR(upO&I362tT!Mf&Z-DOPR7:qVZ&7(SV/t
	6K]%Z%EqlIiIf"'_PB7Cb<cK4YCCTY"Q]tGEuQP^;4=R48Xc<e)(C%^cALfg_.hL"_)!-@Yf5q/Wbk
	/T7ArsmEUD""I5N3Qis==b5O,\^q*E6dQc\W8uSG[b,krVH2j^](fBlGSMma,_='j*:%L]rP29)BU%
	+JG/^1,mHb%Yc)Wg3>]a+nF/+3XBDlaLeaR+rQ-FZ<3+P4HhP,A_@)n*,=dca3d&S*pY9i90udg;Aj
	6.^_r9S5.#PHNh)[PV3B]P("28a?!mU1>X]>OS6D8AsqXsCKn]oG*Cc3esq!>?5^A@,q>V<L8s8IB6
	^"58gil$\YYq`*)K+C.JX]D?sVEXtNe'ZRjp@e47Dng^@Eq7)$$[mGO)`MZi[Vadqp$8NRV_a`7F*$
	s$"/8+jG%0IRMRM&4,RthUFReA0.#Ql0pYF-?cH42MA&jU(:/7ru]m@kf/X8r)Vl/_IiPT_XF,rKX=
	Ar/IeC<!7?[c.W<46Vrdacme3M2\+fX,AAR58J:3]]TJjd`75@q&oA]tI]#[5<E4<1NA?r/Wp_rFlZ
	\BDTo>98/-CI^len[8\Ur4aOK5VakO9CY,^KNlT/Z:7j^ucTV$XEQ9(q55A`P,b4JH++O4-(LPBs15
	msV4TNue8I?,Oap0#9d+-[CPj7T#/!W`93Y2>`hu9ckptpR,2Tn_AH@3$*H1U0tWMqk;-RL13HKqJi
	NfIbDH)=Cd+Q@qS#F6rGp>70\"Y^>&Hf*`<J+i53c?V%/S!oeWeUbeG=0"=C;#$GCg<d.sB><69A#B
	m4[C,[e2r=<A\PbuHc8fCY\om>ID;2L/a,X@BL_taiL:KXUFiCAQs7(/[n^i9J\mf5qH<TVGh>trL+
	3/BJKb.rj7RZ^YPVQK8OsDGBM#-9=!7olWg"EgB[RVBajHWeQ=g;GT/Ib*uPf_djDSq*jET=ifqrd]
	;gqWkH.HU3ooUBd5=Y(>pg$HP-#M\"f^%_!.o?P.e!9a9VQX8CVF!kJaM_De(HLrU0G'.rph7K".2D
	?iSp=jL1@V9?:JHH.oI39^X2E*R5g9aFeII5arpYUK#[F];9TRZaeYL_S#dqAFRD9m-HJ(sjiJUrCG
	p@c,d\k<>!mC1trGB\Q2h0633ZeMs-\(6kgjhlia?b(2gFEDX!mbQas.#O$)3AN?Fdbir3s8D[F?bS
	Xlc(7%CZELHME,]dHW`=9"H0<u<S5P5![UI(.IJ``/3d%I3[s'8$=_jpJo(d\4q!mB[f</t.DSGSRq
	Z[91Y@#%.4?WPW!tVcI[Otq$]Xte&AnEB^cbKDKb=t]*%1Nc%%NV"+R4/o0DnYgE\FT!mcX+5,/YC@
	]4F+6-USFZ^Ab5'/?[r%Io^oM3c<;/f=>E/:lDq*0rVZ6p(G8Z:Q*IU!6D74,(2%5k.[A/A.p$c%gu
	Z_G!T<7nX.8dTTqPYlG4FQ\+iMIC8/+K[6UP&CDnc%%0m;[$'gs#`+4'-A@q0#F;Q3nRcd'fk`\q_i
	=>#q)?Wo]K3]aibcQ6R)k<+sM"TD<"eVl5AYpbKc#QWjD%Ok<^&OhiVhHF-aeO&>pCoCO>3p-Jc?)h
	-^\$WMaGB`6Aq'?55!"d9Xk<,ge(gs9tcFL=)Uie&Fj0\5*W'j&F:#:Ju!+>$ld<q-o[<J2sjum4uZ
	Q"[hop`>(#B'NqH9G5KB76.I"J?kFW9b%brW#l&E#LLf@KM\dhO:6Rf3r8S+CcBO&gp(5848&++;#5
	1-Vh`C#@Pb3k+&p3=mN/o7U'B(dDd)7[;j2ICRDHb1*$n7g5>X]HZ+l5hD[8J"K11J'+kg"U(ALsiE
	/ml_XJf:Ke^RaUU:SX\EKIShA6M&C[GR4On[_rf[>YC[X1:?-NQPS+h3bA$6[/2+V>hD%R>&"mcO9$
	F75O%gfcO(B]HI>8`FjO[<@CM-?7c&k&Nr;VUSQo[;tBOE6!(,KI`R6CTS-lD#hFrKNet!R%#B=<[s
	BAer'jQ^%^4t"s+$M)%^`f>]MHJ90`Y+JIu,8Y5[uf3jK3ZJ1&<-EJukL+N71ZL*'(HP&nHj!/PUt5
	k*!O9G-&'KKq4?Q..8`BPVC1o[-/bR>c2^g^k[05GhWr,^<@YOqnL_K'!r$&=aRcae_<Q\Ip;:8qBl
	BN\VP:s3%gbf[BKH\Qn$*M(p>;o@@,]S[M94Y-gt\iuA%9!+X5-#)mg3`orLhjroRJ&:OS=6TNo7Hh
	Z*n>C1^DLPCO#@u+5/8uW8n/C\=,&?:Wm'Ok*i!%oNE`hc'L;(7GL8kDXJ'SM:)/62)KjdEl1CgHL#
	WV^o8nU)l5OE8uTRi%_>,$O%C!>-k:bCQG_Fm]fG4d_Jf,Ge*,:a2sjl>=#dp@Qg0%h9)@4*N<Db6]
	>D2h`6)Lk1/R')JF#QsBh;@a#dd)/p-""N.HfOX-bOOq\4e!f3n9Yfp1UAY/ku-Va?:adsJ)IJFt]6
	H)>*X[#T_nSG@?j+J^YV^p>![5Z;hDk*d[o4c2Np7r<p$</O;L/"-qF`qq7]QiuEq=BkD70m>(NT7N
	p6Ya#4TP='fG0ti]H`sh#!%nCH`h`sq7i=m\'TnK/J5A\O1?KEpN0Uda#_0:ZFj$5tZ,'o,V7Ap%96
	77<ZIP+pbLXlT4f;"#[P\k8CVbZ\XL/7_2")tL8P7)b=%\0m(MFTs4nR)gSXl>MrVaXO_rYoaDJh'H
	K1S@\RfL65!g34.]IjjiU1@M#<)P,98r?.h78a^F</R1Nl^@JU(t5'&Z!5m,rp"-5S]g5(HES]P'Ii
	,\o8J#,hJq]e36ttu$C=X7@N%PK(o<I]P),ou+_QL=83JOV/R;XfD/F.1O!",QLJFMV3/1TS4CZ]ga
	F!BHX_KeD^"V6cRj9ft67#SV<(&2[W<`eT7@l6sR:FHfjuhZ(`jl"`V)+J$A4AI4?3B>\GK+r=XYsE
	&oZk:&R1qW//sg?gC'p5!#bc-,0Js8*!g<rm!7&-[Z*E9H@4>bGRghq:KMS6NoqAs15kBC-oB^eVbZ
	Z)kC,2#2eEj0&;^4Rt!.%uF&3K=\S7_gE31DA;a$r\aVHg36'H-?AiHEdCWspE:'(X=0`iM&jDu#:0
	@]`\3<%?/;c&I^B9he?ANK'WtKlB\o+N.Qj=?M*4r:p&s0d_-2?t$km+[h]2VXC[%5f=Kq=q`T`,Uu
	'1L1A).c8)SkeikE-3,A#V4`CT,Tpk1pS#UloAICP6DY.pbC:3jq_\f;J[8IhbX:X5Js#oWYJg`U.E
	00QQ0T9b+0u4Y;0ok:VOc`;'0#_hcf[q$iR<h.k4,BiLSQI_AH+tTD3$BZpM+Ed@W$Fe=,>""ATdUP
	p3CdJDAui\;datS=N+s+d8Z_[MS2\Fo&K3[Z!kCQkkQotgmLX&24\`%S6fAk1<A'UW*?D7_X%Fg/e6
	8d/UU@8&XFZ_C70b%">ZER67M'QMS<+s>E?\/r"`Zh5&m(7ZX7:nVq(<hn)Hn"7`[..%mu@!p\0*'V
	,WHG"L`@"gF5i&-V.(m%ngRjJ?s"mFLiU%Rp$1'oTg2!T%1UnB^ug7c/Ej7bShs$%;JB!Z.%AK\@f,
	lBR5MOn7Zoak"Pa&^Nh2F^@RMWD$M`pYCK+e2,9S]')+/>Pj.:<"@$i>1OXsVXd/[q$[H"YSkuc^9e
	%9c8;)XmQn#MTs#nJ_\A>IH`&NT$/L5$8ETqR$Y*a6b_i4.1JV^t&Li+oaSg9k_b^AI?;"G3lG5CIq
	Q?Vb$H=l(R48nM$L,I1I7NC5*\)2T6QV<!5Q7#^p=hJ)-ditLH_m:qKYenh0p.Q(/(k\;\@.^>tkq<
	?>A7t1"fJ,W9e>!MlIURn'KQBi;_<"qbu'P0%fTS,9s4"!E)\LHpfP9`__,`^oL[0Fnka)O;8J)Z;4
	Sq$b8`<:cL\_8alo;nPV0L,S?0[T^RY\sH(::gMg:Pf2eehd;ILj0T[mo+](&8cu]T%6\*('b-EE;s
	3Ko()g-pV3'p)ut-l?N3K":,)_K!!#SZ:.26O@"J
	ASCII85End
End

// JPEG: width= 129, height= 43
Picture tabledit
	ASCII85Begin
	s4IA0!"_al8O`[\!W`9l!([(is5=8)7<iNY!!#_f!%IsK!!iQ0!>5A7!!!!"!!*'"!?(qA!!!!"!!!
	".!?2"B!!!!"!!!"6!@RpM!!!!"!!3-#!AOQU!!!!=!!!">!AXWV!!!!5!!!"ZLM6_k!!!!"!!!"p!
	!!#G!"/XS!!"AX!"/XS!!"AX6"FnCAKXf_Dffo=BQ%i46W5c`=(uP_Dg-7&1,(F;3\WNS0f'q,0fh'
	L3]/Vl!!!!$TE,#p!!!!"!!*'"TE5)r!!!!"!!!",TE>/s!!!!"!!!!Az!!!!'!<W<(!!!!"!!WE'!
	?(qA!!!!"!!!$@!?2"B!!!!"!!!$H!@RpM!!!!"!!3-#!W`9(!!!!"!!!$P!Wi?)!!!!"!!!8ez!!!
	!i!!!!"!!!!i!!!!"s4IA0!"_al8O`[\!WW3k!([(is6Tdp6"FnCAR@f!!!3,f!"M;*Ddm8XA:OX[!
	!3,S!/(=\#RC\B#Rh"G$kWjS$P=*a$k*X](_[Pt',)2p$k*OQ$k*^V$k*OQ$k*OQ$k*OQ$k*OQ$k*O
	Q$k*OQ$k*OF%1<OQ%LisZ%M0<a%Ls0e%LrsY'G1`^$k*OV&I]'V$k*OV$k*OQ$k*OQ$k*OQ$k*OQ$k
	*OQ$k*OQ$k*OQs1eUH#QPtI?ipER!!3`5!tbS6h#IQX#62UB56(Za"T\W)!<E3$z!!!*$!<NB-"pYD
	?$4?k7!<iK)!<E3%z!!!!"!!36*"U52;#mq%O!!*3'!s/T,"U>5;"To/h!<<05!sBb[0a0j?@1si)J
	MIEDOeK$H,:""%_.#2WEe;\+#:5O3nDWnIF#=`-Z@aJlP>l']_P;32(Xc=CAb*0\_p`bgo0t*lUkQ1
	@`73l?V7":mjn2YdG(u<[[`6n\p,>KCB6T,tVmj^ukP#Pg!WiB("9\f0"U52:"pHjb!!3`7+YaT45u
	D'1+qk,8JWUY?YsK\O;UOti,\#_QJs&K"'k;;AnKeATU9]CV-8iZg7$CTF(M#s72KWNio!="edrj^B
	7[0^&[$ASZjRf:V`RX)C<b?N0QDV+1f&lZR2b-q^GDDN_\&\O&!"8r1!!3`7&HG#qln.HYk4KdnBuH
	bn`oT(Sp=EO(!6)fr>IsO#Dn5/H^K4e<SMq5]fZ*nA=!%:#g,TjEHh"i!eAZT6=CHC#e#L/uI<t=bq
	9!LQ!!\:H7o5rX.biK/96+r.4I0JJBW!("g%qVpha8'qaQOHN(s%k6Kp/c^:Y"gHr2mp;!4FV3nd*k
	g/_GJIVqZ)8)"nr4eip,!@uF)7EO!-\g>?hW^SJ&F;kHMRFgJ)YQK6h9I'X_Y75s:SIoQ8Kk[GW2aJ
	5THVe#H/a1e"JgumR6?nDl.b,MNA>,kf9e:7<ZcU?'pYQfoD!$r6dUhjagLDuuJAQO$S!+Ep]n&il3
	AX-6X&i-asmX<@;oGZ7!5-@!=3bBc<Z&SZ`XRs,AaV<9`Pj53YcD>`a:T!OVF!@>#Fa(<,gY_W<].)
	!BI5o-CjD;8oCiS3j1L%-:f_nnN*U5Q#MuNc9Ekh1O'E6Y'rrC+jI2f)4Mlbt,`hsa00s\97/?PD1+
	4Kq%q`&@s[Ec$_ZE2X?du6>J7a!9i`uV\]27jlgO4Aa=hM75[NRN3^"7u)WV]R7ZIG7sZI@*f?>j@_
	W:%kjLRJD[g"8YbVDc,eC]+0dh)jJp?gKe`:BZ7i0>Irt/g[9A&^K1s@5+.9-!,Q.p(+WhfrmAodS"
	3('3g3\?YV<\&l1Ed6en*)%FL1QNnu9m2lq6$^EX9arf(j2GJ1A;5!,q/;^IqI'MLM_hchs2frr?kE
	rrD*lE4Soal<QI*E@Al3jVG,o=&U)BEH@[\G@NMEhedj7C#r?a:"Y`?W8nPQBs$s]GlUiernl7UI[6
	[M.r+=pl.Hs-:OP*3\^.k6he70k<D@Dsp!hg3U]1=8o?pS;d-CIgfhYGOA_$L35AIZU?BMgKafX=o"
	u=f`[JoWfJXXoc^M1O;drr+Tmo4^ef'[IMPO.&tB)99<o\\p5!$g%o!!KB1Q[qq9annP>4u9J8gO#?
	2NFRkeJQ=HUCX;iMJ*PF%qR8r*r&YkIYlf!K2SO*?OD2HOg[>%;fUlNUMhhbmWVkQNU->a3DB%9XK,
	E@5D%=F*6-]%B2R'dh.]qU*oY3Ke'DrcmVNKDMlbfHsnStiU==[k]YNS1%qcMFYh,ZVPj1R\SCL=&R
	FH30keS]7FFYGXPH-'K<^?]sjf6nb'g$cELU\';Y^S?bUPDRboBt_d5H^lUkO*U\*/ZuAXR8Ha"k:/
	N&)X4nm@i$k\'J;SNdQA`Q=@DgNe$44:-!48NcuLkGO&E!T3i?L#ZRqHI`Kf%j^4Up*g5f`)&+(hk!
	\<n\gs<6--/5]544F'k^LM[fIc&QArr@aIJ^f!O)(!rRf[Ms?\rCl5AZTCX[klR<f]R_F.b1)&U,tQ
	/Ojrmo=&lZ<HM,M7l5nUPJ&"3-@nS?G*I3o5\-s+0/s]XtC2&.`InTV6CN$VpYIjBjl\`,'%:*0d@+
	s2^NFO%0!(j<Hh2HD<:ImG!>FPJYpAY-4HGA(@PLMW?Hca#a&tm:_*\qMPSAt*cg_e;]hu8i>!(Eqo
	5;/nkf.h(*pX=I<_oWB&]s$0Ki9fF,cMDlnoTE-Zg9Bkb[YnkmEGOi5DkjShHX"s6D.D"0D1.n%^RC
	Hm3Y0pu[WMJMooH%8`FF*NdE)%Kq`+758[8.Wl_!+bXNg#%Fe#_#R?*='F5(c(Fff/3%L"iNb\PQ$9
	+g`@cU>5.>8u)]^rNh7q7aB^eTDqjGOO>:Pgmrr6>a5mAcQUNCQ5%?NiX#m2oA:kVQ/JK?VCC#;e:+
	7A_2c=FlVNC]WnlLJ6#FcgA,M&hsab:rrA&NrrDGuq7T_$k;i3<SVG;AZr_7hXHPj65=F+O+/$r&TD
	F]7bNTM_kr@K`.Z<*;QatA@`]_7gQSGAXMVNSW;ubPNm1)fdBQ&!2F(fK2+>YW(!'!;:9`uaBz&-)\
	1zzz!'!;:9a!*Lz9&9OK!([(i!([(izz!71cI!'gSczz!#Pe<!+Z-2!!!&8!rr>*"98E&!"UFX!,QI
	oD?'Y:z!!!!Y6:jlRm/R+d!!!Q18,rVi!<<0$8,rVi!<<0\6:jlS-3+#G!!!K/zz!'bu6!'!;:9`tn
	*z"98E%GW8#]9`u=6z"98E%*]QJX9`stez#ljr*z!!*'Z6:jlS$31&+!!!$"!'!;:9d^JPz$31),z!
	!!'[6:jlRo`+sl!!#Oi04ner!<?qJAcN#8z!<=cbAcMi3Tp_>L"onW'!!!$"1&q:S!<?:'!!!3'z!<
	=tW!!!$"/H>bN"onW'!!!$Z6:jlRp](9o!!$s<!<<*!s8W-!s8W-!s8W-!s8W-!s8W*$kPtS_!<<*!
	s8W-!s8W-!s8W-!s8W-!s8W*$kPtS_!<<*!s8W-!s8W-!s8W-!s8W-!s8W*$kPtS_!<<*!s8W-!s8W
	-!s8W-!s8W-!s8W*$kPtTB6:jlSz!!!'#!B<D;9`tLtz#QOi)z!'!;:9a!-Mz"9AN(!B<D;9a!$Jz"
	onZ(!!!'[6:jlS#QOi)!!!Q1!!!$"!!5Cc!!5Cc!!!!Y6:jlS*WQ0?!!!-%!!!!Y6:jlS)?9a;!!>F
	c!!!3'zz!!",A!!$C,!!!18.VK'SQiJ]<0`V1R!<<*"zzzz!<<*"zz?iU0,+92BAzzz!!*'"zzzz!"
	],1!!*'"zDKTc3!!!!#!!!!'@W-C,A91OUC1@5D!!*'"z;Iaf'!!!!%z<,Z^uCi=3(zz9P%gXCi=3(
	zz6?I-_Ci=3(!!!!Az;J0ZbCi=3(!!!",!!!!'F)5Q#ATLmg9QL16!!,l)C1@5D!!*'"!!!!&F)5Q#
	AH2]1&c_n3#BO]q@qA5"Ci=3(z!!!!(B6%p5E(NH6Df01fz!!!4AEbT0#DIm^.D#aP9$q4*2Bk(^ME
	bT0#D?'Y:%:OC$Db"AVATD4$ARkc@!!#uDE+NTuF_q*Y!").nCh[Bj<-`Foz8Sr)_!!!!'@W-C,A91
	OUC1@5D!!*'"z;Iaf'!!!!%z<,Z^uCi=3(zz9P%gXCi=3(zz6?I-_Ci=3(!!!!Az;J0ZbCi=3(!!!"
	,!!!!$F`M:t79ELh!!!$"z!,cpqCfEi*;ucmu!<<*"!!!!nF(]&`79ELh!!!$"z#%;=i<+0E=79ELh
	!!!$"z%V''dCfFtjF@gOE<)$%qDf9Fm!!!!)@qBIm<+U;r<(0ng!!!!"z!"!=WEdC#fBkM<pDKTdr!
	!!Nu;f$/XAOp`[H9l@]B5R\L!!d%GAmoguF8u:@$$Km#F?s_WB5V9uF_q*Y!"VLsCh[Bj<b6;n6#:7
	JD?'Y:#@qCX@<HC.!!!!,@V8&HCi=>nH#R>+DKTdr!!!U";f$/XAO8mSDes?4<-`Foz:2b#]!!!!*F
	Dl+oF`_\9FDPl5B)ho3z$>a9cFAI%$F(KH0Df01fz!!!F:Dfg)>D,5:rF(KH0Df01fz!!!CIBkM+$:
	N^c#ATVa,DJ&qL!!!!Y6:jlS-ia5I!!!E-!!!$an,NFg!!!!Y6:jlS'EA+5!!!-%!!!0^6:jlS$ig8
	-!!iZ,!!!$"!!$C,!!",A!!+2B!$hOE!!hZe(]XU:f`0k0&5#D`7K<Gj!!#Oi8,rYim/RP\A8bpg?U
	INf!WVQf%RFWD@V#OMJ,fQL!WUmSKE)Dd#RC_B$jd4K&ISpR&JYfb$kF'i',))o',V;i$k*OQ$kWmV
	$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*.G$O[CR%1j!Z&/5Ta%MTTe%Lrs_&I]'V$k*^[$k*OQ$k*
	^V$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*OQ$k*RE^]4rP!$D8L!s'SG!YGG8&HVpf!!E9+s24q&!!!$'!
	<E3%!<E0#z!!<3%!X&Z2#7(VC$NU5."T\W)!<E3$z!!!$"!WrQ/"pYD?$4@CF!<`E*!X&Q.#6kG;!t
	6sd!!3`7"<eC4"[Q!o'-_FI1'SGTTs6p/,Sa4n@P]i]K$cpj-'D3riULE!2&;plK-j!M<+JG7UNAC1
	dT,:<o!="edrj^B7OOFrKs[,`eE$7u[Dg\Xoi>[JL6e^F`n';G2b-q^GDDN_\&[+`pCRB,!W`?*"9S
	c1"pYA;"Z6;\!YGMX0bOUT;.4Gg'*U.BOVFLo66j<EdI8q;@c;?ZP!`._@rjKs,mG-ZZ@`B/28[d0P
	>n:nA49KVFCjJ&Z\66FFlW'_Pba#?Q,M25oVJt7e`HI)Ap/opVRFLqk4U/]7os>ILR4pJa8ain$j-M
	1!YGMH!'^JM/a5+SocC#F`1n[!jY`n.f3@#1`PQ\#](Vb7\a$lC='tco2\Z2C`r7Mj*rM)Q3>>>;n\
	3K%`HGBd@<U&IWkW=tHLA!4b%q"W#)S[::nmk;gXS&PEc3ftQ=EI!V^!G>qPVd!6PIDZkSOdHaHB5N
	PHf.(ea1'KXi15>[P<:&#hU.LfR6PngMS;Sp)K7H5-!mXMbYmEZ+I9phf#s<Up"B/T1/NtZ`7Q%jP4
	KtZPl2"2ro=8<;Kh_@NSIgUSY`'AG$AO^7)@_kML5d/IoeCWNH,&W`us^J,2CU7*`WQ#)J9>,n^W^C
	h\'J)kuA(=*=NC@E6(Mb08aSPuQoZ19t-PIEg[A)V#cjXul59AgdP^NVln[oXet^'\/,+lDV;>V0An
	7VX=8%,,-0%GIM2=ht.Yq.EuaY35_]UCpogLESHO1>Hui5rE&t=l8HP<rr=uu^[e]Ern,3i!6?[=)l
	J+BXQ/`gV]+;EZF>-2Xdbb$e+R_W3,;g-cEUZ\XOcR`N&ltgb:9s@*Ot\u],clleUQQ7LQRp_dsAG)
	oCATQ+"!\0gKQ=ZQqq3slBtXHp9EMCq2$O&qG'4m;<i>:%ZHkrPh)2U?#O[q`PQ\#]&pWZmWoV_<tG
	'iR>LqDCh%r1.q/2OdEADVSO_BpP?@R`0Y;#_o\BW#A^(!mZh"e"WQh=,9&%j9#fsO,q//<F._bo_D
	sG*P92\]GI]hbXr0`EA!,Q-E!9=`2\l$B1>rp_[.*&RR(:!O6;]Jt\F.Hfb@l;!XD1>,kj].dEfTiq
	Ej:RMgXn(7m!*+1@hpm4*QD&FOC?a(/fbrI=I5PTHcaqK\BQc:69lK=ieD7j6rr@-3dSp1mlM?Rp:J
	eE0eb4kbC:AUtOh-%aXkW[V1=t3erpQM2Ra8%LBu/KOG-p,p<.0ALmVee_m+_5GqS/iuhs(.@,Lueo
	"KYssJPTIkqaP0]1U6Q+H^T#9@uD@Y<\Q(?ch^:alHsYK[mmt,3uc\S"*(J%^2IPDBtkbEmf!%8T3n
	j]L^Vh6r7q:G5-ELT)qi\m(u(Qt%`3?Sc1H$7Ye'Z\Xl$#J^H;E.r#3eVOk"O=_kO1$EO$Wf.q8R_k
	W[Vq=Ost;<]e(V]g)C0?`@[[NhlF"DJgJ;0JldTa^KA,lZU_.I37V)n$i:koS18uUQ"W)M:8bE^!4Z
	GS1Ck*H2UerY-Ito;,81p.QV&Xl+Dpa(GUsb/j?Ab4<jc,7.j!tZ$L:6=BJYOE\Xh[;Q?TTVdpCG/X
	<T[Q.KfcK7BEFO(13]m4'=^/+d`7c`pRugTe1Ke,)AE@sq.%hpLom!/4-ue9YC<-.s0ge2iN!NHS<5
	XCK)U1Y&\]kC2MBeX^?I4$K0seF<05<OK>_ouu(R*n^4:^ca\f9.T]VH'LP&$l+XPQ<B)[Bn#Du9DS
	F"Dmd<_]CS8QMRG,H?!A^bg=Ff6@ikXM8Zg_&N,q-X82o:-Rf&WJrrC&b^XorYe2eq'ahKnMTZ=qk1
	2Cs$`prEN(sU@`rfd?^7B9]Y0;dXY0l-%JdsEO]aUT#uYM1tnmGG1oqKlN?P#G]@Yj0B>MeVj(C[+T
	3UTrEt>LR>(A(#.0I@GZ"R[./=&)&_GFT&?7O/P7]@s9lZaS,#u3;#L-Z26cOTA\5#c0=kCS?\9GO,
	WpVgN/d*X^d8!"ZYJbCX;iM&b:7o7(2Gd)q=Ama0aLp^:>B:FWTFan(cEWeBMnuD7GU<!,GeSNM5!b
	X;:Xk_b7/0WnmMY9E)%lATd0If83LMj5]45Z*gie<_g]hq.go+n6#/Z!0-XN!:@Do]i1Zg3V?OGL<A
	8X=)l?`P<S:s7+Zi/T[.bQqN:$ckml&(38HeKMqm*S\]q.o4iDc80rE!KgjE!us4IB36:jlS+TMKB!
	!$"!!!!$#!!!!0!'pTq!,hjH!+c-Q!)NZ/!,hjZ!,hjY!,)@N!,qo<!##>u!+Z(J!+Gq>!$D8<!,)@
	N!-A3Z!-8-R!,hjV!$D8/!)ikR!!!!"!'!;:9`tY#z#65#0!!!$#!<;!gb\2*?E&oX*DK@F=A8bpg/
	n8g:06goE0/5(50*"+!G]7)$CLqT1@V'1dDET34]>#O4Bk0@N=#E]+9lNI2BPC"`Eb/0q:/k_LCL]A
	8,!S764Ero3D/a?'FC?;:D/=*23d<e3@:X:cANF^M3c/GM@4rfIGWL(dE-,kY,!faX@V$Za9i)s"Df
	TD31bLL7@k]\s+>bu/1,h*M1,(7%9lFnl7V-$O0f^@30JGF.1,:mI0KLmI+<VdL+<VdL,!I,3Eb&cC
	;FEtsG\q87F#n>PAj%>OFEDI_0/%NnG:n(q/oPcC0/5II3A3'A0/>:7Eb&c6F*VYF@<aAAF!Dkm+?X
	[TAi`=kF(96)E-,f4DBNt1Aia@0Dfp.b+sJ.SD/=*23b2_`,%u(?E&oX*E-62;/oPcC04\QGASbppA
	SuU20/5(60-VN`D/=*23d>(P4X+Q]FDs8o05bh`@:X:cAM.J2D(g-BE%`pu0J=UmG\q87F#nPSE(s%
	i,%u(?E&oX*DK@F=A8bpg/n8g:06goE0/5(505YPZ+s;,ICi4;TF*(;kAj%>OFEDI_0/%3a/n&:/@V
	%0%Df%.P@;mkS/her"<-`Fo02cA&Dfp)1AQ!)O,9e7TD/=*23cJbNFDl56Df@i`BQS?83\N.(F"Um3
	Ddm91@rH3;E+j03Df]T1E%`pu0J=UmG\q87F#nDWAnF1MBQS?83\N.(F"Um3Ddm91@rH3;FD5?!0/5
	(50-VN`D/=*23b<PMAj%>OFEDI_0/%3a/n&:/@V%0%Df%.=G\LbC0eP.5+s:E+3bE;ND..NL,&(n&B
	4W`2E+NZ++F%=63^[q!@<?F.<,Z\k4X*1&Ddm9#:hXchDf]T1E$.MH1E]b5DId[0F!;`O@;n7pEb/[
	$AOKsKAN_4m0JP:60K:X=1K6(`3\iZU2)-U83'&`I+s;,=E&p^3A8,Y$6t(1K4X)X80ek763%Zj@<&
	$*g1,q<P0e4q;3\W63+F%=63_a1-@:Weg@74OGAN_4m0JP:60K:X=1K6(`3\iZU2)-U83'&`I+s;,=
	E(s%f6uQRXD.RU,8OP]cF`hD/3\a&k2`<NN6o@>!2+92R0gRTP1dj)W3&!cZ3B/`[1a4&e@;nq83_=
	41FCB&sAP#9Q,'A$BA3)G76oR"]2+0;h6T%:d0eksM1c.TU2E3BZ2E<`O68Tl/E+j03Df]T1E&p@)C
	i=>gDe*EB+u:DcE+j03Df]T1E&pQX6VqfAAnc'm4X+rF7m\=i77/sf3ArcI1+k:*+E2"4FDl56Df@a
	.BleB7Ed9el+s:uAAnF)"EbT*&FCB9*Df.]^0d7`^BkCs<=Ai^ODesQ<Bl@lP+u_820JG160eb:80H
	qW]BkCs<=]/gPDesQ<Bl@lP+u_820JG160eb:80HqW]BkCs<;IsofCisi6Df/QmBllK^1*Ri_BkCs<
	:186YG%F'UB4Z.+4X)X=2CpU@2_6^A3%QgB3@lpD1+Y1>1b:C@2_6^D1b:L?0J#(;0e>(>1+Y1?1Ft
	:A2CpX<0e>+83%Qj?3@m$C3@m$D1+Y482CpUB0J"t<0e>(=1+Y482(UO<2(UO>1c$mK75Qtl0gmoS7
	PcbT770C15rh4t3AX&]1.!`O0f)-N+s:HABkBD&Bm=3*=@?k?ASuR'Df.]^3Ar'(AU%p$3`'O8ASbL
	;Bl.F!F(oQ14X)[;+s:HABkBCnDes?4;fH/TAN_4l+s:HABkBD$@<?4,AOL6FATMrV+u;,:2DcsA0K
	D$F/2T%@2DHa=2_d'B/2K4>1,:C;0KD$H/2T%@2DZm?2`3<D/2T%@2Dcs@2E3TR/2K1D2E36D1GgmE
	/2K(=1H-j@1cR?H/2K+B2)6^=1cR?M/2K+B2)[!A2`!BO/2K4@2`N?E2`!BQ/2K4@3%um>2`!EJ/2K
	4@3&3$@2`!EL/2K4@3&E0B2`!EN/2K4@3&W<D2`!HP/2T(<3&<*B0f1jH/2T(<3&W<E0f1jK/2T(<3
	&iHG0f1mG/2T(<3AW3C0f1mJ/2T(?1,pgA0fLjJ/2T(?1GC@:0f_3N/2T(A3&W<E0f_3P/2T(A3&iH
	G0f_3R/2T(A3A<!@0f_6K/2T(A3AN-B0f_6M/2T(A3A`9D0f_6O/2T(A3ArEF1,(F@/2/V1/2Sn8/2
	f%</3#1@/28h00ek461+Y.9/28t40f:L:2CpRA/29+81,(771+Y1:/2B%51,UU<2CpUB/2B191GCmH
	7PQn[6o-VW0g\;f5qt>Y7RTU#5qkSb75lnU68:5>4s2t4@;nq83^dP"Bm+&u7WNEa+EMX&AS*u;DKB
	o.DI[6L6p2`:F_PAI5r^VS0ge;o2*sYf75-GN5r1>S6o$Y[0L[l[3&*`V+s:rK;IsH$A8bt#D.RU,8
	OP]cF`hD/3^G_\0el$_5rCtr2+92R0gRTP1dj)W3&!cZ3B/`[1a4S:+?V;tA7dkjATM@%BlJ0.Df.`
	]4>1_cAi`gX7QqqW06fO&D/a?'FC@?U+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+
	<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd
	L+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<
	VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL
	+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<V
	dL+<VdL+<VdL+<VdL4?n(0@:O(aF<G.4A3D,\,!S9kiXAp\6UP3W;GTbR9LSp^!<<*.85*`8DZUIM!
	,ZUqE`,Co+BVcM+:$0l!WWN,"op@X!+BAYE(s8#;ucmu!(fUH+ELFN63$uczz!!!#mec5^N!!!#J/P
	&\\+92BAzzzzzzzzzzz&S#d#F8u:A:]LIq1Lt'<@fQK0KE(uPCj0u?F8u:An,NFg'OkisF8u:B"98E
	%'QR;Y=o\O((]XO9'PCNN=o\O(/-#YM'Ok0I=o\O(5QCca'P)&uA,lT2;ucmuE+EfrA,lT2_uKc;Lj
	!oPA,lT39E5%mL3@9BG5qUFe,TIK,]%U?B`J,8p](9o'Q%DiErZ1C$ig8-,]mU-BE/#80E;(Q%!#<F
	6N@)h49,?e$tiO;6N@)h49,?e$t<166N@)h49,?e%!6'*F8u:@!(1[DH#dV3BQP@F@jrNT3B9&A87d
	!]ATW#G:gmjL@<,m$6Z6g\@;^>j!+]Y^@fQK/z&p$r@66Jig6T-YZ2E!-B/hm>+zz!"s?N7m\=i77/
	sf3ArcI1+k9]zzzzzzzzzzzz!*EB-+92BA!!!#j;#gUs!!!$8bZJ"O+92BAzzz!*EB-+92BA!!!";U
	&Y0Qo`+soOB>Xh+92BA!!!".R/d5rK`D)ig/qK]+92BA!!!!ETE"s&KE)"\cX^U.@fQK/z(.gq^+D>
	k=E&oX*GB\6`Bk:d,@qYiBzz!#A-p6Qg&aFDs8o06_Va/nnm,/n8Ppzzzzzzzzzzz!+]Y^@fQK/z/k
	JK!+>tr72E!-B/hnJ:AS,@nCigdt7m\>.Des?7EZfFB@:Njk/Kf+47m[1Uzz!%pi36Qe9A3ArcI1+k
	:(6tKt=F_l.B;Fa%r@rH1%F`JUGE+*6f+>"^W;Fa%Rzzzzz!+]Y^@fQK/z/5g%kATD@"@q?c`Bk;L&
	DJ((ZDf0*"FD5Z2+DG^98OZ!)0f_-M/M\q5zz!!!!M;IsHOEb0,uAKY#fATqj+B-9Q[DIdI'Bl@l3B
	l5%b77/sf3ArcI1+k9]zzzzzz!-W'fG5qUC!!!\.rW!X>/cZI/'EA7&bQ%bZ$NL96ScA`j!E`K.+92
	BA!!#\!<WGqr!!$(BkA=d=ErZ1?z!<<*"zzz!!!!#NrT.[!cr'g+92BA!(0X`+CfP7FoVLB!!!!%z"
	TSl0%fd:D)#t]X,60+l/H@O+2ZPo>5QF4Q8cVWe;ug&$?3"I8BE2lLEWC:`HiS]tL&d,3O8tOGRK/r
	[U]@@oXoPa-[fF&@_#VITb5flheH">(huMj=lN$DSp&Osj!<EE+%07+C)$(f[,loLs1''?84on(Q9E
	A#l=TMn2B)ulNFTHjjK)pl2Oo_!PT`M+nYlVB9_#_XYd/ho$i;r0DncARg!s/l4'ET9V-3>h%3!)AI
	9*/&o>lnX?E<:FfKE@/8Qi`u`X9,g3_#hd]eH4Y1lN6_]!!<T2('>]^/H[s76N^*d=p&@=EW^amM?B
	.HU'%P#\c]tTdf\M1li[%d"p>SB+9X8!3s8(W<<Qe7E<L^nN!,RPW!'O3`!"Nli<8WQrWN`7*!Ihr3
	X&(Y=9W=@G6N^)Q3F,h[0=MQeHP%<p'(^*('Z,j2[2eW=U&UFHNoE5SHc8%^]r0jis,/]#6u+O.gJ3
	B:Bt;5F9dO*R0Teu^B`0ljTkPd$O@g[1'g>T=pT!OJd@YJWX-<EdKo"Aq[!f?,mcU=:C1P<GmTN<U^
	=U=cO&\>q[*oB-ON!D<!m@IJI7bOXpW,Tg^<W\$O\-d3=A[lBa]G!Qj^,+a:$r7q$[lE.L\ZQ>RY``
	NXVfo^^Sm)o*l-<-4N3L=q,Q_NX_rs_[YH3p^RrI/e1G_A.F)!Rguk:dLP[U#nJ<m5n@94H4Q;PZOb
	@mljsI7-4iNU@1[l!Rh3+Af+@Te'+lr2:D%FUN"N'%aV!_L#8/?r71s,DKG($m_\1uC!tumm6PErCK
	+k$o`=q>I"r&F!8JGnRM\N9-c4oa_&f!5<<Y]ioRh`UOi"cD1-5K/gC_i'IZ52",qA1.g5o4)KM&3<
	2dMMWp)]1gWAJg:AY8Ge,qACCn72]kYOVtVGh&6D7.N2/&G8d%k`>\(^'H9+Q@iL:EZ5_L;!ZW[0;B
	1$'UE%Jtoc5(o7icOhR2s0cllHo`5TXY]PTIO[koUQ\4s+J\PTRX^l6$fa5p0tdQls<in0&bp80N+!
	Tcq])q][C3<?d#=Y9MdI$6qMTAg<Nb_B\Oq+!aQ+HmGa<g*I%O3$i5aQR0ZupEh77=!i\L[jL;d(ah
	m&H7,a@gaEU[5:CM"U+"M?"t;M\CFPf'cmf)H2(E8hRju`7!\6/ZBe,`)d4>GP3@o&!U+FnJ$nXasF
	tKaHi@Ylu9J1oL[k@)%,VN=SOY=a.r\-2`CbVY=gG'<q8hkoP\hWb2.PbKhRkiJL%5UI0Il"SjnMDa
	QAMfu8fJO="9f7\`_DV9M2`>\7Xu>N',WB*iS2]%Z'KAoKN&\m="Z\n0IlY/%q)UDpF?6]gmlN*_CH
	JOXkWC4TANZbNj#nSL@6L;Ii'&8I?p:5Ii'/AL@6^JNi]n_RA3d"Wk<UO_C-epemQrToE^I0#pHpu/
	I7(e<"%5XIMF>`Y&k,ehRRQ(&,"?37X%)SK2+N!`^dnW"91Y19f1?uS@nEXkn4GW3I7hFN$qjMlRS2
	X6.SOkV\kN6#8kkLDgeK.jDGIZ:!)H0^P>C"2-W"eZ]28c0:f3]Zk#*p3HrA!`'2r7:W`/Uj6<'"Fg
	JoY%F]H:Z%ouq9WE/ap6s#OQi)hX7I9=Zq)HgcW\69,@<a)A(oijjhQ!<?T2-bl@em0Y/G[8Et)I@5
	d]jD:W@:-?K"^kD>WaPa5:LTu+ojUL%S7:tt6XuHmlXW7kP[s#i4_9dfk@QkhP%Noj4_Kskl"E:pQ>
	#W!6YW!'nS1U0T5++9:MZkDs(kbQYAFP^?u<Gl&oMK&`,?]8G]1uK.r^5^i,LetQ#Z;696-nN!HVOf
	\9&F,E-0<H.!:5diH@D.Rs+RN<d1lp&U82<b]t[`M0\917XCnX"FFX*_L*MSJUHF)6%,GU!IeL,_LE
	e[KR`*67t@Oh$@uuDc%7X$P(N=Y=+e);*JArrj+U!WX+h+=Ee`2$4,9Ga"GgcJcA=?6R>Lp#A;\Nf0
	T26Tr/>-Eb)J-8R#V-+Arb/t2NOGk#*<_aer`1ZW0.aUHBR<P9p<#M+I%bJoT`dKad+cLT9fnOFdM$
	R9UN>X,aja^r0h;feXJmpYFHT&M4F=2A=_/?5b>-N*M87^qOhPqfV(g/[\>+CQD4YZG,+2q<i!d432
	NUO)Q&FirMOP2i2BPP`2P\pWN$r<O/i>_FfXc.>cc;S7'3u%/ZteN(9`Y#!3gUMlEOa%f!7rS_Qu5.
	Y-]L^S@'$<MREPoH+*4OBXcp0=h)ki9"DgM41_i30"\$o+hX;X'to[B$GM2-s1`lpotYO^m(m>Nj2,
	0?gV[.2eAP5&cG`GqaMp]h_oG'`^W8RZ]ZE4V\]QnS\'$\Q[`gVQ[EUSR[E^\U[a-nY\Bm7_]$WXf^
	=#6o_:(g$`mdT0bLKA<dFM=Kf[jB[i7MSmkh0e*n_/0?qqHYV"l,!k&D`Z/*8[FI.Gq>e2W2:-7,cA
	L;rZQlA)ln9F6*8\K]Wa+QKK@QWTZ,$]]hoMd-=j#jm-mOqs9()&ac+V..4J25juqd=RbGBEq02#N:
	RqYVt;h<_Y$auhY(g[qtH!C)>L0+3;LVk=8M+WGPh^DR/JK4])GA%h#D6ks8VKe%RFWD@V#OM5QCca
	!WUmSKE)#R!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<E3%!<N<(!WiE)!WiE)!s8
	W-!s8W-!s8Q)!<E3%!<E3%!<N<'!WiH+!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!s8W-!
	s8W-!s8W-!s8Z*^]4rP!$D8L!s&u6!YGG8&HVpf!!E91s24r4!!!!'!WrH'zz!!`c6"U#,6$3C5.$N
	U5-"p4l,!<<*"z!!!3,"9Sl1#QY53$4@CF!W`B+!<WE*!s8W,"poDQ!WrQ;"VM"_#889]#Vd#Z1*[M
	?;*l%,,Vp67EIes9OX3AgZ1'(sEXE]#d5<<1;`96tP+k?DF%&PW7q3rI<`^3F_U@H7A:nufKOppb_p
	dWp3+hc).QKO\8P3)f>%_M_C3FfGH$Y1!LPUeEPa.Q$R$jD=V5C/hWN*>5[^WcW]#;S-a2lBFeCE.%
	f\,!>jlYail0@p6p@n@Xq@N]/!<WB+"9Sf1"9\o5"`48A!tbYZ&d9uo!$W(B;$Sjb'QFCFJKp9l;P@
	P81C:<3_9kVjn/(&81aS;`(h5u(U9Z+'),rL_A1%_*K9JcH_U@H7<Fp;R2hZm[Zbt8Po-kTBUpS(ij
	Re_6[Dg\XodE=3AiOsgQDV+1f&l[=GDDN_\&[+`pIJD"G_h`c\B*=dpc1oKBmGQ'WO^.(l1lei8m5t
	UMOLQVb1c.Ws4RG]!s&B'&H`UF560@)FSnkdSa5i"k9f`#q!6=U]t/4@./'7eX5%!KeQk&H1\gko(V
	q2Gq+NCVQS7%e/<t'9*X_hj7X1o3V%BHq'0@UV0#J^EE.ZZmDi3Q:6phP/.<#`.Qlgt,"-:X(':ZOV
	I,296p?Q/@D6>3%Td4=s[<;OQ=;1bj!bpI6!=ofX1+EuUDro`B9n0rB&U[+L(=W9`3:64Fr_B*\)mi
	?<M/B_N>/7Y_QG;[eJ'$%QIS9Dp=2F"!+8Ng^J!G<fV>ael[N5#<,l!N8k25cjT*7GTq]2A[B$%W);
	$+5TlMgiYGQ*&L)jEM<;Ldaf@o)oo[/U-Q4UCusnTMO?^.eGbh)iO7f1,E[kK&%BcL(S>\9cK$IR!1
	(rGDtGi31G=QKuE<jgo(,Mm'(t<+I^cH/tj*OM^Tf`:9g?a\`!;1L=nl()*RkE:0GM]hH@G`Igt[^3
	OXPoCD*`a;ZK_mCWAH5;[4XcqJ@7_U6D9KS*ibAJMTQd\8Nf`B^='ddO=;(A69qmJb,l&b0)cQXoMI
	_=G5$_;'CdIIsF(mbQK]al:$[r0bCK%)1]e4geRfa;f@*)+.%%P%TY%=C[1=WME"3A<0ErO83qZ6U1
	&NK>/!MF//_S_r5O_Rt&60T7?S6rR\UiTD<a*C6nl"S07T_"jOgF)u^0c0?=",hp^JopI67`\&Y<.J
	!iGir*,u.LSjg;lM/WqA,)GVY.*Z0^,q6h@/EaqG(4[1Hi4C^Yo'"@`+=!-O1"l2,t1&Rc)40)21)N
	KkF;7=fDY%+-g*tfb5?>ET&8@Kn!)QsD:EGecK];;hg9s-"\8&Li:]qUKVcn9AcjDd9noReAhl0_9i
	!0k-`EHUL6._q?KaQ-T?FB'YPZ*(GN("I8,VD.__;!Pg&Cs%\dIU!?6,?;5*(?r!"f9I3e-<3rX/Tg
	f^.r(!4V^j^!c)?r[cCD+!j)iDS=TjgS29;FC[R4kB?RTgg+F>^E9m*I_,\`n42Yb96K2Co,TWrnQ?
	3X4[qdPLRq+QfaKMk1erp310<:YYQ)u&]/?,F3;u?j04+>GC2WI3rr>_7bo6\h2h(2I\8JXtDQiK2(
	\oh/Ir%W5`Q-^rIG)5)Mskk6=^k(rS5bb<D&e\Y,^r4$Ap46EIAd\N_9`&9S"S'P_08(_,]MNMrrC`
	3M!8j4RhNQF-N!S_[P<7n^.qYf]:6F=rG/uWa_ZH[;Usgs33S>!+M3B"Y5ops_oaqfEmM;-UE'HY;&
	rU_L2)qb$!o(>@:LFY"Q]Ko%n=f)Q&tcN$XZ+p4aqf7G6ZC^NJYAu2Jmh#cJOg#GlH^j]_>ZKRBh/e
	i?YgQ(`Zo':B'Y'HFsrVT+EDZV96O7lF_3L,t)lPRMi+:6m[)TKh.'MTFB?tS-P`OT.Z6(6u91c6Ck
	/`/c83sh=KkWnf*)F^PM\mLAdh:9B;-"gfk.sr4:^RMfSO#DrQ*&NiR#,G8J,gQ!4J$KkaqUlFsdH*
	'Cj:5=lSPO,9m>HMj[tk@iQTiP"X7QIiQPbC=c!X!4S/+;R-lAr6dpJ-unh+[J3k+[4_fD`lFkr2jP
	7m4qpO-.Isu&7u9DcL#bd&je4J<Rf6m=d;Ku!+gOch#!GF.Jhe6F\dJS9oIU$M:mC'pUF:Ko_gF:DV
	2GJ>A*bq%!KJ.j0S]Hf);e(WnPu_*n\Qa6T-\Z7;/814O4oo,cL#QX.okg'a/%YGS#8=kZ'Gq>Knb5
	`(_6AYuXm/=]nH+YV[JS#U&1J*f'[mc0i5WIW_hp_=KVH1[X#[e/dN#)+rSjGJk9@_3sU`kOJ"Yi2N
	Y),P\G_'NiMh*n\QA>"ML@Z:bW]N_#E]8ZgHi1i=>5h&,#El]/-'k#]VQ2YQY*54.7\9$+N&`']rF1
	Y2HHj8RlMdns)bnSTg)Z*e[ZX-%_8P+GfeQ3q[QOX`u0H`qOLlorqb?]73#IO8^A62.anfR/Ipn!AH
	,6eYhORn!U&gY75P:VrXqg;7KCHOjfVSV;Z`E;NhL@$CA'5+#ibP0[&UBPJoEFmc$RjgW>,$fCh+A+
	iCTlI"=8bh$b!rR&27DC;W.qiCW`M>g9k1"h]LZ,t[g,I"Vq-f+3>]uCqe37jeij*9U/r.Vi]YB28f
	Ia.<*RCrM_D;8LBhiQA&4gEc;Y.rb5A2\YM)/?+Sf\V8L%b$$-#k[!hkp!"H[c-OE#[QUcR#N)n#U9
	thF%,N1doU4"53U\3bFgc]1Zi&c3f5!/mEF.ugiDI6O2O%.kj[6mL@3pFJu9%Lh\PH#VTD$\lZrhBk
	=V,$*7LR>8C>Ts](\`+Oo)J$HtUY#2=.LBn"&(?2E&MLF1QQBk3UsN_sC!@G0Vm_r$hGIfD'/^6p3W
	_gBSB-*duYMkolsj>\-?7R1,P$dk\QJ`U:Fks3\UMOJf.Wn,<7d7GPS(SYt'mr7X'qgQQ)<e/O%SA'
	QS(!$k:?0\>TLXgGRgHZbijJ*h#AK,%D[-CaHLn]+Dr7X"=&>3uaVkj[54=8`nE^fR1Ph(,AicANW>
	:TTM4O9bZ<?oX;SoD*\()0]*pq0"E#r)":AK^"30c/8D\2nh8$/'dV;lajO?ppKZr>$M=%>0i-eb)Q
	BL\"$QZVsoR7C[*&A)uNOJY[_:FVUI-,0`_bAB<_C9$2J648#$36d[)68%9`p"<H*(5IOns=q:!WC/
	b0Z1jk%!95K<'@+5r5!!J88a:?\n=[!CQjiP)mQ&\<.sHtE*c98_K7%**%'5/>kIW+YIS]t[Db'iet
	*Su/)1N2mpT1/u_eEu+YYo%)UNVWC4T6?/l]k=\Yd&1U9Ici@10TTFTE4L*,Cj1>baAn*.BMEAICXD
	=pq8EEJZ:b!tfYosf;ZDf*R4(qQ?_!eCrdb>:AoqtB(05^0*rm[^s]/-U0pg0tSk3L:F^,H0PQn>_!
	_W,Ys/@Su.m<$*g<j[,]buodT%+LNKPgSN2FpY^_h7dKao$EkSU=,$$rltem"VfppgsaGGKN.2q.%/
	O4pAY-\jiLPhS"gA:D;<6n2.QL7'.d$R8L%;j*,)KEFMnZN?<Jd1N-od5c]29k[=0e$G5^^K^>%p*S
	#lU-4_:kkk$OnX=34^,!c1*`-aP_.f$2h6D5XU^p.Cr#9==:g;p1SlJf#+mUC0bV<0>:d(:NOCD/X0
	J8k0em-C#`>!1Em;Bpo#b#?Xj7DA-pBT&[E;Wf)e7jHY>U6V-=k!(f#H1oWJ+kYp8=ItE1:a7WDR^C
	aM9Btm5eJWi%%5N02#Jr!ts'RT</3ph=PpFZA+_i`:F!!($^Q\5('1fM5Hr[$KgBH&6)<56ikP22SA
	#BoQVCeWtMi`=R)g@QC/h^OZA]@Z#=i9B(.S_hm9gZ,&FMQ4\_rgVVdXG#5b4YD36d)B-O3hE'j@oG
	O4'_Peuh#a-MdT^AH:M*OI(@/g(h3HM0X(?5*gE+>g]/hOE[isD9(NjP)h,.uNDA%sL*n&?o2^`\+B
	;'n`USso7`48KpX/VD+?1,DRQJGbXVm_@pDnUe93pASq:@2END6Z"ap!\&lk3k:m_/92PjHnFWSZ,'
	WO7@RHIVsSir!p#qNc?H"<m+52hg$_%_Xf.dpKm7"8&6@`4u<Zq`)O\8Aa\@EDYaD3\iYO^NQ\e$`t
	+7edp[`ZeU2S]:VDHGm#MsFrYJ3BD"2ucrZYcQBI0UTpKm*j\T,@fBK&`-m"QJ=?7Q>:a*-V)Xks\%
	^'X7'Xi+k\den@YGVRiENa&c7>@d,+Zr:nsN$Rpk<7RApWIcVa"E@;\;$X],7DB.[^jL\"NM"\s:M"
	\+;K\=EmnE`*`U,gjfCV&*\?)g)Y4m,8cbWh@g\>Sk3jPq8fA/`SSCU]B*H'f7_o!R^RL3eCkWRP/s
	3fOeI<N@nm,+6pd%-No2ridkjuTjEKC-D9b\_g`mHpIrqklBXZernYX?&ilOP9J'r^N?W,UVB;rYnK
	`gJP@A"`B1NGSUShE*?N%=R@aM%a(a#+\D\67$pmTN^lrg]B7MLDnP+KJ%==O45E:k]SM<78S-^I?t
	n?1&.#5463h?)[J4UQGK7`5bD>u!nF?nrT'hR+@r>DLr^ZWl<L*>aT>uEWl:QA-'Qi)eXr<h)DEcLh
	bgFp39+[eOTu;[bMA]`;^@[eK[$(r+KtRcaq=UQGSm+Um;nlIua[,dnER_,gIXqEG(8$`&jm`lC(2J
	$YmF1WAiRZZ7HZk`m;"a9jepP!mbdMhtV^DVXmIa\Bl[0b"L*X\EqA`NgB_%S4+!T(T3^HN*<75;D*
	96GQI-Y>?IcY,!<DSAsQId(Gl;/p,:nc6tXoJZZ![Jk*^$MusgN&3qg,Xo8jCnX`'/W$9UKWWe9,\^
	)pi7c7)_iQ@K*`Pa]fmLbGCT2Xl0jT0f@%?pPJ[6^lqPZoa*%C^Bl"7Q]Q.u-n5n`^-RZS$/LJrj<n
	<XtD/C:L:19$?PY4eF'#bE6+D\B*Xd:JWc.:LU=Ys0Y)V(3PSbuTic=e]IT3qX&!C-WBb^SU-qiU:N
	_7a`5lkb#4hF^+),-o0)Zb)qU#&Q)oC4+.Q`3U(]3\08E`]h*&Wk>6>I&m%_f(koBmXOBDYd\ellji
	UPm@W$5grF;^0m]tpZta7-g"b*m<@0V@\(>a[&j8ldb0eefaUE5Z1J&HS6Z.ZQn'#-m3A1$kT$N&Or
	rBrZ^hj"Hm]D8-Um'lC;[gV?I`L;."h8N:1b^9=H7<j`Zs?ap>.9Zh.:\ZYE?'#"b0^$hFC0AN^V1?
	YK[&R.3s4SW_qg/FJ_m][mC`B6bDr7O4-O[N*!B6GA#--ZeG61pgtU#Cb#d[Ski/PAbKGoQ%+:nB=]
	%OTm_.!9clK7Y[t">8k\[Zr_mR(*Z>c9<iNLHdI)Qn#p+Fe[(#*4Yh4Ff2`_Et?gDRZRoTbo#Ht@,p
	4_kA)VM9@R8F%E?leMd`roN>aL[u>C"YXS;OSJFrftP&nrO+e7-+1@'\2I]$DN*/gc2Rbm^74BBISX
	h>2\o;OY9Ob9^Ni;CB`o-0%1Q]JRWq4Rm_-uHfmb`*'Q4H@d!LB_o7,`31gO2;=e5H",HghmeBufI@
	PSr;h-FFu4rGgD2,%!f,gUWs%*XpK4@5&WgdksXig8JJTPqEU:])p8bbjLU]8u&D_d!u+_UIo+D3NU
	p5;#!d-(:p7Y)[nLnsYbN@Q+H1;.:0<P8TF(YKY$66:g4&;o"W>nmjo8\oZRGXmm2ZhS77gWkLIeY=
	Nh[?OcREYdZ5p&(b*jfDG;ce^7=n&c%KEaR9#C6+!suoqIgSf?r&16&%Em@l6D+@OV-d%s@<Ts4I
	ASCII85End
End

// PNG: width= 129, height= 43
Picture savebutton
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!",!!!!A#Qau+!+M\f!rr<$$#iF<ErZ1J'*&"?'*/*%S/;5+$;G5%6Vp
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
	Ea/@9[pHIbfrqnGDK_,'ed[r;q!!"-O85`.^!.#pk!.]\%!;ZWp!.a;6!-Ksq!:!ql!'6JI!#KR:?c
	>J7!!l1g6pXdsg9d9oD]D=`a1kV[h:(DPZ/aa8,UW'8M%d.#Tnl-*;'JE(7:MN,#Au&35XL@d+5k4k
	.gI=&-c@/J&.qgY!KkiWUU<o0X;)C=,U1ne)r%X<1S3i<<UXq+R8/+K8NaGn1pYl=Y#"emHG;u6qMV
	I?I8ZN/JI?+aMX[,`Ip5tF^DNOAV@X;E"+Us(%';Ae,%AV0bC:r3+3-!_J4(Vse<dp@U@[79IWb8Eb
	u1N?X]C]bY3XrVGOOhIX7PrS6L9WfT.bk">$?7CjN59U6BWU6*'\cAW*Cs)r:.h<o%!0k^St1"s1PV
	rB`l`u>_uWoI;?1g^FtitcgqKtK'.EnmlQQ)>aL&repm\!%EN3?0^P@A&r!G9MA#^/qG*lpL"3(TJF
	<qRr5S/;s7ksKh*Rf3X]Cq9VD1Oh'o(]0k,.<e6AR8.laj3!CLq(r(h8LRPtJBhZU#-j;'^hIg"C't
	S$-/3dTS/tk2tgWf%09ObZF>P^C5O8%U[bK6kBDd6Eh"f8gu'^Pj.&Zm16XtY5eH5'5((0Yk]c93r-
	[S6ki0@,s&LA!!Y^s0<%&i\,,pcgt^]Qm]J8K!&F_=;He)oIqriceu`.41G_<.#U.Ka3u<W[p,6Mpj
	s3NcH$Xd_FZ!O?U?5,<"XFZ[0S:3QKm_@2Q*HMdoB4N$n,-7=H-[aUqZ@su+]Y;b82WCBi9b#jCi"9
	<[af,pYHN0+c^eL4;TcZJ$3FTEVTpar]]0l'KHrHI!Yfr._:5.j=9p&[o$VkCR7M+ab1urG%aA>@bu
	XmQ%#eoHM`ni3YX?'98XBWmVcY]1&J7n:EX.`I0'TsrmR<Gmqk%B].knjP%&J0!hJ-O%@"?Je-*O3l
	M"]2_e$h?I!*MJRSa$h1DnZ8TUd7%A!?hH#q9=-t2bhXQ@?Z\;DC'o<-NX^O6)enH?3,]j`Y`=UMR_
	o,j#@<r+:,8ROG`\U%6@h0"SfB;-&/,95XB;f)aZkN]l^G[NX$=@]fbhp2HH9Z:b93%/=Zc1/[quc/
	G_'-#M>g+V,D#KF45l2?G>n*K7egLH9D\SC:3@(4u4^cU+!%lC;jZPm0[n#Hj'L2j#%5S%9BoDgt@*
	\F\[EVQ7&Lni-<Bn5QLp7%%k*"amF1u?m*+>hYo9XnE7(7?cA]o')gP/Zg%,pPtL/kZY/B?H%(4V>V
	>ofms1MfH"i)FET9Mh@*eGQ\$oF><pKASf[s="f_>&)a3.O)O%Yo@b*`pMn`70=bti-3Y]*i;8k1qZ
	jpDY"Ll%OZ0gs5"]AZgidDOAZ6'))9Cr#@7>5QgCTqSm%[HGl.H_.."P#=?$P<F!Q9'emHFVokXAoh
	KnUs!uSRb4n:'c=V-aXqbf0c>]>9pdVYS8G`Q$O@#2EBUKf#U.S145"/h4107Xo0u2=Jfn_`)Vern@
	lS1Bi4A@?kbo%:]+O;->kn_7ONG#_Fp8&Ai0X;_0&"MB%+A(\hC0.s`P.M%I3m+,YJ>L5d.%UdoU<Q
	MNdXXgGkh[T,_W<*#eVschCesB]h.t452mtDI1RKBN-kf]4NO=9-&I9A;!sK^d)V>Tn=UF*'rBs#g!
	m8coa8Sj%)[OT>tV)\npTD<h,K,WF5Q$>.kj=<D%.-5$H!\Fbj^miSG_(eT`u",M@c$=e5gKPrTEWE
	WeTiNm0&UH,`4pE<ib=AcF%H>AnPa^f0-XDLLI]uZEh-US;l3-)O(J6!=WK)#*FaW(`iY?Q^-h@;&I
	>FI..Sc^!Xq4J$`&mhtm!.P9T6:R?TjCgQB!prVFa^9GiM&.Mqh"`FAB.jiaJul->h]2J2\u:`auj7
	_<t%'Epc^G-NakI^@^bU4A(1p`VD$cjGB'o\Od2r[E`bPaMuu5nK!9O&&PI2k/&?MQ!.UMhA?Kchb@
	oRl)WQ=2"_Q>.6@[-a>/A7d;ro6sO+,7%p+VO*(L`!5OUX=Bd!&%LWlfEI8$U&JYWV$d=nK\agIP@+
	4Q%0F;?$=DPUa^>>4>G?oE%@Y0U(["M+kU1f#p@h-bm@WqiojXYjg2p@X+CenPUC9$/)0ZFB43l&0.
	V*6*jC`S5u3)8&hA:79LI%(A/Fr<Tq'fGm6XGGLi2,K_HV9K6+1-[p1HXR@,=2+>n"D3#.cJ7<=]Y?
	7f&CQ)3kY0TNDlmRGk-068FdII#S$1Q56"YWN',X-%,g"'G`kd#8[QYZQ+(ldujU_UrW86l4Q/DRdB
	YG3CeWCQ5+5[j7\ue7d$oV8kR$a9)X(GdPXgJ]EbTI?<!J$\g:\Y3CnJ3LC#N'Dqa2F@$-o"5k>n&T
	B#_G)`5.XKK8J6)H^6EtZ(WrAR5QpLg&/tg7\_gh3(t/7mD2Sh,PPtJ'2/bN,^WR(aBjQ79-&P'_)H
	[%LAh^<lD/=%\Rn&EuO1/,[(rBUHhCe9Eq,r?mS$1UghiGPI]k>5#0nYJ5!%''@qs>#0XT?<t;'Z4Q
	fnpR%?atUc^+GK7q,mS[*'a*.p4S&@=Bo+TPqU=IIp+@n$?ZEu&r)+X_Im"*E;TKnn5pH.('#eO5fm
	o,1f&Stb*=K266V41S#Q`;*65>7?sghFPo[oM5*^r@0V"T#b*t&O3E]_F^&)TYFusDTDiL?db,Oe=C
	`i14]![=2[E$RLe)''pb2<'#;ji%/o&\<JdXqc8Ra#H@;CRsUrI.n>%6$@140;P!G^+IQEUhJR99i*
	q=8r4)!/PrOap9H\g].<S!(fUS7'8jaJc
	ASCII85End
End





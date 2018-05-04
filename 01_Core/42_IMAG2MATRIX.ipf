#pragma rtGlobals=1		// Use modern global access method.

//Usage:To convert an image to 2D matrix

//Principle:
//Colours in an image may be converted to a shade of gray by calculating the effective
//brightness or luminance of the colour and using this value to create a shade of gray
//that matches the desired brightness.
//The effective luminance of a pixel is calculated with the following formula:
//Y=0.3RED+0.59GREEN+0.11Blue

//增加image display，抽取MDC 和 EDC
//转动角度
//Coded by JXW(2010-11-04),jashowan@gmail.com


proc imgtomatrix()

string curr=getdatafolder(1)
//dowindow/F IMG2MATRIX
	variable versionnum
	string str="IMG2MATRIX"
	versionnum=igorprocedureversion(str)
	
	DoWindow/F $str
	
	if(V_flag)
	if(!versionnum)
	dowindow/K $str
	DoWindow/F $str
	endif
	endif

if(V_Flag==0)
silent 1
newdatafolder/O/S root:IMG2MATRIX
string/G imagelist
make/O/T/N=0 imagenamewave
make/O/N=0 selectwave
//IMG2MATRIX()
variable/G hirizentYpos,verticalXpos,bindingnumH,bindingnumV,kxkyposcursor=0,setdimension,rotatedegree,verticalXposNum,hirizentaYposNum
variable/G horizental2ndnum,vertical2ndnum,symmHornort,symmVornot,scgap,psgap,normanh,normangap,normalbackground,normangama1,normangamma0
variable/G ErToler
/////declare variables for GetKxKyPos panel
variable/G theta,omega,phi,off_theta,off_omega,off_phi
variable/G kxvalue,kyvalue,hv,workfunction,latticeconstant,showoffset
/////

/////declare variable for symmetrizepanel
variable/G symm1d,symm2d,symmanglecomp,symmetrizeref
variable/G anglestart,angleend,symmetryangle,enlargefactor,
/////declare variables for MirrorDispersion panel
variable/G hreffermirror,vreffermirror,left2right,right2left,bottom2top,top2bottom
/////declare variables for MirrorDisperion panel

/////for fit dispersion panel
variable/G hstackoffset,hstackbindingnum,hstackEstart,hstartEend,hstackKstart,hstackKend
variable/G FittingLorentznum,Fittingbackground1,fittingheight1,fittingfwhm1,fittingposition1
variable/G Fittingbackground2,fittingheight2,fittingfwhm2,fittingposition2
variable/G energynearEF,energyfarEF
/////for fit dispersion panel	

///--------------------------For Fit EDCs from YYP
Variable/G FitEDCEnergyStart=NumVarOrDefault("root:IMG2MATRIX:FitEDCEnergyStart",100)
Variable/G FitEDCEnergyEnd=NumVarOrDefault("root:IMG2MATRIX:FitEDCEnergyEnd",100)
Variable/G holedopinglevel=NumVarOrDefault("root:IMG2MATRIX:holedopinglevel",100)
Variable/G Peakposition=NumVarOrDefault("root:IMG2MATRIX:Peakposition",100)
Variable/G FWHM=NumVarOrDefault("root:IMG2MATRIX:FWHM",100)
Variable/G Temperature=NumVarOrDefault("root:IMG2MATRIX:Temperature",100)
Variable/G Background=NumVarOrDefault("root:IMG2MATRIX:Background",100)
Variable/G energyresolution=NumVarOrDefault("root:IMG2MATRIX:energyresolution",100)
variable/G Nameflag
String/G   EDCFileList
String/G   TempEDCName
Variable/G Nameflag
///---------------------------For Fit EDCs from YYP

///--------------------------For SetColorTool
make/O/T/N=0 SetColorNameList
variable/G inverseornot,lowcolorz,highcolorz
string/G choosecolortablename
///--------------------------For SetColorTool


string/G datafoldertocopy,filterprestr
IMG2MATRIX()
setdatafolder curr
string ctrlname
RefreshImage(ctrlname)
endif
end

function converttograyscale(ctrlname) :ButtonControl
	string ctrlname

variable dimsize_x,dimsize_y,ii,jj
string des_name
controlinfo/W=IMG2MATRIX ImagetoBecoverted
wave/T tmp=root:IMG2MATRIX:$S_Value
des_name="conv_"+tmp[V_Value]

ii=0
jj=0
dimsize_x=dimsize($tmp[V_Value],0)
dimsize_y=dimsize($tmp[V_Value],1)
make/O/N=(dimsize_x,dimsize_y) $des_name
wave tmp_wave_des=$des_name
wave tmp_wave_res=$tmp[V_Value]
do
	jj=0
	do
		tmp_wave_des[ii][jj]=0.3*tmp_wave_res[ii][jj][0]+0.59*tmp_wave_res[ii][jj][1]+0.59*tmp_wave_res[ii][jj][2]
		jj+=1
	while(jj<dimsize_y)
	ii+=1
while(ii<dimsize_x)

	dowindow/K IMGPANEL
    display/K=1 
    appendimage tmp_wave_des
	ModifyGraph tick=3,noLabel=2
	dowindow/C IMGPANEL


end





function showrgbimage(ctrlName) : ButtonControl
	String ctrlName
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    wave selectwave=root:IMG2MATRIX:selectwave
    nvar setdimension=root:IMG2MATRIX:setdimension
    nvar showoffset=root:IMG2MATRIX:showoffset
    //nvar hreffermirror=root:IMG2MATRIX:hreffermirror
   // nvar vreffermirror=root:IMG2MATRIX:vreffermirror
   
  
    variable xmin,xinc,xmax,ymin,yinc,ymax,ii,iimax,jj=0
    iimax=dimsize(selectwave,0)
    
    xmin=dimoffset($tmp[V_Value],0)
    xinc=dimdelta($tmp[V_Value],0)
    xmax=xmin+dimdelta($tmp[V_Value],0)*(dimsize($tmp[V_Value],0)-1)
    
    ymin=dimoffset($tmp[V_Value],1)
    yinc=dimdelta($tmp[V_Value],1)
    ymax=ymin+dimdelta($tmp[V_Value],1)*(dimsize($tmp[V_Value],1)-1)
    //setscale/P x,xmin,xinc,$tmp[V_Value]
    //setscale/P y,ymin,yinc,$tmp[V_Value]
    SetVariable yvaluepos,limits={ymin,ymax,(ymax-ymin)/1000}
	SetVariable xvaluepos,limits={xmin,xmax,(xmax-xmin)/1000}
	
	variable vflagcurr=V_Flag
	dowindow/F mirrordispersionpanel
	if(V_Flag==1)
	setvariable  hreffermirror,Win=mirrordispersionpanel,limits={ymin,ymax,(ymax-ymin)/500}
	setvariable vreffermirror,Win=mirrordispersionpanel,limits={xmin,xmax,(xmax-xmin)/500}
	endif
	V_Flag=vflagcurr
	
    dowindow/K IMGPANEL
    display/K=1 
   
   	if(setdimension!=1)
    appendimage $tmp[V_Value]
    ModifyImage $tmp[V_Value] ctab= {*,*,PlanetEarth256,1}
    endif
   
    if(setdimension==1)
    ii=0
    jj=0
    do
    	if(selectwave[ii]!=0)
    	appendtograph $tmp[ii]
    	ModifyGraph offset($tmp[ii])={0,jj*showoffset}
    	jj+=1
    	endif
    	ii+=1
    while(ii<iimax)
    endif
	
	ModifyGraph tick=2
	
	
	dowindow/C IMGPANEL
	
End



Window IMG2MATRIX() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(430,135,1205,489)
	ModifyPanel fixedSize=1, frameStyle=1
	SetDrawLayer UserBack
	DrawLine 384,98,575,98
	DrawLine 384,168,575,168
	DrawLine 592,116,764,116
	DrawLine 591,259,763,259
	DrawLine 228,82,370,82
	DrawLine 226,166,368,166
	DrawLine 225,215,367,215
	DrawLine 225,255,367,255
	DrawLine 225,314,367,314
	DrawLine 385,223,576,223
	GroupBox group2,pos={584,9},size={187,340},title="\\F'@Arial Unicode MS'FitDispersion"
	GroupBox group2,labelBack=(32768,54528,65280)
	GroupBox group1,pos={376,9},size={207,340},title="\\F'@Arial Unicode MS'ExtractTraces"
	GroupBox group1,labelBack=(32768,54528,65280)
	GroupBox group0,pos={212,8},size={165,340},title="\\F'@Arial Unicode MS'ImageTransform"
	GroupBox group0,labelBack=(32768,54528,65280)
	ListBox ImagetoBecoverted,pos={11,47},size={196,275},font="Arial",frame=4
	ListBox ImagetoBecoverted,listWave=root:IMG2MATRIX:imagenamewave
	ListBox ImagetoBecoverted,selWave=root:IMG2MATRIX:selectwave,mode= 1,selRow= 0
	Button refreshwave,pos={169,8},size={34,34},proc=RefreshImage,title=""
	Button refreshwave,font="@Arial Unicode MS",picture= ProcGlobal#refreshbutton
	Button showimage,pos={222,29},size={148,22},proc=showrgbimage,title="Show"
	Button showimage,font="@Arial Unicode MS"
	Button Convertto2dmatrix,pos={223,89},size={100,20},proc=converttograyscale,title="ConverttoMatrix"
	Button Convertto2dmatrix,font="@Arial Unicode MS"
	Button HirizonCut,pos={386,56},size={80,20},proc=hirizencut,title="HCut@Csr"
	Button HirizonCut,font="@Arial Unicode MS"
	Button VerticalCut,pos={387,128},size={80,19},proc=verticalcut,title="VCut@Csr"
	Button VerticalCut,font="@Arial Unicode MS"
	SetVariable yvaluepos,pos={387,34},size={76,20},proc=adjustYpos,title="\\F'@Arial Unicode MS'Y"
	SetVariable yvaluepos,limits={nan,nan,nan},value= root:IMG2MATRIX:hirizentYpos
	SetVariable xvaluepos,pos={386,104},size={78,20},proc=adjustXpos,title="\\F'@Arial Unicode MS'X"
	SetVariable xvaluepos,limits={nan,nan,nan},value= root:IMG2MATRIX:verticalXpos
	SetVariable bindingnumH,pos={468,56},size={51,20},title="\\F'@Arial Unicode MS'#"
	SetVariable bindingnumH,value= root:IMG2MATRIX:bindingnumH
	SetVariable bindingnumV,pos={469,128},size={49,20},title="\\F'@Arial Unicode MS'#"
	SetVariable bindingnumV,value= root:IMG2MATRIX:bindingnumV
	SetVariable setdimension,pos={13,17},size={64,20},title="\\F'@Arial Unicode MS'Dim"
	SetVariable setdimension,limits={1,3,1},value= root:IMG2MATRIX:setdimension
	Button rotatesmatrix,pos={223,138},size={100,20},proc=rotatematrix,title="Rotates"
	Button rotatesmatrix,font="@Arial Unicode MS"
	SetVariable rotatedegree,pos={226,117},size={86,20},title="\\F'@Arial Unicode MS'Rotate"
	SetVariable rotatedegree,value= root:IMG2MATRIX:rotatedegree
	SetVariable yvalueposNum,pos={464,32},size={93,20},proc=adjustYposNum,title="\\F'@Arial Unicode MS'YPos#"
	SetVariable yvalueposNum,value= root:IMG2MATRIX:hirizentaYposNum
	SetVariable xvalueposNum,pos={465,102},size={92,20},proc=adjustXposnum,title="\\F'@Arial Unicode MS'XPos#"
	SetVariable xvalueposNum,value= root:IMG2MATRIX:verticalXposNum
	SetVariable foldertocopy,pos={9,326},size={125,20},title="\\F'@Arial Unicode MS'NewFolder"
	SetVariable foldertocopy,value= root:IMG2MATRIX:datafoldertocopy
	Button copydata,pos={139,326},size={70,21},proc=copydatatonewfolder,title="\\F'@Arial Unicode MS'Copy"
	SetVariable filterprestr,pos={80,17},size={70,20},title="\\F'@Arial Unicode MS'Pre"
	SetVariable filterprestr,value= root:IMG2MATRIX:filterprestr
	CheckBox SymmH,pos={520,59},size={54,16},title="\\F'@Arial Unicode MS'Symm"
	CheckBox SymmH,variable= root:IMG2MATRIX:symmHornort
	CheckBox SymmV,pos={520,131},size={54,16},title="\\F'@Arial Unicode MS'Symm"
	CheckBox SymmV,variable= root:IMG2MATRIX:symmVornot
	Button Symmetrize,pos={222,191},size={100,20},proc=symmetrizemapping,title="\\F'@Arial Unicode MS'Symmetrize"
	Button MirrorDispesion,pos={222,224},size={120,20},proc=mirrordispersion,title="\\F'@Arial Unicode MS'MirrorDispersion"
	Button hdirection2nd,pos={225,265},size={88,20},proc=horizent2ndimage,title="\\F'@Arial Unicode MS'Horizental2nd"
	SetVariable horizental2ndnum,pos={318,264},size={52,20},title="\\F'@Arial Unicode MS'#"
	SetVariable horizental2ndnum,value= root:IMG2MATRIX:horizental2ndnum
	Button vdirection2nd,pos={224,285},size={88,20},proc=vertical2ndimage,title="\\F'@Arial Unicode MS'Vertical2nd"
	SetVariable vertical2ndnum,pos={318,286},size={52,20},title="\\F'@Arial Unicode MS'#"
	SetVariable vertical2ndnum,value= root:IMG2MATRIX:vertical2ndnum
	Button fitpeakH,pos={386,75},size={80,20},proc=findhorizentalpeak,title="\\F'@Arial Unicode MS'FindPeakPos"
	Button fitpeakV,pos={387,146},size={80,20},proc=findverticalpeakpos,title="\\F'@Arial Unicode MS'FindPeakPos"
	Button GetKxKyValue,pos={475,195},size={99,20},proc=calculatekxky,title="\\F'@Arial Unicode MS'GetKxKyPos"
	Button appendinfor,pos={480,75},size={79,20},proc=appendinfoH,title="\\F'@Arial Unicode MS'ApendInfo"
	Button appendinfor1,pos={481,147},size={80,20},proc=appendinfoV,title="\\F'@Arial Unicode MS'ApendInfo"
	SetVariable normanfitbackground,pos={388,253},size={80,20},title="\\F'@Arial Unicode MS'BG"
	SetVariable normanfitbackground,value= root:IMG2MATRIX:normalbackground
	CheckBox scgap,pos={389,233},size={58,16},title="\\F'@Arial Unicode MS'SCGap"
	CheckBox scgap,variable= root:IMG2MATRIX:scgap
	CheckBox pseudogap,pos={457,233},size={57,16},title="\\F'@Arial Unicode MS'PSGap"
	CheckBox pseudogap,variable= root:IMG2MATRIX:psgap
	SetVariable normanfitheight,pos={388,275},size={99,20},title="\\F'@Arial Unicode MS'Height"
	SetVariable normanfitheight,value= root:IMG2MATRIX:normanh
	SetVariable normanfitgap,pos={491,275},size={80,18},title="\\f01\\F'symbol'D(\\F'Times'eV)"
	SetVariable normanfitgap,value= root:IMG2MATRIX:normangap
	SetVariable normanfitgamma1,pos={390,296},size={80,18},title="\\f01\\F'symbol'g1"
	SetVariable normanfitgamma1,value= root:IMG2MATRIX:normangama1
	SetVariable normanfitgamma0,pos={485,296},size={86,18},title="\\f01\\F'symbol'g0"
	SetVariable normanfitgamma0,value= root:IMG2MATRIX:normangamma0
	Button normanfit,pos={385,316},size={188,19},proc=normanfit,title="\\F'@Arial Unicode MS'Fit"
	Button showselectedtraces,pos={391,172},size={87,20},proc=showseltracesinfor,title="\\F'@Arial Unicode MS'SelTracesInfo"
	Button clearredudance,pos={480,172},size={86,20},proc=clearunsestraces,title="\\F'@Arial Unicode MS'ClearUnused"
	SetVariable showoffset,pos={225,52},size={80,20},disable=2,title="\\F'@Arial Unicode MS'Offset"
	SetVariable showoffset,value= root:IMG2MATRIX:showoffset
	SetVariable MDCstackoffset,pos={593,34},size={79,18},title="\\Z10\\F'@Arial Unicode MS'Offset"
	SetVariable MDCstackoffset,value= root:IMG2MATRIX:hstackoffset
	SetVariable MDCstackbindingnum,pos={678,33},size={78,18},title="\\Z10\\F'@Arial Unicode MS'Bind#"
	SetVariable MDCstackbindingnum,value= root:IMG2MATRIX:hstackbindingnum
	SetVariable MDCstackEstart,pos={594,52},size={79,18},title="\\Z10\\F'@Arial Unicode MS'Estart"
	SetVariable MDCstackEstart,value= root:IMG2MATRIX:hstackEstart
	SetVariable MDCstackEend,pos={677,52},size={78,18},title="\\Z10\\F'@Arial Unicode MS'Eend"
	SetVariable MDCstackEend,value= root:IMG2MATRIX:hstartEend
	SetVariable MDCstackKstart,pos={594,72},size={79,18},title="\\Z10\\F'@Arial Unicode MS'Kstart"
	SetVariable MDCstackKstart,value= root:IMG2MATRIX:hstackKstart
	SetVariable MDCstackKend,pos={678,73},size={78,18},title="\\Z10\\F'@Arial Unicode MS'Kend"
	SetVariable MDCstackKend,value= root:IMG2MATRIX:hstackKend
	SetVariable FittingLorentznum,pos={592,123},size={98,18},proc=loretznum,title="\\Z10\\F'@Arial Unicode MS'Lorentz#"
	SetVariable FittingLorentznum,limits={1,2,1},value= root:IMG2MATRIX:FittingLorentznum
	SetVariable Fittingbackground1,pos={593,147},size={79,18},title="\\Z10\\F'@Arial Unicode MS'BKGD"
	SetVariable Fittingbackground1,value= root:IMG2MATRIX:Fittingbackground1
	SetVariable fittingheight1,pos={674,146},size={83,18},title="\\Z10\\F'@Arial Unicode MS'Height"
	SetVariable fittingheight1,value= root:IMG2MATRIX:fittingheight1
	SetVariable fittingfwhm1,pos={592,163},size={79,18},title="\\Z10\\F'@Arial Unicode MS'FWHM"
	SetVariable fittingfwhm1,value= root:IMG2MATRIX:fittingfwhm1
	SetVariable fittingposition1,pos={673,164},size={83,18},title="\\Z10\\F'@Arial Unicode MS'Position"
	SetVariable fittingposition1,value= root:IMG2MATRIX:fittingposition1
	SetVariable Fittingbackground2,pos={592,192},size={79,18},title="\\Z10\\F'@Arial Unicode MS'BKGD"
	SetVariable Fittingbackground2,value= root:IMG2MATRIX:Fittingbackground2
	SetVariable fittingheight2,pos={675,191},size={83,18},title="\\Z10\\F'@Arial Unicode MS'Height"
	SetVariable fittingheight2,value= root:IMG2MATRIX:fittingheight2
	SetVariable fittingfwhm2,pos={593,208},size={79,18},title="\\Z10\\F'@Arial Unicode MS'FWHM"
	SetVariable fittingfwhm2,value= root:IMG2MATRIX:fittingfwhm2
	SetVariable fittingposition2,pos={676,208},size={83,18},title="\\Z10\\F'@Arial Unicode MS'Position"
	SetVariable fittingposition2,value= root:IMG2MATRIX:fittingposition2
	Button MDCStacks,pos={597,93},size={160,20},proc=horizentstacks,title="\\F'@Arial Unicode MS'HorizentStack"
	Button MDCfitting,pos={599,227},size={147,20},proc=HorizentFitting,title="\\F'@Arial Unicode MS'Fit"
	SetVariable energyfarEF,pos={590,302},size={84,18},title="\\Z10\\F'@Arial Unicode MS'FarEF"
	SetVariable energyfarEF,value= root:IMG2MATRIX:energyfarEF
	SetVariable energynearEF,pos={678,303},size={83,18},title="\\Z10\\F'@Arial Unicode MS'NearEF"
	SetVariable energynearEF,value= root:IMG2MATRIX:energynearEF
	Button ShowfittedDispersion,pos={603,266},size={147,20},proc=showfitteddisperson,title="GetFittedDispersion"
	Button ShowfittedDispersion,font="@Arial Unicode MS"
	Button ShowImageEnergy,pos={604,321},size={147,21},proc=getselfenergy,title="GetSelfEnergy"
	Button ShowImageEnergy,font="@Arial Unicode MS"
	Button imagetomatrixhelp,pos={733,4},size={20,20},proc=helpimage2matrix,title="\\f01\\Z15\\F'@Arial Unicode MS'?"
	CheckBox symm1d,pos={225,174},size={34,16},proc=symm1dcheck,title="\\F'@Arial Unicode MS'1D"
	CheckBox symm1d,variable= root:IMG2MATRIX:symm1d
	CheckBox symm2d,pos={263,175},size={34,16},proc=symm2dcheck,title="\\F'@Arial Unicode MS'2D"
	CheckBox symm2d,variable= root:IMG2MATRIX:symm2d
	Button andersonEDCfit,pos={523,232},size={50,20},proc=andersonedcfit,title="\\F'@Arial Unicode MS'EDCFit"
	CheckBox anglecomp,pos={308,175},size={51,16},proc=symm2dcheck,title="\\F'@Arial Unicode MS'ArbSy"
	CheckBox anglecomp,variable= root:IMG2MATRIX:symmanglecomp
	Button Addjustimagecolorscale,pos={223,319},size={120,20},proc=getsetcolortool,title="\\F'@Arial Unicode MS'AdjustColorscale"
	Button process1d,pos={391,195},size={80,20},proc=goto1dpanel,title="\\F'@Arial Unicode MS'Goto1D"
	SetVariable version,pos={10,366},size={70,16},value= _STR:"2011-08-18"
EndMacro

Function RefreshImage(ctrlname) : ButtonControl
	string ctrlname
			svar imagelist=root:IMG2MATRIX:imagelist
			svar filterprestr=root:IMG2MATRIX:filterprestr
          	nvar setdimension=root:IMG2MATRIX:setdimension
           wave/T imagenamewave=root:IMG2MATRIX:imagenamewave
           wave selectwave=root:IMG2MATRIX:selectwave
			//svar imagelist
			variable ii,itemnum
			imagelist=wavelist(filterprestr+"*",";","DIMS:"+num2str(setdimension))
			itemnum=itemsinlist(imagelist)
			//make/O/T/N=(itemnum) imagenamewave
			redimension/N=(itemnum) imagenamewave,selectwave
			ii=0
			do
			imagenamewave[ii]=stringfromlist(ii,imagelist)
			ii+=1
			while(ii<itemnum)
			listbox ImagetoBecoverted,listWave=imagenamewave,font="Arial"
			
			if(setdimension==1)
			ListBox ImagetoBecoverted,mode=9,selWave=selectwave
			SetVariable showoffset,disable=0
			endif
			
			if(setdimension!=1)
			ListBox ImagetoBecoverted,mode=1
			SetVariable showoffset,disable=2
			endif
				
End

Function hirizencut(ctrlName) : ButtonControl
	String ctrlName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	nvar hirizentYpos=root:IMG2MATRIX:hirizentYpos
	nvar bindingnumH=root:IMG2MATRIX:bindingnumH
	svar datafoldertocopy=root:IMG2MATRIX:datafoldertocopy
	nvar symmHornot=root:IMG2MATRIX:symmHornort
	NVar ErToler=root:IMG2MATRIX:ErToler
	 
	 ErToler=0.2
	string imagenameslist
	imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	
	variable ee,ee0,Emin,Einc,Energypnts,xmin,xinc,xpnts

	xmin=dimoffset(tmp,0)
	xinc=dimdelta(tmp,0)
	xpnts=dimsize(tmp,0)


	Emin=dimoffset(tmp,1)
	Einc=dimdelta(tmp,1)
	Energypnts=dimsize(tmp,1)
	
	string horizentalcutname
	nvar hyn=root:IMG2MATRIX:hirizentaYposNum

variable ii,jj,kx
string pathstr
pathstr=getdatafolder(1)
if(kxkyposcursor==0)
	if(strlen(CsrInfo(A,"IMGPANEL"))>0)
	ee0=vcsr(A,"IMGPANEL")
	hirizentYpos=ee0
	endif
	ee0=hirizentYpos
	endif

	if(kxkyposcursor==1)
		ee0=hirizentYpos
	endif

hyn=round((hirizentYpos-Emin)/Einc)

if(symmHornot==0)
	//hyn=round((hirizentYpos-Emin)/Einc)
	horizentalcutname="H_"+nameofwave(tmp)+num2str(hyn)
	//pathstr="root:"+datafoldertocopy+":"+"hirizenCut:"+horizentalcutname
	pathstr=pathstr+"hirizenCut:"+horizentalcutname
	make/O/N=(xpnts) $pathstr=0
	wave HirizonCut=$pathstr
	setscale/P x,xmin,xinc,HirizonCut

	

	

	make/O/N=2 Hy,Hx
	Hx={xmin,xmin+(xpnts-1)*xinc}
	Hy={ee0,ee0}


	ii=0
	jj=0
	do
		kx=xmin+ii*xinc
		jj=-bindingnumH/2
		do
		ee=ee0+jj*Einc
		if((ee<=(Emin+Einc*(Energypnts-1)))&&(ee>=Emin))
		HirizonCut[ii]+=interp2D(tmp,kx,ee)
		endif
		
		//jj+=1
		jj+=0.5
	while(jj<=bindingnumH/2)
	ii+=1
while(ii<xpnts)
//print ee0,Einc
//HirizonCut/=bindingnumH
	duplicate/O HirizonCut,htmp
	dowindow/F MDC4Hirizon
		if(V_Flag==0)
		display/K=1 htmp
		ModifyGraph mirror=2,fStyle=1,standoff=0
		//ModifyGraph mode=4,marker=19,msize=1.5
		//Label bottom "\\Z15Momentum"
		
		if(waveexists(htmp))
		dowindow/C MDC4Hirizon
		endif
		
		endif
	
	removefromgraph/Z/W=IMGPANEL Hy
	appendtograph/W=IMGPANEL Hy vs Hx
endif

if(symmHornot==1)
	//hyn=round((hirizentYpos-Emin)/Einc)
	
	horizentalcutname="H_Symm"+nameofwave(tmp)+num2str(hyn)
	//pathstr="root:"+datafoldertocopy+":"+"SymhirizenCut:"+horizentalcutname
	pathstr=pathstr+"SymhirizenCut:"+horizentalcutname
	make/O/N=(xpnts) $pathstr=0
	wave HirizonCut=$pathstr
	setscale/P x,xmin,xinc,HirizonCut

	

	//if(kxkyposcursor==0)
	//ee0=vcsr(A,"IMGPANEL")
	//hirizentYpos=ee0
	//endif


	//if(kxkyposcursor==1)
	//	ee0=hirizentYpos
	//endif

	make/O/N=2 Hy,Hx
	Hx={xmin,xmin+(xpnts-1)*xinc}
	Hy={ee0,ee0}


	ii=0
	jj=0
	do
		kx=xmin+ii*xinc
		jj=-bindingnumH/2
		do
		ee=ee0+jj*Einc
		if((ee<=(Emin+Einc*(Energypnts-1)))&&(ee>=Emin))
		HirizonCut[ii]+=interp2D(tmp,kx,ee)
		endif
		
		jj+=1
	while(jj<=bindingnumH/2)
	ii+=1
while(ii<xpnts)

HirizonCut/=bindingnumH

 wave waveref=WaveSymmetrizeJXW(HirizonCut,0)
	duplicate/O waveref,$pathstr
	wave HirizonCut=$pathstr
	duplicate/O HirizonCut,htmp
	dowindow/F MDC4Hirizon
		if(V_Flag==0)
		display/K=1 htmp
		ModifyGraph mirror=2,fStyle=1,standoff=0;DelayUpdate
		//ModifyGraph mode=4,marker=19,msize=1.5
		//Label bottom "\\Z15Momentum"
		
		if(waveexists(htmp))
		dowindow/C MDC4Hirizon
		endif
		
		endif
	
	removefromgraph/Z/W=IMGPANEL Hy
	appendtograph/W=IMGPANEL Hy vs Hx
endif

End

Function verticalcut(ctrlName) : ButtonControl
	String ctrlName

	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	nvar verticalXpos=root:IMG2MATRIX:verticalXpos
	nvar bindingnumV=root:IMG2MATRIX:bindingnumV
	svar datafoldertocopy=root:IMG2MATRIX:datafoldertocopy
	nvar symmVornot=root:IMG2MATRIX:symmVornot
	NVar ErToler=root:IMG2MATRIX:ErToler
	 
	 ErToler=0.2
	
	string imagenameslist

	imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	
	variable xx,xx0,ymin,yinc,ypnts,xmin,xinc,xpnts,yy,yy0

	xmin=dimoffset(tmp,0)
	xinc=dimdelta(tmp,0)
	xpnts=dimsize(tmp,0)


	ymin=dimoffset(tmp,1)
	yinc=dimdelta(tmp,1)
	ypnts=dimsize(tmp,1)

	string verticalcutname
	
	if(kxkyposcursor==0)
	
	if(strlen(CsrInfo(A,"IMGPANEL"))>0)
	xx0=xcsr(A,"IMGPANEL")
	verticalXpos=xx0
	endif
	xx0=verticalXpos
	endif



	if(kxkyposcursor==1)
		xx0=verticalXpos
	endif
	
	nvar vxn=root:IMG2MATRIX:verticalXposNum
	variable ii,jj,kx
	string pathstr
pathstr=getdatafolder(1)
if(symmVornot==0)	
	
	vxn=round((verticalXpos-xmin)/xinc)
	verticalcutname="V_"+nameofwave(tmp)+num2str(vxn)
	//pathstr="root:"+datafoldertocopy+":"+"verticalCut:"+verticalcutname
	pathstr=pathstr+"verticalCut:"+verticalcutname
	make/O/N=(ypnts) $pathstr=0
	wave vercut=$pathstr
	setscale/P x,ymin,yinc,verCut
	
	

	make/O/N=2 Vy,Vx
	Vy={ymin,ymin+(ypnts-1)*yinc}
	Vx={xx0,xx0}


	ii=0
	jj=0
	do
		yy=ymin+ii*yinc
		jj=-bindingnumV/2
		do
		xx=xx0+jj*xinc
		if((xx<=(xmin+xinc*(xpnts-1)))&&(xx>=xmin))
		verCut[ii]+=interp2D(tmp,xx,yy)
		endif
		
		//jj+=1
		jj+=0.5
	while(jj<=bindingnumV/2)
	ii+=1
	while(ii<ypnts)
	verCut/=bindingnumV
	
	duplicate/O verCut,vtmp
	dowindow/F EDC4Vertical
		if(V_Flag==0)
		display/K=1 vtmp
		ModifyGraph mirror=2,fStyle=1,standoff=0
		//ModifyGraph mode=4,marker=19,msize=1.5
		//Label bottom "\\Z15Momentum"
		
		if(waveexists(vtmp))
		dowindow/C  EDC4Vertical
		endif
		
		endif
	
	removefromgraph/Z/W=IMGPANEL Vy
	appendtograph/W=IMGPANEL Vy vs Vx
endif

if(symmVornot==1)	
	
	vxn=round((verticalXpos-xmin)/xinc)
	verticalcutname="V_Symm"+nameofwave(tmp)+num2str(vxn)
	//pathstr="root:"+datafoldertocopy+":"+"SymverticalCut:"+verticalcutname
	pathstr=pathstr+"SymverticalCut:"+verticalcutname
	make/O/N=(ypnts) $pathstr=0
	wave vercut=$pathstr
	setscale/P x,ymin,yinc,verCut
	
	//if(kxkyposcursor==0)
	//xx0=xcsr(A,"IMGPANEL")
	//verticalXpos=xx0
	//endif


	//if(kxkyposcursor==1)
	//	xx0=verticalXpos
	//endif

	make/O/N=2 Vy,Vx
	Vy={ymin,ymin+(ypnts-1)*yinc}
	Vx={xx0,xx0}


	ii=0
	jj=0
	do
		yy=ymin+ii*yinc
		jj=-bindingnumV/2
		do
		xx=xx0+jj*xinc
		if((xx<=(xmin+xinc*(xpnts-1)))&&(xx>=xmin))
		verCut[ii]+=interp2D(tmp,xx,yy)
		endif
		
		jj+=1
	while(jj<=bindingnumV/2)
	ii+=1
	while(ii<ypnts)
	
	verCut/=bindingnumV
	
	wave waveref=WaveSymmetrizeJXW(verCut,0)
	duplicate/O waveref,$pathstr
	wave verCut=$pathstr
	duplicate/O verCut,vtmp
	dowindow/F EDC4Vertical
		if(V_Flag==0)
		display/K=1 vtmp
		ModifyGraph mirror=2,fStyle=1,standoff=0
		//ModifyGraph mode=4,marker=19,msize=1.5
		//Label bottom "\\Z15Momentum"
		if(waveexists(vtmp))
		dowindow/C  EDC4Vertical
		endif
		
		endif
	
	removefromgraph/Z/W=IMGPANEL Vy
	appendtograph/W=IMGPANEL Vy vs Vx
endif
End

Function adjustYpos(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	kxkyposcursor=1
	hirizencut(ctrlName)
	kxkyposcursor=0
	dowindow/F IMG2MATRIX

End

Function adjustXpos(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	kxkyposcursor=1
	verticalcut(ctrlName)
	kxkyposcursor=0
	dowindow/F IMG2MATRIX

End

Function adjustYposNum(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	nvar hirizentYpos=root:IMG2MATRIX:hirizentYpos
	nvar hirizentaYposNum=root:IMG2MATRIX:hirizentaYposNum
	string imagenameslist
	imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	variable ymin,yinc
	
	ymin=dimoffset(tmp,1)
	yinc=dimdelta(tmp,1)
	hirizentYpos=hirizentaYposNum*yinc+ymin
	
	kxkyposcursor=1
	hirizencut(ctrlName)
	kxkyposcursor=0
	dowindow/F IMG2MATRIX


End

Function adjustXposnum(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	nvar verticalXpos=root:IMG2MATRIX:verticalXpos
	nvar verticalXposNum=root:IMG2MATRIX:verticalXposNum
	string imagenameslist
	imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	variable xmin,xinc
	
	xmin=dimoffset(tmp,0)
	xinc=dimdelta(tmp,0)
	verticalXpos=verticalXposNum*xinc+xmin
	
	kxkyposcursor=1
	verticalcut(ctrlName)
	kxkyposcursor=0
	dowindow/F IMG2MATRIX

End

Function rotatematrix(ctrlName) : ButtonControl
	String ctrlName
	
	string imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmpwave=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	
    nvar rotatedegree=root:IMG2MATRIX:rotatedegree
    string desnamestr="R"+num2str(rotatedegree)+imagenameslist
    duplicate/O tmpwave $desnamestr
    wave tmp=$desnamestr
    //variable xpnts,ypnts
    //duplicate tmp tmp
   if(rotatedegree!=90)
    ImageRotate/A=(rotatedegree) tmp
   else
   	matrixtranspose tmp
   endif
   // redimension/N=(xpnts,ypnts) $tmp[V_Value]
   if(waveexists(M_RotatedImage))
   duplicate/O M_RotatedImage $desnamestr
   killwaves/Z M_RotatedImage
   endif
  // wave tmp1=M_RotatedImage
   dowindow/K RotateImage
   display/K=1
   appendimage tmp
   ModifyGraph tick=3,noLabel=2
   ModifyGraph width={Aspect,1}
   dowindow/C RotateImage
   
    
End

Function copydatatonewfolder(ctrlName) : ButtonControl
	String ctrlName
	
	string tmpstr,pathstr
	variable ii,itemsnum
	svar imagelist=root:IMG2MATRIX:imagelist
	svar datafoldertocopy=root:IMG2MATRIX:datafoldertocopy
	
	newdatafolder/O root:$datafoldertocopy
	itemsnum=itemsinlist(imagelist)
	ii=0
	do
		tmpstr=stringfromlist(ii,imagelist)
		wave tmp=$tmpstr
		pathstr="root:"+datafoldertocopy+":"+tmpstr
		//duplicate/O tmp, root:datafoldertocopy:$tmpstr
		duplicate/O tmp,$pathstr
		ii+=1
	while(ii<itemsnum)

	setdatafolder root:$datafoldertocopy
	
	newdatafolder/O hirizenCut
	newdatafolder/O verticalCut
	newdatafolder/O SymhirizenCut
	newdatafolder/O SymverticalCut
	newdatafolder/O fittedDispersion
	newdatafolder/O MirrorDis
	newdatafolder/O Sec2nd
	RefreshImage(ctrlname)
End

Function symmetrizemapping(ctrlName) : ButtonControl
	String ctrlName
	//SyFS_ZWT(ctrlName)
	nvar symm1d=root:IMG2MATRIX:symm1d
	nvar symm2d=root:IMG2MATRIX:symm2d
	nvar symmanglecomp=root:IMG2MATRIX:symmanglecomp
	string cmd
	
	if(symm2d)
	cmd="SyFS_ZWT(\"\")"
	execute cmd
	endif
	
	if(symm1d)
	cmd="symmetrize1dpanel()"
	execute cmd
	endif
	
	if(symmanglecomp)
	cmd="ssymmanglecomp()"
	execute cmd
	endif
End

Function findhorizentalpeak(ctrlName) : ButtonControl
	String ctrlName
	nvar verticalXpos=root:IMG2MATRIX:verticalXpos
	
	
	wave tmp=waverefindexed("",0,1)
	
	CurveFit/NTHR=0 lor  tmp[pcsr(A),pcsr(B)] /D 
	string tmpname="fit_"+nameofwave(tmp)
	ModifyGraph lsize($tmpname)=2,rgb($tmpname)=(512,0,62976)
	verticalXpos=K2
	
End

Function findverticalpeakpos(ctrlName) : ButtonControl
	String ctrlName

	nvar hirizentYpos=root:IMG2MATRIX:hirizentYpos
	
	
	wave tmp=waverefindexed("",0,1)
	
	CurveFit/NTHR=0 lor  tmp[pcsr(A),pcsr(B)] /D
	string tmpname="fit_"+nameofwave(tmp)
	ModifyGraph lsize($tmpname)=2,rgb($tmpname)=(512,0,62976)
	hirizentYpos=K2
End

Function appendinfoH(ctrlName) : ButtonControl
	String ctrlName
	
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    nvar symmHornort=root:IMG2MATRIX:symmHornort
    nvar hirizentaYposNum=root:IMG2MATRIX:hirizentaYposNum
    nvar hirizentYpos=root:IMG2MATRIX:hirizentYpos
    nvar bindingnumH=root:IMG2MATRIX:bindingnumH
    //nvar datafoldertocopy=root:IMG2MATRIX:datafoldertocopy
    
   
    if(!waveexists(CutNameList))
    	make/T/N=0 CutNamelist
    endif
    
    if(!waveexists(Position))
    	make/N=0 Position
    endif
    
    if(!waveexists(PositionNum))
    	make/N=0 PositionNum
    endif
    
    if(!waveexists(BindingNum))
    	make/N=0 BindingNum
    endif
    
    if(!waveexists(ThetaValue))
    	make/N=0 ThetaValue
    endif
    
     if(!waveexists(PhiValue))
    	make/N=0 PhiValue
    endif
    
     if(!waveexists(OmegaValue))
    	make/N=0 OmegaValue
    endif
    
     if(!waveexists(Temperature))
    	make/N=0 Temperature
    endif
    
    if(!waveexists(GapValue))
    	make/N=0 GapValue
    endif
    
   variable itemsnum
   itemsnum=dimsize(CutNameList,0)
   redimension/N=(itemsnum+1) CutNameList,Position,PositionNum,BindingNum,ThetaValue,OmegaValue,PhiValue,Temperature,GapValue
   
   
   if(symmHornort==0)
   CutNameList[itemsnum]="H_"+tmp[V_Value]+num2str(hirizentaYposNum)
   endif
   
   if(symmHornort==1)
   CutNameList[itemsnum]="H_Symm"+tmp[V_Value]+num2str(hirizentaYposNum)
   endif
   Position[itemsnum]=hirizentYpos
   PositionNum[itemsnum]=hirizentaYposNum
   BindingNum[itemsnum]=bindingnumH
   
  
End

Function appendinfoV(ctrlName) : ButtonControl
	String ctrlName
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
   
    nvar symmVornot=root:IMG2MATRIX:symmVornot
    nvar verticalXpos=root:IMG2MATRIX:verticalXpos
    nvar verticalXposNum=root:IMG2MATRIX:verticalXposNum
    nvar bindingnumV=root:IMG2MATRIX:bindingnumV
    
    if(!waveexists(CutNameList))
    	make/T/N=0 CutNamelist
    endif
    
    if(!waveexists(Position))
    	make/N=0 Position
    endif
    
    if(!waveexists(PositionNum))
    	make/N=0 PositionNum
    endif
    
    if(!waveexists(BindingNum))
    	make/N=0 BindingNum
    endif
    
    if(!waveexists(ThetaValue))
    	make/N=0 ThetaValue
    endif
    
     if(!waveexists(PhiValue))
    	make/N=0 PhiValue
    endif
    
     if(!waveexists(OmegaValue))
    	make/N=0 OmegaValue
    endif
    
     if(!waveexists(Temperature))
    	make/N=0 Temperature
    endif
    
   variable itemsnum
   itemsnum=dimsize(CutNameList,0)
   redimension/N=(itemsnum+1) CutNameList,Position,PositionNum,BindingNum,ThetaValue,OmegaValue,PhiValue,Temperature
   
   if(symmVornot==0)
   CutNameList[itemsnum]="V_"+tmp[V_Value]+num2str(verticalXposNum)
   endif
   
   if(symmVornot==1)
   CutNameList[itemsnum]="V_Symm"+tmp[V_Value]+num2str(verticalXposNum)
   endif
   Position[itemsnum]=verticalXpos
   PositionNum[itemsnum]=verticalXposNum
   BindingNum[itemsnum]=bindingnumV
   

End

Window calculatekxkypanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(468,688,680,885)
	SetVariable ThetaValue,pos={14,11},size={80,18},title="\\f01\\F'Symbol'q"
	SetVariable ThetaValue,value= root:IMG2MATRIX:theta
	SetVariable omega,pos={14,31},size={80,18},title="\\f01\\F'Symbol'w"
	SetVariable omega,value= root:IMG2MATRIX:omega
	SetVariable phi,pos={15,52},size={80,18},title="\\f01\\F'Symbol'f"
	SetVariable phi,value= root:IMG2MATRIX:phi
	SetVariable offsetThetaValue,pos={99,8},size={90,20},title="\\f01\\F'@Arial Unicode MS'Off\\F'宋体'_\\F'Symbol'q"
	SetVariable offsetThetaValue,value= root:IMG2MATRIX:off_theta
	SetVariable offsetomega,pos={98,29},size={90,20},title="\\f01\\F'@Arial Unicode MS'Off\\F'宋体'_\\F'Symbol'w"
	SetVariable offsetomega,value= root:IMG2MATRIX:off_omega
	SetVariable offsetphi,pos={98,50},size={90,20},title="\\f01\\F'@Arial Unicode MS'Off\\F'宋体'_\\F'Symbol'f"
	SetVariable offsetphi,value= root:IMG2MATRIX:off_phi
	Button CalculateKxKy,pos={15,129},size={184,20},proc=calculatekxkyvalue,title="\\F'@Arial Unicode MS'CalculateKxKy"
	SetVariable photonenergy,pos={18,86},size={80,18},title="\\f01h\\F'Symbol'w"
	SetVariable photonenergy,value= root:IMG2MATRIX:hv
	SetVariable ThetaValue2,pos={104,85},size={80,18},title="\\f01\\F'Symbol'F"
	SetVariable ThetaValue2,value= root:IMG2MATRIX:workfunction
	SetVariable ThetaValue3,pos={19,106},size={80,18},title="\\Z15\\f01a"
	SetVariable ThetaValue3,value= root:IMG2MATRIX:latticeconstant
	SetVariable kxvalue,pos={17,151},size={181,20},title="\\F'@Arial Unicode MS'Kx"
	SetVariable kxvalue,format="%.4f",value= root:IMG2MATRIX:kxvalue
	SetVariable kyvalue,pos={17,173},size={181,20},title="\\F'@Arial Unicode MS'Ky"
	SetVariable kyvalue,format="%.4f",value= root:IMG2MATRIX:kyvalue
EndMacro

porc caculatekxky(ctrlName) : ButtonControl
	String ctrlName

End

proc calculatekxky(ctrlName) : ButtonControl
	String ctrlName
	
	dowindow/F caculatekxkypanel
	if(V_Flag==0)
	calculatekxkypanel()
	endif

End

Function/C calculatekxkyvalue(ctrlName) : ButtonControl
	String ctrlName

	nvar theta=root:IMG2MATRIX:theta
	nvar omega=root:IMG2MATRIX:omega
	nvar phi=root:IMG2MATRIX:phi
	
	nvar off_theta=root:IMG2MATRIX:off_theta
	nvar off_omega=root:IMG2MATRIX:off_omega
	nvar off_phi=root:IMG2MATRIX:off_phi

	nvar hv=root:IMG2MATRIX:hv
	nvar workfunction=root:IMG2MATRIX:workfunction
	nvar latticeconstant=root:IMG2MATRIX:latticeconstant
	
	nvar kxvalue=root:IMG2MATRIX:kxvalue
	nvar kyvalue=root:IMG2MATRIX:kyvalue
	
	variable theta1,omega1,phi1
	theta1=theta-off_theta
	omega1=omega-off_omega
	phi1=phi-off_phi
	
	Variable K0=0.5118*latticeconstant/3.1416*Sqrt(hv-workfunction)
	variable Ky,Kx
	Ky=K0*sin(3.1416/180*theta1)*cos(3.1416/180*(phi1)) 
    Kx=K0*sin(3.1416/180*(phi1))  
        	
	kyvalue=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+omega1*3.1416/180) 
	kxvalue=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+omega1*3.1416/180) 
	
	//return cmplx(kxvalue,kyvalue)
	
End

Function horizent2ndimage(ctrlName) : ButtonControl
	String ctrlName
	nvar horizental2ndnum=root:IMG2MATRIX:horizental2ndnum
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    string pathstr=getdatafolder(1)
    pathstr=pathstr+"Sec2nd:"+"H2D"+tmp[V_Value]
    duplicate/O $tmp[V_Value],$pathstr
    
    wave tmpwave=$pathstr
    H2dFS(tmpwave,horizental2ndnum)
	
	string tmpname=nameofwave(tmpwave)
	dowindow/K H2ndEKImage
	display/K=1; appendimage tmpwave
	
	ModifyImage $tmpname ctab= {*,*,PlanetEarth256,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	ModifyImage $tmpname ctab= {0,*,PlanetEarth256,1}
	//Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	//Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	//ModifyGraph width={Aspect,0.6}
	dowindow/C H2ndEKImage
	killwaves/Z TempSecDImage

End

Function vertical2ndimage(ctrlName) : ButtonControl
	String ctrlName
	
	nvar vertical2ndnum=root:IMG2MATRIX:vertical2ndnum
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    string pathstr=getdatafolder(1)
    pathstr=pathstr+"Sec2nd:"+"V2D"+tmp[V_Value]
    duplicate/O $tmp[V_Value],$pathstr
    
    wave tmpwave=$pathstr
    V2dFS(tmpwave,vertical2ndnum)
	
	string tmpname=nameofwave(tmpwave)
	dowindow/K V2ndEKImage
	display/K=1; appendimage tmpwave
	
	ModifyImage $tmpname ctab= {*,*,PlanetEarth256,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	ModifyImage $tmpname ctab= {0,*,PlanetEarth256,1}
	//Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	//Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	//ModifyGraph width={Aspect,0.6}
	dowindow/C V2ndEKImage
	killwaves/Z TempSecDImage


End

Function H2dFS(popStr,smoothnumEDC)
	
	wave popStr
	    	            		
        variable   smoothnumEDC

        String Curr=GetDataFolder(1) 
        String Notation=nameofwave(popStr)  	
	variable smoothtimes=smoothnumEDC
       //Duplicate/O  root:DispersionIMAGE:$popStr, root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage
      MatrixTranspose  popStr


       //SetDataFolder root:DispersionFrom2ndDerivative:MDC2ndD
       WAVE SecDImage= popStr
       Duplicate/O SecDImage, TempSecDImage
        
       Variable/G nx, ny
	   Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
       XJZImginfo(SecDImage)


            String ReferenceEnergyWave="TokillEgy"+nameofwave(popStr)
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 

                 String   EDC0="Tokill"+nameofwave(popStr)+"0"
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=TempSecDImage[p] [0]
                 Differentiate EDCC;         Differentiate EDCC
                 Smooth/E=2 SmoothTimes, EDCC
                                  Variable k=0
                                  Do
                                  SecDImage[k] [0]=EDCC[k]
                                  k=k+1
                                  While(k<nx)
	         
                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=1         

	         
	         Variable ll
	         Do
                 PlotName="Tokill"+nameofwave(popStr)+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p][i]
                 Differentiate EDCSpectra;   Differentiate EDCSpectra                 
                 Smooth/E=2 SmoothTimes, EDCSpectra
//               variable n=numpnts(EDCSpectra)
//               EDCSpectra[0,1]=0;	EDCSpectra[n-2,n-1]=0
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)
	        i=i+1
	        While(i<ny) 
       
//这段可能多余	            		
	      	        			       
	         Do
                 PlotName="Tokill"+nameofwave(popStr)+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p] [i]
                 Differentiate EDCSpectra;      Differentiate EDCSpectra
                 Smooth/E=2 SmoothTimes, EDCSpectra
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)        
	         i=i+1
	        While(i<ny) 
	SecDImage=-SecDImage
	 MatrixTranspose  popStr


                

	    String ToBeKilledEDCList=WaveList("Tokill*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	    Variable iEDC=0
	    Do
	    EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	    KillWaves/Z  $EDCCurve
	    iEDC+=1
	    While(iEDC<NoofKilledEDCList)
                
                
	
	SetDataFolder curr
END

Function V2dFS(popStr,smoothnumMDC)
	
	wave popStr
	    	            		
        variable smoothnumMDC
//      String SecDImageName="SecD_"+"ST"+num2str(SmoothTimes)+popStr	
//        String SecDImageName="SecD_"+"MDC"+num2str(SmoothTimes)+popStr	        
//        String SecondDImage="MDC"+num2str(SmoothTimes)+popStr	
       variable smoothtimes=smoothnumMDC
        String Curr=GetDataFolder(1) 
        String Notation=nameofwave(popStr)  	
	
       //Duplicate/O  root:DispersionIMAGE:$popStr, root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage
//     MatrixTranspose  root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage


       //SetDataFolder root:DispersionFrom2ndDerivative:MDC2ndD
       WAVE SecDImage= popStr
       Duplicate/O SecDImage, TempSecDImage
        
       Variable/G nx, ny
	   Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
       XJZImginfo(SecDImage)


            String ReferenceEnergyWave="TokillEngy"+nameofwave(popStr) 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 

                 String   EDC0="Tokill"+nameofwave(popStr) +"0"
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=TempSecDImage[p] [0]
                 Differentiate EDCC;         Differentiate EDCC
                 Smooth/E=2 SmoothTimes, EDCC
                                  Variable k=0
                                  Do
                                  SecDImage[k] [0]=EDCC[k]
                                  k=k+1
                                  While(k<nx)
	         
                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=1         

	         
	         Variable ll
	         Do
                 PlotName="Tokill"+nameofwave(popStr) +num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p][i]
                 Differentiate EDCSpectra;   Differentiate EDCSpectra                 
                 Smooth/E=2 SmoothTimes, EDCSpectra
//               variable n=numpnts(EDCSpectra)
//               EDCSpectra[0,1]=0;	EDCSpectra[n-2,n-1]=0
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)
	        i=i+1
	        While(i<ny) 
       
//这段可能多余	            		
	      	        			       
	         Do
                 PlotName="Tokill"+nameofwave(popStr) +num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p] [i]
                 Differentiate EDCSpectra;      Differentiate EDCSpectra
                 Smooth/E=2 SmoothTimes, EDCSpectra
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)        
	         i=i+1
	        While(i<ny) 
         SecDImage=-SecDImage



                
//                DoWindow $SecDImageName
//	            if(V_flag==0)
//	            MatrixTranspose   SecDImage          
//                Display; AppendImage SecDImage
//                Textbox/N=text0/F=0/A=MT Notation  
//              ModifyImage $SecondDImage ctab= {*,0,Rainbow,1}
//                ModifyImage $SecondDImage ctab= {-0.01,0,PlanetEarth,1}
//                ModifyGraph standoff=0
//                ModifyGraph zero(left)=3
//                Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
//                ModifyGraph width={Aspect,0.5}
//                ModifyGraph margin(left)=26
//                ModifyGraph margin(right)=5
//                ModifyGraph margin(top)=5
                
//                DoWindow/C $SecDImageName
                
//               Else
//             MatrixTranspose   SecDImage   
//               DoWindow/F $SecDImageName 
//               Endif 
//             Print "Till here"
//				ShowInfo
//Kill EDC Curves in Root:DispersionFrom2ndDerivative
	    String ToBeKilledEDCList=WaveList("Tokill*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	    Variable iEDC=0
	    Do
	    EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	    KillWaves/Z  $EDCCurve
	    iEDC+=1
	    While(iEDC<NoofKilledEDCList)
                
                
	
	SetDataFolder curr
END

Function normanfit(ctrlName) : ButtonControl
	String ctrlName
	nvar scgap=root:IMG2MATRIX:scgap
	nvar psgap=root:IMG2MATRIX:psgap
	
	string curr=getdatafolder(1)
	//controlinfo/W=IMG2MATRIX ImagetoBecoverted
    //wave/T tmp=root:IMG2MATRIX:$S_Value
    //wave tmpwave=$tmp[V_Value]
    wave tmpwave=waverefindexed("",0,1)
      
    string namepre=nameofwave(tmpwave)
    
   
    if(!cmpstr("htmp",namepre[0,3])||!cmpstr("H_Symm",namepre[0,5]))
    	if(datafolderexists(":SymhirizenCut"))
    		setdatafolder :SymhirizenCut
   		endif
    endif
  
    
     
    if(!cmpstr("vtmp",namepre[0,4])||!cmpstr("V_Symm",namepre[0,5]))
    	if(datafolderexists(":SymverticalCut"))
    		setdatafolder :SymverticalCut
    	endif
    endif
   
    
	nvar v0=root:IMG2MATRIX:normalbackground
    nvar v1=root:IMG2MATRIX:normanh
    nvar v2=root:IMG2MATRIX:normangap
    nvar v3=root:IMG2MATRIX:normangama1
    nvar v4=root:IMG2MATRIX:normangamma0
    variable  v5=1
       
       Make/O co_EDCfit_normalgap={v0,v1,v2,v3}
       Make/O co_EDCfit_pseudogap={v0,v1,v2,v3,v4} 
       Redimension/D co_EDCfit_normalgap
       Redimension/D co_EDCfit_pseudogap
       
       make/o/n=(dimsize(tmpwave,0)) TempEDCx
	   TempEDCx=dimoffset(tmpwave,0)+dimdelta(tmpwave,0)*x
	   
	   string gapvalue,tmpname
	 if(scgap==1)
	  FuncFit/N=1/Q=1/ODR=0/NTHR=0 Norman_gap_func1 co_EDCfit_normalgap  tmpwave[pcsr(A),pcsr(B)] /D /X= TempEDCx
	  gapvalue="SCGap="+num2str(co_EDCfit_normalgap[2]*1000)+"meV"
	  textbox gapvalue
	  tmpname="fit_"+nameofwave(tmpwave)
	  ModifyGraph lsize($tmpname)=2,rgb($tmpname)=(512,0,62976)
	 endif
	 
	  if(psgap==1)
	  FuncFit/N=1/Q=1/ODR=0/NTHR=0 Norman_pseudogap_func1 co_EDCfit_pseudogap tmpwave[pcsr(A),pcsr(B)] /D /X=TempEDCx
	  gapvalue="PSGap="+num2str(co_EDCfit_pseudogap[2]*1000)+"meV"
	  textbox gapvalue
	  tmpname="fit_"+nameofwave(tmpwave)
	  ModifyGraph lsize($tmpname)=2,rgb($tmpname)=(512,0,62976)
	 endif
	 
	 setdatafolder curr

End

function Norman_gap_func1(v,x)
  
//v0: background
//v1: height
//v2: Gap
//v3: Gamma1
//v4: Gamma0
    wave v
    variable x
    variable positiveinf=0.000000001
    //return v[0]+x+v[1]*(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))/((x-v[2]^2*x/(x^2+0.0001^2))^2+(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))^2)
    
    //return v[0]+v[1]*(v[3]+v[2]^2*positiveinf/(x^2+positiveinf^2))/((x-v[2]^2*x/(x^2+positiveinf^2))^2+(v[3]+v[2]^2*positiveinf/(x^2+positiveinf^2))^2)
    //return v[0]+x+v[1]*v[3]*(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))/((x-v[2]^2*x/(x^2+0.0001^2))^2+(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))^2)
    return v[0]+v[1]*v[3]*(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))/((x-v[2]^2*x/(x^2+0.0001^2))^2+(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))^2)
end

function Norman_pseudogap_func1(v,x)

//v0: background
//v1: height
//v2: Gap
//v3: Gamma1
//v4: Gamma0
    wave v
    variable x
    //return v[0]+x+v[1]*(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))/((x-v[2]^2*x/(x^2+v[4]^2))^2+(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))^2)
    //return v[0]+x+v[1]*v[3]*(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))/((x-v[2]^2*x/(x^2+v[4]^2))^2+(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))^2)//Original
    return v[0]+v[1]*v[3]*(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))/((x-v[2]^2*x/(x^2+v[4]^2))^2+(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))^2)
end

Function showseltracesinfor(ctrlName) : ButtonControl
	String ctrlName
	wave/T CutNamelist=CutNamelist
	if(waveexists(CutNamelist))
	edit/K=1 CutNameList,Temperature,GapValue,Position,PositionNum,BindingNum,ThetaValue,OmegaValue,PhiValue
	endif
End

Function clearunsestraces(ctrlName) : ButtonControl
	String ctrlName
	//showseltracesinfor(ctrlName)
	
	string curr=getdatafolder(1)
	string tmpstr,tokilllist
	variable ii,tokillnum,selnum,jj
	
	wave/T CutNamelist=CutNamelist

	
	//////
	if(!waveexists(CutNamelist)||!dimsize(CutNamelist,0))
		make/T/N=1 tmpCutNamelist
		wave/T CutNamelist=tmpCutNamelist
	endif
	selnum=dimsize(CutNamelist,0)
	
	setdatafolder :hirizencut
	tokilllist=wavelist("*",";","DIMS:1")
	tokillnum=itemsinlist(tokilllist)
	ii=0
	do
		tmpstr=stringfromlist(ii,tokilllist)
		//print cmpstr(tmpstr,CutNamelist[0])
		jj=0
		do
		if(!cmpstr(tmpstr,CutNamelist[jj]))
			break
		endif
		jj+=1
		while(jj<selnum)
		if(jj==selnum)
		killwaves/Z $tmpstr
		endif
	ii+=1
	while(ii<tokillnum)
	
	
	setdatafolder curr
	setdatafolder :SymhirizenCut
	tokilllist=wavelist("*",";","DIMS:1")
	tokillnum=itemsinlist(tokilllist)
	ii=0
	do
		tmpstr=stringfromlist(ii,tokilllist)
		jj=0
		do
		if(!cmpstr(tmpstr,CutNamelist[jj]))
			break
		endif
		jj+=1
		while(jj<selnum)
		if(jj==selnum)
		killwaves/Z $tmpstr
		endif
	ii+=1
	while(ii<tokillnum)
	
	
	setdatafolder curr
	setdatafolder :verticalCut
	tokilllist=wavelist("*",";","DIMS:1")
	tokillnum=itemsinlist(tokilllist)
	ii=0
	do
		tmpstr=stringfromlist(ii,tokilllist)
		jj=0
		do
		if(!cmpstr(tmpstr,CutNamelist[jj]))
			break
		endif
		jj+=1
		while(jj<selnum)
		if(jj==selnum)
		killwaves/Z $tmpstr
		endif
	ii+=1
	while(ii<tokillnum)
	
	setdatafolder curr
	setdatafolder :SymverticalCut
	tokilllist=wavelist("*",";","DIMS:1")
	tokillnum=itemsinlist(tokilllist)
	ii=0
	do
		tmpstr=stringfromlist(ii,tokilllist)
		jj=0
		do
		if(!cmpstr(tmpstr,CutNamelist[jj]))
			break
		endif
		jj+=1
		while(jj<selnum)
		if(jj==selnum)
		killwaves/Z $tmpstr
		endif
	ii+=1
	while(ii<tokillnum)
	
	setdatafolder curr
	wave/T CutNamelist=tmpCutNamelist
	killwaves/Z CutNamelist

End

proc mirrordispersion(ctrlName) : ButtonControl
	String ctrlName
	mirrordispersionpanel()
End

Window mirrordispersionpanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(548,144,775,261)
	//ShowTools/A
	SetVariable hreffermirror,pos={10,7},size={120,20},proc=hreferlineusearrow,title="\\F'@Arial Unicode MS'Hori_Refer"
	SetVariable hreffermirror,value= root:IMG2MATRIX:hreffermirror
	SetVariable vreffermirror,pos={10,31},size={120,20},proc=vreferlineusearrow,title="\\F'@Arial Unicode MS'Ver_Refer"
	SetVariable vreffermirror,value= root:IMG2MATRIX:vreffermirror
	Button hrefferline,pos={135,9},size={80,20},proc=hreferline,title="\\F'@Arial Unicode MS'HReferLine"
	Button vrefferline,pos={135,30},size={80,20},proc=vreferline,title="\\F'@Arial Unicode MS'VReferLine"
	CheckBox left2right,pos={9,64},size={42,14},proc=mleft2right,title="L->R"
	CheckBox left2right,variable= root:IMG2MATRIX:left2right
	CheckBox right2left,pos={61,64},size={42,14},proc=mright2left,title="R->L"
	CheckBox right2left,variable= root:IMG2MATRIX:right2left
	CheckBox bottom2top,pos={112,64},size={42,14},proc=mbottom2top,title="B->T"
	CheckBox bottom2top,variable= root:IMG2MATRIX:bottom2top
	CheckBox top2bottom,pos={164,64},size={42,14},proc=mtop2bottom,title="T->B"
	CheckBox top2bottom,variable= root:IMG2MATRIX:top2bottom
	Button Mirrordispersion,pos={8,87},size={206,20},proc=getmirrordisperaion,title="\\F'@Arial Unicode MS'GetMirrorDis"
EndMacro

Function hreferlineusearrow(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	kxkyposcursor=1
	hreferline(ctrlName)
	kxkyposcursor=0
	dowindow/F mirrordispersionpanel

End

Function hreferline(ctrlName) : ButtonControl
	String ctrlName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	nvar hreffermirror=root:IMG2MATRIX:hreffermirror
	
	string imagenameslist
	imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	
	variable xmin,xinc,xmax,ymin,yinc,ymax
	xmin=dimoffset(tmp,0)
	xinc=dimdelta(tmp,0)
	xmax=xmin+xinc*(dimsize(tmp,0)-1)
	
	ymin=dimoffset(tmp,1)
	yinc=dimdelta(tmp,1)
	ymax=xmin+xinc*(dimsize(tmp,1)-1)
	
	make/O/N=2 hreferlineY,hreferlineX
	
	if(kxkyposcursor==0)
	if(strlen(CsrInfo(A,"IMGPANEL"))>0)
	hreferlineY=vcsr(A,"IMGPANEL")
	hreffermirror=vcsr(A,"IMGPANEL")
	endif
	hreferlineY=hreffermirror
	endif
	
	if(kxkyposcursor==1)
	hreferlineY=hreffermirror
	endif
	
	hreferlineX[0]=xmin
	hreferlineX[1]=xmax
	
	appendtograph/W=IMGPANEL hreferlineY vs hreferlineX
	
	
	
End


Function vreferlineusearrow(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	kxkyposcursor=1
	vreferline(ctrlName)
	kxkyposcursor=0
	dowindow/F mirrordispersionpanel

End


Function vreferline(ctrlName) : ButtonControl
	String ctrlName
	nvar kxkyposcursor=root:IMG2MATRIX:kxkyposcursor
	nvar vreffermirror=root:IMG2MATRIX:vreffermirror
	
	string imagenameslist
	imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	
	variable xmin,xinc,xmax,ymin,yinc,ymax
	xmin=dimoffset(tmp,0)
	xinc=dimdelta(tmp,0)
	xmax=xmin+xinc*(dimsize(tmp,0)-1)
	
	ymin=dimoffset(tmp,1)
	yinc=dimdelta(tmp,1)
	ymax=ymin+yinc*(dimsize(tmp,1)-1)
	
	make/O/N=2 vreferlineY,vreferlineX
	
	if(kxkyposcursor==0)
	if(strlen(CsrInfo(A,"IMGPANEL"))>0)
	vreferlineX=xcsr(A,"IMGPANEL")
	vreffermirror=xcsr(A,"IMGPANEL")
	endif
	vreferlineX=vreffermirror
	endif
	
	if(kxkyposcursor==1)
	vreferlineX=vreffermirror
	endif
	
	vreferlineY[0]=ymin
	vreferlineY[1]=ymax
	
	appendtograph/W=IMGPANEL vreferlineY vs vreferlineX
	
End

Function mleft2right(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar left2right=root:IMG2MATRIX:left2right
	
	if(left2right==1)
	CheckBox left2right,disable=0
	CheckBox right2left,disable=2
	CheckBox bottom2top,disable=2
	CheckBox top2bottom,disable=2
	else
	CheckBox left2right,disable=0
	CheckBox right2left,disable=0
	CheckBox bottom2top,disable=0
	CheckBox top2bottom,disable=0
	endif
	
	

End

Function mright2left(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar right2left=root:IMG2MATRIX:right2left
	
	if(right2left==1)
	CheckBox left2right,disable=2
	CheckBox right2left,disable=0
	CheckBox bottom2top,disable=2
	CheckBox top2bottom,disable=2
	else
	CheckBox left2right,disable=0
	CheckBox right2left,disable=0
	CheckBox bottom2top,disable=0
	CheckBox top2bottom,disable=0
	endif

End

Function mbottom2top(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar bottom2top=root:IMG2MATRIX:bottom2top
	
	if(bottom2top==1)
	CheckBox left2right,disable=2
	CheckBox right2left,disable=2
	CheckBox bottom2top,disable=0
	CheckBox top2bottom,disable=2
	else
	CheckBox left2right,disable=0
	CheckBox right2left,disable=0
	CheckBox bottom2top,disable=0
	CheckBox top2bottom,disable=0
	endif

End

Function mtop2bottom(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar top2bottom=root:IMG2MATRIX:top2bottom
	
	if(top2bottom==1)
	CheckBox left2right,disable=2
	CheckBox right2left,disable=2
	CheckBox bottom2top,disable=2
	CheckBox top2bottom,disable=0
	else
	CheckBox left2right,disable=0
	CheckBox right2left,disable=0
	CheckBox bottom2top,disable=0
	CheckBox top2bottom,disable=0
	endif
End

Function getmirrordisperaion(ctrlName) : ButtonControl
	String ctrlName
	
	nvar left2right=root:IMG2MATRIX:left2right
	nvar right2left=root:IMG2MATRIX:right2left
	nvar bottom2top=root:IMG2MATRIX:bottom2top
	nvar top2bottom=root:IMG2MATRIX:top2bottom
	nvar hreffermirror=root:IMG2MATRIX:hreffermirror
	nvar vreffermirror=root:IMG2MATRIX:vreffermirror
	
	string imagenameslist
	imagenameslist=imagenamelist("IMGPANEL",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("IMGPANEL",imagenameslist)
	
	variable xmin,xinc,xmax,ymin,yinc,ymax,xpnts,ypnts,ipositiony,ipositionx,ii,jj,xx,yy
	xmin=dimoffset(tmp,0)
	xinc=dimdelta(tmp,0)
	xpnts=dimsize(tmp,0)
	xmax=xmin+(xpnts-1)*xinc
	
	ymin=dimoffset(tmp,1)
	yinc=dimdelta(tmp,1)
	ypnts=dimsize(tmp,1)
	ymax=ymin+(ypnts-1)*yinc
	
	ipositiony=round((hreffermirror-ymin)/yinc)
	ipositionx=round((vreffermirror-xmin)/xinc)
	
	
	string curr=getdatafolder(1)
	string mirrordisname
	if(left2right==1)
	
	mirrordisname="MLR_"+nameofwave(tmp)
	
	if(DataFolderExists(":MirrorDis"))
	setdatafolder :MirrorDis
	endif
	make/O/N=(2*ipositionx+1,ypnts) $mirrordisname
	
	wave mtmp=$mirrordisname
	ii=0
	jj=0
	do
		xx=xmin-vreffermirror+ii*xinc
		if(xx>=0)
			xx=-xx
		endif
		jj=0
		
		do
			yy=ymin+jj*yinc
			mtmp[ii][jj]=interp2D(tmp,xx+vreffermirror,yy)
			jj+=1
		while(jj<ypnts)
		ii+=1
	while(ii<2*ipositionx+1)
					
	setscale/P x,xmin-vreffermirror,xinc,mtmp
	setscale/P y,ymin,yinc,mtmp
	
	dowindow/K/Z MirrorDis
	display/K=1
	appendimage mtmp
	ModifyImage $mirrordisname ctab= {*,*,PlanetEarth,1}
	dowindow/C MirrorDis
	
	setdatafolder curr
	endif
	
	
	if(right2left==1)
	
	mirrordisname="MRL_"+nameofwave(tmp)
	if(DataFolderExists(":MirrorDis"))
	setdatafolder :MirrorDis
	endif
	make/O/N=(2*(xpnts-1-ipositionx)+1,ypnts) $mirrordisname
	
	wave mtmp=$mirrordisname
	ii=0
	jj=0
	do
		xx=-(xmax-vreffermirror)+ii*xinc
		if(xx>=0)
			xx=-xx
		endif
		jj=0
		
		do
			yy=ymin+jj*yinc
			mtmp[ii][jj]=interp2D(tmp,-xx+vreffermirror,yy)
			jj+=1
		while(jj<ypnts)
		ii+=1
	while(ii<(2*(xpnts-1-ipositionx)+1))
					
	setscale/P x,-xmax+vreffermirror,xinc,mtmp
	setscale/P y,ymin,yinc,mtmp
	
	dowindow/K/Z MirrorDis
	display/K=1
	appendimage mtmp
	ModifyImage $mirrordisname ctab= {*,*,PlanetEarth,1}
	dowindow/C MirrorDis
	
	setdatafolder curr
	endif
	
	if(top2bottom==1)
	
	mirrordisname="MTB_"+nameofwave(tmp)
	if(DataFolderExists(":MirrorDis"))
	setdatafolder :MirrorDis
	endif
	make/O/N=(xpnts,2*(ypnts-1-ipositiony)+1) $mirrordisname
	
	wave mtmp=$mirrordisname
	ii=0
	jj=0
	do
		xx=xmin+ii*xinc
		
		jj=0
		
		do
			yy=-(ymax-hreffermirror)+jj*yinc
			if(yy>=0)
			yy=-yy
			endif
			mtmp[ii][jj]=interp2D(tmp,xx,-yy+hreffermirror)
			jj+=1
		while(jj<(2*(ypnts-1-ipositiony)+1))
		ii+=1
	while(ii<xpnts)
					
	setscale/P y,-ymax+hreffermirror,yinc,mtmp
	setscale/P x,xmin,xinc,mtmp
	
	dowindow/K/Z MirrorDis
	display/K=1
	appendimage mtmp
	ModifyImage $mirrordisname ctab= {*,*,PlanetEarth,1}
	dowindow/C MirrorDis
	
	setdatafolder curr
	endif
	
	if(bottom2top==1)
	
	mirrordisname="MBT_"+nameofwave(tmp)
	if(DataFolderExists(":MirrorDis"))
	setdatafolder :MirrorDis
	endif
	make/O/N=(xpnts,2*ipositiony+1) $mirrordisname
	
	wave mtmp=$mirrordisname
	ii=0
	jj=0
	do
		xx=xmin+ii*xinc
		
		jj=0
		
		do
			yy=ymin-hreffermirror+jj*yinc
			if(yy>=0)
			yy=-yy
			endif
			mtmp[ii][jj]=interp2D(tmp,xx,yy+hreffermirror)
			jj+=1
		while(jj<(2*ipositiony+1))
		ii+=1
	while(ii<xpnts)
					
	setscale/P y,ymin-hreffermirror,yinc,mtmp
	setscale/P x,xmin,xinc,mtmp
	
	dowindow/K/Z MirrorDis
	display/K=1
	appendimage mtmp
	ModifyImage $mirrordisname ctab= {*,*,PlanetEarth,1}
	dowindow/C MirrorDis
	
	setdatafolder curr
	endif

End

Function horizentstacks(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	
	newdatafolder/O :fittedDispersion:HorisentStack
	nvar MDCstackoffset=root:IMG2MATRIX:hstackoffset
	nvar MDCstackbindingnum=root:IMG2MATRIX:hstackbindingnum
	nvar MDCstackEstart=root:IMG2MATRIX:hstackEstart
	nvar MDCstackEend=root:IMG2MATRIX:hstartEend
	nvar MDCstackKstart=root:IMG2MATRIX:hstackKstart
	nvar MDCstackKend=root:IMG2MATRIX:hstackKend
	
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp1=root:IMG2MATRIX:$S_Value
	wave tmp=$tmp1[V_Value]
	string hdcnamepre=tmp1[V_Value]
	//print nameofwave(tmp)
	variable Emin,Einc,Epnts,Emax,xmin,xinc,xpnts,ee0,ii,jj,kk,ee,bindingnumMDC,kx,Emin0,Emax0
	bindingnumMDC=MDCstackbindingnum
	
	//xmin=dimoffset(tmp,0)
	//xinc=dimdelta(tmp,0)
	//xpnts=dimsize(tmp,0)


	
	//Einc=dimdelta(tmp,1)
	//Epnts=dimsize(tmp,1)
	xmin=MDCstackKstart
	xinc=dimdelta(tmp,0)
	if(xinc<0)
		xinc=-xinc
	endif
	xpnts=round((MDCstackKend-MDCstackKstart)/xinc+1)
	
	Emin0=dimoffset(tmp,1)
	Emin=MDCstackEstart
	Einc=dimdelta(tmp,1)		
	Epnts=round(abs((MDCstackEend-MDCstackEstart)/Einc)+1)
	Emax0=Emin0+(dimsize(tmp,1)-1)*Einc
	string MDCtracename,firstMDCtrace
	//print MDCstackKend,MDCstackKstart,xinc,Einc,xpnts
	dowindow/K HorizentStackPanel
	setdatafolder :fittedDispersion:HorisentStack
	killwaves/Z/A
	setdatafolder curr
	
	display/K=1 
	
	//print Emin,Epnts,Einc
	//reverse the fitting order if E_end<E_start
	if(MDCstackEend<MDCstackEstart)
	Einc=-Einc
	endif
	//reverse the fitting order if E_end<E_start
	
	ii=0
	jj=0
	kk=0
	do
	ee0=Emin+kk*Einc

	if(ee0<0)
	//sprintf MDCtracename,"HValueN%.0fmeV",-ee0*1000
	sprintf MDCtracename,hdcnamepre+"N%.0fmeV",-ee0*1000
	else
	//sprintf MDCtracename,"HValueP%.0fmeV",ee0*1000
	sprintf MDCtracename,hdcnamepre+"P%.0fmeV",ee0*1000
	endif
	
	if(kk==0)
	firstMDCtrace=MDCtracename
	endif
	
	make/O/N=(xpnts) :fittedDispersion:HorisentStack:$MDCtracename
	wave MDC4ArbCut=:fittedDispersion:HorisentStack:$MDCtracename
	ii=0
	do
		kx=xmin+ii*xinc
		jj=-bindingnumMDC/2
		do
			ee=ee0+jj*Einc
			if((ee<=Emax0)&&(ee>=Emin0))
			MDC4ArbCut[ii]+=interp2D(tmp,kx,ee)
			endif
		
		//jj+=1
		jj+=0.5
		while(jj<=bindingnumMDC/2)
	
		
		//MDC4ArbCut[ii]+=MDCstackoffset*kk
		
	ii+=1
	while(ii<xpnts)
	//print ee0,Einc
	setscale/P x,xmin,xinc,MDC4ArbCut
	appendtograph MDC4ArbCut
	ModifyGraph offset($MDCtracename)={0,MDCstackoffset*kk} //Edited by JXW
	kk+=MDCstackbindingnum
	while(kk<Epnts)
	
	setdatafolder :fittedDispersion:HorisentStack
	removefromgraph $firstMDCtrace
	appendtograph $firstMDCtrace
	ModifyGraph lsize($firstMDCtrace)=2,rgb($firstMDCtrace)=(512,0,62976)
	ModifyGraph tick=2,mirror=2
	//Label left "\\Z15MDCIntensity"
	//Label bottom "\\Z15K//"
	//ModifyGraph width={Aspect,0.7}
	dowindow/C HorizentStackPanel
	
	setdatafolder curr
	
End

Function HorizentFitting(ctrlName) : ButtonControl
	String ctrlName
	
	string curr=getdatafolder(1)
	string hdcnamepre
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp1=root:IMG2MATRIX:$S_Value
	wave tmp=$tmp1[V_Value]
	
	hdcnamepre=tmp1[V_Value]
	setdatafolder :fittedDispersion
	nvar MDCstackoffset=root:IMG2MATRIX:hstackoffset
	nvar MDCstackbindingnum=root:IMG2MATRIX:hstackbindingnum
	nvar MDCstackEstart=root:IMG2MATRIX:hstackEstart
	nvar MDCstackEend=root:IMG2MATRIX:hstartEend
	nvar MDCstackKstart=root:IMG2MATRIX:hstackKstart
	nvar MDCstackKend=root:IMG2MATRIX:hstackKend
	nvar FittingLorentznum=root:IMG2MATRIX:FittingLorentznum
	
	nvar Fittingbackground1=root:IMG2MATRIX:Fittingbackground1
	nvar fittingheight1=root:IMG2MATRIX:fittingheight1
	nvar fittingfwhm1=root:IMG2MATRIX:fittingfwhm1
	nvar fittingposition1=root:IMG2MATRIX:fittingposition1
	nvar Fittingbackground2=root:IMG2MATRIX:Fittingbackground2
	nvar fittingheight2=root:IMG2MATRIX:fittingheight2
	nvar fittingfwhm2=root:IMG2MATRIX:fittingfwhm2
	nvar fittingposition2=root:IMG2MATRIX:fittingposition2
	
	variable b1,h1,f1,p1,b2,h2,f2,p2
	b1=Fittingbackground1
	h1=fittingheight1
	f1=fittingfwhm1
	p1=fittingposition1
	b2=Fittingbackground2
	h2=fittingheight2
	f2=fittingfwhm2
	p2=fittingposition2
	
		Make/O co_OnePeak={b1, h1-b1, f1,p1,0}//,E_sigma={0,0,0,0,0}
       Make/O co_TwoPeak={b1, h1-b1, f1,p1,0,h2-b1,f2,p2}//,E2_sigma={0,0,0,0,0,0,0,0}  //edited by JXW. Note b2 has no effect really.  
       
       Redimension/D co_OnePeak//,E_sigma
       Redimension/D co_TwoPeak//,E2_sigma
	
	
	variable Emin,Einc,Epnts,Emax,xmin,xinc,xpnts,ee0,ii,jj,kk,ee,kx,Emin0,Emax0
	
	//MDCstackoffset=0
	xmin=MDCstackKstart
	xinc=dimdelta(tmp,0)
	if(xinc<0)
	xinc=-xinc
	endif
	xpnts=round((MDCstackKend-MDCstackKstart)/xinc+1)
	
	Emin0=dimoffset(tmp,1)
	Emin=MDCstackEstart
	Einc=dimdelta(tmp,1)	
	Epnts=round(abs((MDCstackEend-MDCstackEstart)/Einc)+1)
	
	//Epnts=round((abs(MDCstackEend-MDCstackEstart))/Einc+1)
	Emax0=Emin0+(dimsize(tmp,1)-1)*Einc

	//setdatafolder :fittedDispersion
	
	string heightname1,heightname2,fwhmname1,fwhmname2,positionname1,positionname2
	string errheightname1,errheightname2,errfwhmname1,errfwhmname2,errpositionname1,errpositionname2
	if(FittingLorentznum==1)
		heightname1="Hgh1"+tmp1[V_Value]
		fwhmname1="FWHM1"+tmp1[V_Value]
		positionname1="POS1"+tmp1[V_Value]
		errheightname1="HghErr1"+tmp1[V_Value]
		errfwhmname1="FWHMErr1"+tmp1[V_Value]
		errpositionname1="POSErr1"+tmp1[V_Value]
	
		heightname2=""
		fwhmname2=""
		positionname2=""
		errheightname2=""
		errfwhmname2=""
		errpositionname2=""
		make/O/N=(Epnts) $heightname1,$fwhmname1,$positionname1
		make/O/N=(Epnts) $errheightname1,$errfwhmname1,$errpositionname1
		wave hh1=$heightname1
		wave ff1=$fwhmname1
		wave pp1=$positionname1
		wave ehh1=$errheightname1
		wave eff1=$errfwhmname1
		wave epp1=$errpositionname1
	endif
	
	if(FittingLorentznum==2)
		heightname1="Hgh1"+tmp1[V_Value]
		fwhmname1="FWHM1"+tmp1[V_Value]
		positionname1="POS1"+tmp1[V_Value]
		errheightname1="HghErr1"+tmp1[V_Value]
		errfwhmname1="FWHMErr1"+tmp1[V_Value]
		errpositionname1="POSErr1"+tmp1[V_Value]
	
		heightname2="Hgh2"+tmp1[V_Value]
		fwhmname2="FWHM2"+tmp1[V_Value]
		positionname2="POS2"+tmp1[V_Value]
		errheightname2="HghErr2"+tmp1[V_Value]
		errfwhmname2="FWHMErr2"+tmp1[V_Value]
		errpositionname2="POSErr2"+tmp1[V_Value]
		
		make/O/N=(Epnts) $heightname1,$fwhmname1,$positionname1
		make/O/N=(Epnts) $errheightname1,$errfwhmname1,$errpositionname1
		make/O/N=(Epnts) $heightname2,$fwhmname2,$positionname2
		make/O/N=(Epnts) $errheightname2,$errfwhmname2,$errpositionname2
		wave hh1=$heightname1
		wave ff1=$fwhmname1
		wave pp1=$positionname1
		wave hh2=$heightname2
		wave ff2=$fwhmname2
		wave pp2=$positionname2
		wave ehh1=$errheightname1
		wave eff1=$errfwhmname1
		wave epp1=$errpositionname1
		wave ehh2=$errheightname2
		wave eff2=$errfwhmname2
		wave epp2=$errpositionname2
	endif	
	
	
	//reverse the fitting order if E_end<E_start
	if(MDCstackEend<MDCstackEstart)
	Einc=-Einc
	endif
	//reverse the fitting order if E_end<E_start
	
	string energyname="Eng"+tmp1[V_Value]
	make/O/N=(Epnts) $energyname
	wave energywave=$energyname
	
	setdatafolder curr
	setdatafolder :fittedDispersion:HorisentStack
	string MDCtracename
	ii=0
	jj=0
	
	ii=0
	kk=0
	do
	
	ee0=Emin+ii*Einc
	if(ee0<0)
		sprintf MDCtracename,hdcnamepre+"N%.0fmeV",-ee0*1000
	else
		sprintf MDCtracename,hdcnamepre+"P%.0fmeV",ee0*1000
	endif	
	energywave[kk]=ee0
	wave MDC4ArbCut=$MDCtracename

	if(FittingLorentznum==1)
			//FuncFit/N=1/Q=1/ODR=0/NTHR=0 XJLorentzianFit_OnePeak co_OnePeak MDC4ArbCut (MDCstackKstart,MDCstackKend) /D //X=TempEDCx
			FuncFit/W=2/N=1/Q=1 XJLorentzianFit_OnePeak co_OnePeak MDC4ArbCut (MDCstackKstart,MDCstackKend)  /D//E=E_sigma
			hh1[kk]=co_OnePeak[1]
			ff1[kk]=co_OnePeak[2]
			pp1[kk]=co_OnePeak[3]
			
			wave E_sigma=W_sigma
			ehh1[kk]=E_sigma[1]
			eff1[kk]=E_sigma[2]
			epp1[kk]=E_sigma[3]
			//h1=co_OnePeak[1]
			//f1=co_OnePeak[2]
		
		
	endif
	
	if(FittingLorentznum==2)
			//FuncFit/N=1/Q=1/ODR=0/NTHR=0 XJLorentzianFit_TwoPeak co_TwoPeak MDC4ArbCut (MDCstackKstart,MDCstackKend) /D
			FuncFit/W=2/N=1/Q=1 XJLorentzianFit_TwoPeak co_TwoPeak MDC4ArbCut (MDCstackKstart,MDCstackKend)  /D//E=E2_sigma
			hh1[kk]=co_TwoPeak[1]
			ff1[kk]=co_TwoPeak[2]
			pp1[kk]=co_TwoPeak[3]
			hh2[kk]=co_TwoPeak[5]
			ff2[kk]=co_TwoPeak[6]
			pp2[kk]=co_TwoPeak[7]
			
			wave E_sigma=W_sigma
			ehh1[kk]=E_sigma[1]
			eff1[kk]=E_sigma[2]
			epp1[kk]=E_sigma[3]
			ehh2[kk]=E_sigma[5]
			eff2[kk]=E_sigma[6]
			epp2[kk]=E_sigma[7]
			
			
		
		
	endif
	kk+=1
	ii+=MDCstackbindingnum
	while(ii<Epnts)
	
	 if(FittingLorentznum==1)
	 	redimension/D/N=(kk) hh1,ehh1
		redimension/D/N=(kk) ff1,eff1
		redimension/D/N=(kk) pp1,epp1
		//wave ehh1
		//wave eff1
		//wave epp1
	endif
	
	if(FittingLorentznum==2)
	 	redimension/D/N=(kk) hh1,ehh1
		redimension/D/N=(kk) ff1,eff1
		redimension/D/N=(kk) pp1,epp1
		redimension/D/N=(kk) hh2,ehh2
		redimension/D/N=(kk) ff2,eff2
		redimension/D/N=(kk) pp2,epp2
		//wave ehh1
		//wave eff1
		//wave epp1
	endif
	redimension/D/N=(kk) energywave
	setdatafolder curr

End

Function showfitteddisperson(ctrlName) : ButtonControl
	String ctrlName
	
	string curr=getdatafolder(1)
	setdatafolder :fittedDispersion
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    
	nvar FittingLorentznum=root:IMG2MATRIX:FittingLorentznum
	string nametodisplayy1="",nametodisplayx1="",nametodisplayx2=""
	
	dowindow/K FittedDispersion
	display/K=1
	if(FittingLorentznum==1)
	nametodisplayy1="Eng"+tmp[V_Value]
	nametodisplayx1="POS1"+tmp[V_Value]
	appendtograph $nametodisplayy1 vs $nametodisplayx1
	endif
	
	if(FittingLorentznum==2)
	nametodisplayy1="Eng"+tmp[V_Value]
	nametodisplayx1="POS1"+tmp[V_Value]
	nametodisplayx2="POS2"+tmp[V_Value]
	appendtograph $nametodisplayy1 vs $nametodisplayx1
	appendtograph $nametodisplayy1 vs $nametodisplayx2
	endif
	
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	Label bottom "\\F'Times'\\Z18K//(\\F'symbol'p/\\F'Times'a)"
	ModifyGraph width={Aspect,0.7}
	ModifyGraph mode=4,marker=19
	ModifyGraph mirror=2
	dowindow/C FittedDispersion
	setdatafolder curr

End


Function getselfenergy(ctrlName) : ButtonControl
	String ctrlName
	
	
	string curr=getdatafolder(1)
	
	setdatafolder :fittedDispersion
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    
	nvar FittingLorentznum=root:IMG2MATRIX:FittingLorentznum
	nvar energynearEF=root:IMG2MATRIX:energynearEF
	nvar energyfarEF=root:IMG2MATRIX:energyfarEF
	string energyname,kposname,fwhmname
	string realenergyname,imageenergyname
	
	energyname="Eng"+tmp[V_Value]
	kposname="POS1"+tmp[V_Value]
	fwhmname="FWHM1"+tmp[V_Value]
	
	wave wavefwhmname=$fwhmname
	wave energy=$energyname
	
	variable ebare,knearEF,kfarEF,epnts,ii,kpos
	epnts=dimsize($energyname,0)
	knearEF=interp(energynearEF,$energyname,$kposname)
	kfarEF=interp(energyfarEF,$energyname,$kposname)
	
	if(FittingLorentznum==1)
	realenergyname="Real"+tmp[V_Value]
	imageenergyname="Image"+tmp[V_Value]
	make/O/N=(epnts) $imageenergyname
	
	wave tmp1=$imageenergyname
	tmp1=wavefwhmname*(energyfarEF-energynearEF)/(kfarEF-knearEF)*1000
	endif

	dowindow/K ImageEnergyImage
	display/K=1
	appendtograph/L=left tmp1 vs $energyname
	getrealenergy()
	appendtograph/R=right $realenergyname vs $energyname
	Label left "\\Z15Image Energy(meV)"
	Label right "\\Z15Real Energy(meV)"
	Label bottom "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	ModifyGraph mode=4,marker=19
	ModifyGraph mirror(bottom)=2
	ModifyGraph rgb($imageenergyname)=(0,0,52224)
	Legend/C/N=text0/F=0/A=MC
	dowindow/C ImageEnergyImage
	
	//getrealenergy()
	
	setdatafolder curr

End

function getrealenergy()

	//string curr=getdatafolder(1)
	
	//setdatafolder :fittedDispersion
	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    
	nvar FittingLorentznum=root:IMG2MATRIX:FittingLorentznum
	nvar energynearEF=root:IMG2MATRIX:energynearEF
	nvar energyfarEF=root:IMG2MATRIX:energyfarEF
	string energyname,kposname
	string realenergyname
	
	energyname="Eng"+tmp[V_Value]
	kposname="POS1"+tmp[V_Value]
	wave energy=$energyname
	
	variable ebare,knearEF,kfarEF,epnts,ii,kpos
	epnts=dimsize($energyname,0)
	knearEF=interp(energynearEF,$energyname,$kposname)
	kfarEF=interp(energyfarEF,$energyname,$kposname)
	
	if(FittingLorentznum==1)
	realenergyname="Real"+tmp[V_Value]
	make/O/N=(epnts) $realenergyname
	
	wave tmp1=$realenergyname
	ii=0
	do
		kpos=interp(energy[ii],$energyname,$kposname)
		ebare=energynearEF+(energyfarEF-energynearEF)/(kfarEF-knearEF)*(kpos-knearEF)
		tmp1[ii]=energy[ii]-ebare
		ii+=1
	while(ii<epnts)
	endif
	tmp1*=1000
	
end

Function helpimage2matrix(ctrlName) : ButtonControl
	String ctrlName

displayhelpTopic/Z "A versatile tool coded by JXW"
if(V_Flag)
abort "No help files found! Please make sure the file \"Help_001_Image2Matrix_Version1_JXW.ihf\" is present"
endif
End

Function CheckProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar symm1d=root:IMG2MATRIX:symm1d
	nvar symm2d=root:IMG2MATRIX:symm2d
	if(symm1d)
	symm2d=0
	endif
End

Function symm1dcheck(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar symm1d=root:IMG2MATRIX:symm1d
	nvar symm2d=root:IMG2MATRIX:symm2d
	if(symm1d)
	symm2d=0
	endif
End

Function symm2dcheck(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar symm1d=root:IMG2MATRIX:symm1d
	nvar symm2d=root:IMG2MATRIX:symm2d
	if(symm2d)
	symm1d=0
	endif
End

Function/Wave WaveSymmetrizeJXW(Wave1D,SymmValue)

Wave Wave1D
Variable  SymmValue
NVar ErToler=root:IMG2MATRIX:ErToler


    Variable NXO, XminO, XincO, XmaxO
	NXO=DimSize(Wave1D, 0)
	XminO=DimOffset(Wave1D,0)
    XincO=round(DimDelta(Wave1D,0) * 1E6) / 1E6	
	XmaxO=XminO+(NXO-1)*XincO

////    Variable  NxInterWave1D=Round(XincO/ErToler*1000)*NXO
////    Variable  NNxInterWave1D=Round((XmaxO-XminO)/ErToler*1000+1)
    
    Variable  NxInterWave1D=Round((XmaxO-XminO)/ErToler*1000+1)  
    
    
////    Print "Nx=", NxInterWave1D
////    Print "NNx=", NNxInterWave1D

// Print "Xinc=", XincO, "ErToler=", ErToler, "NxInterWaveD=",  NxInterWave1D
//  	Print "XminO=", XminO, "XmaxO=", XmaxO, "XincO=", XincO	
	
	
    Interpolate2/T=1/N=(NxInterWave1D)/Y=Wave1D_L Wave1D
    
    
    Variable NX, Xmin, Xinc, Xmax
	NX=DimSize(Wave1D_L, 0)
	Xmin=DimOffset(Wave1D_L,0)
    Xinc=round(DimDelta(Wave1D_L,0) * 1E6) / 1E6	
	Xmax=Xmin+(NX-1)*Xinc  
	
    Duplicate/O Wave1D_L NWave1D  

    Variable NXL, NXR
    
    IF ((Xmax-SymmValue)<0)    
       NXL=NX
       NXR=0
    EndIF
     
    
    
    IF ((Xmin-SymmValue)>0)    
       NXR=NX
       NXL=0
    EndIF  
    
    
    
    IF ((Xmax-SymmValue)>=0)    
         
         IF ((Xmin-SymmValue)<=0)      
         NXL=Round((SymmValue-Xmin)/Xinc)
         NXR=Round(NX-NXL)
         EndIF       
        
    EndIF
    
//  Print "NXL=", NXL, "NXR=", NXR
    
//  Variable NWaveD=2*max(NXL,NXR)
    Variable NWaveD
    
    IF (NXL>=NXR)
        NWaveD=Round((2*SymmValue-2*Xmin)/Xinc)+1
    Else
        NWaveD=Round((2*Xmax-2*SymmValue)/Xinc)+1 
    EndIF 
    
    
    Variable NWavemin, NWavemax
    
    
    IF(NXL>=NXR)
        NWavemin=Xmin
        NWavemax=2*SymmValue-Xmin
    Else 
        NWavemax=Xmax
        NWavemin=2*SymmValue-Xmax
    EndIF
    
/// Print "Xmin=", Xmin,"Xmax=", Xmax, "NWaveD=",NWaveD, "NWavemin=", NWavemin, "NWavemax=", NWavemax    
    
    Make/O/N=(NWaveD)  EnWave, EnWaveL, EnWaveR
    Setscale/I x, (NWavemin),(NWavemax), EnWave
    Setscale/I x, (NWavemin), (NWavemax), EnWaveL  
    Setscale/I x, (NWavemin), (NWavemax), EnWaveR    
     
    EnWaveL=0
    EnWaveR=0
    
    Variable i
  
   
    i=0    
    DO   
        IF (NXL>=NXR)
            IF (i<NX)
            EnWaveL[i]=NWave1D[i]
            Else
            EnWaveL[i]=NWave1D[NX-1]
            EndIF
//      EnWaveR[NXL-NXR+i]=NWave1D[NX-i]
        Else
//      EnWaveR[NXR-NXL+i]=NWave1D[i]
        
            IF (i<NX)
            EnWaveL[i]=NWave1D[NX-1-i]
            Else
            EnWave[i]=NWave1D[0]
            EndIF 
        
        
        
//      Print NX, EnWaveL[i], Wave1D[NX-1-i]     
        EndIF
        
        EnWaveR[NWaveD-i-1]=EnWaveL[i]
        
             
    i+=1    
    While (i<NWaveD)
    
    EnWave=EnwaveL + EnWaveR
    

////Edit EnWave, EnWaveL, EnWaveR    
//Display EnWave

Return EnWave
    
End

Window symmetrize1dpanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1/W=(512,141,749,216)
	SetVariable Symmtrizeref,pos={7,8},size={120,20},title="\\F'@Arial Unicode MS'SymPoint"
	SetVariable Symmtrizeref,value= root:IMG2MATRIX:symmetrizeref
	SetVariable Ertollerance,pos={131,8},size={100,20},title="\\F'@Arial Unicode MS'Err"
	SetVariable Ertollerance,value= root:IMG2MATRIX:ErToler
	Button get1dsymmtrize,pos={29,42},size={182,19},proc=symmetrize1d,title="\\F'@Arial Unicode MS'Symmetrize"
EndMacro

Function symmetrize1d(ctrlName) : ButtonControl
	String ctrlName

	controlinfo/W=IMG2MATRIX ImagetoBecoverted
    wave/T tmp=root:IMG2MATRIX:$S_Value
    wave selectwave=root:IMG2MATRIX:selectwave
    nvar symmetrizeref=root:IMG2MATRIX:symmetrizeref
    nvar ErToler=root:IMG2MATRIX:ErToler
    
    string symmname
    variable ii,jj,iimax
   	iimax=dimsize(selectwave,0)
   	
    ii=0
	dowindow/K Symmetrized1D
	display/K=1
    do
    	if(selectwave[ii]!=0)
    	symmname="Symm"+nameofwave($tmp[ii])
    	duplicate/O $tmp[ii] $symmname
    	wave symmwave=WaveSymmetrizeJXW($symmname,symmetrizeref)
    	duplicate/O symmwave $symmname
    	appendtograph $symmname
    	endif
    	ii+=1
    while(ii<iimax)
    dowindow/C Symmetrized1D
  
End

Function andersonedcfit(ctrlName) : ButtonControl
	String ctrlName
	
	
	dowindow/F AndersonEDC_Fit
	if(V_flag==0)
	string cmd
	cmd="AndersonEDC_Fit()"
	execute cmd
	endif
	Namelist(ctrlName,3,"CeCoIn5")
End

proc ssymmanglecomp()

dowindow/F SymmAngleCmp
if(V_flag==0)
SymmAngleCmp1()
endif

end

Window SymmAngleCmp1() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(889,188,1063,365)
	SetVariable anglestart,pos={12,16},size={150,20},title="\\F'@Arial Unicode MS'Anglestart"
	SetVariable anglestart,value= root:IMG2MATRIX:anglestart
	SetVariable angleend,pos={13,41},size={150,20},title="\\F'@Arial Unicode MS'Angleend"
	SetVariable angleend,value= root:IMG2MATRIX:angleend
	SetVariable enlargefactor,pos={14,104},size={150,20},title="\\F'@Arial Unicode MS'Factor"
	SetVariable enlargefactor,value= root:IMG2MATRIX:enlargefactor
	SetVariable symmetryangle,pos={13,81},size={150,20},title="\\F'@Arial Unicode MS'SymmAngle"
	SetVariable symmetryangle,value= root:IMG2MATRIX:symmetryangle
	Button getsymmetry,pos={12,132},size={150,20},proc=getsymmetry,title="\\F'@Arial Unicode MS'GetSymmetry"
EndMacro


Function getsymmetry(ctrlName) : ButtonControl
	String ctrlName
	
nvar anglestart=root:IMG2MATRIX:anglestart
nvar angleend=root:IMG2MATRIX:angleend
nvar symmetryangle=root:IMG2MATRIX:symmetryangle
nvar factor=root:IMG2MATRIX:enlargefactor

variable aa,k0max1,k0max2,k0max
if(strlen(CsrInfo(A,""))>0)
	aa=atan2(vcsr(A,""),hcsr(A,""))
	k0max1=sqrt(vcsr(A,"")*vcsr(A,"")+hcsr(A,"")*hcsr(A,""))
	if(aa<=0)
	anglestart=(aa+2*pi)*360/2/pi
	else
	anglestart=aa*360/2/pi
	endif
endif

if(strlen(CsrInfo(B,""))>0)
	aa=atan2(vcsr(B,""),hcsr(B,""))
	k0max2=sqrt(vcsr(B,"")*vcsr(B,"")+hcsr(B,"")*hcsr(B,""))
	if(aa<=0)
	angleend=(aa+2*pi)*360/2/pi
	else
	angleend=aa*360/2/pi
	endif
endif

k0max=max(k0max1,k0max2)	

variable ii,jj,kx,ky,xpnts,ypnts,kxdel,kydel,kangle,kx1,ky1,kxmin,kxmax,kymin,kymax,rs

string imagenameslist
	imagenameslist=imagenamelist("",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave imagename=ImageNameToWaveRef("",imagenameslist)////////

//string imagename=nameofwave
//anglestart=250.755     
//angleend=312.691

string d_imagename1="S_"+nameofwave(imagename)

duplicate/O imagename $d_imagename1

wave d_imagename=$d_imagename1

kxmin=dimoffset(imagename,0)
kxdel=dimdelta(imagename,0)
xpnts=dimsize(imagename,0)

kymin=dimoffset(imagename,1)
kydel=dimdelta(imagename,1)
ypnts=dimsize(imagename,1)

rs=symmetryangle*2*pi/360

//print anglestart,angleend,rs,kxmin,kymin,xpnts,ypnts
ii=0
jj=0
do
	kx=kxmin+ii*kxdel
	
	jj=0
	do
	
	ky=kymin+jj*kydel
	
	kangle=atan2(ky,kx)
	if(kangle<=0)
		kangle=360*(kangle+2*pi)/2/pi
	else
		kangle=360*kangle/2/pi
	endif
	
	if((kangle>=anglestart)&&(kangle<=angleend))
		//if((interp2d(imagename,kx,ky)>0)&&((kx*kx+ky*ky)<=k0max*k0max))
		kx1=factor*(kx*cos(rs)-ky*sin(rs))
		ky1=factor*(kx*sin(rs)+ky*cos(rs))
		d_imagename[ii][jj]=interp2d(imagename,kx1,ky1)
		//endif
	endif
	jj+=1
	
	while(jj<ypnts)
	ii+=1
while(ii<xpnts)
print ii,jj,kx,ky,factor

	dowindow/K SymmetryComp
	display/K=1
	AppendImage d_imagename
	ModifyImage $d_imagename1 ctab= {*,*,PlanetEarth256,1}
	ModifyGraph width={Aspect,1}
	dowindow/C SymmetryComp


End

Window SetColorTool() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(751,123,957,498)
	SetDrawLayer UserBack
	SetDrawEnv fname= "@Arial Unicode MS"
	DrawText 169,347,"LowZ"
	SetDrawEnv fname= "@Arial Unicode MS"
	DrawText 171,370,"HigZ"
	ListBox SetColorImageNameList,pos={10,6},size={189,289}
	ListBox SetColorImageNameList,listWave=root:IMG2MATRIX:SetColorNameList,mode= 1
	ListBox SetColorImageNameList,selRow= 0
	Slider lowzcolorz,pos={37,333},size={129,19},proc=setcolortable_low
	Slider lowzcolorz,limits={-152.879,305.757,0.764394},value= 0,vert= 0,ticks= 0
	Slider highcolorz,pos={37,356},size={130,19},proc=setcolortable_high
	Slider highcolorz,limits={0,764.394,1.91098},value= 152.87873840332,vert= 0,ticks= 0
	PopupMenu setcolortable,pos={11,302},size={91,20},bodyWidth=91,proc=setcolortable
	PopupMenu setcolortable,mode=15,popvalue="",value= #"\"*COLORTABLEPOPNONAMES*\""
	CheckBox inverseornot,pos={106,304},size={58,16},proc=setcolortable_inverse,title="\\F'@Arial Unicode MS'Inverse"
	CheckBox inverseornot,variable= root:IMG2MATRIX:inverseornot
	Button RefreshSetColorImageList,pos={166,297},size={34,34},proc=RefreshSetColorImage,title=""
	Button RefreshSetColorImageList,font="@Arial Unicode MS"
	Button RefreshSetColorImageList,picture= ProcGlobal#refreshbutton
	CheckBox zerolow,pos={7,337},size={24,14},proc=zerolow,title="0",value= 0
	CheckBox zerohigh,pos={7,357},size={24,14},proc=zerohigh,title="0",value= 0
	SetVariable version,pos={6,382},size={70,16},value= _STR:"2011-08-18"
EndMacro

function getsetcolortool(ctrlName) : ButtonControl
	String ctrlName
	string cmd
	//dowindow/F SetColorTool
	variable versionnum
	string str="SetColorTool"
	versionnum=igorprocedureversion(str)
	
	DoWindow/F $str
	
	if(V_flag)
	if(!versionnum)
	dowindow/K $str
	DoWindow/F $str
	endif
	endif
	
	if(V_Flag==0)
	
	wave/T tmp=root:IMG2MATRIX:SetColorNameList
	//wave tmp1=root:IMG2MATRIX:SetColorSelItems
	if(!waveexists(tmp))
	make/O/T/N=0 root:IMG2MATRIX:SetColorNameList
	endif
	
	//if(!waveexists(tmp1))
	//make/O/N=0 root:IMG2MATRIX:SetColorSelItems
	//endif
	cmd="SetColorTool()"
	execute cmd
	endif
	RefreshSetColorImage(ctrlName)
End

proc setcolorscaletool()

string ctrlname=""
imgtomatrix_creatvarialbe()
getsetcolortool(ctrlName)

end


Function RefreshSetColorImage(ctrlName) : ButtonControl
	String ctrlName

wave/T tmp=root:IMG2MATRIX:SetColorNameList
//wave tmp1= root:IMG2MATRIX:SetColorSelItems
variable ii,itemnum
string strlist,tmpstr

strlist=imagenamelist("",";")
itemnum=itemsinlist(strlist)
redimension/N=(itemnum) tmp
ii=0
do
tmpstr=stringfromlist(ii,strlist)
tmp[ii]=tmpstr
ii+=1
while(ii<itemnum)

End

Function setcolortable(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	string curr=getdatafolder(1)
	nvar inverseornot=root:IMG2MATRIX:inverseornot
	nvar lowcolorz=root:IMG2MATRIX:lowcolorz
	nvar highcolorz=root:IMG2MATRIX:highcolorz
	svar choosecolortablename=root:IMG2MATRIX:choosecolortablename
	choosecolortablename=popStr
	
	string imagenameslist

	
	controlinfo/W=SetColorTool SetColorImageNameList
    wave/T tmp1=root:IMG2MATRIX:$S_Value
	//wave sw=root:IMG2MATRIX:SetColorSelItems

	variable intensitymin,intensitymax//,ii,jj,xlength,ylength
	variable inc
	variable lowzero,highzero
	
	//do
	
	//if(sw[ii])
	
	imagenameslist=tmp1[V_Value]
	
	wave tmp=ImageNameToWaveRef("",imagenameslist)////////
	

	
	
	
	intensitymin=wavemin(tmp)
	intensitymax=wavemax(tmp)
	lowcolorz=intensitymin
	highcolorz=intensitymax
	
	
	
	
	inc=2*(highcolorz-lowcolorz)/400
	Slider  lowzcolorz,win=SetColorTool,limits={5*lowcolorz-highcolorz,2*highcolorz-lowcolorz,inc}
	
	inc=(5*highcolorz-lowcolorz)/400
	Slider  highcolorz,win=SetColorTool,limits={lowcolorz,highcolorz*5,inc}
	Slider lowzcolorz,win=SetColorTool,value=intensitymin
	Slider highcolorz,win=SetColorTool,value=intensitymax
	
	
	controlinfo/W=SetColorTool zerolow
	lowzero=V_Value
	controlinfo/W=SetColorTool zerohigh
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

Function setcolortable_inverse(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	svar choosecolortablename=root:IMG2MATRIX:choosecolortablename
	
	variable popnum
	setcolortable(ctrlName,popNum,choosecolortablename)

End

Function setcolortable_low(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	
	nvar lowcolorz=root:IMG2MATRIX:lowcolorz
	nvar highcolorz=root:IMG2MATRIX:highcolorz
	nvar inverseornot=root:IMG2MATRIX:inverseornot
	svar choosecolortablename=root:IMG2MATRIX:choosecolortablename
			
	string tmpstr
	controlinfo/W=SetColorTool SetColorImageNameList
    wave/T tmp1=root:IMG2MATRIX:$S_Value
	tmpstr=tmp1[V_Value]

	//wave tmp=root:ARToFData:$tmpstr
	
	
	
	ModifyImage $tmpstr ctab= {slidervalue,highcolorz,$choosecolortablename,inverseornot}
	lowcolorz=slidervalue
	//ModifyImage $tmpstr ctab= {slidervalue,*,PlanetEarth256,1}
	if(event %& 0x1)	// bit 0, value set

	endif

	return 0
End

Function setcolortable_high(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	
	nvar lowcolorz=root:IMG2MATRIX:lowcolorz
	nvar highcolorz=root:IMG2MATRIX:highcolorz
	nvar inverseornot=root:IMG2MATRIX:inverseornot
	svar choosecolortablename=root:IMG2MATRIX:choosecolortablename
			
	string tmpstr
	controlinfo/W=SetColorTool SetColorImageNameList
    wave/T tmp1=root:IMG2MATRIX:$S_Value
	tmpstr=tmp1[V_Value]
	
	//print inverseornot	
	ModifyImage $tmpstr ctab= {lowcolorz,slidervalue,$choosecolortablename,inverseornot}
	highcolorz=slidervalue
	if(event %& 0x1)	// bit 0, value set

	endif

	return 0
End

proc imgtomatrix_creatvarialbe()

string curr=getdatafolder(1)
dowindow IMG2MATRIX

if(V_Flag==0)
silent 1
newdatafolder/O/S root:IMG2MATRIX
string/G imagelist
make/O/T/N=0 imagenamewave
make/O/N=0 selectwave
//IMG2MATRIX()
variable/G hirizentYpos,verticalXpos,bindingnumH,bindingnumV,kxkyposcursor=0,setdimension,rotatedegree,verticalXposNum,hirizentaYposNum
variable/G horizental2ndnum,vertical2ndnum,symmHornort,symmVornot,scgap,psgap,normanh,normangap,normalbackground,normangama1,normangamma0
variable/G ErToler
/////declare variables for GetKxKyPos panel
variable/G theta,omega,phi,off_theta,off_omega,off_phi
variable/G kxvalue,kyvalue,hv,workfunction,latticeconstant,showoffset
/////

/////declare variable for symmetrizepanel
variable/G symm1d,symm2d,symmanglecomp,symmetrizeref
variable/G anglestart,angleend,symmetryangle,enlargefactor,
/////declare variables for MirrorDispersion panel
variable/G hreffermirror,vreffermirror,left2right,right2left,bottom2top,top2bottom
/////declare variables for MirrorDisperion panel

/////for fit dispersion panel
variable/G hstackoffset,hstackbindingnum,hstackEstart,hstartEend,hstackKstart,hstackKend
variable/G FittingLorentznum,Fittingbackground1,fittingheight1,fittingfwhm1,fittingposition1
variable/G Fittingbackground2,fittingheight2,fittingfwhm2,fittingposition2
variable/G energynearEF,energyfarEF
/////for fit dispersion panel	

///--------------------------For Fit EDCs from YYP
Variable/G FitEDCEnergyStart=NumVarOrDefault("root:IMG2MATRIX:FitEDCEnergyStart",100)
Variable/G FitEDCEnergyEnd=NumVarOrDefault("root:IMG2MATRIX:FitEDCEnergyEnd",100)
Variable/G holedopinglevel=NumVarOrDefault("root:IMG2MATRIX:holedopinglevel",100)
Variable/G Peakposition=NumVarOrDefault("root:IMG2MATRIX:Peakposition",100)
Variable/G FWHM=NumVarOrDefault("root:IMG2MATRIX:FWHM",100)
Variable/G Temperature=NumVarOrDefault("root:IMG2MATRIX:Temperature",100)
Variable/G Background=NumVarOrDefault("root:IMG2MATRIX:Background",100)
Variable/G energyresolution=NumVarOrDefault("root:IMG2MATRIX:energyresolution",100)
variable/G Nameflag
String/G   EDCFileList
String/G   TempEDCName
Variable/G Nameflag
///---------------------------For Fit EDCs from YYP

///--------------------------For SetColorTool
make/O/T/N=0 SetColorNameList
variable/G inverseornot,lowcolorz,highcolorz
string/G choosecolortablename
///--------------------------For SetColorTool


string/G datafoldertocopy,filterprestr
//IMG2MATRIX()
setdatafolder curr
string ctrlname
//RefreshImage(ctrlname)
endif
end

Function zerolow(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
svar choosecolortablename=root:IMG2MATRIX:choosecolortablename
if(checked)
slider lowzcolorz,win=SetColorTool,disable=2
else 
slider lowzcolorz,win=SetColorTool,disable=0
endif
setcolortable(ctrlName,0,choosecolortablename)

End

Function zerohigh(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
svar choosecolortablename=root:IMG2MATRIX:choosecolortablename
if(checked)
slider highcolorz,win=SetColorTool,disable=2
else 
slider highcolorz,win=SetColorTool,disable=0
endif
setcolortable(ctrlName,0,choosecolortablename)


End


proc goto1dpanel(ctrlName) : ButtonControl
	String ctrlName
	process1d()
End
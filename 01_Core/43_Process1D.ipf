#pragma rtGlobals=1		// Use modern global access method

proc process1d()

string curr=getdatafolder(1)
//dowindow/F Process1DPanel
	variable versionnum
	string str="Process1DPanel"
	versionnum=igorprocedureversion(str)
	
	DoWindow/F $str
	
	if(V_flag)
	if(!versionnum)
	dowindow/K $str
	DoWindow/F $str
	endif
	endif

silent 1
if(V_Flag==0)

newdatafolder/O/S root:Process1D
variable/G process1dnormales,process1dnormalee,process1dsumes,process1dsumee,process1dfactor,process1doffset,process1dshowoffset,process1dsmoothtimes
string/G process1dfiterstr,process1drefwave
make/O/T/N=0 process1dwavenamelist
make/O/N=0 process1dselwave
Process1DPanel()

endif

setdatafolder curr
end



Window Process1DPanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(417,79,661,671) as "Process1DPanel"
	ModifyPanel fixedSize=1, frameStyle=1
	SetDrawLayer UserBack
	SetDrawEnv fillfgc= (32768,54528,65280)
	DrawRect 6,295,239,345
	SetDrawEnv fillfgc= (32768,54528,65280)
	DrawRect 6,350,239,473
	SetDrawEnv fillfgc= (32768,54528,65280)
	DrawRect 6,475,239,526
	SetDrawEnv fillfgc= (32768,54528,65280)
	DrawRect 6,529,239,586
	ListBox process1dlistbox,pos={10,49},size={227,240}
	ListBox process1dlistbox,listWave=root:Process1D:process1dwavenamelist
	ListBox process1dlistbox,selWave=root:Process1D:process1dselwave,mode= 9
	Button refresh1dwaves,pos={142,7},size={34,34},proc=process1drefresh,title=""
	Button refresh1dwaves,font="@Arial Unicode MS",picture= ProcGlobal#refreshbutton
	SetVariable fiter1dwave,pos={11,14},size={127,20},title="\\F'@Arial Unicode MS'Filter"
	SetVariable fiter1dwave,value= root:Process1D:process1dfiterstr
	PopupMenu ref1dwave,pos={10,534},size={227,20},bodyWidth=200,title="\\F'@Arial Unicode MS'REF"
	PopupMenu ref1dwave,mode=7,popvalue="EUJF6t25O0PP100NT0P42",value= #"root:Process1D:process1drefwave"
	Button normalize1dwave,pos={170,353},size={64,23},proc=process1dnormalize,title="Normalize"
	Button normalize1dwave,font="@Arial Unicode MS"
	SetVariable precess1denergystart,pos={9,354},size={90,20},title="\\F'@Arial Unicode MS'EnR: S"
	SetVariable precess1denergystart,value= root:Process1D:process1dnormales
	SetVariable precess1denergyend,pos={105,354},size={62,20},bodyWidth=50,title="\\F'@Arial Unicode MS'E"
	SetVariable precess1denergyend,value= root:Process1D:process1dnormalee
	Button process1dsubtract,pos={10,561},size={106,24},proc=process1dsubtract,title="Subtract"
	Button process1dsubtract,font="@Arial Unicode MS"
	Button process1ddevide,pos={121,561},size={115,24},proc=process1ddevide,title="Divide"
	Button process1ddevide,font="@Arial Unicode MS"
	Button process1denlarge,pos={117,376},size={118,23},proc=process1denlarge,title="Enlarge"
	Button process1denlarge,font="@Arial Unicode MS"
	Button process1doffset,pos={117,399},size={118,24},proc=process1dshift,title="Shift"
	Button process1doffset,font="@Arial Unicode MS"
	SetVariable precess1denlargefactor,pos={8,382},size={105,20},title="\\F'@Arial Unicode MS'Factor"
	SetVariable precess1denlargefactor,value= root:Process1D:process1dfactor
	SetVariable precess1dOffset,pos={8,404},size={105,20},title="\\F'@Arial Unicode MS'Offset"
	SetVariable precess1dOffset,value= root:Process1D:process1doffset
	Button normalize1ddisplay,pos={117,320},size={121,23},proc=process1ddisplay,title="Display"
	Button normalize1ddisplay,font="@Arial Unicode MS"
	SetVariable precess1dshowoffset,pos={10,322},size={101,20},title="\\F'@Arial Unicode MS'Offset"
	SetVariable precess1dshowoffset,value= root:Process1D:process1dshowoffset
	SetVariable precess1dsmooth,pos={9,427},size={105,20},title="\\F'@Arial Unicode MS'Smooth"
	SetVariable precess1dsmooth,value= root:Process1D:process1dsmoothtimes
	Button process1dsmooth,pos={118,424},size={118,24},proc=process1dsmooth,title="Smooth"
	Button process1dsmooth,font="@Arial Unicode MS"
	SetVariable set_EnergyS,pos={10,477},size={100,20},title="\\F'@Arial Unicode MS'EnergS"
	SetVariable set_EnergyS,limits={-inf,inf,0.001},value= root:Process1D:process1dsumes
	SetVariable set_EnergyE,pos={116,477},size={70,20},title="\\F'@Arial Unicode MS'End"
	SetVariable set_EnergyE,limits={-inf,inf,0.001},value= root:Process1D:process1dsumee
	Button SumButtonControl,pos={8,501},size={106,24},proc=process1dsum,title="\\F'@Arial Unicode MS'Sum"
	Button DifButtonControl,pos={125,501},size={106,24},proc=process1dDif,title="\\F'@Arial Unicode MS'Differentiate"
	SetVariable setxoffset,pos={10,299},size={106,20},title="\\F'@Arial Unicode MS'EF"
	SetVariable setxoffset,value= _NUM:0
	Button SetFermiEnergy,pos={117,297},size={121,23},proc=setef,title="\\F'@Arial Unicode MS'SetEF"
	SetVariable symmetrizerefer,pos={8,450},size={70,20},title="\\F'@Arial Unicode MS'Ref"
	SetVariable symmetrizerefer,value= _NUM:0
	SetVariable symmetrizeerr,pos={84,450},size={70,20},title="\\F'@Arial Unicode MS'Err"
	SetVariable symmetrizeerr,value= _NUM:0
	Button symmetrize1d,pos={159,449},size={76,22},proc=process1dsymmetrize,title="Symmetrize"
	Button symmetrize1d,font="@Arial Unicode MS"
	Button moveup,pos={182,7},size={25,37},proc=process1dmoveup,title=""
	Button moveup,picture= ProcGlobal#UpButton
	Button moveup1,pos={210,6},size={25,37},proc=process1dmovedown,title=""
	Button moveup1,picture= ProcGlobal#DownButton
	SetVariable version,pos={8,597},size={70,16},value= _STR:"2011-08-09"
EndMacro

////-----------Set EF------------------
Function setef(ctrlName) : ButtonControl
	String ctrlName

controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave


variable ii,iimax,efvalue,xmin,xinc
iimax=dimsize(selwave,0)

string tmpname
dowindow/K SetEFWave
display/K=1
ii=0

    do
    	if(selwave[ii]!=0)
    	tmpname="EF_"+tmp[ii]
    	duplicate/O $tmp[ii],$tmpname
    	wave tmp1=$tmpname
    	controlinfo/W=Process1DPanel setxoffset
    	efvalue=V_Value
    	xmin=dimoffset(tmp1,0)
    	xinc=dimdelta(tmp1,0)
    	setscale/P x,xmin-efvalue,xinc,tmp1
    	appendtograph tmp1
    	endif
    	ii+=1
    while(ii<iimax)
 Dowindow/C SetEFWave


End




/////-----------Refresh----------------
Function process1drefresh(ctrlName) : ButtonControl
	String ctrlName
	
wave/T namelist=root:Process1D:process1dwavenamelist
wave selwave=root:Process1D:process1dselwave
svar process1drefwave=root:Process1D:process1drefwave
svar filterstr=root:Process1D:process1dfiterstr

variable ii,itemnum
string tmpstr
process1drefwave=wavelist(filterstr+"*",";","DIMS:1")

itemnum=itemsinlist(process1drefwave)

redimension/N=(itemnum) namelist,selwave

ii=0
do
tmpstr=stringfromlist(ii,process1drefwave)
namelist[ii]=tmpstr
ii+=1
while(ii<itemnum)

PopupMenu ref1dwave,value= #"root:Process1D:process1drefwave"

ListBox process1dlistbox,mode=9

End

////--------------------Normalize---------------
Function process1dnormalize(ctrlName) : ButtonControl
	String ctrlName

controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave
nvar estart=root:Process1D:process1dnormales
nvar eend=root:Process1D:process1dnormalee

variable ii,imax,normalsum,iimax
iimax=dimsize(selwave,0)

string tmpname
dowindow/K Normalized1D
display/K=1
ii=0

    do
    	if(selwave[ii]!=0)
    	tmpname="N"+tmp[ii]
    	duplicate/O $tmp[ii],$tmpname
    	wave tmp1=$tmpname
    	normalsum=sum(tmp1,estart,eend)
    	tmp1/=normalsum
    	appendtograph tmp1
    	endif
    	ii+=1
    while(ii<iimax)
 Dowindow/C Normalized1D

End

///------------------------Enlarge---------------------
Function process1denlarge(ctrlName) : ButtonControl
	String ctrlName

controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave
nvar factor=root:Process1D:process1dfactor

variable ii,imax,normalsum,iimax
iimax=dimsize(selwave,0)

string tmpname

dowindow/K Enlarged1D
display/K=1
ii=0

    do
    	if(selwave[ii]!=0)
    	tmpname="E"+tmp[ii]
    	duplicate/O $tmp[ii],$tmpname
    	wave tmp1=$tmpname
    	
    	tmp1*=factor
    	appendtograph tmp1
    	endif
    	ii+=1
    while(ii<iimax)
	
dowindow/C Enlarged1D	

End

///----------------------Symmetrize-----------------
Function process1dsymmetrize(ctrlName) : ButtonControl
	String ctrlName

controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selectwave=root:Process1D:process1dselwave
nvar showoffset=root:Process1D:process1dshowoffset

variable symmetrizeref,err

controlinfo/W=Process1DPanel symmetrizerefer
symmetrizeref=V_Value

controlinfo/W=Process1DPanel symmetrizeerr
err=V_Value

    string symmname
    variable ii,jj,iimax
   	iimax=dimsize(selectwave,0)
   	
    ii=0
    jj=0
	dowindow/K Process1DSym
	display/K=1
    do
    	if(selectwave[ii]!=0)
    	symmname="Symm"+nameofwave($tmp[ii])
    	duplicate/O $tmp[ii] $symmname
    	wave symmwave=WaveSymmetrizeJXWV2($symmname,symmetrizeref,err)
    	duplicate/O symmwave $symmname
    	appendtograph $symmname
    	ModifyGraph offset($symmname)={0,jj*showoffset}
    	jj+=1
    	endif
    	ii+=1
    while(ii<iimax)
    dowindow/C Process1DSym

End

Function/Wave WaveSymmetrizeJXWV2(Wave1D,SymmValue,err)

Wave Wave1D
Variable  SymmValue
variable err
variable ErToler=err

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

///----------------------Shift----------------------
Function process1dshift(ctrlName) : ButtonControl
	String ctrlName

controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave
nvar offset=root:Process1D:process1doffset

variable ii,imax,normalsum,iimax
iimax=dimsize(selwave,0)

string tmpname
dowindow/K Offset1D
display/K=1
ii=0

    do
    	if(selwave[ii]!=0)
    	tmpname="OF"+tmp[ii]
    	duplicate/O $tmp[ii],$tmpname
    	wave tmp1=$tmpname
    	
    	tmp1+=offset
    	appendtograph tmp1
    	endif
    	ii+=1
    while(ii<iimax)
    
dowindow/C Offset1D   
End

////////---------------------Subtract----------------
Function process1dsubtract(ctrlName) : ButtonControl
	String ctrlName
	
controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave

controlinfo/W=Process1DPanel ref1dwave
wave reftmp=$S_Value

variable ii,imax,normalsum,iimax
iimax=dimsize(selwave,0)

string tmpname
dowindow/K Subtract1D
display/K=1
ii=0

    do
    	if(selwave[ii]!=0)
    	tmpname="S"+tmp[ii]
    	duplicate/O $tmp[ii],$tmpname
    	wave tmp1=$tmpname
    	
    	tmp1-=reftmp
    	appendtograph tmp1
    	endif
    	ii+=1
    while(ii<iimax)

dowindow/C Subtract1D
End

///---------------------Devide--------------------
Function process1ddevide(ctrlName) : ButtonControl
	String ctrlName
	
	
controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave

controlinfo/W=Process1DPanel ref1dwave
wave reftmp=$S_Value

variable ii,imax,normalsum,iimax
iimax=dimsize(selwave,0)

string tmpname
dowindow/K Devide1D
display/K=1
ii=0

    do
    	if(selwave[ii]!=0)
    	tmpname="D"+tmp[ii]
    	duplicate/O $tmp[ii],$tmpname
    	wave tmp1=$tmpname
    	
    	tmp1/=reftmp
    	appendtograph tmp1
    	endif
    	ii+=1
    while(ii<iimax)
dowindow/C Devide1D
End

///---------------Display-----------------
Function process1ddisplay(ctrlName) : ButtonControl
	String ctrlName

controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave
nvar showoffset=root:Process1D:process1dshowoffset

variable ii,jj,iimax
iimax=dimsize(selwave,0)
//dowindow/K Process1DGraph

display/K=1
   ii=0
    jj=0
    do
    	if(selwave[ii]!=0)
    	appendtograph $tmp[ii]
    	ModifyGraph offset($tmp[ii])={0,jj*showoffset}
    	jj+=1
    	endif
    	ii+=1
    while(ii<iimax)
//Dowindow/C Process1DGraph


End

////------------Smooth

Function process1dsmooth(ctrlName) : ButtonControl
	String ctrlName

controlinfo/W=Process1DPanel process1dlistbox
wave/T tmp=root:Process1D:$S_Value
wave selwave=root:Process1D:process1dselwave
nvar smoothtimes=root:Process1D:process1dsmoothtimes
variable ii,imax,normalsum,iimax
iimax=dimsize(selwave,0)

string tmpname

dowindow/K Smooth1D
display/K=1
ii=0

    do
    	if(selwave[ii]!=0)
    	tmpname="SM"+tmp[ii]
    	duplicate/O $tmp[ii],$tmpname
    	wave tmp1=$tmpname
    	
    	smooth smoothtimes, tmp1
    	appendtograph tmp1
    	endif
    	ii+=1
    while(ii<iimax)
	
dowindow/C Smooth1D	

End
//------------------Sum
Function process1dsum(ctrlName) : ButtonControl
  String ctrlName
  
  controlinfo/W=Process1DPanel process1dlistbox
  wave/T tmp=root:Process1D:$S_Value
  wave selwave=root:Process1D:process1dselwave
  variable ii,iimax
  nvar estart=root:Process1D:process1dsumes
  nvar eend=root:Process1D:process1dsumee
  iimax=dimsize(selwave,0)
  
  string tmpname


  ii=0
     do
     if(selwave[ii]!=0)
     tmpname="Sum_"+tmp[ii]
     duplicate/O $tmp[ii],$tmpname
     wave tmp1=$tmpname
     
     print nameofwave(tmp1),"=",sum(tmp1,estart,eend)
     
     killwaves/Z tmp1
    
     endif
     ii+=1
     while(ii<iimax)
    
End  


//-------------------Differentiate
Function process1dDif(ctrlName) : ButtonControl
  String ctrlName
  
  controlinfo/W=Process1DPanel process1dlistbox
  wave/T tmp=root:Process1D:$S_Value
  wave selwave=root:Process1D:process1dselwave
  variable ii,iimax
  nvar estart=root:Process1D:process1dsumes
  nvar eend=root:Process1D:process1dsumee
  iimax=dimsize(selwave,0)
  
  dowindow/K Differentiate1D
  display/K=1
  string tmpname


  ii=0
     do
     if(selwave[ii]!=0)
     tmpname="Dif_"+tmp[ii]
     duplicate/O $tmp[ii],$tmpname
     wave tmp1=$tmpname
     
    Differentiate tmp1
     
    Appendtograph tmp1
     endif
     ii+=1
     while(ii<iimax)
 
    dowindow/C Differentiate1D
End  


Function process1dmoveup(ctrlName) : ButtonControl
	String ctrlName
  
  controlinfo/W=Process1DPanel process1dlistbox
  wave/T tmp=root:Process1D:$S_Value
  wave selwave=root:Process1D:process1dselwave
 
  string tmpstr
  variable ii,iimax 
  iimax=dimsize(selwave,0)
 
 	 ii=1
     do
     if(selwave[ii])
     tmpstr=tmp[ii-1]
     tmp[ii-1]=tmp[ii]
     tmp[ii]=tmpstr
     selwave[ii]=0
     selwave[ii-1]=1
     endif
     ii+=1
     while(ii<iimax)
  
  
End

Function process1dmovedown(ctrlName) : ButtonControl
	String ctrlName
	
  controlinfo/W=Process1DPanel process1dlistbox
  wave/T tmp=root:Process1D:$S_Value
  wave selwave=root:Process1D:process1dselwave
 
  string tmpstr
  variable ii,iimax 
  iimax=dimsize(selwave,0)
 
 	 ii=iimax-1
     do
     if(selwave[ii])
     tmpstr=tmp[ii+1]
     tmp[ii+1]=tmp[ii]
     tmp[ii]=tmpstr
     selwave[ii]=0
     selwave[ii+1]=1
     endif
     ii-=1
     while(ii>=0)

End

// PNG: width= 137, height= 46
Picture refreshbutton
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
	>J7!#.@`6pXdsg?`!WE)alKn*YD7\MZE[Us\Bo+KPZr"\/:&2Fb,XCe,kjQ#($R=^IUXAb%;'UuH2q
	Q.fLWDoJ4"MS6ik<8sooKoO]-@S"9EP)TY)OO/R++:2b(N/ee#baY"Zn*8a?%?IbHDn^%)eS]k]Lc=
	eqn+EmarVI\mO:VKm^\oI<rSR)V1G^hL87Zme<`'Q*dl<A/3#j4j-"UY!2)R64O(Y#-%E#\rj[slH4
	+qRDa.guFkiaFKcuko>32b5.;Gn,5"KJN'h/;sJn)j6;JUrCGp@c7OZ?.Fc<HS:l,d8>V[/S*oCcnT
	6Z-6Cd>*d^ph0o"`g%"TP<E0VtU*t%%#9h#&'1+[=j#F3KZujKW/T#?A'bqJ,H6@mRr:8$pPEXb1Dd
	SFLY-+q6B?s=H9]Yej)hS'H1$3bQA_B<kY]]9_/R,Xd!eHUYq;R;cAhk6n1:YoPN$kqJ#,C"&'-kmm
	7PtGP&-/"^'$lm>jc*^KQAr`#RaPZ;F"Kl\iO(o=^:SPYF*Q5Ba2c5-IJ).\nSqD?=dEV9#2O1hDiW
	j[Q=X4MZ7K!U0ufn`ki%:=DJa6uq)X!&q"<t)_r:+:^]*nk&D+*ms7suj*fWWjKjYaPAQb&R(l#:H/
	!nEk6E7&cp?^IRf3NURI(f*n/*#[Mp%@ubqqBZQUb&(Y^\6g/5C>FK];0L108]faE#d%T%)X3D!.Y%
	g\tNo>>=+gr^.7VEYcG0hk<<L^s8;3W?hocSY<DoR<@Jk*)LCqm(Bm)9"G)"PbHc4Dn92-n-]4YMlZ
	KaCR\n&50rNL2Dr8:+VP_sOHS(@NgiLe)=0GqYk*]kJ6!V-Oq5'EaE]TaRcY'Re#U-%'p07m>0FWYS
	3h<:N`aUZpchG?k:Me[fiFbCPR:-pa/M3)UA514$7UprBe'lbpe)>CX63mSl6?K,LKFhT17M&[YB4Z
	W?Aj2VVGm(?aHen\u)]c3a!-ma0h%P]LO^gWIi21@\6d#\?\@D=ims\=L"HMLtR>bjKp.At#QL[RZh
	Qe\uA]<EKj72pCr`h&lM*t7@<,$(2_[euE\@<B47$_!/bfn<*^@se"gW_F2U*pjg!!#Gr(e,&>;%sU
	/2M<>IoVU7+p&"]FU-p1;78YNa.X(:;4Ztqk2)Y(!dnd0AAY[YlD]X61#d2Sg0qD;N!?B.a\*Ou!#R
	Q%^!_eEI>F%\`+[1s^2,qFXX(u\J9^gWMh2PpnM;d[HiI`.hT=KPT>P5c,c#5/VE]>'/GW_NlbHgL)
	GZ^:)qu&.6COU_]EH)S#/4l#VlU;'[!'#uP"9ALaa^dLTci*UqT1C5"91tV;Q;#b4$1[lXY>_S?(De
	lqN%E.YYF"9/^YeL%3b,Es,*BYXe,'Co63tp/JfkUk17=*Ql[@]B#F:[A8kVh;n[N.5L%9YI1>T0`p
	htX/]Z]\a,aFn&Bb6cL!-o7L4Mu0/7A.igE&_Ee+Pj7)NY-O@!g(]BDC9r.Q4:Vbrq$'oJFL?!>N8?
	4Z3XRKf\G7eIt)rfEH*NFK+N3JFAu=C,D<^9n#fs.kVJ*j$kEmCp\/%,G"n-qWi@P7AMM3S##3Q?V,
	@eY6W"PtBXXG[2DHq+mFntRZEi`ZBqFMV]C3JVb"@=`EH1N/*BWI@WDmVGB^!U(/!3B@l#_Zt@@K6J
	k7,=*'ZK$MUsj%(^C]B7AZ*jEY"^@qeY1W#4I8W@#<\9&&r/#=Q+<?!MmKF,,FZ,+Yo&n#-Oa?[m!$
	!Ne$:qKM#tl*:s!D]M;,YSQ"/0M3\QCR7$(iCqprU"6.7[Nn[QKqkj7YX]A8.%Cc5Kr;e&&PEk-A[f
	Wer,Nd*[8k006O(G>soJ\&ERdkkpT1CO@/KJB@T?3kQDl;\,Kgt\FWmsjD\7q>aLK]I0a63rXme'ZR
	jdEs[55C`P%l+XmGMMd:[RMoJ`D(e0iK.c"ILc^j7eU>-Pmu,.#321i`Ok-OQ5JnU[=o3En8j!1UG\
	B/=!6iEIe)qrgH>h(Xac5tYZ7P4*`H)I60c6+!>%8*H!+63X":-TWCijdK1ej"j%NIIdEk/,tRARN0
	AE<L^%im_'i.DQ33-!s+V+Wmom\FAj8[9m?f6'F$1<RVV`cPL1\Qhooq4oEr<;82fX$W&:Q@A7CTA.
	&+pPBP2Y$ANCF6?<AZKPbqXI5r"=]XK3M#O`Ba@,3tWiCnPs-j*2RqdSMa:V+'4X0"2DIn:Kk9&UXY
	MXfgZObWJO,h7m@c7rt6fK6h&4-Re#!p-N\qs-s'd9';SP:@BHhQe4KgJP4e*H\<h/5Li=E_ppZ)"2
	Vl)1/&o[-1dHL!.$'2X69:"(eTPobEuFuGUXmG5B5&.#dN/t^H[+W+h9#dM%Tr#=Pg`kD-'qrXAd;U
	7V[j/N["5'/QG>YM2Si%H/*'b5Nr-3DL=dQ*AP?PPrdfn0em5IA-'p_t#6kS`Z!DZDn4=r8DR!72.u
	o;dXn91qnm'c$-'m4?FI#jG>heTJlAqq:iBHA5i6+Ul8UVQ&mm@2Lh+."!e48CZ/=['d<h0S3k=6AV
	LQPj!6n4<AESBV<%)#Us+[!EQJ2FAA<m>1hL@hUWNab?V;B/G4fOOd#S5dK>P/HLA!*',_E#RrsN,F
	lU&a2&#:&?Al+LNfK9c&r4B`G.V$4QeUm;KgP*dkL?J0QS2]`Df<s41=X#p:"+5jdkhshHn;EoVsh=
	n?L!"hKZE,PW2Nf_BmJ`u2b$8+[Vjp$-jo(ZL7k,N\Wpm?jUdfoH=4)"_%Fns%-2\%LdMqB+f"o$kl
	JY@m9Al9MT-iR@A4WA2m?^&Y[[S4!4B5B>IJ?f3#nY@g6O%Bi]7Xa]tNUSS_Lo/IkI(/]A3`9__>b5
	5aNGOd;JXModqaI%Yk-rCsRb[8aAW`GB`fUp[@"S?VqMua$UT*AdG+Z&jiOIIZ1R#.d-QIgGT6j`XI
	J:"Bbpi"a9i\o%a[4hKj\4M9``n)')&"#uD)4)E;A;ahS=<ljDMCrqF0''+sMg<q]*Rf66G3K7cDbd
	>t_QgXb-6CK!J(Th-YcE+*1K\@B&QLDO9A@3#V7Mj@r-&A>cja,V1p\T;CZ:CeV%6I>_rIqNA*WiN1
	e;g(r0\@fcIQN)QR`eXL+5Pb$a5J(h=^t?ar(*SkQ%KVDT:'&H\HR#"e)9T\lp=ncUSYM5&<Xm1QrH
	j!Brm7?+G)YR*3hLce3D#C"`KPui=&r?;hDoT8`9#1/,tV8H!?i_A/1`?"i<s#F[VZt3^8S!o>Mo:C
	,Y9ga=P4OGWN)t%:0D_dB:@D^^2\fKTb6M/#KsC]!2*mj:_["35ZZEBrS7X4_"A.s@gaLe!Ml^cXnO
	Lm`%o"YBk<jUkOXt)Q9klQgPoBr+:./VT+?WB>ISLXT<GE#/tCm#2>bCQ)eESlKb25B`C33a#U.nda
	)O#UqsV:,='+#/gh]2^='&I)=18Z-//GjCo;6BJ[j\jC\bODks1YGQK5Lo$/-?IeQiKGYb;'m:Npgk
	dDVK96r#uL7:VV;X!dNI[D@q8S3<10)!((+JpRhg5c,4666u*OC/<>aKn3$a;Zd7(TBP!s-6A$g-@<
	*?3k007-^-4W[VqI?+/Ps-U6*Di_6UO4)TC81\Sls6&@uO.2>R'`D47>j;:#16lh&iE90Wg5*Irk3N
	_o,<$Pm-4[(kePr@7fDRLMoA\[JGS%SK)uLRi$f(!Ne(1J-!HQI-2l,psO`\NAW$*$<WNPg1YBJ0[/
	nMm**\tdA'4`ietN42)SB5<(%rXqI4A]mkST9%"f>L-j6ZdYq.ss3LNPfNugHq:-`;+`q8o1hs\$l2
	d-nE/CiPp2C?AJE)ni:Gsg*j9fKD(,FQqQ$P/4ba2Y!ko;.41JQiL2RF+o84e&pD=X1(_ac%r2[Wns
	),-U738cs:L;3fNcmI]YlLCYL#q0_KZ&BhBAk2m@H8Z1%:<(^0@iSib]f<77UNg0[dZ7K:E<6I%b9N
	P<I=2+5?Vpi0dKP?mu+9i#S7Ros[=^He;5`!3"M*iJJGSU;[3!RXR09(oYJ,$L"r>p5)UtKuN\r]Wt
	od*%6;D^g"c<_EI/Lh0]etJ&*(E/`#2)W)HqWf@N,O;"1N)`kPVpiauP$UqU4GaX?qu,hJd-Bqo9q-
	V%MdP8PH#nDV-q#PM8uL/.Gl6XEPCank'c!j6@mYin%Uf_N/4'nMQuG1!G%8ZDZ@QK:qVF#nea`nF!
	9SD3';B6P5CDs_fB;9tX('QJd%Ho/1<-i/Z#O5^ioQM6DJO%B^OL`)8]f*kZe6l]@p#%N&F/NE\U!e
	Dg[-UH041]G4O;JUJO0>:R[T[77n8U\44`9F^2MoCPsj*\P%g@X91p+3#[qq$p[%7JbN0(b6HcJ>&-
	)ah=X7sB7?A_To&d+BNC\/=q<q+$?Q*.(10$,OH#l0K/uJ7)SFO3IrNf.CWS^_BP?2$FK`uodUf8i*
	Ek,@X>=V.PIdht3*'\n"Ci!ojE]6'A9*ipf4e5??5(1#?Vl.2?>S)S.`l@ZpW;35e.A+r<gtY"G0_#
	#3ci<R&^RUga>j36-P=[*bVbWeoEofo=H+>1l)`MY>`QD9engjhF!!k-6?pZOjMFodCW19H%r8Xu-h
	Wk+(o8g;fDHsng@9RnId4erb!s8PKpQ(oZ4C1o`'(EbIYB-N]g!pgtis`iP1sI]_\ft*R/M/Q>Abk?
	)M][?95qj.O&O:VeGqtd-*ZiVgEqAnoj5]11>V7!+lae,EKpG.Ne->:Cdko<s5#2h]<E8YdHnZC:']
	m4C5O@\#.PEHQ&A_a.*fj[?G"kue\[a_(%]QJ.b%@uf[C*hYE#$M4"F13?(.8^C#RMiF&DaQGWkn16
	j'<UA7d#j3j@j(9oAI'GNn3K)T7cPQ:!RCWRK\5LPg&dlNt%)h/&N+$AGX"l%BE)\6:dF(WMukgSt<
	sA`_\(Jcf]#&D&>`+T@YpElh+0)lg!b]pYC%-&V_oQRU?;O6([9&k2sDSeZUS5ETsRGZ90irEUi&-V
	P^4u0LujH$DFK"VJ/5d%qD,#,bi]MTDnI1]B2I(,Y8=G!XPJn-?J\7_,Vs&VM,='/-B%0;3WU95aJ7
	BP0`HkDW"dVaQ<rbiF4bqZC(([mF?^^mH%0$>SV3N!e4],V<MSIUWk**(ieXPjXe:Td!0ri``4<i'Z
	Gc[L#1\C4aZmMo[-1t^%YiEAL/p?dJ<tT+D<@Vlh(lWW5$B^)i`u,-71c84'Pll$?JeMdNqJRSXo06
	leB$qDh!9:aN-n`AL7#7L10;WDKfb!]#u3A8R`M`)N>dtE1inu_+l9D:dt]k&3(tRH>_u.n+MS^'.b
	f;W[qWkdLARm/`"41]W(3401qra)28l#kHE2X1eiaU5jHji*iCP[&jJB:rTq@d5d>[hjAVb?S"#=(,
	+n_]V]$Hl2K.G73&l0A_M(N+ic;RT8YTEQG`>2KX01d1A9.G4h$4H3b[`I;_bdV9Q@][:R[T+%,#:A
	p<-<>+6USc,^qbX3(DK;X]A8\Z]/SLE'LK#TX/bI5dSa^jk@9Q9QH<\(mCPHEl%[#q9JVkrokrZLK?
	][Xc<m+^I'7=_W49@Ympd3SZqSreQsblXM$YM^j#K'=?n>fH/IPc"$QR>61c[;hkdJ9*H^bF2B,K2p
	Ua]j_$O`(fjN*H.[C*E!7)Ce*g=k7W-o<h?2E3ZU4[#o]R_A)Z;aU=52*bI!&OI3I'qbKtVq]qZ1ej
	a:Q\lTePZTIPMoC\r3>)[Q.)^iL)_*?g7n6()LPMYPW35H.".6f6Ii^3:ciR?0*:E1[Ci4,k<L!c4F
	q("](aD;MA]5FL2ue-ebPO3*f)(`6qSgK5N^i&A/k(O"Adh-EA/EDq4Nj*-ZiJ+3"TT_@G"I5rb9Dh
	0eOfb>qnlcgU.rnq&]8W/k'<Q(7fAZ)bD-TMhRn,T17>MMpm,KF_r4E?PY<E6Z.R:Ebl%Bd/sip1a>
	@,nHG,T/Pq=R>F`hg:LP&(lp:dGqI_/jf`uffD^:ldr9%ac/OQu,rE&^N7VPg=.()BkLV<AVF`a;_G
	<@odS[C*E*,gi@mKb+4aBG^r3aN8KJci2D^J,IPS4.?;.<0djuYtU+9\])eNGe@rG4eK_3PI2OZE?'
	K/'4>"r1+c3ZYc.l@Cg4%9anoflCB>9&%*S0'a)N*T_5B)'RV"1=j#AZXb>BoaopG;ZRO4#KW+G)^q
	0YA%784<r\q*=P/rdMWE(@m'-:TgUaQN.GbL.NY7^:XE0aEE*%[9`"+:&I4_rpX=SCE:dboR#g!+Ll
	f_>Vu`B,6[)[t[eKS7.enF"pB&@hW7nZE0n03jYb;UpR[sQISO_+:(<CbQWmbWdnkpPs8C1L57,U;%
	3?5bbLT,24=a(C-kXLg5*GcD9!*oZIi=@arnE[.8&/=6J*]?&G0-3EGJ/Q_2r%NS#6oqna)[YSY-T"
	h5XEc!Y@\S5qKoo*6YQ;!!j^%^RYe^a]ShVX=R64Ved6ZK6=dMBEq]6E=LXh-_@1aP]geKlTd#]DB4
	Np#7Lrnf"Mprh88Q_A]H.a;^(l-'DEj))Phd5/>E.<cPl`m5cfG*LYfCP\ojCuj%gH9^Wk^:Kd1mC2
	#tRXXJ)T,7NVU1!!#SZ:.26O@"J
	ASCII85End
End


proc TD21D()

string curr=getdatafolder(1)
dowindow/F TD21D_Panel
if(V_Flag==0)
newdatafolder/O root:TD21D
string/G root:TD21D:Namelist41D
make/O/T/N=0 root:TD21D:TD21DNamelist
make/O/N=0 root:TD21D:TD21DSelItems
TD21D_Panel()
endif

Window TD21D_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(484,115,701,475)
	ListBox TD21D_listbox,pos={6,6},size={210,269},listWave=root:TD21D:TD21DNamelist
	ListBox TD21D_listbox,selWave=root:TD21D:TD21DSelItems,mode= 9
	Button TD21D_Refresh,pos={78,278},size={64,23},proc=TD21D_Refresh,title="Refresh"
	Button TD21D_Refresh,font="@Arial Unicode MS"
	Button TD21D_Get1D,pos={111,303},size={103,23},proc=TD21D_EDCIntegegrate,title="IntegrateEDC"
	Button TD21D_Get1D,font="@Arial Unicode MS"
	SetVariable TD21D_Fitler,pos={7,279},size={69,20},title="\\F'@Arial Unicode MS'Filter"
	SetVariable TD21D_Fitler,value= _STR:""
	CheckBox TD21D_EnergyAxisH,pos={4,308},size={67,16},title="\\F'@Arial Unicode MS'EAxis:  H"
	CheckBox TD21D_EnergyAxisH,value= 1,side= 1
	CheckBox TD21D_EnergyAxisV,pos={75,308},size={26,16},title="\\F'@Arial Unicode MS'V"
	CheckBox TD21D_EnergyAxisV,value= 0,side= 1
	Button TD21D_display,pos={143,278},size={68,23},proc=TD21D_Display,title="ShowImg"
	Button TD21D_display,font="@Arial Unicode MS"
	PopupMenu TD21D_display1d,pos={6,332},size={100,20},bodyWidth=100,proc=TD21D_dispaly1D
	PopupMenu TD21D_display1d,mode=1,popValue=" ",value= #"root:TD21D:Namelist41D"
	Button TD21D_get1dprocedure,pos={111,329},size={100,25},proc=TD21D_get1dprocedure,title="\\F'@Arial Unicode MS'1DProcessPanel"
EndMacro

Function TD21D_Refresh(ctrlName) : ButtonControl
	String ctrlName
wave/T nw=root:TD21D:TD21DNamelist
wave sw=root:TD21D:TD21DSelItems
string filterstr,tmpstr,namelist
variable ii,iimax
svar Namelist41D=root:TD21D:Namelist41D
controlinfo/W=TD21D_Panel TD21D_Fitler
filterstr=S_Value
namelist=wavelist(filterstr+"*",";","DIMS:2")
iimax=itemsinlist(namelist)
redimension/N=(iimax) nw,sw
ii=0
do
	nw[ii]=stringfromlist(ii,namelist)
	ii+=1
while(ii<iimax)

Namelist41D=wavelist("Inte*",";","DIMS:1")

PopupMenu TD21D_display1d,popValue=" ",value= #"root:TD21D:Namelist41D"

End

Function TD21D_EDCIntegegrate(ctrlName) : ButtonControl
	String ctrlName

wave/T nw=root:TD21D:TD21DNamelist
wave sw=root:TD21D:TD21DSelItems
svar Namelist41D=root:TD21D:Namelist41D
string name1d
variable ii,iimax,xpnt,ypnt,jj,eish,eisv,xmin,xinc,ymin,yinc

controlinfo/W=TD21D_Panel TD21D_EnergyAxisV
eisv=V_Value
controlinfo/W=TD21D_Panel TD21D_EnergyAxisH
eish=V_Value
iimax=dimsize(nw,0)

ii=0
do
	if(sw[ii])
	name1d="Inte_"+nw[ii]
	wave w=$nw[ii]
	
	if(eisv)
	xpnt=dimsize(w,0)
	
	ypnt=dimsize(w,1)
	ymin=dimoffset(w,1)
	yinc=dimdelta(w,1)
	
	make/O/N=(ypnt) $name1d
	wave inte_w=$name1d
	inte_w=0
	setscale/P x,ymin,yinc,inte_w
	jj=0
	do
	inte_w+=w[jj][p]
	jj+=1
	while(jj<xpnt)
	inte_w/=xpnt
	endif
	
	if(eish)
	xpnt=dimsize(w,0)
	xmin=dimoffset(w,0)
	xinc=dimdelta(w,0)
	
	ypnt=dimsize(w,1)
	
	
	make/O/N=(xpnt) $name1d
	wave inte_w=$name1d
	inte_w=0
	setscale/P x,xmin,xinc,inte_w
	jj=0
	do
	inte_w+=w[p][jj]
	jj+=1
	while(jj<ypnt)
	inte_w/=ypnt
	endif
	
	endif
	ii+=1
while(ii<iimax)
Namelist41D=wavelist("Inte*",";","DIMS:1")

PopupMenu TD21D_display1d,value= #"root:TD21D:Namelist41D"

End

Function TD21D_Display(ctrlName) : ButtonControl
	String ctrlName

wave/T nw=root:TD21D:TD21DNamelist
wave sw=root:TD21D:TD21DSelItems
variable ii,iimax
iimax=dimsize(sw,0)
ii=0
do
if(sw[ii])
display/K=1
appendimage $nw[ii]
ModifyImage $nw[ii] ctab= {*,*,PlanetEarth256,1}
break
endif
ii+=1
while(ii<iimax)

End

Function TD21D_dispaly1D(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
display/K=1 $popStr

End

Function TD21D_get1dprocedure(ctrlName) : ButtonControl
	String ctrlName
	string cmd
	cmd="process1d()"
	execute cmd
	
End

#pragma rtGlobals=1		// Use modern global access method.

Proc InfoTableFillTool()
Newdatafolder/O/s root:infotabletool
Variable/G Fillstart,FillEnd,Valuetobefilled,Valuedelta
String/G infowavename
Dowindow/F tabletool
if (V_flag==0)
InfoTableTool()
else
//Dowindow/F infotabletool
Endif

Window InfoTableTool() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(425,240,682,479) as "InfoTableTool"
	ShowTools/A
	PopupMenu ItemTobefilled,pos={26,19},size={211,20},proc=Getinfowave,title="Item to be filled"
	PopupMenu ItemTobefilled,mode=1,popvalue="Theta_Angle1D",value= #"\"Theta_Angle1D;Phi_Angle1D; Omega_Angle1D;Temperature1D; BLI0_1D;Spinfile_ID;SpinCh_total;Spin_Channel;Process1DFlag\""
	SetVariable FillStart,pos={27,53},size={133,16},title="Fillstart"
	SetVariable FillStart,value= root:infotabletool:Fillstart
	SetVariable FillEnd,pos={27,79},size={133,16},title="FillEnd"
	SetVariable FillEnd,value= root:infotabletool:Fillend
	SetVariable Valuetobefilled,pos={27,103},size={133,16},title="Valuetobefilled"
	SetVariable Valuetobefilled,value= root:infotabletool:Valuetobefilled
	Button StartFill,pos={27,160},size={95,24},proc=DoFill,title="StartFill"
	SetVariable ValueDelta,pos={27,127},size={133,16},title="ValueDelta"
	SetVariable ValueDelta,value= root:infotabletool:Valuedelta
EndMacro

Proc DoFill(ctrlName):Buttoncontrol
string ctrlname
variable i=0,ilimit, Startpnt,Endpnt, valuestart,delta
string Itemname
startpnt=root:infotabletool:fillstart
endpnt=root:infotabletool:fillend
valuestart=root:infotabletool:valuetobefilled
delta=root:infotabletool:valuedelta
Itemname=root:infotabletool:infowavename

i=0
Do
     
root:spin:OriginalSpindata:$Itemname[i+startpnt]=valuestart+i*delta
i+=1
while (i+startpnt<endpnt)

end

Proc Getinfowave(ctrlName,popNum,popStr) : PopupMenuControl
string popstr,ctrlname
variable popnum
root:infotabletool:infowavename=popstr
end


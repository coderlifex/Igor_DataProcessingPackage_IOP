#pragma rtGlobals=1		// Use modern global access method.

Proc InfoTableFillTool()
Newdatafolder/O/s root:infotabletool
Variable/G Fillstart,FillEnd,Valuetobefilled,Valuedelta,Infotablechecked
String/G infowavename,Infotablelist

Dowindow/F Infotabletool
if (V_flag==0)
InfoTableTool()
else
Dowindow/F infotabletool
Endif
Infotablecheck("Set2DInfotable",0)
end

Window InfoTableTool() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(557,143,806,363) as "InfoTableTool"
	ShowTools/A
	PopupMenu ItemTobefilled,pos={26,40},size={187,20},proc=Getinfowave,title="Item to be filled"
	PopupMenu ItemTobefilled,mode=2,popvalue="Phi_Angle",value= #"root:infotabletool:infotablelist"
	SetVariable FillStart,pos={27,74},size={133,16},title="Fillstart"
	SetVariable FillStart,value= root:infotabletool:Fillstart
	SetVariable FillEnd,pos={27,100},size={133,16},title="FillEnd"
	SetVariable FillEnd,value= root:infotabletool:Fillend
	SetVariable Valuetobefilled,pos={27,124},size={133,16},title="Valuetobefilled"
	SetVariable Valuetobefilled,value= root:infotabletool:Valuetobefilled
	Button StartFill,pos={27,181},size={95,24},proc=DoFill,title="StartFill"
	SetVariable ValueDelta,pos={27,148},size={133,16},title="ValueDelta"
	SetVariable ValueDelta,value= root:infotabletool:Valuedelta
	CheckBox Set2DInfotable,pos={27,17},size={102,14},proc=Infotablecheck,title="Set2DInfotable"
	CheckBox Set2DInfotable,variable= root:infotabletool:Infotablechecked
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
if(root:infotabletool:infotablechecked==0)      
   root:spin:OriginalSpindata:$Itemname[i+startpnt]=valuestart+i*delta
Else
   root:Originaldata:$Itemname[i+startpnt]=valuestart+i*delta
Endif
i+=1
while (i+startpnt<=endpnt)

end

Proc Getinfowave(ctrlName,popNum,popStr) : PopupMenuControl
string popstr,ctrlname
variable popnum
root:infotabletool:infowavename=popstr
end

Proc Infotablecheck(cba,checked) : CheckBoxControl
String cba
variable checked
if(root:infotabletool:infotablechecked==0)
Infotablelist="Theta_Angle1D;Phi_Angle1D;Omega_Angle1D;Temperature1D;BLI0_1D;Spinfile_ID;SpinCh_total;Spin_Channel;Process1DFlag"
else 
Infotablelist="Theta_Angle;Phi_Angle;Omega_Angle;Temperature;Ef_Correction;IntensityScale;ProcessFlag"
Endif

End

Function CheckProc_1(cba) : CheckBoxControl
	STRUCT WMCheckboxAction &cba

	switch( cba.eventCode )
		case 2: // mouse up
			Variable checked = cba.checked
			break
		case -1: // control being killed
			break
	endswitch

	return 0
End

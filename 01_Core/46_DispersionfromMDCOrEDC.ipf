#pragma rtGlobals=1		// Use modern global access method.

Proc MDCandEDC()
     string curr=getdatafolder(1)
  dowindow/F MDCandEDCPanel
  if(V_flag==0) 
   string Wavenames0=Wavelist("*",";","DIMS:2")
  newdatafolder/O/S root:MDCandEDC
  string/G Wavenames=Wavenames0
  variable/G EStart=NumVarOrDefault("root:MDCandEDC:EStart",0)
  variable/G EEnd=NumVarOrDefault("root:MDCandEDC:EEnd",0)
  variable/G KStart=NumVarOrDefault("root:MDCandEDC:KStart",0)
  variable/G KEnd=NumVarOrDefault("root:MDCandEDC:KEnd",0)
  String/G SelWave=StrVarOrDefault("root:MDCandEDC:SelWave","wave")
  variable/G MDCBKGD=NumVarOrDefault("root:MDCandEDC:MDCBKGD",0)
   variable/G MDCHeight=NumVarOrDefault("root:MDCandEDC:MDCHeight",0)
   variable/G MDCFWHM=NumVarOrDefault("root:MDCandEDC:MDCFWHM",0)
 variable/G MDCStart=NumVarOrDefault("root:MDCandEDC:MDCStart",0)
  variable/G MDCEnd=NumVarOrDefault("root:MDCandEDC:MDCEnd",0)
  variable/G MDCPosition=NumVarOrDefault("root:MDCandEDC:MDCPosition",0)
  variable/G EDCBKGD=NumVarOrDefault("root:MDCandEDC:EDCBKGD",0)
  variable/G EDCHeight=NumVarOrDefault("root:MDCandEDC:EDCHeight",0)
  variable/G EDCHeight2=NumVarOrDefault("root:MDCandEDC:EDCHeight2",0)
  variable/G EDCFWHM=NumVarOrDefault("root:MDCandEDC:EDCFWHM",0)
  variable/G EDCFWHM2=NumVarOrDefault("root:MDCandEDC:EDCFWHM2",0)
  variable/G EDCPosition=NumVarOrDefault("root:MDCandEDC:EDCPosition",0)
  variable/G EDCPosition2=NumVarOrDefault("root:MDCandEDC:EDCPosition2",0)
  variable/G Temperature=NumVarOrDefault("root:MDCandEDC:Temperature",0)
  variable/G EDCBKGDSlope=NumVarOrDefault("root:MDCandEDC:EDCBKGDSlope",0)
  variable/G EDCStart=NumVarOrDefault("root:MDCandEDC:EDCStart",0)
   variable/G EDCEnd=NumVarOrDefault("root:MDCandEDC:EDCEnd",0)
   variable/G EDCPeaksNum=NumVarOrDefault("root:MDCandEDC:EDCPeaksNum",0)
  setdatafolder curr
  MDCandEDCPanel()
  endif
End  
     

Proc SelectImage(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string curr=getdatafolder(1)
	duplicate/O $popStr,root:MDCandEDC:$PopStr
	setdatafolder root:MDCandEDC
	Selwave=PopStr
	Display;AppendImage $Selwave
	ModifyImage $Selwave ctab= {*,*,PlanetEarth,1}
	ModifyGraph width=170.079,height={Aspect,1.5}
	setdatafolder curr
	

End
Window MDCandEDCPanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(205,223,800,626)
	ShowTools
	PopupMenu SelectImage,pos={10,19},size={296,20},bodyWidth=219,proc=SelectImage,title="Select Image"
	PopupMenu SelectImage,mode=1,popvalue="EKZF5t15O45PP30T1P",value= #"root:MDCandEDC:wavenames"
	Button MDC,pos={65,266},size={62,22},proc=MDCFitButton,title="MDCFit"
	Button EDC,pos={317,278},size={61,23},proc=EDCButton,title="EDCFit"
	Button ShowMDC,pos={69,134},size={62,20},proc=ShowMDCButton,title="Show MDC"
	Button ShowEDC,pos={343,127},size={61,21},proc=ShowEDCButton,title="Show EDC"
	Button ClearMDC,pos={66,299},size={61,22},proc=ClearMDCButton,title="ClearMDC"
	Button ClearEDC,pos={373,300},size={61,22},proc=ClearEDCButton,title="ClearEDC"
	SetVariable Height,pos={105,161},size={77,16},title="Height"
	SetVariable Height,value= root:MDCandEDC:MDCHeight
	SetVariable setvar1,pos={12,196},size={77,16},title="FWHM"
	SetVariable setvar1,value= root:MDCandEDC:MDCFWHM
	SetVariable setvar2,pos={106,195},size={77,16},title="Position"
	SetVariable setvar2,value= root:MDCandEDC:MDCPosition
	SetVariable setvar3,pos={35,67},size={99,16},title="EStart"
	SetVariable setvar3,value= root:MDCandEDC:EStart
	SetVariable setvar4,pos={106,227},size={77,16},title="End"
	SetVariable setvar4,value= root:MDCandEDC:MDCEnd
	SetVariable setvar5,pos={14,227},size={77,16},title="Start"
	SetVariable setvar5,value= root:MDCandEDC:MDCStart
	Button SeekPeak,pos={245,279},size={63,22},proc=SeekPeakButton,title="Seek Peak"
	SetVariable setvar6,pos={245,256},size={77,16},title="Start"
	SetVariable setvar6,value= root:MDCandEDC:EDCStart
	SetVariable setvar7,pos={332,256},size={77,16},title="End"
	SetVariable setvar7,value= root:MDCandEDC:EDCEnd
	SetVariable setvar8,pos={242,163},size={77,16},title="BKGD"
	SetVariable setvar8,value= root:MDCandEDC:EDCBKGD
	SetVariable Height1,pos={336,162},size={104,16},title="Height"
	SetVariable Height1,value= root:MDCandEDC:EDCHeight
	SetVariable setvar9,pos={336,193},size={105,16},title="FWHM"
	SetVariable setvar9,value= root:MDCandEDC:EDCFWHM
	SetVariable setvar0,pos={337,222},size={105,16},title="Position"
	SetVariable setvar0,value= root:MDCandEDC:EDCPosition
	SetVariable setvar04,pos={245,192},size={74,16},title="T"
	SetVariable setvar04,value= root:MDCandEDC:Temperature
	SetVariable setvar05,pos={246,218},size={73,16},title="Slope"
	SetVariable setvar05,value= root:MDCandEDC:EDCBKGDSlope
	SetVariable setvar06,pos={158,67},size={88,16},title="EEnd"
	SetVariable setvar06,value= root:MDCandEDC:EEnd
	SetVariable setvar07,pos={35,91},size={99,16},title="KStart"
	SetVariable setvar07,value= root:MDCandEDC:KStart
	SetVariable setvar08,pos={158,92},size={89,16},title="KEnd"
	SetVariable setvar08,value= root:MDCandEDC:KEnd
	SetVariable setvar09,pos={12,162},size={77,16},title="BKGD"
	SetVariable setvar09,value= root:MDCandEDC:MDCBKGD
	Button ShowMDC1,pos={274,74},size={90,21},proc=ShowImage,title="Show Image"
	SetVariable Height2,pos={449,161},size={110,16},title="Height2"
	SetVariable Height2,value= root:MDCandEDC:EDCHeight2
	SetVariable setvar10,pos={449,191},size={112,16},title="FWHM2"
	SetVariable setvar10,value= root:MDCandEDC:EDCFWHM2
	SetVariable setvar01,pos={451,222},size={112,16},title="Position2"
	SetVariable setvar01,value= root:MDCandEDC:EDCPosition2
	PopupMenu popup0,pos={416,255},size={96,20},proc=PopMenuProc,title="PeaksNum"
	PopupMenu popup0,mode=2,popvalue="2",value= #"\"1;2;3\""
	Button button0,pos={317,19},size={50,20},proc=ZLfresh,title="Refresh"
EndMacro

Proc MDCFitButton(ctrlName) : ButtonControl
	String ctrlName
	silent 1;pauseupdate
	string curr=getdatafolder(1)
	setdatafolder root:MDCandEDC
	 string wavenames=wavelist("Fit_MDC*",";","")
        string wavenames0
        variable nn=itemsinlist(wavenames,";")
        variable ii=0
        do
        wavenames0=stringfromlist(ii,wavenames,";")
        killwaves/Z  $wavenames0
        ii+=1
        while(ii<nn)
	make/o/n=5 Fitcoef
	Fitcoef[0]=MDCBKGD
	Fitcoef[1]=MDCHeight
	Fitcoef[2]=MDCFWHM
	Fitcoef[3]=MDCPosition
	Fitcoef[4]=0
	nn=MDCEnd-MDCStart+1
	Make/o/n=(nn) MDCBKGDW
	Make/o/n=(nn) MDCHeightW
	Make/o/n=(nn) MDCFWHMW
	Make/o/n=(nn) MDCPositionW
         ii=MDCStart
	string MDCwaveName
	do
	MDCwaveName="MDCIntensity"+num2str(ii)
	FuncFit  LorentzianFit_OnePeak Fitcoef $MDCwaveName/D/X=Axisx
	MDCBKGDW[ii]=Fitcoef[0]
	MDCHeightW[ii]=Fitcoef[1]
	MDCFWHMW[ii]=Fitcoef[2]
	MDCPositionW[ii]=Fitcoef[3]
	ii+=1
	while(ii<=MDCEnd)
	duplicate/o Axisy,DispersionE
	DeletePoints (MDCEnd+1),(ny-MDCEnd-1), DispersionE
	DeletePoints 0,(MDCStart), DispersionE
	display;appendimage $Seledwave
	ModifyImage $Seledwave ctab= {*,*,PlanetEarth,1}
	ModifyGraph width=170.079,height={Aspect,1.5}
	appendtograph DispersionE vs MDCPositionW
	setdatafolder curr
	
End

Proc EDCButton(ctrlName) : ButtonControl
	String ctrlName
	silent 1;pauseupdate
	string curr=getdatafolder(1)
	setdatafolder root:MDCandEDC
	string wavenames=wavelist("Fit_EDC*",";","")
        string wavenames0
        variable nn=itemsinlist(wavenames,";")
        variable ii=0
        do
        wavenames0=stringfromlist(ii,wavenames,";")
        killwaves/Z  $wavenames0
        ii+=1
        while(ii<nn)
	if(EDCPeaksNum==1)
	make/o/n=6 FitcoefEDC
	endif
	if(EDCPeaksNum==3)
	make/o/n=6 FitcoefEDC
	endif
	if(EDCPeaksNum==2)
	make/o/n=9 FitCoefEDC
	FitcoefEDC[6]=EDCHeight2
	FitcoefEDC[7]=EDCFWHM2
	FitcoefEDC[8]=EDCPosition2
	endif
	FitcoefEDC[0]=EDCBKGD
	FitcoefEDC[1]=EDCHeight
	FitcoefEDC[2]=EDCFWHM
	FitcoefEDC[3]=EDCPosition
	FitcoefEDC[4]=Temperature
	FitcoefEDC[5]=EDCBKGDSlope
	nn=EDCEnd-EDCStart+1
	Make/o/n=(nn) EDCBKGDW
	Make/o/n=(nn) EDCHeightW
	Make/o/n=(nn) EDCFWHMW
	Make/o/n=(nn) EDCFitE
	if(EDCPeaksNum==2)
	Make/o/n=(nn) EDCHeightW2
	Make/o/n=(nn) EDCFWHMW2
	Make/o/n=(nn) EDCFitE2
	endif
         ii=EDCStart
	string EDCwaveName
	variable EDCmaxp0,EDCFWHMNum,EDCmaxp2
	
	do
	EDCwaveName="EDCIntensity"+num2str(ii)
	if(EDCPeaksNum==1)
	FuncFit/H="000010" LorEDCFit FitCoefEDC $EDCwaveName/D/X=Axisy
	
	endif
	if(EDCPeaksNum==2)
	FuncFit/H="000010000" LorEDCFitTwoPeaks, FitCoefEDC $EDCWaveName/D/X=Axisy
	endif
	if(EDCPeaksNum==3)
	wavestats $EDCWaveName
	EDCmaxp0=V_maxloc
	//print EDCMaxp0
	
	 
	EDCFWHMNum=round(FitcoefEDC[2]/(Axisy[9]-Axisy[0])*9)
	print EDCFWHMNum
	duplicate/o/R=(V_maxloc-EDCFWHMNum,V_maxloc+EDCFWHMNum) $EDCWaveName,TempEDC
	duplicate/o/R=(V_maxloc-EDCFWHMNum,V_maxloc+EDCFWHMNum) Axisy,TempAxisy
	FuncFit/H="000010" LorEDCFit FitCoefEDC TempEDC/D/X=TempAxisy
	endif
	//FuncFit  LorentzianFit_OnePeak Fitcoef $MDCwaveName/D/X=Axisx
	EDCBKGDW[ii-EDCStart]=FitcoefEDC[0]
	EDCHeightW[ii-EDCStart]=FitcoefEDC[1]
	EDCFWHMW[ii-EDCStart]=FitcoefEDC[2]
	EDCFitE[ii-EDCStart]=FitcoefEDC[3]
	if(EDCPeaksNum==2)
	EDCHeightW2[ii-EDCStart]=FitcoefEDC[6]
	EDCFWHMW2[ii-EDCStart]=FitcoefEDC[7]
	EDCFitE2[ii-EDCStart]=FitcoefEDC[8]
	endif
	ii+=1
	while(ii<=EDCEnd)
	duplicate/o Axisx,EDCFitK
	DeletePoints (EDCEnd+1),(nx-EDCEnd), EDCFitK
	DeletePoints 0,(EDCStart), EDCFitK
	setdatafolder curr
	

End

Proc  ShowMDCButton(ctrlName) : ButtonControl
	String ctrlName
	silent 1; pauseupdate
	string curr=getdatafolder(1)
	setdatafolder root:MDCandEDC
	variable/G nx=dimsize($seledwave,0)
	variable/G ny=dimsize($seledwave,1)
	variable ymin=dimoffset($seledwave,1)
	variable xmin=Dimoffset($seledwave,0)
	variable ydelta=dimdelta($seledwave,1)
	variable xdelta=dimdelta($seledwave,0)
	make/o/n=(nx) Axisx
	Axisx=xmin+xdelta*x
	make/o/n=(ny) Axisy
	Axisy=ymin+ydelta*x
	string MDCname
	display as "MDCFit"
	variable ii=0
	do
	MDCname="MDCIntensity"+num2str(ii)
	make/o/n=(nx) $MDCName
	$MDCName=$seledwave[p][ii]
	appendtograph $MDCName vs Axisx
	ii+=1
	while(ii<ny)
	setdatafolder curr
	ModifyGraph lsize(MDCIntensity0)=2,rgb(MDCIntensity0)=(0,0,52224)

End

Proc ShowEDCButton(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	silent 1;pauseupdate
	setdatafolder root:MDCandEDC
	variable/G nx=dimsize($seledwave,0)
	variable/G ny=dimsize($seledwave,1)
	variable ymin=dimoffset($seledwave,1)
	variable xmin=Dimoffset($seledwave,0)
	variable ydelta=dimdelta($seledwave,1)
	variable xdelta=dimdelta($seledwave,0)
	make/o/n=(nx) Axisx
	Axisx=xmin+xdelta*x
	make/o/n=(ny) Axisy
	Axisy=ymin+ydelta*x
	string EDCname
	
	variable ii=0
	do
	EDCname="EDCIntensity"+num2str(ii)
	make/o/n=(ny) $EDCName
	$EDCName=$seledwave[ii][p]
	$EDCName+=0//20*ii
	ii+=1
	while(ii<nx)
	ii=EDCStart
	if(EDCEnd==0)
	ii=0
	EDCEnd=nx-1
	endif
	display as "EDCFit"
	do
	EDCname="EDCIntensity"+num2str(ii)
	appendtograph $EDCName vs Axisy
	ii+=1
	while(ii<=EDCEnd)
	ModifyGraph zero(bottom)=4
	setdatafolder curr

End

Proc ClearMDCButton(ctrlName) : ButtonControl
	String ctrlName
        String wavenames
        string curr=getdatafolder(1)
        setdatafolder root:MDCandEDC
        wavenames=wavelist("*MDCIntensity*",";","")
        string wavenames0
        variable nn=itemsinlist(wavenames,";")
        variable ii=0
        do
        wavenames0=stringfromlist(ii,wavenames,";")
        killwaves/Z  $wavenames0
        ii+=1
        while(ii<nn)
        setdatafolder curr
End

Proc ClearEDCButton(ctrlName) : ButtonControl
	String ctrlName
        String wavenames
        string curr=getdatafolder(1)
        setdatafolder root:MDCandEDC
        wavenames=wavelist("*EDCIntensity*",";","")
        string wavenames0
        variable nn=itemsinlist(wavenames,";")
        variable ii=0
        do
        wavenames0=stringfromlist(ii,wavenames,";")
        killwaves/Z  $wavenames0
        ii+=1
        while(ii<nn)
        setdatafolder curr
End

Proc SeekPeakButton(ctrlName) : ButtonControl
	String ctrlName
	silent 1;pauseupdate
	String curr=getdatafolder(1)
	setdatafolder root:MDCandEDC
	Duplicate/o Axisx,EDCSeekPK
	DeletePoints (EDCEnd+1),(nx-EDCEnd),EDCSeekPK
	DeletePoints 0,(EDCStart),EDCSeekPK
        Make/o/n=(EDCEnd-EDCStart+1) EDCSeekPE
	variable ii=EDCStart
	string EDCwaveName
	do
             EDCwaveName="EDCIntensity"+num2str(ii)
             wavestats/Q $EDCwaveName
           EDCSeekPE[ii-EDCStart]=Axisy[V_maxloc]
	  ii+=1
	while(ii<=EDCEnd)
	setdatafolder curr
	

End

Function LorentzianFit_OnePeak(w,x)

	//w[0]   constant background;
	//w[1]   Height of the Lorentzian peak; 
	//w[2]   Full Width at Half maximum;
	//w[3]   Lorentzian Peak position;
	//w[4]   Background slope
	wave w; Variable x

	return w[0] +w[4]*x+ w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2))
END
Function LorEDCFit(coefWave,x)
   Wave coefWave
   Variable x
   // Lor X Fermi Cutoff
   Return (coefWave[0]+coefWave[5]*x+coefWave[1]*coefWave[2]^2/(4*(x-coefWave[3])^2+coefWave[2]^2))/(exp(11594.2*(x)/coefWave[4])+1) 
End
Function LorEDCFitTwoPeaks(coefWave,x)
   Wave coefWave
   Variable x
   // Lor X Fermi Cutoff
   Return (coefWave[0]+coefWave[5]*x+coefWave[1]*coefWave[2]^2/(4*(x-coefWave[3])^2+coefWave[2]^2)+CoefWave[6]*coefWave[7]^2/(4*(x-coefwave[8])^2+coefwave[7]^2))/(exp(11594.2*(x)/coefWave[4])+1) 
End

Proc ShowImage(ctrlName) : ButtonControl
	String ctrlName
	
	string curr=getdatafolder(1)
	setdatafolder root:MDCandEDC
	string/G Seledwave="N"+selwave
	duplicate/o/R=(KStart,KEnd) (EStart,EEnd) $selwave,$Seledwave
	display;appendimage $Seledwave
	ModifyImage $Seledwave ctab= {*,*,PlanetEarth,1}
	ModifyGraph width=170.079,height={Aspect,1.5}
	ModifyGraph width=0
	setdatafolder curr

End

Function PopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	NVAR EDCPeaksNum
	EDCPeaksNum=popNum

End





proc ZLfresh(ctrlName) : ButtonControl
	String ctrlName
string wavenames0=wavelist("*",";","DIMS:2")
	setdatafolder root:MDCandEDC
	wavenames=wavenames0
End

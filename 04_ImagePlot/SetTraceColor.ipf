#pragma rtGlobals=1		// Use modern global access method.

menu "ARPES"
	  "Trace Color Toll", SetTraceColor()
end

proc SetTraceColor()
dowindow/f setTraceColor
if(V_flag!=1)
make/o/n=3 STRGBwave_i,STRGBwave_f
string/g SC_traceliststr
string/g SC_modelist="RGBlinear;"+"RGBquadratic;"+"HLSlinear;"+"HLSquadratic"
string/g SC_modstr="RGBlinear"
variable/g SC_Hcontr=0.5
variable/g SC_Lcontr=0.5
variable/g SC_Scontr=0.5
make/o/T/n=0 SC_tracelistwave
make/o/T/n=0 SC_colorwave, SC_colorwaveS
make/o/n=0 SC_traceselwave
setTraceColorpanel()
endif
end


Window setTraceColorpanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel/K=1 /W=(907,425,1385,767) as "setTraceColorW"
	SetDrawLayer UserBack
	SetDrawEnv linethick= 2
	DrawLine 262,126,460,126
	SetDrawEnv fillfgc= (61696,64000,57856),fillbgc= (32768,54528,65280)
	DrawRect 254,71,471,202
	DrawLine 261,128,463,128
	SetDrawEnv fillfgc= (61696,64000,57856),fillbgc= (32768,54528,65280)
	DrawRect 254,227,471,320
	PopupMenu popup0,pos={263,98},size={200,21},proc=SC_fromColorTable
	PopupMenu popup0,mode=14,popvalue="",value= #"\"*COLORTABLEPOPNONAMES*\""
	PopupMenu popup1,pos={261,169},size={78,21},proc=SC_manualStart,title="Start"
	PopupMenu popup1,mode=1,popColor= (15360,37120,22784),value= #"\"*COLORPOP*\""
	PopupMenu popup2,pos={385,169},size={75,21},proc=SC_manualEnd,title="End"
	PopupMenu popup2,mode=1,popColor= (18176,14080,38144),value= #"\"*COLORPOP*\""
	ListBox tracellistbox,pos={11,39},size={232,297},listWave=root:SC_tracelistwave
	ListBox tracellistbox,selWave=root:SC_traceselwave,mode= 9
	Button moveup,pos={184,0},size={25,37},proc=SC_traceup,title=""
	Button moveup,picture= ProcGlobal#UpButton
	Button moveup1,pos={216,0},size={25,37},proc=SC_tracedown,title=""
	Button moveup1,picture= ProcGlobal#DownButton
	Button button0,pos={15,4},size={84,26},proc=SC_updateList,title="Get Traces"
	Button button0,fSize=14,fStyle=1
	TitleBox title0,pos={262,77},size={64,15},title="Color Table",frame=0
	TitleBox title1,pos={266,140},size={40,15},title="Manual",frame=0
	TitleBox title2,pos={254,51},size={60,15},title="Alll Traces",frame=0,fStyle=1
	TitleBox title3,pos={252,20},size={93,15},title="Selected Traces",frame=0
	TitleBox title3,fStyle=1
	PopupMenu popup3,pos={358,17},size={50,21},proc=SC_seltrace
	PopupMenu popup3,mode=1,popColor= (0,65280,65280),value= #"\"*COLORPOP*\""
	PopupMenu popup4,pos={334,137},size={127,21},proc=SC_colormode,title="Mode"
	PopupMenu popup4,mode=4,popvalue="HLSquadratic",value= #"SC_modelist"
	CheckBox check0,pos={435,20},size={31,15},proc=SC_selAlltraces,title="All"
	CheckBox check0,value= 1
	Slider Hue,pos={297,236},size={170,19},proc=SC_changeHLS,fSize=10
	Slider Hue,limits={0,1,0.005},variable= SC_Hcontr,vert= 0,ticks= 0
	Slider Lum,pos={298,264},size={170,19},proc=SC_changeHLS,fSize=10
	Slider Lum,limits={0,1,0.005},variable= SC_Lcontr,vert= 0,ticks= 0
	Slider Sat,pos={298,294},size={170,19},proc=SC_changeHLS,fSize=10
	Slider Sat,limits={0,1,0.005},variable= SC_Scontr,vert= 0,ticks= 0
	TitleBox title4,pos={261,237},size={25,15},title="Hue:",frame=0,fStyle=1
	TitleBox title5,pos={260,264},size={28,15},title="Lum:",frame=0,fStyle=1
	TitleBox title6,pos={260,294},size={22,15},title="Sat:",frame=0,fStyle=1
EndMacro

function SC_updateList(ctrlName) : ButtonControl
	String ctrlName
	wave/T listwave=SC_tracelistwave
	wave/T colorwave=SC_colorwave
	wave/T colorwaveS=SC_colorwaveS
	wave selwave=SC_traceselwave
	string tracelist=TraceNameList("",";",1)
	variable jj,jjmax
	jjmax=ItemsInList(tracelist)
	redimension/n=(jjmax) listwave
	redimension/n=(jjmax)  selwave
	redimension/n=(jjmax)  colorwave
	redimension/n=(jjmax)  colorwaveS
	selwave=0
	jj=0	
	if(jjmax>0)
	string temptrace, tempcolorstr
	do
		temptrace=StringFromList(jj,  tracelist)
		tempcolorstr=StringFromList(30, TraceInfo("",temptrace,0))
		colorwave[jj]=tempcolorstr[7,strlen(tempcolorstr)-1]
		listwave[jj]=temptrace
		jj+=1
	while(jj<jjmax)	
	endif
	colorwaveS=colorwave
	nvar SC_Hcontr, SC_Lcontr, SC_Scontr	
 	SC_Hcontr=0.5
 	SC_Lcontr=0.5
 	SC_Scontr=0.5
 end

Function SC_traceup(ctrlName) : ButtonControl
	String ctrlName
  
  controlinfo/W=MDCWidthShow MDCWidthlistbox
  wave/T tmp=SC_tracelistwave
  wave selwave=SC_traceselwave
 
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

Function SC_tracedown(ctrlName) : ButtonControl
	String ctrlName
  
  controlinfo/W=MDCWidthShow MDCWidthlistbox
  wave/T tmp=SC_tracelistwave
  wave selwave=SC_traceselwave
 
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

Function SC_seltrace(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string colorstr
	wave/T  SC_colorwave
	wave/T  SC_colorwaveS
	wave/T listwave=SC_tracelistwave
	wave selwave=SC_traceselwave
	variable jj,jjmax
	jjmax=dimsize(listwave,0)
	jj=0	
	if(jjmax>0)
	string temptrace
	do
		if(selwave[jj])
		SC_colorwave[jj]=popStr
		endif
		jj+=1
	while(jj<jjmax)	
	endif	
	SC_colorwaveS=SC_colorwave
	SC_changecolor()
	nvar SC_Hcontr, SC_Lcontr, SC_Scontr	
 	SC_Hcontr=0.5
 	SC_Lcontr=0.5
 	SC_Scontr=0.5
End

Function SC_manualStart(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
//	string colorstr
	wave/T  SC_colorwave
	SC_colorwave[0]=popStr
	SC_calcolor()
	SC_changecolor()
	nvar SC_Hcontr, SC_Lcontr, SC_Scontr	
 	SC_Hcontr=0.5
 	SC_Lcontr=0.5
 	SC_Scontr=0.5
End

Function  SC_manualEnd(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	wave/T  SC_colorwave
	SC_colorwave[dimsize(SC_colorwave,0)-1]=popStr
	SC_calcolor()
	SC_changecolor()
	nvar SC_Hcontr, SC_Lcontr, SC_Scontr	
 	SC_Hcontr=0.5
 	SC_Lcontr=0.5
 	SC_Scontr=0.5
End

Function SC_colormode(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	svar mode=SC_modstr
	mode=popStr
	SC_calcolor()
	SC_changecolor()
	nvar SC_Hcontr, SC_Lcontr, SC_Scontr	
 	SC_Hcontr=0.5
 	SC_Lcontr=0.5
 	SC_Scontr=0.5
End

Function SC_calcolor()
	wave STRGBwave_i
	wave STRGBwave_f
	wave/T listwave=SC_tracelistwave
	wave/T  SC_colorwave
	wave/T  SC_colorwaveS
	svar mode=SC_modstr
	duplicate/o STRGBwave_i STHLSwave_i
	duplicate/o STRGBwave_f STHLSwave_f
	duplicate/o STRGBwave_f tempRGBwave,tempHLSwave
	string colorstr
	 colorstr=SC_colorwave[0]
	colorstr=colorstr[1,strlen(colorstr)-2]
	STRGBwave_i[0]=str2num(StringFromList(0, colorstr, ","))
	STRGBwave_i[1]=str2num(StringFromList(1, colorstr, ","))
	STRGBwave_i[2]=str2num(StringFromList(2, colorstr, ","))
	colorstr=SC_colorwave[dimsize(SC_colorwave,0)-1]
	colorstr=colorstr[1,strlen(colorstr)-2]
	STRGBwave_f[0]=str2num(StringFromList(0, colorstr, ","))
	STRGBwave_f[1]=str2num(StringFromList(1, colorstr, ","))
	STRGBwave_f[2]=str2num(StringFromList(2, colorstr, ","))
	
	STHLSwave_i=RGB2HLS(STRGBwave_i) 
	STHLSwave_f=RGB2HLS(STRGBwave_f)
	
	variable jj,jjmax,r,g,b
	jjmax=dimsize(listwave,0)
	jj=0	
	if(jjmax>0)
	string temptrace
	do
		temptrace=listwave[jj]
		if(stringmatch(mode,"RGBlinear"))
		tempRGBwave=STRGBwave_i+(STRGBwave_f-STRGBwave_i)*jj/jjmax
		endif
		if(stringmatch(mode,"HLSlinear"))
		tempHLSwave=STHLSwave_i+(STHLSwave_f-STHLSwave_i)*jj/jjmax
		tempRGBwave=HLS2RGB(tempHLSwave) 
		endif
		if(stringmatch(mode,"RGBquadratic"))
		tempRGBwave=STRGBwave_i+(STRGBwave_f-STRGBwave_i)*jj*jj/jjmax/jjmax
		endif
		if(stringmatch(mode,"HLSquadratic"))
		tempHLSwave=STHLSwave_i+(STHLSwave_f-STHLSwave_i)*jj*jj/jjmax/jjmax
		tempRGBwave=HLS2RGB(tempHLSwave) 
		endif
		r=tempRGBwave[0]
		g=tempRGBwave[1]
		b=tempRGBwave[2]
		SC_colorwave[jj]="("+num2str(r)+","+num2str(g)+","+num2str(b)+")"
//		modifygraph rgb($temptrace)=(r,g,b)
		jj+=1
	while(jj<jjmax)	
	endif
	SC_colorwaveS=SC_colorwave
End

Function SC_changecolor()
	wave/T listwave=SC_tracelistwave
	wave/T  SC_colorwaveS
	
	variable jj,jjmax,r,g,b
	string colorstr,temptrace
	jjmax=dimsize(listwave,0)
	jj=0	
	if(jjmax>0)
	do
		temptrace=listwave[jj]
		colorstr=SC_colorwaveS[jj]
		colorstr=colorstr[1,strlen(colorstr)-2]
		r=str2num(StringFromList(0, colorstr, ","))
		g=str2num(StringFromList(1, colorstr, ","))
		b=str2num(StringFromList(2, colorstr, ","))
		modifygraph rgb($temptrace)=(r,g,b)
		jj+=1
	while(jj<jjmax)	
	endif
end



Function SC_fromColorTable(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr			
	wave/T listwave=SC_tracelistwave
	wave/T colorwave=SC_colorwave
	wave/T colorwaveS=SC_colorwaveS
	
	ColorTab2Wave $popStr
	wave M_colors
	variable cpnt=dimsize(M_colors,0)
	variable jj,jjmax
	jjmax=dimsize(listwave,0)
	jj=0	
	if(jjmax>0)
	do
		 colorwave[jj]="("+num2str(M_colors[jj*cpnt/jjmax][0])+","+num2str(M_colors[jj*cpnt/jjmax][1])+","+num2str(M_colors[jj*cpnt/jjmax][2])+")"
		jj+=1
	while(jj<jjmax)	
	endif
	 colorwaveS= colorwave
	SC_changecolor()
	nvar SC_Hcontr, SC_Lcontr, SC_Scontr	
 	SC_Hcontr=0.5
 	SC_Lcontr=0.5
 	SC_Scontr=0.5
End


function RGB2HLS(RGB) 
	wave RGB
	duplicate/o RGB HLSwave
	variable r,g,b,h,l,s 
	r=RGB[0]/255/256
	g=RGB[1]/255/256
	b=RGB[2]/255/256
//	print RGB
 	variable  m=max(max(r,g),b)
  	variable n=min(min(r,g),b)
	l=(m+n)/2
	if(m==n) 
   		s=0
		h=0
   	else 
    		if(l<=0.5)  
    		s=(m-n)/(m+n)
    		else  
    		s=(m-n)/(2-m-n)
    		endif
    	
    		if(r==m)
    			h=(g-b)/(m-n)
    		elseif(g==m)
    			h=2+(b-r)/(m-n)
    		elseif(b==m)
    			h=4+(r-g)/(m-n)
    		endif
    	
    		h=h*60
    	
    		if(h<0)
    			h=h+360
    		endif   
    	endif
    	HLSwave[0]=h
    	HLSwave[1]=l
    	HLSwave[2]=s
    	return HLSwave
end


function HLS2RGB(HLS) 
	wave HLS
	duplicate/o HLS RGBwave
	variable r,g,b,h,l,s 
	h=HLS[0]
	l=HLS[1]
	s=HLS[2]
 	variable cmax,cmin;
   	 if(l <= 0.5)
        	cmax = l*(1+s);
   	 else
        	cmax = l*(1-s)+s;
        endif
    	cmin = 2*l-cmax;
   	 if(s == 0)
        r =l*255;
         g= l*255;
         b = l*255;
    	else
        r = HLS2RGBvalue(cmin,cmax,h+120)*255;
        g = HLS2RGBvalue(cmin,cmax,h)*255;
        b = HLS2RGBvalue(cmin,cmax,h-120)*255;
     endif
     RGBwave[0]=r*256
    RGBwave[1]=g*256
     RGBwave[2]=b*256
     return RGBwave
end

function HLS2RGBvalue(n1,n2,hue)
	variable n1,n2,hue
    	if(hue > 360)
        	hue -= 360;
    	endif
    	if(hue < 0)
        hue += 360;
        endif 
               
   	 if(hue < 60)
        return n1+(n2-n1)*hue/60;
    	 elseif(hue < 180)
        return n2;
    	 elseif(hue < 240)
        return n1+(n2-n1)*(240-hue)/60;
    	else
        return n1;
        endif
end

Function SC_selAlltraces(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	wave selwave=SC_traceselwave
	selwave=checked
End

Function SC_changeHLS(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	wave STRGBwave_i
	wave/T  SC_colorwave
	wave/T  SC_colorwaveS
	duplicate/o STRGBwave_f tempRGBwave,tempHLSwave
	string colorstr,temptrace
	variable jj,jjmax
	nvar SC_Hcontr,SC_Lcontr,SC_Scontr
	jjmax=dimsize(SC_colorwave,0)
	jj=0	
	if(jjmax>0)
	do
		colorstr=SC_colorwave[jj]
		colorstr=colorstr[1,strlen(colorstr)-2]
		tempRGBwave[0]=str2num(StringFromList(0, colorstr, ","))
		tempRGBwave[1]=str2num(StringFromList(1, colorstr, ","))
		tempRGBwave[2]=str2num(StringFromList(2, colorstr, ","))
		tempHLSwave=RGB2HLS(tempRGBwave)
		tempHLSwave[0]=tempHLSwave[0]+(SC_Hcontr-0.5)*360
			if(tempHLSwave[0]>360)
			tempHLSwave[0]=tempHLSwave[0]-360
			endif
			if(tempHLSwave[0]<0)
			tempHLSwave[0]=tempHLSwave[0]+360
			endif
			
	//	tempHLSwave[1]=((0.5/tempHLSwave[1]-1)*2*SC_Lcontr+2-0.5/tempHLSwave[1])*tempHLSwave[1]*2*SC_Lcontr
	//	tempHLSwave[2]=((0.5/tempHLSwave[2]-1)*2*SC_Scontr+2-0.5/tempHLSwave[2])*tempHLSwave[2]*2*SC_Scontr
	//	tempHLSwave[1]=SC_Lcontr
	//	tempHLSwave[2]=SC_Scontr
		tempHLSwave[1]=tempHLSwave[1]+(SC_Lcontr-0.5)
		tempHLSwave[1]=tempHLSwave[1]<1?tempHLSwave[1]:1
		tempHLSwave[1]=tempHLSwave[1]>0?tempHLSwave[1]:0
		tempHLSwave[2]=tempHLSwave[2]+(SC_Scontr-0.5)
		tempHLSwave[2]=tempHLSwave[2]<1?tempHLSwave[2]:1
		tempHLSwave[2]=tempHLSwave[2]>0?tempHLSwave[2]:0
		tempRGBwave=HLS2RGB(tempHLSwave)
		SC_colorwaveS[jj]="("+num2str(tempRGBwave[0])+","+num2str(tempRGBwave[1])+","+num2str(tempRGBwave[2])+")"
		jj+=1
	while(jj<jjmax)	
	endif
	SC_changecolor()
End


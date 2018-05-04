#pragma rtGlobals=1		// Use modern global access method.

menu "Tools"
	"LorentzFit",  MDXLorentzFitPanel()
end

proc MDXLorentzFitPanel()
	String Curr=GetDataFolder(1)
	newdatafolder/o root:LorentzFit
	setdatafolder root:LorentzFit
	variable/g BGInitial Height1Initial FWHM1Initial Position1Initial Height2Initial FWHM2Initial Position2Initial Height3Initial FWHM3Initial Position3Initial Height4Initial FWHM4Initial Position4Initial Height5Initial FWHM5Initial Position5Initial
	variable/g NofLorentz=1
	string/g ToFitXNameList
	string/g ToFitYNameList
	string/g ToFitXName
	string/g ToFitYName
	make/o/n=2 ToFitY, ToFitX
	setdatafolder Curr
	root:LorentzFit:ToFitXNameList=""
	root:LorentzFit:ToFitYNameList=wavelist("*",";","DIMS:1")
	
	dowindow/F Lorentz_Fit
	if (V_flag==0)
PauseUpdate; Silent 1		// building window...
	NewPanel/K=1 /W=(989,202,1825,458)
	SetVariable BackGroud,pos={37,83},size={121,16},title="BackGroud"
	SetVariable BackGroud,value= root:LorentzFit:BGInitial
	SetVariable Height1Initial,pos={34,137},size={121,16},title="Height"
	SetVariable Height1Initial,value= root:LorentzFit:Height1Initial
	SetVariable Height2Initial,pos={194,137},size={121,16},title="Height"
	SetVariable Height2Initial,value= root:LorentzFit:Height2Initial
	SetVariable Height3Initia1,pos={349,138},size={121,16},title="Height"
	SetVariable Height3Initia1,value= root:LorentzFit:Height3Initial
	SetVariable Height4Initia1,pos={507,141},size={121,16},title="Height"
	SetVariable Height4Initia1,value= root:LorentzFit:Height4Initial
	SetVariable Height5Initia1,pos={667,140},size={121,16},title="Height"
	SetVariable Height5Initia1,value= root:LorentzFit:Height5Initial
	SetVariable FWHM1Initial,pos={34,173},size={121,16},title="FWHM"
	SetVariable FWHM1Initial,value= root:LorentzFit:FWHM1Initial
	SetVariable FWHM2Initial,pos={196,173},size={117,16},title="FWHM"
	SetVariable FWHM2Initial,value= root:LorentzFit:FWHM2Initial
	SetVariable FWHM3Initial,pos={352,170},size={116,16},title="FWHM"
	SetVariable FWHM3Initial,value= root:LorentzFit:FWHM3Initial
	SetVariable FWHM4Initial,pos={506,173},size={120,16},title="FWHM"
	SetVariable FWHM4Initial,value= root:LorentzFit:FWHM4Initial
	SetVariable FWHM5Initial,pos={665,167},size={124,16},title="FWHM"
	SetVariable FWHM5Initial,value= root:LorentzFit:FWHM5Initial
	SetVariable Position1Initial,pos={34,200},size={122,16},title="Position"
	SetVariable Position1Initial,value= root:LorentzFit:Position1Initial
	SetVariable Position2Initial,pos={191,204},size={123,16},title="Position"
	SetVariable Position2Initial,value= root:LorentzFit:Position2Initial
	SetVariable Position3Initial,pos={352,203},size={119,16},title="Position"
	SetVariable Position3Initial,value= root:LorentzFit:Position3Initial
	SetVariable Position4Initial,pos={508,200},size={123,16},title="Position"
	SetVariable Position4Initial,value= root:LorentzFit:Position4Initial
	SetVariable Position5Initial,pos={664,197},size={124,16},title="Position"
	SetVariable Position5Initial,value= root:LorentzFit:Position5Initial
	GroupBox group0,pos={27,115},size={139,113},title="lorenz1"
	GroupBox group1,pos={176,115},size={150,112},title="lorenz2"
	GroupBox group2,pos={336,115},size={149,109},title="lorenz3"
	GroupBox group3,pos={495,115},size={150,107},title="lorenz4"
	GroupBox group4,pos={655,115},size={155,109},title="lorenz5"
	SetVariable setvar0,pos={34,50},size={98,16},title="NumofLorz"
	SetVariable setvar0,limits={1,5,1},value= root:LorentzFit:NofLorentz
	PopupMenu popup0,pos={220,78},size={120,20},proc=TobeFitX,title="X wave"
	PopupMenu popup0,mode=4,popvalue="MDCK47K",value= #"root:LorentzFit:ToFitXNameList"
	PopupMenu popup1,pos={219,47},size={120,20},proc=TobeFitY,title="Y wave"
	PopupMenu popup1,mode=3,popvalue="MDCI47K",value= #"root:LorentzFit:ToFitYNameList"
	Button button0,pos={543,78},size={50,20},proc=MDXLorentzFit,title="Fit"
	dowindow/C Lorentz_Fit
	endif

setdatafolder Curr
end

PROC TobeFitY(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
	setdatafolder root:LorentzFit
	duplicate/o $(Curr+popStr) ToFitY
//	ToFitYName=popStr
	setdatafolder Curr
	variable nopnts=dimsize($popStr,0)+10
//	print nopnts
	root:LorentzFit:ToFitXNameList=wavelist("*",";","DIMS:1")+"Non"
End

PROC TobeFitX(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
	setdatafolder root:LorentzFit
//	ToFitXName=popStr
//	
	
	if(stringmatch(popStr,"Non"))
		duplicate/o ToFitY ToFitX
		LorentzFitx=p
	else
		duplicate/o $(Curr+popStr) ToFitX
	endif
	dowindow/f LorentzFitW
	if(v_flag!=1)
	display ToFitY vs ToFitX
	dowindow/c LorentzFitW
	ModifyGraph lsize(ToFitY)=3,rgb(ToFitY)=(0,0,0)
	ModifyGraph tick=2,mirror=2,standoff=0
	endif
	setdatafolder Curr
End



proc MDXLorentzFit(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

//	duplicate/o $root:LorentzFit:ToFitYName  root:LorentzFit:ToFitY
//	if(stringmatch(root:LorentzFit:ToFitXName,"Non"))
//	else
//		duplicate/o $root:LorentzFit:ToFitXName  root:LorentzFit:ToFitX
//	endif
	
	setdatafolder root:LorentzFit

	if(pcsr(A)&&pcsr(B))
	duplicate/o/R=[pcsr(A), pcsr(B)]  ToFitY FitlineY
	duplicate/o/R=[pcsr(A), pcsr(B)]  ToFitX FitlineX
	else
	duplicate/o  ToFitY FitlineY
	duplicate/o  ToFitX FitlineX
	endif
	duplicate/o  FitlineY Fittedline
	Fittedline=0
	dowindow/f LorentzFitW
	if(v_flag==1)
	
	if(NofLorentz==5)

		make/o/n=16 Fitresult

		Fitresult[0]=BGInitial
		Fitresult[1]=Height1Initial
		Fitresult[2]=FWHM1Initial
		Fitresult[3]=Position1Initial
		Fitresult[4]=Height2Initial
		Fitresult[5]=FWHM2Initial
		Fitresult[6]=Position2Initial
		Fitresult[7]=Height3Initial
		Fitresult[8]=FWHM3Initial
		Fitresult[9]=Position3Initial
		Fitresult[10]=Height4Initial
		Fitresult[11]=FWHM4Initial
		Fitresult[12]=Position4Initial
		Fitresult[13]=Height5Initial
		Fitresult[14]=FWHM5Initial
		Fitresult[15]=Position5Initial		
		
			funcfit MDXLorentzianFit5Peak Fitresult FitlineY  /X=FitlineX /D=Fittedline
		
		BGInitial=Fitresult[0]
		Height1Initial=Fitresult[1]
		FWHM1Initial=Fitresult[2]
		Position1Initial=Fitresult[3]
		Height2Initial=Fitresult[4]
		FWHM2Initial=Fitresult[5]
		Position2Initial=Fitresult[6]
		Height3Initial=Fitresult[7]
		FWHM3Initial=Fitresult[8]
		Position3Initial=Fitresult[9]
		Height4Initial=Fitresult[10]
		FWHM4Initial=Fitresult[11]
		Position4Initial=Fitresult[12]
		Height5Initial=Fitresult[13]
		FWHM5Initial=Fitresult[14]
		Position5Initial=Fitresult[15]
		
	endif
	
		if(NofLorentz==4)

		make/o/n=13 Fitresult

		Fitresult[0]=BGInitial
		Fitresult[1]=Height1Initial
		Fitresult[2]=FWHM1Initial
		Fitresult[3]=Position1Initial
		Fitresult[4]=Height2Initial
		Fitresult[5]=FWHM2Initial
		Fitresult[6]=Position2Initial
		Fitresult[7]=Height3Initial
		Fitresult[8]=FWHM3Initial
		Fitresult[9]=Position3Initial
		Fitresult[10]=Height4Initial
		Fitresult[11]=FWHM4Initial
		Fitresult[12]=Position4Initial	
		
		funcfit MDXLorentzianFit4Peak Fitresult FitlineY  /X=FitlineX /D=Fittedline
		BGInitial=Fitresult[0]
		Height1Initial=Fitresult[1]
		FWHM1Initial=Fitresult[2]
		Position1Initial=Fitresult[3]
		Height2Initial=Fitresult[4]
		FWHM2Initial=Fitresult[5]
		Position2Initial=Fitresult[6]
		Height3Initial=Fitresult[7]
		FWHM3Initial=Fitresult[8]
		Position3Initial=Fitresult[9]
		Height4Initial=Fitresult[10]
		FWHM4Initial=Fitresult[11]
		Position4Initial=Fitresult[12]
	endif
	
	if(NofLorentz==3)

		make/o/n=10 Fitresult

		Fitresult[0]=BGInitial
		Fitresult[1]=Height1Initial
		Fitresult[2]=FWHM1Initial
		Fitresult[3]=Position1Initial
		Fitresult[4]=Height2Initial
		Fitresult[5]=FWHM2Initial
		Fitresult[6]=Position2Initial
		Fitresult[7]=Height3Initial
		Fitresult[8]=FWHM3Initial
		Fitresult[9]=Position3Initial	
		funcfit MDXLorentzianFit3Peak Fitresult FitlineY  /X=FitlineX /D=Fittedline
		BGInitial=Fitresult[0]
		Height1Initial=Fitresult[1]
		FWHM1Initial=Fitresult[2]
		Position1Initial=Fitresult[3]
		Height2Initial=Fitresult[4]
		FWHM2Initial=Fitresult[5]
		Position2Initial=Fitresult[6]
		Height3Initial=Fitresult[7]
		FWHM3Initial=Fitresult[8]
		Position3Initial=Fitresult[9]
	endif
	
	if(NofLorentz==2)

		make/o/n=7 Fitresult

		Fitresult[0]=BGInitial
		Fitresult[1]=Height1Initial
		Fitresult[2]=FWHM1Initial
		Fitresult[3]=Position1Initial
		Fitresult[4]=Height2Initial
		Fitresult[5]=FWHM2Initial
		Fitresult[6]=Position2Initial
		
		funcfit MDXLorentzianFit2Peak Fitresult FitlineY  /X=FitlineX /D=Fittedline
		BGInitial=Fitresult[0]
		Height1Initial=Fitresult[1]
		FWHM1Initial=Fitresult[2]
		Position1Initial=Fitresult[3]
		Height2Initial=Fitresult[4]
		FWHM2Initial=Fitresult[5]
		Position2Initial=Fitresult[6]
	endif
	
	if(NofLorentz==1)

		make/o/n=4 Fitresult

		Fitresult[0]=BGInitial
		Fitresult[1]=Height1Initial
		Fitresult[2]=FWHM1Initial
		Fitresult[3]=Position1Initial
		funcfit MDXLorentzianFit1Peak Fitresult FitlineY  /X=FitlineX /D=Fittedline
		BGInitial=Fitresult[0]
		Height1Initial=Fitresult[1]
		FWHM1Initial=Fitresult[2]
		Position1Initial=Fitresult[3]
	endif
	
	if(strlen(traceinfo("LorentzFitW","Fittedline",0)))
	else
	appendtograph Fittedline vs FitlineX
	endif
	ModifyGraph lsize(Fittedline)=2
	endif
	setdatafolder Curr
	
end







Function MDXLorentzianFit1Peak(w,x)

	//w[0]   constant background;
	
	//w[1]   Height of the Lorentzian peak 1; 
	//w[2]   Full Width at Half maximum 1;
	//w[3]   Lorentzian Peak position 1;
	wave w; Variable x

	return w[0]+w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2))
END

Function MDXLorentzianFit2Peak(w,x)

	//w[0]   constant background;
	
	//w[1]   Height of the Lorentzian peak 1; 
	//w[2]   Full Width at Half maximum 1;
	//w[3]   Lorentzian Peak position 1;
	
	//w[4]   Height of the Lorentzian peak 2; 
	//w[5]   Full Width at Half maximum 2;
	//w[6]   Lorentzian Peak position 2;
	wave w; Variable x

	return w[0]+w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2)) + w[4]*(w[5]/2)*(w[5]/2)/((x-w[6])*(x-w[6])+(w[5]/2)*(w[5]/2)) 
END

Function MDXLorentzianFit3Peak(w,x)

	//w[0]   constant background;
	
	//w[1]   Height of the Lorentzian peak 1; 
	//w[2]   Full Width at Half maximum 1;
	//w[3]   Lorentzian Peak position 1;
	
	//w[4]   Height of the Lorentzian peak 2; 
	//w[5]   Full Width at Half maximum 2;
	//w[6]   Lorentzian Peak position 2;
	
	//w[7]   Height of the Lorentzian peak 3; 
	//w[8]   Full Width at Half maximum 3;
	//w[9]   Lorentzian Peak position 3;	
	
	wave w; Variable x

	return w[0]+w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2)) + w[4]*(w[5]/2)*(w[5]/2)/((x-w[6])*(x-w[6])+(w[5]/2)*(w[5]/2)) + w[7]*(w[8]/2)*(w[8]/2)/((x-w[9])*(x-w[9])+(w[8]/2)*(w[8]/2)) 
END

Function MDXLorentzianFit4Peak(w,x)

	//w[0]   constant background;
	
	//w[1]   Height of the Lorentzian peak 1; 
	//w[2]   Full Width at Half maximum 1;
	//w[3]   Lorentzian Peak position 1;
	
	//w[4]   Height of the Lorentzian peak 2; 
	//w[5]   Full Width at Half maximum 2;
	//w[6]   Lorentzian Peak position 2;
	
	//w[7]   Height of the Lorentzian peak 3; 
	//w[8]   Full Width at Half maximum 3;
	//w[9]   Lorentzian Peak position 3;	
	
	//w[10]   Height of the Lorentzian peak 4; 
	//w[11]   Full Width at Half maximum 4;
	//w[12]   Lorentzian Peak position 4;	
	wave w; Variable x

	return w[0]+w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2)) + w[4]*(w[5]/2)*(w[5]/2)/((x-w[6])*(x-w[6])+(w[5]/2)*(w[5]/2)) + w[7]*(w[8]/2)*(w[8]/2)/((x-w[9])*(x-w[9])+(w[8]/2)*(w[8]/2)) + w[10]*(w[11]/2)*(w[11]/2)/((x-w[12])*(x-w[12])+(w[11]/2)*(w[11]/2))
END

Function MDXLorentzianFit5Peak(w,x)

	//w[0]   constant background;
	
	//w[1]   Height of the Lorentzian peak 1; 
	//w[2]   Full Width at Half maximum 1;
	//w[3]   Lorentzian Peak position 1;
	
	//w[4]   Height of the Lorentzian peak 2; 
	//w[5]   Full Width at Half maximum 2;
	//w[6]   Lorentzian Peak position 2;
	
	//w[7]   Height of the Lorentzian peak 3; 
	//w[8]   Full Width at Half maximum 3;
	//w[9]   Lorentzian Peak position 3;	
	
	//w[10]   Height of the Lorentzian peak 4; 
	//w[11]   Full Width at Half maximum 4;
	//w[12]   Lorentzian Peak position 4;	
	
	//w[13]   Height of the Lorentzian peak 5; 
	//w[14]   Full Width at Half maximum 5;
	//w[15]   Lorentzian Peak position 5;	
	wave w; Variable x

	return w[0]+w[1]*(w[2]/2)*(w[2]/2)/((x-w[3])*(x-w[3])+(w[2]/2)*(w[2]/2)) + w[4]*(w[5]/2)*(w[5]/2)/((x-w[6])*(x-w[6])+(w[5]/2)*(w[5]/2)) + w[7]*(w[8]/2)*(w[8]/2)/((x-w[9])*(x-w[9])+(w[8]/2)*(w[8]/2)) + w[10]*(w[11]/2)*(w[11]/2)/((x-w[12])*(x-w[12])+(w[11]/2)*(w[11]/2))+w[13]*(w[14]/2)*(w[14]/2)/((x-w[15])*(x-w[15])+(w[14]/2)*(w[14]/2))
END

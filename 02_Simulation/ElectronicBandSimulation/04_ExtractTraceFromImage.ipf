#pragma rtGlobals=1		// Use modern global access method.
#pragma version=3.32



function Tracer_Initialise()
	string savDF= GetDataFolder(1)		
	NewDataFolder/O Root:DigitizedData
	NewDataFolder/O root:TempVariable
	NewDataFolder/O/S root:TempVariable:DigitizeData
	
	string /G ImageStr="", NewTraceStr=""
	make /O/N=11 sliderTicks=p/10
	make /O/T/N=11 sliderLabels
	sliderLabels[0]="Exact"
	sliderLabels[10]="Fuzzy"
	
	make /O/n=20  root:TempVariable:DigitizeData:TracerGlobals
	wave TracerGlobals=root:TempVariable:DigitizeData:TracerGlobals
	SetDimLabel 0, 0, null, TracerGlobals
	SetDimLabel 0, 1, XA, TracerGlobals
	SetDimLabel 0, 2, XB, TracerGlobals
	SetDimLabel 0, 3, YA, TracerGlobals
	SetDimLabel 0, 4, YB, TracerGlobals
	SetDimLabel 0, 5, gaps, TracerGlobals
	SetDimLabel 0, 6, JumpThreshold, TracerGlobals
	SetDimLabel 0, 7, R, TracerGlobals
	SetDimLabel 0, 8, G, TracerGlobals
	SetDimLabel 0, 9, B, TracerGlobals
	SetDimLabel 0, 10, RGBthreshold, TracerGlobals
	SetDimLabel 0, 11, bgR, TracerGlobals
	SetDimLabel 0, 12, bgG, TracerGlobals
	SetDimLabel 0, 13, bgB, TracerGlobals
	SetDimLabel 0, 14, fuzzy, TracerGlobals
	SetDimLabel 0, 15, csr, TracerGlobals
	SetDimLabel 0, 16, LogX, TracerGlobals
	SetDimLabel 0, 17, LogY, TracerGlobals
	SetDimLabel 0, 18, update, TracerGlobals
	SetDimLabel 0, 19, XYdata, TracerGlobals
	
	TracerGlobals[%null]=nan
	TracerGlobals[%XA]=nan
	TracerGlobals[%XB]=nan
	TracerGlobals[%YA]=nan
	TracerGlobals[%YB]=nan
	TracerGlobals[%gaps]=0
	TracerGlobals[%JumpThreshold]=100
	TracerGlobals[%R]=0
	TracerGlobals[%G]=0
	TracerGlobals[%B]=0
	TracerGlobals[%RGBthreshold]=50
	TracerGlobals[%JumpThreshold]=100
	TracerGlobals[%bgR]=255
	TracerGlobals[%bgG]=255
	TracerGlobals[%bgB]=255
	TracerGlobals[%fuzzy]=0.1
	TracerGlobals[%csr]=0
	TracerGlobals[%LogX]=0
	TracerGlobals[%LogY]=0
	TracerGlobals[%update]=50
	TracerGlobals[%XYdata]=0
	
	setDataFolder savDF
	
	dowindow /k TracerGraph
	Tracer_MakePanel()
	
end

Function Tracer_MakePanel()
	
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	
	doWindow /K TracerPanel
	NewPanel /K=1/N=TracerPanel/W=(55,59,243,625) as "Tracer"
	ModifyPanel /W=TracerPanel, fixedSize= 1//, noEdit=1
	SetDrawLayer UserBack
	DrawText 18,292,"trace"
	DrawText 27,319,"bg"
	Button Load,pos={44,9},size={100,20},proc=Tracer_Buttons,title="Load image..."
	Button Load,help={"Load an image to TempVariable:DigitizeData:"}
	Button displayIm,pos={44,36},size={100,20},proc=Tracer_Buttons,title="Display image..."
	Button displayIm,help={"Display an image from TempVariable:DigitizeData:"}
	Button clean,pos={44,63},size={100,20},title="Kill images...", proc=Tracer_Buttons
	Button clean,help={"Kill all images in TempVariable:DigitizeData:"}
	
	GroupBox groupScale,pos={9,97},size={172,144},title="Set Scale"
	TitleBox titleX,pos={69,113},size={12,20},title="\\Z16X",frame=0,fStyle=1
	TitleBox titleY,pos={126,113},size={12,20},title="\\Z16Y",frame=0,fStyle=1
	TitleBox titleCsrA,pos={18,136},size={42,14},title="\\Z18\\W642",frame=0
	TitleBox titleCsrB,pos={18,163},size={42,14},title="\\Z18\\W612",frame=0
	SetVariable setvarXA,pos={54,135},size={43,16},title=" "
	SetVariable setvarXA,limits={-inf,inf,0},value= root:TempVariable:DigitizeData:TracerGlobals[%XA]
	SetVariable setvarXB,pos={54,162},size={43,16},title=" "
	SetVariable setvarXB,limits={-inf,inf,0},value= root:TempVariable:DigitizeData:TracerGlobals[%XB]
	SetVariable setvarYA,pos={111,135},size={43,16},title=" "
	SetVariable setvarYA,limits={-inf,inf,0},value= root:TempVariable:DigitizeData:TracerGlobals[%YA]
	SetVariable setvarYB,pos={111,162},size={43,16},title=" "
	SetVariable setvarYB,limits={-inf,inf,0},value= root:TempVariable:DigitizeData:TracerGlobals[%YB]
	CheckBox checkLogX,pos={57,190},size={36,14},proc=Tracer_CheckProc,title="Log"
	CheckBox checkLogX,value=w[%LogX]
	CheckBox checkLogY,pos={114,190},size={36,14},proc=Tracer_CheckProc,title="Log"
	CheckBox checkLogY,value= w[%LogY]
	Button setX,pos={54,214},size={43,20},proc=Tracer_Buttons,title="Set X"
	Button setX,help={"Set image X scaling"}
	Button setY,pos={111,214},size={43,20},proc=Tracer_Buttons,title="Set Y"
	Button setY,help={"Set image Y scaling"}
	
	GroupBox groupColour,pos={9,253},size={171,123},title="Colour Selector"
	PopupMenu popupColour,pos={54,273},size={50,21},proc=Tracer_PopMenuProc
	PopupMenu popupColour,mode=1,popColor= (w[%R]/255*65535,w[%G]/255*65535,w[%B]/255*65535),value= #"\"*COLORPOP*\""
	Button CsrTr,pos={115,273},size={40,20},proc=Tracer_Buttons,title="csr..."
	Button CsrTr,help={"Select trace colour from image"}
	PopupMenu popupbg,pos={54,301},size={50,21},proc=Tracer_PopMenuProc
	PopupMenu popupbg,mode=1,popColor= (w[%bgR]/255*65535,w[%bgG]/255*65535,w[%bgB]/255*65535),value= #"\"*COLORPOP*\""
	Button CsrBg,pos={116,301},size={40,20},proc=Tracer_Buttons,title="csr..."
	Button CsrBg,help={"Select background colour from image"}
	Slider slider0,pos={18,328},size={153,42},proc=Tracer_SliderProc,fSize=8
	Slider slider0,limits={0,1,0.05},vert= 0
	Slider slider0,userTicks={:TempVariable:DigitizeData:sliderTicks,:TempVariable:DigitizeData:sliderLabels}
	Slider slider0,value= w[%fuzzy]
	
	GroupBox groupTrace,pos={10,385},size={170,172},title="Trace extractor"
	SetVariable setvarTraceName,pos={18,406},size={155,16},proc=Tracer_SetVarProc,title="Create:"
	SetVariable setvarTraceName,value= root:TempVariable:DigitizeData:NewTraceStr
	CheckBox checkXY,pos={60,429},size={58,14},proc=Tracer_CheckProc,title="XY Data"
	CheckBox checkXY,value= w[%XYdata]
	CheckBox checkGaps,pos={60,447},size={71,14},proc=Tracer_CheckProc,title="Allow Gaps"
	CheckBox checkGaps,value= w[%gaps]
	SetVariable setvarJump,pos={25,467},size={140,16},title="Jump threshold (pixels)"
	SetVariable setvarJump,limits={0,inf,0},value= root:TempVariable:DigitizeData:TracerGlobals[%JumpThreshold]	
	Button Go,pos={64,491},size={62,30},proc=Tracer_Buttons,title="Trace!"
	Button Go,picture= ProcGlobal#tracerpict2
	//Button Go,picture= ProcGlobal#AddButton
	Button editTrace,pos={65,528},size={60,20},proc=Tracer_Buttons,title="Edit trace"	
	
	SetWindow kwTopWin,hook=Tracer_PanelHook
	
End

function Tracer_PanelHook(infoStr)
	String infoStr
	
	String event= StringByKey("EVENT",infoStr)
		
	if (stringmatch(event, "kill")) 
		dowindow /K TracerGraph
		return 1
	endif
	return 0
end

Function Tracer_Buttons(ctrlName) : ButtonControl
	String ctrlName
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	
	SVAR NewTraceStr = root:TempVariable:DigitizeData:NewTraceStr
	
	String savDF
	string cmd, str

	
	strswitch(ctrlName)
		case "load":
			Tracer_LoadImage()
			return 1
		case "displayIm":
			Tracer_MakeGraph()			
			return 1
		case "clean":
			Tracer_Cleanup()			
			return 1
	endswitch
	
	doWindow TracerGraph
	if (V_flag==0)
		doAlert 0, "No image display!"
		return 0
	endif
	
	strswitch(ctrlName)
		case "setX":			
			if (abs(w[%XA]-w[%XB])<1e-15)
				return 0
			endif
			Tracer_SetImageScale("X")
			return 1			
		case "setY":			
			if (abs(w[%YA]-w[%YB])<1e-15)
				return 0
			endif
			Tracer_SetImageScale("Y")
			return 1
		case "CsrTr":
			// put csr on graph to select colour
			if (w[%csr]==1)
				w[%csr]=0
				setwindow TracerGraph hook=Tracer_Hook, hookevents=4
			else			
				w[%csr]=1
				setwindow TracerGraph hook=Tracer_Hook, hookevents=7, hookcursor=3
				dowindow /F TracerGraph
			endif
			return 1
		case "csrBg":
			// put csr on graph to select colour
			if (w[%csr]==2)
				w[%csr]=0
				setwindow TracerGraph hook=Tracer_Hook, hookevents=4
			else
				w[%csr]=2
				setwindow TracerGraph hook=Tracer_Hook, hookevents=7, hookcursor=3
				dowindow /F TracerGraph
			endif
			return 1
		case "Go":
			Tracer_ExtractTraceFromImage()
			return 1
		case "editTrace":
			if (Tracer_EditTrace())
				Button editTrace, win=TracerPanel, title="Stop edit", rename=StopEdit	
				return 1
			endif
			return 0
		case "StopEdit":
			GraphNormal
			Button StopEdit, win=TracerPanel, title="Edit trace", rename=editTrace
			return 1
	endswitch
End


Function Tracer_SliderProc(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	if(event %& 0x1)	// bit 0, value set
		w[%fuzzy]=sliderValue
		return 1
	endif

	return 0
End

Function Tracer_LoadImage()
	string savDF= GetDataFolder(1)			
	setDataFolder root:TempVariable:DigitizeData
	ImageLoad
	if (V_Flag==0)
		setDataFolder savDF
		return 0
	endif
	string str="root:TempVariable:DigitizeData:"+possiblyquotename (stringfromlist(0, S_waveNames))
	wave w=$str
	if (V_Flag)
		setscale /P y, 0, -1, w
	endif
	setDataFolder savDF
	return 1
end

Function Tracer_MakeGraph()
	
	string savDF= GetDataFolder(1)
	setDataFolder root:TempVariable:DigitizeData

	string str
	wave w=root:TempVariable:DigitizeData:TracerGlobals			
	string ListOfImages=wavelist("*", ";", "DIMS:2")+wavelist("*", ";", "DIMS:3")
	prompt str, "Select Image", popup, ListOfImages
	doprompt  "select image", str
	
	if (V_flag || stringmatch(str, "_none_") )
		setDataFolder savDF
		return 0
	endif
	
	DoWindow /K TracerGraph
	
	Display /K=1/N=TracerGraph /W=(188.25,44.75,679.5,459.5)   as "Tracer Image"
	AppendImage $str
	
	modifygraph width={Plan, abs(DimDelta($str, 1 )/ DimDelta($str, 0)) ,bottom,left}
	
	if(w[%LogX] || w[%LogY])
		Tracer_Replot()
	endif
	
	showinfo  /W=TracerGraph
	doupdate
	cursor  /I/W=TracerGraph/p A $str 0.1*DimSize($str, 0), 0.9*DimSize($str,1)
	cursor  /I/W=TracerGraph/p B $str 0.9*DimSize($str, 0), 0.9*DimSize($str,1)
	setDataFolder savDF
	doupdate
	w[%XA]=xcsr(A, "TracerGraph")
	w[%XB]=xcsr(B, "TracerGraph")
	w[%YA]=vcsr(A, "TracerGraph")
	w[%YB]=vcsr(B, "TracerGraph")
	setwindow TracerGraph hook=Tracer_Hook, hookevents=4
	
	SVAR NewTraceStr = root:TempVariable:DigitizeData:NewTraceStr
	NewTraceStr=UniqueName("trace", 1, 0) 
	setDataFolder savDF
	return 1
End

Function Tracer_Cleanup()	
	string savDF= GetDataFolder(1)
	setDataFolder root:TempVariable:DigitizeData
	DoAlert 1, "Discard all tracer images from memory?"
	if (V_Flag==2)
		setDataFolder savDF
		return 0
	endif
	DoWindow /K tracergraph
	string str, listofimages=wavelist("*", ";", "DIMS:3") 
	variable i
	for (i=0;i<itemsinlist(listofimages); i+=1)
		killwaves /Z $stringfromlist(i,listofimages)
	endfor
	setDataFolder savDF
	return 1	
end

Function Tracer_CheckProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	wave w=root:TempVariable:DigitizeData:TracerGlobals
					
	strswitch (ctrlName)
		case "CheckGaps":
			w[%gaps]=checked
			break
		case "CheckLogX":
			w[%LogX]=checked
			if (checked)
				w[%XYdata]=1
				CheckBox checkXY, win=TracerPanel, value=1, disable=2
			else
				w[%XYdata]=0
				CheckBox checkXY, win=TracerPanel, value=0, disable=0
			endif
			Tracer_Replot()
			break
		case "CheckLogY":
			w[%LogY]=checked
			Tracer_Replot()
			break
		case "CheckXY":
			w[%XYdata]=checked
			break	
	endswitch
	return 1
End

function Tracer_Replot()
	dowindow tracergraph
	if (V_Flag==0)
		return 0
	endif
	
	string strImage=stringfromlist(0, ImageNameList("TracerGraph", ";" ))
	wave w_image=ImageNameToWaveRef("TracerGraph", strImage )
	removeimage /W=tracergraph  $strImage
	string ImageNote=note(W_Image)

	
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	
	string strLogX="*", strLogY="*"
	variable Xhigh, Xlow, Yhigh, Ylow
	
	if(w[%LogX])
		make /O/n=(dimsize(w_image,0)+1) root:TempVariable:DigitizeData:TracerLogX
		wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
		Xhigh=numberbykey("Xhigh", ImageNote)
		if (numtype(Xhigh)==2)  //nan
			Xhigh=100
		endif
		Xlow=numberbykey("Xlow", ImageNote)
		if (numtype(Xlow)==2)  //nan
			Xlow=1
		endif	
		TracerLogX=alog(log(Xlow)+(p+0.5)/dimsize(TracerLogX,0)*(log(Xhigh)-log(Xlow)))
		strLogX="root:TempVariable:DigitizeData:TracerLogX"
		
	endif
	if(w[%LogY])
		make /O/n=(dimsize(w_image,1)+1) root:TempVariable:DigitizeData:TracerLogY
		wave TracerLogY=root:TempVariable:DigitizeData:TracerLogY
		Yhigh=numberbykey("Yhigh", ImageNote)
		if (numtype(Yhigh)==2)  //nan
			Yhigh=100
		endif
		Ylow=numberbykey("Ylow", ImageNote)
		if (numtype(Ylow)==2)  //nan
			Ylow=1
		endif		
		TracerLogY=alog(log(Ylow)+(dimsize(TracerLogY,0)-p-0.5)/dimsize(TracerLogY,0)*(log(Yhigh)-log(Ylow)))
		strLogY="root:TempVariable:DigitizeData:TracerLogY"
		
	endif
	
	string cmd
	sprintf cmd, "AppendImage /W=TracerGraph root:TempVariable:DigitizeData:%s vs {%s,%s}", possiblyquotename(strImage), strLogX, strLogY
	execute cmd
	
	// 
	if (w[%LogX] || w[%LogY])
		modifygraph  /W=TracerGraph width=0
	else
		modifygraph  /W=TracerGraph width={Plan, abs(DimDelta(w_image, 1 )/ DimDelta(w_image, 0)) ,bottom,left}
	endif
	
	cursor  /I/W=TracerGraph/p A $strImage 0.1*DimSize(W_Image, 0), 0.9*DimSize(W_Image,1)
	cursor  /I/W=TracerGraph/p B $strImage 0.9*DimSize(W_Image, 0), 0.9*DimSize(W_Image,1)
end

Function Tracer_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	SVAR NewTraceStr = root:TempVariable:DigitizeData:NewTraceStr 
	NewTraceStr=CleanupName(NewTraceStr, 0 )
	return 1	
End


Function Tracer_Hook (infoStr)
	String infoStr
	
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	
	String event= StringByKey("EVENT",infoStr)
		
	if (stringmatch(event, "mousedown")) // clear colourpicker
		w[%csr]=0
		setwindow TracerGraph hook=Tracer_Hook, hookevents=4
		return 1
	endif
	
	if (stringmatch(event, "mousemoved")) // update colourpicker
		string ImageNameString=stringfromlist (0, ImageNameList("TracerGraph", ";" ))
		wave theImage=ImageNameToWaveRef("TracerGraph",ImageNameString)
		
		variable varX, varY
		varX=AxisValFromPixel("TracerGraph", "bottom", numberbykey("MOUSEX", infostr) )
		varY=AxisValFromPixel("TracerGraph", "left", numberbykey("MOUSEY", infostr) )

		
		if(w[%logY])
			wave TracerLogY=root:TempVariable:DigitizeData:TracerLogY
			findlevel /q /P TracerLogY,varY  
			if (V_Flag)
				return 0
			endif  // found the point of TracerLogY closest to varY
			//V_LevelX shpould be image column number
			// reset varY from axis to image scaling 
			varY=  DimOffset(theImage, 1) + (V_LevelX-0.5)   *DimDelta(theImage,1)
		endif
		
		
		// this part not tested ****************
		if(w[%logX])
			wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
			findlevel /q/P TracerLogX,varX  
			if (V_Flag)
				return 0
			endif  // found the point of TracerLogY closest to varY
			//V_LevelX should be image row number
			// reset varX from axis to image scaling 
			varX=  DimOffset(theImage, 0) + (V_LevelX-0.5)   *DimDelta(theImage,0)
		endif
		// *******************
		
		if(w[%csr]==1) // trace picker
			w[%R]=theImage(varX)(varY)[0]
			w[%G]=theImage(varX)(varY)[1]
			w[%B]=theImage(varX)(varY)[2] 
			PopupMenu popupColour,win=TracerPanel, popColor= (65535*w[%R]/255,65535*w[%G]/255,65535*w[%B]/255)				
			ControlUpdate /W=TracerGraph popupColour		
		elseif(w[%csr]==2)			
			w[%bgR]=theImage(varX)(varY)[0]
			w[%bgG]=theImage(varX)(varY)[1]
			w[%bgB]=theImage(varX)(varY)[2] 
			PopupMenu popupbg,win=TracerPanel, popColor= (65535*w[%bgR]/255,65535*w[%bgG]/255,65535*w[%bgB]/255)				
			ControlUpdate /W=TracerGraph popupbg		
		endif
		return 1
	endif	
	
	if (stringmatch(event, "cursormoved"))
		string whichcsr=StringByKey("CURSOR",infoStr)
		strswitch(whichcsr)
			case "A":				
				if (strlen(CsrInfo(A  ,"TracerGraph")))
					w[%XA]=xcsr(a, "TracerGraph")
					w[%YA]=vcsr(a, "TracerGraph")
				endif
				return 1
			case "B":			
				if (strlen(CsrInfo(B  ,"TracerGraph")))
					w[%XB]=xcsr(B, "TracerGraph")
					w[%YB]=vcsr(B, "TracerGraph")
				endif
				return 1
		endswitch
	endif
	
	
	return 0				// 0 if nothing done, else 1 or 2
End

function Tracer_SetImageScale(XorY)	
	string XorY
	
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	
	variable A_val, B_val	
	
	variable isX=stringmatch(XorY, "X")
	variable isY=1-isX
	
	A_val=w[%YA]*isY + w[%XA]*isX
	B_val=w[%YB]*isY + w[%XB]*isX
	
	if (A_val==B_val)
		return 0
	endif
		
	wave pic=CsrWaveRef(A, "TracerGraph")
	variable A_P=isX*pcsr(A, "TracerGraph")+isY*qcsr(A, "TracerGraph")
	variable B_P=isX*pcsr(B, "TracerGraph")+isY*qcsr(B, "TracerGraph")
	variable V_delta=(A_Val-B_Val)/(A_P-B_P)
	
	
	string strNote=""
	variable Xhigh, Xlow, Yhigh, Ylow
	if (isX&&w[%LogX])
		if(A_val<=0 || B_val<=0)
			return 0
		endif
		strNote=note(pic)
		note /K pic
		
		wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
		
		TracerLogX=alog(log(A_val)+(p-0.5-pcsr(a))*(log(B_val)-log(A_val))/(pcsr(B)-pcsr(A)))
		Xlow=alog(log(A_val)+(-1-pcsr(a))*(log(B_val)-log(A_val))/(pcsr(B)-pcsr(A)))
		Xhigh=alog(log(A_val)+(dimsize(TracerLogX,0)-1-pcsr(a))/(pcsr(B)-pcsr(A))*(log(B_val)-log(A_val)))
		strNote=ReplaceNumberByKey("XHigh", strNote, Xhigh)
		strNote=ReplaceNumberByKey("XLow", strNote, Xlow)
		note pic, strNote
		return 1
	endif
	if (isY&&w[%LogY])
		if(A_val<=0 || B_val<=0)
			return 0
		endif
		strNote=note(pic)
		note /K pic
		
		wave TracerLogY=root:TempVariable:DigitizeData:TracerLogY
		
		TracerLogY=alog(log(A_val)+(p-0.5-qcsr(a))*(log(B_val)-log(A_val))/(qcsr(B)-qcsr(A)))
				
		// i'm not sure that this is exactly right. this part hurts my head.
		Ylow=alog(log(A_val)+(dimsize(TracerLogY,0)-1-qcsr(a))/(qcsr(B)-qcsr(A))*(log(B_val)-log(A_val)))
		Yhigh=alog(log(A_val)+(-1-qcsr(a))*(log(B_val)-log(A_val))/(qcsr(B)-qcsr(A)))
		
		strNote=ReplaceNumberByKey("YHigh", strNote, Yhigh)
		strNote=ReplaceNumberByKey("YLow", strNote, Ylow)
		note pic, strNote
		return 1
	endif
	

	
	string cmd
	sprintf cmd, "setscale /P %s %g, %g, root:TempVariable:DigitizeData:%s ", XorY, B_Val-V_delta*B_P, V_delta,  PossiblyQuoteName(csrwave(A, "TracerGraph"))
	execute cmd
	
	
	if (w[%LogX] || w[%LogY])
		modifygraph /W=TracerGraph width=0
	else
		modifygraph /W=TracerGraph width={Plan, abs(DimDelta(pic, 1 )/ DimDelta(pic, 0)) ,bottom,left}
	endif
	return 1
	//
end

function Tracer_EditTrace()
	string traceName=""
	if (!(itemsinlist( tracenamelist("TracerGraph",";",1))))
		GraphNormal // just in case
		DoAlert 0, "No traces on graph"
		return 0
	endif
	
	prompt traceName, "Trace to edit:"popup, tracenamelist("TracerGraph",";",1)
	doprompt "Select trace to edit", traceName
	
	if (V_flag)
		GraphNormal // just in case
		return 0
	endif
	
	GraphWaveEdit /W=TracerGraph /M $traceName
	return 1
end

Function Tracer_PopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	ControlInfo $ctrlName
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	if (stringmatch(ctrlName, "popupColour"))
		w[%R]=255/65535*V_Red // convert to 8 bit
		w[%G]=255/65535*V_Green
		w[%B]=255/65535*V_Blue	
	else // set bg colour
		w[%bgR]=255/65535*V_Red
		w[%bgG]=255/65535*V_Green
		w[%bgB]=255/65535*V_Blue
	endif
	
End

function Tracer_ExtractTraceFromImage()	
	wave g=root:TempVariable:DigitizeData:TracerGlobals
	string ImageNameString=stringfromlist (0, ImageNameList("TracerGraph", ";" ))
	SVAR TraceNameString=root:TempVariable:DigitizeData:NewTraceStr

	ShowInfo /W=TracerGraph
	if ( strlen(CsrInfo(A, "TracerGraph"))==0 || strlen(CsrInfo(B, "TracerGraph"))==0 )
		doalert 0, "Set cursors at start and end of trace"
		return 0
	endif
	if (cmpstr(CsrWave(A, "TracerGraph"), csrwave(B, "TracerGraph")))
		doalert 0, "Cursors must be on the same image"
		return 0
	endif
	if (pcsr(A, "TracerGraph")>pcsr(B, "TracerGraph"))
		variable tempP=pcsr(A, "TracerGraph"), tempQ=qcsr(A, "TracerGraph")	
		cursor /I /P /W=TracerGraph A $CsrWave(A, "TracerGraph") pcsr(B, "TracerGraph"), qcsr(B, "TracerGraph")
		cursor /I /P /W=TracerGraph B $CsrWave(A, "TracerGraph") tempP, tempQ		// does this work with liberal names???
	endif
	
	variable resolution=abs(pcsr(B, "TracerGraph")-pcsr(A, "TracerGraph"))+1	
	wave w=ImageNameToWaveRef( "TracerGraph", ImageNameString)
	
	TraceNameString=CleanupName(TraceNameString, 0 )
	if (CheckName(TraceNameString, 1) )
		doalert 1, TraceNameString+" already exists. Overwrite?"
		if (V_Flag==2)
			return 0		
		endif	
	endif
	setdatafolder root:digitizedData
	make /O/N=(resolution) $TraceNameString=nan
	wave dataWave=$TraceNameString
	print "created wave "+nameofwave(dataWave)
	
	removefromgraph /Z /W=TracerGraph $nameofwave(dataWave) // just in case
	
	if (!g[%logX])
		setscale /I x, xcsr(A, "TracerGraph"), xcsr(B, "TracerGraph"), dataWave
	endif
	
	if (g[%XYdata])
		make /O/N=(resolution) $TraceNameString+"_X"=nan
		wave dataXwave=$TraceNameString+"_X"
		setscale /I x, xcsr(A, "TracerGraph"), xcsr(B, "TracerGraph"), dataXwave
		
		if (g[%logX]) // deal with X data for log X plots
			wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
			dataXwave=TracerLogX[pcsr(A)+p+0.5] 
		else
			//dataXwave=xcsr(A, "TracerGraph")+p*DimDelta(w, 1)
			dataXwave=x
		endif	
	endif
	
	
	//fix for 31 character names!"
	if (strlen(ImageNameString)>32)
		ImageNameString=ImageNameString[1,31]
	endif
	
	string info=imageinfo("TracerGraph", ImageNameString, 0)
	
	if(g[%XYdata])
		AppendToGraph /W=TracerGraph dataWave vs dataXwave
	else
		AppendToGraph /W=TracerGraph dataWave
	endif
		
	ModifyGraph /W=TracerGraph mode($nameofwave(dataWave))=0,lsize($nameofwave(dataWave))=2, rgb($nameofwave(dataWave))=(65280,0,0)
	// default tracing is red
	if (g[%R]>128 && g[%G]<128 && g[%B]<128) // data is red on image
		ModifyGraph /W=TracerGraph rgb($nameofwave(dataWave))=(0,65280,0) // tracing will be green
	endif
	
	variable i=pcsr(A, "TracerGraph")
	variable j=0 // DataWave point number

	variable highP=qcsr(A, "TracerGraph"), lowP=qcsr(A, "TracerGraph")
	variable gap, jump=0, k

	
	do		
		gap=0
		if (RGBgood(w[i][highP][0],w[i][highP][1] ,w[i][highP][2])==0) // non-trace pixel
			do
				// expand to find a trace pixel
				lowP-=1
				highP+=1				
				
				if (RGBgood(w[i][highP][0],w[i][highP][1] ,w[i][highP][2]))
					lowP=highP
					break
				elseif(RGBgood(w[i][lowP][0],w[i][lowP][1] ,w[i][lowP][2]))
					highP=lowP
					break
				endif
			while ( highP<DimSize(w,1) && lowP>0 )			
		endif
		// check that we're on a trace pixel now	
			
		if (highP>lowP) // failed to find one
			if (g[%gaps])
				gap=1
			else
				if (g[%XYdata])
					doalert 0, "Failed to follow trace at x=" +  num2str(dataXwave[j])+ "\rTry allowing gaps"
				else
					doalert 0, "Failed to follow trace at x=" +  num2str(pnt2x(dataWave, j))+ "\rTry allowing gaps" 
				endif
				return 0
			endif
		else // found a trace pixel
			
			k=max(j,1)
			do
				k-=1 // find the last non-nan value in dataWave
			while(numtype(dataWave[k])==2&&k)
			
			
			if (g[%LogY])
				wave TracerLogY=root:TempVariable:DigitizeData:TracerLogY
				if (numtype(dataWave[k])==0)
					findlevel /q/P TracerLogY, dataWave[k]
					if (V_Flag)
						return 0 // should never arrive here
						print "failed at findlevel"
					endif  
					//V_LevelX should be image column number

					if(abs(highP-V_LevelX)>g[%JumpThreshold]) // need to check that this really is the right number of pixels
						// more than JumpThreshold pixels away from previous value
						if (g[%gaps])
							gap=1 // treat it as a gap
						else
							if (g[%logX])				
								wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
								jump+=(jump==0)*TracerLogX[pcsr(A)+j+0.5] 
							else
								jump+=(jump==0)*pnt2x(dataWave, j) // save first jump position
							endif	
						endif					
					endif	
				endif
			elseif (abs(highP-(dataWave[k]-DimOffset(w, 1))/DimDelta(w, 1))>g[%JumpThreshold] )
				// more than JumpThreshold pixels away from previous value
				if (g[%gaps])
					gap=1 // treat it as a gap
				else
					if (g[%logX])				
						wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
						jump+=(jump==0)*TracerLogX[pcsr(A)+j+0.5] 
					else
						jump+=(jump==0)*pnt2x(dataWave, j) // save first jump position
					endif	
				endif
			endif
		endif
		if (gap)
			
			k=max(j,1)
			do
				k-=1 // find the last non-nan value in dataWave
			while(numtype(dataWave[k])==2&&k)
			
			dataWave[j]=nan
			
			if (g[%LogY])
				wave TracerLogY=root:TempVariable:DigitizeData:TracerLogY
				findlevel /q /P TracerLogY, dataWave[k]
				highP=V_LevelX
			else
				highP=(dataWave[k]-DimOffset(w, 1))/DimDelta(w, 1)
			endif
			lowP=highP
		else		// not a gap
			do
				highP+=RGBgood(w[i][highP+1][0], w[i][highP+1][1], w[i][highP+1][2])
				lowP-=RGBgood(w[i][lowP-1][0], w[i][lowP-1][1], w[i][lowP-1][2]) 
				
				
				lowP=max(lowP,0)
				highP=min(highP,DimSize(w,1))
				
				
				if ( RGBgood(w[i][highP+1][0], w[i][highP+1][1], w[i][highP+1][2])==0 && RGBgood(w[i][lowP-1][0], w[i][lowP-1][1], w[i][lowP-1][2])==0 ) 
					// found the upper and lower bounds of trace
					break
				endif
			while (highP<DimSize(w,1) && lowP>0)
			
			// find the mid-point
			if (g[%LogY])
				wave TracerLogY=root:TempVariable:DigitizeData:TracerLogY
				dataWave[j]=TracerLogY[(highP+LowP)/2+0.5]
			else
				dataWave[j]=DimOffset(w, 1)+DimDelta(w, 1)*(highP+LowP)/2
			endif
					
//			// deal with X data for log X plots
//			if (g[%XYdata])
//				dataXwave[j]=x
//				if (g[%logX])
//					wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
//					dataXwave[j]=TracerLogX[pcsr(A)+j+0.5] 
//				endif
//			endif	
			
			highP=round((highP+LowP)/2)
			lowP=highP
		endif
		// allowing the doupdate can slow things down
		if((g[%update]) && mod(i, g[%update])==0) // sparse updating
			doupdate
		endif
		i+=1
		j+=1
	while(i<=pcsr(B, "TracerGraph"))	
	
	// make sure we found something!
	variable badData=1
	for (j=0;j<Dimsize(dataWave, 0); j+=1)
		if(numtype(dataWave[j])==0)
			badData=0
			break
		endif
	endfor
	
	if (jump!=0)
		print "Failed to follow trace at x=" +  num2str(jump)
		doalert 1, "May have failed to follow trace at x=" +  num2str(jump)+ "\rTry allowing gaps or adjusting jump thresholdr\rDelete "+ nameofwave(dataWave)+"?"
		if (V_flag==1)
			removefromgraph /W=TracerGraph $nameofwave(dataWave)
			killwaves dataWave
			print "deleted wave "+TraceNameString
		endif
	elseif ( badData || (abs(qcsr(B)- highP )>10) ) // no data, or more than 10 pixels away from target 
		print  "Looks like trace failed"
		doalert  1, "Looks like trace failed.\rDelete "+ nameofwave(dataWave)+"?"
		if (V_flag==1)
			removefromgraph /W=TracerGraph $nameofwave(dataWave)
			killwaves dataWave
			print "deleted wave "+TraceNameString
		endif
	else
		print "Trace extracted successfully"
	endif
end

static function RGBgood(R, G, B)
	variable R, G, B

	wave w=root:TempVariable:DigitizeData:TracerGlobals
	
	if (abs(R-w[%R])>max(w[%fuzzy]*(abs(w[%R]-w[%bgR])), w[%RGBthreshold]))
		return 0
	elseif (abs(G-w[%G])>max(w[%fuzzy]*(abs(w[%G]-w[%bgG])), w[%RGBthreshold]))
		return 0
	elseif (abs(B-w[%B])>max(w[%fuzzy]*(abs(w[%B]-w[%bgB])), w[%RGBthreshold]))
		return 0
	endif
	
	return 1
end


function ACW_EraseMarqueeArea()
	GetMarquee left, bottom
	if (V_flag == 0)
		Print "There is no marquee"
		return 0
	endif
	wave w=root:TempVariable:DigitizeData:TracerGlobals
	
	string ImageNameString=stringfromlist (0, ImageNameList("", ";" ))
	if (strlen(ImageNameString)==0)
		doalert 0, "Top window doesn't contain an image"
		return 0
	endif
	wave theImage=ImageNameToWaveRef("", ImageNameString)
	duplicate theImage tempTracerImage
	wave temp=tempTracerImage
	
	// convert coordinates to point values	
	
	if (w[%LogX])
		wave TracerLogX=root:TempVariable:DigitizeData:TracerLogX
		findlevel /q /P TracerLogX, V_left
		V_left=V_LevelX
		findlevel /q /P TracerLogX, V_right
		V_right=V_LevelX
	else
		V_left=(V_left - DimOffset(theImage, 0))/DimDelta(theImage,0)
		V_right=(V_right - DimOffset(theImage, 0))/DimDelta(theImage,0)
	endif	
	
	if (w[%LogY])
		wave TracerLogY=root:TempVariable:DigitizeData:TracerLogY
		findlevel /q /P TracerLogY, V_top
		V_top=V_LevelX
		findlevel /q /P TracerLogY, V_bottom
		V_bottom=V_LevelX
	else
		V_bottom=(V_bottom - DimOffset(theImage, 1))/DimDelta(theImage,1)
		V_top=(V_top - DimOffset(theImage, 1))/DimDelta(theImage,1)
	endif
	
	variable pXlow, pXhigh, pYlow, pYhigh
	pXlow=ceil(min(V_left,V_right))
	pXhigh=max(V_left,V_right)
	pYlow=ceil(min(V_bottom,V_top))
	pYhigh=max(V_bottom,V_top)
	
	theImage[pXlow, pXhigh][pYlow, pYhigh][]=255
	doupdate
	doalert 1, "keep changes?"
	if (V_flag==2)
		duplicate /o temp theImage
	endif
	killwaves temp
End


// PNG: width= 997, height= 165
Picture TracerPict2
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!#1!!!!?#R18/!1STD#ljr*$#iF<ErZ1A`;fl>`;thHJ+!@;!!Hq#9gJ
	aZYK/X+MWk*@!#]lI=EIJ[Aor6*Eb,5:A8bpg+A$EYB4XtP@:XY'a^mR7!!\-K6pXdsg1"=%If4`s!
	<EC@i5($N$jm=K%(H:$H#i$1@ID[H<t?ibZ@me"S_X=9\o6K?0lV,PiA:e34LoM)0Gd-DQBiR''btj
	.8b!7a!<S&\PfOjbYkjjJ_M&@+"pP8?jFDg.9<>kZY?uor0ekDanfL&C@)/''$%[ZS9<>j/Y?leEOV
	ZgZ%NJjV#TtIA$HRAb5j>,`:1QV-66.JfPh7uoiYs"jQpAVO-ta)!*]s\iORp7cj>-ng!Q[r<R>kGY
	!1PSL5C`ZcQZ0kC:t;bGV8WG9p1`M=>+,m%?b_$nQi%sjK1\+$irg(bZiIHi)qKB;`Ap0`0nJ%4`9%
	JqK,b;Nlke/o+NQ*qR38ghgnA"_#PhA(>8u'Ua4YRNQH2@KnCk9c@(s:d4B:3JC2-?sZXJBRRi>W'K
	D^\/l%1LL_r:f(8DL)FRl27`S_5[s9A]^M`'dL4"F=6;&t33-+ag:9oG8&p@2TB9fEVca"kLSH%oM'
	Tpc<o#QK4r>T;IIu'\@eX&9.c0GA7jXTTVFQQ8W>b!rr?iF@$5o3!0o&dSY]Z3>%b6TYq<I%'iNa#9
	+Ki4?EP`j8r/P"',6>!0l^;p%AX=Cf&-&@8KZa8Ma7p#;*YiWD`fE_JJ;C#/r_d!!j^A'DdJ;5f`Dh
	Fb4i]iY6_ZMqM(o<3fBX8OG,TdG)<uQFs`OVH01V>,=5OR.='[o&;EoQ>mBG5XZo?CaC^A4:Z+q.nE
	LoCljE:r;+4%^oK_a!2W_qNX^Nml_"lY>QAL?J_K1L-?cJ=**(]M.k.U>6#d?kF)6[R+Fo7dFhq/=;
	X/8_G!@k/Idm.6f[K'/(/dV-5`#s$8Yj<R$SBU--$83F*)]735`#s$8Yj<R$dHm"`\f0i6#hrLl2hM
	^/>S69$mh".Sq(n3jnA)r$p/\$,^RrD?h47Uj%,**#<?DVaunaD]&9YATf"DrR[[iVm3(M@GLQd=J=
	*9t"$oWlEeYKh0q2>e?>=QrWRZBiV:i6>-rR+CV5;ju!'gN=;8WrAdt=)VNO7p=%]571/^:.,d'BE;
	9="p*J,j%f(oDhLZYe25IDP.Q@/H,:#p`^"Y#9W=KpoD/U%eft+M=7B;E>;`3fXo\8aVLieDfcO'%7
	^%,o5.obs7<'JD01Z[P]oT3\d1&Hm<%k*.9!.(<=t"J>I17!5c>NJ<\p\5W(8e/hMl]!WYjR`$Y,m2
	VLJhB,"<)i$oiRok4^SZXN);+Fl/80#1`<Y[IV^.klo=!1HJ)B<;Ig;p_Pd5Ygp)A,qL*&f11<3XA$
	PjpO?Q&3rokl?:Oc:Ip'B@2_+cSD6i?g%Zo'#aL.;l5c+&8PN=*-?N.S7$KN881P/\5iNa4r$!l#'0
	?Ic8s>'3/HgS(@_nM[_);TB0I`$WA\3p-ZcQKJ!(qpK"9kN60e.df!clXEM*NpWX?Zm81mh3-?3*&_
	9d5)f_CX(:![*==jC&sKZA9Ak*Jg:NBE]PqC`BgOE'uNi@.=\9&(BYK5QG5Q\ptE;63>h#RulYY)+u
	:*djHJdiu3%@2%^<>4@jXP9.6Ktdqg29q*L%n3(I7>M&[5eABpJRC;,eYCa$7_6B'U%oF2?s9[mAM0
	\Am&aOtf(X_%qe,<>P=l\R?cRS*WOD737rP(TqR-cTt)q?@3JRS4RWWm8]Q-k]Hg:f;=1$W+G"&0Da
	f,ltpa8lm$2;Mu1r!!7s7#ouNY7ZDQR\7uFE9+G-WTt1So?6)I\QjjTl1g:$3?E-r!1rj2$?ms9>FW
	?6@^dW.#5u"\bh/T6$d",#Q6&sUu!Q7=2KJ!SedJjARP4MLg=XV:,:nWEaLO"-;((4R:3.`htnd3h9
	"1=,f=lP%eiik.eC7@q39e5]:ZJc[#k^_Z_R\`$c9NZ\+@l?RPZ+t[^ZriM%EX])$/]/2ZWTKt:]$R
	0=$<ogs.WMFN*`&rlkbBc;k`EZI&C;WHaYb$'^&\:kM:NV!BT^@b0qY&40!s8m6*Ao5*-IrdS<I\G/
	:@U'&Df<+Te0=fn150eVtU:EV$5rFV8U'gJC#(D?b_&PV&,af9(Z$@hN8H.!!1#?%g;ZbrS`"b,`'!
	WokJH#a&UCES"RSF:Tb\NbRG!jI=TMu_`5@J!!3Q/!,>BaiU*nDz8OZBBY!QNJ
	ASCII85End
End
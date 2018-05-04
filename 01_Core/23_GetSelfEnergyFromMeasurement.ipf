#pragma rtGlobals=1		// Use modern global access method.



// DDessau Group Procedure for KK Transfromation

Proc kkimaginarytorealAG(imagpartwave)
string imagpartwave
pauseupdate;silent 1
// create a variable for the number of rows in the input wave
Variable/D dimension=DimSize($imagpartwave,0)
// Create a complex wave with the input data in the real part,and zero's in the imaginary part
Make/d/c/o/n=(dimension) input_cmplx=cmplx(0,$imagpartwave)
// Fast Fourrier Transform the complex input wave
iFFT/c Input_cmplx
input_cmplx[0]=0.5*input_cmplx[0]
setscale/i x -0.5, 0.5, input_cmplx
//Now enforce causality by removing all 'values for times less than zero
Variable counter=0
do
if(pnt2x(input_cmplx,counter)>0)
input_cmplx[counter]=0
endif
counter+=1
While(counter<dimension)
// Fast Fourrier Transform back to E space
FFT input_cmplx
setscale/p x,0,1, input_cmplx
input_cmplx*=2
// Make output waves for real and imaginary parts
Make/d/o/n=(dimension) ioutput_real, ioutput_imag
copyscales $imagpartwave, ioutput_real, ioutput_imag
Ioutput_real=-real(input_cmplx)
Ioutput_imag=imag(input_cmplx)
Display $imagpartwave
Appendtograph ioutput_real, ioutput_imag
differentcolorsino()
Updatelegendino(3)
ModifyGraph mode($imagpartwave)=4,msize($imagpartwave)=1
End




Proc NewSelfEnergyPanel()

	
	setdatafolder root:MDCFittedParameters
	String tempf="Ey*F"+num2str(root:PROCESS:ProcessedImageFlag)+"*"
	//print tempf
	String TempList=wavelist(tempF,";","DIMS:1")
	//print templist
	String TempString=""
	String TempList1=""
	variable ii=0
	
	do
		TempString=StringFromList(ii,TempList,";")
		TempString=Stringbykey("E",TempString,"y")
		tempList1=TempList1+";"+TempString	
		ii=ii+1
	while(ii<ItemsInList(TempList,";"))
	//print TempList1
	//templist
	root:DispersionIMAGE:DispersionFileList=TempList1
	DoWindow/F NEW_SELF_ENERGY_PANEL
	if (V_flag==0)

	    NewDataFolder/O/S root:Original_DispMDCWidth_1overA
	
	    NewDataFolder/O/S root:Shifted_DispMDCWidth_1overA	
	    
	    NewDataFolder/O/S root:EffectiveSEfromOriDisp1overA	    
	
	    NewDataFolder/O/S root:SelfEnergyFromMDC
	      
		Variable/G  Energy0Start=NumVarOrDefault("root:SelfEnergyFromMDC:Energy0Start",5)
		Variable/G  Energy0End=NumVarOrDefault("root:SelfEnergyFromMDC:Energy0End",5)	        
		Variable/G  Energy1Start=NumVarOrDefault("root:SelfEnergyFromMDC:Energy1Start",5)
		Variable/G  Energy1End=NumVarOrDefault("root:SelfEnergyFromMDC:Energy1End",5)
		Variable/G  Energy2Start=NumVarOrDefault("root:SelfEnergyFromMDC:Energy2Start",5)
		Variable/G  Energy2End=NumVarOrDefault("root:SelfEnergyFromMDC:Energy2End",5)
		Variable/G  Energy3Start=NumVarOrDefault("root:SelfEnergyFromMDC:Energy3Start",5)	       
		Variable/G  Energy3End=NumVarOrDefault("root:SelfEnergyFromMDC:Energy3End",5)
		
		Variable/G  SEEStart=NumVarOrDefault("root:SelfEnergyFromMDC:SEEStart",5)		
		Variable/G  SEEEnd=NumVarOrDefault("root:SelfEnergyFromMDC:SEEEnd",5)			
		Variable/G  SEKStart=NumVarOrDefault("root:SelfEnergyFromMDC:SEKStart",5)			
		Variable/G  SEKEnd=NumVarOrDefault("root:SelfEnergyFromMDC:SEKEnd",5)			
		
		
		      
	      
		Variable/G  FittedA=NumVarOrDefault("root:SelfEnergyFromMDC:FittedA",5)
		Variable/G  FittedB=NumVarOrDefault("root:SelfEnergyFromMDC:FittedB",5)	        
		Variable/G  FittedC=NumVarOrDefault("root:SelfEnergyFromMDC:FittedC",5)
		
		Variable/G WayForRealSE
		Variable/G WayForImaginarySE
		
		Variable/G KKSEShowMode=NumVarOrDefault("root:SelfEnergyFromMDC:KKSEShowMode",0) 
		
		
		String/G    RealSEFileList=Wavelist("ReSE_*",";","DIMS:1")
		String/G    ImaginarySEFileList=Wavelist("ImSE_*",";","DIMS:1")
		
		NEW_SELF_ENERGY_Panel()
		
	endif
End



 Window NEW_SELF_ENERGY_PANEL() : Panel

	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(155,113,600,580)	
	ModifyPanel cbRGB=(48896,52992,65280)
	SetDrawLayer UserBack
	
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,15872,65280),fstyle= 1,fsize= 14
	DrawText 5,20,"A:Show Dispersion and MDC Width"	
	
	
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,15872,65280),fstyle= 1,fsize= 12
	DrawText 270,15,"Effective SE from OriDisp(1/A)"		
	
		
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,15872,65280),fstyle= 1,fsize= 16
	DrawText 5,100,"B:Get Velocities"		
	

	SetDrawEnv fname= "Times New Roman"	
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 13
	DrawText 5,120,"High       BE     Line:"	
	
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 13
	DrawText 5,140,"Near       Ef      Line:"
	
	
    SetDrawEnv fname= "Times New Roman"	
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 13
	DrawText 5,170,"Bare Band: Linear Line"
	
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 13
	DrawText 5,190,"Bare Band: Parabola:"
	
	SetDrawEnv fname= "Times New Roman"	
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 13
	DrawText 5,205," w=a+b*k+c*k^2"
	
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,15872,65280),fstyle= 1,fsize= 16
	DrawText 5,255,"C: Extraction of Self Energy"
	
    SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,15872,65280),fstyle= 1,fsize= 16
	DrawText 5,370,"D: Kramers-Kronig Transformation"	
		
	
	
	
//	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 16
//	DrawText 230,90,"Connect Two Points"
//	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 16	
//	DrawText 245,110,"Energy Position"
	
	PopupMenu popup_OriDispersionPiOA,pos={10,20},size={150,100},font="Times New Roman",proc=ShowOriginalDispersion_PiOa,title="OriDisp(pi/a) "
	PopupMenu popup_OriDispersionPiOA,mode=6,popvalue="NDJQF3t15O45PP29T0P",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 
	
	PopupMenu popup_OriDispersionFile1OA,pos={10,40},size={150,100},font="Times New Roman",proc=ShowOriginalDispersion_1OA,title="OriDisp(1/A) "
	PopupMenu popup_OriDispersionFile1OA,mode=6,popvalue="NDJQF3t15O45PP29T0P",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 	
		
	
	PopupMenu popup_DispersionFileforSE,pos={10,60},size={150,100},font="Times New Roman",proc=ShowShiftedDispersion,title="SFTDisp(1/A)"
	PopupMenu popup_DispersionFileforSE,mode=6,popvalue="NDJQF3t15O45PP29T0P",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 
	
	
	
	SetVariable EnergySEE_Start,proc=SetVarProc,pos={278,15},size={150,25},font="Times New Roman",title="SEE_Start(eV) ",fSize=10
	SetVariable EnergySEE_Start,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:SEEStart
	SetVariable EnergySEK_Start,proc=SetVarProc,pos={278,30},size={150,25},font="Times New Roman",title="SEK_Start(1/A)",fSize=10
	SetVariable EnergySEK_Start,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:SEKStart
	
	
	
	SetVariable EnergySEE_End,proc=SetVarProc,pos={278,49},size={150,25},font="Times New Roman",title="SEE_End (eV) ",fSize=10
	SetVariable EnergySEE_End,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:SEEEnd	
	SetVariable EnergySEK_End,proc=SetVarProc,pos={278,64},size={150,25},font="Times New Roman",title="SEK_End (1/A)",fSize=10
	SetVariable EnergySEK_End,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:SEKEnd	
	
 	
 	PopupMenu popup_EffectiveSE,pos={260,80},size={150,90},font="Times New Roman",proc=GetEffectiveSEfromOriDisp1OA,title="EffSE"
	PopupMenu popup_EffectiveSE,mode=6,popvalue="NDJQF3t15O45PP29T0P",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 	
	
	

	SetVariable Energy1_Start,proc=SetVarProc,pos={150,106},size={135,25},font="Times New Roman",title="HighE_Start1 (eV)",fSize=10
	SetVariable Energy1_Start,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:Energy1Start
	SetVariable Energy1_End,proc=SetVarProc,pos={300,106},size={135,25},font="Times New Roman",title="HighE_End1 (eV)",fSize=10
	SetVariable Energy1_End,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:Energy1End
	

	SetVariable Energy3_Start,proc=SetVarProc,pos={150,127},size={135,25},font="Times New Roman",title="NearEf_Start2 (eV)",fSize=10
	SetVariable Energy3_Start,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:Energy3Start
	SetVariable Energy3_End,proc=SetVarProc,pos={300,127},size={135,25},font="Times New Roman",title="NearEf_End2 (eV)",fSize=10
	SetVariable Energy3_End,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:Energy3End	
	
	
	SetVariable Energy0_Start,proc=SetVarProc,pos={150,158},size={135,25},font="Times New Roman",title="BareE_Start0 (eV)",fSize=10
	SetVariable Energy0_Start,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:Energy0Start
	SetVariable Energy0_End,proc=SetVarProc,pos={300,158},size={135,25},font="Times New Roman",title="BareE_End0 (eV)",fSize=10
	SetVariable Energy0_End,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:Energy0End	
		
		
	SetVariable Fitted_a,proc=SetVarProc,pos={150,185},size={105,25},font="Times New Roman",title="Fitted a:",fSize=10
	SetVariable Fitted_a,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:FittedA
	SetVariable Fitted_b,proc=SetVarProc,pos={265,185},size={75,25},font="Times New Roman",title="b:",fSize=10
	SetVariable Fitted_b,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:FittedB
	SetVariable Fitted_c,proc=SetVarProc,pos={360,185},size={75,25},font="Times New Roman",title="c:",fSize=10
	SetVariable Fitted_c,limits={-inf,inf,0.1},value=root:SelfEnergyFromMDC:FittedC		


	PopupMenu popup_GetVelocity,pos={50,210},size={180,105},font="Times New Roman",proc=GetVelocity,title="Get   Velocity  "
	PopupMenu popup_GetVelocity,mode=6,popvalue="NDJQF3t15O45PP29T0P",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 


    SetVariable set_KKSEShowMode,pos={240,240},size={190,25},font="Times New Roman",title="Show KK Self-Energy?(0:No,1:Yes)",fSize=10
	SetVariable set_KKSEShowMode,limits={0,1,1},value= root:SelfEnergyFromMDC:KKSEShowMode


	PopupMenu popup_RePartWayType,pos={50,260},size={150,85},font="Times New Roman",proc=BareDispersionTypeSelection,title="Way to Get Bare Dispersion?"
	PopupMenu popup_RePartWayType,mode=1,popvalue="Fitted",value= #"\"Fitted Dispersion;Connect Two Points\""

	
	PopupMenu popup_ImaginarySEType,pos={50,290},size={150,45},font="Times New Roman",proc=ImaginarySEWaySelection,title="Way to Get Imaginary Part?  "
	PopupMenu popup_ImaginarySEType,mode=1,popvalue="MDCHWHM X BareVelocity",value= #"\"MDCHWHM X BareVelocity;Kramers-Kronig Transform\""	
	
	PopupMenu popup_GetImagSelfEnergy,pos={50,320},size={180,105},font="Times New Roman",proc=GetMeasuredSelfEnergy,title="Extract Self Energy"
	PopupMenu popup_GetImagSelfEnergy,mode=6,popvalue="NDJQF3t15O45PP29T0P",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 
	
		
	PopupMenu popup_KKGetImagFromReal,pos={100,375},size={180,105},font="Times New Roman",proc=KKGetImagFromReal,title="Get Imaginary from Real"
	PopupMenu popup_KKGetImagFromReal,mode=6,popvalue="ReSE_L0F0t20P10T17N ",value= #"root:SelfEnergyFromMDC:RealSEFileList\t\t" 
	
	PopupMenu popup_KKGetRealFromImag,pos={100,405},size={180,105},font="Times New Roman",proc=KKGetRealFromImag,title="Get Real from Imaginary"
	PopupMenu popup_KKGetRealFromImag,mode=6,popvalue="ImSE_L0F0t20P10T17N ",value= #"root:SelfEnergyFromMDC:ImaginarySEFileList\t\t" 	
		
	

	Button Button_CleanExit,pos={150,435},size={180,30},font="Times New Roman",proc=NSECleanExit,title="Clean and  Exit"	
	
		
	EndMacro
	
	
	Proc BareDispersionTypeSelection(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
	If (cmpstr(popStr,"Fitted Dispersion")==0)	
	root:SelfEnergyFromMDC:WayForRealSE=0
	Print popStr,  "WayForRealSE=", root:SelfEnergyFromMDC:WayForRealSE
	Endif
	
	If (cmpstr(popStr,"Connect Two Points")==0)
	root:SelfEnergyFromMDC:WayForRealSE=1
	Print popStr,  "WayForRealSE=", root:SelfEnergyFromMDC:WayForRealSE
	Endif	
	
	SetDataFolder Curr
	
	END
	
	
	Proc ImaginarySEWaySelection(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
	If (cmpstr(popStr,"MDCHWHM X BareVelocity")==0)	
	root:SelfEnergyFromMDC:WayForImaginarySE=0
	Print popStr,  "WayForRealSE=", root:SelfEnergyFromMDC:WayForImaginarySE
	Endif
	
	If (cmpstr(popStr,"Kramers-Kronig Transform")==0)
	root:SelfEnergyFromMDC:WayForImaginarySE=1
	Print popStr,  "WayForRealSE=", root:SelfEnergyFromMDC:WayForImaginarySE
	Endif	
	
	SetDataFolder Curr
	
	END	
	
	
	Proc ShowOriginalDispersion_PiOa(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String WindowName=	"OPOa_"+popStr
	String Curr=GetDataFolder(1)
	pauseupdate;silent 1
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"t",0)
	String NameForDisp=popStr[0,ImageNameLength]
	
	String SE_kPosition="Psn1" + NameforDisp
	String SE_kPositionError="PsEr1" + NameforDisp	
	String SE_FWHM="FM1"+NameforDisp
	String SE_FWHMError="FMEr1"+NameforDisp
	String SE_InvHeight="IvH1"+NameforDisp
	String SE_Energy="Ey"+NameforDisp
////	String Zero_kPosition="k0Pos1"+NameforDisp
////	String Zero_kPositionError="k0PosEr1"+NameforDisp	
////	String A_FWHM="FWHM1"+NameforDisp
////	String A_FWHMError="FWHMEr1"+NameforDisp	
////	String A_Energy="Energy"+NameforDisp
	
////	Print SE_kPosition, Zero_kPosition
	
////	Duplicate/O root:MDCFittedParameters:$SE_kPosition  root:MDCFitPara_Zerokand1overA:$Zero_kposition
////    Duplicate/O root:MDCFittedParameters:$SE_kPositionError  root:MDCFitPara_Zerokand1overA:$Zero_kpositionError
////	Duplicate/O root:MDCFittedParameters:$SE_FWHM  root:MDCFitPara_Zerokand1overA:$A_FWHM
////	Duplicate/O root:MDCFittedParameters:$SE_FWHMError  root:MDCFitPara_Zerokand1overA:$A_FWHMError	
////	Duplicate/O root:MDCFittedParameters:$SE_Energy  root:MDCFitPara_Zerokand1overA:$A_Energy

	SetDataFolder  root:MDCFittedParameters
//	$Zero_kPosition*=1
//	$A_FWHM*=1
	
////	$Zero_kPosition*=3.1416/root:PROCESS:LatticeConstant
////	$Zero_kPositionError*=3.1416/root:PROCESS:LatticeConstant	
////	$A_FWHM*=3.1416/root:PROCESS:LatticeConstant
////	$A_FWHMError*=3.1416/root:PROCESS:LatticeConstant	
	
////       Variable DataPointNumber=DimSize($A_Energy,0)
////       Variable EnergyStep=$A_Energy[1]-$A_Energy[0]
	
//Find the position of the zero energy
////       Variable ZeroEnergyPoint
////       Variable k0Shift
////       Variable iFind0E=0
////       Do 
////       IF (1000*abs($A_Energy[iFind0E])<=abs(EnergyStep)*1000*51/100)
////       ZeroEnergyPoint=iFind0E
////       k0Shift=$Zero_kposition[iFind0E]
////       Endif
////       iFind0E+=1
////       While(iFind0E<DataPointNumber)
////       Print "ZeroEnergyPoint=",ZeroEnergyPoint
////       Print "k0Shift=", k0Shift, "(1/A)",  "      ",  k0Shift*root:PROCESS:LatticeConstant/3.1416, "Pi/a"
////       $Zero_kposition-=k0Shift	
		

	DoWindow $WindowName
	
	IF(V_flag==0)	

Display/L=LDis/B=BDis $SE_Energy vs $SE_kPosition
ErrorBars $SE_Energy X,wave=($SE_kPositionError,$SE_kPositionError)
ModifyGraph width={Aspect,1.8}
ModifyGraph height=350
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph freePos(LDis)={-1.3,BDis},freePos(BDis)={-2,LDis}
ModifyGraph margin(left)=67,margin(bottom)=57, margin(right)=57
ModifyGraph axisEnab(BDis)={0,0.45}
ModifyGraph mode=3,marker=8,rgb=(0,15872,65280)
ModifyGraph mirror(BDis)=2
ModifyGraph lblPosMode(LDis)=4

AppendToGraph/R=RMDCWidth/B=BMDCWidth $SE_FWHM vs $SE_Energy
ErrorBars $SE_FWHM Y,wave=($SE_FWHMError,$SE_FWHMError)
ModifyGraph fStyle(RMDCWidth)=1,fSize(RMDCWidth)=12,standoff(RMDCWidth)=0;DelayUpdate
ModifyGraph font(RMDCWidth)="Times New Roman",freePos(RMDCWidth)={0,BMDCWidth}
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph axisEnab(BMDCWidth)={0.60,1},freePos(BMDCWidth)={0,RMDCWidth}
ModifyGraph mirror(BMDCWidth)=2
ModifyGraph mode=3,marker=8,rgb($SE_FWHM)=(52224,34816,0)
Label LDis "\\F'Times New Roman'\\Z20E-E\\BF\\M\\Z20 (eV)"
Label BMDCWidth "\\F'Times New Roman'\\Z20E - E\\BF\\M\\Z20 (eV)"
Label BDis "\\F'Times New Roman'\\Z20k (\\F'Symbol'p\\Z20\\F'Times New Roman'/a)"
ModifyGraph lblRot(RMDCWidth)=180;DelayUpdate
Label RMDCWidth "\\F'Times New Roman'\\Z20MDC Width (\\F'Symbol'p\\Z20\\F'Times New Roman'/a)"

AppendToGraph/L=LInvHeight/B=BMDCWidth $SE_InvHeight vs $SE_Energy
ModifyGraph standoff=0,freePos(LInvHeight)={-1.2,BMDCWidth}
ModifyGraph mode=3,marker=8
ModifyGraph fStyle=1
Label LInvHeight "\\Z18\\f01Inverse Height"
ModifyGraph lblPos(LInvHeight)=55


ModifyGraph tick=2

ModifyGraph lblPos(BMDCWidth)=100
ModifyGraph lblPos(BDis)=100
ModifyGraph lblPos(LDis)=100
ModifyGraph lblPos(RMDCWidth)=100

Legend/C/N=text0/F=0/A=LB



    ShowInfo
	DoWindow/C $WindowName
	Else
	DoWindow/F $WindowName
	Endif

	SetDataFolder Curr
 
	
	End
		
	
	
	
	Proc ShowOriginalDispersion_1OA(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String WindowName=	"O1OA_"+popStr
	String Curr=GetDataFolder(1)
	Pauseupdate;silent 1
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"t",0)
	String NameForDisp=popStr[0,ImageNameLength]
	
	String SE_kPosition="Psn1" + NameforDisp
	String SE_kPositionError="PsEr1" + NameforDisp	
	String SE_FWHM="FM1"+NameforDisp
	String SE_FWHMError="FMEr1"+NameforDisp
	String SE_InvHeight="IvH1"+NameforDisp
	String SE_Energy="Ey"+NameforDisp
//	String Zero_kPosition="k0Position"+NameforDisp
	String Zero_kPosition="Ps1OA"+NameforDisp
	String Zero_kPositionError="PEr1A"+NameforDisp	
	String A_FWHM="FM1OA"+NameforDisp
	String A_FWHMError="FMEr1OA"+NameforDisp	
	String A_InvHeight="IvH1OA"+NameforDisp	
	String A_Energy="Ey1OA"+NameforDisp
	
	Print SE_kPosition, Zero_kPosition
	Print A_InvHeight
	
	Duplicate/O root:MDCFittedParameters:$SE_kPosition  root:Original_DispMDCWidth_1overA:$Zero_kposition
    Duplicate/O root:MDCFittedParameters:$SE_kPositionError  root:Original_DispMDCWidth_1overA:$Zero_kpositionError
	Duplicate/O root:MDCFittedParameters:$SE_FWHM  root:Original_DispMDCWidth_1overA:$A_FWHM
	Duplicate/O root:MDCFittedParameters:$SE_FWHMError  root:Original_DispMDCWidth_1overA:$A_FWHMError
	Duplicate/O root:MDCFittedParameters:$SE_InvHeight  root:Original_DispMDCWidth_1overA:$A_InvHeight		
	Duplicate/O root:MDCFittedParameters:$SE_Energy  root:Original_DispMDCWidth_1overA:$A_Energy

	SetDataFolder  root:Original_DispMDCWidth_1overA
//	$Zero_kPosition*=1
//	$A_FWHM*=1
	
	$Zero_kPosition*=3.1416/root:PROCESS:LatticeConstant
	$Zero_kPositionError*=3.1416/root:PROCESS:LatticeConstant	
	$A_FWHM*=3.1416/root:PROCESS:LatticeConstant
	$A_FWHMError*=3.1416/root:PROCESS:LatticeConstant	
	
       Variable DataPointNumber=DimSize($A_Energy,0)
       Variable EnergyStep=$A_Energy[1]-$A_Energy[0]
	
	

	DoWindow $WindowName
	
	IF(V_flag==0)	

Display/L=LDis/B=BDis  $A_Energy vs $Zero_kposition
ErrorBars $A_Energy X,wave=($Zero_kpositionError,$Zero_kpositionError)
ModifyGraph width={Aspect,1.8}
ModifyGraph height=350
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph freePos(LDis)={-2.3,BDis},freePos(BDis)={-2,LDis}
ModifyGraph margin(left)=67,margin(bottom)=57, margin(right)=57
ModifyGraph axisEnab(BDis)={0,0.45}
ModifyGraph mode=3,marker=8,rgb=(0,15872,65280)
ModifyGraph mirror(BDis)=2
ModifyGraph lblPosMode(LDis)=4

AppendToGraph/R=RMDCWidth/B=BMDCWidth $A_FWHM vs $A_Energy
ErrorBars $A_FWHM Y,wave=($A_FWHMError,$A_FWHMError)
ModifyGraph fStyle(RMDCWidth)=1,fSize(RMDCWidth)=12,standoff(RMDCWidth)=0;DelayUpdate
ModifyGraph font(RMDCWidth)="Times New Roman",freePos(RMDCWidth)={0,BMDCWidth}
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph axisEnab(BMDCWidth)={0.60,1},freePos(BMDCWidth)={0,RMDCWidth}
ModifyGraph mirror(BMDCWidth)=2
ModifyGraph mode=3,marker=8,rgb($A_FWHM)=(52224,34816,0)
Label LDis "\\F'Times New Roman'\\Z20E-E\\BF\\M\\Z20 (eV)"
Label BMDCWidth "\\F'Times New Roman'\\Z20E - E\\BF\\M\\Z20 (eV)"
Label BDis "\\F'Times New Roman'\\Z20k (1/A)"
ModifyGraph lblRot(RMDCWidth)=180;DelayUpdate
Label RMDCWidth "\\F'Times New Roman'\\Z20MDC Width (1/A)"


AppendToGraph/L=LInvHeight/B=BMDCWidth $A_InvHeight vs $A_Energy
ModifyGraph standoff=0,freePos(LInvHeight)={-1.2,BMDCWidth}
ModifyGraph mode=3,marker=8
ModifyGraph fStyle=1
Label LInvHeight "\\Z18\\f01Inverse Height"
ModifyGraph lblPos(LInvHeight)=55


ModifyGraph tick=2

ModifyGraph lblPos(BMDCWidth)=100
ModifyGraph lblPos(BDis)=100
ModifyGraph lblPos(LDis)=100
ModifyGraph lblPos(RMDCWidth)=100

Legend/C/N=text0/F=0/A=LB




    ShowInfo
	DoWindow/C $WindowName
	Else
	DoWindow/F $WindowName
	Endif

	SetDataFolder Curr
 
	
	End	
	
	
	
		
	Proc ShowShiftedDispersion(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String WindowName=	"Sft1OA_"+popStr
	String Curr=GetDataFolder(1)
	Pauseupdate;silent 1
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"t",0)
	String NameForDisp=popStr[0,ImageNameLength]
	
	String SE_kPosition="Psn1" + NameforDisp
	String SE_kPositionError="PsEr1" + NameforDisp	
	String SE_FWHM="FM1"+NameforDisp
	String SE_FWHMError="FMEr1"+NameforDisp
	String SE_InvHeight="IvH1"+NameforDisp
	String SE_Energy="Ey"+NameforDisp
//	String Zero_kPosition="k0Position"+NameforDisp
	String Zero_kPosition="k0P1"+NameforDisp
	String Zero_kPositionError="k0PEr1"+NameforDisp	
	String A_FWHM="FM1"+NameforDisp
	String A_FWHMError="FMEr1"+NameforDisp
	String A_InvHeight="IvH1"+NameforDisp
	String A_Energy="Ey"+NameforDisp
	
	Print SE_kPosition, Zero_kPosition
	
	Duplicate/O root:MDCFittedParameters:$SE_kPosition  root:Shifted_DispMDCWidth_1overA:$Zero_kposition
    Duplicate/O root:MDCFittedParameters:$SE_kPositionError  root:Shifted_DispMDCWidth_1overA:$Zero_kpositionError
	Duplicate/O root:MDCFittedParameters:$SE_FWHM  root:Shifted_DispMDCWidth_1overA:$A_FWHM
	Duplicate/O root:MDCFittedParameters:$SE_FWHMError  root:Shifted_DispMDCWidth_1overA:$A_FWHMError
	Duplicate/O root:MDCFittedParameters:$SE_InvHeight  root:Shifted_DispMDCWidth_1overA:$A_InvHeight	
	Duplicate/O root:MDCFittedParameters:$SE_Energy  root:Shifted_DispMDCWidth_1overA:$A_Energy

	SetDataFolder  root:Shifted_DispMDCWidth_1overA
//	$Zero_kPosition*=1
//	$A_FWHM*=1
	
	$Zero_kPosition*=3.1416/root:PROCESS:LatticeConstant
	$Zero_kPositionError*=3.1416/root:PROCESS:LatticeConstant	
	$A_FWHM*=3.1416/root:PROCESS:LatticeConstant
	$A_FWHMError*=3.1416/root:PROCESS:LatticeConstant	
	
       Variable DataPointNumber=DimSize($A_Energy,0)
       Variable EnergyStep=$A_Energy[1]-$A_Energy[0]
	
//Find the position of the zero energy
       Variable ZeroEnergyPoint
       Variable k0Shift
       Variable iFind0E=0
       Do 
       IF (1000*abs($A_Energy[iFind0E])<=abs(EnergyStep)*1000*51/100)
       ZeroEnergyPoint=iFind0E
       k0Shift=$Zero_kposition[iFind0E]
       Endif
       iFind0E+=1
       While(iFind0E<DataPointNumber)
       Print "ZeroEnergyPoint=",ZeroEnergyPoint
       Print "k0Shift=", k0Shift, "(1/A)",  "      ",  k0Shift*root:PROCESS:LatticeConstant/3.1416, "Pi/a"
       $Zero_kposition-=k0Shift	
		

	DoWindow $WindowName
	
	IF(V_flag==0)	

	

Display/L=LDis/B=BDis  $A_Energy vs $Zero_kposition
ErrorBars $A_Energy X,wave=($Zero_kpositionError,$Zero_kpositionError)
ModifyGraph width={Aspect,1.8}
ModifyGraph height=350
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph freePos(LDis)={-0.3,BDis},freePos(BDis)={-2,LDis}
ModifyGraph margin(left)=67,margin(bottom)=57, margin(right)=57
ModifyGraph axisEnab(BDis)={0,0.45}
ModifyGraph mode=3,marker=8,rgb=(0,15872,65280)
ModifyGraph mirror(BDis)=2
ModifyGraph lblPosMode(LDis)=4
ModifyGraph zero(BDis)=6,zeroThick(BDis)=2

AppendToGraph/R=RMDCWidth/B=BMDCWidth $A_FWHM vs $A_Energy
ErrorBars $A_FWHM Y,wave=($A_FWHMError,$A_FWHMError)
ModifyGraph fStyle(RMDCWidth)=1,fSize(RMDCWidth)=12,standoff(RMDCWidth)=0;DelayUpdate
ModifyGraph font(RMDCWidth)="Times New Roman",freePos(RMDCWidth)={0,BMDCWidth}
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph axisEnab(BMDCWidth)={0.60,1},freePos(BMDCWidth)={0,RMDCWidth}
ModifyGraph mirror(BMDCWidth)=2
ModifyGraph mode=3,marker=8,rgb($A_FWHM)=(52224,34816,0)
Label LDis "\\F'Times New Roman'\\Z20E-E\\BF\\M\\Z20 (eV)"
Label BDis "\\F'Times New Roman'\\Z20k - k\\BF\\M\\Z20 (\\F'Symbol'p\\F'Times New Roman'/a)"
Label BMDCWidth "\\F'Times New Roman'\\Z20E - E\\BF\\M\\Z20 (eV)"
Label BDis "\\F'Times New Roman'\\Z20k - k\\BF\\M\\Z20 (\\F'Symbol'1/A)"
ModifyGraph lblRot(RMDCWidth)=180;DelayUpdate
Label RMDCWidth "\\F'Times New Roman'\\Z20MDC Width (1/A)"


AppendToGraph/L=LInvHeight/B=BMDCWidth $A_InvHeight vs $A_Energy
ModifyGraph standoff=0,freePos(LInvHeight)={-1.2,BMDCWidth}
ModifyGraph mode=3,marker=8
ModifyGraph fStyle=1
Label LInvHeight "\\Z18\\f01Inverse Height"
ModifyGraph lblPos(LInvHeight)=55


ModifyGraph tick=2

ModifyGraph lblPos(BMDCWidth)=100
ModifyGraph lblPos(BDis)=100
ModifyGraph lblPos(LDis)=100
ModifyGraph lblPos(RMDCWidth)=100

Legend/C/N=text0/F=0/A=LB
	
//	Display/L=LDisp $Zero_kposition vs $A_Energy
//	ErrorBars $Zero_kposition Y,wave=($Zero_kpositionError,$Zero_kpositionError)
	
//	AppendToGraph/R=RFWHM $A_FWHM vs $A_Energy
//	ErrorBars $A_FWHM Y,wave=($A_FWHMError,$A_FWHMError)
	
	
//	ModifyGraph mode($Zero_kposition)=3,marker($Zero_kposition)=19
//	ModifyGraph mode($A_FWHM)=3,marker($A_FWHM)=19,rgb($A_FWHM)=(0,12800,52224)
//	ModifyGraph mirror(bottom)=1
//	ModifyGraph freePos(LDisp)={root:MDCSpectra:DispersionEnergyStart,bottom}
//	ModifyGraph freePos(RFWHM)={root:MDCSpectra:DispersionEnergyEnd,bottom}
//	ModifyGraph margin(bottom)=62,margin(right)=62,margin(left)=62
//	ModifyGraph width={Aspect,0.6}
////	ModifyGraph height=432
//	ModifyGraph tick=2
//	ModifyGraph fStyle(LDisp)=1,fStyle(bottom)=1,axThick(LDisp)=2,axThick(bottom)=2;DelayUpdate
//    ModifyGraph standoff(LDisp)=0,standoff(bottom)=0
//    ModifyGraph fStyle=1,axThick=2,standoff=0
//	Label bottom "\\Z12\\f01E - E\\BF \\M(eV)"
//	Label LDisp "\\Z12\\f01Momentum k (1/A)"
//	Label RFWHM "\\Z12\\f01FWHM (1/A)"	
//	Legend/N=text0/F=0/A=LB
//	Textbox/C/N=text1/A=RT  TextOne
//      AppendText/N=text1 TextTwo
    ShowInfo
	DoWindow/C $WindowName
	Else
	DoWindow/F $WindowName
	Endif



	SetDataFolder Curr
 
	
	End
	
	
	
	Proc GetEffectiveSEfromOriDisp1OA(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String WindowName="EffecSE_"+popStr
	String Curr=GetDataFolder(1)
	pauseupdate;silent 1
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"t",0)
	String NameForDisp=popStr[0,ImageNameLength]
	
	String SE_kPosition="Psn1" + NameforDisp
	String SE_kPositionError="PsEr1" + NameforDisp	
	String SE_FWHM="FM1"+NameforDisp
	String SE_FWHMError="FMEr1"+NameforDisp
	String SE_Energy="Ey"+NameforDisp
//	String Zero_kPosition="k0Position"+NameforDisp
	String Zero_kPosition="EffPos"+NameforDisp
	String Zero_kPositionError="EffPosEr"+NameforDisp	
	String A_FWHM="Eff_FM"+NameforDisp
	String A_FWHMError="Eff_FMEr"+NameforDisp	
	String A_Energy="Eff_Ey"+NameforDisp
	
////	Print SE_kPosition, Zero_kPosition
	
	Duplicate/O root:MDCFittedParameters:$SE_kPosition  root:EffectiveSEfromOriDisp1overA:$Zero_kposition
    Duplicate/O root:MDCFittedParameters:$SE_kPositionError  root:EffectiveSEfromOriDisp1overA:$Zero_kpositionError
	Duplicate/O root:MDCFittedParameters:$SE_FWHM  root:EffectiveSEfromOriDisp1overA:$A_FWHM
	Duplicate/O root:MDCFittedParameters:$SE_FWHMError  root:EffectiveSEfromOriDisp1overA:$A_FWHMError	
	Duplicate/O root:MDCFittedParameters:$SE_Energy  root:EffectiveSEfromOriDisp1overA:$A_Energy

	SetDataFolder  root:EffectiveSEfromOriDisp1overA
	
	$Zero_kPosition*=3.1416/root:PROCESS:LatticeConstant
	$Zero_kPositionError*=3.1416/root:PROCESS:LatticeConstant	
	$A_FWHM*=3.1416/root:PROCESS:LatticeConstant
	$A_FWHMError*=3.1416/root:PROCESS:LatticeConstant	
	
       Variable DataPointNumber=DimSize($A_Energy,0)
       Variable EnergyStep=$A_Energy[1]-$A_Energy[0]
       
       
     String BareBEName="BareBE_"+ NameforDisp
     String EffectiveSEName="Eff_"+NameforDisp
     
     Duplicate/O $A_Energy  $BareBEName
     Duplicate/O $A_Energy  $EffectiveSEName
     
     
     Variable SEEStart=root:SelfEnergyFromMDC:SEEStart
     Variable SEEEnd=root:SelfEnergyFromMDC:SEEEnd
     Variable SEKStart=root:SelfEnergyFromMDC:SEKStart
     Variable SEKEnd=root:SelfEnergyFromMDC:SEKEnd
     
     
     $BareBEName=(SEEEnd-SEEStart)/(SEKEnd-SEKStart)*($Zero_kPosition-SEKStart)+SEEStart
     
     $EffectiveSEName=($A_Energy-$BareBEName)*1000 
	
	

	DoWindow $WindowName
	
	IF(V_flag==0)	

Display/L=LDis/B=BDis  $EffectiveSEName vs $A_Energy
ModifyGraph width={Aspect,1.6}
ModifyGraph height=283
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph freePos(LDis)={-2.5,BDis},freePos(BDis)={-1000,LDis}
ModifyGraph margin(left)=57,margin(bottom)=57, margin(right)=57
ModifyGraph axisEnab(BDis)={0,0.5}
ModifyGraph mode=3,marker=8,rgb=(0,15872,65280)
ModifyGraph mirror(BDis)=2
ModifyGraph lblPosMode(LDis)=4

AppendToGraph/R=RMDCWidth/B=BMDCWidth $A_FWHM vs $A_Energy
ErrorBars $A_FWHM Y,wave=($A_FWHMError,$A_FWHMError)
ModifyGraph fStyle(RMDCWidth)=1,fSize(RMDCWidth)=12,standoff(RMDCWidth)=0;DelayUpdate
ModifyGraph font(RMDCWidth)="Times New Roman",freePos(RMDCWidth)={0,BMDCWidth}
ModifyGraph fStyle=1,fSize=12,standoff=0,font="Times New Roman";DelayUpdate
ModifyGraph axisEnab(BMDCWidth)={0.55,1},freePos(BMDCWidth)={0,RMDCWidth}
ModifyGraph mirror(BMDCWidth)=2
ModifyGraph mode=3,marker=8,rgb($A_FWHM)=(52224,34816,0)
Label LDis "\\F'Times New Roman'\\Z18Effective Self-Energy (meV)"
Label BMDCWidth "\\F'Times New Roman'\\Z20E - E\\BF\\M\\Z20 (eV)"
Label BDis "\\F'Times New Roman'\\Z20E-E\\BF\\M\\Z20 (eV)"
ModifyGraph lblRot(RMDCWidth)=180;DelayUpdate
Label RMDCWidth "\\F'Times New Roman'\\Z20MDC Width (1/A)"

ModifyGraph lblPos(BMDCWidth)=100
ModifyGraph lblPos(BDis)=100
ModifyGraph lblPos(LDis)=100
ModifyGraph lblPos(RMDCWidth)=100


    ShowInfo
	DoWindow/C $WindowName
	Else
	DoWindow/F $WindowName
	Endif

	SetDataFolder Curr
 
		
	End

	
	
	
	Proc GetVelocity(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String SEWindowName=	"SE_"+popStr
	String Curr=GetDataFolder(1)
	pauseupdate;silent 1
////	ShowMeasuredDispersion(ctrlName,popNum,popStr)
	
    ShowShiftedDispersion(ctrlName,popNum,popStr)
	
	Variable ImageNameLength=strlen(popStr)
	String NameForDisp=popStr[0,ImageNameLength]
//	print NameforDisp
	
	
//	String Zero_kPosition="k0Position"+NameforDisp
	String Zero_kPosition="k0P1"+NameforDisp
	String Zero_kPositionError="k0PEr1"+NameforDisp
	//String Zero_kPositionError=NameforDisp
	String A_FWHM="FM1"+NameforDisp
	String A_FWHMError="FMEr1"+NameforDisp	
	String A_Energy="Ey"+NameforDisp
	String SE_Energy="SEEy_"+NameforDisp
	String ReSE="ReSE_"+NameforDisp
	String ReSEError="ReSEEr_"+NameforDisp
	String ImSE="ImSE_"+NameforDisp
	String ImSEError="ImSEEr_"+NameforDisp	
	Variable FitA=root:SelfEnergyFromMDC:FittedA
	Variable FitB=root:SelfEnergyFromMDC:FittedB
	Variable FitC=root:SelfEnergyFromMDC:FittedC
	
//	Print Zero_kPosition
	
	SetDataFolder root:Shifted_DispMDCWidth_1overA
	

	Variable  EnergyPointNumber=DimSize($A_Energy,0)
	Variable  MomentumPointNumber=DimSize($Zero_kPosition,0)	
	Variable  DataPointNumber=DimSize($A_Energy,0)
    Variable  EnergyStep=$A_Energy[1]-$A_Energy[0]	
    
//  Print "EnergyStep=", energyStep
	
	
	
	
	//Find k and E for the high BE point
	
       Variable HighBEEnergy=root:SelfEnergyFromMDC:Energy0Start
       Variable HighBEk
       Variable iHighBE=0
       Do 
       IF (1000*abs($A_Energy[iHighBE]-HighBEEnergy)<abs(EnergyStep)*1000*51/100)
       HighBEk=$Zero_kposition[iHighBE]
       Endif
       iHighBE+=1
       While(iHighBE<DataPointNumber)
//       Print "HigBEEnergy=",HighBEEnergy
//       Print "HighBEk=", HighBEk
	
	
	//Fing k and E for the near Ef point
	
       Variable NearEfEnergy=root:SelfEnergyFromMDC:Energy0End
       Variable NearEfk
       Variable iNearEf=0
       Do 
       IF (1000*abs($A_Energy[iNearEf]-NearEfEnergy)<abs(EnergyStep)*1000*51/100)
       NearEfk=$Zero_kposition[iNearEf]
       Endif
       iNearEf+=1
       While(iNearEf<DataPointNumber)
//       Print "NearEfEnergy=",NearEfEnergy
//       Print "NearEfk=", NearEfk	
	
	
	//Calculate Real part of Self-energy
	Make/O/N=(EnergyPointNumber) BareDispersion, RealSE, RealSEError,ImagSE, ImagSEError	
	
	IF (root:SelfEnergyFromMDC:WayForRealSE==0)	
	BareDispersion=FitA+FitB*($Zero_kPosition)+FitC*($Zero_kPosition)^2
	EndIF
	
	IF(root:SelfEnergyFromMDC:WayForRealSE==1)
	BareDispersion=NearEfEnergy+(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)*($Zero_kPosition-NearEfk)
	EndIF
	
//      String  TextBareDispersionLine="BareDisp Line:  E=" + num2str(NearEfEnergy-(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)*NearEfk) + Num2Str((HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)) +"*k"	
        String  TextBareDispersionLine="BareDisp Line:  E="  + Num2Str((HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)) +"*k"	

        Textbox/C/N=text1/A=RT  TextBareDispersionLine
	
//	Display BareDispersion vs $Zero_kPosition

	RealSE=($A_Energy-BareDispersion)*1000
	RealSEError=$Zero_kPositionError*(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)*1000


	  //Calculate Imaginary part of Self-Energy
	
      //Find Energy points for Typical energy positions
      
       Variable EnergyS1=root:SelfEnergyFromMDC:Energy1Start
       Variable EnergyE1=root:SelfEnergyFromMDC:Energy1End 
       Variable EnergyS2=root:SelfEnergyFromMDC:Energy2Start
       Variable EnergyE2=root:SelfEnergyFromMDC:Energy2End           
       Variable EnergyS3=root:SelfEnergyFromMDC:Energy3Start
       Variable EnergyE3=root:SelfEnergyFromMDC:Energy3End            
       Variable ES1,EE1,ES2,EE2,ES3,EE3
       Variable iEnergyP=0
       Do 

       IF (1000*abs($A_Energy[iEnergyP]-EnergyS1)<=abs(EnergyStep)*1000*51/100)
       ES1=iEnergyP
       Print "EnergyS1=", EnergyS1, "ES1=", iEnergyP
       Endif
       IF (1000*abs($A_Energy[iEnergyP]-EnergyE1)<=abs(EnergyStep)*1000*51/100)
       EE1=iEnergyP
       
       Print "EE1=", EE1
       Endif     
       
       IF (1000*abs($A_Energy[iEnergyP]-EnergyS2)<=abs(EnergyStep)*1000*51/100)
       ES2=iEnergyP
       Endif
       IF (1000*abs($A_Energy[iEnergyP]-EnergyE2)<=abs(EnergyStep)*1000*51/100)
       EE2=iEnergyP
       Endif   
       
       IF (1000*abs($A_Energy[iEnergyP]-EnergyS3)<=abs(EnergyStep)*1000*51/100)
       ES3=iEnergyP
       Endif
       IF (1000*abs($A_Energy[iEnergyP]-EnergyE3)<=abs(EnergyStep)*1000*51/100)
       EE3=iEnergyP
       Endif              
       
     
       iEnergyP+=1
       While(iEnergyP<DataPointNumber)	
	
       Print "ES1=", ES1, "EE1=", EE1	
	
	
	//Step 1:  Fit Dispersion at high BE with a line
	
//	Print ES1, EE1
//	Edit $A_Energy

////	CurveFit line, $Zero_kPosition(ES1, EE1) /X=$A_Energy /D
	CurveFit line, $A_Energy(ES1, EE1) /X=$Zero_kPosition /D	
	
	String FittedDispersionHighBE="fit_"+A_Energy
//	Display $FittedDispersionHighBE
	Duplicate/O $FittedDispersionHighBE TempVelocityHighBE
	Duplicate/O $FittedDispersionHighBE FittedHighBELine

	RemoveFromGraph/Z FittedHighBELine
	
	
	AppendToGraph/L=LDis/B=BDis FittedHighBELine		
////	 AppendToGraph/L=LDisp FittedHighBELine
     ModifyGraph rgb(FittedHighBELine)=(0,0,0)
     ModifyGraph lsize(FittedHighBELine)=2

		
////	Differentiate TempVelocityHighBE
////	Variable HighBEinVelocity=TempVelocityHighBE[0]
////	Variable HighBEVelocity=1/HighBEinVelocity
////	Variable  EoverkInter=-W_coef[0]/W_coef[1]
////	Variable EoverkSlope=1/W_coef[1]
        String  TextHighBELine="HighBE:  E=" + num2str(W_coef[0]) + "+"+Num2Str(W_coef[1]) +"*k"
//     String TextOne="HighBEVelocity= "+num2str(HighBEVelocity)+"eV*A"
    AppendText/N=text1   TextHighBELine	
    TextBox/C/N=text1/A=MB/X=1.06/Y=14.73
	
	//Step 2:  Fit Dispersion near EF with a line

	CurveFit line, $A_Energy(ES3, EE3) /X=$Zero_kPosition /D
	String FittedDispersionNearEf="fit_"+A_Energy
//	Display $FittedDispersionNearEf
	Duplicate/O $FittedDispersionNearEf TempVelocityNearEf
	Duplicate/O $FittedDispersionHighBE FittedNearEfLine

	RemoveFromGraph/Z FittedNearEfLine
////	AppendToGraph/L=LDisp FittedNearEfLine
	AppendToGraph/L=LDis/B=BDis FittedNearEfLine	
    ModifyGraph rgb(FittedNearEfLine)=(0,0,0)
    ModifyGraph lsize(FittedNearEfLine)=2
       
	Differentiate TempVelocityNearEf
	Variable NearEfinVelocity=TempVelocityNearEf[0]
	Variable NearEfVelocity=1/NearEfinVelocity
	
	Variable  EoverkEfInter=W_coef[0]
	Variable EoverkEfSlope=W_coef[1]
       String  TextNearEfLine="Near Ef:  E=" + num2str(EoverkEfInter) + "+" + Num2Str(EoverkEfSlope) +"*k"
//     String TextTwo="NearEfVelocity= "+num2str(NearEfVelocity)+"eV*A"
       AppendText/N=text1 TextNearEfLine
       
       
	RemoveFromGraph/Z $FittedDispersionNearEf  
	Killwaves/Z  $FittedDispersionNearEf    
       
       
       
       //Step 3:  Get coupling constant from BareDispersion/NearEfvelocity
       Variable CalculatedLamda=(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)/EoverkEfSlope-1
       String CalLamda="CalculatedLamda=" + num2Str(CalculatedLamda)
       AppendText/N=text1 CalLamda       
       
		
	
	SetDataFolder Curr
	End


	
	
	
	
////////////////////////////////////////////////////////////////////////////

	Proc GetMeasuredSelfEnergy(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ReSEpopStr="ReSE_"+popStr
	String ImSEpopStr="ImSE_"+popStr
	String SEWindowName=	"SE_"+popStr
	String Curr=GetDataFolder(1)
	pauseupdate;silent 1
	
//  Kill SelfEnergyFiles in Root:SelfEnergyfromMDC
	SetDataFolder root:SelfEnergyFromMDC
	String ToBeKilledSEList=WaveList("*SE*_*",";","DIMS:1")
       Variable NoofKilledSEList=ItemsinList(ToBeKilledSEList,";")
        String SECurve
	     Variable iSE=0
	     Do
	     SECurve=StringFromList(iSE,ToBeKilledSEList,";")
	     KillWaves/Z  $SECurve
	     iSE+=1
	     While(iSE<NoofKilledSEList)
	     
		 String ToBeKilledKKList=WaveList("*KK*_*",";","DIMS:1")
        Variable NoofKilledKKList=ItemsinList(ToBeKilledKKList,";")
        String KKCurve
	     Variable iKK=0
	     Do
	     KKCurve=StringFromList(iKK,ToBeKilledKKList,";")
	     KillWaves/Z  $KKCurve
	     iKK+=1
	     While(iKK<NoofKilledKKList)     
	     
	     

	
	
////	ShowMeasuredDispersion(ctrlName,popNum,popStr)


    String ShiftWindowName=	"Sft1OA_"+popStr

    ShowShiftedDispersion(ctrlName,popNum,popStr)
	
	Variable ImageNameLength=strlen(popStr)
	String NameForDisp=popStr[0,ImageNameLength]
//	print NameforDisp
	
	
//	String Zero_kPosition="k0Position"+NameforDisp
	String Zero_kPosition="k0P1"+NameforDisp
	String Zero_kPositionError=	"k0PEr1"+NameforDisp
	String A_FWHM="FM1"+NameforDisp
	String A_FWHMError="FMEr1"+NameforDisp	
	String A_Energy="Ey"+NameforDisp
	String SE_Energy="SEEy_"+NameforDisp
	String ReSE="ReSE_"+NameforDisp
	String ReSEError="ReSEEr_"+NameforDisp
	String ImSE="ImSE_"+NameforDisp
	String ImSEError="ImSEEr_"+NameforDisp	
	Variable FitA=root:SelfEnergyFromMDC:FittedA
	Variable FitB=root:SelfEnergyFromMDC:FittedB
	Variable FitC=root:SelfEnergyFromMDC:FittedC
	
//	Print Zero_kPosition
	
	SetDataFolder root:Shifted_DispMDCWidth_1overA
	

	Variable  EnergyPointNumber=DimSize($A_Energy,0)
	Variable  MomentumPointNumber=DimSize($Zero_kPosition,0)	
	Variable  DataPointNumber=DimSize($A_Energy,0)
    Variable  EnergyStep=$A_Energy[1]-$A_Energy[0]	
    
//  Print "EnergyStep=", energyStep
	
	
	
	
	//Find k and E for the high BE point
	
       Variable HighBEEnergy=root:SelfEnergyFromMDC:Energy0Start
       Variable HighBEk
       Variable iHighBE=0
       Do 
       IF (1000*abs($A_Energy[iHighBE]-HighBEEnergy)<abs(EnergyStep)*1000*51/100)
       HighBEk=$Zero_kposition[iHighBE]
       Endif
       iHighBE+=1
       While(iHighBE<DataPointNumber)
//       Print "HigBEEnergy=",HighBEEnergy
//       Print "HighBEk=", HighBEk
	
	
	//Fing k and E for the near Ef point
	
       Variable NearEfEnergy=root:SelfEnergyFromMDC:Energy0End
       Variable NearEfk
       Variable iNearEf=0
       Do 
       IF (1000*abs($A_Energy[iNearEf]-NearEfEnergy)<abs(EnergyStep)*1000*51/100)
       NearEfk=$Zero_kposition[iNearEf]
       Endif
       iNearEf+=1
       While(iNearEf<DataPointNumber)
//       Print "NearEfEnergy=",NearEfEnergy
//       Print "NearEfk=", NearEfk	
	
	
	//Calculate Real part of Self-energy
	Make/O/N=(EnergyPointNumber) BareDispersion, RealSE, RealSEError,ImagSE, ImagSEError	
	
	IF (root:SelfEnergyFromMDC:WayForRealSE==0)	
	BareDispersion=FitA+FitB*($Zero_kPosition)+FitC*($Zero_kPosition)^2
	EndIF
	
	IF(root:SelfEnergyFromMDC:WayForRealSE==1)
	BareDispersion=NearEfEnergy+(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)*($Zero_kPosition-NearEfk)
	EndIF
	
//      String  TextBareDispersionLine="BareDisp Line:  E=" + num2str(NearEfEnergy-(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)*NearEfk) + Num2Str((HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)) +"*k"	
        String  TextBareDispersionLine="BareDisp Line:  E="  + Num2Str((HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)) +"*k"	

        Textbox/C/N=text1/A=RT  TextBareDispersionLine
	
//	Display BareDispersion vs $Zero_kPosition

	RealSE=($A_Energy-BareDispersion)*1000
	RealSEError=$Zero_kPositionError*(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)*1000


	  //Calculate Imaginary part of Self-Energy
	
      //Find Energy points for Typical energy positions
      
       Variable EnergyS1=root:SelfEnergyFromMDC:Energy1Start
       Variable EnergyE1=root:SelfEnergyFromMDC:Energy1End 
       Variable EnergyS2=root:SelfEnergyFromMDC:Energy2Start
       Variable EnergyE2=root:SelfEnergyFromMDC:Energy2End           
       Variable EnergyS3=root:SelfEnergyFromMDC:Energy3Start
       Variable EnergyE3=root:SelfEnergyFromMDC:Energy3End            
       Variable ES1,EE1,ES2,EE2,ES3,EE3
       Variable iEnergyP=0
       Do 

       IF (1000*abs($A_Energy[iEnergyP]-EnergyS1)<=abs(EnergyStep)*1000*51/100)
       ES1=iEnergyP
       Print "EnergyS1=", EnergyS1, "ES1=", iEnergyP
       Endif
       IF (1000*abs($A_Energy[iEnergyP]-EnergyE1)<=abs(EnergyStep)*1000*51/100)
       EE1=iEnergyP
       
       Print "EE1=", EE1
       Endif     
       
       IF (1000*abs($A_Energy[iEnergyP]-EnergyS2)<=abs(EnergyStep)*1000*51/100)
       ES2=iEnergyP
       Endif
       IF (1000*abs($A_Energy[iEnergyP]-EnergyE2)<=abs(EnergyStep)*1000*51/100)
       EE2=iEnergyP
       Endif   
       
       IF (1000*abs($A_Energy[iEnergyP]-EnergyS3)<=abs(EnergyStep)*1000*51/100)
       ES3=iEnergyP
       Endif
       IF (1000*abs($A_Energy[iEnergyP]-EnergyE3)<=abs(EnergyStep)*1000*51/100)
       EE3=iEnergyP
       Endif              
       
     
       iEnergyP+=1
       While(iEnergyP<DataPointNumber)	
	
       Print "ES1=", ES1, "EE1=", EE1	
	
	
	//Step 1:  Fit Dispersion at high BE with a line
	
//	Print ES1, EE1
//	Edit $A_Energy

////	CurveFit line, $Zero_kPosition(ES1, EE1) /X=$A_Energy /D
	CurveFit line, $A_Energy(ES1, EE1) /X=$Zero_kPosition /D	
	
	String FittedDispersionHighBE="fit_"+A_Energy
//	Display $FittedDispersionHighBE
	Duplicate/O $FittedDispersionHighBE TempVelocityHighBE
	Duplicate/O $FittedDispersionHighBE FittedHighBELine

	RemoveFromGraph/Z FittedHighBELine
	
	
	AppendToGraph/L=LDis/B=BDis FittedHighBELine		
////	 AppendToGraph/L=LDisp FittedHighBELine
     ModifyGraph rgb(FittedHighBELine)=(0,0,0)
     ModifyGraph lsize(FittedHighBELine)=2

		
////	Differentiate TempVelocityHighBE
////	Variable HighBEinVelocity=TempVelocityHighBE[0]
////	Variable HighBEVelocity=1/HighBEinVelocity
////	Variable  EoverkInter=-W_coef[0]/W_coef[1]
////	Variable EoverkSlope=1/W_coef[1]
        String  TextHighBELine="HighBE:  E=" + num2str(W_coef[0]) + "+"+Num2Str(W_coef[1]) +"*k"
//     String TextOne="HighBEVelocity= "+num2str(HighBEVelocity)+"eV*A"
    AppendText/N=text1   TextHighBELine	
    TextBox/C/N=text1/A=MB/X=1.06/Y=14.73
	
	//Step 2:  Fit Dispersion near EF with a line

	CurveFit line, $A_Energy(ES3, EE3) /X=$Zero_kPosition /D
	String FittedDispersionNearEf="fit_"+A_Energy
//	Display $FittedDispersionNearEf
	Duplicate/O $FittedDispersionNearEf TempVelocityNearEf
	Duplicate/O $FittedDispersionHighBE FittedNearEfLine

	RemoveFromGraph/Z FittedNearEfLine
////	AppendToGraph/L=LDisp FittedNearEfLine
	AppendToGraph/L=LDis/B=BDis FittedNearEfLine	
    ModifyGraph rgb(FittedNearEfLine)=(0,0,0)
    ModifyGraph lsize(FittedNearEfLine)=2
       
	Differentiate TempVelocityNearEf
	Variable NearEfinVelocity=TempVelocityNearEf[0]
	Variable NearEfVelocity=1/NearEfinVelocity
	
	Variable  EoverkEfInter=W_coef[0]
	Variable EoverkEfSlope=W_coef[1]
       String  TextNearEfLine="Near Ef:  E=" + num2str(EoverkEfInter) + "+" + Num2Str(EoverkEfSlope) +"*k"
//     String TextTwo="NearEfVelocity= "+num2str(NearEfVelocity)+"eV*A"
       AppendText/N=text1 TextNearEfLine
       
       
	RemoveFromGraph/Z $FittedDispersionNearEf  
	Killwaves/Z  $FittedDispersionNearEf    
       
       
       
       //Step 3:  Get coupling constant from BareDispersion/NearEfvelocity
       Variable CalculatedLamda=(HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk)/EoverkEfSlope-1
       String CalLamda="CalculatedLamda=" + num2Str(CalculatedLamda)
       AppendText/N=text1 CalLamda       
       
   
	
	//Step 4: Get the overall velocity wave and Imaginary part of Self Energy

	Make/O/N=(EnergyPointNumber) VelocityWave
	
	IF (root:SelfEnergyFromMDC:WayForImaginarySE==0)
	
	
		IF (root:SelfEnergyFromMDC:WayForRealSE==0)	
		VelocityWave=sqrt((FitB)^2-4*(FitA-($A_Energy))*FitC)
		EndIF
	
		IF(root:SelfEnergyFromMDC:WayForRealSE==1)
		VelocityWave=abs((HighBEEnergy-NearEfEnergy)/(HighBEk-NearEfk))
		EndIF	

	
	ImagSE=VelocityWave*root:Shifted_DispMDCWidth_1overA:$A_FWHM/2*1000
	ImagSEError=VelocityWave*root:Shifted_DispMDCWidth_1overA:$A_FWHMError/2*1000
		
	Endif	
	
	
	IF (root:SelfEnergyFromMDC:WayForImaginarySE==1)
	
	//Print "TO BE FINISHED >>>>>>>>>>>>"
	//string KKimagSE="KKImSE"+popStr
	//string dim_KKimagSE=dimsize(root:SelfEnergyFromMDC:$KKimagSE)
	//duplicate/O root:SelfEnergyFromMDC:$KKimagSE,ImagSE
	Endif
	

	Duplicate/O RealSE root:SelfEnergyFromMDC:$ReSE
	Duplicate/O RealSEError root:SelfEnergyFromMDC:$ReSEError	
	Duplicate/O ImagSE root:SelfEnergyFromMDC:$ImSE
	Duplicate/O ImagSEError root:SelfEnergyFromMDC:$ImSEError			
	Duplicate/O $A_Energy root:SelfEnergyFromMDC:$SE_Energy
	
	SetDataFolder root:SelfEnergyFromMDC


	
//	SEWindowName+="_"+Num2Str(abs(root:SelfEnergyFromMDC:Energy0Start)*1000)+"meV"
	DoWindow/K $ShiftWindowName     
	
	DoWindow $SEWindowName
	IF(V_flag==0)	
	Display/L=LRe $ReSE vs $SE_Energy
	ErrorBars $ReSE Y,wave=($ReSEError,$ReSEError)
	
	AppendToGraph/R=RIm $ImSE vs $SE_Energy
	ErrorBars $ImSE Y,wave=($ImSEError,$ImSEError)
	
	ModifyGraph mode($ReSE)=3,marker($ReSE)=19
	ModifyGraph mode($ImSE)=3,marker($ImSE)=19,rgb($ImSE)=(0,15872,65280)
	ModifyGraph mirror(bottom)=1
	ModifyGraph freePos(LRe)={root:MDCSpectra:DispersionEnergyStart,bottom}
	ModifyGraph freePos(RIm)={root:MDCSpectra:DispersionEnergyEnd,bottom}
	ModifyGraph margin(bottom)=62,margin(right)=62,margin(left)=62
	
	ModifyGraph tick=2,fStyle=1,axThick=2,standoff=0
    ModifyGraph width={Aspect,0.8}
    ModifyGraph height=380
	
	
    Label LRe "\\K(65280,0,0)\\F'Times New Roman'\\Z20\\f01Re(SE) (meV)"
	Label bottom "\\F'Times New Roman'\\Z20\\f01E - E\\BF \\M\\Z20(eV)"
    Label RIm "\\K(0,15872,65280)\\F'Times New Roman'\\Z20\\f01Im(SE) (meV)"
	ModifyGraph lblRot(RIm)=180
	ModifyGraph zero(LRe)=2
    ModifyGraph zero(bottom)=2
	ModifyGraph fSize=12
	Legend/N=text0/F=2/A=LB
	ShowInfo
	DoWindow/C $SEWindowName
	Else
	DoWindow/F $SEWindowName
	Endif
	
	
	ModifyGraph lblPos(LRe)=100
    ModifyGraph lblPos(RIm)=100
	
	
	
	root:SelfEnergyFromMDC:RealSEFileList=Wavelist("ReSE_*",";","DIMS:1")
	root:SelfEnergyFromMDC:ImaginarySEFileList=Wavelist("ImSE_*",";","DIMS:1")
	


    IF (root:SelfEnergyFromMDC:KKSEShowMode==1)		
		
    NKKGetRealFromImag(ctrlName,popNum,ImSEpopStr)
    NKKGetImagFromReal(ctrlName,popNum,ReSEpopStr) 
    
    String KKEnergy="KKEnergy_"+popStr
    String KKReSE="KKReSE_"+popStr
    String KKImSE="KKImSE_"+popStr

	DoWindow/F $SEWindowName
	AppendToGraph/L=LRe $KKReSE vs $KKEnergy
	AppendToGraph/R=RIm $KKImSE vs $KKEnergy
	SetAxis bottom $KKEnergy[0],0   
	ModifyGraph mode($KKReSE)=3,marker($KKReSE)=8;DelayUpdate
    ModifyGraph rgb($KKReSE)=(65280,0,0)
    
    ModifyGraph mode($KKImSE)=3,marker($KKImSE)=8;DelayUpdate
    ModifyGraph rgb($KKImSE)=(0,15872,65280)
    
    EndIF
	
	SetDataFolder Curr
	End




/////////////////////////////////////////////////////////////////////////
// (1). KK to get Imaginary Part from Real part: For all SE

	Proc NKKGetImagFromReal(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String Curr=GetDataFolder(1)
	Setdatafolder root:SelfEnergyFromMDC
	
	String SEWindowName="R2IKK_"+popStr
		
	RealSEFileList=Wavelist("ReSE_*",";","DIMS:1")
	ImaginarySEFileList=Wavelist("ImSE_*",";","DIMS:1")	
	
		
		
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"_",0)
	String NameForKKSE=popStr[5,ImageNameLength]
	
	String OriginalRealSE="ReSE_"+NameForKKSE
	string OriginalImSE="ImSE_"+NameForKKSE
	String OriginalEnergy="SEEnergy_"+NameForKKSE
	
	String KKImagSE="KKImSE_"+NameForKKSE
	String KKRealSE="KKReSE_"+NameForKKSE	
	string KKEnergy="KKEnergy_"+NameForKKSE
	
//  Display $OriginalRealSE vs $OriginalEnergy

	
	Duplicate/O $OriginalRealSE,realwave
//  Symmetrize the OriginalRealSE
	variable iE,RealSElength,xmin,xdelta
	xmin=$OriginalEnergy[0] 
	xdelta=$OriginalEnergy[1]-$OriginalEnergy[0]
	RealSElength=round((0-xmin)/xdelta)+1
	redimension/N=(2*RealSElength),realwave
	iE=RealSElength
	do
		realwave[iE]=realwave[2*RealSElength-iE-1]
		iE+=1
	while(iE<2*RealSElength)

//  Create a variable for the number of rows in the input wave
	Variable/D dimension=DimSize(realwave,0)

//  Creat the energy wave as x scale of KKIM
	duplicate/O realwave,$KKEnergy
	iE=0
	do
		$KKEnergy[iE]=xmin+(iE-1)*xdelta
		iE+=1
	while(iE<dimension)

// Create a complex wave with the input data in the real part,and zero's in the imaginary part
	Make/d/c/o/n=(dimension) input_cmplx=cmplx(realwave,0)
// Fast Fourrier Transform the complex input wave
	iFFT/c Input_cmplx
	input_cmplx[0]=0.5*input_cmplx[0]
	setscale/i x -0.5, 0.5, input_cmplx
//Now enforce causality by removing all 'values for times less than zero
	variable counter=0
	do
		if(pnt2x(input_cmplx,counter)>0)
			input_cmplx[counter]=0
		endif
		counter+=1
	While(counter<dimension)
// Fast Fourrier Transform back to E space
	FFT input_cmplx
	setscale/p x,0,1, input_cmplx
	input_cmplx*=2
// Make output waves for real and imaginary parts
	Make/d/o/n=(dimension) ioutput_real, ioutput_imag
//	copyscales $imagpartwave, ioutput_real, ioutput_imag
	Ioutput_real=real(input_cmplx)
	Ioutput_imag=-imag(input_cmplx)
	duplicate/O Ioutput_imag,$KKImagSE
	
	
//	Print "SEWindowName", SEWindowName
////	dowindow/F $SEWindowName
////	if(V_flag==0)
////		Display $OriginalRealSE vs $OriginalEnergy
////		Appendtograph  $OriginalImSE vs $OriginalEnergy	
////		Appendtograph $KKImagSE vs $KKEnergy
////		setaxis bottom,$KKEnergy[0],0
////		ModifyGraph width={Aspect,0.6667},gFont="Times New Roman"
////		ModifyGraph height=500
////		ModifyGraph fStyle=1,fSize=15
////		variable ioffset,ii=0
////		do
////			if(abs($KKEnergy[ii]+0.04)<=($KKEnergy[1]-$KKEnergy[0]))
////			ioffset=ii
////			endif
////			ii+=1
////		while(ii<dimension)
////		ModifyGraph offset($KKImagSE)={0,$OriginalImSE[ioffset]-$KKImagSE[ioffset]}
////		ModifyGraph mode($OriginalRealSE)=3,marker($OriginalRealSE)=8,rgb($OriginalRealSE)=(65280,0,0)
////		ModifyGraph mode=3,marker($OriginalImSE)=19, rgb($OriginalImSE)=(0,0,0)
////		ModifyGraph mode($KKImagSE)=3,marker($KKImagSE)=8,rgb($KKImagSE)=(0,15872,65280)
////		Legend/C/N=text0/F=0/A=MB
////		ModifyGraph tick=2,mirror=2,standoff=0;DelayUpdate
////        Label left "\\Z20 Self-Energy (meV)"
////        Label bottom "\\Z20E - E\\BF\\M\\Z20 (eV)"
////        ModifyGraph axThick=2
////	dowindow/C $SEWindowName
////	endif
	//differentcolorsino()
	//Updatelegendino(3)
	//modifyGraph mode($imagpartwave)=4,msize($imagpartwave)=1
	
	
//	Print "Get Imaginary from Real:  KK Transform"
	
	setdatafolder Curr	
END
	
	
	
	
	
///////////////////////////////////////////////////////////////////
//(2). KK to get Real Part from Imaginary part: for all SE 	
	
Proc  NKKGetRealFromImag(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String SEWindowName="I2RKK_"+popStr
	String Curr=GetDataFolder(1)
	setdatafolder root:SelfEnergyFromMDC
		
	RealSEFileList=Wavelist("ReSE_*",";","DIMS:1")
	ImaginarySEFileList=Wavelist("ImSE_*",";","DIMS:1")			
		
		
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"_",0)
	String NameForKKSE=popStr[5,ImageNameLength]
	
	String OriginalImSE="ImSE_"+NameForKKSE
	String OriginalImSEEr="ImSEEr_"+NameForKKSE
	string OriginalRealSE="ReSE_"+NameForKKSE
	string OriginalRealSEEr="ReSEEr_"+NameForKKSE	
	String OriginalEnergy="SEEnergy_"+NameForKKSE
	
	String KKRealSE="KKReSE_"+NameForKKSE
	string KKEnergy="KKEnergy_"+NameForKKSE
	
	//Display $OriginalRealSE vs $OriginalEnergy

	
	Duplicate/O $OriginalImSE,imagwave
//  Symmetrize the OriginalImagSE
	variable iE,ImagSElength,xmin,xdelta
	xmin=$OriginalEnergy[0] 
	xdelta=$OriginalEnergy[1]-$OriginalEnergy[0]
	ImagSElength=round((0-xmin)/xdelta)+1
	redimension/N=(2*ImagSElength),imagwave
	iE=ImagSElength
	do
		imagwave[iE]=imagwave[2*ImagSElength-iE-1]
		iE+=1
	while(iE<2*ImagSElength)




// Create a variable for the number of rows in the input wave
	Variable/D dimension=DimSize(imagwave,0)

// Creat the energy wave as x scale of KKIM
	Duplicate/O imagwave,$KKEnergy
	iE=0
	do
		$KKEnergy[iE]=xmin+(iE-1)*xdelta
		iE+=1
	while(iE<dimension)
	
//	Display ImagWave vs $KKEnergy

// Create a complex wave with the input data in the real part,and zero's in the imaginary part
	Make/d/c/o/n=(dimension) input_cmplx=cmplx(0,imagwave)
// Fast Fourrier Transform the complex input wave
	iFFT/c Input_cmplx
	input_cmplx[0]=0.5*input_cmplx[0]
	setscale/i x -0.5, 0.5, input_cmplx
//Now enforce causality by removing all 'values for times less than zero
	variable counter=0
	do
		if(pnt2x(input_cmplx,counter)>0)
			input_cmplx[counter]=0
		endif
		counter+=1
	While(counter<dimension)
// Fast Fourrier Transform back to E space
	FFT input_cmplx
	setscale/p x,0,1, input_cmplx
	input_cmplx*=2
// Make output waves for real and imaginary parts
	Make/d/o/n=(dimension) ioutput_real, ioutput_imag
//	copyscales $imagpartwave, ioutput_real, ioutput_imag
	Ioutput_real=-real(input_cmplx)
	Ioutput_imag=imag(input_cmplx)
	duplicate/O Ioutput_real,$KKRealSE
	
////	dowindow/F $SEWindowName
////	if(V_flag==0)
////		Display $OriginalImSE vs $OriginalEnergy
////		Appendtograph $OriginalRealSE vs $OriginalEnergy
////		Appendtograph $KKRealSE vs $KKEnergy

////		setaxis bottom,$KKEnergy[0],0
		
		
////		 ModifyGraph width={Aspect,0.6667}
////        ModifyGraph height=500,gFont="Times New Roman"
        
////        ModifyGraph fStyle=1,fSize=15,axThick=2
////        Label left "\\Z20Self Energy (meV)";DelayUpdate
////        Label bottom "\\Z20E - E\\BF\\M\\Z20 (eV)"
////		//variable ioffset,ii=0
		//do
		//	if(abs($KKEnergy[ii]+0.04)<=($KKEnergy[1]-$KKEnergy[0]))
		//	ioffset=ii
		//	endif
		//	ii+=1
		//while(ii<dimension)
		//ModifyGraph offset($KKImagSE)={0,$OriginalRealSE[ioffset]-$KKRealSE[ioffset]}
////		ModifyGraph mode($OriginalImSE)=3,marker($OriginalImSE)=19,rgb($OriginalImSE)=(0,0,0)
////		ModifyGraph mode($OriginalRealSE)=3,marker($OriginalRealSE)=8,rgb($OriginalRealSE)=(65280,0,0)
		
////		ModifyGraph mode($KKRealSE)=3,marker($KKRealSE)=8,rgb($KKRealSE)=(52224,0,41728)
////		Legend/C/N=text0/F=0/A=MB
////		ModifyGraph tick=2,mirror=2,standoff=0

////	dowindow/C $SEWindowName
////	endif
	//differentcolorsino()
	//Updatelegendino(3)
	//modifyGraph mode($imagpartwave)=4,msize($imagpartwave)=1
	
	
//	Print "Get reak from Imaginary:  KK Transform"
	
	setdatafolder Curr	
END









/////////////////////////////////////////////////////////////////////////
//(3). KK to get Imaginary Part from Real part: Seperate

	Proc KKGetImagFromReal(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String Curr=GetDataFolder(1)
	Setdatafolder root:SelfEnergyFromMDC
	
	String SEWindowName="R2IKK_"+popStr
		
	RealSEFileList=Wavelist("ReSE_*",";","DIMS:1")
	ImaginarySEFileList=Wavelist("ImSE_*",";","DIMS:1")	
	
		
		
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"_",0)
	String NameForKKSE=popStr[5,ImageNameLength]
	
	String OriginalRealSE="ReSE_"+NameForKKSE
	string OriginalImSE="ImSE_"+NameForKKSE
	String OriginalEnergy="SEEnergy_"+NameForKKSE
	
	String KKImagSE="KKImSE_"+NameForKKSE
	String KKRealSE="KKReSE_"+NameForKKSE	
	string KKEnergy="KKEnergy_"+NameForKKSE
	
//  Display $OriginalRealSE vs $OriginalEnergy

	
	Duplicate/O $OriginalRealSE,realwave
//  Symmetrize the OriginalRealSE
	variable iE,RealSElength,xmin,xdelta
	xmin=$OriginalEnergy[0] 
	xdelta=$OriginalEnergy[1]-$OriginalEnergy[0]
	RealSElength=round((0-xmin)/xdelta)+1
	redimension/N=(2*RealSElength),realwave
	iE=RealSElength
	do
		realwave[iE]=realwave[2*RealSElength-iE-1]
		iE+=1
	while(iE<2*RealSElength)

//  Create a variable for the number of rows in the input wave
	Variable/D dimension=DimSize(realwave,0)

//  Creat the energy wave as x scale of KKIM
	duplicate/O realwave,$KKEnergy
	iE=0
	do
		$KKEnergy[iE]=xmin+(iE-1)*xdelta
		iE+=1
	while(iE<dimension)

// Create a complex wave with the input data in the real part,and zero's in the imaginary part
	Make/d/c/o/n=(dimension) input_cmplx=cmplx(realwave,0)
// Fast Fourrier Transform the complex input wave
	iFFT/c Input_cmplx
	input_cmplx[0]=0.5*input_cmplx[0]
	setscale/i x -0.5, 0.5, input_cmplx
//Now enforce causality by removing all 'values for times less than zero
	variable counter=0
	do
		if(pnt2x(input_cmplx,counter)>0)
			input_cmplx[counter]=0
		endif
		counter+=1
	While(counter<dimension)
// Fast Fourrier Transform back to E space
	FFT input_cmplx
	setscale/p x,0,1, input_cmplx
	input_cmplx*=2
// Make output waves for real and imaginary parts
	Make/d/o/n=(dimension) ioutput_real, ioutput_imag
//	copyscales $imagpartwave, ioutput_real, ioutput_imag
	Ioutput_real=real(input_cmplx)
	Ioutput_imag=-imag(input_cmplx)
	duplicate/O Ioutput_imag,$KKImagSE
	
	
//	Print "SEWindowName", SEWindowName
	dowindow/F $SEWindowName
	if(V_flag==0)
		Display $OriginalRealSE vs $OriginalEnergy
		Appendtograph  $OriginalImSE vs $OriginalEnergy	
		Appendtograph $KKImagSE vs $KKEnergy
		setaxis bottom,$KKEnergy[0],0
		ModifyGraph width={Aspect,0.6667},gFont="Times New Roman"
		ModifyGraph height=380
		ModifyGraph fStyle=1,fSize=15
		variable ioffset,ii=0
		do
			if(abs($KKEnergy[ii]+0.04)<=($KKEnergy[1]-$KKEnergy[0]))
			ioffset=ii
			endif
			ii+=1
		while(ii<dimension)
		ModifyGraph offset($KKImagSE)={0,$OriginalImSE[ioffset]-$KKImagSE[ioffset]}
		ModifyGraph mode($OriginalRealSE)=3,marker($OriginalRealSE)=8,rgb($OriginalRealSE)=(65280,0,0)
		ModifyGraph mode=3,marker($OriginalImSE)=19, rgb($OriginalImSE)=(0,0,0)
		ModifyGraph mode($KKImagSE)=3,marker($KKImagSE)=8,rgb($KKImagSE)=(0,15872,65280)
		Legend/C/N=text0/F=0/A=MB
		ModifyGraph tick=2,mirror=2,standoff=0;DelayUpdate
        Label left "\\Z20 Self-Energy (meV)"
        Label bottom "\\Z20E - E\\BF\\M\\Z20 (eV)"
        ModifyGraph axThick=2
	dowindow/C $SEWindowName
	endif
	//differentcolorsino()
	//Updatelegendino(3)
	//modifyGraph mode($imagpartwave)=4,msize($imagpartwave)=1
	
	
//	Print "Get Imaginary from Real:  KK Transform"
	
	setdatafolder Curr	
END
	
	
	
	
	
///////////////////////////////////////////////////////////////////
//(4). KK to get Real Part from Imaginary part:Seperate	
	
Proc KKGetRealFromImag(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String SEWindowName="I2RKK_"+popStr
	String Curr=GetDataFolder(1)
	setdatafolder root:SelfEnergyFromMDC
		
	RealSEFileList=Wavelist("ReSE_*",";","DIMS:1")
	ImaginarySEFileList=Wavelist("ImSE_*",";","DIMS:1")			
		
		
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"_",0)
	String NameForKKSE=popStr[5,ImageNameLength]
	
	String OriginalImSE="ImSE_"+NameForKKSE
	String OriginalImSEEr="ImSEEr_"+NameForKKSE
	string OriginalRealSE="ReSE_"+NameForKKSE
	string OriginalRealSEEr="ReSEEr_"+NameForKKSE	
	String OriginalEnergy="SEEnergy_"+NameForKKSE
	
	String KKRealSE="KKReSE_"+NameForKKSE
	string KKEnergy="KKEnergy_"+NameForKKSE
	
	//Display $OriginalRealSE vs $OriginalEnergy

	
	Duplicate/O $OriginalImSE,imagwave
//  Symmetrize the OriginalImagSE
	variable iE,ImagSElength,xmin,xdelta
	xmin=$OriginalEnergy[0] 
	xdelta=$OriginalEnergy[1]-$OriginalEnergy[0]
	ImagSElength=round((0-xmin)/xdelta)+1
	redimension/N=(2*ImagSElength),imagwave
	iE=ImagSElength
	do
		imagwave[iE]=imagwave[2*ImagSElength-iE-1]
		iE+=1
	while(iE<2*ImagSElength)




// Create a variable for the number of rows in the input wave
	Variable/D dimension=DimSize(imagwave,0)

// Creat the energy wave as x scale of KKIM
	Duplicate/O imagwave,$KKEnergy
	iE=0
	do
		$KKEnergy[iE]=xmin+(iE-1)*xdelta
		iE+=1
	while(iE<dimension)
	
//	Display ImagWave vs $KKEnergy

// Create a complex wave with the input data in the real part,and zero's in the imaginary part
	Make/d/c/o/n=(dimension) input_cmplx=cmplx(0,imagwave)
// Fast Fourrier Transform the complex input wave
	iFFT/c Input_cmplx
	input_cmplx[0]=0.5*input_cmplx[0]
	setscale/i x -0.5, 0.5, input_cmplx
//Now enforce causality by removing all 'values for times less than zero
	variable counter=0
	do
		if(pnt2x(input_cmplx,counter)>0)
			input_cmplx[counter]=0
		endif
		counter+=1
	While(counter<dimension)
// Fast Fourrier Transform back to E space
	FFT input_cmplx
	setscale/p x,0,1, input_cmplx
	input_cmplx*=2
// Make output waves for real and imaginary parts
	Make/d/o/n=(dimension) ioutput_real, ioutput_imag
//	copyscales $imagpartwave, ioutput_real, ioutput_imag
	Ioutput_real=-real(input_cmplx)
	Ioutput_imag=imag(input_cmplx)
	duplicate/O Ioutput_real,$KKRealSE
	
	dowindow/F $SEWindowName
	if(V_flag==0)
		Display $OriginalImSE vs $OriginalEnergy
		Appendtograph $OriginalRealSE vs $OriginalEnergy
		Appendtograph $KKRealSE vs $KKEnergy

		setaxis bottom,$KKEnergy[0],0
		
		
		 ModifyGraph width={Aspect,0.6667}
        ModifyGraph height=380,gFont="Times New Roman"
        
        ModifyGraph fStyle=1,fSize=15,axThick=2
        Label left "\\Z20Self Energy (meV)";DelayUpdate
        Label bottom "\\Z20E - E\\BF\\M\\Z20 (eV)"
		//variable ioffset,ii=0
		//do
		//	if(abs($KKEnergy[ii]+0.04)<=($KKEnergy[1]-$KKEnergy[0]))
		//	ioffset=ii
		//	endif
		//	ii+=1
		//while(ii<dimension)
		//ModifyGraph offset($KKImagSE)={0,$OriginalRealSE[ioffset]-$KKRealSE[ioffset]}
		ModifyGraph mode($OriginalImSE)=3,marker($OriginalImSE)=19,rgb($OriginalImSE)=(0,0,0)
		ModifyGraph mode($OriginalRealSE)=3,marker($OriginalRealSE)=8,rgb($OriginalRealSE)=(65280,0,0)
		
		ModifyGraph mode($KKRealSE)=3,marker($KKRealSE)=8,rgb($KKRealSE)=(52224,0,41728)
		Legend/C/N=text0/F=0/A=MB
		ModifyGraph tick=2,mirror=2,standoff=0

	dowindow/C $SEWindowName
	endif
	//differentcolorsino()
	//Updatelegendino(3)
	//modifyGraph mode($imagpartwave)=4,msize($imagpartwave)=1
	
	
//	Print "Get reak from Imaginary:  KK Transform"
	
	setdatafolder Curr	
END

//	Proc KKGetRealFromImag(ctrlName,popNum,popStr) : PopupMenuControl
//	String ctrlName
//	Variable popNum
//	String popStr
//	String SEWindowName=	"KKSE_"+popStr
//	String Curr=GetDataFolder(1)
//
//	Print "Get Real from Imaginary: KK Transform"
//	
///	Variable ImageNameLength=strlen(popStr)
////	Variable Positionoft=strsearch(popStr,"_",0)
//	String NameForKKSE=popStr[5,ImageNameLength]
//
//	String OriginalImagSE="ImSE_"+NameForKKSE
//	String OriginalEnergy="SEEnergy_"+NameForKKSE
//	
//	Print NameForKKSE
//	
//	
//	String KKRealSE="KKReSE_"+NameForKKSE
//	
////	Display $OriginalImagSE vs $OriginalEnergy
	
//	Variable EStart, EEnd, ESize
//	ESize=DimSize($OriginalEnergy,0)
//	EStart= $OriginalEnergy[0]
//	EEnd=$OriginalEnergy[ESize-1]
///        Print ESize, EStart, EEnd
        
//Make/O/N=(ESize)  Imaginary, IntegrandIM, EnergyIM, KKReSE
//SetScale x EStart, EEnd, Imaginary, IntegrandIM, EnergyIM, KKReSE
//EnergyIM=x
//Imaginary=$OriginalImagSE


//Display Imaginary vs EnergyIM


//Variable jE=0
//Variable inter

//DO

//For a given E,  first get the intergrand
//inter=0
//Do

//IF (inter==jE)
//Integ1D_RE[inter]=Integ1D_RE[inter-1]
//IntegrandIM[inter]=(IntegrandIM[inter-1]+Imaginary[jE]/(EnergyIM[jE]-EnergyIM[inter+1]))
//Else
//IntegrandIM=Imaginary[jE]/(EnergyIM[jE]-EnergyIM[inter])
//ENDIF


//inter+=1
//While (inter<ESize)

//Then get the integration

//UEP1D_IM[jE]=-Pi*AreaXY(Ener1D,Integ1D_IM,ES,0)
//UEP1D_RE[jE]=AreaXY(Ener1D,Integ1D_RE,ES,0)

//KKReSE[jE]=1/Pi*AreaXY(EnergyIM,IntegrandIM,EStart,EEnd)

//jE+=1
//While(jE<ESize)


//Display KKReSE vs EnergyIM


	
	
//	END	
	
	


	
	Function NSECleanExit(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	//Kill Fitted Curves in root:Original_DispMDCWidth_1overA
	SetDataFolder root:Original_DispMDCWidth_1overA
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	
	DoWindow/K New_Self_Energy_Panel     
	
	SetDataFolder Curr
	
End
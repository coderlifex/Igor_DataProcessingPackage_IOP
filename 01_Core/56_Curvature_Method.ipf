//
//	function curvature_enhance
//
//	*Inputs*
//	inwave: 			a 2D wave that you want to artificially sharpen
//	newwavename:	name you choose for your output wave, must be enterred as a string with quotes
//	binx:			(binx = 1 is default) bins the data along the x-direction by this amount (must be an integer) before taking a derivative
//	biny:			(biny = 1 is default) bins the data along the y-direction
//	xtoggle:			xtoggle = 1 if you would like to sharpen along the x-direction, 0 otherwise
//	ytoggle:			ytoggle = 1 if you would like to sharpen along the y-direction, 0 otherwise
//	i0:				i0 is a constant that you have to adjust manually, perhaps start with .1 and multiply or divide by 10 to see an effect
//
//	*Outputs*
//	newwave:		an artificially sharpened 2D wave
//	inwave:			remains unchanged by this procedure



Proc Curvature_1DEDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	// variable   SmoothTimes=root:PROCESS:MDCSmoothingTimes
	 String Notation=popStr    
    Variable PFlag=root:PROCESS:ProcessedImageFlag
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Variable bindE=root:PROCESS:CurBindE
	Variable bindK=root:PROCESS:CurBindK
	Variable i0=root:PROCESS:Curbindi0/10000
	String Curvature_Image="E"+num2str(bindE)+num2str(bindK)+popStr

	Newdatafolder/O root:EKImage_Interpolated
	NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a
	Killwaves/A/Z
	Setdatafolder root:OriginalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName
	String GraphN="EDC"+"E"+num2str(bindE)+"K"+num2str(bindK)+popStr
	string PopStr1

	NewDatafolder/O root:DispersionFrom2ndDerivative:Curvature
	pauseupdate;silent 1
	ii=0
	do
		if(stringmatch(PopStr,ProcessedImage[ii]))
		Setdatafolder root:OriginalData
			
			TempPhi=Phi_Angle[ii]
			tempWavename=ProcessedImage[ii]
			//EKName="EK"+tempWaveName+"_PiOvera"
			//GraphN="Image"+tempWaveName+"PiOvera"
			
				if(tempPhi>90)
				tempPhi=180+tempPhi
				endif
			EKName="EK"+tempWaveName
			//GraphN="Image"+tempWaveName
			
			setdatafolder root:EKImage_Interpolated:Pi_over_a 
			duplicate/O root:PROCESS:$TempWaveName,tempImage
			Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
			Make/O/N=(Dimsize(tempImage,0)) EE
			
			PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
			MinE=leftx(TempImage)
			MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			SetScale/I x MinE,MaxE,"", EE
			EE=x
			MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=0.5118*LatticeConstant/pi*MaxK
			MinK=0.5118*LatticeConstant/pi*MinK
			SetScale/I x MinK,MaxK,"", KK
			Variable DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
			//print deltaK
			kk=x
			Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
			jj=0
			Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
			PhiAngle=tempPhi-PhiOffset-PhiAngle
			do
				MDCIntensity=TempImage[jj][p]
				MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
				Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
				lowKn=round((MDCKp[0]-kk[0])/deltaK)
				HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				tempMDC[0,highkn-1]=tempMDC[highkn]
				tempMDC[lowkn+1,dimsize(tempMDC,0)]=tempMDC[lowkn]
				$EKName[][jj]=TempMDC[p]
				SetScale/I x minK,maxk,"", $EKName
				if(tempPhi>90)
				SetScale/I x -minK,-maxk,"", $EKName
				endif
				
				SetScale/I y minE,maxE,"", $EKName
				jj=jj+1
			while(jj<Dimsize(TempImage,0))
//			dowindow/K $GraphN
//			Display/N=$GraphN
//			AppendImage $EKName;
//			ModifyImage $EKName ctab= {*,*,PlanetEarth,1}
//			ModifyGraph fStyle=1,fSize=14,axThick=1.5,standoff=0;
//			Label left "\Z20E-E\\BF \\M(eV)";DelayUpdate
////			Label bottom "\Z20k\\B// \\M(\\F'Symbol'p/\\F'Arial'a)"
//			ModifyGraph tick=2
//			ModifyGraph margin(left)=50, margin(bottom)=45, margin(top)=7,margin(right)=7
//			ModifyGraph width=226.772
//			ModifyGraph height=425.197
//			ModifyGraph zero(left)=4

			setdatafolder root:EKImage_Interpolated:Pi_over_a
			PopStr1="EK"+popStr
			Duplicate/o $popStr1, root:DispersionFrom2ndDerivative:Curvature:$Curvature_Image
			killwaves/A/Z
			
			Break
		endif
		ii=ii+1
	while(ii<loops)
	
	//NewDatafolder/O/S root:DispersionFromCurvatureImage
	//NewDatafolder/O/S root:DispersionFrom2ndDerivative:Curvature
	setdatafolder root:DispersionFrom2ndDerivative:Curvature
	//string PopStr1="EK"+popStr+"_PiOVera"
	//string PopStr1="EK"+popStr
	
	
	//GraphN=Curvature_Image
	
//	Duplicate/o root:EKImage_Interpolated:Pi_over_a:$popStr1, $Curvature_Image
	Duplicate/o $Curvature_Image, tempt
		
	//SetDataFolder root:DispersionFrom2ndDerivative:Curvature
	pauseupdate;silent 1
	
	curvature_enhance(tempt,Curvature_Image,bindE,bindK,0,1,i0)
	wavestats/Q $Curvature_Image
	$Curvature_Image=$Curvature_Image/V_max	
	//differentiate/Dim=0 $SecondDImage
	//differentiate/Dim=0 $SecondDImage
	//smooth/E=2/Dim=0 smoothtimes,$SecondDImage
		
	DoWindow $GraphN
    if(V_flag==0)  
    Display/K=1          
	AppendImage $Curvature_Image	
	DoWindow/C $GraphN
	else
	DoWindow/F $GraphN
	endif
	//Textbox/N=text0/F=0/A=MT Notation  
   	ModifyImage $Curvature_Image ctab= {0,0.6,PlanetEarth,1}
    ModifyGraph standoff=0
    ModifyGraph zero(left)=3
    Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
    ModifyGraph width=180
    ModifyGraph height={Aspect,1.8}
    ModifyGraph margin(left)=26
    ModifyGraph margin(right)=5
    ModifyGraph margin(top)=5
    
                
	KillWaves/Z tempt

END








Proc Curvature_1DMDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	// variable   SmoothTimes=root:PROCESS:MDCSmoothingTimes
	 String Notation=popStr    
    Variable PFlag=root:PROCESS:ProcessedImageFlag
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Variable bindE=root:PROCESS:CurBindE
	Variable bindK=root:PROCESS:CurBindK
	Variable i0=root:PROCESS:Curbindi0/10000
	String Curvature_Image="M"+num2str(bindE)+num2str(bindK)+popStr
	NewDatafolder/O root:DispersionFrom2ndDerivative:Curvature
	Newdatafolder/O root:EKImage_Interpolated
	NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a
	Killwaves/A/Z
	Setdatafolder root:OriginalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName
	String GraphN="MDC"+"E"+num2str(bindE)+"K"+num2str(bindK)+popStr
	string PopStr1

	
	pauseupdate;silent 1
	ii=0
	do
		if(stringmatch(PopStr,ProcessedImage[ii]))
		Setdatafolder root:OriginalData
			
			TempPhi=Phi_Angle[ii]
			tempWavename=ProcessedImage[ii]
			//EKName="EK"+tempWaveName+"_PiOvera"
			//GraphN="Image"+tempWaveName+"PiOvera"
			
				if(tempPhi>90)
				tempPhi=180+tempPhi
				endif
			EKName="EK"+tempWaveName
			//GraphN="Image"+tempWaveName
			
			setdatafolder root:EKImage_Interpolated:Pi_over_a 
			duplicate/O root:PROCESS:$TempWaveName,tempImage
			Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
			Make/O/N=(Dimsize(tempImage,0)) EE
			
			PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
			MinE=leftx(TempImage)
			MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			SetScale/I x MinE,MaxE,"", EE
			EE=x
			MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=0.5118*LatticeConstant/pi*MaxK
			MinK=0.5118*LatticeConstant/pi*MinK
			SetScale/I x MinK,MaxK,"", KK
			Variable DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
			//print deltaK
			kk=x
			Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
			jj=0
			Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
			PhiAngle=tempPhi-PhiOffset-PhiAngle
			do
				MDCIntensity=TempImage[jj][p]
				MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
				Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
				lowKn=round((MDCKp[0]-kk[0])/deltaK)
				HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				tempMDC[0,highkn-1]=tempMDC[highkn]
				tempMDC[lowkn+1,dimsize(tempMDC,0)]=tempMDC[lowkn]
				$EKName[][jj]=TempMDC[p]
				SetScale/I x minK,maxk,"", $EKName
				if(tempPhi>90)
				SetScale/I x -minK,-maxk,"", $EKName
				endif
				
				SetScale/I y minE,maxE,"", $EKName
				jj=jj+1
			while(jj<Dimsize(TempImage,0))
//			dowindow/K $GraphN
//			Display/N=$GraphN
//			AppendImage $EKName;
//			ModifyImage $EKName ctab= {*,*,PlanetEarth,1}
//			ModifyGraph fStyle=1,fSize=14,axThick=1.5,standoff=0;
//			Label left "\Z20E-E\\BF \\M(eV)";DelayUpdate
////			Label bottom "\Z20k\\B// \\M(\\F'Symbol'p/\\F'Arial'a)"
//			ModifyGraph tick=2
//			ModifyGraph margin(left)=50, margin(bottom)=45, margin(top)=7,margin(right)=7
//			ModifyGraph width=226.772
//			ModifyGraph height=425.197
//			ModifyGraph zero(left)=4

			setdatafolder root:EKImage_Interpolated:Pi_over_a
			PopStr1="EK"+popStr
			Duplicate/o $popStr1, root:DispersionFrom2ndDerivative:Curvature:$Curvature_Image
			killwaves/A/Z
			
			Break
		endif
		ii=ii+1
	while(ii<loops)
	
	//NewDatafolder/O/S root:DispersionFromCurvatureImage
	setdatafolder root:DispersionFrom2ndDerivative:Curvature

	//string PopStr1="EK"+popStr+"_PiOVera"
	//string PopStr1="EK"+popStr
	
	
	//GraphN=Curvature_Image
	
//	Duplicate/o root:EKImage_Interpolated:Pi_over_a:$popStr1, $Curvature_Image
	Duplicate/o $Curvature_Image, tempt
		
	//SetDataFolder root:DispersionFrom2ndDerivative:Curvature
	pauseupdate;silent 1
	
	curvature_enhance(tempt,Curvature_Image,bindE,bindK,1,0,i0)
	wavestats/Q $Curvature_Image
	$Curvature_Image=$Curvature_Image/V_max	
	//differentiate/Dim=0 $SecondDImage
	//differentiate/Dim=0 $SecondDImage
	//smooth/E=2/Dim=0 smoothtimes,$SecondDImage
		
	DoWindow $GraphN
    if(V_flag==0)  
    Display/K=1          
	AppendImage $Curvature_Image	
	DoWindow/C $GraphN
	else
	DoWindow/F $GraphN
	endif
	//Textbox/N=text0/F=0/A=MT Notation  
   	ModifyImage $Curvature_Image ctab= {0,0.6,PlanetEarth,1}
    ModifyGraph standoff=0
    ModifyGraph zero(left)=3
    Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
    ModifyGraph width=180
    ModifyGraph height={Aspect,1.8}
    ModifyGraph margin(left)=26
    ModifyGraph margin(right)=5
    ModifyGraph margin(top)=5
    
                
	KillWaves/Z tempt

END







Proc Curvature_2D(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	// variable   SmoothTimes=root:PROCESS:MDCSmoothingTimes
	 String Notation=popStr    
    Variable PFlag=root:PROCESS:ProcessedImageFlag
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable PhiOffset=root:PROCESS:PhiOffset
	Variable bindE=root:PROCESS:CurBindE
	Variable bindK=root:PROCESS:CurBindK
	Variable i0=root:PROCESS:Curbindi0/10000
	String Curvature_Image="T"+num2str(bindE)+num2str(bindK)+popStr
	NewDatafolder/O root:DispersionFrom2ndDerivative:Curvature
	Newdatafolder/O root:EKImage_Interpolated
	NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a
	Killwaves/A/Z
	Setdatafolder root:OriginalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName
	String GraphN="C2D"+"E"+num2str(bindE)+"K"+num2str(bindK)+popStr
	string PopStr1

	
	pauseupdate;silent 1
	ii=0
	do
		if(stringmatch(PopStr,ProcessedImage[ii]))
		Setdatafolder root:OriginalData
			
			TempPhi=Phi_Angle[ii]
			tempWavename=ProcessedImage[ii]
			//EKName="EK"+tempWaveName+"_PiOvera"
			//GraphN="Image"+tempWaveName+"PiOvera"
			
				if(tempPhi>90)
				tempPhi=180+tempPhi
				endif
			EKName="EK"+tempWaveName
			//GraphN="Image"+tempWaveName
			
			setdatafolder root:EKImage_Interpolated:Pi_over_a 
			duplicate/O root:PROCESS:$TempWaveName,tempImage
			Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
			Make/O/N=(Dimsize(tempImage,0)) EE
			
			PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
			MinE=leftx(TempImage)
			MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
			SetScale/I x MinE,MaxE,"", EE
			EE=x
			MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
			MaxK=0.5118*LatticeConstant/pi*MaxK
			MinK=0.5118*LatticeConstant/pi*MinK
			SetScale/I x MinK,MaxK,"", KK
			Variable DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
			//print deltaK
			kk=x
			Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
			jj=0
			Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
			PhiAngle=tempPhi-PhiOffset-PhiAngle
			do
				MDCIntensity=TempImage[jj][p]
				MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
				Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
				lowKn=round((MDCKp[0]-kk[0])/deltaK)
				HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
				tempMDC[0,highkn-1]=tempMDC[highkn]
				tempMDC[lowkn+1,dimsize(tempMDC,0)]=tempMDC[lowkn]
				$EKName[][jj]=TempMDC[p]
				SetScale/I x minK,maxk,"", $EKName
				if(tempPhi>90)
				SetScale/I x -minK,-maxk,"", $EKName
				endif
				
				SetScale/I y minE,maxE,"", $EKName
				jj=jj+1
			while(jj<Dimsize(TempImage,0))
//			dowindow/K $GraphN
//			Display/N=$GraphN
//			AppendImage $EKName;
//			ModifyImage $EKName ctab= {*,*,PlanetEarth,1}
//			ModifyGraph fStyle=1,fSize=14,axThick=1.5,standoff=0;
//			Label left "\Z20E-E\\BF \\M(eV)";DelayUpdate
////			Label bottom "\Z20k\\B// \\M(\\F'Symbol'p/\\F'Arial'a)"
//			ModifyGraph tick=2
//			ModifyGraph margin(left)=50, margin(bottom)=45, margin(top)=7,margin(right)=7
//			ModifyGraph width=226.772
//			ModifyGraph height=425.197
//			ModifyGraph zero(left)=4

			setdatafolder root:EKImage_Interpolated:Pi_over_a
			PopStr1="EK"+popStr
			Duplicate/o $popStr1, root:DispersionFrom2ndDerivative:Curvature:$Curvature_Image
			killwaves/A/Z
			
			Break
		endif
		ii=ii+1
	while(ii<loops)
	
	//NewDatafolder/O/S root:DispersionFromCurvatureImage
	setdatafolder root:DispersionFrom2ndDerivative:Curvature

	//string PopStr1="EK"+popStr+"_PiOVera"
	//string PopStr1="EK"+popStr
	
	
	//GraphN=Curvature_Image
	
//	Duplicate/o root:EKImage_Interpolated:Pi_over_a:$popStr1, $Curvature_Image
	Duplicate/o $Curvature_Image, tempt
		
	//SetDataFolder root:DispersionFrom2ndDerivative:Curvature
	pauseupdate;silent 1
	
	curvature_enhance(tempt,Curvature_Image,bindE,bindK,1,1,i0)
	wavestats/Q $Curvature_Image
	$Curvature_Image=$Curvature_Image/V_max	
	//differentiate/Dim=0 $SecondDImage
	//differentiate/Dim=0 $SecondDImage
	//smooth/E=2/Dim=0 smoothtimes,$SecondDImage
		
	DoWindow $GraphN
    if(V_flag==0)  
    Display/K=1          
	AppendImage $Curvature_Image	
	DoWindow/C $GraphN
	else
	DoWindow/F $GraphN
	endif
	//Textbox/N=text0/F=0/A=MT Notation  
   	ModifyImage $Curvature_Image ctab= {0,0.6,PlanetEarth,1}
    ModifyGraph standoff=0
    ModifyGraph zero(left)=3
    Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
    ModifyGraph width=180
    ModifyGraph height={Aspect,1.8}
    ModifyGraph margin(left)=26
    ModifyGraph margin(right)=5
    ModifyGraph margin(top)=5
    
                
	KillWaves/Z tempt

END



End


function curvature_enhance(inwave, newwavename, binx, biny, xtoggle,ytoggle,i0)
	wave inwave
	variable binx, biny, xtoggle, ytoggle, i0
	string newwavename
	bin2dSC7(inwave, newwavename, binx, biny)
	
	wave newwave = $newwavename
	if((xtoggle==1)&&(ytoggle==1))
	
		string newwavenameddx = newwavename+"_ddx"
		duplicate/o newwave $newwavenameddx
		wave newwaveddx = $newwavenameddx
		differentiate/dim=0 newwave/d=$newwavenameddx
		
		string newwavenameddy = newwavename+"_ddy"
		duplicate/o newwave $newwavenameddy
		wave newwaveddy = $newwavenameddy
		differentiate/dim=1 newwave/d=$newwavenameddy
		
		string newwavenamed2dy2 = newwavename+"_d2dy2"
		duplicate/o newwave $newwavenamed2dy2
		wave newwaved2dy2 = $newwavenamed2dy2
		differentiate/dim=1 newwave/d=$newwavenamed2dy2
		differentiate/dim=1 $newwavenamed2dy2
		
		string newwavenamed2dx2 = newwavename+"_d2dx2"
		duplicate/o newwave $newwavenamed2dx2
		wave newwaved2dx2 = $newwavenamed2dx2
		differentiate/dim=0 newwave/d=$newwavenamed2dx2
		differentiate/dim=0 $newwavenamed2dx2
		
		string newwavenamed2dydx = newwavename+"_d2dydx"
		duplicate/o newwave $newwavenamed2dydx
		wave newwaved2dydx = $newwavenamed2dydx
		//differentiate/dim=0 newwave/d=$newwavenamed2dydx
		//differentiate/dim=1 newwave/d=$newwavenamed2dydx
		differentiate/dim=0 newwave/d=$newwavenamed2dydx
		differentiate/dim=1 $newwavenamed2dydx		
		//Differentiate/DIM=0  test/D=test_DIF
		
		variable Cy = i0^2
		variable Cx = i0^2*(dimdelta(newwave,0)/dimdelta(newwave,1))^2
	
		newwave = -((1+Cx*newwaveddx^2)*Cy*newwaved2dy2 - 2*Cx*Cy*newwaveddx*newwaveddy*newwaved2dydx + (1+Cy*newwaveddy^2)*Cx*newwaved2dx2) / (1+Cx*newwaveddx^2+Cy*newwaveddx^2)^(3/2)
		killwaves/Z newwaveddx newwaveddy newwaved2dx2 newwaved2dy2 newwaved2dydx
//		newwave = newwave[p][q]<0 ? 0 : newwave[p][q]
	elseif(((xtoggle==1)&&(ytoggle==0))||((xtoggle==0)&&(ytoggle==1)))
		string newwavenamederiv1 = newwavename+"_deriv1"
		duplicate/o newwave $newwavenamederiv1
		wave newwavederiv1 = $newwavenamederiv1
		if(xtoggle==1)
			differentiate/dim=0 newwave/d=$newwavenamederiv1
		else
			differentiate/dim=1 newwave/d=$newwavenamederiv1
		endif
		
		string newwavenamederiv2 = newwavename+"_deriv2"
		duplicate/o newwave $newwavenamederiv2
		wave newwavederiv2 = $newwavenamederiv2
		if(xtoggle==1)
			differentiate/dim=0 newwave/d=$newwavenamederiv2
			differentiate/dim=0 $newwavenamederiv2
		else
			differentiate/dim=1 newwave/d=$newwavenamederiv2
			differentiate/dim=1 $newwavenamederiv2
		endif

		newwave = -newwavederiv2/(1+i0^2*newwavederiv1^2)^(3/2)
		killwaves/Z newwavederiv1 newwavederiv2
//		newwave = newwave[p][q]<0 ? 0 : newwave[p][q]  //we only care about positive values, but i think this makes the image quality worse so i commented it out
	else
		print("David error, wrong toggle")
	endif
end





function bin2dEX7(inwave, newwavename,binx,biny)
	wave inwave
	string newwavename
	variable binx, biny
	make/o/n=(floor(dimsize(inwave,0)/binx),floor(dimsize(inwave,1)/biny)) $newwavename
	wave newwave = $newwavename
	setscale/p x, dimoffset(inwave,0), dimdelta(inwave,0)*binx, $newwavename
	setscale/p y, dimoffset(inwave,1), dimdelta(inwave,1)*biny, $newwavename
	newwave=0
	variable i,j
	for(i=0; i<binx; i+=1)
		for(j=0; j<biny; j+=1)
			newwave[][]+=inwave[binx*p+i][biny*q+j]
		endfor
	endfor
end


function bin2dSC7(inwave, newwavename,binx,biny)
	wave inwave
	string newwavename
	variable binx, biny
	duplicate/o inwave,$newwavename
	wave newwave = $newwavename
	//setscale/p x, dimoffset(inwave,0), dimdelta(inwave,0)*binx, $newwavename
	//setscale/p y, dimoffset(inwave,1), dimdelta(inwave,1)*biny, $newwavename
	newwave=0
	variable i,j
	for(i=0; i<binx; i+=1)
		for(j=0; j<biny; j+=1)
			newwave[][]+=inwave[p+i-round(binx/2)][q+j-round(biny/2)]
			
		endfor
	endfor
end
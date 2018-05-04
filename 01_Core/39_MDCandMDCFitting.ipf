#pragma rtGlobals=1		// Use modern global access method.
Proc MDC_Fitting_XJIOP()
	Pauseupdate;Silent 1
	dowindow/F MDC_Fitting_Panel
	if(V_Flag==0)
	NewDataFolder/O/S root:TempVariable
	Newdatafolder/O/S root:TempVariable:MDCandMDCFitting
	Variable/G OffSet
	Variable/G Bind
	Variable/G EStart
	Variable/G EEnd
	Variable/G KStart
	Variable/G KEnd
	Variable/G BareBand_a
	//Variable/G BareBand_b
	Variable/G Z1
	Variable/G Z2
	Variable/G Phi1
	Variable/G Phi2
	Variable/G BareBandL
	Variable/G BareBandTJ
	Variable/G BackGround
	Variable/G Intensity
	Variable/G KFValue
	//Variable/G K0_tj
	Variable/G K1
	Variable/G K2
	//Variable/G a0
	//Variable
	Make/T/O/N=0 AllWaves
	Make/O/N=0 SelWaves
	setdatafolder root:OriginalData
	String tempWaveName
	variable Flag=root:PROCESS:ProcessedImageFlag
	variable ii,DIM
	DIM=Dimsize(ProcessFlag,0)
	ii=0
	do
		setdatafolder root:OriginalData
		if(ProcessFlag[ii]==Flag)
			tempWaveName=ProcessedImage[ii]
			setdatafolder root:TempVariable:MDCandMDCFitting
			insertpoints Dimsize(AllWaves,0),1,AllWaves,SelWaves
			Allwaves[Dimsize(allWaves,0)-1]=tempWaveName
			SelWaves=0
		endif
		ii=ii+1
	while(ii<DIM)
	setdatafolder root:TempVariable:MDCandMDCFitting
	selWaves[0]=1
	MDC_Fitting_Panel_XJIOP()
	if(BareBandL)
		//GroupBox BareBand_G,size={205,75}
		checkbox barebandtj,pos={190,250}
		SetVariable a0,Pos={200,230},size={80,15},disable=0
		//setvariable a0,disable=0
		setvariable K1,Pos={300,230},size={80,15},disable=1
		//setvariable K0,disable=1
		//setvariable K1,disable=1
		setvariable K2,disable=1
		//Button FitMDC_B,Pos={290,275}
		//Button ShowMDCFitFunc_B,pos={195,275}
		//GroupBox MDCFitting_G,size={215,190}
	endif
	if(BareBandTJ)
		checkbox barebandtj,pos={190,230}
		//GroupBox BareBand_G,size={205,55}
		//checkbox barebandtj,pos={190,230}
		SetVariable a0,Pos={200,250},size={60,15},disable=1
		//setvariable b0,disable=1
		//setvariable K0,disable=0
		setvariable K1,Pos={262,250},size={60,15},disable=0
		setvariable K2,Pos={324,250},disable=0
	endif
	ListBox ALLWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	endif
end

Window MDC_Fitting_Panel_XJIOP():Panel
	PauseUpdate;Silent 1
	NewPanel/K=1/W=(800,100,1195,405) as "MDC and MDC fitting"
	ModifyPanel fixedSize=1,framestyle=1
	DrawText 1,18,"Select for Extracting MDC"
	ListBox ALLWaves_L frame= 4,pos={1,20},size={175,285}
	GroupBox MDCStack_G,Pos={180,10},size={215,105},title="MDC Stack",font="Arial",fSize=10,fStyle=2,labelBack=(50000,50000,50000)
	SetVariable EStart, Pos={185,25},Value=root:TempVariable:MDCandMDCFitting:EStart,limits={-10,0.2,0.001},size={100,15},title="E Start"
	SetVariable EEnd, Pos={290,25},Value=root:TempVariable:MDCandMDCFitting:EEnd,limits={-10,0.2,0.001},size={100,15},title="E End"
	SetVariable KStart, Pos={185,45},Value=root:TempVariable:MDCandMDCFitting:KStart,limits={-2,2,0.001},size={100,15},title="K Start"
	SetVariable KEnd, Pos={290,45},Value=root:TempVariable:MDCandMDCFitting:KEnd,limits={-2,2,0.001},size={100,15},title="K End"
	SetVariable Offset, Pos={185,65},Value=root:TempVariable:MDCandMDCFitting:Offset,limits={-1000,1000,5},size={100,15},title="OffSet "
	SetVariable Bind, Pos={290,65},Value=root:TempVariable:MDCandMDCFitting:Bind,limits={-1000,1000,2},size={100,15},title="BinD  "
	SetVariable KF, Pos={185,90},Value=root:TempVariable:MDCandMDCFitting:KFValue,limits={-1000,1000,2},size={100,15},title="K\BF"
	Button ShowMDC_B,pos={290,85},size={100,25},title="Show MDC",proc=ShowMDC_MDCFitting_XJIOP//,valueColor=(65535,0,0)
	
	GroupBox MDCFitting_G,Pos={180,115},size={215,190},title="MDC Fitting",font="Arial",fSize=10,fStyle=2,labelBack=(50000,50000,50000)
	SetVariable Intensity, Pos={185,130},Value=root:TempVariable:MDCandMDCFitting:Intensity,limits={0,10000,50},size={100,15},title="HIGHT"
	SetVariable Background, Pos={290,130},Value=root:TempVariable:MDCandMDCFitting:BackGround,limits={0,100,10},size={100,15},title="BKGD"
	SetVariable Z1, Pos={185,150},Value=root:TempVariable:MDCandMDCFitting:Z1,limits={-2000,2000,0.001},size={100,15},title="Z1"
	SetVariable Z2, Pos={290,150},Value=root:TempVariable:MDCandMDCFitting:Z2,limits={-2000,2000,0.001},size={100,15},title="Z2"
	SetVariable Phi1, Pos={185,170},Value=root:TempVariable:MDCandMDCFitting:Phi1,limits={-1000,1000,5},size={100,15},title="\F'Symbol'f\B1"
	SetVariable Phi2, Pos={290,170},Value=root:TempVariable:MDCandMDCFitting:Phi2,limits={-1000,1000,2},size={100,15},title="\F'Symbol'f\B2"
	GroupBox BareBand_G,Pos={185,195},size={205,78},title="BareBand",font="Arial",fSize=10,fStyle=2//,labelBack=(50000,50000,50000)
	CheckBox BareBandL,pos={190,210},size={60,14},proc=BareBand_Radio_XJIOP,title="Linear BareBand"
	CheckBox BareBandL,variable=root:TempVariable:MDCandMDCFitting:BareBandL,mode=1
	CheckBox BareBandTJ,pos={190,230},size={60,14},proc=BareBand_Radio_XJIOP,title="t-J BareBand"
	CheckBox BareBandTJ,variable=root:TempVariable:MDCandMDCFitting:BareBandTJ,mode=1
	SetVariable a0, Pos={200,230},Value=root:TempVariable:MDCandMDCFitting:BareBand_a,limits={-10,10,0.001},size={80,15},title="K\BF",disable=1
	//SetVariable b0, Pos={300,230},Value=root:TempVariable:MDCandMDCFitting:K1,limits={-10,10,0.001},size={80,15},title="b",disable=1
	//SetVariable K0, Pos={200,250},Value=root:TempVariable:MDCandMDCFitting:K0_tj,limits={-10,10,0.001},size={60,15},title="K0",disable=1
	SetVariable K1, Pos={260,250},Value=root:TempVariable:MDCandMDCFitting:K1,limits={-10,10,0.001},size={60,15},title="K1",disable=1
	SetVariable K2, Pos={320,250},Value=root:TempVariable:MDCandMDCFitting:K2,limits={-10,10,0.001},size={60,15},title="K2",disable=1
	Button ShowMDCFitFunc_B,pos={195,275},size={90,25},title="Show Fit Func",proc=ShowFitFunction_MDC_XJIOP
	Button FitMDC_B,pos={290,275},size={90,25},title="MDC Fitting",proc=Fit_MDCFitting_XJIOP//,valueColor=(65535,0,0)
end

Proc ShowFitFunction_MDC_XJIOP(CtrlName):Buttoncontrol
	String CtrlName
	Variable BareBand_a=root:TempVariable:MDCandMDCFitting:BareBand_a
	//Variable BareBand_b=root:TempVariable:MDCandMDCFitting:BareBand_b
	Variable Z1=root:TempVariable:MDCandMDCFitting:Z1
	Variable Z2=root:TempVariable:MDCandMDCFitting:Z2
	Variable Phi1=root:TempVariable:MDCandMDCFitting:PHi1
	Variable Phi2=root:TempVariable:MDCandMDCFitting:PHi2
	variable Intensity=root:TempVariable:MDCandMDCFitting:Intensity
	Variable BackGround=root:TempVariable:MDCandMDCFitting:BackGround
	Variable BareBandTJ=root:TempVariable:MDCandMDCFitting:BareBandTJ
	Variable BareBandL=root:TempVariable:MDCandMDCFitting:BareBandL
	//print k0
	String MDCList=TraceNameList("",";",1)
	String TempMDCName=StringFromList(0,MDCList,";")
	tempMDCName="aa"+TempMDCName
	TempMDCName=stringbykey("aa",TempMDCNAMe,"'","'")
	String TempKName=XWaveName("",TempMDCName)
	
	Variable ii=0
	String TempWaveName
	setdatafolder root:TempVariable:MDCandMDCFitting
	do
		if(SelWaves[ii]!=0)
			TempWaveName=AllWaves[ii]
			Break
		endif
		ii=ii+1
	while(ii<DimSize(Allwaves,0))
	//print TempWaveNAme
	TempWaveName="MDC_"+TempWaveName
	setdatafolder root:MDCandMDCFitting:$TempWaveName
	make/O/N=(Dimsize($TempKName,0)) FitFunc
	//make/O/N=500 FitFunc
	//SetScale/I x -1,1,"", FitFunc
	if(BareBandL)
		Make/O/N=8 C
		C[0]=Intensity
		C[1]=BackGround
		C[2]=Z1
		C[3]=Z2
		C[4]=PHi1
		C[5]=Phi2
		C[6]=BareBand_a
		C[7]=K1
		//FitFunc=C[1]+C[0]*((c[2]+C[6]+C[7]*$TempKName)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[6]+C[7]*$TempKName)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[6]+C[7]*$TempKName)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
		FitFunc=C[1]+C[0]*((c[2]+C[7]*($TempKName-C[6]))*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*($TempKName-C[6]))^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*($TempKName-C[6]))^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
		 // FitFunc=C[1]+C[0]*((c[2]+C[7]*$TempKName+C[8]*$TempKName^2-C[6]*C[7]-C[8]*C[6]^2)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*$TempKName+C[8]*$TempKName^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*$TempKName+C[8]*$TempKName^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	endif
	//killwaves C
	//Duplicate/O $TempKName,T0
	//T0=$
	if(BareBandTJ)
		Make/O/N=9 C
		C[0]=Intensity
		C[1]=BackGround
		C[2]=Z1
		C[3]=Z2
		C[4]=PHi1
		C[5]=Phi2
		C[6]=BareBand_a
		C[7]=K1
		C[8]=K2
		//T0=C[7]*($TempKName)+C[8]*($TempKName)^2
		//T0=C[7]*($TempKName)+C[8]*($TempKName)^2-C[6]*C[7]-C[8]*C[6]^2
		//print k2
		//FitFunc=C[1]+C[0]*((c[2]+C[6]+C[7]*$TempKName)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[6]+C[7]*$TempKName)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[6]+C[7]*$TempKName)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
		//FitFunc=C[1]+C[0]*((c[2]+C[7]*$TempKName+C[8]*($TempKName)^2-C[6]*C[7]-C[8]*C[6]^2)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*$TempKName+C[8]*$TempKName^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*$TempKName+C[8]*$TempKName^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
		//FitFunc=C[1]+C[0]*((c[2]+T0)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(T0)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(T0)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
		//FitFunc=C[1]+C[8]
		FitFunc=C[1]+C[0]*((c[2]+C[7]*($TempKName)+C[8]*($TempKName)^2-C[6]*C[7]-C[8]*C[6]^2)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*($TempKName)+C[8]*$TempKName^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*($TempKName)+C[8]*$TempKName^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	endif
	//FitFunc=C[1]+C[0]*((c[2]+C[6]+C[7]*x)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	//Display FitFunc vs $TempKName
	//String GraphN="FitFunction"
	//DoWindow/K $GraphN
	//Display/N=$GraphN
	//string traceName=TraceNameList("",";",1)
	//if(itemsinlist(TraceName))
	RemoveFromGraph/z FitFunc
	appendtograph Fitfunc vs $tempKName
	ModifyGraph rgb(FitFunc)=(0,15872,65280)
	//appendtograph Fitfunc vs $tempKName
	
end

//Proc ShowMDCFittingFunc(CtrlName,VarNum,VarStr,VarName):SetvariableContrl
//	String CtrlName
//	Variable VarNum
//	String VarStr
//	String VarName
//end

Proc Fit_MDCFitting_XJIOP(CtrlName):Buttoncontrol
	String CtrlName
	PauseUpdate;Silent 1
	variable EStart=root:TempVariable:MDCandMDCFitting:Estart
	Variable EEnd=root:TempVariable:MDCandMDCFitting:EEnd
	Variable BareBand_a=root:TempVariable:MDCandMDCFitting:BareBand_a
	//Variable BareBand_b=root:TempVariable:MDCandMDCFitting:BareBand_b
	Variable Z1=root:TempVariable:MDCandMDCFitting:Z1
	Variable Z2=root:TempVariable:MDCandMDCFitting:Z2
	Variable Phi1=root:TempVariable:MDCandMDCFitting:PHi1
	Variable Phi2=root:TempVariable:MDCandMDCFitting:PHi2
	variable Intensity=root:TempVariable:MDCandMDCFitting:Intensity
	Variable BackGround=root:TempVariable:MDCandMDCFitting:BackGround
	Variable Offset=root:TempVariable:MDCandMDCFitting:Offset
	Variable Bind=root:TempVariable:MDCandMDCFitting:Bind
	Variable BareBandTJ=root:TempVariable:MDCandMDCFitting:BareBandTJ
	Variable BareBandL=root:TempVariable:MDCandMDCFitting:BareBandL
	//NewDatafolder/O/S root:MDCandMDCFitting:ExtractedMDC:MDCFittingResults
	if(EStart>EEnd)
		Offset=-Offset
	endif
	
	Variable ii=0
	String TempWaveName
	setdatafolder root:TempVariable:MDCandMDCFitting
	do
		if(SelWaves[ii]!=0)
			TempWaveName=AllWaves[ii]
			Break
		endif
		ii=ii+1
	while(ii<DimSize(Allwaves,0))
	//print TempWaveNAme
	TempWaveName="MDC_"+TempWaveName
	setdatafolder root:MDCandMDCFitting:$TempWaveName
	String MDCList=TraceNameList("",";",1)
	//print MDCList
	Variable MDCNum=ItemsInlist(MDCList)
	Make/O/N=(MDCNum) Intensity_Fit
	Make/O/N=(MDCNum) BackGround_Fit
	Make/O/N=(MDCNum) Z1_Fit
	Make/O/N=(MDCNum) Z2_Fit
	Make/O/N=(MDCNum) Phi1_Fit
	Make/O/N=(MDCNum) Phi2_Fit
	Make/O/N=(MDCNum) K_1
	Make/O/N=(MDCNum) K_2
	String TempMDCName,TempKName
	if(BareBandL)
		Make/O/D/N=8 C
		C[0]=Intensity
		C[1]=BackGround
		C[2]=Z1
		C[3]=Z2
		C[4]=PHi1
		C[5]=Phi2
		C[6]=BareBand_a
		C[7]=K1
		ii=0
		//Make/O/T/N=4 T_Constraints
		//T_Constraints[0] = {"K4 > -0.05","K4 < 0.05","K5> -0.05","K5< 0.05"}
		Do
			TempMDCName=StringFromList(ii,MDCList,";")
			if(Stringmatch(TempMDCName,"'*"))
				tempMDCName="aa"+TempMDCName
				//print TempMDCName
				TempMDCName=stringbykey("aa",TempMDCNAMe,"'","'")
			endif
			TempKName=XWaveName("",TempMDCName)
			//print TempKName
			//TempMDCName=
			//print numpnts(TempMDCName)
			//deletepoints 0,1,TempMDCName
			//display $tempMDCName
			//print TempMDCName
			//tempMDCName="'"+tempMDCName+"'"
			//setdatafolder root:MDCandMDCFitting
			//FuncFit/H="00000011" Akw_SC C root:MDCandMDCfitting:ExtractedMDC:$TempMDCName /D
			PauseUpdate;Silent 1
			//FuncFit/Q=1/N=1/G/ODR=0/NTHR=0/H="00000000" Akw_SC C $TempMDCName /X=$TempKName /D
			//print tempMDCName
			FuncFit/N=1/Q=1/G/ODR=0/NTHR=0/H="00000011" Akw_LinearBB C $TempMDCName /X=$TempKName /D ///C=T_Constraints
			//FuncFit/N=1/G/ODR=0/NTHR=0/H="00111100" Akw_SC C $TempMDCName /X=$TempKName /D
			Intensity_Fit[ii]=C[0]
			BackGround_Fit[ii]=C[1]
				
			C[1]+=Offset*(Bind+1)/2
		
			Z1_Fit[ii]=C[2]
			Z2_Fit[ii]=C[3]
			Phi1_Fit[ii]=C[4]
			Phi2_Fit[ii]=C[5]
			//BareBanda[ii]=C[6]
			K_1[ii]=C[7]
		
			//FuncFit Akw_SC C $TempMDCName /X=$TempKName /D
			//FuncFit/H="00000011" Akw_SC C 'MDCI_-100.5meV' /D
			ii=ii+1
		While(ii<MDCNum)
	endif
	if(BareBandTJ)
		Make/O/D/N=9 C
		C[0]=Intensity
		C[1]=BackGround
		C[2]=Z1
		C[3]=Z2
		C[4]=PHi1
		C[5]=Phi2
		C[6]=BareBand_a
		C[7]=K1
		C[8]=K2
		ii=0
		//Make/O/T/N=4 T_Constraints
		//T_Constraints[0] = {"K4 > -0.05","K4 < 0.05","K5> -0.05","K5< 0.05"}
		Do
			TempMDCName=StringFromList(ii,MDCList,";")
			tempMDCName="aa"+TempMDCName
			
			TempMDCName=stringbykey("aa",TempMDCNAMe,"'","'")
			TempKName=XWaveName("",TempMDCName)
			//print TempKName
			//TempMDCName=
			//print numpnts(TempMDCName)
			//deletepoints 0,1,TempMDCName
			//display $tempMDCName
			//print TempMDCName
			//tempMDCName="'"+tempMDCName+"'"
			//setdatafolder root:MDCandMDCFitting
			//FuncFit/H="00000011" Akw_SC C root:MDCandMDCfitting:ExtractedMDC:$TempMDCName /D
			PauseUpdate;Silent 1
			//FuncFit/Q=1/N=1/G/ODR=0/NTHR=0/H="00000000" Akw_SC C $TempMDCName /X=$TempKName /D
			FuncFit/N=1/Q=1/G/ODR=0/NTHR=0/H="000000111" Akw_TJBB C $TempMDCName /X=$TempKName /D ///C=T_Constraints
			//FuncFit/N=1/G/ODR=0/NTHR=0/H="00111100" Akw_SC C $TempMDCName /X=$TempKName /D
			Intensity_Fit[ii]=C[0]
			BackGround_Fit[ii]=C[1]
				
			C[1]+=Offset*(Bind+1)/2
		
			Z1_Fit[ii]=C[2]
			Z2_Fit[ii]=C[3]
			Phi1_Fit[ii]=C[4]
			Phi2_Fit[ii]=C[5]
			K_1[ii]=C[7]
			K_2[ii]=C[8]
		
			//FuncFit Akw_SC C $TempMDCName /X=$TempKName /D
			//FuncFit/H="00000011" Akw_SC C 'MDCI_-100.5meV' /D
			ii=ii+1
		While(ii<MDCNum)
	endif
	//While(ii<1)
	SetScale/I x EStart,EEnd,"", Intensity_Fit,BackGround_Fit,Z1_Fit,Z2_Fit,Phi1_Fit,Phi2_Fit,K_1,K_2
	Duplicate/O Z1_fit,RESE,IMSE
	RESE=x-Z1_fit
	IMSE=Z2_fit
	Z1_Fit/=x
	Z2_Fit/=x
	//Duplicate
end

Function Akw_LinearBB(C,x)
	Wave C
	Variable x
	//Return C[1]+C[0]*((c[2]+C[6]+C[7]*x)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	//return C[1]+C[0]*((c[2]+C[7]*(x-C[6]))*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	return C[1]+C[0]*((c[2]+C[7]*(x-C[6]))*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
End

Function Akw_TJBB(C,x)
	Wave C
	Variable x
	//Return C[1]+C[0]*((c[2]+C[6]+C[7]*x)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	//return C[1]+C[0]*((c[2]+C[7]*(x-C[6]))*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	return C[1]+C[0]*((c[2]+C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
		   //C[1]+C[0]*((c[2]+C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
End

function BareBand_Radio_XJIOP(name,value)
	String name
	variable value
	setdatafolder root:TempVariable:MDCandMDCFitting
	strswitch(name)
		case "BareBandL":
			variable/G root:TempVariable:MDCandMDCFitting:BareBandL=1
			Variable/G root:TempVariable:MDCandMDCFitting:BareBandTJ=0
			//GroupBox BareBand_G,size={205,75}
			checkbox barebandtj,pos={190,250}
			SetVariable a0,Pos={200,230},size={80,15},disable=1
			//setvariable b0,disable=0
			//setvariable K0,disable=1
			setvariable K1,Pos={300,230},size={80,15},disable=0
			setvariable K2,disable=1
			//Button FitMDC_B,Pos={290,275}
			//Button ShowMDCFitFunc_B,pos={195,275}
			//GroupBox MDCFitting_G,size={215,190}
			break
		case "BareBandTJ":
			variable/G root:TempVariable:MDCandMDCFitting:BareBandL=0
			Variable/G root:TempVariable:MDCandMDCFitting:BareBandTJ=1
			checkbox barebandtj,pos={190,230}
			//GroupBox BareBand_G,size={205,55}
			//checkbox barebandtj,pos={190,230}
			SetVariable a0,Pos={200,250},size={60,15},disable=1
			//setvariable b0,disable=1
			//setvariable K0,disable=0
			//setvariable K1,disable=0
			setvariable K1,Pos={262,250},size={60,15},disable=0
			setvariable K2,Pos={324,250},disable=0
			//Button FitMDC_B,Pos={290,255}
			//Button ShowMDCFitFunc_B,pos={195,255}
			//GroupBox MDCFitting_G,size={215,170}
			break
	endswitch
end

Proc ShowMDC_MDCFitting_XJIOP(CtrlName):ButtonControl
	String CtrlName
	variable EStart=root:TempVariable:MDCandMDCFitting:Estart
	Variable EEnd=root:TempVariable:MDCandMDCFitting:EEnd
	Variable KStart=root:TempVariable:MDCandMDCFitting:KStart
	Variable KEnd=root:TempVariable:MDCandMDCFitting:KEnd
	Variable Offset=root:TempVariable:MDCandMDCFitting:Offset
	Variable Bind=root:TempVariable:MDCandMDCFitting:Bind
	variable PHIOffset=root:PROCESS:PhiOffset
	//Variable ThetaOffset=root:PROCESS:ThetaOffset
	//Variable Omega=root:PROCESS:RotationAngle
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable KFValue=root:TempVariable:MDCandMDCFitting:KFValue
	String TempWaveName
	setdatafolder root:TempVariable:MDCandMDCFitting
	Variable ii,theta,phi//,omega,
	do
		if(SelWaves[ii]!=0)
			TempWaveName=AllWaves[ii]
			Break
		endif
		ii=ii+1
	while(ii<DimSize(Allwaves,0))
	Newdatafolder/O root:MDCandMDCfitting
	setdatafolder root:OriginalData
	//print tempwavename
	ii=0
	do
		//setdatafolder root:OriginalData
		if(stringmatch(ProcessedImage[ii],TempWaveName))
			Theta=Theta_Angle[ii]
			PHI=Phi_Angle[ii]
			//print 1
			break
		endif
		ii=ii+1
	while(ii<Dimsize(ProcessedImage,0))
	setdatafolder root:Process
	Duplicate/O $TempWaveName,root:MDCandMDCfitting:TempImage
	setdatafolder root:MDCandMDCFitting
	variable deltaE=deltax(TempImage)
	variable E0=leftx(TempImage)
	Make/O/N=(dimsize(TempImage,1)) AngleY,MDCIntensity,MDCKp
	AngleY=Dimdelta(TempImage,1)*x+Dimoffset(TempImage,1)
	AngleY=Phi-PhiOffset-AngleY
	//MDCIntensity=TempImage[100][p]
	String TempFullPath
	variable jj=0
	//variable halfBind=(bind+1)/2
	String TempMDCname,TempKName
	String tempFolderName="MDC_"+TempWaveName
	NewDataFolder/O/S root:MDCandMDCFitting:$tempFolderName
	killwaves/A/Z
	setdatafolder root:MDCandMDCFitting
	String GraphN="MDC_"+TempWaveName
	DoWindow/F $GraphN
	if(!V_Flag)
	Display/K=1/N=$GraphN
	endif
	ii=round((EStart-E0)/DeltaE)
	root:TempVariable:MDCandMDCFitting:Estart=ii*DeltaE+E0
	PauseUpdate;Silent 1
	//print EStart
	//Print EENd
	if(EStart<=EEnd)
	
		do
			if(ii>round((EEnd-E0)/DeltaE))
			//print "bb"
				root:TempVariable:MDCandMDCFitting:EEnd=(ii-(Bind+1)/2)*DeltaE+E0
				//print 1
				break
			endif
		
			setdatafolder root:MDCandMDCFitting
			MDCIntensity=TempImage[ii][p]
			jj=1
			if(Bind-1!=0)
				//print "aa"
				do
					MDCIntensity+=TempImage[ii+jj][p]+TempImage[ii-jj][p]
					jj=jj+1
				while(jj<(Bind+1)/2)
			endif
			//TempMDCName=TempWaveName+"_MDC"+num2str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempMDCName=TempWaveName[3]+"_I"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempMDCName="MDCI_"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempMDCName=TempWaveName+"_MDC"+num2str(E0+ii*deltaE)+"meV"
			//print num2str((1000*(E0+ii*deltaE)))
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+":"+TempMDCName
			setdatafolder root:MDCandMDCFitting:$TempFolderName
			//Duplicate/O MDCIntensity,root:MDCandMDCFitting:$tempFolderName:$TempMDCName
			//Duplicate/O MDCIntensity,$TempFullPath
			Duplicate/O root:MDCandMDCFitting:MDCIntensity,$TempMDCName
			setdatafolder root:MDCandMDCFitting
			//MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			MDCKp=0.5118*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)-KFValue
			//TempKName=TempWaveName+"_K"+num2Str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempKName=TempWaveName+"_K"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempKName="MDCK_"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+TempKName
			setdatafolder root:MDCandMDCFitting:$TempFolderName
			Duplicate/O root:MDCandMDCFitting:MDCKp,$TempKName
			//Duplicate/O MDCKp,root:MDCandMDCFitting:$tempFolderName:$TempKName
			//Duplicate/O MDCKp,$TempFullPath
			setdatafolder root:MDCandMDCFitting:$tempFolderName
			$TempMDCName+=(ii-round((EStart-E0)/DeltaE))*Offset
			//print TempMDCName
			appendtograph $TempMDCName vs $TempKName
			//ModifyGraph offset($TempMDCName)={0,(ii-round((EStart-E0)/DeltaE))*Offset}
		
			ii=ii+(Bind+1)/2
		While(1)
		
	endif
	
	if(EStart>EEnd)
		//DeltaE=-DeltaE
		do
			if(ii<round((EEnd-E0)/DeltaE))
				root:TempVariable:MDCandMDCFitting:EEnd=(ii+(Bind+1)/2)*DeltaE+E0
				//print 1
				break
			endif
		
			setdatafolder root:MDCandMDCFitting
			MDCIntensity=TempImage[ii][p]
			jj=1
			if(Bind-1!=0)
				do
					MDCIntensity+=TempImage[ii-jj][p]+TempImage[ii-jj][p]
					jj=jj+1
				while(jj<(Bind+1)/2)
			endif
			//TempMDCName=TempWaveName+"_MDC"+num2str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempMDCName=TempWaveName[3]+"_I"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempMDCName="MDCI_"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempMDCName=TempWaveName+"_MDC"+num2str(E0+ii*deltaE)+"meV"
			//print num2str((1000*(E0+ii*deltaE)))
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+":"+TempMDCName
			setdatafolder root:MDCandMDCFitting:$TempFolderName
			//Duplicate/O MDCIntensity,root:MDCandMDCFitting:$tempFolderName:$TempMDCName
			//Duplicate/O MDCIntensity,$TempFullPath
			Duplicate/O root:MDCandMDCFitting:MDCIntensity,$TempMDCName
			setdatafolder root:MDCandMDCFitting
			//MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			MDCKp=0.5118*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)-KFValue
			//TempKName=TempWaveName+"_K"+num2Str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempKName=TempWaveName+"_K"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempKName="MDCK_"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+TempKName
			setdatafolder root:MDCandMDCFitting:$TempFolderName
			Duplicate/O root:MDCandMDCFitting:MDCKp,$TempKName
			//Duplicate/O MDCKp,root:MDCandMDCFitting:$tempFolderName:$TempKName
			//Duplicate/O MDCKp,$TempFullPath
			setdatafolder root:MDCandMDCFitting:$tempFolderName
			$TempMDCName+=(ii-round((EStart-E0)/DeltaE))*Offset
			//print TempMDCName
			appendtograph $TempMDCName vs $TempKName
			//ModifyGraph offset($TempMDCName)={0,(ii-round((EStart-E0)/DeltaE))*Offset}
		
			ii=ii-(Bind+1)/2
		While(1)
	endif
	Label bottom "K\\B//\\M (1/A)"
	Label left "Intensity"
	setdatafolder root:MDCandMDCFitting
	killwaves/A/Z
end

//Function Akw_LinearBB(C,x)
//	Wave C
//	Variable x
	//Return C[1]+C[0]*((c[2]+C[6]+C[7]*x)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	//return C[1]+C[0]*((c[2]+C[7]*(x-C[6]))*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
//	return C[1]+C[0]*((c[2]+C[7]*(x-C[6]))*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
//End

//Function Akw_TJBB(C,x)
//	Wave C
//	Variable x
	//Return C[1]+C[0]*((c[2]+C[6]+C[7]*x)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[6]+C[7]*x)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
	//return C[1]+C[0]*((c[2]+C[7]*(x-C[6]))*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*(x-C[6]))^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
//	return C[1]+C[0]*((c[2]+C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
		   //C[1]+C[0]*((c[2]+C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)*(2*C[2]*C[3]-2*C[4]*C[5])-C[3]*(C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2))/((C[2]^2-C[3]^2-(C[7]*x+C[8]*x^2-C[6]*C[7]-C[8]*C[6]^2)^2-C[4]^2+C[5]^2)^2+4*(C[3]*C[2]-C[4]*C[5])^2)
//End

//proc AAAA()
	
//end
Proc FitAllImage_MDC_ZWT(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
	dowindow/K FitAllImage_MDC_ZWT_Panel
	//if(!V_Flag==1)
		FitAllImage_MDC_ZWT_Panel()
	//endif
end

window FitAllImage_MDC_ZWT_Panel():Panel
	PauseUpdate;Silent 1
	NewPanel/K=1/W=(1000,0,1175,350) as "Fit All Image"
	newdatafolder/O/S root:TempVariable
	newdatafolder/O/S root:TempVariable:FitAllImage
	String ALLImage=root:Process:ALLOriginalImage
	variable ImageNum=ItemsInList(ALLImage,";")
	Make/T/O/N=(ImageNum) AllWaves
	Make/O/N=(ImageNum) SelWaves
	variable ii=0
	do
		AllWaves[ii]=StringFromList(ii,ALLImage,";")	
		ii=ii+1
	while(ii<ImageNum)
	//DrawText 5,20,"Select Images:"
	Button FitallImage,pos={5,5},size={130,20},title="Fit Selected Images",proc=FitALLIMage_ZWT_Pro
	ListBox ALLWaves_L frame= 4,pos={5,25},size={165,320}
	ListBox ALLWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	//Make/O/
end

Proc FitALLIMage_ZWT_Pro(CtrlName):ButtonControl
	String CtrlName
	Pauseupdate;silent 1
	setdatafolder root:TempVariable:FitAllImage
	variable ii=0
	do
		if(SelWaves[ii])
			ZWTMDCLorentzFitting("DispersionMDC_file",0,Allwaves[ii])
		endif
		ii=ii+1
		setdatafolder root:TempVariable:FitAllImage
	while(ii<dimsize(AllWaves,0))
end

proc ZWTMDCLorentzFitting(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
//////////////////////////////////////////////////////////////////////////////
variable EStart=root:MDCSpectra:DispersionEnergyStart
	Variable EEnd=root:MDCSpectra:DispersionEnergyEnd
	Variable KStart=root:MDCSpectra:DispersionMomentumStart
	Variable KEnd=root:MDCSpectra:DispersionMomentumEnd
	Variable Offset=root:MDCSpectra:MDCSpectraOffset
	Variable Bind=root:MDCSpectra:MDCBindNumber
	variable PHIOffset=root:PROCESS:PhiOffset
	Variable PhotonEnergy=root:PROCESS:PhotonEnergy
	Variable LatticeConstant=root:PROCESS:LatticeConstant
	Variable WorkFunction=root:PROCESS:WorkFunction
	Variable ii//,jj
	
	Variable theta,phi//,omega,
	Newdatafolder/O root:MDCSpectra
	setdatafolder root:MDCSpectra
	String GraphN="MDC"+popStr
	DoWindow/K $GraphN
	killwaves/A/Z
	Display/K=1/N=$GraphN
	setdatafolder root:OriginalData
	//print tempwavename
	ii=0
	do
		//setdatafolder root:OriginalData
		if(stringmatch(ProcessedImage[ii],popStr))
			Theta=Theta_Angle[ii]
			PHI=Phi_Angle[ii]
			//print 1
			break
		endif
		ii=ii+1
	while(ii<Dimsize(ProcessedImage,0))
	
	setdatafolder root:Process
	Duplicate/O $popStr,root:MDCSpectra:TempImage
	setdatafolder root:MDCSpectra
	variable deltaE=deltax(TempImage)
	variable E0=leftx(TempImage)
	Make/O/N=(dimsize(TempImage,1)) AngleY,MDCIntensity,MDCKp
	AngleY=Dimdelta(TempImage,1)*x+Dimoffset(TempImage,1)
	AngleY=Phi-PhiOffset-AngleY
	//MDCIntensity=TempImage[100][p]
	String TempFullPath
	variable jj=0
	//variable halfBind=(bind+1)/2
	String TempMDCname,TempKName
	String tempFolderName="MDC_"+popStr
	//NewDataFolder/O/S root:MDCandMDCFitting:$tempFolderName
	//killwaves/A/Z
	
	//if(!V_Flag)
	//Display/N=$GraphN
	//endif
	ii=round((EStart-E0)/DeltaE)
	Variable temp=ii
	root:MDCSpectra:DispersionEnergyStart=ii*DeltaE+E0
	PauseUpdate;Silent 1
	//print EStart
	//Print EENd
	if(EStart<=EEnd)
	
		do
			if(ii>round((EEnd-E0)/DeltaE))
			//print "bb"
				root:MDCSpectra:DispersionEnergyEnd=(ii-(Bind+1)/2)*DeltaE+E0
				//print 1
				break
			endif
		
			setdatafolder root:MDCSpectra
			MDCIntensity=TempImage[ii][p]
			jj=1
			if(Bind-1!=0)
				//print "aa"
				do
					MDCIntensity+=TempImage[ii-jj][p]+TempImage[ii-jj][p]
					jj=jj+1
				while(jj<(Bind+1)/2)
			endif
			//TempMDCName=TempWaveName+"_MDC"+num2str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempMDCName=TempWaveName[3]+"_I"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempMDCName="MDCI_"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempMDCName=TempWaveName+"_MDC"+num2str(E0+ii*deltaE)+"meV"
			//print num2str((1000*(E0+ii*deltaE)))
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+":"+TempMDCName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			//Duplicate/O MDCIntensity,root:MDCandMDCFitting:$tempFolderName:$TempMDCName
			//Duplicate/O MDCIntensity,$TempFullPath
			Duplicate/O root:MDCSpectra:MDCIntensity,$TempMDCName
			setdatafolder root:MDCSpectra
			//MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			//TempKName=TempWaveName+"_K"+num2Str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempKName=TempWaveName+"_K"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempKName="MDCK_"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+TempKName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			Duplicate/O root:MDCSpectra:MDCKp,$TempKName
			//Duplicate/O MDCKp,root:MDCandMDCFitting:$tempFolderName:$TempKName
			//Duplicate/O MDCKp,$TempFullPath
			//setdatafolder root:MDCandMDCFitting:$tempFolderName
			$TempMDCName+=(ii-round((EStart-E0)/DeltaE))*Offset
			//print TempMDCName
			appendtograph $TempMDCName vs $TempKName
			//ModifyGraph offset($TempMDCName)={0,(ii-round((EStart-E0)/DeltaE))*Offset}
		
			ii=ii+(Bind+1)/2
		While(1)
		
	endif
	
	if(EStart>EEnd)
		//DeltaE=-DeltaE
		do
			if(ii<round((EEnd-E0)/DeltaE))
				root:MDCSpectra:DispersionEnergyEnd=(ii+(Bind+1)/2)*DeltaE+E0
				//print 1
				break
			endif
		
			setdatafolder root:MDCSpectra
			MDCIntensity=TempImage[ii][p]
			jj=1
			if(Bind-1!=0)
				do
					MDCIntensity+=TempImage[ii-jj][p]+TempImage[ii-jj][p]
					jj=jj+1
				while(jj<(Bind+1)/2)
			endif
			//TempMDCName=TempWaveName+"_MDC"+num2str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempMDCName=TempWaveName[3]+"_I"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempMDCName="MDCI_"+num2str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempMDCName=TempWaveName+"_MDC"+num2str(E0+ii*deltaE)+"meV"
			//print num2str((1000*(E0+ii*deltaE)))
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+":"+TempMDCName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			//Duplicate/O MDCIntensity,root:MDCandMDCFitting:$tempFolderName:$TempMDCName
			//Duplicate/O MDCIntensity,$TempFullPath
			Duplicate/O root:MDCSpectra:MDCIntensity,$TempMDCName
			setdatafolder root:MDCSpectra
			//MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+(E0+ii*deltaE))*sin(AngleY*pi/180)
			//TempKName=TempWaveName+"_K"+num2Str(round(1000*(E0+ii*deltaE)))+"meV"
			//TempKName=TempWaveName+"_K"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			TempKName="MDCK_"+num2Str(round(10000*(E0+ii*deltaE)/5)/10*5)+"meV"
			//TempFullPath="root:MDCandMDCFitting:"+TempFolderName+TempKName
			//setdatafolder root:MDCandMDCFitting:$TempFolderName
			Duplicate/O root:MDCSpectra:MDCKp,$TempKName
			//Duplicate/O MDCKp,root:MDCandMDCFitting:$tempFolderName:$TempKName
			//Duplicate/O MDCKp,$TempFullPath
			//setdatafolder root:MDCandMDCFitting:$tempFolderName
			$TempMDCName+=(ii-round((EStart-E0)/DeltaE))*Offset
			//print TempMDCName
			appendtograph $TempMDCName vs $TempKName
			//ModifyGraph offset($TempMDCName)={0,(ii-round((EStart-E0)/DeltaE))*Offset}
		
			ii=ii-(Bind+1)/2
		While(1)
	endif
	Label bottom "K\\B//\\M (\\F'Symbol'p/\\F'ARial'a)"
	Label left "Intensity (A. U. )"
	SetAxis bottom KStart,KEnd
	//TempMDCName="MDCI_"+num2str(round(10000*(E0+temp*deltaE)/5)/10*5)+"meV"
	//TempKName="MDCK_"+num2Str(round(10000*(E0+temp*deltaE)/5)/10*5)+"meV"
//	RemoveFromGraph $TempMDCName
//	appendtograph  $TempMDCName vs $TempKName
//	ModifyGraph lsize($tempMDCName)=3,rgb($TempMDCName)=(0,0,65280)
	setdatafolder root:MDCSpectra
	killwaves/A/Z
	
	
	
	
/////////////////////////////////////////////////////////////////////////	
	
	//String Curr=GetDataFolder(1)
    //20100111SetDataFolder root:MDCSpectra
    //20100111Duplicate/O root:PROCESS:$popStr,root:MDCSpectra:TempImage
   
   	//make/O/N=(round(abs(EStart-Eend)/Deltax(TempImage))+1) EE
   		//Killwaves/Z TempImage
   // String ReferenceMomentum="KRef_"+root:MDCSpectra:TempMDCName
	//String EnergryRefreence="ERef_"+root:MDCSpectra:TempMDCName
   // Variable SN, EN, lim
   // String/G ThetaFromName
   // Variable i,j 
	String MDCList, Name, TraceName, Order
	String ThetaAngle, NBackground, NHeight1, InvNHeight1, NFWHM1, NFWHMError1,NPosition1,NPositionError1,NEnergy
	String NHeight2, InvNHeight2, NFWHM2, NFWHMError2,NPosition2,NPositionError2
	String NHeight3, InvNHeight3, NFWHM3, NFWHMError3,NPosition3,NPositionError3	
	Variable w0,w1,w2,w3,w4,w5, w6, w7, w8, w9, w10
	
////       ThetaAngle=root:OriginalData:ThetaFromName
//     ThetaAngle=root:MDCFittedParameters:MDCTheta	
	   MDCList=TraceNameList("", ";",1)
     //  String/G MDCTheta=ThetaAngle
       //SN=root:MDCSpectra:MDCCurveStart
       //EN=root:MDCSpectra:MDCCurveEnd
       Variable MDCNum=ItemsInlist(MDCList)
       
       ///////////////////20100111
       	make/O/N=(MDCNum) EE
		SetScale/I x EStart,EEnd,"", EE
		EE=x
   
		/////////////////////
       w0=root:MDCSpectra:MDCBackground
       w1=root:MDCSpectra:MDCHeight
       w2=root:MDCSpectra:MDCFWHM
       w3=root:MDCSpectra:MDCPosition	
       w4=1
       w5=root:MDCSpectra:MDC2Height
       w6=root:MDCSpectra:MDC2FWHM
       w7=root:MDCSpectra:MDC2Position	
       w8=root:MDCSpectra:MDC3Height
       w9=root:MDCSpectra:MDC3FWHM
       w10=root:MDCSpectra:MDC3Position	
       Make/O co_OnePeak={w0, w1, w2,w3,w4}
       Make/O co_TwoPeak={w0, w1, w2,w3,w4,w5,w6,w7}     
       Make/O co_ThreePeak={w0, w1, w2,w3,w4,w5,w6,w7,w8,w9,w10}   
       Redimension/D co_OnePeak;DelayUpdate
       Redimension/D co_TwoPeak;DelayUpdate
       Redimension/D co_ThreePeak
         
       
	//lim=EN+1
	Variable NumofPeaks=root:MDCSpectra:NumberofLorentzianPeaks
	Make/O/N=(MDCNum) Background=0, Height1=0, FWHM1=0, FWHMError1=0,Position1=0, PositionError1=0,Energy
	Make/O/N=(MDCNum) Height2=0, FWHM2=0, FWHMError2=0, Position2=0, PositionError2=0
    Make/O/N=(MDCNum) Height3=0, FWHM3=0, FWHMError3=0, Position3=0, PositionError3=0
	ii=0
	jj=0
	//Variable kStart=root:MDCSpectra:DispersionMomentumStart
	//Variable kEnd=root:MDCSpectra:DispersionMomentumEnd
	
////Duplicate/O root:MDCSpectra:$ReferenceMomentum  RefMomentum
	
	
	//String ToFitMDCIntensity, ToFitMDCMomentum
	variable TempKStart,TempKEnd
	setdatafolder root:MDCSpectra
	DO
		//Name=StringFromList(ii,list,";")
//ToFitMDCIntensity="MDCIntensity"+num2str(i)
//	    ToFitMDCMomentum="MDcMomentum"+num2str(i)
		TempMDCName=StringFromList(ii,MDCList,";")
			if(Stringmatch(TempMDCName,"'*"))
				tempMDCName="aa"+TempMDCName
				//print TempMDCName
				TempMDCName=stringbykey("aa",TempMDCNAMe,"'","'")
			endif
			TempKName=XWaveName("",TempMDCName)
		if(KStart>$TempKName[dimsize($TempKName,0)-1])
			findlevel/Q $tempKName,KStart
			tempKStart=round(V_LevelX)
		else 
			tempKStart=Dimsize($TempKName,0)-1
		endif
		if(KEnd<$TempKName[0])
			findlevel/Q $tempKName,KEnd
			tempKEnd=round(V_LevelX)
		else
			tempKEnd=0
			//print "aa"
		endif
		//print kstart, Kend
	    IF(NumofPeaks==1)	    
	    
////	FuncFit XJLorentzianFit_OnePeak co_OnePeak root:MDCSpectra:$Name /D /X=RefMomentum		
		FuncFit/W=2/N=1/Q=1 XJLorentzianFit_OnePeak co_OnePeak $TempMDCName [tempKStart,TempKEnd] /D /X=$TempKName	
		
            Background[jj]=co_OnePeak[0]
	        Height1[jj]=co_OnePeak[1]
	        FWHM1[jj]=co_OnePeak[2]
	        Position1[jj]=co_OnePeak[3]
	        Energy[jj]=EE[ii]
	        
	        FWHMError1[jj]=W_sigma[2]
	        PositionError1[jj]=W_sigma[3]
	        
            //co_OnePeak[0]=Background[jj]
	        co_OnePeak[1]+=Offset*(Bind+1)/2
	        //co_OnePeak[2]=FWHM1[jj]
	        //co_OnePeak[3]=Position1[jj]
	        ENDIF
	        
	       IF(NumofPeaks==2)	
//		FuncFit XJLorentzianFit co root:MDCSpectra:$Name /D /X=root:MDCSpectra:ReferenceMomentumWav
//		FuncFit XJLorentzianFit_TwoPeak co_TwoPeak root:MDCSpectra:$Name /D /X=RefMomentum
		FuncFit/W=2/N=1/Q=1 XJLorentzianFit_TwoPeak co_TwoPeak root:MDCSpectra:$TempMDCName [tempKstart, tempKend] /D /X=$TempKName		
		
		
		
            Background[jj]=co_TwoPeak[0]
	        Height1[jj]=co_TwoPeak[1]
	        FWHM1[jj]=co_TwoPeak[2]
	        Position1[jj]=co_TwoPeak[3]
            Height2[jj]=co_TwoPeak[5]
	        FWHM2[jj]=co_TwoPeak[6]
	        Position2[jj]=co_TwoPeak[7]	        
            Energy[jj]=EE[ii]
                
	        FWHMError1[jj]=W_sigma[2]
	        PositionError1[j]=W_sigma[3]
	        FWHMError2[jj]=W_sigma[6]
	        PositionError2[j]=W_sigma[7]               
	        
           // co_TwoPeak[0]=Background[j]
	        co_TwoPeak[1]+=Offset*(Bind+1)/2
	       // co_TwoPeak[2]=FWHM1[j]
	       // co_TwoPeak[3]=Position1[j]
	        co_TwoPeak[5]+=Offset*(Bind+1)/2
	      //  co_TwoPeak[6]=FWHM2[j]
	      //  co_TwoPeak[7]=Position2[j]	        
	        ENDIF	
	        
	        
	    IF(NumofPeaks==3)	
//		FuncFit XJLorentzianFit co root:MDCSpectra:$Name /D /X=root:MDCSpectra:ReferenceMomentumWav
//		FuncFit XJLorentzianFit_ThreePeak co_ThreePeak root:MDCSpectra:$Name /D /X=RefMomentum
	    FuncFit/W=2/N=1/Q=1 XJLorentzianFit_ThreePeak co_ThreePeak root:MDCSpectra:$TempMDCName [tempKstart, tempKend] /D /X=$TempKName
		
		
            Background[jj]=co_ThreePeak[0]
	        Height1[jj]=co_ThreePeak[1]
	        FWHM1[jj]=co_ThreePeak[2]
	        Position1[jj]=co_ThreePeak[3]
            Height2[jj]=co_ThreePeak[5]
	        FWHM2[jj]=co_ThreePeak[6]
	        Position2[jj]=co_ThreePeak[7]
            Height3[jj]=co_ThreePeak[8]
	        FWHM3[jj]=co_ThreePeak[9]
	        Position3[jj]=co_ThreePeak[10]        	        
            Energy[jj]=EE[ii]
                
            FWHMError1[jj]=W_sigma[2]
	        PositionError1[jj]=W_sigma[3]
	        FWHMError2[jj]=W_sigma[6]
	        PositionError2[jj]=W_sigma[7]    
            FWHMError3[jj]=W_sigma[9]
	        PositionError3[jj]=W_sigma[10]               
                
	        
           // co_TwoPeak[0]=Background[jj]
	        co_TwoPeak[1]+=Offset*(Bind+1)/2
	       // co_TwoPeak[2]=FWHM1[jj]
	       // co_TwoPeak[3]=Position1[jj]
	        co_TwoPeak[5]+=Offset*(Bind+1)/2
	      //  co_TwoPeak[6]=FWHM2[jj]
	       // co_TwoPeak[7]=Position2[jj]
	        co_TwoPeak[8]+=Offset*(Bind+1)/2
	       // co_TwoPeak[9]=FWHM3[jj]
	      //  co_TwoPeak[10]=Position3[jj]	        	        
	        ENDIF		        
	        
            jj+=1
		ii+=1
	WHILE(ii<MDCNum)
	
//	NBackground= "Background"+ThetaAngleforMDCPlot
    NBackground= "BD"+popStr
	NHeight1= "Ht1"+popStr
	InvNHeight1= "IvH1"+popStr
	NFWHM1= "FM1"+popStr
	NPosition1= "Psn1"+popStr
	NEnergy="Ey"+popStr
	
	NFWHMError1="FMEr1"+popStr
	NPositionError1="PsEr1"+popStr
	
	    IF(NumofPeaks==2)	
		NHeight2= "Ht2"+popStr
		InvNHeight2= "IvH2"+popStr	
		NFWHM2= "FM2"+popStr
		NPosition2= "Psn2"+popStr
		
		NFWHMError2= "FMEr2"+popStr
		NPositionError2= "PsEr2"+popStr		
			
		ENDIF
		
	    IF(NumofPeaks==3)
		NHeight2= "Ht2"+popStr
		InvNHeight2= "IvH2"+popStr	
		NFWHM2= "FM2"+popStr
		NPosition2= "Psn2"+popStr       	
		NHeight3= "Ht3"+popStr
		InvNHeight3= "IvH3"+popStr		
		NFWHM3= "FM3"+popStr
		NPosition3= "Psn3"+popStr
		
		NFWHMError2= "FMEr2"+popStr
		NPositionError2= "PsEr2"+popStr       	
		NFWHMError3= "FMEr3"+popStr
		NPositionError3= "PsEr3"+popStr		
		
			
		ENDIF		
		
		
	Duplicate/O Background, root:MDCFittedParameters:$NBackground
	Duplicate/O Height1, root:MDCFittedParameters:$NHeight1
	Duplicate/O Height1, root:MDCFittedParameters:$InvNHeight1	
	root:MDCFittedParameters:$InvNHeight1=1/root:MDCFittedParameters:$NHeight1
	
	
	Duplicate/O FWHM1, root:MDCFittedParameters:$NFWHM1
	Duplicate/O FWHMError1, root:MDCFittedParameters:$NFWHMError1	
	Duplicate/O Position1, root:MDCFittedParameters:$NPosition1
	Duplicate/O PositionError1, root:MDCFittedParameters:$NPositionError1	
	Duplicate/O Energy, root:MDCFittedParameters:$NEnergy
	
	
	       IF(NumofPeaks==2)
		Duplicate/O Height2, root:MDCFittedParameters:$NHeight2
		Duplicate/O Height2, root:MDCFittedParameters:$InvNHeight2
		root:MDCFittedParameters:$InvNHeight2=1/root:MDCFittedParameters:$NHeight2
		
		Duplicate/O FWHM2, root:MDCFittedParameters:$NFWHM2
		Duplicate/O FWHMError2, root:MDCFittedParameters:$NFWHMError2		
		Duplicate/O Position2, root:MDCFittedParameters:$NPosition2
        Duplicate/O PositionError2, root:MDCFittedParameters:$NPositionError2		
		
		ENDIF       	

	       IF(NumofPeaks==3)
		Duplicate/O Height2, root:MDCFittedParameters:$NHeight2
		Duplicate/O Height2, root:MDCFittedParameters:$InvNHeight2
		
		root:MDCFittedParameters:$InvNHeight2=1/root:MDCFittedParameters:$NHeight2
		
		Duplicate/O FWHM2, root:MDCFittedParameters:$NFWHM2
		Duplicate/O FWHMError2, root:MDCFittedParameters:$NFWHMError2
		Duplicate/O Position2, root:MDCFittedParameters:$NPosition2
		Duplicate/O PositionError2, root:MDCFittedParameters:$NPositionError2	       
		Duplicate/O Height3, root:MDCFittedParameters:$NHeight3
		Duplicate/O Height3, root:MDCFittedParameters:$InvNHeight3
		
	    root:MDCFittedParameters:$InvNHeight3=1/root:MDCFittedParameters:$NHeight3
	
		Duplicate/O FWHM3, root:MDCFittedParameters:$NFWHM3
		Duplicate/O FWHMError3, root:MDCFittedParameters:$NFWHMError3
		Duplicate/O Position3, root:MDCFittedParameters:$NPosition3
       Duplicate/O PositionError3, root:MDCFittedParameters:$NPositionError3
	
		ENDIF       	
	
       //SetDataFolder Curr
       setdatafolder root:MDCSpectra
       //killwaves/A/Z
       root:MDCSpectra:ThetaAngleForMDCPlot=popstr
		Execute "DrawMDCDispersion()"


end
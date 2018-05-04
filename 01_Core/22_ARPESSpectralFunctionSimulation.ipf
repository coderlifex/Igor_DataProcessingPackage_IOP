#pragma rtGlobals=1		// Use modern global access method.

/// This tool is designed to simulate ARPES spectra using different models:
/// 1 Standard Fermi Liquid
/// 2 Marginal Fermi Liquid
/// 3 Electron-boson(phonon) Coupling
/// 4 Luttinger Fermi Liquid(Uncompleted)
/// 2011-07-04

Proc ARPESSimulation()

	//DoWindow/F ARPES_Simulation_Panel
	variable versionnum
	string str="ARPES_Simulation_Panel"
	versionnum=igorprocedureversion(str)
	
	DoWindow/F $str
	
	if(V_flag)
	if(!versionnum)
	dowindow/K $str
	DoWindow/F $str
	endif
	endif
	
	silent 1
	if (V_flag==0)
	
	        NewDataFolder/O/S root:ARPESSimulation
	        
	        String/G    SimulationFunctionName=StrVarOrDefault("root:ARPESSimulation:SimulationFunctionName","")
	        string/G    arbtrarydosname=StrVarOrDefault("root:ARPESSimulation:arbtrarydosname","")
	        
		    Variable/G  MomentumKStart=NumVarOrDefault("root:ARPESSimulation:MomentumKStart",5)
		    Variable/G  MomentumKEnd=NumVarOrDefault("root:ARPESSimulation:MomentumKEnd",5)		
	        Variable/G  NumberofMomentumPoints=NumVarOrDefault("root:ARPESSimulation:NumberofMomentumPoints",5)

		   Variable/G  BindingEnergyStart=NumVarOrDefault("root:ARPESSimulation:BindingEnergyStart",5)
		   Variable/G  BindingEnergyEnd=NumVarOrDefault("root:ARPESSimulation:BindingEnergyEnd",5)		
	       Variable/G  NumberofEnergyPoints=NumVarOrDefault("root:ARPESSimulation:NumberofEnergyPoints",5)		
		
	       Variable/G  SimulationTemperature=NumVarOrDefault("root:ARPESSimulation:SimulationTemperature",5)
	       
	       Variable/G  SimulationEnergyResolution=NumVarOrDefault("root:ARPESSimulation:SimulationEnergyResolution",5)
	       
	       Variable/G  SimulationMomentumResolution=NumVarOrDefault("root:ARPESSimulation:SimulationMomentumResolution",5)	       
	       	       
	       
	       Variable/G  SimulationImageNameType=NumVarOrDefault("root:ARPESSimulation:SimulationImageNameType",5)
	       
	       Variable/G  EDCOffSet=NumVarOrDefault("root:ARPESSimulation:EDCOffSet",5)
	       Variable/G  EDCBinding=NumVarOrDefault("root:ARPESSimulation:EDCBinding",5)
	       
	       
	       String/G    NamePrefix=StrVarOrDefault("root:ARPESSimulation:NamePrefix","")
	       
	       Variable/G  SimulationFunctionType  
	       
	       String/G  SimulatedImageFileList
	       
	       
	       Variable/G Uni_BareDispCoef= NumVarOrDefault("root:ARPESSimulation:Uni_BareDispCoef",5)   
	       Variable/G Uni_BareDispInterc= NumVarOrDefault("root:ARPESSimulation:Uni_BareDispInterc",5)
	       Variable/G Uni_BareCorrection= NumVarOrDefault("root:ARPESSimulation:Uni_BareCorrection",5) 	       
	       
	       
	       Variable/G FL_BareDispCoef= NumVarOrDefault("root:ARPESSimulation:FL_BareDispCoef",5)   
	       Variable/G FL_BareDispInterc= NumVarOrDefault("root:ARPESSimulation:FL_BareDispInterc",5)
	       Variable/G FL_BareCorrection= NumVarOrDefault("root:ARPESSimulation:FL_BareCorrection",5)  	       
	       
	       Variable/G MFL_BareDispCoef= NumVarOrDefault("root:ARPESSimulation:MFL_BareDispCoef",5)   
	       Variable/G MFL_BareDispInterc= NumVarOrDefault("root:ARPESSimulation:MFL_BareDispInterc",5)
	       Variable/G MFL_BareCorrection= NumVarOrDefault("root:ARPESSimulation:MFL_BareCorrection",5)  	       
	       
	       Variable/G LFL_BareDispCoef= NumVarOrDefault("root:ARPESSimulation:LFL_BareDispCoef",5)   
	       Variable/G LFL_BareDispInterc= NumVarOrDefault("root:ARPESSimulation:LFL_BareDispInterc",5)
	       Variable/G LFL_BareCorrection= NumVarOrDefault("root:ARPESSimulation:LFL_BareCorrection",5) 
	       variable/G LFL_EKSA= NumVarOrDefault("root:ARPESSimulation:LFL_EKSA",5) 
	       variable/G LFL_EKSB= NumVarOrDefault("root:ARPESSimulation:LFL_EKSB",5) 	      
	       variable/G LFL_EKSC= NumVarOrDefault("root:ARPESSimulation:LFL_EKSC",5)
	       variable/G LFL_g= NumVarOrDefault("root:ARPESSimulation:LFL_g",5) 
	       variable/G LFL_wc= NumVarOrDefault("root:ARPESSimulation:LFL_wc",5)
	       variable/G LFL_a= NumVarOrDefault("root:ARPESSimulation:LFL_a",5)  
	       
	       Variable/G EPC_BareDispCoef= NumVarOrDefault("root:ARPESSimulation:EPC_BareDispCoef",5)   
	       Variable/G EPC_BareDispInterc= NumVarOrDefault("root:ARPESSimulation:EPC_BareDispInterc",5)
	       Variable/G EPC_BareCorrection= NumVarOrDefault("root:ARPESSimulation:EPC_BareCorrection",5)  
	       
	       Variable/G All_BareDispCoef= NumVarOrDefault("root:ARPESSimulation:All_BareDispCoef",5)   
	       Variable/G All_BareDispInterc= NumVarOrDefault("root:ARPESSimulation:All_BareDispInterc",5)
	       Variable/G All_BareCorrection= NumVarOrDefault("root:ARPESSimulation:All_BareCorrection",5)  	       
	       
	       
              Variable/G FL_Alpha=NumVarOrDefault("root:ARPESSimulation:FL_Alpha",5)
              Variable/G FL_Beta=NumVarOrDefault("root:ARPESSimulation:FL_Beta",5)              	       	       
       
              Variable/G MFL_OmegaC=NumVarOrDefault("root:ARPESSimulation:MFL_OmegaC",5)

	       
	       Variable/G MFL_CoefSelfEnergy= NumVarOrDefault("root:ARPESSimulation:MFL_CoefSelfEnergy",5)
//	       Variable/G MFL_IterationStep= NumVarOrDefault("root:ARPESSimulation:MFL_IterationStep",5)
//	       Variable/G MFL_IterationTolerance= NumVarOrDefault("root:ARPESSimulation:MFL_IterationTolerance",5)	       	         				
               
  
	       Variable/G EPC_MassEnhanceMent= NumVarOrDefault("root:ARPESSimulation:EPC_MassEnhancement",5)
	       Variable/G EPC_DebyeEnergy= NumVarOrDefault("root:ARPESSimulation:EPC_DebyeEnergy",5)
	       Variable/G EPC_EinsteinEnergy= NumVarOrDefault("root:ARPESSimulation:EPC_EinsteinEnergy",5)
	       
	       Variable/G Uni_DOSHeight= NumVarOrDefault("root:ARPESSimulation:Uni_DOSHeight",5)
	       Variable/G Uni_ECut= NumVarOrDefault("root:ARPESSimulation:Uni_ECut",5)
	       Variable/G Uni_CalLamda
	       Variable/G Uni_PhononDOSType	
	              
	       
	       Variable/G Uni_AlphaSquared= NumVarOrDefault("root:ARPESSimulation:Uni_AlphaSquared",5)
	       Variable/G Uni_LamdaExpected= NumVarOrDefault("root:ARPESSimulation:Uni_LamdaExpected",5)		
	       Variable/G Uni_DOSPeakEnergy= NumVarOrDefault("root:ARPESSimulation:Uni_DOSPeakEnergy",5)	
	       Variable/G All_Impurity=NumVarOrDefault("root:ARPESSimulation:All_Impurity",5)	   	       
  
               NewDataFolder/O/S root:ARPESSimulatedImage
   	        root:ARPESSimulation:SimulatedImageFileList=WaveList("*",";","DIMS:2")           
               NewDataFolder/O/S root:ARPESSimulatedSpectra
               NewDataFolder/O/S root:ARPESSimulatedDispersion
               NewDataFolder/O/S root:ARPESRealSEfromMDC              
               NewDataFolder/O/S root:ARPESSimulatedSelfEnergy
 
		ARPES_Simulation_Panel()
		
	endif
End


Window ARPES_Simulation_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(332,229,934,686)
	ModifyPanel cbRGB=(64512,62423,1327)
	SetDrawLayer UserBack
	SetDrawEnv fname= "@Arial Unicode MS",fsize= 15,fstyle= 1,textrgb= (0,12800,52224)
	DrawText 4,56,"Momentum"
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 2,56,128,128
	SetDrawEnv fname= "@Arial Unicode MS",fsize= 15,fstyle= 1,textrgb= (0,12800,52224)
	DrawText 134,56,"Energy"
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 130,56,251,128
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 3,152,250,267
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 3,297,250,454
	SetDrawEnv linethick= 2,linefgc= (16384,28160,65280),fillpat= 0
	DrawRRect 269,277,596,390
	SetDrawEnv fname= "@Arial Unicode MS",fsize= 15,fstyle= 1,textrgb= (0,12800,52224)
	DrawText 4,152,"Condition"
	SetDrawEnv fname= "@Arial Unicode MS",fsize= 15,fstyle= 1,textrgb= (0,12800,52224)
	DrawText 5,297,"Result"
	DrawLine 332,311,346,311
	DrawLine 349,311,588,311
	PopupMenu popup_SimulationFunction,pos={5,10},size={247,20},bodyWidth=139,proc=SimulationFunctionSelection,title="\\F'@Arial Unicode MS'SIMULATE WHAT?"
	PopupMenu popup_SimulationFunction,font="Times New Roman"
	PopupMenu popup_SimulationFunction,mode=1,popvalue="Standard Fermi Liquid",value= #"\"Standard Fermi Liquid;Marginal Fermi Liquid;Luttinger Fermi Liquid;FL plus e_p Coupling--3DDebye;FL plus e_p Coupling--Einstein;El_Ph Universal;All Contributions:Universal\""
	SetVariable set_FunctionName,pos={288,5},size={293,20},bodyWidth=180,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Simulation Function"
	SetVariable set_FunctionName,font="Times New Roman",fSize=10
	SetVariable set_FunctionName,value= root:ARPESSimulation:SimulationFunctionName
	SetVariable MomentumK_Start,pos={5,59},size={119,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Start(1/A)"
	SetVariable MomentumK_Start,font="Times New Roman",fSize=10
	SetVariable MomentumK_Start,limits={-inf,inf,0.1},value= root:ARPESSimulation:MomentumKStart
	SetVariable MomentumK_End,pos={5,82},size={119,20},bodyWidth=50,proc=SetVarProc,title="\\Z12\\F'@Arial Unicode MS'End(1/A) "
	SetVariable MomentumK_End,font="Times New Roman",fSize=10
	SetVariable MomentumK_End,limits={-inf,inf,0.1},value= root:ARPESSimulation:MomentumKEnd
	SetVariable NumberofMomentum,pos={4,105},size={120,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Size              "
	SetVariable NumberofMomentum,font="Times New Roman",fSize=10
	SetVariable NumberofMomentum,limits={-inf,inf,0.1},value= root:ARPESSimulation:NumberofMomentumPoints
	SetVariable BindingEnergy_Start,pos={133,60},size={116,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Start(eV)"
	SetVariable BindingEnergy_Start,font="Times New Roman",fSize=10
	SetVariable BindingEnergy_Start,limits={-inf,inf,0.1},value= root:ARPESSimulation:BindingEnergyStart
	SetVariable BindingEnergy_End,pos={133,83},size={116,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12End(eV) "
	SetVariable BindingEnergy_End,font="Times New Roman",fSize=10
	SetVariable BindingEnergy_End,limits={-inf,inf,0.1},value= root:ARPESSimulation:BindingEnergyEnd
	SetVariable NumberofEnergy,pos={132,105},size={117,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Size             "
	SetVariable NumberofEnergy,font="Times New Roman",fSize=10
	SetVariable NumberofEnergy,limits={-inf,inf,0.1},value= root:ARPESSimulation:NumberofEnergyPoints
	SetVariable SimulationTemperature,pos={9,156},size={228,20},bodyWidth=60,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Temperature (K)                    "
	SetVariable SimulationTemperature,font="Times New Roman",fSize=10
	SetVariable SimulationTemperature,limits={-inf,inf,0.1},value= root:ARPESSimulation:SimulationTemperature
	SetVariable SimulationEnergyResolution,pos={10,177},size={228,20},bodyWidth=60,proc=SetVarProc,title="\\Z12\\F'@Arial Unicode MS'Energy Resolution(meV)     "
	SetVariable SimulationEnergyResolution,font="Times New Roman",fSize=10
	SetVariable SimulationEnergyResolution,limits={-inf,inf,0.1},value= root:ARPESSimulation:SimulationEnergyResolution
	SetVariable SimulationMomentumResolution,pos={10,199},size={229,20},bodyWidth=60,proc=SetVarProc,title="\\Z12\\F'@Arial Unicode MS'Momentum Resolution(1/A)"
	SetVariable SimulationMomentumResolution,font="Times New Roman",fSize=10
	SetVariable SimulationMomentumResolution,limits={-inf,inf,0.1},value= root:ARPESSimulation:SimulationMomentumResolution
	PopupMenu popup_ImageNameType,pos={10,242},size={231,20},bodyWidth=100,proc=ImageNameTypeSelection,title="\\F'@Arial Unicode MS'\\Z12Name Type?                   "
	PopupMenu popup_ImageNameType,font="Times New Roman"
	PopupMenu popup_ImageNameType,mode=1,popvalue="Simple",value= #"\"Simple;Complete\""
	PopupMenu EDCSpectra_file,pos={8,341},size={237,20},bodyWidth=140,proc=GetEDCSimulationSpectra,title="\\F'@Arial Unicode MS'\\Z12Simulated  EDC  "
	PopupMenu EDCSpectra_file,font="Times New Roman",fSize=10
	PopupMenu EDCSpectra_file,mode=6,popvalue="SM100000 ",value= #"root:ARPESSimulation:SimulatedImageFileList\t\t"
	SetVariable EDC_OffSet,pos={11,300},size={85,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Offset"
	SetVariable EDC_OffSet,font="Times New Roman",fSize=10
	SetVariable EDC_OffSet,value= root:ARPESSimulation:EDCOffSet
	SetVariable EDC_Binding,pos={144,299},size={96,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Binding"
	SetVariable EDC_Binding,font="Times New Roman",fSize=10
	SetVariable EDC_Binding,value= root:ARPESSimulation:EDCBinding
	PopupMenu MDCDispersion_file,pos={9,363},size={236,20},bodyWidth=140,proc=GetSimulationDispersion,title="\\F'@Arial Unicode MS'\\Z12MDC Dispersion "
	PopupMenu MDCDispersion_file,font="Times New Roman"
	PopupMenu MDCDispersion_file,mode=6,popvalue="SM100000 ",value= #"root:ARPESSimulation:SimulatedImageFileList\t\t"
	PopupMenu ScatteringRate_file,pos={8,385},size={237,20},bodyWidth=140,proc=GetSimulationScatteringRate,title="\\F'@Arial Unicode MS'\\Z12SimuMDCWidth  "
	PopupMenu ScatteringRate_file,font="Times New Roman"
	PopupMenu ScatteringRate_file,mode=6,popvalue="SM100000 ",value= #"root:ARPESSimulation:SimulatedImageFileList\t\t"
	PopupMenu MeasuredReS_file,pos={7,407},size={238,20},bodyWidth=140,proc=GetRealSEfromMDC,title="\\F'@Arial Unicode MS'\\Z12RealSEfromMDC"
	PopupMenu MeasuredReS_file,font="Times New Roman"
	PopupMenu MeasuredReS_file,mode=6,popvalue="SM100000 ",value= #"root:ARPESSimulation:SimulatedImageFileList\t\t"
	PopupMenu SelfEnergyReal_file,pos={6,429},size={239,20},bodyWidth=140,proc=ShowSimulationSelfEnergy,title="\\F'@Arial Unicode MS'\\Z12OriginSelfEnergy "
	PopupMenu SelfEnergyReal_file,font="Times New Roman"
	PopupMenu SelfEnergyReal_file,mode=6,popvalue="SM100000 ",value= #"root:ARPESSimulation:SimulatedImageFileList\t\t"
	SetVariable set_UniNamePrefix,pos={291,150},size={122,20},bodyWidth=50,proc=SetVarProc,title="\\F'@Arial Unicode MS'\\Z12Name Prefix"
	SetVariable set_UniNamePrefix,font="Times New Roman",fSize=10
	SetVariable set_UniNamePrefix,value= root:ARPESSimulation:NamePrefix
	Button ButtonARPESImage,pos={268,394},size={160,60},proc=GetEDCSimulationImage,title="\\F'@Arial Unicode MS'Simulated Image"
	Button ButtonARPESImage,font="Times New Roman",fSize=20
	Button ButtonExit,pos={447,394},size={150,60},proc=SimulationCleanandExit,title="\\F'@Arial Unicode MS'\\Z20Clean and EXIT"
	Button ButtonExit,font="Times New Roman",fSize=14
	PopupMenu popup_waytogetse,pos={9,221},size={232,20},bodyWidth=100,disable=2,title="\\F'@Arial Unicode MS'\\Z12Way to get Selfenergy? "
	PopupMenu popup_waytogetse,font="Times New Roman"
	PopupMenu popup_waytogetse,mode=1,popvalue="Direct",value= #"\"Direct;Elishiaberg\""
	TitleBox title0,pos={277,300},size={53,20},title="\\Z16\\F'Times'A(k,\\F'symbol'w\\F'Times')="
	TitleBox title0,frame=0
	TitleBox title1,pos={336,318},size={154,20},title="\\Z16\\F'Times'   [\\F'Symbol'w - e (\\F'Times'k) - Re\\F'Symbol'S(\\F'Times'k,\\F'Symbol'w)]"
	TitleBox title1,frame=0
	TitleBox title2,pos={490,311},size={98,27},title="\\Z16\\F'Times'\\S2\\M\\Z16 + [Im\\F'Symbol'S(\\F'Times'k,\\F'Symbol'w)]\\S2"
	TitleBox title2,frame=0
	TitleBox title3,pos={336,292},size={8,16},title="\\Z161",frame=0
	TitleBox title4,pos={424,289},size={59,20},title="\\Z16Im\\F'Symbol'S(\\F'Times'k,\\F'Symbol'w)"
	TitleBox title4,frame=0
	TitleBox title5,pos={334,316},size={10,20},title="\\Z16\\F'symbol'p",frame=0
	TitleBox title6,pos={276,346},size={130,26},title="\\Z16\\F'Symbol'e(\\F'Times'k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	TitleBox title6,frame=0
	PopupMenu simuSpectra,pos={8,320},size={237,20},bodyWidth=140,proc=getsimulatedimg,title="\\F'@Arial Unicode MS'\\Z12Simulated Image"
	PopupMenu simuSpectra,font="Times New Roman",fSize=10
	PopupMenu simuSpectra,mode=6,popvalue="SM100000 ",value= #"root:ARPESSimulation:SimulatedImageFileList\t\t"
	Button get2dprocesspanel,pos={120,276},size={130,20},proc=get2dprocesspanel,title="\\F'@Arial Unicode MS'Goto2DProcessPanel"
	SetVariable version,pos={9,473},size={70,16},value= _STR:"2011-08-18"
EndMacro
  
  Proc SimulationFunctionSelection(ctrlName,popNum,popStr) : PopupMenuControl
//---------------------------------
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
//	Print ctrlName, popNum, popStr

        	DoWindow/K ARPES_Simulation_Panel
        	ARPESSimulation()

	If (cmpstr(popStr,"Standard Fermi Liquid")==0)
	root:ARPESSimulation:SimulationFunctionType=1
	Print  popStr
	
	root:ARPESSimulation:SimulationFunctionName="Fermi Liquid"
	popupmenu popup_waytogetse,disable=2
	TitleBox titlewk,frame=0,pos={288,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e(\\F'Times'k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception,bodywidth=60,proc=SetVarProc,pos={200,53},size={230,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:FL_BareDispInterc	
    SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={200,73},size={230,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:FL_BareDispCoef
    SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={200,93},bodywidth=60,size={230,25},title="\\f01\\Z11\\F'Arial'c:            ",fSize=10
	SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:FL_BareCorrection
	SetVariable set_UniNamePrefix, pos={288,240}
	root:ARPESSimulation:Uni_BareDispInterc=root:ARPESSimulation:FL_BareDispInterc
	root:ARPESSimulation:Uni_BareDispCoef=root:ARPESSimulation:FL_BareDispCoef	
	root:ARPESSimulation:Uni_BareCorrection=root:ARPESSimulation:FL_BareCorrection	
	
	
    SetVariable Var_FLAlpha,proc=SetVarProc,pos={272,180},size={160,25},bodywidth=60, title="\\Z11\\F'symbol'a:            ",fSize=10
	SetVariable Var_FLAlpha,limits={-inf,inf,0.1},value=root:ARPESSimulation:FL_Alpha	
	SetVariable Var_FLBeta,proc=SetVarProc,pos={272,200},size={160,25},bodywidth=60, title="\\Z11\\F'symbol'b:            ",fSize=10
	SetVariable Var_FLBeta,limits={-inf,inf,0.1},value=root:ARPESSimulation:FL_Beta
	
	TitleBox titlesfl,frame=0,pos={285,130},size={130,20},title="\\K(0,26112,39168)\\f00\\Z16\\F'Arial' Standard Fermi Liquid: "
	TitleBox titlesflf1,frame=0,pos={290,155},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'S (\\F'Arial'k,\\F'symbol'w) \\F'Times' ="
	titlebox titlesflf2,frame=0,pos={357,148},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'\\f01a\\f00w + \\F'TImes' i \\F'symbol'\\f01b\\f00w\\S2  "	
    //SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 13
	//SetDrawEnv fname= "Times New Roman"
	//DrawText 329,200, "Standard Fermi Liquid Self-Energy:"
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 14	
	//SetDrawEnv fname= "Times New Roman"	
	//DrawText 332,220, "SE(k,w)=Alpha*w+i*Beta*w^2"
	PopupMenu popup_SimulationFunction,mode=1
	
	Endif
	
	
	If (cmpstr(popStr,"Marginal Fermi Liquid")==0)
	root:ARPESSimulation:SimulationFunctionType=2
	Print popStr

	root:ARPESSimulation:SimulationFunctionName="Marginal Fermi Liquid"
	popupmenu popup_waytogetse,disable=2
	//SetVariable Var_UniBareInterception,proc=SetVarProc,pos={330,30},size={230,25},font="Times New Roman", title="BareDipsersionInterc(1/A) a:",fSize=10
	//SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_BareDispInterc	
    //SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={330,50},size={230,25},font="Times New Roman", title="BareDipsersionCoef(eV*A)  b:",fSize=10
	//SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_BareDispCoef
    //SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={330,70},size={230,25},font="Times New Roman", title="BareDispersionCorrection  c:",fSize=10
	//SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_BareCorrection
	TitleBox titlewk,frame=0,pos={288,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e(\\F'Times'k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception,bodywidth=60,proc=SetVarProc,pos={200,53},size={230,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_BareDispInterc
    SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={200,73},size={230,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_BareDispCoef
    SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={200,93},bodywidth=60,size={230,25},title="\\f01\\Z11\\F'Arial'c:            ",fSize=10
	SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_BareCorrection
	SetVariable set_UniNamePrefix, pos={288,250}
	root:ARPESSimulation:Uni_BareDispInterc=root:ARPESSimulation:MFL_BareDispInterc
	root:ARPESSimulation:Uni_BareDispCoef=root:ARPESSimulation:MFL_BareDispCoef	
	root:ARPESSimulation:Uni_BareCorrection=root:ARPESSimulation:MFL_BareCorrection


	TitleBox titlemfl,frame=0,pos={285,130},size={130,20},title="\\K(0,26112,39168)\\f00\\Z16\\F'Arial' Maginal Fermi Liquid: "
	TitleBox titlemfl1,frame=0,pos={290,150},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'S (\\F'Arial'k,\\F'symbol'w) \\F'Times' ="
	titlebox titlemfl2,frame=0,pos={362,149},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'times'\\f02c\\f00 [\\F'symbol'w \\F'times'ln (x/\\F'symbol'w\\F'times'\\Bc\\M\\Z16)"	
	titlebox titlemfl3,frame=0,pos={445,149},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'times' - i \\F'symbol'p\\F'times'x/2]"
	titlebox titlemfl4,frame=0,pos={290,169},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'times'where x = Max{ \\F'symbol'p\\f02\\F'times'T, \\F'symbol'\\f00w}"
	
    SetVariable Var_MFLCoefofSelfEnergy,proc=SetVarProc,pos={285,195},size={145,25},bodywidth=60, title="\\F'times'\\f02\\Z11c:            ",fSize=10
	SetVariable Var_MFLCoefofSelfEnergy,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_CoefSelfEnergy	
	SetVariable Var_MFLOmegaC,proc=SetVarProc,pos={285,215},size={145,25}, bodywidth=60,title="\\F'symbol'\\Z11w\\F'times'\\Bc\\M\\Z11 (eV):   ",fSize=10
	SetVariable Var_MFLOmegaC,limits={-inf,inf,0.1},value=root:ARPESSimulation:MFL_OmegaC
	
	PopupMenu popup_SimulationFunction,mode=2

    //SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 13
	//SetDrawEnv fname= "Times New Roman"
	//DrawText 329,200, "Marginal Fermi Liquid Self-Energy:"
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 14
	//SetDrawEnv fname= "Times New Roman"		
	//DrawText 329,220, "SE(k,w)=c*[ w*ln(x/wc) - i*pi/2*x]"
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 14	
	//SetDrawEnv fname= "Times New Roman"	
	//DrawText 329,240, "in which x=Max(pi*T,w)"			
	Endif



	If (cmpstr(popStr,"Luttinger Fermi Liquid")==0)
	root:ARPESSimulation:SimulationFunctionType=3
	print  popStr

	root:ARPESSimulation:SimulationFunctionName="Luttinger Fermi Liquid"	
	popupmenu popup_waytogetse,disable=2
	//SetVariable Var_UniBareInterception,proc=SetVarProc,pos={330,30},size={230,25},font="Times New Roman", title="BareDipsersionInterc(1/A) a:",fSize=10
	//SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_BareDispInterc	
    //SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={330,50},size={230,25},font="Times New Roman", title="BareDipsersionCoef(eV*A)  b:",fSize=10
	//SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_BareDispCoef
    //SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={330,70},size={230,25},font="Times New Roman", title="BareDispersionCorrection  c:",fSize=10
	//SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_BareCorrection	
	TitleBox titlewk,frame=0,pos={288,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e\\F'Times'\\Sc\\M\\Z16(k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception,bodywidth=60,proc=SetVarProc,pos={185,53},size={230,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_BareDispInterc	
    SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={185,73},size={230,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_BareDispCoef
    SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={185,93},bodywidth=60,size={230,25},title="\\f01\\Z11\\F'Arial'c:            ",fSize=10
	SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_BareCorrection	
	
	TitleBox titlewk_lt,frame=0,pos={450,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e\\F'Times'\\Ss\\M\\Z16(k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception_lt,bodywidth=60,proc=SetVarProc,pos={350,53},size={230,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception_lt,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_EKSA
    SetVariable Var_UniBareCoefficient_lt,proc=SetVarProc,pos={350,73},size={230,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient_lt,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_EKSB
    SetVariable Var_UniBareCorrection_lt,proc=SetVarProc,pos={350,93},bodywidth=60,size={230,25},title="\\f01\\Z11\\F'Arial'c:            ",fSize=10
	SetVariable Var_UniBareCorrection_lt,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_EKSC	
	
	setvariable set_UniNamePrefix,pos={289,254}
	root:ARPESSimulation:Uni_BareDispInterc=root:ARPESSimulation:LFL_BareDispInterc
	root:ARPESSimulation:Uni_BareDispCoef=root:ARPESSimulation:LFL_BareDispCoef	
	root:ARPESSimulation:Uni_BareCorrection=root:ARPESSimulation:LFL_BareCorrection
	PopupMenu popup_SimulationFunction,mode=3
	
	TitleBox titlelf,frame=0,pos={288,120},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'arial' Luttinger Fermi Liquid Green Function: "
	TitleBox titlelf1,frame=0,pos={278,158},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'arial'G(\\F'symbol'e\\F'arial'\\Bk\\M\\Z16\\F'symbol',w) \\F'arial'="
	TitleBox titlelf2,frame=0,pos={388,136},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'symbol'w\\B\\F'arial'c\\M\\Z16\\F'symbol'\\S-a\\M\\F'arial'\\Z16e\\Si\\F'symbol'f"
	TitleBox titlelf3,frame=0,pos={355,168},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'symbol'[(w-e\\F'arial'\\Bk\\M\\Z16\\Sc\\M\\Z16)"
	TitleBox titlelf4,frame=0,pos={418,168},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'symbol'(w-e\\F'arial'\\Bk\\M\\Z16\\Ss\\M\\Z16)]\\S1/2"
	TitleBox titlelf5,frame=0,pos={505,168},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'symbol'(w-e\\F'arial'\\Bk\\M\\Z16\\Sc\\M\\Z16)\\S\\F'symbol'-a"
	TitleBox titlelf6,frame=0,pos={511,147},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'arial'g(\\F'symbol'a,d\\F'arial')"
	SetDrawEnv fname= "@Arial Unicode MS",fsize= 15,fstyle= 1,textrgb= (0,12800,52224)
	SetDrawEnv linefgc= (0,17408,26112)
	DrawText 5,297,"Result"
	DrawLine 353,168,499,168
	DrawLine 500,168,580,168
	
	SetVariable ltalpha,proc=SetVarProc,pos={320,200},bodywidth=60,size={110,25},title="\\f01\\Z11 \\F'symbol'a\\F'arial'(0<\\F'symbol'a<1/2):",fSize=10
	SetVariable ltalpha,limits={0,0.5,0.01},value=root:ARPESSimulation:LFL_a
	
	SetVariable ltg,proc=SetVarProc,pos={320,220},bodywidth=60,size={110,25},title="\\f01\\Z11\\F'arial' g\\F'symbol'(a,d):",fSize=10
	SetVariable ltg,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_g
	
	SetVariable ltwc,proc=SetVarProc,pos={420,200},bodywidth=60,size={110,25},title="\\f01\\Z11\\F'symbol'w\\F'arial'\\Bc\\M\\Z11:",fSize=10
	SetVariable ltwc,limits={-inf,inf,0.1},value=root:ARPESSimulation:LFL_wc
	button ltlref,pos={559,249},size={20,20},title="?",proc=getref
//    FermiLevelPanel( )
	Endif
	
	
	If (cmpstr(popStr,"FL plus e_p Coupling--3DDebye")==0)
	root:ARPESSimulation:SimulationFunctionType=4
	Print popStr
	popupmenu popup_waytogetse,disable=2

	root:ARPESSimulation:SimulationFunctionName="El-Ph coupling -- 3D Debye"	
	TitleBox titlewk,frame=0,pos={288,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e(\\F'Times'k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception,bodywidth=60,proc=SetVarProc,pos={288,53},size={110,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispInterc	
    SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={404,53},size={110,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispCoef
    SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={518,52},bodywidth=60,size={73,25},title="\\f01\\Z11\\F'Arial'c:",fSize=10
	SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareCorrection	
	SetVariable set_UniNamePrefix, pos={290,253}	
	//SetVariable Var_UniBareInterception,proc=SetVarProc,pos={330,30},size={230,25},font="Times New Roman", title="BareDipsersionInterc(1/A) a:",fSize=10
	//SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispInterc	
    //SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={330,50},size={230,25},font="Times New Roman", title="BareDipsersionCoef(eV*A)  b:",fSize=10
	//SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispCoef
    //SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={330,70},size={230,25},font="Times New Roman", title="BareDispersionCorrection  c:",fSize=10
	//SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareCorrection		
	root:ARPESSimulation:Uni_BareDispInterc=root:ARPESSimulation:EPC_BareDispInterc
	root:ARPESSimulation:Uni_BareDispCoef=root:ARPESSimulation:EPC_BareDispCoef	
	root:ARPESSimulation:Uni_BareCorrection=root:ARPESSimulation:EPC_BareCorrection


    SetVariable Var_EPCMassEnhance,proc=SetVarProc,pos={290,213},size={205,25},bodywidth=60, title="\\Z11\\F'symbol'l \\F'arial'(Mass Enhansment)            ",fSize=10
	SetVariable Var_EPCMassEnhance,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_MassEnhancement	
	SetVariable Var_DebyeEnergy,proc=SetVarProc,pos={290,232},size={205,25},bodywidth=60, title="\\F'symbol'\\Z11w\\F'arial'\\Bd\\M\\Z11\\F'arial' ( Debye Temperature,eV):",fSize=10
	SetVariable Var_DebyeEnergy,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_DebyeEnergy
	
	TitleBox titleepc,frame=0,pos={286,88},size={130,20},title="\\K(0,26112,39168)\\f00\\Z16\\F'Arial' Electron-Phonon Coupling Self-Energy: "
	TitleBox titleepc1,frame=0,pos={290,114},size={130,20},title="\\K(0,26112,39168)\\Z16Im\\F'symbol'S\\F'arial'(k,\\F'symbol'w)\\F'times'=\\Z30{"
	TitleBox titleepc2,frame=0,pos={372,103},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'\\f02l\\f00\\F'symbol'p|w|\\S3\\M\\Z16/(3w\\F'arial'\\Bd\\Z16\\S2\\M\\Z16)"
	TitleBox titleepc3,frame=0,pos={475,109},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'|w|<w\\F'arial'\\Bd"
	TitleBox titleepc4,frame=0,pos={372,133},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'\\f02l\\f00pw\\F'arial'\\Bd\\M\\Z16/3"
	TitleBox titleepc5,frame=0,pos={475,131},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'|w|>w\\F'arial'\\Bd"
	TitleBox titleepc6,frame=0,pos={290,163},size={130,20},title="\\K(0,26112,39168)\\Z16Re\\F'symbol'S\\F'arial'(k,\\F'symbol'w)\\F'times'="
	TitleBox titleepc7,frame=0,pos={360,161},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'symbol'(\\f02l\\f00w\\F'arial'\\Bd\\M\\Z16/3) [\\F'symbol'w/w\\F'arial'\\Bd\\Z16\\S3"
	TitleBox titleepc8,frame=0,pos={458,157},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'arial'ln(\\F'symbol'w\\F'arial'\\Bd\\M\\Z16\\S2\\M\\Z16-\\F'symbol'w\\S2\\M\\Z16)/w\\S2"
	TitleBox titleepc9,frame=0,pos={418,185},size={130,20},title="\\K(0,26112,39168)\\Z16+\\F'arial'ln(\\F'symbol'w\\F'arial'\\Bd\\M\\Z16+\\F'symbol'w)/"
	TitleBox titleepc10,frame=0,pos={490,185},size={130,20},title="\\K(0,26112,39168)\\Z16(\\F'symbol'w\\F'arial'\\Bd\\M\\Z16-\\F'symbol'w)+w/w\\F'arial'\\Bd\\M\\Z16]"
	PopupMenu popup_SimulationFunction,mode=4
	
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 13
	//SetDrawEnv fname= "Times New Roman"
	//DrawText 270,185, "Electron-Phonon Coupling Self-Energy:"
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 10	
	//SetDrawEnv fname= "Times New Roman"	
	//DrawText 240,205, "IM(SE(k,w))=hbar*Lamda*pi*|w|^3/(3*w_d^2)  for |w|<w_d"
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 10	
	//SetDrawEnv fname= "Times New Roman"
	//DrawText 240,220, "                  =hbar*Lamda*pi*w_d/3                   for |w|>w_d"
	
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 10	
	//SetDrawEnv fname= "Times New Roman"
	//DrawText 240,240, "RE(SE(k.w))=-(Lamda*hbar*w_d/3)*[(w/w_d)^3*ln(w_d^2-w^2)/w^2"
	//SetDrawEnv textrgb= (16384,28160,65280)
	//SetDrawEnv fstyle= 1	
	//SetDrawEnv fsize= 10	
	//SetDrawEnv fname= "Times New Roman"
	//DrawText 240,255, "                       +ln|(w_d+w)/(w_d-w)| + w/w_d]"	
	Endif
	

	If (cmpstr(popStr,"FL plus e_p Coupling--Einstein")==0)
	root:ARPESSimulation:SimulationFunctionType=5
	Print popStr

	popupmenu popup_waytogetse,disable=2
	root:ARPESSimulation:SimulationFunctionName="El-Ph coupling -- Einstein"		
	//SetVariable Var_UniBareInterception,proc=SetVarProc,pos={330,30},size={230,25},font="Times New Roman", title="BareDipsersionInterc(1/A) a:",fSize=10
	//SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispInterc	
    //SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={330,50},size={230,25},font="Times New Roman", title="BareDipsersionCoef(eV*A)  b:",fSize=10
	//SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispCoef
    //SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={330,70},size={230,25},font="Times New Roman", title="BareDispersionCorrection  c:",fSize=10
	//SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareCorrection	
	TitleBox titlewk,frame=0,pos={288,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e(\\F'Times'k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception,bodywidth=60,proc=SetVarProc,pos={200,53},size={230,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispInterc	
    SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={200,73},size={230,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispCoef
    SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={200,93},bodywidth=60,size={230,25},title="\\f01\\Z11\\F'Arial'c:            ",fSize=10
	SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareCorrection
	SetVariable set_UniNamePrefix, pos={288,250}	
	root:ARPESSimulation:Uni_BareDispInterc=root:ARPESSimulation:EPC_BareDispInterc
	root:ARPESSimulation:Uni_BareDispCoef=root:ARPESSimulation:EPC_BareDispCoef	
	root:ARPESSimulation:Uni_BareCorrection=root:ARPESSimulation:EPC_BareCorrection	
	

    SetVariable Var_EPCMassEnhance,proc=SetVarProc,pos={300,202},size={160,25},bodywidth=60, title="\\F'symbol'\\Z11l \\F'arial'(MassEnhansment):",fSize=10
	SetVariable Var_EPCMassEnhance,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_MassEnhancement	
	SetVariable Var_EinsteinEnergy,proc=SetVarProc,pos={300,222},size={160,25},bodywidth=60, title="\\Z11\\F'symbol'w\\F'arial'\\Be\\M\\Z11 (EinsteinMode,eV):",fSize=10
	SetVariable Var_EinsteinEnergy,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_EinsteinEnergy
       
	
	TitleBox titleepcei,frame=0,pos={280,114},size={130,20},title="\\K(0,26112,39168)\\f00\\Z16\\F'Arial' Electron-Phonon Coupling - Einstein: "
	TitleBox titleepcei1,frame=0,pos={288,133},size={130,20},title="\\K(0,26112,39168)\\Z16Re\\F'symbol'S\\F'arial'(k,\\F'symbol'w)\\F'times'= \\F'symbol'\\f02l\\f00/p"
	TitleBox titleepcei2,frame=0,pos={390,133},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'arial'ln(|\\F'symbol'w+w\\F'arial'\\Be\\M\\Z16)/"
	TitleBox titleepcei3,frame=0,pos={458,133},size={130,20},title="\\K(0,26112,39168)\\Z16(\\F'symbol'w-w\\F'arial'\\Be\\M\\Z16)|)"
	TitleBox titleepcei7,frame=0,pos={288,158},size={130,20},title="\\K(0,26112,39168)\\Z16Im\\F'symbol'S\\F'arial'(k,\\F'symbol'w)\\F'times'="
	TitleBox titleepcei4,frame=0,pos={359,151},size={130,20},title="\\K(0,26112,39168)\\Z16\\F'arial'c\\B2\\M\\Z16+c\\B3\\M\\Z16\\F'symbol'w\\S2"
	TitleBox titleepcei5,frame=0,pos={415,158},size={130,20},title="\\K(0,26112,39168)\\Z16+\\F'arial'[(H(\\F'symbol'w+w\\F'arial'\\Be\\M\\Z16)"
	TitleBox titleepcei6,frame=0,pos={492,158},size={130,20},title="\\K(0,26112,39168)\\Z16+\\F'arial'H(\\F'symbol'w-w\\F'arial'\\Be\\M\\Z16)]"
	TitleBox titleepcei8,frame=0,pos={290,182},size={130,20},title="\\K(65280,0,0)\\Z16\\F'arial'H: Step Function"
	PopupMenu popup_SimulationFunction,mode=5

 Endif
	If (cmpstr(popStr,"El_Ph Universal")==0)
	root:ARPESSimulation:SimulationFunctionType=6
	Print popStr
	popupmenu popup_waytogetse,disable=0
	root:ARPESSimulation:SimulationFunctionName="El-Ph coupling -- Universal"		
	//SetVariable Var_UniBareInterception,proc=SetVarProc,pos={330,30},size={230,25},font="Times New Roman", title="BareDipsersionInterc(1/A) a:",fSize=10
	//SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispInterc	
   // SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={330,50},size={230,25},font="Times New Roman", title="BareDipsersionCoef(eV*A)  b:",fSize=10
	//SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispCoef
   // SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={330,70},size={230,25},font="Times New Roman", title="BareDispersionCorrection  c:",fSize=10
	//SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareCorrection
	TitleBox titlewk,frame=0,pos={288,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e(\\F'Times'k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception,bodywidth=60,proc=SetVarProc,pos={200,53},size={230,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispInterc	
    SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={200,73},size={230,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareDispCoef
    SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={200,93},bodywidth=60,size={230,25},title="\\f01\\Z11\\F'Arial'c:            ",fSize=10
	SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:EPC_BareCorrection
	//SetVariable set_UniNamePrefix, pos={288,250}			
	root:ARPESSimulation:Uni_BareDispInterc=root:ARPESSimulation:EPC_BareDispInterc
	root:ARPESSimulation:Uni_BareDispCoef=root:ARPESSimulation:EPC_BareDispCoef	
	root:ARPESSimulation:Uni_BareCorrection=root:ARPESSimulation:EPC_BareCorrection
	
	
	//PopupMenu popup_PhononDOSType,pos={280,120},size={255,25},bodywidth=80,proc=PhononDOSTypeSelection, title="\\F'arial'Phonon DOS Type?"
	//PopupMenu popup_PhononDOSType,mode=1,popvalue="2D Debye",value= #"\"Triangle;3D Debye;2D Debye;Rectangular;Arbitary\""
	PopupMenu popup_PhononDOSType,pos={280,120},size={150,25},bodywidth=80,proc=PhononDOSTypeSelection, title="\\F'arial'Phonon DOS"
	PopupMenu popup_PhononDOSType,mode=1,popvalue="2D Debye",value= #"\"Triangle;3D Debye;2D Debye;Rectangular;Arbitary(ArbDos*)\""
	
	PopupMenu popup_PhononDOSarb,pos={440,120},size={150,25},bodywidth=80,proc=selectarbdos, title="\\F'arial'Arbitrary DOS"
	PopupMenu popup_PhononDOSarb,mode=1//,popvalue="2D Debye",value= #"\"Triangle;3D Debye;2D Debye;Rectangular;Arbitary\""
	
    SetVariable Var_DOSHeight,proc=SetVarProc,pos={320,141},size={222,25},bodywidth=94, title="\\F'arial'\\Z11Phonon DOS F(w) Height:",fSize=10
	SetVariable Var_DOSHeight,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_DOSHeight
	
	SetVariable Var_DOSPeakEnergy,proc=SetVarProc,pos={320,161},size={222,25},bodywidth=94, title="\\F'arial'\\Z11F(w) DOS Peak Energy (eV):",fSize=10
	SetVariable Var_DOSPeakEnergy,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_DOSPeakEnergy	

	SetVariable Var_DOSECut,proc=SetVarProc,pos={320,181},size={222,25},bodywidth=94,title="\\F'arial'\\Z11F(w) DOS Energy Cutoff(eV):",fSize=10
	SetVariable Var_DOSECut,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_ECut
	

//  SetVariable Var_AlphaSquare,proc=SetVarProc,pos={329,190},size={230,25},title="Alpha Squared:",fSize=10     	
//	SetVariable Var_AlphaSquare,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_AlphaSquared
	
    SetVariable Var_ExpectedLamda,proc=SetVarProc,pos={320,201},size={222,25},bodywidth=94,title="\\F'symbol'\Z11l \\F'Arial' Expected:",fSize=10     	
	SetVariable Var_ExpectedLamda,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_LamdaExpected	
	
	
	
	SetVariable set_UniNamePrefix,proc=SetVarProc,pos={296,230},size={103,25}, title="\\F'Arial'\\Z12Name Prefix",fSize=10
	SetVariable set_UniNamePrefix, value= root:ARPESSimulation:NamePrefix	      	

	
       root:ARPESSimulation:Uni_PhononDOSType=3
       PopupMenu popup_SimulationFunction,mode=6
       PhononDOSTypeSelection(ctrlName,3,popStr)

  	Endif
       	

	
	If (cmpstr(popStr,"All Contributions:Universal")==0)
	root:ARPESSimulation:SimulationFunctionType=7
	Print popStr
	popupmenu popup_waytogetse,disable=0

	root:ARPESSimulation:SimulationFunctionName="All: el-el+el-ph+Impurity"		
	//SetVariable Var_UniBareInterception,proc=SetVarProc,pos={330,30},size={230,25},font="Times New Roman", title="BareDipsersionInterc(1/A) a:",fSize=10
	//SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:All_BareDispInterc	
    //SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={330,50},size={230,25},font="Times New Roman", title="BareDipsersionCoef(eV*A)  b:",fSize=10
	//SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:All_BareDispCoef
    //SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={330,70},size={230,25},font="Times New Roman", title="BareDispersionCorrection  c:",fSize=10
	//SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},font="Times New Roman", value=root:ARPESSimulation:All_BareCorrection
	TitleBox titlewk,frame=0,pos={288,25},size={130,20},title="\\K(0,26112,39168)\\f01\\Z16\\F'Symbol'e(\\F'Times'k) = \\f02a + b\\f00k + \\f02c\\f00k\\S2  "
	SetVariable Var_UniBareInterception,bodywidth=60,proc=SetVarProc,pos={288,53},size={110,25}, title="\\f02\\Z11\\F'Arial'a\\f00 (1/A):   ",fSize=10
	SetVariable Var_UniBareInterception,limits={-inf,inf,0.1},value=root:ARPESSimulation:All_BareDispInterc	
    SetVariable Var_UniBareCoefficient,proc=SetVarProc,pos={404,53},size={110,25},bodywidth=60,title="\\f02\\Z11\\F'Arial'b \\f00(eVA) :",fSize=10
	SetVariable Var_UniBareCoefficient,limits={-inf,inf,0.1},value=root:ARPESSimulation:All_BareDispCoef
    SetVariable Var_UniBareCorrection,proc=SetVarProc,pos={518,52},bodywidth=60,size={73,25},title="\\f01\\Z11\\F'Arial'c:",fSize=10
	SetVariable Var_UniBareCorrection,limits={-inf,inf,0.1},value=root:ARPESSimulation:All_BareCorrection
	root:ARPESSimulation:Uni_BareDispInterc=root:ARPESSimulation:All_BareDispInterc
	root:ARPESSimulation:Uni_BareDispCoef=root:ARPESSimulation:All_BareDispCoef	
	root:ARPESSimulation:Uni_BareCorrection=root:ARPESSimulation:All_BareCorrection		
	
	
	//PopupMenu popup_PhononDOSType,pos={320,85},size={230,25},font="Times New Roman", proc=PhononDOSTypeSelection,title="Phonon DOS Type?"
	//PopupMenu popup_PhononDOSType,mode=1,popvalue="2D Debye",value= #"\"Triangle;3D Debye;2D Debye;Arbitary\""
	
	
     	//SetVariable Var_DOSHeight,proc=SetVarProc,pos={329,110},size={230,25},font="Times New Roman", title="Phonon DOS F(w) Height:",fSize=10
	//SetVariable Var_DOSHeight,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_DOSHeight
	
	//SetVariable Var_DOSPeakEnergy,proc=SetVarProc,pos={329,125},size={230,25},font="Times New Roman", title="F(w) DOS Peak Energy  (eV):",fSize=10
	//SetVariable Var_DOSPeakEnergy,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_DOSPeakEnergy	

	//SetVariable Var_DOSECut,proc=SetVarProc,pos={329,140},size={230,25},font="Times New Roman", title="F(w) DOS Energy Cutoff  (eV):",fSize=10
	//SetVariable Var_DOSECut,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_ECut
	

//  SetVariable Var_AlphaSquare,proc=SetVarProc,pos={329,155},size={230,25},title="Alpha Squared:",fSize=10     	
//	SetVariable Var_AlphaSquare,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_AlphaSquared 
	
    //SetVariable Var_ExpectedLamda,proc=SetVarProc,pos={329,155},size={230,25},font="Times New Roman", title="Lamda Expected:",fSize=10     	
	//SetVariable Var_ExpectedLamda,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_LamdaExpected
	PopupMenu popup_PhononDOSType,pos={280,90},size={150,25},bodywidth=80,proc=PhononDOSTypeSelection, title="\\F'arial'Phonon DOS"
	PopupMenu popup_PhononDOSType,mode=1,popvalue="2D Debye",value= #"\"Triangle;3D Debye;2D Debye;Rectangular;Arbitary(ArbDos*)\""
	
	PopupMenu popup_PhononDOSarb,pos={440,90},size={150,25},bodywidth=80,proc=selectarbdos, title="\\F'arial'Arbitrary DOS"
	PopupMenu popup_PhononDOSarb,mode=1//,popvalue="2D Debye",value= #"\"Triangle;3D Debye;2D Debye;Rectangular;Arbitary\""
	
	
    SetVariable Var_DOSHeight,proc=SetVarProc,pos={320,111},size={222,25},bodywidth=94, title="\\F'arial'\\Z11Phonon DOS F(w) Height:",fSize=10
	SetVariable Var_DOSHeight,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_DOSHeight
	
	SetVariable Var_DOSPeakEnergy,proc=SetVarProc,pos={320,131},size={222,25},bodywidth=94, title="\\F'arial'\\Z11F(w) DOS Peak Energy (eV):",fSize=10
	SetVariable Var_DOSPeakEnergy,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_DOSPeakEnergy	

	SetVariable Var_DOSECut,proc=SetVarProc,pos={320,151},size={222,25},bodywidth=94,title="\\F'arial'\\Z11F(w) DOS Energy Cutoff(eV):",fSize=10
	SetVariable Var_DOSECut,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_ECut
	

//  SetVariable Var_AlphaSquare,proc=SetVarProc,pos={329,190},size={230,25},title="Alpha Squared:",fSize=10     	
//	SetVariable Var_AlphaSquare,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_AlphaSquared
	
    SetVariable Var_ExpectedLamda,proc=SetVarProc,pos={320,171},size={222,25},bodywidth=94,title="\\F'symbol'\Z11l \\F'Arial' Expected:",fSize=10     	
	SetVariable Var_ExpectedLamda,limits={-inf,inf,0.1},value=root:ARPESSimulation:Uni_LamdaExpected	
		

	
    SetVariable Var_Impurity,proc=SetVarProc,pos={320,191},size={222,25},bodywidth=94, title="\\F'arial'\\Z11Impurity to IM:",fSize=10     	
	SetVariable Var_Impurity,limits={-inf,inf,0.1},value=root:ARPESSimulation:All_Impurity 	
	
    SetVariable Var_ElectronAlpha,proc=SetVarProc,pos={320,211},size={222,25},bodywidth=94, title="\\F'arial'\\Z11Electron \\F'symbol'a:",fSize=10     	
	SetVariable Var_ElectronAlpha,limits={-inf,inf,0.1},value=root:ARPESSimulation:FL_Alpha		
	
    SetVariable Var_ElectronBeta,proc=SetVarProc,pos={320,231},size={222,25},bodywidth=94, title="\\F'arial'\\Z11Electron   \\F'symbol'b:",fSize=10     	
	SetVariable Var_ElectronBeta,limits={-inf,inf,0.1},value=root:ARPESSimulation:FL_Beta		
	
	 
	
	
	//SetVariable set_UniNamePrefix,proc=SetVarProc,pos={329,230},size={165,25},font="Times New Roman", title="Name Prefix",fSize=10
	//SetVariable set_UniNamePrefix, value= root:ARPESSimulation:NamePrefix	   	
	SetVariable set_UniNamePrefix,proc=SetVarProc,pos={296,253},size={103,25}, title="\\F'Arial'\\Z12Name Prefix",fSize=10
	SetVariable set_UniNamePrefix, value= root:ARPESSimulation:NamePrefix	   
	PopupMenu popup_SimulationFunction,mode=7
	
       root:ARPESSimulation:Uni_PhononDOSType=3
    PhononDOSTypeSelection(ctrlName,3,popStr)
   	Endif       	
       	
       	
       	
       	
       	
	
	SetDataFolder root:ARPESSimulatedImage
	root:ARPESSimulation:SimulatedImageFileList=WaveList("*",";","DIMS:2")
//      Print root:ARPESSimulation:SimulatedImageFileList


	SetDataFolder Curr
End


Proc ImageNameTypeSelection(ctrlName,popNum,popStr) : PopupMenuControl
//--------------------------------
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
	If (cmpstr(popStr,"Simple")==0)	
	root:ARPESSimulation:SimulationImageNameType=0
//	Print root:ARPESSimulation:SimulationImageNameType
	Endif
	
	If (cmpstr(popStr,"Complete")==0)
	root:ARPESSimulation:SimulationImageNameType=1
//	Print root:ARPESSimulation:SimulationImageNameType
	Endif	
	
	SetDataFolder Curr
	
	END
	
	
Proc PhononDOSTypeSelection(ctrlName,popNum,popStr) : PopupMenuControl
//--------------------------------
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)

	root:ARPESSimulation:Uni_PhononDOSType=3	
	string/G root:ARPESSimulation:arbdoslist
	//If (cmpstr(popStr,"Triangle")==0)
	If (popnum==1)
	root:ARPESSimulation:Uni_PhononDOSType=popNum
	PopupMenu popup_PhononDOSarb,disable=2
	root:ARPESSimulation:arbdoslist="none"
	PopupMenu popup_PhononDOSarb,value=#"root:ARPESSimulation:arbdoslist"
	Endif
	
	//If (cmpstr(popStr,"3D Debye")==0)
	If (popnum==2)
	root:ARPESSimulation:Uni_PhononDOSType=popNum
	PopupMenu popup_PhononDOSarb,disable=2
	root:ARPESSimulation:arbdoslist="none"
	PopupMenu popup_PhononDOSarb,value=#"root:ARPESSimulation:arbdoslist"
	Endif
	
	//If (cmpstr(popStr,"2D Debye")==0)
	If (popnum==3)
	root:ARPESSimulation:Uni_PhononDOSType=popNum
	PopupMenu popup_PhononDOSarb,disable=2
	root:ARPESSimulation:arbdoslist="none"
	PopupMenu popup_PhononDOSarb,value=#"root:ARPESSimulation:arbdoslist"
	Endif
	
	//If (cmpstr(popStr,"Rectangular")==0)
	If (popnum==4)
	root:ARPESSimulation:Uni_PhononDOSType=popNum
	PopupMenu popup_PhononDOSarb,disable=2
	root:ARPESSimulation:arbdoslist="none"
	PopupMenu popup_PhononDOSarb,value=#"root:ARPESSimulation:arbdoslist"
	Endif	
	
	
	//If (cmpstr(popStr,"Arbitary")==0)
	If (popnum==5)
	root:ARPESSimulation:Uni_PhononDOSType=popNum
	PopupMenu popup_PhononDOSarb,disable=0
	root:ARPESSimulation:arbdoslist=wavelist("ArbDos*",";","DIMS:1")
	if(!strlen(root:ARPESSimulation:arbdoslist))
	root:ARPESSimulation:arbdoslist="No Dos found. hint: root:ARPESSimulation:ArbDos*"
	endif
	PopupMenu popup_PhononDOSarb,value=#"root:ARPESSimulation:arbdoslist"
	Endif		
	
	Print root:ARPESSimulation:Uni_PhononDOSType
	
	SetDataFolder Curr
	
	END	
	


//Fermi Function
Function SimulationFermi(w,x)

	//w[0]   constant background;
	//w[1]   Height of the Fermi Step; 
	//w[2]   Full Width at Half maximum;
	//w[3]   Fermi Edge position;
	//w[4]   Background Slope;
	wave w; Variable x

	return w[0] + w[1]/(exp(4400*(x-w[3])/w[2])+1)+w[4]*x
	
END




//proc   GetEDCSimulationImage(ctrlName) : ButtonControl
function  GetEDCSimulationImage(ctrlName) : ButtonControl
	   String ctrlName

	 
String Curr=GetDataFolder(1)
string curr1
SetDataFolder root:ARPESSimulation

String BareK, BareE
String UniImageName, UniWindowName

Variable Uni_a
Variable Uni_b
Variable Uni_c
Variable xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0,nx,ny
//Variable KS=root:ARPESSimulation:MomentumKStart*3.1416/3.8
//Variable KE=root:ARPESSimulation:MomentumKEnd*3.1416/3.8
nvar KS=root:ARPESSimulation:MomentumKStart//*1
nvar KE=root:ARPESSimulation:MomentumKEnd//*1
nvar ES=root:ARPESSimulation:BindingEnergyStart
nvar EE=root:ARPESSimulation:BindingEnergyEnd
nvar MomentumPoint=root:ARPESSimulation:NumberofMomentumPoints
nvar EnergyPoint=root:ARPESSimulation:NumberofEnergyPoints
nvar Temp=root:ARPESSimulation:SimulationTemperature
//String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
//String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
//String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)

//     Gaussian for Energy Resolution convolution
       nvar GES=root:ARPESSimulation:BindingEnergyStart
       nvar GEE=root:ARPESSimulation:BindingEnergyEnd
      // variable NumberofEnergy=(root:ARPESSimulation:NumberofEnergyPoints)/(GEE-GES)*0.2+1
        variable NumberofEnergy=(EnergyPoint)/(GEE-GES)*0.2+1
      
       Make/O/N=(NumberofEnergy) GForConvolution
       Setscale/I x -0.1, 0.1, GForConvolution
       nvar EResolutionforC=root:ARPESSimulation:SimulationEnergyResolution
       Variable ERforC=EResolutionforC/1000/2/sqrt(ln(2))
       GForConvolution=exp(-(x/ERforC)^2)
       
//     Gaussian for Momentum Resolution convolution
       nvar KES=root:ARPESSimulation:MomentumKStart
       nvar KEE=root:ARPESSimulation:MomentumKEnd
       Variable NumberofMomentum=(MomentumPoint)/(KEE-KES)*0.2+1
       Make/O/N=(NumberofMomentum) GForKConvolution
       Setscale/I x -0.1, 0.1, GForKConvolution
       nvar KResolutionforC=root:ARPESSimulation:SimulationMomentumResolution
       Variable MRforC=KResolutionforC/2/sqrt(ln(2))
       GForKConvolution=exp(-(x/MRforC)^2)       
       
           

DoWindow GaussianForEConvolution
If (V_Flag==0)

       Display/K=1 GForConvolution as "GaussainForEnergyConvolution"
       
       
DoWindow/C GaussianForEConvolution
Else 
DoWindow/F GaussainForEConvolution
Endif
       
       
       
DoWindow GaussianForKConvolution
If (V_Flag==0)

       Display/K=1 GForKConvolution as "GaussainForMomentumConvolution"
       
       
DoWindow/C GaussianForKConvolution
Else 
DoWindow/F GaussainForKConvolution
Endif

String TextOne
String TextTwo
String TextThree
String TextFour
String TextFive
String TextSix
 String UniRE
	String UniIM
	String UniEnergy
variable ii,jj,Lamda,w_d
Variable Uni_AlphaSq
nvar SimulationFunctionType=root:ARPESSimulation:SimulationFunctionType
nvar SimulationImageNameType=root:ARPESSimulation:SimulationImageNameType
svar NamePrefix=root:ARPESSimulation:NamePrefix
nvar FL_Alpha=root:ARPESSimulation:FL_Alpha
nvar FL_Beta=root:ARPESSimulation:FL_Beta

nvar Uni_BareDispInterc=root:ARPESSimulation:Uni_BareDispInterc
nvar FL_BareDispInterc=root:ARPESSimulation:FL_BareDispInterc
nvar Uni_BareDispCoef=root:ARPESSimulation:Uni_BareDispCoef
nvar FL_BareDispCoef=root:ARPESSimulation:FL_BareDispCoef	
nvar Uni_BareCorrection=root:ARPESSimulation:Uni_BareCorrection
nvar FL_BareCorrection=root:ARPESSimulation:FL_BareCorrection
nvar SimulationTemperature=root:ARPESSimulation:SimulationTemperature

If (SimulationFunctionType==1)
Print "Image from Standard Fermi Liquid"


BareK="BareK" + "FL"+NamePrefix//root:ARPESSimulation:NamePrefix
BareE="BareE" + "FL"+NamePrefix//root:ARPESSimulation:NamePrefix

If (SimulationImageNameType==0)
UniImageName=NamePrefix+"FL"
UniWindowName=NamePrefix+"FLImg"
Endif

If(SimulationImageNameType==1)
UniImageName=NamePrefix+"FL"+num2str(FL_Alpha*1000)+"Al"+num2str(FL_Beta*1000)+"Be"
UniWindowName=NamePrefix+"FL_"+num2str(FL_Alpha*1000)+"Al"+num2str(FL_Beta*1000)+"Be"
ENDif

Uni_BareDispInterc=FL_BareDispInterc
Uni_BareDispCoef=FL_BareDispCoef	
Uni_BareCorrection=FL_BareCorrection	
nvar SFL_Alpha=root:ARPESSimulation:FL_Alpha
nvar SFL_Beta=root:ARPESSimulation:FL_Beta
Uni_a=FL_BareDispInterc
Uni_b=FL_BareDispCoef	
Uni_c=FL_BareCorrection


Make/O/N=(MomentumPoint,EnergyPoint) SFLSpectralFunction, IM, RE, EK0, FermiF
Setscale y  ES, EE, SFLSpectralFunction, IM, RE, EK0, FermiF      //Energy w
SetScale x KS, KE, SFLSpectralFunction, IM, RE, EK0, FermiF      //Momentum k

IM=-abs(SFL_Beta*y^2)
RE=-SFL_Alpha*y
FermiF=1/(exp(11600*y/Temp)+1)
EK0=Uni_a+Uni_b*x+Uni_c*x^2

SFLSpectralFunction=-1/3.1416*IM/((y-EK0-RE)*(y-EK0-RE)+IM*IM)*FermiF
//SFLSpectralFunction=-1/3.1416*IM/((y-EK0-RE)*(y-EK0-RE)+IM*IM)*1

TextOne="a= "+num2str(FL_BareDispInterc)
TextTwo="b= "+num2str(FL_BareDispCoef)
 TextThree="c= "+num2str(FL_BareCorrection)
TextFour="Alpha= "+num2str(FL_Alpha)
 TextFive="Beta= "+num2str(FL_Beta)
 TextSix="Temp.=" + num2str(SimulationTemperature)+"K"



//Energy Resolution Convolution
//-----------------------------------------------------------------------------------------           E Convolution Start
MatrixTranspose SFLSpectralFunction
//Display; AppendImage SFLSpectralFunction
               
              // XJZImginfo(SFLSpectralFunction)
             nx=DimSize(SFLSpectralFunction, 0); 	ny=DimSize(SFLSpectralFunction, 1)
            xmin=DimOffset(SFLSpectralFunction,0);  ymin=DimOffset(SFLSpectralFunction,1);
             xinc=round(dimdelta(SFLSpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(SFLSpectralFunction,1)* 1E6) / 1E6
            xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, xmin, xinc
             //print ny, ymin, yinc
             
                Make/O/N=(nx) ReferenceWave
              ii=0
      	         Do
        		ReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NSFLSpectralFunction
               Make/O/N=(nx) TempEDC
                             
                jj=0
                Do
                TempEDC=SFLSpectralFunction[p][jj]
                 //Convolution for Finite Energy Resolution
               Convolve/A root:ARPESSimulation:GForConvolution, TempEDC             
                NSFLSpectralFunction[] [jj]=TempEDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempEDC vs ReferenceWave

Setscale/I x xmin, xmax, NSFLSpectralFunction
Setscale/I y ymin,ymax, NSFLSpectralFunction

MatrixTranspose NSFLSpectralFunction
//Display; Appendimage NSFLSpectralFunction
//--------------------------------------------------------------------------------------------------------E Convolution End




//Momentum Resolution Convolution
//------------------------------------------------------------------------------------------------------K Convolution Start
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               //XJZImginfo(NSFLSpectralFunction)
             nx=DimSize(NSFLSpectralFunction, 0); 	ny=DimSize(NSFLSpectralFunction, 1)
             xmin=DimOffset(NSFLSpectralFunction,0);  ymin=DimOffset(NSFLSpectralFunction,1);
             xinc=round(DimDelta(NSFLSpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(NSFLSpectralFunction,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) KReferenceWave
                variable Kii=0
      	         Do
        		KReferenceWave[ii]=xmin+xinc*Kii
        		Kii=Kii+1
       	 	While(Kii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NKSFL_SpectralFunction
               Make/O/N=(nx) TempMDC
                      
                Variable Kjj=0
                Do
                TempMDC=NSFLSpectralFunction[p][Kjj]
                 //Convolution for Finite Momentum Resolution
                Convolve/A root:ARPESSimulation:GForKConvolution, TempMDC             
                NKSFL_SpectralFunction[] [Kjj]=TempMDC[p]
                Kjj+=1
	        While(Kjj<ny)
//	        Display TempMDC vs KReferenceWave

Setscale/I x xmin, xmax, NKSFL_SpectralFunction
Setscale/I y ymin,ymax, NKSFL_SpectralFunction

//Display; Appendimage NKSFL_SpectralFunction
//--------------------------------------------------------------------------------------------------------K Convolution End



//Duplicate/O NSFLSpectralFunction, root:ARPESSimulatedImage:$UniImageName  
//Duplicate/O NSFLSpectralFunction, root:DispersionImage:$UniImageName

////Duplicate/O NSFLSpectralFunction, root:ARPESSimulatedImage:$UniImageName  
////Duplicate/O NSFLSpectralFunction, root:DispersionImage:$UniImageName


Duplicate/O NKSFL_SpectralFunction, root:ARPESSimulatedImage:$UniImageName  
Duplicate/O NKSFL_SpectralFunction, root:DispersionImage:$UniImageName



DoWindow $UniWindowName
If (V_Flag==0)
Display/K=1; Appendimage root:ARPESSimulatedImage:$UniImageName  
ModifyImage $UniImageName ctab= {*,*,PlanetEarth,1}
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
Label left "\\Z12\\f01E-E\\BF\\M\\Z12 (eV)";DelayUpdate
Label bottom "\\Z12\\f01Momentum (1/A)"
ModifyGraph standoff=0
ModifyGraph zero(left)=3
SetAxis left ES,EE 

DoWindow/C $UniWindowName
Else
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix 
DoWindow/F $UniWindowName
Endif

//Calculate the Self-Energy
       UniRE="S"+UniImageName+"_RE"
	 UniIM="S"+UniImageName+"_IM"
	 UniEnergy="S"+UniImageName+"_Energy"	
	Make/O/N=(EnergyPoint) SUni_IM, SUni_RE, SUni_Energy
	Setscale x  ES, EE, SUni_IM, SUni_RE, SUni_Energy

	SUni_Energy=x


	SUni_IM=SFL_Beta*x^2
        SUni_RE=-SFL_Alpha*x
	
               Duplicate/O SUni_RE, root:ARPESSimulatedSelfEnergy:$UniRE
               Duplicate/O SUni_IM, root:ARPESSimulatedSelfEnergy:$UniIM
               Duplicate/O SUni_Energy, root:ARPESSimulatedSelfEnergy:$UniEnergy

//Append Bare Dispersion on the Image
Curr1=GetDataFolder(1)
SetDataFolder root:ARPESSimulatedImage
Uni_a=FL_BareDispInterc
Uni_b=FL_BareDispCoef	
Uni_c=FL_BareCorrection
Make/O/N=(MomentumPoint) $Barek, $BareE
SetScale x KS, KE, $BareK, $BareE
wave tmpK=$BareK
wave tmpE=$BareE
tmpK=x
tmpE=Uni_a+Uni_b*x+Uni_c*x*x
//$BareK=x
//$BareE=Uni_a+Uni_b*x+Uni_c*x*x
RemoveFromGraph/Z $BareE vs $BareK
AppendToGraph $BareE vs $BareK
//SetDataFolder Curr1



  
Endif

nvar MFL_CoefSelfEnergy=root:ARPESSimulation:MFL_CoefSelfEnergy
nvar MFL_OmegaC=root:ARPESSimulation:MFL_OmegaC
nvar MFL_BareDispInterc=root:ARPESSimulation:MFL_BareDispInterc
nvar MFL_BareDispCoef=root:ARPESSimulation:MFL_BareDispCoef	
nvar MFL_BareCorrection=root:ARPESSimulation:MFL_BareCorrection

If (SimulationFunctionType==2)
Print "Image from Marginal Fermi Liquid"

BareK="BareK" + "MFL"+NamePrefix
BareE="BareE" + "MFL"+NamePrefix

If (SimulationImageNameType==0)
UniImageName=NamePrefix+"MFL"
UniWindowName=NamePrefix+"MFLImg"
Endif
If(SimulationImageNameType==1)
UniImageName=NamePrefix+"MFL"+num2str(MFL_CoefSelfEnergy*1000)+"c"+num2str(MFL_OmegaC*1000)+"wc"
UniWindowName=NamePrefix+"MFL_"+num2str(MFL_CoefSelfEnergy*1000)+"c"+num2str(MFL_OmegaC*1000)+"wc"
ENDif


Uni_BareDispInterc=MFL_BareDispInterc
Uni_BareDispCoef=MFL_BareDispCoef	
Uni_BareCorrection=MFL_BareCorrection
Variable d=MFL_CoefSelfEnergy
Variable wc=MFL_OmegaC
Uni_a=MFL_BareDispInterc
Uni_b=MFL_BareDispCoef
Uni_c=MFL_BareCorrection

Make/O/N=(MomentumPoint,EnergyPoint) MFLSpectralFunction, IM, RE, EK0, FermiF
Setscale/I y  ES, EE, MFLSpectralFunction, IM, RE, EK0, FermiF      //Energy w
SetScale/I x KS, KE, MFLSpectralFunction, IM, RE, EK0, FermiF      //Momentum k

IM=-d*3.1416/2*max(abs(y),Pi*Temp/12000)
RE=d*y*ln(max(abs(y),Pi*Temp/12000)/wc)
FermiF=1/(exp(12000*y/Temp)+1)
EK0=Uni_a+Uni_b*x+Uni_c*x^2

MFLSpectralFunction=-1/3.1416*IM/((y-EK0-RE)*(y-EK0-RE)+IM*IM)*FermiF

//Energy Resolution Convolution
//-----------------------------------------------------------------------------------------           E Convolution Start
MatrixTranspose MFLSpectralFunction
//Display; AppendImage SFLSpectralFunction
               
              // XJZImginfo(SFLSpectralFunction)
             nx=DimSize(MFLSpectralFunction, 0); 	ny=DimSize(MFLSpectralFunction, 1)
            xmin=DimOffset(MFLSpectralFunction,0);  ymin=DimOffset(MFLSpectralFunction,1);
             xinc=round(dimdelta(MFLSpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(MFLSpectralFunction,1)* 1E6) / 1E6
            xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, xmin, xinc
             //print ny, ymin, yinc
             
                Make/O/N=(nx) ReferenceWave
              ii=0
      	         Do
        		ReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NMFLSpectralFunction
               Make/O/N=(nx) TempEDC
                             
                jj=0
                Do
                TempEDC=MFLSpectralFunction[p][jj]
                 //Convolution for Finite Energy Resolution
               Convolve/A root:ARPESSimulation:GForConvolution, TempEDC             
                NMFLSpectralFunction[] [jj]=TempEDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempEDC vs ReferenceWave

Setscale/I x xmin, xmax,  NMFLSpectralFunction
Setscale/I y ymin,ymax,  NMFLSpectralFunction

MatrixTranspose NMFLSpectralFunction
//Display; Appendimage NSFLSpectralFunction
//--------------------------------------------------------------------------------------------------------E Convolution End




//Momentum Resolution Convolution
//------------------------------------------------------------------------------------------------------K Convolution Start
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               //XJZImginfo(NSFLSpectralFunction)
             nx=DimSize(NMFLSpectralFunction, 0); 	ny=DimSize(NMFLSpectralFunction, 1)
             xmin=DimOffset(NMFLSpectralFunction,0);  ymin=DimOffset(NMFLSpectralFunction,1);
             xinc=round(DimDelta(NMFLSpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(NMFLSpectralFunction,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) KReferenceWave
               ii=0
      	         Do
        		KReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NKMFLSpectralFunction
               Make/O/N=(nx) TempMDC
                      
               jj=0
                Do
                TempMDC=NMFLSpectralFunction[p][jj]
                 //Convolution for Finite Momentum Resolution
                Convolve/A root:ARPESSimulation:GForKConvolution, TempMDC             
                NKMFLSpectralFunction[] [jj]=TempMDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempMDC vs KReferenceWave

Setscale/I x xmin, xmax, NKMFLSpectralFunction
Setscale/I y ymin,ymax, NKMFLSpectralFunction

//Display; Appendimage NKSFL_SpectralFunction
//--------------------------------------------------------------------------------------------------------K Convolution End


 TextOne="a= "+num2str(MFL_BareDispInterc)
 TextTwo="b= "+num2str(MFL_BareDispCoef)
 TextThree="c= "+num2str(MFL_BareCorrection)
 TextFour="d= "+num2str(MFL_CoefSelfEnergy)
 TextFive="wc= "+num2str(MFL_OmegaC)+"eV"
 TextSix="Temp.=" + num2str(SimulationTemperature)+"K"

Duplicate/O NKMFLSpectralFunction, root:ARPESSimulatedImage:$UniImageName  
Duplicate/O NKMFLSpectralFunction, root:DispersionImage:$UniImageName


DoWindow $UniWindowName
If (V_Flag==0)
Display/K=1; Appendimage root:ARPESSimulatedImage:$UniImageName  
ModifyImage $UniImageName ctab= {*,*,PlanetEarth,1}
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
Label left "\\Z12\\f01E-E\\BF\\M\\Z12 (eV)";DelayUpdate
Label bottom "\\Z12\\f01Momentum (1/A)"
ModifyGraph standoff=0
ModifyGraph zero(left)=3
SetAxis left ES,EE 

DoWindow/C $UniWindowName
Else
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix 
DoWindow/F $UniWindowName
Endif

//Calculate the Self-Energy
        UniRE="S"+UniImageName+"_RE"
 UniIM="S"+UniImageName+"_IM"
 UniEnergy="S"+UniImageName+"_Energy"	
	Make/O/N=(EnergyPoint) SUni_IM, SUni_RE, SUni_Energy
	Setscale x  ES, EE, SUni_IM, SUni_RE, SUni_Energy

	SUni_Energy=x


	SUni_IM=d*3.1416/2*max(abs(x),3.1416*Temp/12000)
        SUni_RE=d*x*ln(max(abs(x),3.1416*Temp/12000)/wc)
	
               Duplicate/O SUni_RE, root:ARPESSimulatedSelfEnergy:$UniRE
               Duplicate/O SUni_IM, root:ARPESSimulatedSelfEnergy:$UniIM
               Duplicate/O SUni_Energy, root:ARPESSimulatedSelfEnergy:$UniEnergy
               
//Append Bare Dispersion on the Image
 Curr1=GetDataFolder(1)
SetDataFolder root:ARPESSimulatedImage
Uni_a=MFL_BareDispInterc
Uni_b=MFL_BareDispCoef
Uni_c=MFL_BareCorrection
Make/O/N=(MomentumPoint) $Barek, $BareE
SetScale x KS, KE, $BareK, $BareE
wave tmpK=$BareK
wave tmpE=$BareE
tmpK=x
tmpE=Uni_a+Uni_b*x+Uni_c*x*x
//$BareK=x
//$BareE=Uni_a+Uni_b*x+Uni_c*x*x
RemoveFromGraph/Z $BareE vs $BareK
AppendToGraph $BareE vs $BareK
//SetDataFolder Curr1               

ENDIF

nvar LFL_BareDispInterc=root:ARPESSimulation:LFL_BareDispInterc
nvar LFL_BareDispCoef=root:ARPESSimulation:LFL_BareDispCoef	
nvar LFL_BareCorrection=root:ARPESSimulation:LFL_BareCorrection

If (SimulationFunctionType==3)
Print "Image from Luttinger Fermi Liquid"

////Simulation method please refer to arXiv:cond-mat/0405522 (Already published in EPL)
////1. Get Green Function
////2. Get spectra function
////This is a phenomenology method
////by JXW 2011-07-10

BareK="BareK" + "MFL"+NamePrefix
BareE="BareE" + "MFL"+NamePrefix

If (SimulationImageNameType==0)
UniImageName=NamePrefix+"LTL"
UniWindowName=NamePrefix+"LTLImg"
Endif
If(SimulationImageNameType==1)
UniImageName=NamePrefix+"LTL_"//+num2str(MFL_CoefSelfEnergy*1000)+"c"+num2str(MFL_OmegaC*1000)+"wc"
UniWindowName=NamePrefix+"LTL_"//+num2str(MFL_CoefSelfEnergy*1000)+"c"+num2str(MFL_OmegaC*1000)+"wc"
ENDif

	Uni_BareDispInterc=LFL_BareDispInterc
	Uni_BareDispCoef=LFL_BareDispCoef	
	Uni_BareCorrection=LFL_BareCorrection
	Uni_a=LFL_BareDispInterc
	Uni_b=LFL_BareDispCoef	
	Uni_c=LFL_BareCorrection
	
//Append Bare Dispersion on the Image
Curr1=GetDataFolder(1)
//SetDataFolder root:ARPESSimulatedImage
	Uni_a=LFL_BareDispInterc
	Uni_b=LFL_BareDispCoef	
	Uni_c=LFL_BareCorrection

variable lutts_a,lutts_b,lutts_c,lutt_alpha,lutt_g,lutt_wc
controlinfo/W=ARPES_Simulation_Panel Var_UniBareInterception_lt
lutts_a=V_Value
controlinfo/W=ARPES_Simulation_Panel Var_UniBareCoefficient_lt
lutts_b=V_Value
controlinfo/W=ARPES_Simulation_Panel Var_UniBareCorrection_lt
lutts_c=V_Value 
controlinfo/W=ARPES_Simulation_Panel ltalpha
lutt_alpha=V_Value
controlinfo/W=ARPES_Simulation_Panel ltg
lutt_g=V_Value
controlinfo/W=ARPES_Simulation_Panel ltwc
lutt_wc=V_Value

//make/C/O/N=(MomentumPoint,EnergyPoint) LTL_GF
Make/O/N=(MomentumPoint,EnergyPoint) LTL_AKW,LTL_EKC,LTL_EKS, FermiF
Setscale/I y  ES, EE, LTL_AKW,LTL_EKC,LTL_EKS, FermiF    //Energy w
SetScale/I x KS, KE, LTL_AKW,LTL_EKC,LTL_EKS, FermiF       //Momentum k
FermiF=1/(exp(12000*y/Temp)+1)

//variable/C i_unit=cmplx(0,1)
LTL_EKC=Uni_a+Uni_b*x+Uni_a*x^2
LTL_EKS=lutts_a+lutts_b*x+lutts_c*x^2
//LTL_GF=lutt_wc^(-lutt_alpha)*exp(i_unit*lutt_alpha*pi/2)*lutt_g*H(y-LTL_EKC)*F(y-LTL_EKC)*H(y-LTL_EKS)*F(y-LTL_EKS)*F1(y-LTL_EKC,lutt_alpha)
//LTL_GF=lutt_wc*exp(-lutt_alpha)*exp(i_unit*lutt_alpha*pi/2)*lutt_g/(y-LTL_EKC)^0.5/(y-LTL_EKS)^0.5*(y-LTL_EKC)^(lutt_alpha)
//LTL_AKW=-1/pi*imag(LTL_GF)*FermiF
LTL_AKW=lutt_g*lutt_wc^(-lutt_alpha)/pi*(sin(pi*lutt_alpha/2)*F(y-LTL_EKC,lutt_alpha)*F(y-LTL_EKS,0))
LTL_AKW+=lutt_g*lutt_wc^(-lutt_alpha)/pi*(sin(pi*lutt_alpha/2)*F(-y+LTL_EKC,lutt_alpha)*F(-y+LTL_EKS,0))
LTL_AKW+=lutt_g*lutt_wc^(-lutt_alpha)/pi*(cos(pi*lutt_alpha/2)*F(-y+LTL_EKC,lutt_alpha)*F(y-LTL_EKS,0))
LTL_AKW+=lutt_g*lutt_wc^(-lutt_alpha)/pi*(cos(pi*lutt_alpha/2)*F(y-LTL_EKC,lutt_alpha)*F(-y+LTL_EKS,0))
//LTL_AKW+=lutt_g*lutt_wc^(-lutt_alpha)/pi*(sin(pi*lutt_alpha/2)*H(y-LTL_EKC)*H(y-LTL_EKS)*F(y-LTL_EKC)*F(y-LTL_EKS)*F1(y-LTL_EKC,lutt_alpha))
//LTL_AKW+=lutt_g*lutt_wc^(-lutt_alpha)/pi*(cos(pi*lutt_alpha/2)*H(-y+LTL_EKC)*H(y-LTL_EKS)/(-y+LTL_EKC)^0.5/(y-LTL_EKS)^0.5*(-y+LTL_EKC)^(lutt_alpha))
//LTL_AKW+=lutt_g*lutt_wc^(-lutt_alpha)/pi*(cos(pi*lutt_alpha/2)*H(y-LTL_EKC)*H(-y+LTL_EKS)/(y-LTL_EKC)^0.5/(-y+LTL_EKS)^0.5*(y-LTL_EKC)^(lutt_alpha))
LTL_AKW=LTL_AKW*FermiF

///energy resolution --------------
MatrixTranspose LTL_AKW
//Display; AppendImage EPC_SpectralFunction
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
              // XJZImginfo(EPC_SpectralFunction)
             nx=DimSize(LTL_AKW, 0); 	ny=DimSize(LTL_AKW, 1)
             xmin=DimOffset(LTL_AKW,0);  ymin=DimOffset(LTL_AKW,1);
             xinc=round(DimDelta(LTL_AKW,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(LTL_AKW,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) ReferenceWave
                ii=0
      	         Do
        		ReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NLTL_AKW
               Make/O/N=(nx) TempEDC
                             
                jj=0
                Do
                TempEDC=LTL_AKW[p][jj]
                 //Convolution for Finite Energy Resolution
                Convolve/A root:ARPESSimulation:GForConvolution, TempEDC             
                NLTL_AKW[] [jj]=TempEDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempEDC vs ReferenceWave

Setscale/I x xmin, xmax, NLTL_AKW
Setscale/I y ymin,ymax, NLTL_AKW

MatrixTranspose NLTL_AKW

//Momentum Resolution Convolution
//variable Kii,Kjj
//------------------------------------------------------------------------------------------------------K Convolution Start
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               //XJZImginfo(NSFLSpectralFunction)
             nx=DimSize(NLTL_AKW, 0); 	ny=DimSize(NLTL_AKW, 1)
             xmin=DimOffset(NLTL_AKW,0);  ymin=DimOffset(NLTL_AKW,1);
             xinc=round(DimDelta(NLTL_AKW,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(NLTL_AKW,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) KReferenceWave
               ii=0
      	         Do
        		KReferenceWave[ii]=xmin+xinc*Kii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NKLTL_AKW
               Make/O/N=(nx) TempMDC
                      
               jj=0
                Do
                TempMDC=NLTL_AKW[p][jj]
                 //Convolution for Finite Momentum Resolution
                Convolve/A root:ARPESSimulation:GForKConvolution, TempMDC             
                NKLTL_AKW[] [jj]=TempMDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempMDC vs KReferenceWave

Setscale/I x xmin, xmax, NKLTL_AKW
Setscale/I y ymin,ymax, NKLTL_AKW

Duplicate/O NKLTL_AKW, root:ARPESSimulatedImage:$UniImageName
Duplicate/O NKLTL_AKW, root:DispersionImage:$UniImageName

//string textone,texttwo,textthree,textfour,textfive
textone="\\Z14\\F'symbol'e\\S\\F'arial'c\\M\\Z14(k)="+num2str(Uni_a)+"+"+num2str(Uni_b)+"k"+"+"+num2str(Uni_c)+"k\\S2"
texttwo="\\Z14\\F'symbol'e\\S\\F'arial's\\M\\Z14(k)="+num2str(lutts_a)+"+"+num2str(lutts_b)+"k"+"+"+num2str(lutts_c)+"k\\S2"
textthree="\\Z14\\F'symbol'a="+num2str(lutt_alpha)
textfour="\\Z14\\F'symbol'w\\F'arial'\\Bc\\M\\Z14="+num2str(lutt_wc)
textfive="\\Z14\\F'arial'g="+num2str(lutt_g)

DoWindow $UniWindowName
If (V_Flag==0)
Display/K=1; Appendimage root:ARPESSimulatedImage:$UniImageName  
ModifyImage $UniImageName ctab= {0,*,PlanetEarth,1}
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Label left "\\Z12\\f01E-E\\BF\\M\\Z12 (eV)"
Label bottom "\\Z12\\f01Momentum (1/A)"
ModifyGraph standoff=0
ModifyGraph zero(left)=3
ModifyGraph height={Aspect,1.5}
SetAxis left ES,EE

DoWindow/C $UniWindowName
Else 
DoWindow/F $UniWindowName
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
ModifyGraph height={Aspect,1.5}
Endif
//	abort "Under construction!!! Do you know Spectrafunction in Luttinger Fermi Liquid model??"
//Make/O/N=(MomentumPoint) $Barek, $BareE
//SetScale x KS, KE, $BareK, $BareE
//wave tmpK=$BareK
//wave tmpE=$BareE
//tmpK=x
//tmpE=Uni_a+Uni_b*x+Uni_c*x*x
//$BareK=x
//$BareE=Uni_a+Uni_b*x+Uni_c*x*x
//RemoveFromGraph/Z $BareE vs $BareK
//AppendToGraph $BareE vs $BareK
//SetDataFolder Curr1      	
	
Endif

nvar EPC_BareDispInterc=root:ARPESSimulation:EPC_BareDispInterc
nvar EPC_BareDispCoef=root:ARPESSimulation:EPC_BareDispCoef	
nvar EPC_BareCorrection=root:ARPESSimulation:EPC_BareCorrection
nvar EPC_MassEnhancement=root:ARPESSimulation:EPC_MassEnhancement
nvar EPC_DebyeEnergy=root:ARPESSimulation:EPC_DebyeEnergy

If (SimulationFunctionType==4)
Print "Image from FL plus e_p Coupling--3DDebye Model"

BareK="BareK" + "EPC"+NamePrefix
BareE="BareE" + "EPC"+NamePrefix

If (SimulationImageNameType==0)
UniImageName=NamePrefix+"EPC"
UniWindowName=NamePrefix+"EPCImg"
Endif
If(SimulationImageNameType==1)
UniImageName=NamePrefix+"EPC"+num2str(MFL_CoefSelfEnergy*1000)+"c"+num2str(MFL_OmegaC*1000)+"wc"
UniWindowName=NamePrefix+"EPC_"+num2str(MFL_CoefSelfEnergy*1000)+"c"+num2str(MFL_OmegaC*1000)+"wc"
ENDif

Uni_BareDispInterc=EPC_BareDispInterc
Uni_BareDispCoef=EPC_BareDispCoef	
Uni_BareCorrection=EPC_BareCorrection
Lamda=EPC_MassEnhancement
 w_d=EPC_DebyeEnergy
Uni_a=EPC_BareDispInterc
Uni_b=EPC_BareDispCoef
Uni_c=EPC_BareCorrection


Make/O/N=(MomentumPoint,EnergyPoint) EPC_SpectralFunction, EPC_IM, EPC_RE, EPC_EK0, FermiF
Setscale/I y  ES, EE, EPC_SpectralFunction, EPC_IM, EPC_RE, EPC_EK0, FermiF      //Energy w
SetScale/I x KS, KE, EPC_SpectralFunction, EPC_IM, EPC_RE, EPC_EK0, FermiF       //Momentum k
FermiF=1/(exp(12000*y/Temp)+1)
EPC_EK0=Uni_a+Uni_b*x+Uni_c*x*x

Make/O/N=(EnergyPoint) yE
Setscale/I x  ES, EE, yE
yE=x

Variable iE
Variable iiM=0
Do
iE=0
Do
	If (abs(yE[iE])<=w_d)
	EPC_IM[iiM][iE]=Lamda*3.1416*abs(yE[iE])*abs(yE[iE])*abs(yE[iE])/(3*w_d*w_d)
       Else
	EPC_IM[iiM][iE]=Lamda*3.1416*w_d/3
	Endif
iE+=1
While(iE<EnergyPoint)
iiM+=1
While(iiM<MomentumPoint)


EPC_RE=-(Lamda*w_d/3)*(y*y*y/w_d/w_d/w_d*ln(abs((w_d*w_d-y*y)/y/y)) + ln(abs((w_d+y)/(w_d-y))) +y/w_d)
//EPC_SpectralFunction=1/3.1416*EPC_IM/((y-EPC_EK0-EPC_RE)*(y-EPC_EK0-EPC_RE)+EPC_IM*EPC_IM)*FermiF+0.001
EPC_SpectralFunction=1/3.1416*EPC_IM/((y-EPC_EK0-EPC_RE)*(y-EPC_EK0-EPC_RE)+EPC_IM*EPC_IM)*1+0.001

 TextOne="a= "+num2str(EPC_BareDispInterc)
 TextTwo="b= "+num2str(EPC_BareDispCoef)
 TextThree="c= "+num2str(EPC_BareCorrection)
 TextFour="Lamda= "+num2str(EPC_MassEnhancement)
 TextFive="w_d= "+num2str(EPC_DebyeEnergy)

MatrixTranspose EPC_SpectralFunction
//Display; AppendImage EPC_SpectralFunction
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
              // XJZImginfo(EPC_SpectralFunction)
             nx=DimSize(EPC_SpectralFunction, 0); 	ny=DimSize(EPC_SpectralFunction, 1)
             xmin=DimOffset(EPC_SpectralFunction,0);  ymin=DimOffset(EPC_SpectralFunction,1);
             xinc=round(DimDelta(EPC_SpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(EPC_SpectralFunction,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) ReferenceWave
                ii=0
      	         Do
        		ReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NEPC_SpectralFunction
               Make/O/N=(nx) TempEDC
                             
                jj=0
                Do
                TempEDC=EPC_SpectralFunction[p][jj]
                 //Convolution for Finite Energy Resolution
                Convolve/A root:ARPESSimulation:GForConvolution, TempEDC             
                NEPC_SpectralFunction[] [jj]=TempEDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempEDC vs ReferenceWave

Setscale/I x xmin, xmax, NEPC_SpectralFunction
Setscale/I y ymin,ymax, NEPC_SpectralFunction

MatrixTranspose NEPC_SpectralFunction
//Display; Appendimage NEPC_SpectralFunction

//Momentum Resolution Convolution
//------------------------------------------------------------------------------------------------------K Convolution Start
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               //XJZImginfo(NSFLSpectralFunction)
             nx=DimSize(NEPC_SpectralFunction, 0); 	ny=DimSize(NEPC_SpectralFunction, 1)
             xmin=DimOffset(NEPC_SpectralFunction,0);  ymin=DimOffset(NEPC_SpectralFunction,1);
             xinc=round(DimDelta(NEPC_SpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(NEPC_SpectralFunction,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) KReferenceWave
               ii=0
      	         Do
        		KReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NKEPC_SpectralFunction
               Make/O/N=(nx) TempMDC
                      
               jj=0
                Do
                TempMDC=NEPC_SpectralFunction[p][jj]
                 //Convolution for Finite Momentum Resolution
                Convolve/A root:ARPESSimulation:GForKConvolution, TempMDC             
                NKEPC_SpectralFunction[] [jj]=TempMDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempMDC vs KReferenceWave

Setscale/I x xmin, xmax, NKEPC_SpectralFunction
Setscale/I y ymin,ymax, NKEPC_SpectralFunction

//Display; Appendimage NKSFL_SpectralFunction
//--------------------------------------------------------------------------------------------------------K Convolution End
Duplicate/O NKEPC_SpectralFunction, root:ARPESSimulatedImage:$UniImageName
Duplicate/O NKEPC_SpectralFunction, root:DispersionImage:$UniImageName


DoWindow $UniWindowName
If (V_Flag==0)
Display/K=1; Appendimage root:ARPESSimulatedImage:$UniImageName  
ModifyImage $UniImageName ctab= {*,*,PlanetEarth,1}
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Label left "\\Z12\\f01E-E\\BF\\M\\Z12 (eV)";DelayUpdate
Label bottom "\\Z12\\f01Momentum (1/A)"
ModifyGraph standoff=0
ModifyGraph zero(left)=3
SetAxis left ES,EE

DoWindow/C $UniWindowName
Else 
DoWindow/F $UniWindowName
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif


//Calculate the Self-Energy
       String EPCRE="S"+UniImageName+"_RE"
	String EPCIM="S"+UniImageName+"_IM"
	String EPCEnergy="S"+UniImageName+"_Energy"	
	Make/O/N=(EnergyPoint) SEPC_IM, SEPC_RE, SEPC_Energy
	Setscale x  ES, EE, SEPC_IM, SEPC_RE, SEPC_Energy

	SEPC_Energy=x

	Variable iiIM=0
	Do
	If (abs(SEPC_Energy[iiIM])<=w_d)
	SEPC_IM[iiIM]=Lamda*3.1416*abs(SEPC_Energy[iiIM])*abs(SEPC_Energy[iiIM])*abs(SEPC_Energy[iiIM])/(3*w_d*w_d)*1000
	Else
	SEPC_IM[iiIM]=Lamda*3.1416*w_d/3*1000
	Endif
	iiIM+=1
	While(iiIM<EnergyPoint)


	SEPC_RE=(-(Lamda*w_d/3)*(x*x*x/w_d/w_d/w_d*ln(abs((w_d*w_d-x*x)/x/x)) + ln(abs((w_d+x)/(w_d-x))) +x/w_d))*1000

 
               Duplicate/O SEPC_RE, root:ARPESSimulatedSelfEnergy:$EPCRE
               Duplicate/O SEPC_IM, root:ARPESSimulatedSelfEnergy:$EPCIM
               Duplicate/O SEPC_Energy, root:ARPESSimulatedSelfEnergy:$EPCEnergy
               
//Append Bare Dispersion on the Image
Curr1=GetDataFolder(1)
SetDataFolder root:ARPESSimulatedImage
Uni_a=EPC_BareDispInterc
Uni_b=EPC_BareDispCoef
Uni_c=EPC_BareCorrection
Make/O/N=(MomentumPoint) $Barek, $BareE
SetScale x KS, KE, $BareK, $BareE
wave tmpK=$BareK
wave tmpE=$BareE
tmpK=x
tmpE=Uni_a+Uni_b*x+Uni_c*x*x
RemoveFromGraph/Z $BareE vs $BareK
AppendToGraph $BareE vs $BareK
//SetDataFolder Curr1                    
               
 Endif	

nvar EPC_EinsteinEnergy=root:ARPESSimulation:EPC_EinsteinEnergy

If (SimulationFunctionType==5)
Print "Image from FL plus e_p Coupling--Einstein Model"

BareK="BareK" + "Ein"+NamePrefix
BareE="BareE" + "Ein"+NamePrefix

If (SimulationImageNameType==0)
UniImageName=NamePrefix+"Einstein"
UniWindowName=NamePrefix+"EinsteinIMG"
Endif
If(SimulationImageNameType==1)
UniImageName=NamePrefix+"Ein"+num2str(EPC_MassEnhancement*1000)+"L"+num2str(EPC_EinsteinEnergy*1000)+"DE"
UniWindowName=NamePrefix+"Ein"+num2str(EPC_MassEnhancement*1000)+"L"+num2str(EPC_EinsteinEnergy*1000)+"DE"
Endif


Uni_BareDispInterc=EPC_BareDispInterc
Uni_BareDispCoef=EPC_BareDispCoef	
Uni_BareCorrection=EPC_BareCorrection	
 Lamda=EPC_MassEnhancement
 variable w_e=EPC_EinsteinEnergy
Uni_a=EPC_BareDispInterc
Uni_b=EPC_BareDispCoef
Uni_c=EPC_BareCorrection	


Make/O/N=(MomentumPoint,EnergyPoint) Ein_SpectralFunction, Ein_IM, Ein_RE, Ein_EK0, FermiF
Setscale y  ES, EE, Ein_SpectralFunction, Ein_IM, Ein_RE, Ein_EK0, FermiF      //Energy w
SetScale x KS, KE, Ein_SpectralFunction, Ein_IM, Ein_RE, Ein_EK0, FermiF       //Momentum k
FermiF=1/(exp(12000*y/Temp)+1)
Ein_EK0=Uni_a+Uni_b*x+Uni_c*x^2


Variable c2=0.001
Variable c3=0.0


Ein_RE=-Lamda/Pi*Ln(abs((y+w_e)/(y-w_e)))
Ein_IM=c2 + c3*y^2+Lamda*((y<-w_e) + (y>w_e))

Ein_SpectralFunction=1/3.1416*Ein_IM/((y-Ein_EK0-Ein_RE)*(y-Ein_EK0-Ein_RE)+Ein_IM*Ein_IM)*FermiF

//Energy Resolution Convolution
//-----------------------------------------------------------------------------------------           E Convolution Start
MatrixTranspose Ein_SpectralFunction
//Display; AppendImage SFLSpectralFunction
               
              // XJZImginfo(SFLSpectralFunction)
             nx=DimSize(Ein_SpectralFunction, 0); 	ny=DimSize(Ein_SpectralFunction, 1)
            xmin=DimOffset(Ein_SpectralFunction,0);  ymin=DimOffset(Ein_SpectralFunction,1);
             xinc=round(dimdelta(Ein_SpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(Ein_SpectralFunction,1)* 1E6) / 1E6
            xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, xmin, xinc
             //print ny, ymin, yinc
             
                Make/O/N=(nx) ReferenceWave
              ii=0
      	         Do
        		ReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NEin_SpectralFunction
               Make/O/N=(nx) TempEDC
                             
                jj=0
                Do
                TempEDC=Ein_SpectralFunction[p][jj]
                 //Convolution for Finite Energy Resolution
               Convolve/A root:ARPESSimulation:GForConvolution, TempEDC             
                NEin_SpectralFunction[] [jj]=TempEDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempEDC vs ReferenceWave

Setscale/I x xmin, xmax, NEin_SpectralFunction
Setscale/I y ymin,ymax, NEin_SpectralFunction

MatrixTranspose NEin_SpectralFunction
//Display; Appendimage NSFLSpectralFunction
//--------------------------------------------------------------------------------------------------------E Convolution End




//Momentum Resolution Convolution
//------------------------------------------------------------------------------------------------------K Convolution Start
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               //XJZImginfo(NSFLSpectralFunction)
             nx=DimSize(NEin_SpectralFunction, 0); 	ny=DimSize(NEin_SpectralFunction, 1)
             xmin=DimOffset(NEin_SpectralFunction,0);  ymin=DimOffset(NEin_SpectralFunction,1);
             xinc=round(DimDelta(NEin_SpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(NEin_SpectralFunction,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) KReferenceWave
               ii=0
      	         Do
        		KReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NKEin_SpectralFunction
               Make/O/N=(nx) TempMDC
                      
               jj=0
                Do
                TempMDC=NEin_SpectralFunction[p][jj]
                 //Convolution for Finite Momentum Resolution
                Convolve/A root:ARPESSimulation:GForKConvolution, TempMDC             
                NKEin_SpectralFunction[] [jj]=TempMDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempMDC vs KReferenceWave

Setscale/I x xmin, xmax, NKEin_SpectralFunction
Setscale/I y ymin,ymax, NKEin_SpectralFunction

//Display; Appendimage NKSFL_SpectralFunction
//--------------------------------------------------------------------------------------------------------K Convolution End
 TextOne="a= "+num2str(EPC_BareDispInterc)
 TextTwo="b= "+num2str(EPC_BareDispCoef)
 TextThree="c= "+num2str(EPC_BareCorrection)
 TextFour="f0= "+num2str(EPC_MassEnhancement)
 TextFive="w_e= "+num2str(EPC_EinsteinEnergy) + "eV"

Duplicate/O  NKEin_SpectralFunction, root:ARPESSimulatedImage:$UniImageName  
Duplicate/O  NKEin_SpectralFunction, root:DispersionImage:$UniImageName


DoWindow $UniWindowName
If (V_Flag==0)
Display/K=1; Appendimage root:ARPESSimulatedImage:$UniImageName  
ModifyImage $UniImageName ctab= {*,*,PlanetEarth,1}
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Label left "\\Z12\\f01E-E\\BF\\M\\Z12 (eV)";DelayUpdate
Label bottom "\\Z12\\f01Momentum (1/A)"
ModifyGraph standoff=0
ModifyGraph zero(left)=3
ModifyGraph zero=2
SetAxis left ES,EE

DoWindow/C $UniWindowName
Else 
DoWindow/F $UniWindowName
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif


//Calculate the Self-Energy
       String EinRE="S"+UniImageName+"_RE"
	String EinIM="S"+UniImageName+"_IM"
	String EinEnergy="S"+UniImageName+"_Energy"	
	Make/O/N=(EnergyPoint) SEin_IM, SEin_RE, SEin_Energy
	Setscale x  ES, EE, SEin_IM, SEin_RE, SEin_Energy

	SEin_Energy=x


	SEin_IM=c2 + c3*x^2+Lamda*((x<-w_e) + (x>w_e))*1000

	SEin_RE=-Lamda/Pi*Ln(abs((x+w_e)/(x-w_e)))*1000

 
               Duplicate/O SEin_RE, root:ARPESSimulatedSelfEnergy:$EinRE
               Duplicate/O SEin_IM, root:ARPESSimulatedSelfEnergy:$EinIM
               Duplicate/O SEin_Energy, root:ARPESSimulatedSelfEnergy:$EinEnergy

//Append Bare Dispersion on the Image
 Curr1=GetDataFolder(1)
SetDataFolder root:ARPESSimulatedImage
Uni_a=EPC_BareDispInterc
Uni_b=EPC_BareDispCoef
Uni_c=EPC_BareCorrection	
Make/O/N=(MomentumPoint) $Barek, $BareE
SetScale/I x KS, KE, $BareK, $BareE
wave tmpK=$BareK
wave tmpE=$BareE
tmpK=x
tmpE=Uni_a+Uni_b*x+Uni_c*x*x
RemoveFromGraph/Z $BareE vs $BareK
AppendToGraph $BareE vs $BareK
//SetDataFolder Curr1       

Endif	

nvar Uni_DOSHeight=root:ARPESSimulation:Uni_DOSHeight
nvar Uni_DOSPeakEnergy=root:ARPESSimulation:Uni_DOSPeakEnergy
nvar Uni_ECut=root:ARPESSimulation:Uni_ECut
nvar Uni_AlphaSquared=root:ARPESSimulation:Uni_AlphaSquared
nvar PhononDOSType=root:ARPESSimulation:Uni_PhononDOSType
nvar Uni_CalLamda=root:ARPESSimulation:Uni_CalLamda
nvar Uni_LamdaExpected=root:ARPESSimulation:Uni_LamdaExpected
Variable Uni_DOSH, Uni_PeakE
Variable UEP1D_Lamda
Variable DOSSelection
Variable iE1D,jE
Variable inter

If (SimulationFunctionType==6)
Print "Image from Universal Electron-Phonon Coupling--arbitary F(w)"

BareK="BareK" + "UEP"+NamePrefix
BareE="BareE" + "UEP"+NamePrefix

If (SimulationImageNameType==0)
UniImageName=NamePrefix+"UEP"
UniWindowName=NamePrefix+"UEPImg"
Endif
If(SimulationImageNameType==1)
UniImageName=NamePrefix+"UEP"+num2str(EPC_MassEnhancement*1000)+"L"+num2str(EPC_DebyeEnergy*1000)+"DE"+num2str(abs(EPC_BareDispCoef*1000))+"b"
UniWindowName=NamePrefix+num2str(EPC_MassEnhancement*1000)+"L"+num2str(EPC_DebyeEnergy*1000)+"DE"+num2str(abs(EPC_BareDispCoef*1000))+"b"
Endif



Uni_BareDispInterc=EPC_BareDispInterc
Uni_BareDispCoef=EPC_BareDispCoef	
Uni_BareCorrection=EPC_BareCorrection
 Uni_DOSH=Uni_DOSHeight
 Uni_PeakE=Uni_DOSPeakEnergy
//Variable Uni_ECut=Uni_ECut
Uni_AlphaSq=Uni_AlphaSquared
Uni_a=EPC_BareDispInterc
Uni_b=EPC_BareDispCoef	
Uni_c=EPC_BareCorrection


// Step 0:  First deal with 1D situation because SE is k-independent

//(*). Define F(w)

Make/O/N=(EnergyPoint) FDOS1D, Ener1D, Integ1D_IM, Integ1D_Re, Integ1D_Lamda, UEP1D_IM, UEP1D_RE
SetScale/I x ES, EE, FDOS1D, Ener1D,  Integ1D_IM, Integ1D_Re,  Integ1D_Lamda, UEP1D_IM, UEP1D_RE

Ener1D=x
DOSSelection=PhononDOSType
iE1D=0
//print DOSSelection
svar arbtrarydosname=root:ARPESSimulation:arbtrarydosname
wave tmp=root:ARPESSimulation:$arbtrarydosname
if(waveexists(tmp))
duplicate/O tmp x_tmp
x_tmp=x
endif
Do

IF (DOSSelection==1)
//Triangle Form****************************************************************************************************
FDOS1D[iE1D]=0


IF (Ener1D[iE1D]>=-Uni_PeakE)
	IF (Ener1D[iE1D]<0)
        FDOS1D[iE1D]=Uni_DOSH/Uni_PeakE*abs(Ener1D[iE1D])
        Endif
ENDIF


IF (Ener1D[iE1D]>=-Uni_ECut)
	IF (Ener1D[iE1D]<-Uni_PeakE)
	  FDOS1D[iE1D]=Uni_DOSH-Uni_DOSH/(Uni_ECut-abs(Uni_PeakE))*(abs(Ener1D[iE1D])-Uni_PeakE)
        Endif
ENDIF


//*********************************************************************************************************************
ENDIF


IF (DOSSelection==2)
//3D Debye Form****************************************************************************************************

FDOS1D[iE1D]=0

IF (Ener1D[iE1D]>=-Uni_ECut)
	IF (Ener1D[iE1D]<0)
FDOS1D[iE1D]= Uni_DOSH/(Uni_ECut)^2*abs(Ener1D[iE1D])^2
	Endif
ENDIF


//*********************************************************************************************************************
ENDIF

IF (DOSSelection==3)
//2D Debye Form****************************************************************************************************

FDOS1D[iE1D]=0

IF (Ener1D[iE1D]<0)
	IF (Ener1D[iE1D]>=-Uni_ECut)
	FDOS1D[iE1D]= Uni_DOSH/Uni_ECut*abs(Ener1D[iE1D])
	Endif
ENDIF


//*********************************************************************************************************************
ENDIF


IF (DOSSelection==4)
//Rectangular Form****************************************************************************************************
IF (Ener1D[iE1D]<0)
	IF (Ener1D[iE1D]>=-Uni_ECut)
	FDOS1D[iE1D]= Uni_DOSH
	Endif
ENDIF

IF (Ener1D[iE1D]<-Uni_ECut)
FDOS1D[iE1D]=0
ENDIF

IF (Ener1D[iE1D]>0)
FDOS1D[iE1D]=0
ENDIF

IF (Ener1D[iE1D]==0)
FDOS1D[iE1D]=0
ENDIF
//*********************************************************************************************************************
ENDIF


//Variable Hi1=1
//Variable Gamma1=0.003
//Variable Posi1=-0.03
//Variable Hi2=1
//Variable Gamma2=0.003
//Variable Posi2=-0.05

IF (DOSSelection==5)
//Arbitarty form****************************************************************************************************

if((Ener1D[iE1D]>=wavemin(x_tmp))&&(Ener1D[iE1D]<=wavemax(x_tmp)))
FDOS1D[iE1D]=interp(Ener1D[iE1D],x_tmp,tmp)
else
FDOS1D[iE1D]=0
endif
//FDOS1D=0*(0.002/2)^2/((Ener1D-(-0.03))^2+(0.002/2)^2)+1*(0.002/2)^2/((Ener1D-(-0.05))^2+(0.002/2)^2)
//FDOS1D[iE1D]=interp

//IF (Ener1D[iE1D]<0)
//	IF (Ener1D[iE1D]>=-Uni_ECut)
//	FDOS1D[iE1D]= Uni_DOSH
//	Endif
//ENDIF

//IF (Ener1D[iE1D]<-Uni_ECut))
//FDOS1D[iE1D]=0
//ENDIF

//IF (Ener1D[iE1D]>0)
//FDOS1D[iE1D]=0
//ENDIF

//IF (Ener1D[iE1D]==0)
//FDOS1D[iE1D]=0
//ENDIF
//*********************************************************************************************************************
ENDIF





IF (Ener1D[iE1D]==0)
Ener1D[iE1D]=0.001
//Integ1D_Lamda[iE1D]=Uni_AlphaSq*FDOS1D[iE1D]/Ener1D[iE1D]
Integ1D_Lamda[iE1D]=1*FDOS1D[iE1D]/Ener1D[iE1D]
Else
//Integ1D_Lamda[iE1D]=Uni_AlphaSq*FDOS1D[iE1D]/Ener1D[iE1D]
Integ1D_Lamda[iE1D]=1*FDOS1D[iE1D]/Ener1D[iE1D]
ENDIF

iE1D+=1
While (iE1D<EnergyPoint)

Uni_CalLamda=abs(2*AreaXY(Ener1D,Integ1D_Lamda,0,ES))

Uni_AlphaSq=Uni_LamdaExpected/Uni_CalLamda

nvar Uni_AlphaSquared=root:ARPESSimulation:Uni_AlphaSquared
Uni_AlphaSquared=Uni_AlphaSq

//Print "Calculated UEP1D_Lamda=", root:ARPESSimulation:Uni_CalLamda
//Print "Uni_AlphaSq=", Uni_AlphaSq

DoWindow PhononDOS
If(V_Flag==0)
Display/K=1 FDOS1D vs Ener1D
DoWindow/C PhononDOS
Else
DoWindow/F PhononDOS
Endif

controlinfo/W=ARPES_Simulation_Panel popup_waytogetse

jE=0


DO

//For a given E,  first get the intergrand
inter=0


Do

Integ1D_IM[inter]=Uni_AlphaSq*FDOS1D[inter]*(2/(exp(12000*(Ener1D[inter])/Temp)-1)+1/(exp(12000*(Ener1D[inter]+Ener1D[jE])/Temp)+1)+1/(exp(12000*(Ener1D[inter]-Ener1D[jE])/Temp)+1))

if(V_Value==1)
IF (inter==jE)
//Integ1D_RE[inter]=Integ1D_RE[inter-1]
	if((Ener1D[inter+1]+Ener1D[jE])==0)
		Integ1D_RE[inter]=0//(Integ1D_RE[inter-1]+Uni_AlphaSq*FDOS1D[inter+1]*ln(abs(0.000000001/(Ener1D[inter+1]-Ener1D[jE]))))/2
	else
		//Integ1D_RE[inter]=(Integ1D_RE[inter-1]+Uni_AlphaSq*FDOS1D[inter+1]*ln(abs((Ener1D[inter+1]+Ener1D[jE])/(Ener1D[inter+1]-Ener1D[jE]))))/2
		Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*ln(abs((Ener1D[inter]+Ener1D[jE])/0.0000001))
	endif
Else
	if((Ener1D[inter]+Ener1D[jE])==0)
		Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*ln(abs(0.0000001/(Ener1D[inter]-Ener1D[jE])))
	else
		Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*ln(abs((Ener1D[inter]+Ener1D[jE])/(Ener1D[inter]-Ener1D[jE])))
	endif
ENDIF
endif

if(V_Value==2)
Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*kernal(Ener1D[jE],Ener1D[inter])
endif

inter+=1
While (inter<EnergyPoint)

//Then get the integration

UEP1D_IM[jE]=-Pi*AreaXY(Ener1D,Integ1D_IM,ES,0)
UEP1D_RE[jE]=AreaXY(Ener1D,Integ1D_RE,ES,0)

jE+=1
While(jE<EnergyPoint)
//endif

display/K=1 UEP1D_IM,UEP1D_RE vs ener1D
//Display UEP1D_IM vs Ener1D
//Display UEP1D_RE vs Ener1D

Make/O/N=(MomentumPoint,EnergyPoint) UEP_SpectralFunction, UEP_IM, UEP_RE, UEP_EK0, FermiF, Ener
SetScale/I x KS, KE, UEP_SpectralFunction, UEP_IM, UEP_RE, UEP_EK0, FermiF, Ener      //Momentum k
Setscale/I y  ES, EE, UEP_SpectralFunction, UEP_IM, UEP_RE, UEP_EK0, FermiF, Ener     //Energy w
Ener=y
FermiF=1/(exp(12000*y/Temp)+1)////Not accurate
UEP_EK0=Uni_a+Uni_b*x+Uni_c*x*x


//Get Real and Imaginary Part of Self Energy

//Variable iKK=0
//Variable iEE
//Do
//	iEE=0
//	DO
//	UEP_RE[iKK][iEE]=UEP1D_RE[iEE]
//	UEP_IM[iKK][iEE]=UEP1D_IM[iEE]
//	iEE+=1
//	While (iEE<EnergyPoint)
//iKK+=1
//While (iKK<MomentumPoint)


Variable iKK=0
Do
	UEP_RE[iKK][]=UEP1D_RE[q] //////////jxw debug
	UEP_IM[iKK][]=UEP1D_IM[q] //////////jxw debug
iKK+=1
While (iKK<MomentumPoint)





//Display;  AppendImage FDOS

UEP_SpectralFunction=1/3.1416*UEP_IM/((y-UEP_EK0-UEP_RE)*(y-UEP_EK0-UEP_RE)+UEP_IM*UEP_IM)*FermiF+0.002

 TextOne="a= "+num2str(EPC_BareDispInterc)
 TextTwo="b= "+num2str(EPC_BareDispCoef)
 TextThree="c= "+num2str(EPC_BareCorrection)
 TextFour="Phonon DOS Height: "+num2str(Uni_DOSHeight)
 TextFive="Phonon PeakE: "+num2str(Uni_DOSPeakEnergy)
 TextSix="Phonon ECutoff: "+num2str(Uni_ECut)
string TextSeven="\\F'symbol'a\\S2:\\M\\F'times'"+num2str(Uni_AlphaSquared)
string TextEight="Expected \\F'symbol'l\\F'Times'= "+num2str(Uni_LamdaExpected)

MatrixTranspose UEP_SpectralFunction
//Display; AppendImage UEP_SpectralFunction
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
              // XJZImginfo(UEP_SpectralFunction)
             nx=DimSize(UEP_SpectralFunction, 0); 	ny=DimSize(UEP_SpectralFunction, 1)
             xmin=DimOffset(UEP_SpectralFunction,0);  ymin=DimOffset(UEP_SpectralFunction,1);
             xinc=round(DimDelta(UEP_SpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(UEP_SpectralFunction,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
            // print nx, ny
             
                Make/O/N=(nx) ReferenceWave
                ii=0
      	         Do
        		ReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NUEP_SpectralFunction
               Make/O/N=(nx) TempEDC
                             
                jj=0
                Do
                TempEDC=UEP_SpectralFunction[p][jj]
                 //Convolution for Finite Energy Resolution
                Convolve/A root:ARPESSimulation:GForConvolution, TempEDC             
                NUEP_SpectralFunction[] [jj]=TempEDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempEDC vs ReferenceWave

Setscale/I x xmin, xmax, NUEP_SpectralFunction
Setscale/I y ymin,ymax, NUEP_SpectralFunction

MatrixTranspose NUEP_SpectralFunction
//Display; Appendimage NUEP_SpectralFunction
//Momentum Resolution Convolution
//------------------------------------------------------------------------------------------------------K Convolution Start
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               //XJZImginfo(NSFLSpectralFunction)
             nx=DimSize(NUEP_SpectralFunction, 0); 	ny=DimSize(NUEP_SpectralFunction, 1)
             xmin=DimOffset(NUEP_SpectralFunction,0);  ymin=DimOffset(NUEP_SpectralFunction,1);
             xinc=round(DimDelta(NUEP_SpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(NUEP_SpectralFunction,1)* 1E6) / 1E6
             xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) KReferenceWave
               ii=0
      	         Do
        		KReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NKUEP_SpectralFunction
               Make/O/N=(nx) TempMDC
                      
               jj=0
                Do
                TempMDC=NUEP_SpectralFunction[p][jj]
                 //Convolution for Finite Momentum Resolution
                Convolve/A root:ARPESSimulation:GForKConvolution, TempMDC             
                NKUEP_SpectralFunction[] [jj]=TempMDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempMDC vs KReferenceWave

Setscale/I x xmin, xmax, NKUEP_SpectralFunction
Setscale/I y ymin,ymax, NKUEP_SpectralFunction

//Display; Appendimage NKSFL_SpectralFunction
//--------------------------------------------------------------------------------------------------------K Convolution End

Duplicate/O NKUEP_SpectralFunction, root:ARPESSimulatedImage:$UniImageName  
Duplicate/O NKUEP_SpectralFunction, root:DispersionImage:$UniImageName


DoWindow $UniWindowName
If (V_Flag==0)
Display/K=1; Appendimage root:ARPESSimulatedImage:$UniImageName  
ModifyImage $UniImageName ctab= {*,*,PlanetEarth,1}
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight

Label left "\\Z12\\f01E-E\\BF\\M\\Z12 (eV)";DelayUpdate
Label bottom "\\Z12\\f01Momentum (1/A)"
ModifyGraph standoff=0
ModifyGraph zero(left)=3
SetAxis left ES,EE

DoWindow/C $UniWindowName
Else 
DoWindow/F $UniWindowName
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
Endif


//Calculate the Self-Energy
       String UEPRE="S"+UniImageName+"_RE"
	String UEPIM="S"+UniImageName+"_IM"
	String UEPEnergy="S"+UniImageName+"_Energy"	
	
               Duplicate/O UEP1D_RE, root:ARPESSimulatedSelfEnergy:$UEPRE
               Duplicate/O UEP1D_IM, root:ARPESSimulatedSelfEnergy:$UEPIM
               Duplicate/O Ener1D, root:ARPESSimulatedSelfEnergy:$UEPEnergy


//Append Bare Dispersion on the Image
 Curr1=GetDataFolder(1)
SetDataFolder root:ARPESSimulatedImage
Uni_a=EPC_BareDispInterc
Uni_b=EPC_BareDispCoef	
Uni_c=EPC_BareCorrection
Make/O/N=(MomentumPoint) $Barek, $BareE
SetScale x KS, KE, $BareK, $BareE
wave tmpK=$BareK
wave tmpE=$BareE
tmpK=x
tmpE=Uni_a+Uni_b*x+Uni_c*x*x
RemoveFromGraph/Z $BareE vs $BareK
AppendToGraph $BareE vs $BareK
//SetDataFolder Curr1       
ENDIF	
      

nvar All_BareDispInterc=root:ARPESSimulation:All_BareDispInterc
nvar All_BareDispCoef=root:ARPESSimulation:All_BareDispCoef	
nvar All_BareCorrection=root:ARPESSimulation:All_BareCorrection


//All contributions:  Electron-Electron + Electron-Phonon + Impurity 

If (SimulationFunctionType==7)
Print "Image from All Contributions:  Electron-Electron + Electron-Phonon + Impurity"

BareK="BareK" + "All"+NamePrefix
BareE="BareE" + "All"+NamePrefix

If (SimulationImageNameType==0)
UniImageName=NamePrefix+"All"
UniWindowName=NamePrefix+"AllImg"
Endif
If(SimulationImageNameType==1)
UniImageName=NamePrefix+"All"+num2str(EPC_MassEnhancement*1000)+"L"+num2str(EPC_DebyeEnergy*1000)+"DE"+num2str(abs(EPC_BareDispCoef*1000))+"b"
UniWindowName=NamePrefix+num2str(EPC_MassEnhancement*1000)+"L"+num2str(EPC_DebyeEnergy*1000)+"DE"+num2str(abs(EPC_BareDispCoef*1000))+"b"
Endif



Uni_BareDispInterc=All_BareDispInterc
Uni_BareDispCoef=All_BareDispCoef	
Uni_BareCorrection=All_BareCorrection	
 Uni_DOSH=Uni_DOSHeight
 Uni_PeakE=Uni_DOSPeakEnergy
nvar Uni_ECut=root:ARPESSimulation:Uni_ECut
nvar aa=root:ARPESSimulation:Uni_AlphaSquared
Uni_AlphaSq=aa
nvar All_Alpha=root:ARPESSimulation:FL_Alpha
nvar All_Beta=root:ARPESSimulation:FL_Beta
nvar Impurity=root:ARPESSimulation:All_Impurity 	
Uni_a=All_BareDispInterc
Uni_b=All_BareDispCoef	
Uni_c=All_BareCorrection	


// Step 0:  First deal with 1D situation because SE is k-independent

//(*). Define F(w)

Make/O/N=(EnergyPoint) FDOS1D, Ener1D, Integ1D_IM, Integ1D_Re, Integ1D_Lamda, UEP1D_IM, UEP1D_RE
SetScale x ES, EE, FDOS1D, Ener1D,  Integ1D_IM, Integ1D_Re,  Integ1D_Lamda, UEP1D_IM, UEP1D_RE

Ener1D=x
nvar bb=root:ARPESSimulation:Uni_PhononDOSType
DOSSelection=bb
iE1D=0
svar arbtrarydosname=root:ARPESSimulation:arbtrarydosname
wave tmp=root:ARPESSimulation:$arbtrarydosname
if(waveexists(tmp))
duplicate/O tmp x_tmp
x_tmp=x
endif

Do

IF (DOSSelection==1)
//Triangle Form****************************************************************************************************
IF (abs(Ener1D[iE1D])<=abs(Uni_PeakE))
FDOS1D[iE1D]=Uni_DOSH/Uni_PeakE*abs(Ener1D[iE1D])
ENDIF

IF (abs(Ener1D[iE1D])>abs(Uni_PeakE))
	IF (abs(Ener1D[iE1D])<abs(Uni_ECut))
FDOS1D[iE1D]=Uni_DOSH-Uni_DOSH/(Uni_ECut-abs(Uni_PeakE))*(abs(Ener1D[iE1D])-Uni_PeakE)
	ENDIF
EndIF
//*********************************************************************************************************************
ENDIF


IF (DOSSelection==2)
//3D Debye Form****************************************************************************************************
IF (abs(Ener1D[iE1D])<=abs(Uni_ECut))
FDOS1D[iE1D]= Uni_DOSH*abs(Ener1D[iE1D])^2
ENDIF

IF (abs(Ener1D[iE1D])>abs(Uni_ECut))
FDOS1D[iE1D]=0
ENDIF
//*********************************************************************************************************************
ENDIF

IF (DOSSelection==3)
//2D Debye Form****************************************************************************************************

IF (Ener1D[iE1D]<0)
	IF (Ener1D[iE1D]>=-Uni_ECut)
	FDOS1D[iE1D]= Uni_DOSH*abs(Ener1D[iE1D])
	Endif
ENDIF

IF (Ener1D[iE1D]<-Uni_ECut)
FDOS1D[iE1D]=0
ENDIF

IF (Ener1D[iE1D]>0)
FDOS1D[iE1D]=0
ENDIF

IF (Ener1D[iE1D]==0)
FDOS1D[iE1D]=0
ENDIF
//*********************************************************************************************************************
ENDIF

IF (DOSSelection==4)

//Rectangular Form****************************************************************************************************
IF (Ener1D[iE1D]<0)
	IF (Ener1D[iE1D]>=-Uni_ECut)
	FDOS1D[iE1D]= Uni_DOSH
	Endif
ENDIF

IF (Ener1D[iE1D]<-Uni_ECut)
FDOS1D[iE1D]=0
ENDIF

IF (Ener1D[iE1D]>0)
FDOS1D[iE1D]=0
ENDIF

IF (Ener1D[iE1D]==0)
FDOS1D[iE1D]=0
ENDIF
//*********************************************************************************************************************
endif
IF (DOSSelection==5)
//Arbitarty form****************************************************************************************************

if((Ener1D[iE1D]>=wavemin(x_tmp))&&(Ener1D[iE1D]<=wavemax(x_tmp)))
FDOS1D[iE1D]=interp(Ener1D[iE1D],x_tmp,tmp)
else
FDOS1D[iE1D]=0
endif
FDOS1D[iE1D]=1.0*(0.0004/2)^2/((Ener1D[iE1D]-(-0.04))^2+(0.0004/2)^2)+1*(0.0004/2)^2/((Ener1D[iE1D]-(-0.060))^2+(0.0004/2)^2)
endif
//Redimension/D FDOS1D


//FDOS1D=1*(0.005/2)^2/((Ener1D-(-0.027))^2+(0.005/2)^2)+1.5*(0.005/2)^2/((Ener1D-(-0.045))^2+(0.005/2)^2)+1*(0.005/2)^2/((Ener1D-(-0.060))^2+(0.005/2)^2)+0.5*(0.005/2)^2/((Ener1D-(-0.075))^2+(0.005/2)^2)


//four peaks at 25, 40, 60 and 80 meV
//FDOS1D=0.3*(0.0004/2)^2/((Ener1D-(-0.025))^2+(0.0004/2)^2)+1.*(0.0004/2)^2/((Ener1D-(-0.040))^2+(0.0004/2)^2)+1.0*(0.0004/2)^2/((Ener1D-(-0.060))^2+(0.0004/2)^2)+0.6*(0.0004/2)^2/((Ener1D-(-0.0795))^2+(0.0004/2)^2)

//1 peaks at 70 meV
//FDOS1D=1*(0.0004/2)^2/((Ener1D-(-0.07))^2+(0.0004/2)^2)

//Five peaks at 10, 25, 40, 60 and 80 meV
//FDOS1D=0.5*(0.0004/2)^2/((Ener1D-(-0.010))^2+(0.0004/2)^2)+0.3*(0.0004/2)^2/((Ener1D-(-0.025))^2+(0.0004/2)^2)+1.*(0.0004/2)^2/((Ener1D-(-0.040))^2+(0.0004/2)^2)+1.0*(0.0004/2)^2/((Ener1D-(-0.060))^2+(0.0004/2)^2)+0.6*(0.0004/2)^2/((Ener1D-(-0.081))^2+(0.0004/2)^2)


//Four peaks at 37, 55, 71, and 85 meV
//FDOS1D=0.3*(0.0004/2)^2/((Ener1D-(-0.025))^2+(0.0004/2)^2)+1.*(0.0004/2)^2/((Ener1D-(-0.040))^2+(0.0004/2)^2)+1*(0.0004/2)^2/((Ener1D-(-0.060))^2+(0.0004/2)^2)+0.6*(0.0004/2)^2/((Ener1D-(-0.0805))^2+(0.0004/2)^2)


//One peak at 70 meV
//FDOS1D=1*(0.0004/2)^2/((Ener1D-(-0.061))^2+(0.0004/2)^2)


//Two peaks at 40meV and 60 meV
//FDOS1D=1.0*(0.0004/2)^2/((Ener1D-(-0.04))^2+(0.0004/2)^2)+1*(0.0004/2)^2/((Ener1D-(-0.060))^2+(0.0004/2)^2)



//IF (Ener1D[iE1D]<0)
//	IF (Ener1D[iE1D]>=-Uni_ECut)
//	FDOS1D[iE1D]= Uni_DOSH
//	Endif
//ENDIF

//IF (Ener1D[iE1D]<-Uni_ECut))
//FDOS1D[iE1D]=0
//ENDIF

//IF (Ener1D[iE1D]>0)
//FDOS1D[iE1D]=0
//ENDIF

//IF (Ener1D[iE1D]==0)
//FDOS1D[iE1D]=0
//ENDIF
//*********************************************************************************************************************




IF (Ener1D[iE1D]==0)
Ener1D[iE1D]=0.001
//Integ1D_Lamda[iE1D]=Uni_AlphaSq*FDOS1D[iE1D]/Ener1D[iE1D]
Integ1D_Lamda[iE1D]=1*FDOS1D[iE1D]/Ener1D[iE1D]
Else
//Integ1D_Lamda[iE1D]=Uni_AlphaSq*FDOS1D[iE1D]/Ener1D[iE1D]
Integ1D_Lamda[iE1D]=1*FDOS1D[iE1D]/Ener1D[iE1D]
ENDIF

iE1D+=1
nvar Uni_CalLamda=root:ARPESSimulation:Uni_CalLamda

While (iE1D<EnergyPoint)

Uni_CalLamda=abs(2*AreaXY(Ener1D,Integ1D_Lamda,0,ES))
nvar Uni_LamdaExpected=root:ARPESSimulation:Uni_LamdaExpected
Uni_AlphaSq=Uni_LamdaExpected/Uni_CalLamda

Uni_AlphaSquared=Uni_AlphaSq

//Print "Calculated UEP1D_Lamda=", root:ARPESSimulation:Uni_CalLamda
//Print "Uni_AlphaSq=", Uni_AlphaSq

DoWindow PhononDOS
If(V_Flag==0)
Display/K=1 FDOS1D vs Ener1D
DoWindow/C PhononDOS
Else
DoWindow/F PhononDOS
Endif



jE=0
//Variable inter

DO

//For a given E,  first get the intergrand

Redimension/D Integ1D_IM
Redimension/D UEP1D_IM
Redimension/D UEP1D_RE
//////Redimension/D root:ARPESSimulation:UEP1D_AnyWave_IM
//////Redimension/D root:ARPESSimulation:UEP1D_AnyWave_RE

controlinfo/W=ARPES_Simulation_Panel popup_waytogetse

inter=0

Do

Integ1D_IM[inter]=Uni_AlphaSq*FDOS1D[inter]*(2/(exp(12000*(Ener1D[inter])/Temp)-1)+1/(exp(12000*(Ener1D[inter]+Ener1D[jE])/Temp)+1)+1/(exp(12000*(Ener1D[inter]-Ener1D[jE])/Temp)+1))

//IF (inter==jE)
//Integ1D_RE[inter]=Integ1D_RE[inter-1]
//Integ1D_RE[inter]=(Integ1D_RE[inter-1]+Uni_AlphaSq*FDOS1D[inter+1]*ln(abs((Ener1D[inter+1]+Ener1D[jE])/(Ener1D[inter+1]-Ener1D[jE]))))/2
//Else
//Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*ln(abs((Ener1D[inter]+Ener1D[jE])/(Ener1D[inter]-Ener1D[jE])))
//ENDIF

if(V_Value==1)
IF (inter==jE)
//Integ1D_RE[inter]=Integ1D_RE[inter-1]
	if((Ener1D[inter+1]+Ener1D[jE])==0)
		Integ1D_RE[inter]=0//(Integ1D_RE[inter-1]+Uni_AlphaSq*FDOS1D[inter+1]*ln(abs(0.000000001/(Ener1D[inter+1]-Ener1D[jE]))))/2
	else
		//Integ1D_RE[inter]=(Integ1D_RE[inter-1]+Uni_AlphaSq*FDOS1D[inter+1]*ln(abs((Ener1D[inter+1]+Ener1D[jE])/(Ener1D[inter+1]-Ener1D[jE]))))/2
		Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*ln(abs((Ener1D[inter]+Ener1D[jE])/0.000000001))
	endif
Else
	if((Ener1D[inter]+Ener1D[jE])==0)
		Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*ln(abs(0.000000001/(Ener1D[inter]-Ener1D[jE])))
	else
		Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*ln(abs((Ener1D[inter]+Ener1D[jE])/(Ener1D[inter]-Ener1D[jE])))
	endif
ENDIF
endif

if(V_Value==2)
Integ1D_RE[inter]=Uni_AlphaSq*FDOS1D[inter]*kernal(Ener1D[jE],Ener1D[inter])
endif

inter+=1
While (inter<EnergyPoint)

//Then get the integration


UEP1D_IM[jE]=-Pi*AreaXY(Ener1D,Integ1D_IM,ES,0)
UEP1D_RE[jE]=AreaXY(Ener1D,Integ1D_RE,ES,0)

jE+=1
While(jE<EnergyPoint)


//Display UEP1D_IM vs Ener1D
Display/K=1 UEP1D_RE vs Ener1D



//Replace here the calculated Self-Energy with  any form of self-energy

//////UEP1D_IM=root:ARPESSimulation:UEP1D_AnyWave_IM
//////UEP1D_RE=root:ARPESSimulation:UEP1D_AnyWave_RE



Make/O/N=(MomentumPoint,EnergyPoint) UEP_SpectralFunction, UEP_IM, UEP_RE, UEP_EK0, FermiF, Ener, EE_IM, EE_RE, All_IM, All_RE
REdimension/D UEP_SpectralFunction, UEP_IM, UEP_RE, UEP_EK0, FermiF, Ener, EE_IM, EE_RE, All_IM, All_RE
SetScale x KS, KE, UEP_SpectralFunction, UEP_IM, UEP_RE, UEP_EK0, FermiF, Ener,  EE_IM, EE_RE, All_IM, All_RE     //Momentum k
Setscale y  ES, EE, UEP_SpectralFunction, UEP_IM, UEP_RE, UEP_EK0, FermiF, Ener,  EE_IM, EE_RE, All_IM, All_RE     //Energy w
Ener=y
FermiF=1/(exp(12000*y/Temp)+1)
UEP_EK0=Uni_a+Uni_b*x+Uni_c*x*x


//Get Real and Imaginary Part of Self Energy for Electron-Phonon Coupling

Variable iiKK=0
Do
	UEP_RE[iiKK][]=UEP1D_RE[q]
	UEP_IM[iiKK][]=UEP1D_IM[q]
iiKK+=1
While (iiKK<MomentumPoint)
//Display;  AppendImage FDOS


//Get Real and Imaginary Part of Self Energy for Electron-Electron Coorelation

//EE_RE=All_Alpha*Ener
//EE_IM=All_Beta*(Ener)^2


//Get Real and Imaginary Part of Self Energy for Electron-Electron Coorelation + Electron-Phonon Contributions + Impurity

All_RE=UEP_RE-All_Alpha*Ener
All_IM=UEP_IM+All_Beta*(Ener)^2+Impurity

//Edit UEP_RE
//Edit  UEP_IM

//UEP_SpectralFunction=1/3.1416*UEP_IM/((y-UEP_EK0-UEP_RE)*(y-UEP_EK0-UEP_RE)+UEP_IM*UEP_IM)*FermiF+0.002

Redimension/D UEP_SpectralFunction

UEP_SpectralFunction=1/3.1416*All_IM/((y-UEP_EK0-All_RE)*(y-UEP_EK0-All_RE)+All_IM*All_IM)*FermiF+0.002
//

 TextOne="a= "+num2str(All_BareDispInterc)
 TextTwo="b= "+num2str(All_BareDispCoef)
 TextThree="c= "+num2str(All_BareCorrection)
 TextFour="Phonon DOS Height: "+num2str(Uni_DOSHeight)
 TextFive="Phonon PeakE: "+num2str(Uni_DOSPeakEnergy)
 TextSix="Phonon ECutoff: "+num2str(Uni_ECut)
 TextSeven="\\F'symbol'a\\S2\\M\\F'Times':"+num2str(Uni_AlphaSquared)
 TextEight="Expected \\F'symbol'l\\F'Times'= "+num2str(Uni_LamdaExpected)
String TextNine="Electron \\F'symbol'a\\F'Times'="+num2str(FL_Alpha)
String TextTen="Electron \\F'symbol'b\\F'Times'="+num2str(FL_Beta)
nvar All_Impurity=root:ARPESSimulation:All_Impurity
String TextEleven="Impurity="+num2str(All_Impurity)




//Energy Resolution Convolution
//------------------------------------------------------------------------------------------------------E Convolution Start
MatrixTranspose UEP_SpectralFunction
//Display; AppendImage UEP_SpectralFunction
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               //XJZImginfo(UEP_SpectralFunction)
             nx=DimSize(UEP_SpectralFunction, 0); 	ny=DimSize(UEP_SpectralFunction, 1)
             xmin=DimOffset(UEP_SpectralFunction,0);  ymin=DimOffset(UEP_SpectralFunction,1);
             xinc=round(DimDelta(UEP_SpectralFunction,0) * 1E6) / 1E6	
	         yinc=round(DimDelta(UEP_SpectralFunction,1)* 1E6) / 1E6
	         xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) ReferenceWave
               ii=0
      	         Do
        		ReferenceWave[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NUEP_SpectralFunction
               Make/O/N=(nx) TempEDC
                      
               jj=0
                Do
                TempEDC=UEP_SpectralFunction[p][jj]
                 //Convolution for Finite Energy Resolution
                Convolve/A root:ARPESSimulation:GForConvolution, TempEDC             
                NUEP_SpectralFunction[][jj]=TempEDC[p]
                jj+=1
	        While(jj<ny)
//	        Display TempEDC vs ReferenceWave

Setscale/I x xmin, xmax, NUEP_SpectralFunction
Setscale/I y ymin,ymax, NUEP_SpectralFunction

MatrixTranspose NUEP_SpectralFunction
//print dimoffset(NUEP_SpectralFunction,0),dimoffset(NUEP_SpectralFunction,0)+(dimsize(NUEP_SpectralFunction,0)-1)*dimdelta(NUEP_SpectralFunction,0)
//Display; Appendimage NUEP_SpectralFunction
//--------------------------------------------------------------------------------------------------------E Convolution End


//Momentum Resolution Convolution
//------------------------------------------------------------------------------------------------------K Convolution Start
               //Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
              // XJZImginfo(NUEP_SpectralFunction)
             nx=DimSize(NUEP_SpectralFunction, 0); 	ny=DimSize(NUEP_SpectralFunction, 1)
             xmin=DimOffset(NUEP_SpectralFunction,0);  ymin=DimOffset(NUEP_SpectralFunction,1);
             xinc=round(DimDelta(NUEP_SpectralFunction,0) * 1E6) / 1E6	
	        yinc=round(DimDelta(NUEP_SpectralFunction,1)* 1E6) / 1E6
	        xmax=xmin+(nx-1)*xinc;ymax=ymin+(ny-1)*yinc
             //print nx, ny
             
                Make/O/N=(nx) KReferenceWave
                variable Kiii=0
      	         Do
        		KReferenceWave[ii]=xmin+xinc*Kiii
        		Kiii=Kiii+1
       	 	While(Kiii<nx)
//       	 Edit ReferenceWave
        
               Make/O/N=(nx,ny) NKUEP_SpectralFunction
               Make/O/N=(nx) TempMDC
                      
                Variable Kjjj=0
                Do
                TempMDC=NUEP_SpectralFunction[p][Kjjj]
                 //Convolution for Finite Momentum Resolution
                Convolve/A root:ARPESSimulation:GForKConvolution, TempMDC             
                NKUEP_SpectralFunction[] [Kjjj]=TempMDC[p]
                Kjjj+=1
	        While(Kjjj<ny)
//	        Display TempMDC vs KReferenceWave

Setscale/I x xmin, xmax, NKUEP_SpectralFunction
Setscale/I y ymin,ymax, NKUEP_SpectralFunction

//Display; Appendimage NKUEP_SpectralFunction
//--------------------------------------------------------------------------------------------------------K Convolution End



//Duplicate/O NUEP_SpectralFunction, root:ARPESSimulatedImage:$UniImageName  
//Duplicate/O NUEP_SpectralFunction, root:DispersionImage:$UniImageName

Duplicate/O NKUEP_SpectralFunction, root:ARPESSimulatedImage:$UniImageName  
Duplicate/O NKUEP_SpectralFunction, root:DispersionImage:$UniImageName



DoWindow $UniWindowName
If (V_Flag==0)
Display/K=1; Appendimage root:ARPESSimulatedImage:$UniImageName  
ModifyImage $UniImageName ctab= {*,*,PlanetEarth,1}
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
AppendText/N=text0 TextNine
AppendText/N=text0 TextTen
AppendText/N=text0 TextEleven

Label left "\\Z12\\f01E-E\\BF\\M\\Z12 (eV)";DelayUpdate
Label bottom "\\Z12\\f01Momentum (1/A)"
ModifyGraph standoff=0
ModifyGraph zero(left)=3
SetAxis left ES,EE

DoWindow/C $UniWindowName
Else 
DoWindow/F $UniWindowName
Textbox/C/N=text0/A=LB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
AppendText/N=text0 TextNine
AppendText/N=text0 TextTen
AppendText/N=text0 TextEleven
Endif


//Calculate the Self-Energy
       String AllRE="S"+UniImageName+"_RE"
	String AllIM="S"+UniImageName+"_IM"
	String AllEnergy="S"+UniImageName+"_Energy"	
	
	
	Make/O/N=(EnergyPoint) SAll_IM, SAll_RE, SAll_Energy
	Setscale x  ES, EE, SAll_IM, SAll_RE, SAll_Energy

	SAll_Energy=x


	SAll_IM=UEP1D_IM+All_Beta*(SAll_Energy)^2+Impurity
       SAll_RE=abs(UEP1D_RE)+abs(All_Alpha*SAll_Energy)
        
        
	
               Duplicate/O SAll_RE, root:ARPESSimulatedSelfEnergy:$AllRE
               Duplicate/O SAll_IM, root:ARPESSimulatedSelfEnergy:$AllIM
               Duplicate/O SAll_Energy, root:ARPESSimulatedSelfEnergy:$AllEnergy	
               
//Append Bare Dispersion on the Image
 Curr1=GetDataFolder(1)
SetDataFolder root:ARPESSimulatedImage
Uni_a=All_BareDispInterc
Uni_b=All_BareDispCoef	
Uni_c=All_BareCorrection	
Make/O/N=(MomentumPoint) $Barek, $BareE
SetScale x KS, KE, $BareK, $BareE
wave tmpK=$BareK
wave tmpE=$BareE
tmpK=x
tmpE=Uni_a+Uni_b*x+Uni_c*x*x
RemoveFromGraph/Z $BareE vs $BareK
AppendToGraph $BareE vs $BareK
//SetDataFolder Curr1       
        
ENDIF	

SetDataFolder root:ARPESSimulatedImage	
svar SimulatedImageFileList=root:ARPESSimulation:SimulatedImageFileList
SimulatedImageFileList=WaveList("*",";","DIMS:2")     
SetDataFolder Curr	
	
END



Function GetEDCSimulationSpectra(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String EDCWindowName="EDC"+popStr
	String Curr=GetDataFolder(1)

//	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"t",0)
//	String ThetaAngleForImage=popStr[Positionoft,ImageNameLength-1]
	
//Kill EDC Curves in root:ARPESSimulatedSpectra
	SetDataFolder root:ARPESSimulatedSpectra
	String ToBeKilledEDCList=WaveList("*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	     Variable iEDC=0
	     Do
	     EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	     KillWaves/Z  $EDCCurve
	     iEDC+=1
	     While(iEDC<NoofKilledEDCList)


        WAVE NImage=root:ARPESSimulatedImage:$popStr
        NVar Offset=root:ARPESSimulation:EDCOffSet
        NVar SpecBind=root:ARPESSimulation:EDCBinding	
        
//      Display; Appendimage NImage

       
      SetDataFolder Root:ARPESSimulatedSpectra
        	
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
        XJZImginfo(NNImage)


//        NVAR EnergyStart=root:PROCESS:ProcessedImageEnergyStart
//        NVAR EnergyEnd=root:PROCESS:ProcessedImageEnergyEnd
 
        Duplicate/O NImage, NNImage
        MatrixTranspose NNImage
//      Display; Appendimage NImage 
        XJZImginfo(NNImage)


//     Gaussian for Energy Resolution convolution
//       Make/O/N=(nx) GForConvolution
//       Setscale/I x -0.1,0.1, GForConvolution
//       NVar     EResolutionforC=root:ARPESSimulation:SimulationEnergyResolution
//       Variable     ERforC=EResolutionforC/1000/2/sqrt(ln(2))
//       GForConvolution=exp(-(x/ERforC)^2)
//    Display GForConvolution

              String ReferenceEnergyWave="Energy"+ProcImage 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 
                String   PlotName0=popstr+"0"
                String   EDC0=PlotName0
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=NNImage[p] [0]
                 //Convolution for Finite Energy Resolution
//                 Convolve/A GForConvolution, EDCC


                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=SpecBind               
                
                DoWindow $EDCWindowName
	         if(V_flag==0)
                Display/K=1  EDCC vs ReferenceEnergy as ProcImage
            	  DoWindow/C $EDCWindowName
	        Textbox/N=text0/F=0  ThetaAngleForImage
	         ModifyGraph margin(left)=29
	         
	         Do
                 PlotName=ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=NNImage[p] [i]+Offset*i
                 //Convolution for Finite Energy Resolution
//                 Convolve/A GForConvolution, EDCSpectra
                 AppendToGraph EDCSpectra vs ReferenceEnergy 
	          i=i+SpecBind
	          While(i<ny) 
	        
	            		
	        Else
	        DoWindow/K $EDCWindowName
	       
                DoWindow $EDCWindowName
	         Display/K=1  EDCC vs ReferenceEnergy as ProcImage
        	  DoWindow/C $EDCWindowName
	         ModifyGraph margin(left)=29
	         
	         Do
                 PlotName=ProcImage+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=NNImage[p] [i]+Offset*i
                 //Convolution for Finite Energy Resolution
//                 Convolve/A GForConvolution, EDCSpectra
                 AppendToGraph EDCSpectra vs ReferenceEnergy 
	          i=i+SpecBind
	          While(i<ny) 
	        	
	        	Endif  
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
//               ModifyGraph noLabel(left)=2

SetDataFolder Curr	 
END




Proc GetSimulationDispersion(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String DispersionWindowName="SimulatedDisp"+popStr
	String Curr=GetDataFolder(1)
	
//	GetEDCSimulationImage(ctrlName)

SetDataFolder root:ARPESSimulation


string      SPW=popStr+"PW",SPosition=popstr+"Position", 
String     SWidth=popStr+"Width", SEnergy=popStr+"Energy"
Variable nx=DimSize(root:ARPESSimulatedImage:$popStr, 0) 	
Variable ny=DimSize(root:ARPESSimulatedImage:$popStr, 1)
Variable ymin=DimOffset(root:ARPESSimulatedImage:$popStr,1)
Variable yinc=round(DimDelta(root:ARPESSimulatedImage:$popStr,1)* 1E6) / 1E6
		Make/O/N=(ny) $SPosition, $SWidth, $SEnergy
		Make/C/O/N=(ny) $SPW
		SetScale/P x ymin, yinc, "" $SPW,  $SPosition, $SWidth, $SEnergy
		root:ARPESSimulatedImage:$popStr-=0.1
              $SPW=XJZPEAK2D( root:ARPESSimulatedImage:$popStr, root:ARPESSimulation:MomentumKStart, root:ARPESSimulation:MomentumKEnd, x, 0 )
              $SPosition=REAL($SPW)
              $SWidth=Imag($SPW)
              $SEnergy=x
               Duplicate/O $SPosition, root:ARPESSimulatedDispersion:$SPosition
               Duplicate/O $SWidth, root:ARPESSimulatedDispersion:$SWidth  
               Duplicate/O $SEnergy, root:ARPESSimulatedDispersion:$SEnergy                   


DoWindow $DispersionWindowName
If (V_Flag==0)

               Display/K=1 root:ARPESSimulatedDispersion:$SEnergy  vs root:ARPESSimulatedDispersion:$SPosition
               SetAxis/A/R bottom
               ModifyGraph mode($SEnergy)=0,lsize($SEnergy)=2,rgb($SEnergy)=(0,0,0)
               ModifyGraph standoff=0
               ModifyGraph mirror=2
               Label left "\\Z14\\f01E - E\\BF\\M\\Z14 (eV)";DelayUpdate
               Label bottom "\\Z14\\f01Momentum (1/A)"
               ModifyGraph manTick(bottom)={0,0.02,0,2},manMinor(bottom)={1,0}
               ModifyGraph zero=2
               

If (root:ARPESSimulation:SimulationFunctionType==1)
Print "Dispersion from Standard Fermi Liquid"
String BareK="BareK" +"FL"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"FL"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Alpha= "+num2str(root:ARPESSimulation:FL_Alpha)
String TextFive="Beta= "+num2str(root:ARPESSimulation:FL_Beta)
String TextSix="Temp.=" + num2str(root:ARPESSimulation:SimulationTemperature)+"K"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
Endif

If (root:ARPESSimulation:SimulationFunctionType==2)
Print "Dispersion from Marginal Fermi Liquid"
String BareK="BareK" +"MFL"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"MFL"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="d= "+num2str(root:ARPESSimulation:MFL_CoefSelfEnergy)
String TextFive="wc= "+num2str(root:ARPESSimulation:MFL_OmegaC)+"eV"
String TextSix="Temp.=" + num2str(root:ARPESSimulation:SimulationTemperature)+"K"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
Endif
If (root:ARPESSimulation:SimulationFunctionType==3)
Print "Dispersion from Luttinger Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==4)
Print "Dispersion from FL plus e_p Coupling--3D Debye"
String BareK="BareK" +"3DD"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"3DD"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:EPC_MassEnhancement)
String TextFive="w_d= "+num2str(root:ARPESSimulation:EPC_DebyeEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==5)
Print "Dispersion from FL plus e_p Coupling--Einstein"
String BareK="BareK" +"Ein"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"Ein"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:Uni_MassEnhancement)
String TextFive="w_e= "+num2str(root:ARPESSimulation:Uni_EinsteinEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==6)
Print "Dispersion Universal e_p Coupling"
String BareK="BareK" +"UEP"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"UEP"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Phonon DOS Height: "+num2str(root:ARPESSimulation:Uni_DOSHeight)
String TextFive="Phonon PeakE: "+num2str(root:ARPESSimulation:Uni_DOSPeakEnergy)
String TextSix="Phonon ECutoff: "+num2str(root:ARPESSimulation:Uni_ECut)
String TextSeven="Alpha*Alpha:"+num2str(root:ARPESSimulation:Uni_AlphaSquared)
String TextEight="Expected Lamda= "+num2str(root:ARPESSimulation:Uni_LamdaExpected)
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
Endif


If (root:ARPESSimulation:SimulationFunctionType==7)
Print "Dispersion From All Contributions--electron-electron, electron-phonon and Impurity"
String BareK="BareK" +"All"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"All"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Phonon DOS Height: "+num2str(root:ARPESSimulation:Uni_DOSHeight)
String TextFive="Phonon PeakE: "+num2str(root:ARPESSimulation:Uni_DOSPeakEnergy)
String TextSix="Phonon ECutoff: "+num2str(root:ARPESSimulation:Uni_ECut)
String TextSeven="Alpha*Alpha:"+num2str(root:ARPESSimulation:Uni_AlphaSquared)
String TextEight="Expected Lamda= "+num2str(root:ARPESSimulation:Uni_LamdaExpected)
String TextNine="Electron Alpha="+num2str(root:ARPESSimulation:FL_Alpha)
String TextTen="Electron Beta="+num2str(root:ARPESSimulation:FL_Beta)
String TextEleven="Impurity="+num2str(root:ARPESSimulation:All_Impurity)
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
AppendText/N=text0 TextNine
AppendText/N=text0 TextTen
AppendText/N=text0 TextEleven
Endif



//Append Bare Dispersion on the Image
String Curr1=GetDataFolder(1)



Variable Uni_a=root:ARPESSimulation:Uni_BareDispInterc
Variable Uni_b=root:ARPESSimulation:Uni_BareDispCoef	
Variable Uni_c=root:ARPESSimulation:Uni_BareCorrection	
Variable ES=root:ARPESSimulation:BindingEnergyStart
Variable EE=root:ARPESSimulation:BindingEnergyEnd
Variable KS=root:ARPESSimulation:MomentumKStart*1
Variable KE=root:ARPESSimulation:MomentumKEnd*1
Variable MomentumPoint=root:ARPESSimulation:NumberofMomentumPoints
Variable EnergyPoint=root:ARPESSimulation:NumberofEnergyPoints
Variable Temp=root:ARPESSimulation:SimulationTemperature

SetDataFolder root:ARPESSimulatedImage

//String BareK="BareK" +root:ARPESSimulation:NamePrefix
//String BareE="BareE" +root:ARPESSimulation:NamePrefix

RemoveFromGraph/Z $BareE
Make/O/N=(MomentumPoint) $Barek, $BareE
SetScale x KS, KE, $BareK, $BareE
$BareK=x
$BareE=Uni_a+Uni_B*x+Uni_c*x*x
AppendToGraph $BareE vs $BareK
SetAxis left ES,EE 

SetDataFolder Curr1


DoWindow/C $DispersionWindowName
Else 
DoWindow/F $DispersionWindowName

If (root:ARPESSimulation:SimulationFunctionType==1)
Print "Dispersion from Standard Fermi Liquid"
String BareK="BareK" +"FL"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"FL"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Alpha= "+num2str(root:ARPESSimulation:FL_Alpha)
String TextFive="Beta= "+num2str(root:ARPESSimulation:FL_Beta)
String TextSix="Temp.=" + num2str(root:ARPESSimulation:SimulationTemperature)+"K"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
Endif

If (root:ARPESSimulation:SimulationFunctionType==2)
Print "Dispersion from Marginal Fermi Liquid"
String BareK="BareK" +"MFL"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"MFL"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="d= "+num2str(root:ARPESSimulation:MFL_CoefSelfEnergy)
String TextFive="wc= "+num2str(root:ARPESSimulation:MFL_OmegaC)+"eV"
String TextSix="Temp.=" + num2str(root:ARPESSimulation:SimulationTemperature)+"K"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
Endif
If (root:ARPESSimulation:SimulationFunctionType==3)
Print "Dispersion from Luttinger Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==4)
Print "Dispersion from FL plus e_p Coupling--3D Debye"
String BareK="BareK" +"3DD"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"3DD"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:EPC_MassEnhancement)
String TextFive="w_d= "+num2str(root:ARPESSimulation:EPC_DebyeEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==5)
Print "Dispersion from FL plus e_p Coupling--Einstein"
String BareK="BareK" +"Ein"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"Ein"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:Uni_MassEnhancement)
String TextFive="w_e= "+num2str(root:ARPESSimulation:Uni_EinsteinEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==6)
Print "Dispersion Universal e_p Coupling"
String BareK="BareK" +"UEP"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"UEP"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Phonon DOS Height: "+num2str(root:ARPESSimulation:Uni_DOSHeight)
String TextFive="Phonon PeakE: "+num2str(root:ARPESSimulation:Uni_DOSPeakEnergy)
String TextSix="Phonon ECutoff: "+num2str(root:ARPESSimulation:Uni_ECut)
String TextSeven="Alpha*Alpha:"+num2str(root:ARPESSimulation:Uni_AlphaSquared)
String TextEight="Expected Lamda= "+num2str(root:ARPESSimulation:Uni_LamdaExpected)
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
Endif


If (root:ARPESSimulation:SimulationFunctionType==7)
Print "Dispersion From All Contributions--electron-electron, electron-phonon and Impurity"
String BareK="BareK" +"All"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"All"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Phonon DOS Height: "+num2str(root:ARPESSimulation:Uni_DOSHeight)
String TextFive="Phonon PeakE: "+num2str(root:ARPESSimulation:Uni_DOSPeakEnergy)
String TextSix="Phonon ECutoff: "+num2str(root:ARPESSimulation:Uni_ECut)
String TextSeven="Alpha*Alpha:"+num2str(root:ARPESSimulation:Uni_AlphaSquared)
String TextEight="Expected Lamda= "+num2str(root:ARPESSimulation:Uni_LamdaExpected)
String TextNine="Electron Alpha="+num2str(root:ARPESSimulation:FL_Alpha)
String TextTen="Electron Beta="+num2str(root:ARPESSimulation:FL_Beta)
String TextEleven="Impurity="+num2str(root:ARPESSimulation:All_Impurity)
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
AppendText/N=text0 TextNine
AppendText/N=text0 TextTen
AppendText/N=text0 TextEleven
Endif


ENDIF


SetDataFolder Curr
END



Proc GetRealSEfromMDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String ProcImage=popStr
	String DispersionWindowName="SEfromMDC_"+popStr
	String Curr=GetDataFolder(1)
	
//	GetEDCSimulationImage(ctrlName)

SetDataFolder root:ARPESSimulation


string      SPW=popStr+"PW",SPosition=popstr+"Position", 
String     SWidth=popStr+"Width", SEnergy=popStr+"Energy"
Variable nx=DimSize(root:ARPESSimulatedImage:$popStr, 0) 	
Variable ny=DimSize(root:ARPESSimulatedImage:$popStr, 1)
Variable ymin=DimOffset(root:ARPESSimulatedImage:$popStr,1)
Variable yinc=round(DimDelta(root:ARPESSimulatedImage:$popStr,1)* 1E6) / 1E6
		Make/O/N=(ny) $SPosition, $SWidth, $SEnergy
		Make/C/O/N=(ny) $SPW
		SetScale/P x ymin, yinc, "" $SPW,  $SPosition, $SWidth, $SEnergy
		root:ARPESSimulatedImage:$popStr-=0.1
              $SPW=XJZPEAK2D( root:ARPESSimulatedImage:$popStr, root:ARPESSimulation:MomentumKStart, root:ARPESSimulation:MomentumKEnd, x, 0 )
              $SPosition=REAL($SPW)
              $SWidth=Imag($SPW)
              $SEnergy=x
//               Duplicate/O $SPosition, root:ARPESSimulatedDispersion:$SPosition
//               Duplicate/O $SWidth, root:ARPESSimulatedDispersion:$SWidth  
//               Duplicate/O $SEnergy, root:ARPESSimulatedDispersion:$SEnergy    

                Duplicate/O $SPosition, root:ARPESRealSEfromMDC:$SPosition
                Duplicate/O $SEnergy, root:ARPESRealSEfromMDC:$SEnergy    
             


DoWindow $DispersionWindowName
If (V_Flag==0)

If (root:ARPESSimulation:SimulationFunctionType==1)
Print "Dispersion from Standard Fermi Liquid"
String BareK="BareK" +"FL"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"FL"+root:ARPESSimulation:NamePrefix
Endif

If (root:ARPESSimulation:SimulationFunctionType==2)
Print "Dispersion from Marginal Fermi Liquid"
String BareK="BareK" +"MFL"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"MFL"+root:ARPESSimulation:NamePrefix
Endif

If (root:ARPESSimulation:SimulationFunctionType==3)
Print "Dispersion from Luttinger Fermi Liquid"
Endif

If (root:ARPESSimulation:SimulationFunctionType==4)
Print "Dispersion from FL plus e_p Coupling--3D Debye"
String BareK="BareK" +"3DD"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"3DD"+root:ARPESSimulation:NamePrefix
Endif

If (root:ARPESSimulation:SimulationFunctionType==5)
Print "Dispersion from FL plus e_p Coupling--Einstein"
String BareK="BareK" +"Ein"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"Ein"+root:ARPESSimulation:NamePrefix
Endif

If (root:ARPESSimulation:SimulationFunctionType==6)
Print "Dispersion Universal e_p Coupling"
String BareK="BareK" +"UEP"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"UEP"+root:ARPESSimulation:NamePrefix
Endif


If (root:ARPESSimulation:SimulationFunctionType==7)
Print "Dispersion From All Contributions--electron-electron, electron-phonon and Impurity"
String BareK="BareK" +"All"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"All"+root:ARPESSimulation:NamePrefix
Endif



//Append Bare Dispersion on the Image
String Curr1=GetDataFolder(1)



Variable Uni_a=root:ARPESSimulation:Uni_BareDispInterc
Variable Uni_b=root:ARPESSimulation:Uni_BareDispCoef	
Variable Uni_c=root:ARPESSimulation:Uni_BareCorrection	
Variable ES=root:ARPESSimulation:BindingEnergyStart
Variable EE=root:ARPESSimulation:BindingEnergyEnd
Variable KS=root:ARPESSimulation:MomentumKStart*1
Variable KE=root:ARPESSimulation:MomentumKEnd*1
Variable MomentumPoint=root:ARPESSimulation:NumberofMomentumPoints
Variable EnergyPoint=root:ARPESSimulation:NumberofEnergyPoints
Variable Temp=root:ARPESSimulation:SimulationTemperature

SetDataFolder root:ARPESSimulatedImage

//String BareK="BareK" +root:ARPESSimulation:NamePrefix
//String BareE="BareE" +root:ARPESSimulation:NamePrefix

//RemoveFromGraph/Z $BareE
//Make/O/N=(MomentumPoint) $Barek, $BareE
//SetScale x KS, KE, $BareK, $BareE
//$BareK=x
//$BareE=Uni_a+Uni_B*x+Uni_c*x*x
//AppendToGraph $BareE vs $BareK
//SetAxis left ES,EE 

SetDataFolder root:ARPESRealSEfromMDC

Duplicate/O root:ARPESSimulation:$SEnergy, root:ARPESRealSEfromMDC:BareEnergy  
root:ARPESRealSEfromMDC:BareEnergy =(root:ARPESRealSEfromMDC:$SPosition)*Uni_B
//AppendToGraph BareEnergy vs root:ARPESRealSEfromMDC:$SPosition

String RealSelfE="RSE_"+SEnergy
Duplicate/O root:ARPESSimulation:$SEnergy, root:ARPESRealSEfromMDC:$RealSelfE  
$RealSelfE =$SEnergy-BareEnergy 

//Duplicate/O root:ARPESSimulation:$SEnergy, root:ARPESRealSEfromMDC:RealSE  
//RealSE=$SEnergy-BareEnergy  


//             Display RealSE  vs $SEnergy
               Display/K=1 $RealSelfE  vs $SEnergy                                       
               SetAxis/A bottom
               ModifyGraph standoff=0
               ModifyGraph mirror=2
               ModifyGraph manTick(bottom)={0,0.02,0,2},manMinor(bottom)={1,0}
               ModifyGraph zero=2
               Label left "\\f01\\Z12Real Self-Energy (eV)"
               Label bottom "\\f01\\Z12E - E\\BF\\M\\Z12 (eV)"
               
//String RealSelfE="RSE_"+SEnergy
//Duplicate/O RealSE, root:ARPESRealSEfromMDC:$RealSelfE  

SetDataFolder Curr1


DoWindow/C $DispersionWindowName
Else 
DoWindow/F $DispersionWindowName

ENDIF


SetDataFolder Curr
END






Proc GetSimulationScatteringRate(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String DispersionWindowName="SimulatedWidth"+popStr
	SetDataFolder root:ARPESSimulatedDispersion
       String SPW=popStr+"PW",SPosition=popstr+"Position", 
       String SWidth=popStr+"Width", SEnergy=popStr+"Energy"

	String Curr=GetDataFolder(1)

If (root:ARPESSimulation:SimulationFunctionType==1)
Print "Scattering Rate from Standard Fermi Liquid"

Endif

If (root:ARPESSimulation:SimulationFunctionType==2)
Print "Scattering Rate from Marginal Fermi Liquid"
Endif

If (root:ARPESSimulation:SimulationFunctionType==3)
Print "Scattering Rate from Luttinger Fermi Liquid"
Endif

If (root:ARPESSimulation:SimulationFunctionType==4)
//Print "Scattering Rate from FL plus e_p Coupling"

Endif	

DoWindow $DispersionWindowName
If (V_Flag==0)

               Display/K=1 $SWidth  vs $SEnergy
               ModifyGraph mode=4,marker=19
               ModifyGraph standoff=0
               ModifyGraph mirror=2
               SetAxis left 0,0.1
               Label left "\\Z12\\f01MDC Width (1/A)";DelayUpdate
               Label bottom "\\Z14\\f01E - E\\BF\\M\\Z14  (eV)"
               ModifyGraph manTick(left)={0,0.02,0,2},manMinor(left)={1,0}
               
If (root:ARPESSimulation:SimulationFunctionType==1)
Print "Dispersion from Standard Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==2)
Print "Dispersion from Marginal Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==3)
Print "Dispersion from Luttinger Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==4)
Print "Dispersion from FL plus e_p Coupling"
String TextOne="a= "+num2str(root:ARPESSimulation:EPC_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:EPC_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:EPC_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:EPC_MassEnhancement)
String TextFive="w_d= "+num2str(root:ARPESSimulation:EPC_DebyeEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==5)
Print "Dispersion from FL plus e_p Coupling"
String TextOne="a= "+num2str(root:ARPESSimulation:EPC_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:EPC_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:EPC_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:EPC_MassEnhancement)
String TextFive="w_e= "+num2str(root:ARPESSimulation:EPC_EinsteinEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==6)
Print "Dispersion Universal e_p Coupling"
String BareK="BareK" +"UEP"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"UEP"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Phonon DOS Height: "+num2str(root:ARPESSimulation:Uni_DOSHeight)
String TextFive="Phonon PeakE: "+num2str(root:ARPESSimulation:Uni_DOSPeakEnergy)
String TextSix="Phonon ECutoff: "+num2str(root:ARPESSimulation:Uni_ECut)
String TextSeven="Alpha*Alpha:"+num2str(root:ARPESSimulation:Uni_AlphaSquared)
String TextEight="Expected Lamda= "+num2str(root:ARPESSimulation:Uni_LamdaExpected)
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
Endif
               
               

DoWindow/C $DispersionWindowName
Else 
DoWindow/F $DispersionWindowName

If (root:ARPESSimulation:SimulationFunctionType==1)
Print "Dispersion from Standard Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==2)
Print "Dispersion from Marginal Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==3)
Print "Dispersion from Luttinger Fermi Liquid"
Endif
If (root:ARPESSimulation:SimulationFunctionType==4)
Print "Dispersion from FL plus e_p Coupling"
String TextOne="a= "+num2str(root:ARPESSimulation:EPC_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:EPC_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:EPC_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:EPC_MassEnhancement)
String TextFive="w_d= "+num2str(root:ARPESSimulation:EPC_DebyeEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==5)
Print "Dispersion from FL plus e_p Coupling"
String TextOne="a= "+num2str(root:ARPESSimulation:EPC_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:EPC_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:EPC_BareCorrection)
String TextFour="Lamda= "+num2str(root:ARPESSimulation:EPC_MassEnhancement)
String TextFive="w_e= "+num2str(root:ARPESSimulation:EPC_EinsteinEnergy) + "eV"
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
Endif

If (root:ARPESSimulation:SimulationFunctionType==6)
Print "Dispersion Universal e_p Coupling"
String BareK="BareK" +"UEP"+root:ARPESSimulation:NamePrefix
String BareE="BareE" +"UEP"+root:ARPESSimulation:NamePrefix
String TextOne="a= "+num2str(root:ARPESSimulation:Uni_BareDispInterc)
String TextTwo="b= "+num2str(root:ARPESSimulation:Uni_BareDispCoef)
String TextThree="c= "+num2str(root:ARPESSimulation:Uni_BareCorrection)
String TextFour="Phonon DOS Height: "+num2str(root:ARPESSimulation:Uni_DOSHeight)
String TextFive="Phonon PeakE: "+num2str(root:ARPESSimulation:Uni_DOSPeakEnergy)
String TextSix="Phonon ECutoff: "+num2str(root:ARPESSimulation:Uni_ECut)
String TextSeven="Alpha*Alpha:"+num2str(root:ARPESSimulation:Uni_AlphaSquared)
String TextEight="Expected Lamda= "+num2str(root:ARPESSimulation:Uni_LamdaExpected)
Textbox/C/N=text0/A=RB  TextOne
AppendText/N=text0 TextTwo
AppendText/N=text0 TextThree
AppendText/N=text0 TextFour
AppendText/N=text0 TextFive
AppendText/N=text0 TextSix
AppendText/N=text0 TextSeven
AppendText/N=text0 TextEight
Endif
Endif
 
	
SetDataFolder Curr	 
	
	
END

Function/C  XJZPEAK2D( img, x1, x2, y0, pkmode )
//====================
//return complex value {peak CENTROID postion, edgewidth}
	wave img
	variable x1, x2, y0, pkmode
	
// extract line profile
	variable nx=DimSize( img, 0)
	make/O/n=(nx) tmp
	CopyScales img, tmp
	tmp=img(x)( y0)
//	Edit img
//	edit tmp
	WaveStats/Q/R=(x1, x2) tmp
//		PulseStats/Q/R=(x1, x2)/L=(V_max,V_min) tmp    ///B=3 boxcar average
	variable hwlvl=(V_max+V_min)/2, lxhw, rxhw
	FindLevel/Q/R=(x1, x2) tmp, hwlvl
		lxhw=V_levelX
	FindLevel/Q/R=(x2, x1) tmp, hwlvl
		rxhw=V_levelX
	variable pkpos, pkwidth
	//Average between  half-height positions OR Peak max location 
	pkpos=SelectNumber(pkmode, (lxhw+rxhw)/2, V_maxloc)
//	edit pkpos				
	pkwidth=abs(rxhw-lxhw)			//Difference between  half-height positions
//		return CMPLX( (V_PulseLoc1+V_PulseLoc2)/2,  V_PulseWidth2_1 )
//      Edit pkpos
	return CMPLX( pkpos,  pkwidth )
End


Proc ShowSimulationSelfEnergy(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String SEWindowName="SSE"+popStr
	String EPCRE="S"+popStr+"_RE"
	String EPCIM="S"+PopStr+"_IM"
	String EPCEnergy="S"+popStr+"_Energy"	
	String Curr=GetDataFolder(1)
	
	Print EPCRE,EPCIM,EPCEnergy
	SetDataFolder root:ARPESSimulatedSelfEnergy
	DoWindow $SEWindowName
       If (V_Flag==0)
       Display/K=1 $EPCRE vs $EPCEnergy
       AppendToGraph/R=RIM $EPCIM vs $EPCEnergy
       ModifyGraph standoff(left)=0,standoff(bottom)=0
       ModifyGraph mode($EPCIM)=4,marker($EPCIM)=19
       ModifyGraph mode=4,marker($EPCRE)=8,rgb($EPCRE)=(0,15872,65280)
       SetAxis bottom root:ARPESSimulation:BindingEnergyStart,0.02
       ModifyGraph freePos(RIM)={0.02,bottom}
//     SetAxis bottom root:ARPESSimulation:BindingEnergyStart,root:ARPESSimulation:BindingEnergyEnd
//     ModifyGraph freePos(RIM)={root:ARPESSimulation:BindingEnergyEnd,bottom}
       ModifyGraph mirror(bottom)=1
       ModifyGraph zero(left)=2
       ModifyGraph zero(bottom)=2
       Legend/N=text0/F=0/A=LB
       ModifyGraph tick=2
       ModifyGraph margin(right)=58       
       Label left "\\Z14\\f01Real (SE) (eV)"
       Label bottom "\\Z14\\f01E - E\\BF\\M\\Z14 (eV)"
       Label RIM "\\Z14\\f01Imaginary(SE) (eV)"
       DoWindow/C $SEWindowName
       
       Else
       DoWindow/F $SEWindowName
       EndIf
       ShowInfo
       SetDataFolder Curr
       
       END


//Proc GetSimulationSelfEnergy(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String SEWindowName="SSE"+popStr
	String Curr=GetDataFolder(1)

       If (root:ARPESSimulation:SimulationFunctionType==4)
	String SSEImageName, SSEWindowName
	String EPCRE="S"+popStr+"_RE"
	String EPCIM="S"+popStr+"_IM"
	String EPCEnergy="S"+popStr+"_Energy"	
	Variable EPC_a=root:ARPESSimulation:EPC_BareDispInterc
	Variable EPC_b=root:ARPESSimulation:EPC_BareDispCoef	
	Variable Lamda=root:ARPESSimulation:EPC_MassEnhancement
	Variable w_d=root:ARPESSimulation:EPC_DebyeEnergy
	Variable KS=root:ARPESSimulation:MomentumKStart*3.1416/3.8
	Variable KE=root:ARPESSimulation:MomentumKEnd*3.1416/3.8
	Variable ES=root:ARPESSimulation:BindingEnergyStart
	Variable EE=root:ARPESSimulation:BindingEnergyEnd
	Variable MomentumPoint=root:ARPESSimulation:NumberofMomentumPoints
	Variable EnergyPoint=root:ARPESSimulation:NumberofEnergyPoints
	Variable Temp=root:ARPESSimulation:SimulationTemperature

	Make/O/N=(EnergyPoint) EPC_IM, EPC_RE, EPC_Energy
	Setscale x  ES, EE, EPC_IM, EPC_RE, EPC_Energy

	EPC_Energy=x

	Variable iIM=0
	Do
	If (abs(EPC_Energy[iIM])<=w_d)
	EPC_IM[iIM]=Lamda*3.1416*abs(EPC_Energy[iIM])*abs(EPC_Energy[iIM])*abs(EPC_Energy[iIM])/(3*w_d*w_d)*1000
	Else
	EPC_IM[iIM]=Lamda*3.1416*w_d/3*1000
	Endif
	iIM+=1
	While(iIM<EnergyPoint)


	EPC_RE=(-(Lamda*w_d/3)*(x*x*x/w_d/w_d/w_d*ln(abs((w_d*w_d-x*x)/x/x)) + ln(abs((w_d+x)/(w_d-x))) +x/w_d))*1000

 
        Endif
               Duplicate/O EPC_RE, root:ARPESSimulatedSelfEnergy:$EPCRE
               Duplicate/O EPC_IM, root:ARPESSimulatedSelfEnergy:$EPCIM
               Duplicate/O EPC_Energy, root:ARPESSimulatedSelfEnergy:$EPCEnergy
        
       DoWindow $SEWindowName
       If (V_Flag==0)
       Display/K=1 $EPCRE vs $EPCEnergy
       AppendToGraph/R=RIM $EPCIM vs $EPCEnergy
       ModifyGraph standoff(left)=0,standoff(bottom)=0
       ModifyGraph mode($EPCIM)=4,marker($EPCIM)=19
       ModifyGraph mode=4,marker($EPCRE)=8,rgb($EPCRE)=(0,15872,65280)
       SetAxis bottom root:ARPESSimulation:BindingEnergyStart,0.02
       ModifyGraph freePos(RIM)={0.02,bottom}
//       SetAxis bottom root:ARPESSimulation:BindingEnergyStart,root:ARPESSimulation:BindingEnergyEnd
//       ModifyGraph freePos(RIM)={root:ARPESSimulation:BindingEnergyEnd,bottom}
       ModifyGraph mirror(bottom)=1
       ModifyGraph zero(left)=2
       ModifyGraph zero(bottom)=2
       Legend/N=text0/F=0/A=LB
       ModifyGraph tick=2
       ModifyGraph margin(right)=58       
       Label left "\\Z14\\f01Real (SE) (meV)"
       Label bottom "\\Z14\\f01E - E\\BF\\M\\Z14 (eV)"
       Label RIM "\\Z14\\f01Imaginary(SE) (meV)"
       
       DoWindow/C $SEWindowName
       
       Else
       DoWindow/F $SEWindowName
       EndIf
	
	SetDataFolder Curr
	End


Proc  GetMFLEquationPlot(ctrlName) : ButtonControl
	 String ctrlName

Variable a, b, c, k,wc,Delta, Tolerance
a=root:ARPESSimulation:MFL_BareDispInterc
b=root:ARPESSimulation:MFL_BareDispCoef	
k=0.8
c=root:ARPESSimulation:MFL_CoefSelfEnergy
wc=root:ARPESSimulation:MFL_OmegaC
Delta=root:ARPESSimulation:MFL_IterationStep
Tolerance=root:ARPESSimulation:MFL_IterationTolerance
Variable iniY,  DiffY
iniY=a+b*k
//iniY=1.8

Make/O/N=100  DispersionY, DifferenceY,YY
SetScale x, (a+b*(k-0.5)), (a+b*(k+0.5)), DispersionY, YY
SetScale x, (a+b*(k-0.5)), (a+b*(k+0.5)), DifferenceY
         YY=x
         DispersionY=a+b*k+c*(YY)*ln((YY)/wc)
         DifferenceY= (YY)-(a+b*k+c*(YY)*ln((YY)/wc))
         
Display/K=1 DifferenceY vs YY
AppendtoGraph DispersionY vs YY
ModifyGraph zero(left)=3
ModifyGraph mode=4,marker=19
ModifyGraph marker(DispersionY)=5,rgb(DispersionY)=(0,15872,65280)
Legend/N=text0/F=0/A=MC

END


Function SimulationCleanandExit(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	DoWindow/K ARPES_Simulation_Panel
		
	SetDataFolder Curr
	
End

Function getselfenergyfromelishiaberg(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	variable se_way,simuwhat
	controlinfo/W=ARPES_Simulation_Panel popup_waytogetse
	se_way=V_Value
	controlinfo/W=ARPES_Simulation_Panel popup_SimulationFunction
	simuwhat=V_Value
	
		if(se_way==1)
		 if(simuwhat==6)
		 SetVariable Var_alpha2,proc=SetVarProc,pos={320,221},size={222,25},bodywidth=94,title="\\F'symbol'\Z11a\\F'Arial'\\S2:",fSize=10     	
		 SetVariable Var_alpha2,limits={-inf,inf,0.1},disable=1,value= _NUM:0
		 setvariable Var_ExpectedLamda,disable=0
		 setvariable set_UniNamePrefix,pos={278,230}
		 endif
		 
		 if(simuwhat==7)
		 SetVariable Var_alpha2,proc=SetVarProc,pos={431,251},size={111,25},bodywidth=94,title="\\F'symbol'\Z11a\\F'Arial'\\S2:",fSize=10     	
		 SetVariable Var_alpha2,limits={-inf,inf,0.1},disable=1,value= _NUM:0
		 //setvariable set_UniNamePrefix,pos={278,230}
		 endif
		endif
		
		if(se_way==2)
		if(simuwhat==6)
		 SetVariable Var_alpha2,proc=SetVarProc,pos={320,221},size={222,25},bodywidth=94,title="\\F'symbol'\Z11a\\F'Arial'\\S2:",fSize=10     	
		 SetVariable Var_alpha2,limits={-inf,inf,0.1},disable=0,value= _NUM:0
		 setvariable Var_ExpectedLamda,disable=2
		 setvariable set_UniNamePrefix,pos={278,250}
		endif
		if(simuwhat==7)
		 SetVariable Var_alpha2,proc=SetVarProc,pos={431,251},size={111,25},bodywidth=94,title="\\F'symbol'\Z11a\\F'Arial'\\S2:",fSize=10     	
		 SetVariable Var_alpha2,limits={-inf,inf,0.1},disable=0,value= _NUM:0
		// setvariable set_UniNamePrefix,pos={278,250}
		endif
		
		endif
End

function kernal(y,y1)
variable y
variable y1
nvar kt=root:ARPESSimulation:SimulationTemperature

y=y/0.8625*10000/kt
y1=y1/0.8625*10000/kt

variable g,gn,nn=0
g=0
gn=1
do
gn=8*pi*pi*(2*nn+1)*y*y1/((y-y1)*(y-y1)+(2*nn+1)*(2*nn+1)*pi*pi)/((y+y1)*(y+y1)+(2*nn+1)*(2*nn+1)*pi*pi)
g=g+gn
nn+=1
while(gn>0.00001*g)
return (g)


end

Function selectarbdos(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
svar arbtrarydosname=root:ARPESSimulation:arbtrarydosname
arbtrarydosname=popStr
End

Function getsimulatedimg(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	string curr=getdatafolder(1)
	setdatafolder root:ARPESSimulatedImage
	string windowname
	windowname="SimulatedImage"+popStr
	dowindow/K $windowname
	display/K=1
	appendimage $popStr
	ModifyImage $popStr ctab= {*,*,PlanetEarth256,1}
	ModifyGraph standoff=0
	ModifyGraph zero(left)=3
	ModifyGraph width={Aspect,0.6}
	dowindow/C $windowname

End

proc get2dprocesspanel(ctrlName) : ButtonControl
	String ctrlName
	imgtomatrix()
End

function H(var)
variable var

if(var>0)
return 1
else 
return 0
endif
end

Function F(var,alpha)
variable var
variable alpha
if(var<=0)
return 0
else
return (var^(-0.5+alpha))
endif


end

Function F1(var,alpha)
variable var
variable alpha

if(var<=0)
return 0
else
return (var^(alpha))
endif


end

function getref(ctrlname):buttoncontrol
string ctrlname

DoWindow/F ReferenceNote
	if (V_flag==0)
		string txt
		NewNotebook/K=1/W=(100,100,450,250)/F=1/N=ReferenceNote
		Notebook ReferenceNote, showruler=0, backRGB=(45000,65535,65535)
		Notebook ReferenceNote, fstyle=1, text="Simulation Method \r"
		Notebook ReferenceNote, fstyle=0, text="Simulation method please refer to arXiv:cond-mat/0405522\r(Already published in EPL)\r"
		Notebook ReferenceNote, fstyle=0, text="1. Get Green Function\r"
		Notebook ReferenceNote, fstyle=0, text="2. Get spectra function\r"
		Notebook ReferenceNote, fstyle=0, text="This is a phenomenology method\r"
		Notebook ReferenceNote, fstyle=0, text="JXW 2011-07-10\r"
		Notebook ReferenceNote, fstyle=0, text="2002jiaxiaowen@163.com\r\r"
		

	endif

end
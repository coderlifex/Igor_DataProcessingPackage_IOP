#pragma rtGlobals=1		// Use modern global access method.

proc GapSimu()
	variable tab
	String name
	DoWindow/F GapSimulation
	if(V_flag==0)
		NewDataFolder/O/S root:Simulation
		NewDataFolder/O/S root:Simulation:GapSimu
		NewDataFolder/O/S root:Simulation:GapSimu:OriginalEDC
		NewDataFolder/O/S root:Simulation:GapSimu:SymmetrizedEDC
		NewDataFolder/O/S root:Simulation:GapSimu:EDCbyFermiFunc
		
		setdatafolder root:Simulation:GapSimu
		Variable/G Temperature
		Variable/G AngleStep
		Variable/G background
    	Variable/G Intensity
		Variable/G Gapmax
		Variable/G Gamma0
		Variable/G Gamma1
		Variable/G resolution
		Variable/G AngleEND
		Variable/G ConvolveFermiFunc
		Variable/G Radio_FindEdgeMidPoint
		Variable/G Radio_FindEdgeAuto
		Variable/G Radio_OneEDC
		Variable/G Radio_AllEDC
		Variable/G EDCEvery
		Variable/G EStart
		Variable/G EEnd
		Variable/G EDCatAngle
		Variable/G EDCOffset
		Variable/G Append2Graph
		Variable/G Tabs
		
		if (!Gamma1)
			Gamma0=0.000001
			Gamma1=0.002
			Intensity=1
			Background=0.2
			Gapmax=40
			AngleStep=1
			Temperature=20
			Resolution=5
			ConvolveFermifunc=1
			Radio_FindEdgeAuto=1
			Radio_AllEDC=1
			EDCatAngle=45
			EDCEvery=1
			EStart=-0.1
			EEnd=0.1
			EDCOffset=20
		endif
		
		
		NewDataFolder/O/S root:Simulation:t_J_Model
		Variable/G t0
		Variable/G t1
		Variable/G t2
		Variable/G t3
		Variable/G t_bi
		Variable/G t_z
		Variable/G E_F
		Variable/G Bonding
		Variable/G AntiBonding
		Variable/G KxStart
		Variable/G KxEnd
		Variable/G KyStart
		Variable/G KyEnd
		Variable/G PhotonEnergy
		Variable/G LatticeConstant
		Variable/G PHI
		Variable/G Omega
		Variable/G Theta
		Variable/G DetectAngle
		Variable/G LinearCut
		Variable/G ByARPES
		Variable/G Kz
		Variable/G A0
		Variable/G WorkFunction

		if (!t0)
			t0=0.5
			t1=-0.2
			t2=0.12
			t3=0.03
			t_bi=0.2
			t_z=0.05
			E_F=0.45
			Kz=2
			a0=0.3
			PhotonEnergy=6.994
			LatticeConstant=3.82
			Phi=30
			Omega=45
			Theta=20
			DetectAngle=30
			WorkFunction=4.461
		endif
		
		NewDataFolder/O/S root:Simulation:Image2DSimulation
			Variable/G Parabola
			Variable/G TJModel
			Variable/G a
			Variable/G b
			Variable/G c
			Variable/G EnergyResolution
			Variable/G MomentumResolution
			Variable/G EnergyStart
			Variable/G EnergyEnd
			Variable/G EDCOffset_2DImage
			Variable/G EDCEVery_2DImage
			Variable/G Temperature_2DImage
			Variable/G Gapmax_2DImage
			String/G ImageList
			Variable/G showselectEDC
			Variable/G EDCStart
			Variable/G EDCEnd
			//Variable/G KStart
			//Variable/G Kend
			Variable/G FWHM
			if (!EnergyResolution)
				EnergyResolution=5
				MomentumResolution=0.004
				EnergyStart=-0.2
				EnergyEnd=0.2
			    EDCEvery_2DImage=5
			    Temperature_2DImage=20
			    GapMax_2DImage=40
			    ImageList="Akw;Original_Image;Convolved_Image;DCF_Image"
			   // KStart=-0.2
			   // KEnd=0.2
			    FWHM=0.02
			endif
		
		
		GapSimulation()

		Setdatafolder root:Simulation:GapSimu
		
		CheckBox FindLeadingEdge,value= Radio_FindEdgeAuto
		CheckBox FindLeadingEdge_1,value= Radio_FindEdgeMidPoint
		CheckBox OneEDC,value= Radio_OneEDC
		CheckBox ALLEDC,value= Radio_AllEDC

		tab=tabs
		tabproc(name,tabs)
		
		setDatafolder root:Simulation:t_J_Model
		CheckBox LinearCut,value= LinearCut
		CheckBox SelectCutsByARPES,value= ByARPES
	else
		setdatafolder root:Simulation:GapSimu
		
		tab=tabs
		tabproc(name,tabs)
	endif


end

Window GapSimulation() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel/K=1 /W=(482,132,832,372) as "Gap Simulation"
	ModifyPanel fixedSize=1,framestyle=1
	TabControl foo,pos={2,3},size={345,235},proc=tabProc,font="Calibri"
	TabControl foo,tabLabel(0)="D-Wave Simulation",tabLabel(1)="T-J Model"
	TabControl foo,tabLabel(2)="2DImage Simulation",value= root:simulation:gapsimu:tabs
	SetVariable Background,pos={16,76},size={137,15},title="Background"
	SetVariable Background,limits={0,10,0.1},value= root:Simulation:GapSimu:background
	SetVariable Intensity,pos={16,61},size={137,15},title="Intensity"
	SetVariable Intensity,limits={0,100,1},value= root:Simulation:GapSimu:Intensity
	SetVariable Gamma1,pos={16,31},size={137,15},title="Gamma1"
	SetVariable Gamma1,limits={0,1,0.001},value= root:Simulation:GapSimu:Gamma1
	SetVariable Resolution,pos={16,137},size={137,15},title="Resolution(meV)"
	SetVariable Resolution,limits={0,100,5},value= root:Simulation:GapSimu:Resolution
	SetVariable GapMax,pos={15,91},size={138,15},title="GapMax(meV)"
	SetVariable GapMax,limits={0,150,1},value= root:Simulation:GapSimu:GapMax
	SetVariable AngleStep,pos={14,106},size={139,15},title="Angle Step"
	SetVariable AngleStep,value= root:Simulation:GapSimu:AngleStep
	SetVariable Temperature,pos={14,121},size={139,15},title="Temperature(K)"
	SetVariable Temperature,limits={0,1000,10},value= root:Simulation:GapSimu:Temperature
	SetVariable Gamma0,pos={15,46},size={138,15},title="Gamma0"
	SetVariable Gamma0,limits={0,1,1e-05},value= root:Simulation:GapSimu:Gamma0
	Button GapSimu,pos={28,212},size={105,20},proc=Gaps,title="Gap SimuLation"
	Button GapSimu,font="Arial",fStyle=1
	CheckBox ConvolvedFF,pos={13,152},size={126,14},title="DConvolveFermiFunc"
	CheckBox ConvolvedFF,help={"Devide convolved EDC by convolved Fermi function"}
	CheckBox ConvolvedFF,variable= root:Simulation:GapSimu:ConvolveFermiFunc
	CheckBox FindLeadingEdge,pos={16,180},size={42,14},proc=GapSimu_Radio,title="Auto"
	CheckBox FindLeadingEdge,variable= root:Simulation:GapSimu:Radio_FindEdgeAuto,mode=1
	CheckBox FindLeadingEdge_1,pos={16,194},size={114,14},proc=GapSimu_Radio,title="Midpoint of Peak"
	CheckBox FindLeadingEdge_1,variable= root:Simulation:GapSimu:Radio_FindEdgeMidPoint,mode=1
	GroupBox FindLeadingEdgeGroup,pos={12,166},size={137,45},title="Find LeadingEdge"
	GroupBox FindLeadingEdgeGroup,font="Arial",fSize=10,fStyle=2
	GroupBox GapSimulation,pos={7,19},size={147,216},title="Gap Simulation"
	GroupBox GapSimulation,font="Arial",fSize=10,fStyle=3
	GroupBox ShowEDC,pos={156,20},size={187,216},title="Show EDC",font="Arial"
	GroupBox ShowEDC,fSize=10,fStyle=3
	GroupBox Select,pos={159,30},size={160,52},title="Select",font="Arial",fSize=10
	GroupBox Select,fStyle=3
	CheckBox OneEDC,pos={165,43},size={54,14},proc=GapSimu_Radio,title="EDC at"
	CheckBox OneEDC,variable= root:Simulation:GapSimu:Radio_OneEDC,mode=1
	SetVariable EDCatAngle,pos={221,43},size={94,15},title="Angle"
	SetVariable EDCatAngle,limits={0,90,1},value= root:Simulation:GapSimu:EDCatAngle
	CheckBox AllEDC,pos={165,61},size={60,14},proc=GapSimu_Radio,title="All EDC"
	CheckBox AllEDC,variable= root:Simulation:GapSimu:Radio_AllEDC,mode=1
	SetVariable EDCOffset,pos={227,61},size={88,15},title="Offset"
	SetVariable EDCOffset,limits={-100,100,1},value= root:Simulation:GapSimu:EDCOffset
	Button ShowOriginalEDC,pos={163,151},size={150,20},proc=ShowOriginalEDC,title="Show Original EDC"
	Button ShowOriginalEDC,font="Arial",fStyle=1
	Button ShowSymmetrizedEDC,pos={163,174},size={150,20},proc=ShowSymmetrizedEDC,title="Show Symmetrized EDC"
	Button ShowSymmetrizedEDC,font="Arial",fStyle=1
	Button ShowEDCDevidedFF,pos={163,196},size={150,20},proc=ShowDevideFermiFuncEDC,title="EDC Devide Fermifunc"
	Button ShowEDCDevidedFF,font="Arial",fStyle=1
	SetVariable ShowEDCEvery,pos={162,83},size={154,15},title="Show EDC Every"
	SetVariable ShowEDCEvery,limits={0,10,1},value= root:Simulation:GapSimu:EDCEvery
	SetVariable EnergyStart,pos={162,99},size={154,15},title="Energy Start(meV)"
	SetVariable EnergyStart,limits={-1,0,0.1},value= root:Simulation:GapSimu:EStart
	SetVariable EnergyEnd,pos={162,117},size={154,15},title="Energy End(meV)"
	SetVariable EnergyEnd,limits={0,1,0.1},value= root:Simulation:GapSimu:EEnd
	CheckBox AppendtoGraph,pos={184,134},size={108,14},title="Append to Graph"
	CheckBox AppendtoGraph,variable= root:Simulation:GapSimu:append2graph
	Button Help,pos={321,217},size={17,14},proc=GapSimuHellp,title="?",font="Arial"
	Button ShowFermiSurface,pos={10,210},size={100,20},disable=1,proc=ShowFermiSurface,title="Fermi Surface"
	Button ShowFermiSurface,font="Arial",fStyle=1
	GroupBox SelectCut,pos={140,44},size={202,68},disable=1,title="Select Linear Cut (Pi/a)"
	GroupBox SelectCut,font="Arial",fSize=10,fStyle=2
	SetVariable KxStart,pos={143,58},size={102,15},disable=1,title="KxStart"
	SetVariable KxStart,limits={-1,1,0.05},value= root:Simulation:t_J_Model:KxStart
	SetVariable KxEND,pos={248,58},size={90,15},disable=1,title="Kx End"
	SetVariable KxEND,limits={-1,1,0.05},value= root:Simulation:t_J_Model:KxEND
	SetVariable KyStart,pos={143,73},size={102,15},disable=1,title="KyStart"
	SetVariable KyStart,limits={-1,1,0.05},value= root:Simulation:t_J_Model:KyStart
	SetVariable KyEND,pos={248,74},size={90,15},disable=1,title="Ky End"
	SetVariable KyEND,limits={-1,1,0.05},value= root:Simulation:t_J_Model:KyEnd
	Button Cursors,pos={201,89},size={63,20},disable=1,proc=Cursor2Point,title="Cursors"
	Button Cursors,font="Arial",fStyle=1
	GroupBox Resolutions,pos={8,127},size={180,45},disable=1,title="Resolutions"
	GroupBox Resolutions,font="Arial",fSize=10,fStyle=2
	SetVariable Energy,pos={11,139},size={173,15},disable=1,title="Energy(meV)"
	SetVariable Energy,limits={0,100,5},value= root:Simulation:Image2DSimulation:EnergyResolution
	SetVariable Momentum,pos={11,154},size={173,15},disable=1,title="Momentum(1/A)"
	SetVariable Momentum,limits={0,1,0.001},value= root:Simulation:Image2DSimulation:MomentumResolution
	GroupBox EnergyRange,pos={8,171},size={180,33},disable=1,title="Energy range (meV)"
	GroupBox EnergyRange,font="Arial",fSize=10,fStyle=2
	SetVariable EStart,pos={12,186},size={90,15},disable=1,title="Start"
	SetVariable EStart,limits={-2,1,0.2},value= root:Simulation:Image2DSimulation:EnergyStart
	SetVariable EEnd,pos={104,186},size={80,15},disable=1,title="End"
	SetVariable EEnd,limits={-2,1,0.2},value= root:Simulation:Image2DSimulation:EnergyEND
	GroupBox Bareband,pos={8,30},size={180,80},disable=1,title="Bare Band"
	GroupBox Bareband,font="Arial",fSize=10,fStyle=2
	CheckBox Parabola,pos={11,42},size={66,14},disable=1,proc=SelectBareBand_Radio,title="Parabola"
	CheckBox Parabola,variable= root:Simulation:Image2DSimulation:Parabola,mode=1
	SetVariable a,pos={23,56},size={60,15},disable=1,title="a"
	SetVariable a,value= root:Simulation:Image2DSimulation:a
	SetVariable b,pos={23,73},size={60,15},disable=1,title="b"
	SetVariable b,value= root:Simulation:Image2DSimulation:b
	SetVariable c,pos={23,90},size={60,15},disable=1,title="c"
	SetVariable c,value= root:Simulation:Image2DSimulation:c
	CheckBox TJModel,pos={93,43},size={72,14},disable=1,proc=SelectBareBand_Radio,title="T-J Model"
	CheckBox TJModel,variable= root:Simulation:Image2DSimulation:TJModel,mode=1
	SetVariable t,pos={13,37},size={100,15},disable=1,title="t(eV)"
	SetVariable t,limits={0,1,0.1},value= root:Simulation:t_J_Model:t0
	SetVariable t1byt,pos={13,52},size={100,15},disable=1,title="t'/t"
	SetVariable t1byt,limits={-2,2,0.1},value= root:Simulation:t_J_Model:t1
	SetVariable t2byt,pos={13,67},size={100,15},disable=1,title="t\"/t"
	SetVariable t2byt,limits={-2,2,0.1},value= root:Simulation:t_J_Model:t2
	SetVariable t3byt,pos={13,82},size={100,15},disable=1,title="t\"'/t"
	SetVariable t3byt,limits={-2,2,0.1},value= root:Simulation:t_J_Model:t3
	SetVariable tbibyt,pos={13,97},size={100,15},disable=1,title="t_bi/t"
	SetVariable tbibyt,limits={-2,2,0.1},value= root:Simulation:t_J_Model:t_bi
	SetVariable tzbyt,pos={13,112},size={100,15},disable=1,title="t_z/t"
	SetVariable tzbyt,limits={-2,2,0.1},value= root:Simulation:t_J_Model:t_z
	SetVariable Ef,pos={13,127},size={100,15},disable=1,title="E_F"
	SetVariable Ef,limits={-2,2,0.1},value= root:Simulation:t_J_Model:E_F
	GroupBox VariableSelect,pos={6,19},size={110,215},disable=1,title="Variable"
	GroupBox VariableSelect,font="Arial",fSize=10,fStyle=2
	CheckBox BondingBand,pos={12,176},size={60,14},disable=1,title="Bonding"
	CheckBox BondingBand,variable= root:Simulation:t_J_Model:Bonding
	CheckBox AntiBonding,pos={12,192},size={84,14},disable=1,title="AntiBonding"
	CheckBox AntiBonding,variable= root:Simulation:t_J_Model:AntiBonding
	GroupBox SelectCutbyARPES,pos={140,122},size={202,84},disable=1,title="Select Cut by ARPES"
	GroupBox SelectCutbyARPES,font="Arial",fSize=10,fStyle=2
	SetVariable PhotonEnergy,pos={147,136},size={190,15},disable=1,title="Photon Energy(eV)"
	SetVariable PhotonEnergy,value= root:Simulation:t_J_Model:PhotonEnergy
	GroupBox SelectCutAll,pos={121,19},size={223,215},disable=1,title="Select Cut"
	GroupBox SelectCutAll,font="Arial",fSize=10,fStyle=2
	CheckBox LinearCut,pos={126,32},size={78,14},disable=1,proc=TJModel_Radio,title="Linear Cut"
	CheckBox LinearCut,value= 1,mode=1
	CheckBox SelectCutsByARPES,pos={124,111},size={66,14},disable=1,proc=TJModel_Radio,title="By ARPES"
	CheckBox SelectCutsByARPES,value= 0,mode=1
	SetVariable PHI,pos={149,168},size={60,15},disable=1,title="\F'Symbol'F"
	SetVariable PHI,limits={-180,180,2},value= root:Simulation:t_J_Model:PHI
	SetVariable Theta,pos={211,168},size={60,15},disable=1,title="\F'Symbol'Q"
	SetVariable Theta,limits={-180,180,2},value= root:Simulation:t_J_Model:THETA
	SetVariable Omega,pos={277,168},size={60,15},disable=1,title="\F'Symbol'W"
	SetVariable Omega,limits={-180,180,2},value= root:Simulation:t_J_Model:Omega
	SetVariable LatticeConstant,pos={147,152},size={190,15},disable=1,title="Lattice Constant(A)"
	SetVariable LatticeConstant,value= root:Simulation:t_J_Model:Latticeconstant
	SetVariable DetectAngle,pos={147,184},size={85,15},disable=1,title="DetAngle"
	SetVariable DetectAngle,value= root:Simulation:t_J_Model:DetectAngle
	Button GetBareBand,pos={198,209},size={100,20},disable=1,proc=GetBareBand,title="Get Bareband"
	Button GetBareBand,font="Arial",fStyle=1
	Button Get2DImage,pos={35,208},size={129,20},disable=1,proc=get2DImage,title="Get 2D Image"
	Button Get2DImage,font="Arial",fStyle=1
	GroupBox ShowEDCFrom2DImage,pos={193,52},size={150,120},disable=1,title="Show EDC"
	GroupBox ShowEDCFrom2DImage,font="Arial",fSize=10,fStyle=2
	SetVariable EDCOffset_2DImage,pos={201,68},size={129,15},disable=1,title="EDC Offset"
	SetVariable EDCOffset_2DImage,limits={0,10,0.1},value= root:Simulation:Image2DSimulation:EDCOffset_2DImage
	SetVariable ShowEDCEvery_2DImage,pos={200,84},size={130,15},disable=1,title="Show EDC Every"
	SetVariable ShowEDCEvery_2DImage,limits={1,20,1},value= root:Simulation:Image2DSimulation:EDCEvery_2DImage
	SetVariable Kz,pos={13,142},size={100,15},disable=1,title="Kz"
	SetVariable Kz,limits={0,2,0.1},value= root:Simulation:t_J_Model:Kz
	SetVariable A0_VerticalHopping,pos={13,157},size={100,15},disable=1,title="a0"
	SetVariable A0_VerticalHopping,limits={-2,2,0.1},value= root:Simulation:t_J_Model:A0
	Button GetCut,pos={145,209},size={50,20},disable=1,proc=GetCut,title="Cut"
	Button GetCut,font="Arial",fStyle=1
	SetVariable WorkFunction,pos={240,184},size={97,15},disable=1,title="WorkFunc"
	SetVariable WorkFunction,limits={3,6,0.1},value= root:Simulation:t_J_Model:WorkFunction
	GroupBox Get2DImageGroup,pos={6,19},size={185,215},disable=1,title="Get 2D Image"
	GroupBox Get2DImageGroup,font="Arial",fSize=10,fStyle=2
	SetVariable GapMax_2DImage,pos={9,113},size={105,15},disable=1,title="GapMax(meV)"
	SetVariable GapMax_2DImage,limits={0,100,5},value= root:Simulation:Image2DSimulation:GapMax_2DImage
	SetVariable Temperature_2DImage,pos={117,113},size={70,15},disable=1,title="T(K)"
	SetVariable Temperature_2DImage,limits={0,1000,10},value= root:Simulation:Image2DSimulation:Temperature_2DImage
	PopupMenu Show2DImage,pos={193,29},size={55,20},disable=1,proc=Show2DImage//,//help={"Devide convolved EDC by convolved Fermi function"}
	PopupMenu Show2DImage,mode=1,popvalue="Akw",value= #"root:Simulation:Image2DSimulation:ImageList\t\t"
	SetVariable FWHM,pos={89,90},size={94,15},disable=1,title="FWHM"
	SetVariable FWHM,limits={0,1,0.002},value= root:Simulation:Image2DSimulation:FWHM
	CheckBox ShowSelectedEDC,pos={200,99},size={120,14},disable=1,title="Show Selected EDC"
	CheckBox ShowSelectedEDC,variable= root:Simulation:Image2DSimulation:showselectEDC
	SetVariable EDCStart,pos={202,114},size={120,15},disable=1,title="EDC Start"
	SetVariable EDCStart,limits={0,1000,5},value= root:Simulation:Image2DSimulation:EDCStart
	SetVariable EDCEnd,pos={202,130},size={120,15},disable=1,title="EDC End"
	SetVariable EDCEnd,limits={0,1000,5},value= root:Simulation:Image2DSimulation:EDCEnd
	PopupMenu Show2DImageEDC,pos={203,146},size={121,20},disable=1,proc=Show2DImageEDC
	PopupMenu Show2DImageEDC,mode=2,popvalue="Original_Image",value= #"root:Simulation:Image2DSimulation:ImageList\t\t"
EndMacro

Function TabProc(name,tab)
	String name
	Variable tab
	setdatafolder root:Simulation:GapSimu
	nvar Tabs
	tabs=tab
	if (Tabs==0)
	
	SetVariable Background,Disable=0
	SetVariable Background,Disable=0
	SetVariable Intensity,Disable=0
	SetVariable Gamma1,Disable=0
	SetVariable Resolution,Disable=0
	SetVariable GapMax,Disable=0
	SetVariable AngleStep,Disable=0
	SetVariable Temperature,Disable=0
	SetVariable Gamma0,Disable=0
	Button GapSimu,Disable=0
	CheckBox ConvolvedFF,Disable=0
	CheckBox FindLeadingEdge,Disable=0
	CheckBox FindLeadingEdge_1,Disable=0
	GroupBox FindLeadingEdgeGroup,Disable=0
	GroupBox GapSimulation,Disable=0
	GroupBox ShowEDC,Disable=0
	GroupBox Select,Disable=0
	CheckBox OneEDC,Disable=0
	SetVariable EDCatAngle,Disable=0
	CheckBox AllEDC,Disable=0
	SetVariable EDCOffset,Disable=0
	Button ShowOriginalEDC,Disable=0
	Button ShowSymmetrizedEDC,Disable=0
	Button ShowEDCDevidedFF,Disable=0
	SetVariable ShowEDCEvery,Disable=0
	SetVariable EnergyStart,Disable=0
	SetVariable EnergyEnd,Disable=0
	CheckBox AppendtoGraph,Disable=0
	//Button Help,Disable=0
	
	
	SetVariable WorkFunction,Disable=1
	Button GetCut,Disable=1
	Button ShowFermiSurface,Disable=1
	GroupBox SelectCut,Disable=1
	SetVariable KxStart,Disable=1
	SetVariable KxEND,Disable=1
	SetVariable KyStart,Disable=1
	SetVariable KyEND,Disable=1
	Button Cursors,Disable=1
	GroupBox Resolutions,Disable=1
	SetVariable Energy,Disable=1
	SetVariable Momentum,Disable=1
	GroupBox EnergyRange,Disable=1
	SetVariable EStart,Disable=1
	SetVariable EEnd,Disable=1
	GroupBox Bareband,Disable=1
	CheckBox Parabola,Disable=1
	SetVariable a,Disable=1
	SetVariable b,Disable=1
	SetVariable c,Disable=1
	CheckBox TJModel,Disable=1
	SetVariable t,Disable=1
	SetVariable t1byt,Disable=1
	SetVariable t2byt,Disable=1
	SetVariable t3byt,Disable=1
	SetVariable tbibyt,Disable=1
	SetVariable tzbyt,Disable=1
	SetVariable Ef,Disable=1
	GroupBox VariableSelect,Disable=1
	CheckBox BondingBand,Disable=1
	CheckBox AntiBonding,Disable=1
	GroupBox SelectCutbyARPES,Disable=1
	SetVariable PhotonEnergy,Disable=1
	GroupBox SelectCutAll,Disable=1
	CheckBox LinearCut,Disable=1
	CheckBox SelectCutsByARPES,Disable=1
	SetVariable PHI,Disable=1
	SetVariable Theta,Disable=1
	SetVariable Omega,Disable=1
	SetVariable LatticeConstant,Disable=1
	SetVariable DetectAngle,Disable=1
	Button GetBareBand,Disable=1
	Button Get2DImage,Disable=1
	GroupBox ShowEDCFrom2DImage,Disable=1
	SetVariable EDCOffset_2DImage,Disable=1
	SetVariable ShowEDCEvery_2DImage,Disable=1
	//Button ShowEDC_2DImage,Disable=1
	SetVariable Kz,Disable=1
	SetVariable A0_VerticalHopping,Disable=1
	GroupBox Get2DImageGroup,Disable=1
	SetVariable Temperature_2DImage,Disable=1
	SetVariable GapMax_2DImage,Disable=1
	PopupMenu Show2DImage,Disable=1
	//SetVariable KStart,Disable=1
	//SetVariable KEnd,Disable=1
	SetVariable FWHM,Disable=1
	CheckBox ShowSelectedEDC,Disable=1
	SetVariable EDCStart,Disable=1
	SetVariable EDCEnd,Disable=1
	PopupMenu Show2DImageEDC,Disable=1
	
	elseif (Tabs==1)
	//DrawText 206,231,Disable=1
	//DrawText 203,230,"Click here for help",disable=1
	SetVariable Background,Disable=1
	SetVariable Background,Disable=1
	SetVariable Intensity,Disable=1
	SetVariable Gamma1,Disable=1
	SetVariable Resolution,Disable=1
	SetVariable GapMax,Disable=1
	SetVariable AngleStep,Disable=1
	SetVariable Temperature,Disable=1
	SetVariable Gamma0,Disable=1
	Button GapSimu,Disable=1
	CheckBox ConvolvedFF,Disable=1
	CheckBox FindLeadingEdge,Disable=1
	CheckBox FindLeadingEdge_1,Disable=1
	GroupBox FindLeadingEdgeGroup,Disable=1
	GroupBox GapSimulation,Disable=1
	GroupBox ShowEDC,Disable=1
	GroupBox Select,Disable=1
	CheckBox OneEDC,Disable=1
	SetVariable EDCatAngle,Disable=1
	CheckBox AllEDC,Disable=1
	SetVariable EDCOffset,Disable=1
	Button ShowOriginalEDC,Disable=1
	Button ShowSymmetrizedEDC,Disable=1
	Button ShowEDCDevidedFF,Disable=1
	SetVariable ShowEDCEvery,Disable=1
	SetVariable EnergyStart,Disable=1
	SetVariable EnergyEnd,Disable=1
	CheckBox AppendtoGraph,Disable=1
	//Button Help,Disable=1
	
	//
	SetVariable WorkFunction,Disable=0
	Button GetCut,Disable=0
	Button ShowFermiSurface,Disable=0
	GroupBox SelectCut,Disable=0
	SetVariable KxStart,Disable=0
	SetVariable KxEND,Disable=0
	SetVariable KyStart,Disable=0
	SetVariable KyEND,Disable=0
	Button Cursors,Disable=0
	GroupBox Resolutions,Disable=1
	SetVariable Energy,Disable=1
	SetVariable Momentum,Disable=1
	GroupBox EnergyRange,Disable=1
	SetVariable EStart,Disable=1
	SetVariable EEnd,Disable=1
	GroupBox Bareband,Disable=1
	CheckBox Parabola,Disable=1
	SetVariable a,Disable=1
	SetVariable b,Disable=1
	SetVariable c,Disable=1
	CheckBox TJModel,Disable=1
	SetVariable t,Disable=0
	SetVariable t1byt,Disable=0
	SetVariable t2byt,Disable=0
	SetVariable t3byt,Disable=0
	SetVariable tbibyt,Disable=0
	SetVariable tzbyt,Disable=0
	SetVariable Ef,Disable=0
	GroupBox VariableSelect,Disable=0
	CheckBox BondingBand,Disable=0
	CheckBox AntiBonding,Disable=0
	GroupBox SelectCutbyARPES,Disable=0
	SetVariable PhotonEnergy,Disable=0
	GroupBox SelectCutAll,Disable=0
	CheckBox LinearCut,Disable=0
	CheckBox SelectCutsByARPES,Disable=0
	SetVariable PHI,Disable=0
	SetVariable Theta,Disable=0
	SetVariable Omega,Disable=0
	SetVariable LatticeConstant,Disable=0
	SetVariable DetectAngle,Disable=0
	Button GetBareBand,Disable=0
	Button Get2DImage,Disable=1
	GroupBox ShowEDCFrom2DImage,Disable=1
	SetVariable EDCOffset_2DImage,Disable=1
	SetVariable ShowEDCEvery_2DImage,Disable=1
	//Button ShowEDC_2DImage,Disable=1
	SetVariable Kz,Disable=0
	SetVariable A0_VerticalHopping,Disable=0
	GroupBox Get2DImageGroup,Disable=1
	SetVariable Temperature_2DImage,Disable=1
	SetVariable GapMax_2DImage,Disable=1
	PopupMenu Show2DImage,Disable=1
	//SetVariable KStart,Disable=1
	//SetVariable KEnd,Disable=1
	SetVariable FWHM,Disable=1
	CheckBox ShowSelectedEDC,Disable=1
	SetVariable EDCStart,Disable=1
	SetVariable EDCEnd,Disable=1
	PopupMenu Show2DImageEDC,Disable=1
	
	elseif (Tabs==2)
	
	SetVariable Background,Disable=1
	SetVariable Background,Disable=1
	SetVariable Intensity,Disable=1
	SetVariable Gamma1,Disable=1
	SetVariable Resolution,Disable=1
	SetVariable GapMax,Disable=1
	SetVariable AngleStep,Disable=1
	SetVariable Temperature,Disable=1
	SetVariable Gamma0,Disable=1
	Button GapSimu,Disable=1
	CheckBox ConvolvedFF,Disable=1
	CheckBox FindLeadingEdge,Disable=1
	CheckBox FindLeadingEdge_1,Disable=1
	GroupBox FindLeadingEdgeGroup,Disable=1
	GroupBox GapSimulation,Disable=1
	GroupBox ShowEDC,Disable=1
	GroupBox Select,Disable=1
	CheckBox OneEDC,Disable=1
	SetVariable EDCatAngle,Disable=1
	CheckBox AllEDC,Disable=1
	SetVariable EDCOffset,Disable=1
	Button ShowOriginalEDC,Disable=1
	Button ShowSymmetrizedEDC,Disable=1
	Button ShowEDCDevidedFF,Disable=1
	SetVariable ShowEDCEvery,Disable=1
	SetVariable EnergyStart,Disable=1
	SetVariable EnergyEnd,Disable=1
	CheckBox AppendtoGraph,Disable=1
	//Button Help,Disable=1
	
	//
	SetVariable WorkFunction,Disable=1
	Button GetCut,Disable=1
	Button ShowFermiSurface,Disable=1
	GroupBox SelectCut,Disable=1
	SetVariable KxStart,Disable=1
	SetVariable KxEND,Disable=1
	SetVariable KyStart,Disable=1
	SetVariable KyEND,Disable=1
	Button Cursors,Disable=1
	GroupBox Resolutions,Disable=0
	SetVariable Energy,Disable=0
	SetVariable Momentum,Disable=0
	GroupBox EnergyRange,Disable=0
	SetVariable EStart,Disable=0
	SetVariable EEnd,Disable=0
	GroupBox Bareband,Disable=0
	CheckBox Parabola,Disable=0
	SetVariable a,Disable=0
	SetVariable b,Disable=0
	SetVariable c,Disable=0
	CheckBox TJModel,Disable=0
	SetVariable t,Disable=1
	SetVariable t1byt,Disable=1
	SetVariable t2byt,Disable=1
	SetVariable t3byt,Disable=1
	SetVariable tbibyt,Disable=1
	SetVariable tzbyt,Disable=1
	SetVariable Ef,Disable=1
	GroupBox VariableSelect,Disable=1
	CheckBox BondingBand,Disable=1
	CheckBox AntiBonding,Disable=1
	GroupBox SelectCutbyARPES,Disable=1
	SetVariable PhotonEnergy,Disable=1
	GroupBox SelectCutAll,Disable=1
	CheckBox LinearCut,Disable=1
	CheckBox SelectCutsByARPES,Disable=1
	SetVariable PHI,Disable=1
	SetVariable Theta,Disable=1
	SetVariable Omega,Disable=1
	SetVariable LatticeConstant,Disable=1
	SetVariable DetectAngle,Disable=1
	Button GetBareBand,Disable=1
	Button Get2DImage,Disable=0
	GroupBox ShowEDCFrom2DImage,Disable=0
	SetVariable EDCOffset_2DImage,Disable=0
	SetVariable ShowEDCEvery_2DImage,Disable=0
	//Button ShowEDC_2DImage,Disable=0
	SetVariable Kz,Disable=1
	SetVariable A0_VerticalHopping,Disable=1
	GroupBox Get2DImageGroup,Disable=0
	SetVariable Temperature_2DImage,Disable=0
	SetVariable GapMax_2DImage,Disable=0
	PopupMenu Show2DImage,Disable=0
	//SetVariable KStart,Disable=0
	//SetVariable KEnd,Disable=0
	SetVariable FWHM,Disable=0
	CheckBox ShowSelectedEDC,Disable=0
	SetVariable EDCStart,Disable=0
	SetVariable EDCEnd,Disable=0
	
	PopupMenu Show2DImageEDC,Disable=0
	
	endif
end
	




Function GapSimu_Radio(name,value)
	String name
	Variable value
	setdatafolder root:Simulation:GapSimu
	nvar Radio_FindEdgeMidPoint=Radio_FindEdgeMidPoint
	nvar Radio_FindEdgeAuto=Radio_FindEdgeAuto
	nvar Radio_OneEDC=Radio_OneEDC
	nvar Radio_AllEDC=Radio_AllEDC
	
	strswitch (name)
		case "FindLeadingEdge":
			Radio_FindEdgeAuto= 1
			Radio_FindEdgeMidPoint=0
			break
		case "FindLeadingEdge_1":
			Radio_FindEdgeAuto= 0
			Radio_FindEdgeMidPoint=1
			break
		case "OneEDC":
			 Radio_OneEDC=1 
			 Radio_AllEDC=0
			break
		case "AllEDC":
			Radio_OneEDC=0
			Radio_AllEDC=1
			break
	endswitch
	CheckBox FindLeadingEdge,value= Radio_FindEdgeAuto
	CheckBox FindLeadingEdge_1,value= Radio_FindEdgeMidPoint
	CheckBox OneEDC,value= Radio_OneEDC
	CheckBox ALLEDC,value= Radio_AllEDC

End

//Function EDC_CheckProc(name, value)
//	String name
//	Variable value



Function Gaps(ctrlName):ButtonControl
	string ctrlName
	String EDCName
	variable ii,Angledim
	SetDataFolder root:Simulation:Gapsimu
	make/O/N=2 W_FindLevels
	nvar Anglestep
	nvar temperature
	nvar background
	nvar intensity
	nvar Gamma1
	nvar Gamma0
	nvar gapmax
	nvar resolution
	nvar ConvolveFermiFunc
	nvar AngleEND
	nvar Radio_FindEdgeMidPoint
	nvar Radio_FindEdgeAuto
	nvar EDCOffset
	Make/O/N=4001 EDC,SyEDC,DFEDC,FermiFunc,ConFermiFunc
	Make/O/N=301 Gaussian
	Redimension/D EDC,SyEDC,DFEDC,FermiFunc,ConFermiFunc,Gaussian
	SetScale/I x -2,2,"", EDC 
	SetScale/I x -2,2,"", SyEDC
	SetScale/I x -2,2,"", DFEDC
	SetScale/I x -2,2,"", FermiFunc
	SetScale/I x -2,2,"", ConFermiFunc
	SetScale/I x -0.15,0.15,"", Gaussian
	String GapL,GapP,GraphN,GapD
	//zresolution/=1000
	Gaussian=exp(-x^2/2/(resolution/2.3548/1000)^2)/2.506628274631000502415765284811/(resolution/2.3548/1000)
	Angledim=round(90/Anglestep)+1
	make/O/N=(AngleDim) Gap_Original,Gap_LeadingEdge,Gap_Peak,Gap_DF
	Redimension/D Gap_Original,Gap_LeadingEdge,Gap_Peak,Gap_DF
	SetScale/I x 0,90,"", Gap_Original
	SetScale/I x 0,90,"", Gap_LeadingEdge
	SetScale/I x 0,90,"", Gap_Peak
	SetScale/I x 0,90,"", Gap_DF
	Gap_Original=abs(Gapmax*cos(2*x*pi/180))
	ii=0
	FermiFunc=1/(exp(x*11594.2/Temperature)+1)
	ConFermiFunc=FermiFunc
	convolve/A Gaussian,ConFermiFunc
	setdatafolder root:Simulation:GapSimu:OriginalEDC
	killwaves/A/Z
	setdatafolder root:Simulation:GapSimu:SymmetrizedEDC
	killwaves/A/Z
	setdatafolder root:Simulation:GapSimu:EDCbyFermiFunc
	killwaves/A/Z 
	do
		setdatafolder root:Simulation:GapSimu
		//EDC=1
		//EDC=(background+intensity*FWHM^2/((x-Gap_Original[ii]/1000)^2+FWHM^2)+intensity*FWHM^2/((x+Gap_Original[ii]/1000)^2+FWHM^2))/(exp(x*11594.2/temperature)+1)
		EDC=(background+Intensity*(Gamma1+(Gap_Original[ii]/1000)^2*Gamma0/(x^2+Gamma0^2))/((x-(Gap_Original[ii]/1000)^2*x/(x^2+Gamma0^2))^2+(Gamma1+(Gap_Original[ii]/1000)^2*Gamma0/(x^2+Gamma0^2))^2))/(exp(x*11594.2/temperature)+1)
		convolve/A Gaussian,EDC
		EDC/=1000
		//duplicate/O/R=[1000,3001] EDC,EDCN
		findpeak/Q/R=(-1,1) EDC
		if (Radio_FindEdgeAuto)
			Gap_LeadingEdge[ii]=-(1000*V_TrailingEdgeLoc)
			//print "a"
		elseif (Radio_FindEdgeMidPoint)
			findlevels/Q/R=(-0.1,0.1) EDC,(V_PeakVal-background)/2
			Gap_LeadingEdge[ii]=-1000*W_FindLevels[2]
			//print "b"
		endif
		//duplicate/O EDCN,SyEDC
		SyEDC=EDC
		Wavetransform/o flip SyEDC
		SyEDC+=EDC
		findpeak/Q/R=(-1,1) SyEDC
		Gap_Peak[ii]=-(1000*V_PeakLoc)
		//DFEDC=EDC
		if (ConvolveFermiFunc)
			
			DFEDC=1000*EDC/ConFermiFunc
			//Print 2
		else
	    	DFEDC=EDC/FermiFunc
	    endif
	    findpeak/Q/R=(-0.1,0.1) DFEDC
	    Gap_DF[ii]=-(1000*V_PeakLoc)
		EDCName="EDC_"+num2str(Gap_Original[ii])+"meV"
		EDC=EDC-ii*EDCOffset
		Duplicate/O EDC,root:Simulation:GapSimu:OriginalEDC:$EDCName
		//  $EDCO,root:GapSimu:OriginalEDC:
		SyEDC=SyEDC-ii*EDCOffset
		EDCName="SyEDC_"+num2str(Gap_Original[ii])+"meV"
		Duplicate/O SyEDC,root:Simulation:GapSimu:SymmetrizedEDC:$EDCName
		//MoveWave $EDCO,root:GapSimu:SymmetrizedEDC:
		DFEDC=DFEDC-ii*EDCOffset
		EDCName="EDCDF_"+num2str(Gap_Original[ii])+"meV"
		Duplicate/O DFEDC,root:Simulation:GapSimu:EDCbyFermiFunc:$EDCName
		//MoveWave $EDCO,root:GapSimu:EDCbyFermiFunc:
		ii=ii+1
	while(ii<AngleDim)
	GapL="Gap_LeadingEdge_"+num2str(resolution)+"meV"
	GapP="Gap_Peak_"+num2str(resolution)+"meV"
	GapD="Gap_DF_"+num2str(resolution)+"meV"
	GraphN="Gap_"+"Resolution"+num2str(Resolution)+"meV"+num2str(temperature)+"K"//+"Gamma"+num2str(fwhm)+"_Temperature_"+num2str(temperature)+"K"
	Duplicate/o Gap_LeadingEdge, $gapl
	Duplicate/o Gap_Peak, $gapp
	Duplicate/o Gap_DF, $GapD
	
	dowindow/K $graphN
	Display/N=$GraphN $gapl,$gapp,$gapD,Gap_Original
	ModifyGraph tick=2,mirror=2,fStyle=1,fSize=18,axThick=2,standoff=0
	ModifyGraph lsize=2,rgb($Gapp)=(0,39168,0);DelayUpdate
	ModifyGraph rgb($Gapl)=(0,12800,52224)
	ModifyGraph rgb($GapD)=(0,52224,52224)
	Label left "Gap (meV)";DelayUpdate
	Label bottom "Angle (Degree)"
	ModifyGraph width={Aspect,1}
	ModifyGraph height=425.197
	Legend/C/N=text0/F=0
	Legend/C/N=text0/J/X=24.00/Y=11.00
	//if GapFromSymmetrizedEDC
	//end
	//background=10
end


//function findLeadingEdge(peakPn,EDC)
	//wave EDC
	//variable peakPn
	
//end
function ShowSymmetrizedEDC(CtrlName):ButtonControl
	String CtrlName
	String AllofEDCName
	String GraphN,EDCName
	variable PointNum,ii
	setdatafolder root:Simulation:GapSimu
	nvar Radio_OneEDC
	nvar Radio_AllEDC
	nvar EDCEvery
	nvar EStart
	nvar EEnd
	nvar EDCatAngle
	nvar EDCOffset
	nvar AngleStep
	nvar Append2graph

	setdatafolder root:Simulation:GapSimu:SymmetrizedEDC
	AllofEDCName=WaveList ("SyEDC_*",";","DIMS:1")
	Variable NumofEDC=ItemsInList(AllofEDCName,";")
	if (!NumofEDC)
		DoAlert 0, "Are you kidding me! Please make sure you have EDC data in the folder root:GapSimu:SymmetrizedEDC"
	endif
	
	if (V_Flag==0)
	PointNum=round(EDCatAngle/AngleStep)

	if (EDCatAngle>45)
		PointNum=round(90/AngleStep)-PointNum
	endif
	
	if (Radio_OneEDC)
		if (append2graph)
			appendtograph $StringFromList(PointNum,AllofEDCName,";")
		else
			GraphN="SymmetrizedEDC"+"_Angle"+num2Str(EDCatAngle)
			dowindow/K $graphN
			Display/N=$GraphN $StringFromList(PointNum,AllofEDCName,";")
			
		endif
		findpeak/Q/R=(-0.1,0.05) $StringFromList(PointNum,AllofEDCName,";")
		SetAxis left 0,V_PeakVal*1.05
	endif
	if (radio_AllEDC)
		GraphN="SymmetrizeEDC_All"
		dowindow/K $GraphN
		display/N=$GraphN
		ii=0
		do
			AppendToGraph/W=$graphN $StringFromList(ii,AllofEDCName,";")
			EDCName=StringFromList(ii,AllofEDCName,";")
			//ModifyGraph offset($EDCName)={0,ii*EDCOffset/EDCEvery}
			ii=ii+EDCEvery
		while(ii<NumofEDC)
	if (sign(EDCOffset)==1)
		findpeak/Q/R=(-0.1,0.05) $EDCName
		SetAxis left 0,V_PeakVal+ii*EDCOffset/EDCEvery
	else
		findpeak/Q/R=(-0.1,0.05) $StringFromList(0,AllofEDCName,";")
		SetAxis left ii*EDCOffset/EDCEvery,V_PeakVal
		
	endif
	endif
	
	ModifyGraph tick(left)=3,tick(bottom)=2,zero(bottom)=10,mirror=2,fStyle=1;DelayUpdate
	ModifyGraph fSize=18,axThick=2,zeroThick(bottom)=1.5,standoff=0,font="Arial";DelayUpdate
	Label left "Intensity (Arb. Units)";DelayUpdate
	Label bottom "\\u#2E-E\\BF\\M (meV)";DelayUpdate
	SetAxis bottom EStart,Eend
	ModifyGraph margin(top)=7,margin(right)=14
	ModifyGraph height=340.157
	ModifyGraph width={Aspect,1}
	ModifyGraph lblMargin(left)=3 
	ModifyGraph noLabel(left)=1
	ModifyGraph margin(left)=28
	ModifyGraph lblMargin(bottom)=5
	ModifyGraph width=0,height=0
	endif
end


function ShowOriginalEDC(CtrlName):ButtonControl
	String CtrlName
	String AllofEDCName
	String GraphN,EDCName
	variable PointNum,ii
	setdatafolder root:Simulation:GapSimu
	nvar Radio_OneEDC
	nvar Radio_AllEDC
	nvar EDCEvery
	nvar EStart
	nvar EEnd
	nvar EDCatAngle
	nvar EDCOffset
	nvar AngleStep
	nvar Append2graph

	setdatafolder root:Simulation:GapSimu:OriginalEDC
	AllofEDCName=WaveList ("EDC_*",";","DIMS:1")
	Variable NumofEDC=ItemsInList(AllofEDCName,";")
	if (!NumofEDC)
		DoAlert 0, "Are you kidding me! Please make sure you have EDC data in the folder root:GapSimu:OriginalEDC"
	endif
	
	if (V_Flag==0)

	PointNum=round(EDCatAngle/AngleStep)

	if (EDCatAngle>45)
		PointNum=round(90/AngleStep)-PointNum
	endif

	
	if (Radio_OneEDC)
		if (Append2Graph)
			appendtograph $StringFromList(PointNum,AllofEDCName,";")
		else
			GraphN="OriginalEDC"+"_Angle"+num2Str(EDCatAngle)
			dowindow/K $graphN
			Display/N=$GraphN $StringFromList(PointNum,AllofEDCName,";")
		endif
			findpeak/Q/R=(-0.1,0.05) $StringFromList(PointNum,AllofEDCName,";")
			SetAxis left 0,V_PeakVal*1.05
		
	endif
	if (radio_AllEDC)
		GraphN="OriginalEDC_All"
		dowindow/K $GraphN 
		display/N=$GraphN

		ii=0
		do
			AppendToGraph/W=$graphN $StringFromList(ii,AllofEDCName,";")
			EDCName=StringFromList(ii,AllofEDCName,";")
			//ModifyGraph offset($EDCName)={0,ii*EDCOffset/EDCEvery}
			//$EDCName=$EDCName+ii*EDCOffset/EDCEvery
			ii=ii+EDCEvery
		while(ii<NumofEDC)
	if (sign(EDCOffset)==1)
		findpeak/Q/R=(-0.1,0.05) $EDCName
		SetAxis left 0,V_PeakVal+ii*EDCOffset/EDCEvery
	else
		findpeak/Q/R=(-0.1,0.05) $StringFromList(0,AllofEDCName,";")
		SetAxis left ii*EDCOffset/EDCEvery,V_PeakVal
		
	endif
	endif

	ModifyGraph tick(left)=3,tick(bottom)=2,zero(bottom)=10,mirror=2,fStyle=1;DelayUpdate
	ModifyGraph fSize=18,axThick=2,zeroThick(bottom)=1.5,standoff=0,font="Arial";DelayUpdate
	Label left "Intensity (Arb. Units)";DelayUpdate
	Label bottom "\\u#2E-E\\BF\\M (meV)";DelayUpdate
	SetAxis bottom EStart,Eend
	ModifyGraph margin(top)=7,margin(right)=14
	ModifyGraph height=340.157
	ModifyGraph width={Aspect,1}
	ModifyGraph lblMargin(left)=3 
	ModifyGraph noLabel(left)=1
	ModifyGraph margin(left)=28
	ModifyGraph lblMargin(bottom)=5
	ModifyGraph height=0
	ModifyGraph width=0
	endif
end

function ShowDevideFermiFuncEDC(CtrlName):ButtonControl
	String CtrlName
	String AllofEDCName
	String GraphN,EDCName
	variable PointNum,ii
	setdatafolder root:Simulation:GapSimu
	nvar Radio_OneEDC
	nvar Radio_AllEDC
	nvar EDCEvery
	nvar EStart
	nvar EEnd
	nvar EDCatAngle
	nvar EDCOffset
	nvar AngleStep
	nvar Append2Graph
	
	setdatafolder root:Simulation:GapSimu:EDCbyFermiFunc
	AllofEDCName=WaveList ("*EDCDF_*",";","DIMS:1")
	Variable NumofEDC=ItemsInList(AllofEDCName,";")
	if (!NumofEDC)
		DoAlert 0, "Are you kidding me! Please make sure you have EDC data in the folder root:GapSimu:EDCbyFermiFunc"
	endif
	
	if (V_Flag==0)
	PointNum=round(EDCatAngle/AngleStep)

	if (EDCatAngle>45)
		PointNum=round(90/AngleStep)-PointNum
	endif

	
	if (Radio_OneEDC)
		if (Append2Graph)
			AppendtoGraph $StringFromList(PointNum,AllofEDCName,";")
		else
			GraphN="DevideFermiFuncEDC"+"_Angle"+num2Str(EDCatAngle)
			dowindow/K $graphN
			Display/N=$GraphN $StringFromList(PointNum,AllofEDCName,";")
		endif
		findpeak/Q/R=(-0.1,0.05) $StringFromList(PointNum,AllofEDCName,";")
		SetAxis left 0,V_PeakVal*1.05
	endif
	if (radio_AllEDC)
		GraphN="DevideFermiFuncEDC_All"
		dowindow/K $GraphN
		display/N=$GraphN

		ii=0
		do
			AppendToGraph/W=$graphN $StringFromList(ii,AllofEDCName,";")
			EDCName=StringFromList(ii,AllofEDCName,";")
			//ModifyGraph offset($EDCName)={0,ii*EDCOffset/EDCEvery}
			//$EDCName+=ii*EDCOffset/EDCEvery
			ii=ii+EDCEvery
		while(ii<NumofEDC)
	//findpeak/Q/R=(-0.1,0.05) $EDCName
		if (sign(EDCOffset)==1)
			findpeak/Q/R=(-0.1,0.05) $EDCName
			SetAxis left 0,V_PeakVal+ii*EDCOffset/EDCEvery
		else
			findpeak/Q/R=(-0.1,0.05) $StringFromList(0,AllofEDCName,";")
			SetAxis left ii*EDCOffset/EDCEvery,V_PeakVal
		
		endif
	endif

	ModifyGraph tick(left)=3,tick(bottom)=2,zero(bottom)=10,mirror=2,fStyle=1;DelayUpdate
	ModifyGraph fSize=18,axThick=2,zeroThick(bottom)=1.5,standoff=0,font="Arial";DelayUpdate
	Label left "Intensity (Arb. Units)";DelayUpdate
	Label bottom "\\u#2E-E\\BF\\M (meV)";DelayUpdate
	SetAxis bottom EStart,Eend
	ModifyGraph margin(top)=7,margin(right)=14
	ModifyGraph height=340.157
	ModifyGraph width={Aspect,1}
	ModifyGraph lblMargin(left)=3 
	ModifyGraph noLabel(left)=1
	ModifyGraph margin(left)=28
	ModifyGraph lblMargin(bottom)=5
	ModifyGraph height=0
	ModifyGraph width=0
	
	endif
end

proc GapSimuHellp(CtrlName):ButtonControl
	String CtrlName
	DoWindow/F HelpforGapSimulation
	if (V_Flag==0)
		String txt
		NewNotebook/W=(100,100,470,400)/F=1/N=HelpforGapSimulation
		Notebook HelpforGapSimulation, showruler=0, backRGB=(45000,65535,65535)
		Notebook HelpforGapSimulation, fstyle=0, text="¡ñIf you have any problem, please contact",fstyle=1, text=" WTZero@gmail.com\r\r"
		Notebook HelpforGapSimulation, fstyle=0, text="¡ñEDC: Phys. Rev. B",fstyle=1, text=" 57,",fstyle=0,text=" 11093(1998)\r\r"
		Notebook HelpforGapSimulation, fstyle=0, text="¡ñt-J Model: Phys. Rev. B",fstyle=1, text=" 72,",fstyle=0,text=" 054519(2005)\r\r"
		Notebook HelpforGapSimulation, fstyle=0, text="¡ñ2D gap Simulation: Nature",fstyle=1, text=" 456",fstyle=0,text="(7218)\r\r"
		Notebook HelpforGapSimulation, fstyle=0, text="¡ñSome Terms\r	Akw: spectra function\r	Original_Image:Spectra function multiped by Fermi function\r	Convolved_Image: Original_Image convolved by resolution\r	DCF_Image: Convolved_Image devived by convolved Fermifunc\r\r"
		Notebook HelpforGapSimulation, fstyle=0, text="¡ñNotes: The t-J model only using for Bi2212\r\r"
	
	
	endif
end



Function ShowFermiSurface(CtrlName):ButtonControl
		String CtrlName
		String GraphN
		SetDatafolder root:Simulation:t_J_Model
		nvar t0
		nvar t1
		nvar t2
		nvar t3
		nvar t_bi
		nvar t_z
		nvar E_F
		nvar Bonding
		nvar AntiBonding
		nvar kz
		nvar a0

		Make/O/N=(2001,2001)/D BondingEnergy,AntiBondingEnergy,Tz,Az,Ep,Ez,TwoBandsEnergy
		SetScale/I x -1,1,"", BondingEnergy,AntiBondingEnergy,Tz,Az,Ep,Ez,TwoBandsEnergy
		SetScale/I y -1,1,"", BondingEnergy,AntiBondingEnergy,Tz,Az,Ep,Ez,TwoBandsEnergy
		Ep=E_F-2*t0*(cos(x*pi)+cos(y*pi))-4*t1*t0*cos(pi*x)*cos(Pi*y)-2*t2*t0*(cos(2*x*pi)+cos(2*y*pi))-4*t3*t0*(cos(2*x*pi)*cos(y*pi)+cos(2*y*pi)*cos(x*pi))
		Az=4*t_z*t0*cos(x*pi/2)*cos(y*pi/2)
		Tz=-sqrt((t_Bi*t0)^2+Az^2+2*t0*t_bi*Az*cos(kz*pi/2))
		Ez=-Tz*(a0+0.25*(cos(x*pi)-cos(y*pi))^2)
		
		BondingEnergy=Ep-Ez
		AntiBondingEnergy=Ep+Ez
		BondingEnergy=sign(BondingEnergy)
		AntiBondingEnergy=sign(AntiBondingEnergy)
		TwoBandsEnergy=-AntiBondingEnergy+BondingEnergy
		
		
		if  (Bonding)
			if (antibonding)
			GraphN="TwoBandFermiSurafce"
			dowindow/K $GraphN
			Display/N=$GraphN;AppendImage TwoBandsEnergy

			ModifyImage TwoBandsEnergy ctab= {*,*,Terrain256,0}

			else 
			GraphN="BondingFermiSurafce"
			dowindow/K $GraphN
			Display/N=$GraphN;AppendImage BondingEnergy

			ModifyImage BondingEnergy ctab= {*,*,Terrain256,0}

			endif
		else
			GraphN="AntiBondingFermiSurafce"
			dowindow/K $GraphN
			Display/N=$GraphN;AppendImage AntibondingEnergy
			ModifyImage AntibondingEnergy ctab= {*,*,Terrain256,0}

		endif
		
			ModifyGraph tick=2,fStyle=1,fSize=18,axThick=2,standoff=0;DelayUpdate
			SetAxis left -1,1 ;DelayUpdate
			SetAxis bottom -1,1 
			ModifyGraph width={Aspect,1}
			Label left "Ky (\\F'Symbol'p/\\F'Arial'a)";DelayUpdate
			Label bottom "Kx (\\F'Symbol'p/\\F'Arial'a)"
			ModifyGraph lblMargin=10
			ModifyGraph margin(top)=14,margin(right)=14
			DrawLine 0, 0, 1, 1
			DrawLine 0, 1, 1, 0
			DrawLine 0.5, 0, 0.5, 1
			DrawLine 0, 0.5, 1, 0.5
			//SetDrawEnv linethick= 2.00
		
		
		ShowInfo
end


function Cursor2Point(CtrlName):ButtonControl
		String CtrlName
		setDatafolder root:Simulation:t_J_Model
		nvar KxStart
		nvar Kxend
		nvar KyStart
		nvar KyEnd=KyEnd

		KxStart=hcsr(A)
		KyStart=vcsr(A)
		kxEnd=hcsr(B)
		kyEnd=vcsr(B)

end


function GetCut(CtrlName):ButtonControl
		String CtrlName
		Setdatafolder root:Simulation:t_J_Model
		nvar Linearcut
		nvar KxStart
		nvar Kxend
		Nvar KyStart
		Nvar KyEnd
		Nvar PhotonEnergy
		Nvar LatticeConstant
		Nvar PHI
		Nvar Theta
		Nvar Omega
		Nvar DetectAngle
		Nvar WorkFunction
		//variable StartK,ENDK
		
		//print linearcut
		
		if (LinearCut)
			Make/O/N=601/D Kx_LinearCut,ky_LinearCut,Kp_LinearCut
			SetScale/I x KxStart,KxEnd,"", Kx_LinearCut
			Setscale/I x KyStart,KyEnd,"", Ky_LinearCut
			Ky_LinearCut=x
			Kx_LinearCut=x
			if(KxStart==KxEnd)
			Kx_LinearCut=KxStart
			endif
			if(KyStart==KyEnd)
			Ky_LinearCut=KyStart
			endif
			
			Kp_LinearCut=Sqrt((Kx_linearCut-KxStart)^2+(Ky_Linearcut-KyStart)^2)+Sqrt(KxStart^2+KyStart^2)
			RemoveFromGraph/Z Ky_LinearCut
			Appendtograph Ky_LinearCut vs Kx_LinearCut	
			ModifyGraph lsize=3,rgb(ky_LinearCut)=(13056,26112,0)
		else
			Make/O/N=601/D PhiV,Kx_ByARPES,Ky_ByARPES,RKx,RKy,Kp_ByARPES
			Setscale/I x (Phi-DetectAngle/2),(Phi+DetectAngle/2),"", PhiV
			PhiV=x
			variable K0=0.5118*LatticeConstant/3.1416*Sqrt(PhotonEnergy-WorkFunction)
			RKy=K0*sin(pi/180*Theta)*cos(pi/180*PhiV)
       		RKx=K0*sin(pi/180*(PhiV))  
       		Kp_ByARPES=RKx
			Ky_ByARPES=sqrt(RKy^2+RKx^2)*sin((atan2(RKy,RKx))+Omega*pi/180) 
			Kx_ByARPES=sqrt(RKy^2+RKx^2)*cos((atan2(RKy,RKx))+Omega*pi/180) 
			RemoveFromGraph/Z Ky_byARPES
			Appendtograph Ky_byARPES vs Kx_ByARPES
			ModifyGraph lsize(Ky_ByARPES)=3
			
		endif
end

Function TJModel_Radio(name,value)
	String name
	Variable value
	setdatafolder root:Simulation:t_J_Model
	nvar LinearCut
	nvar ByARPES

	
	strswitch (name)
		case "LinearCut":
			LinearCut= 1
			ByARPES=0
			break
		case "SelectCutsByARPES":
			LinearCut= 0
			ByARPES=1
			break

	endswitch
	CheckBox LinearCut,value= LinearCut
	CheckBox SelectCutsByARPES,value= ByARPES


End

Function GetBareBand(CtrlName):ButtonControl
		String CtrlName
		
		SetDatafolder root:Simulation:t_J_Model
		nvar t0
		nvar t1
		nvar t2
		nvar t3
		nvar t_bi
		nvar t_z
		nvar E_F
		nvar Bonding
		nvar AntiBonding
		nvar kz
		nvar a0
		nvar Linearcut
		nvar ByARPES
		String GRAPHN
		nvar KxStart
		nvar KxEND
		Nvar KyStart
		nvar Kyend
		nvar KxStart
		nvar Kxend
		Nvar KyStart
		Nvar KyEnd
		Nvar PhotonEnergy
		Nvar LatticeConstant
		Nvar PHI
		Nvar Theta
		Nvar Omega
		Nvar DetectAngle
		Nvar WorkFunction
		variable ktemp
		
		//WAVE/Z Kx_LinearCut
		//WAVE/Z Ky_LinearCut
		//WAVE/Z Kx_ByARPES
		//WAVE/Z Ky_ByARPES
		//Wave/Z Kp_ByARPES
		//Wave/Z Kp_LinearCut
		//Make/N=1001/D Kp_LinearCut,Kp_ByARPES,Ky_ByARPES,Kx_ByARPES,Ky_LinearCut,Kx_LinearCut
		Make/O/N=601/D BondingEnergy1D,AntiBondingEnergy1D,Tz1D,Az1D,Ep1D,Ez1D
		if (LinearCut)
		//variable numpnts(Kx_lea)
		//,TwoBandsEnergy1
		//SetScale/I x 0,1,"", BondingEnergy,AntiBondingEnergy,Tz,Az,Ep,Ez,TwoBandsEnergy
		//SetScale/I y 0,1,"", BondingEnergy,AntiBondingEnergy,Tz,Az,Ep,Ez,TwoBandsEnergy
		//if (Bonding)
			Make/O/N=601/D Kx_LinearCut,ky_LinearCut,Kp_LinearCut
			SetScale/I x KxStart,KxEnd,"", Kx_LinearCut
			Setscale/I x KyStart,KyEnd,"", Ky_LinearCut
			Ky_LinearCut=x
			Kx_LinearCut=x
			if(KxStart==KxEnd)
			Kx_LinearCut=KxStart
			endif
			if(KyStart==KyEnd)
			Ky_LinearCut=KyStart
			endif
			Kp_LinearCut=Sqrt((Kx_linearCut-KxStart)^2+(Ky_Linearcut-KyStart)^2)//+Sqrt(KxStart^2+KyStart^2)
			//RemoveFromGraph/Z Ky_LinearCut
			//Appendtograph Ky_LinearCut vs Kx_LinearCut	
			//ModifyGraph lsize=3,rgb(ky_LinearCut)=(13056,26112,0)
			duplicate/O Kx_linearcut,Kx
			duplicate/O Ky_Linearcut,Ky
			duplicate/O Kp_LinearCut,Kp
		endif
		
		if (ByARPES)
			Make/O/N=601/D PhiV,Kx_ByARPES,Ky_ByARPES,RKx,RKy,Kp_ByARPES
			Setscale/I x (Phi-DetectAngle/2),(Phi+DetectAngle/2),"", PhiV
			PhiV=x
			variable K0=0.5118*LatticeConstant/3.1416*Sqrt(PhotonEnergy-WorkFunction)
			RKy=K0*sin(pi/180*Theta)*cos(pi/180*PhiV)
       		RKx=K0*sin(pi/180*(PhiV))  
       		Kp_ByARPES=RKx
			Ky_ByARPES=sqrt(RKy^2+RKx^2)*sin((atan2(RKy,RKx))+Omega*pi/180) 
			Kx_ByARPES=sqrt(RKy^2+RKx^2)*cos((atan2(RKy,RKx))+Omega*pi/180) 
			//RemoveFromGraph/Z Ky_byARPES
			//Appendtograph Ky_byARPES vs Kx_ByARPES
			//ModifyGraph lsize(Ky_ByARPES)=3
			duplicate/O Kx_ByARPES,Kx
			duplicate/O Ky_ByARPES,Ky
			duplicate/O Kp_ByARPES,Kp
		
		endif
		
		Ep1D=E_F-2*t0*(cos(Kx*pi)+cos(Ky*pi))-4*t1*t0*cos(pi*Kx)*cos(Pi*Ky)-2*t2*t0*(cos(2*Kx*pi)+cos(2*ky*pi))-4*t3*t0*(cos(2*kx*pi)*cos(ky*pi)+cos(2*ky*pi)*cos(kx*pi))
		Az1D=4*t_z*t0*cos(kx*pi/2)*cos(ky*pi/2)
		Tz1D=-sqrt((t_Bi*t0)^2+Az1D^2+2*t0*t_bi*Az1D*cos(kz*pi/2))
		Ez1D=-Tz1D*(a0+0.25*(cos(kx*pi)-cos(ky*pi))^2)
		
		BondingEnergy1D=Ep1D+Ez1D
		AntiBondingEnergy1D=Ep1D-Ez1D
		//duplicate/O antibondingEnergy1D, FSfromPaper
		//FSfromPaper=-2*0.395*(cos(kx*pi)+cos(ky*pi))+4*0.084*cos(kx*pi)*cos(ky*pi)-2*0.042*(cos(2*kx*pi)+cos(2*ky*pi))+0.43
		variable Dim=Dimsize(kp,0)
		//Setscale/I x (Phi-DetectAngle/2),(Phi+DetectAngle/2),"", BondingEnergy1D,AntiBondingEnergy1D
		variable pn
		
		if (Antibonding)
			//findlevel/Q AntiBondingEnergy1D,0
			//pn=V_LevelX
			//Setscale/I x Kp[0]-Kp[pn],kp[dim-1]-Kp[pn],"", BondingEnergy1D,AntiBondingEnergy1D//,FSfromPaper
			//ktemp=kp[pn]
			//Kp=Kp-Ktemp
		elseif (bonding)
			//findlevel/Q BondingEnergy1D,0
			//pn=V_LevelX
			//Setscale/I x Kp[0]-Kp[pn],kp[dim-1]-Kp[pn],"", BondingEnergy1D,AntiBondingEnergy1D//,FSfromPaper
			//ktemp=kp[pn]
			//Kp=Kp-Ktemp
		endif
		
		if (Bonding)
			if (!Antibonding)
				GraphN="BondingBand"
				dowindow/K $GraphN
				display/N=$GraphN BondingEnergy1D vs kp
				//duplicate/O BondingEnergy1D,BareBand
			else
				GraphN="BondingAndAntiBondingBand"
				dowindow/K $GraphN
			
				display/N=$GraphN BondingEnergy1D vs kp
				appendtograph AntiBondingEnergy1D vs kp

				ModifyGraph lsize=2,rgb(BondingEnergy1D)=(0,0,52224)
			endif
			duplicate/O BondingEnergy1D,BareBand
		else
			GraphN="AntiBondingBand"
			dowindow/K $GraphN

			display/N=$GraphN AntiBondingEnergy1D vs kp
			duplicate/O AntiBondingEnergy1D,BareBand
		endif
		//Kp=Kp*pi/LatticeConstant
		ModifyGraph lsize=2
		ModifyGraph tick=2,zero(left)=10,mirror=2,fStyle=1,fSize=18,axThick=2;DelayUpdate
		ModifyGraph zeroThick(left)=1.5,lblMargin(left)=15,lblMargin(bottom)=10;DelayUpdate
		ModifyGraph standoff=0;DelayUpdate
		Label left "E-E\\BF\\M(eV)";DelayUpdate
		Label bottom "K//(1/A)"

		
end


function get2DImage(CtrlName):ButtonControl
		String CtrlName
		setdatafolder root:Simulation:Image2DSimulation
		nvar a
		nvar b
		nvar c
		nvar TJMOdel
		nvar Parabola
		nvar EnergyResolution
		nvar MomentumResolution
		nvar Temperature_2DImage
		nvar GapMax_2DImage
		nvar EnergyStart
		nvar EnergyEnd
		//variable Kstart=
		//variable Kend
		nvar FWHM
		//variable Dim
		//Make/O/N=401 BareBand
		//print kend
		variable ii,jj
		
		Make/O/N=(51,81)/D Gaussian
		SetScale/I y -0.04,0.04,"", Gaussian
		
		if (TJMOdel)
				String EBonding="BareBand"
				String Kxn="Kx"
				String Kyn="Ky"
				Duplicate/O root:Simulation:t_J_Model:$EBonding, BareBand
				Duplicate/O root:Simulation:t_J_Model:$Kxn, Kx
				Duplicate/O root:Simulation:t_J_Model:$kyn, Ky
				
				
				Make/O/N=(DimSize(Kx,0))/D GapSize,Uk,Vk
				GapSize=GapMax_2DImage*abs(cos(Kx*pi)-cos(Ky*pi))/2000
				Uk=0.5*(1-BareBand/sqrt((BareBand)^2+GapSize^2))
				Vk=0.5*(1+BareBand/sqrt((BareBand)^2+GapSize^2))

				Duplicate/O BareBand,temp
				temp=x
				SetScale/p x -25*(temp[1]-temp[0]),(temp[1]-temp[0]),"", Gaussian
				
				Make/O/N=(Dimsize(Kx,0),round((EnergyEnd-EnergyStart)/0.001)+1)/D Akw
				SetScale/I y EnergyStart,EnergyENd,"", Akw;DelayUpdate 
				SetScale/I x temp[0],temp[Dimsize(temp,0)-1],"", Akw
				//killwaves temp
				Make/O/N=(round((EnergyEnd-EnergyStart)/0.001)+1)/D EnergyScale
				SetScale/I x EnergyStart,EnergyENd,"", EnergyScale
				
				EnergyScale=x

				for(jj=0;jj<DimSize(Kx,0);jj=jj+1)

					for(ii=0;ii<Dimsize(EnergyScale,0);ii=ii+1)

					Akw[jj][ii]=Uk[jj]*FWHM/(FWHM^2+(EnergyScale[ii]+sqrt(BareBand[jj]^2+GapSize[jj]^2))^2)+Vk[jj]*FWHM/(FWHM^2+(EnergyScale[ii]-sqrt(BareBand[jj]^2+GapSize[jj]^2))^2)

					endfor

				endfor
		endif
		///make/O/N=(round((EnergyEnd-EnergyStart)/0.001)+1) FermiFunc
		//setscale/l x,EnergyStart,EnergyEnd,"",FermiFunc
		Gaussian=exp(-y^2/2/(Energyresolution/2.3548/1000)^2)/2.506628274631000502415765284811/(Energyresolution/2.3548/1000)*exp(-x^2/2/(Momentumresolution/2.3548)^2)/2.506628274631000502415765284811/(Momentumresolution/2.3548)
		Duplicate/O Akw,Original_Image
		Original_Image=Original_Image/(exp(y*11594.2/Temperature_2DImage)+1)
		Duplicate/O Original_Image,Convolved_Image
		matrixconvolve gaussian,Convolved_Image
		convolved_Image=convolved_Image/1000*(temp[1]-temp[0])
		Duplicate/O Convolved_Image,FermiFunc
		Fermifunc=1/(exp(11594.2*y/temperature_2DImage)+1)
		Duplicate/O Convolved_Image,DCF_Image
		DCF_Image/=Fermifunc
		//string root:Simulation:Image2DSimulation:ImageList="Akw;Original_Image;Convolved_Image;DCF_Image"
end

proc Show2DImage(ctrlName,popNum,popStr):PopupMenuControl
		String CtrlName
		variable popnum
		String popStr
		String EKImage="E_k"+popStr
		Setdatafolder root:Simulation:Image2DSimulation
       DoWindow $EKImage
	   if(V_flag==0)
	   		Display; AppendImage $popStr
           DoWindow/C $EKImage
	       ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
		else
	         DoWindow/F $EKImage
	    endif
	    ModifyGraph tick=2,zero=10,fStyle=1,fSize=18,axThick=2,zeroThick=1.5,standoff=0
	    ModifyGraph margin(top)=14,margin(right)=14
		Label left "E-E\\BF\\M (eV)";DelayUpdate
		Label bottom "K// (\\F'Symbol'p\\F'Arial'/a)"
		ModifyGraph lblMargin=10
end

function Show2DImageEDC(ctrlName,popNum,popStr):PopupMenuControl
		String CtrlName
		variable popnum
		String popStr
		String EDCGraphN="EDC"+popStr
		//string EDCPath="EDC_"+popStr
		newdatafolder/O/s root:simulation:Image2DSimulation:AKW_EDC
		
		killwaves/A/Z 
		newdatafolder/O/s root:simulation:Image2DSimulation:original_EDC
		killwaves/A/Z 
		newdatafolder/O/s root:simulation:Image2DSimulation:Convolved_EDC
		killwaves/A/Z 
		newdatafolder/O/s root:simulation:Image2DSimulation:DF_EDC
		killwaves/A/Z 
		setdatafolder root:Simulation:Image2DSimulation
		nvar EDCEVery_2DImage
		nvar EDCOffset_2DImage
		nvar showselectEDC
		nvar EDCStart
		nvar EDCEnd
		variable ii,jj
		string edcN
		setdatafolder root:Simulation:Image2DSimulation
		DoWindow/K $EDCGraphN
		Display/N=$EDCGraphN
		string E="EnergyScale"
		wave Energy=$E
		wave Image=$popstr
		//matrixtranspose Image
		if (showselectEDC)
			for(ii=EDCStart;ii<EDCEnd+1;ii=ii+1)
			SetDatafolder root:Simulation:Image2DSimulation
			//display A[1][] vs x
				edcn="EDC"+num2str(ii)
				Make/O/N=(Dimsize(Image,1)) EDC
				setscale/p x,Energy[0],0.001,"", EDC
				//wave EDC=$EDCN
           //WAVE EDCC=$EDC0
           		for(jj=0;jj<Dimsize(Image,1);jj=jj+1)
           		EDC[jj]=Image[ii][jj]
           		endfor
           		
           		strswitch (popstr)
					case "Original_Image":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:original_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:original_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
								break
					case "Akw":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:AKw_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:AKw_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "DCF_Image":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:DF_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:DF_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "Convolved_Image":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:Convolved_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:Convolved_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
						break
				endswitch
           		
           		//appendtograph EDC
           		
			ii=ii+EDCEVery_2DImage-1
			endfor
		
		else
			for(ii=0;ii<Dimsize(Image,0);ii=ii+1)
			SetDatafolder root:Simulation:Image2DSimulation
			//display A[1][] vs x
				edcn="EDC"+num2str(ii)
				Make/O/N=(Dimsize(Image,1)) EDC
				setscale/p x,Energy[0],0.001,"", EDC
				//wave EDC=$EDCN
           //WAVE EDCC=$EDC0
           		for(jj=0;jj<Dimsize(Image,1);jj=jj+1)
           		EDC[jj]=Image[ii][jj]
           		endfor
           		
           		strswitch (popstr)
					case "Original_Image":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:original_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:original_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
								break
					case "Akw":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:AKw_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:AKw_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "DCF_Image":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:DF_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:DF_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "Convolved_Image":
							Duplicate/O EDC,root:Simulation:Image2DSimulation:Convolved_EDC:$EDCN
							SetDatafolder root:Simulation:Image2DSimulation:Convolved_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
						break
				endswitch
           		
           		//appendtograph EDC
           		
			ii=ii+EDCEVery_2DImage-1
			endfor
			
			
		endif
end


Function SelectbareBand_Radio(name,value)
	String name
	Variable value
	setdatafolder root:Simulation:Image2DSimulation
	nvar Parabola
	nvar TJModel

	
	strswitch (name)
		case "Parabola":
			Parabola= 1
			TJModel=0
			break
		case "TJMOdel":
			Parabola= 0
			TJModel=1
			break

	endswitch
	CheckBox Parabola,value= ParaBola
	CheckBox TJMOdel,value= TJMOdel


End

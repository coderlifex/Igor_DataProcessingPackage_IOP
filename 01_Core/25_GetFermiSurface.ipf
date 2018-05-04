#pragma rtGlobals=1		// Use modern global access method.


Proc SchematicFermiSurface( )

           
   
       String Curr=GetDataFolder(1)
	   DoWindow/F Schematic_Fermi_Surface_Panel
	   if (V_flag==0)
	   NewDataFolder/O/S root:SchematicFermiSurface
	   String/G    PFermiSurfaceName=StrVarOrDefault("root:SchematicFermiSurface:PFermiSurfaceName","")
       Variable/G  NoFSPoints=NumVarOrDefault("root:SchematicFermiSurface:NoFSPoints",5)
       Variable/G  NoFSPoints_Overall=NumVarOrDefault("root:SchematicFermiSurface:NoFSPoints_Overall",5)       
       Variable/G  NoFSPoints_1BZ=NumVarOrDefault("root:SchematicFermiSurface:NoFSPoints_1BZ",5)          
       Variable/G  NoFSPoints_2BZA=NumVarOrDefault("root:SchematicFermiSurface:NoFSPoints_2BZA",5)       
       Variable/G  NoFSPoints_2BZB=NumVarOrDefault("root:SchematicFermiSurface:NoFSPoints_2BZB",5)
       Variable/G  NoFSPoints_Final=NumVarOrDefault("root:SchematicFermiSurface:NoFSPoints_Final",5)       
                 
       Variable/G  IntegratedArea_Initial=NumVarOrDefault("root:SchematicFermiSurface:IntegratedArea_Initial",5)
       Variable/G  IntegratedArea_1BZ=NumVarOrDefault("root:SchematicFermiSurface:IntegratedArea_1BZ",5)       
       Variable/G  IntegratedArea_2BZA=NumVarOrDefault("root:SchematicFermiSurface:IntegratedArea_2BZA",5)       
       Variable/G  IntegratedArea_2BZB=NumVarOrDefault("root:SchematicFermiSurface:IntegratedArea_2BZB",5)
       Variable/G  IntegratedArea_Final=NumVarOrDefault("root:SchematicFermiSurface:IntegratedArea_Final",5)
             
       Variable/G  NumberofHoles_Initial=NumVarOrDefault("root:SchematicFermiSurface:NumberofHoles_Initial",5)  
       Variable/G  NumberofHoles_1BZ=NumVarOrDefault("root:SchematicFermiSurface:NumberofHoles_1BZ",5)       
       Variable/G  NumberofHoles_2BZA=NumVarOrDefault("root:SchematicFermiSurface:NumberofHoles_2BZA",5)       
       Variable/G  NumberofHoles_2BZB=NumVarOrDefault("root:SchematicFermiSurface:NumberofHoles_2BZB",5)       
       Variable/G  NumberofHoles_Final=NumVarOrDefault("root:SchematicFermiSurface:NumberofHoles_Final",5) 
       
       Variable/G  FSShowFlag=NumVarOrDefault("root:SchematicFermiSurface:FSShowFlag",5) 
       
       Variable/G  MDCShowFlag=NumVarOrDefault("root:SchematicFermiSurface:MDCShowFlag",5)     
       Variable/G  MDCShowOffset=NumVarOrDefault("root:SchematicFermiSurface:MDCShowOffset",5)  
       Variable/G  MDCShowBind=NumVarOrDefault("root:SchematicFermiSurface:MDCShowBind",5)                     
       Variable/G  EnergyPosition=NumVarOrDefault("root:SchematicFermiSurface:EnergyPosition",5)        
             
       Variable/G  EDCShowFlag=NumVarOrDefault("root:SchematicFermiSurface:EDCShowFlag",5)  
       Variable/G  EDCShowOffset=NumVarOrDefault("root:SchematicFermiSurface:EDCShowOffset",5)   
       Variable/G  EDCShowBind=NumVarOrDefault("root:SchematicFermiSurface:EDCShowBind",5)
       Variable/G  EDCPlotMode=NumVarOrDefault("root:SchematicFermiSurface:EDCPlotMode",5)
       

       Variable/G  EDCFitBackGround=NumVarOrDefault("root:SchematicFermiSurface:EDCFitBackGround",5)   
       Variable/G  EDCFitGapSize=NumVarOrDefault("root:SchematicFermiSurface:EDCFitGapSize",5)
       Variable/G  EDCFitGamma0=NumVarOrDefault("root:SchematicFermiSurface:EDCFitGamma0",5)
       Variable/G  EDCFitGamma1=NumVarOrDefault("root:SchematicFermiSurface:EDCFitGamma1",5)  
       Variable/G  EDCFitPreFactor=NumVarOrDefault("root:SchematicFermiSurface:EDCFitPreFactor",5)    
       Variable/G  EDCFitFlag=NumVarOrDefault("root:SchematicFermiSurface:EDCFitFlag",5)         
       Variable/G  EDCERange=NumVarOrDefault("root:SchematicFermiSurface:EDCERange",5) 
       
       Variable/G  SCGapMax=NumVarOrDefault("root:SchematicFermiSurface:SCGapMax",5)     
       Variable/G  SCGapBValue=NumVarOrDefault("root:SchematicFermiSurface:SCGapBValue",5)      
       
               
                                  
       NewDataFolder/O/S root:SchematicFermiSurface:EDConFS
       NewDataFolder/O/S root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
       String/G SymEDCFileList
       NewDataFolder/O/S root:SchematicFermiSurface:EDConFS:OriginalEDC
       String/G OriEDCFileList               

       Schematic_Fermi_Surface_Panel( )
       Endif
       
      SetDataFolder Curr	
    
End


Window Schematic_Fermi_Surface_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(320,101,750,453)
	ModifyPanel cbRGB=(49152,65280,32768)
	SetDrawLayer UserBack
	

    SetDrawEnv fillfgc= (48896,49152,65280)
    DrawRRect 3,2,115,116                                           //Set Initial Fermi Surface
      
    SetDrawEnv fillfgc= (0,65280,0) 
    SetDrawEnv linefgc= (0,65280,0)
    DrawRRect 120,2,245,116                                           //Get Experimental Fermi Surface    
      


    SetDrawEnv fillfgc= (0,52224,52224)
    SetDrawEnv linefgc= (0,52224,52224) 
    DrawRRect 3,117,245,244                                         //Get Experimental Fermi Surface  Info  
      
      
    SetDrawEnv fillfgc= (0,43520,65280)
    DrawRRect 246,2,425,73                                           //Get MDC
      
      
    SetDrawEnv fillfgc= (0,65280,65280)      
    DrawRRect 246,74,425,144                                       //Get EDC  on Fermi Surface   
    
    SetDrawEnv fillfgc= (65280,32768,58880)    
    DrawRRect 246,145,425,244                                       //Fit and simulate EDCs
    
    
    SetDrawEnv fillfgc= (52224,52224,0)    
    DrawRRect 3,246,333,350                                       //Superconducting Gap
    
     
      
	
	
    SetVariable set_PFSName,proc=SetVarProc,pos={10,5},size={100,40},font="Times New Roman",title="InitialFSName",fSize=10
	SetVariable set_PFSName, value= root:SchematicFermiSurface:PFermiSurfaceName
	
	SetVariable NoOfFSPoints,proc=SetVarProc,pos={10,20},size={100,25},font="Times New Roman",title="#_FS_Points",fSize=10
	SetVariable NoOfFSPoints,limits={0,inf,1},value=root:SchematicFermiSurface:NoFSPoints
	
	
	Button ProposedFermiSurface,pos={10,35},size={100,20},font="Times New Roman",title="Set Initial FS",proc=ProposedFS
	
	Button ExpandFermiSurface,pos={10,60},size={100,20},font="Times New Roman",title="EXPANDInitialFS",proc=ExpandInitialFS
//  Button RemoveFermiSurface,pos={230,90},size={120,30},title="Remove Initail  FS",proc=RemoveInitialFS		
	
	ValDisplay val_IntegratedArea,pos={10,83},size={100,25},font="Times New Roman",title="Integrated Area",fSize=10
	ValDisplay val_IntegratedArea,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_IntegratedArea,value=root:SchematicFermiSurface:IntegratedArea_Initial

	ValDisplay val_NumberofHoles,pos={10,99},size={100,25},font="Times New Roman",title="NumberofHoles",fSize=10
	ValDisplay val_NumberofHoles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofHoles,value=root:SchematicFermiSurface:NumberofHoles_Initial


	
	
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 14
	SetDrawEnv fname= "Times New Roman"
	DrawText 130,20,"Experimental FS "
	
	Button RealFermiSurfaceTable_Overall,pos={125,20},size={115,30},font="Times New Roman",title="Set Overall Table",proc=Table_Overall
	

	
	
	SetVariable FSShowFlag,proc=SetVarProc,pos={125,50},size={115,25},font="Times New Roman",title="FS Show Flag",fSize=10
	SetVariable FSShowFlag,limits={0,inf,1},value=root:SchematicFermiSurface:FSShowFlag		
	
    Button GetKxKyOverall,pos={125,68},size={115,30},font="Times New Roman",title="Get Overall KxKy",proc=GetOverallKxKy	

	ValDisplay val_NumberofPointsOverall,pos={125,100},size={115,20},font="Times New Roman",title="#ofPoints",fSize=10
	ValDisplay val_NumberofPointsOverall,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofPointsOverall,value=root:SchematicFermiSurface:NoFSPoints_Overall		

	
    SetDrawEnv textrgb= (0,0,0),fstyle= 1,fsize= 11
    SetDrawEnv fname= "Times New Roman"
	DrawText 40,130,"#Points"	

//  Button RemoveKxKyOverall,pos={245,180},size={105,20},title="RemoveOverall",proc=RemoveOverallKxKy		
	
    SetDrawEnv textrgb= (0,0,0),fstyle= 1,fsize= 11
    SetDrawEnv fname= "Times New Roman"
	DrawText 148,130,"Area"
    SetDrawEnv textrgb= (0,0,0),fstyle= 1,fsize= 11
    SetDrawEnv fname= "Times New Roman"
	DrawText 192,130,"#Holes"	
			
		
	Button RealFermiSurfaceTable_1BZ,pos={5,130},size={41,20},font="Times New Roman",title="1  BZ",proc=Table_1BZ
	ValDisplay val_NumberofPoints1BZ,pos={50,134},font="Times New Roman",size={27,20},title="",fSize=10
	ValDisplay val_NumberofPoints1BZ,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofPoints1BZ,value=root:SchematicFermiSurface:NoFSPoints_1BZ	
	Button Expand1BZ,pos={83,130},size={50,20},font="Times New Roman",title="Expand",proc=Expand1BZ
//	Button Remove1BZ,pos={120,248},size={90,15},title="Remove1BZ",proc=Remove1BZ
	ValDisplay val_IntegratedArea_1BZ,pos={137,134},font="Times New Roman",size={50,30},title="",fSize=10
	ValDisplay val_IntegratedArea_1BZ,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_IntegratedArea_1BZ,value=root:SchematicFermiSurface:IntegratedArea_1BZ
	ValDisplay val_NumberofHoles_1BZ,pos={192,134},font="Times New Roman",size={50,30},title="",fSize=10
	ValDisplay val_NumberofHoles_1BZ,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofHoles_1BZ,value=root:SchematicFermiSurface:NumberofHoles_1BZ
	

	Button RealFermiSurfaceTable_2BZA,pos={5,154},font="Times New Roman",size={41,20},title="2BZUL",proc=Table_2BZA
	ValDisplay val_NumberofPoints2BZA,pos={50,158},font="Times New Roman",size={27,20},title="",fSize=10
	ValDisplay val_NumberofPoints2BZA,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofPoints2BZA,value=root:SchematicFermiSurface:NoFSPoints_2BZA
	Button Expand2BZA,pos={83,154},size={50,20},font="Times New Roman",title="Expand",proc=Expand2BZA	
//	Button Remove2BZA,pos={120,293},size={90,15},title="Remove2BZA",proc=Remove2BZA
	ValDisplay val_IntegratedArea_2BZA,pos={137,158},font="Times New Roman",size={50,30},title="",fSize=10
	ValDisplay val_IntegratedArea_2BZA,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_IntegratedArea_2BZA,value=root:SchematicFermiSurface:IntegratedArea_2BZA	
	ValDisplay val_NumberofHoles_2BZA,pos={192,158},font="Times New Roman",size={50,30},title="",fSize=10
	ValDisplay val_NumberofHoles_2BZA,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofHoles_2BZA,value=root:SchematicFermiSurface:NumberofHoles_2BZA
		
		
	
	Button RealFermiSurfaceTable_2BZB,pos={5,177},font="Times New Roman",size={41,20},title="2BZBR",proc=Table_2BZB
	ValDisplay val_NumberofPoints2BZB,pos={50,181},font="Times New Roman",size={27,20},title="",fSize=10
	ValDisplay val_NumberofPoints2BZB,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofPoints2BZB,value=root:SchematicFermiSurface:NoFSPoints_2BZB
	Button Expand2BZB,pos={83,177},size={50,20},font="Times New Roman",title="Expand",proc=Expand2BZB	
//	Button Remove2BZB,pos={120,338},size={90,15},title="Remove2BZB",proc=Remove2BZB	
	ValDisplay val_IntegratedArea_2BZB,pos={137,181},font="Times New Roman",size={50,30},title="",fSize=10
	ValDisplay val_IntegratedArea_2BZB,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_IntegratedArea_2BZB,value=root:SchematicFermiSurface:IntegratedArea_2BZB		
	ValDisplay val_NumberofHoles_2BZB,pos={192,181},font="Times New Roman",size={50,30},title="",fSize=10
	ValDisplay val_NumberofHoles_2BZB,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofHoles_2BZB,value=root:SchematicFermiSurface:NumberofHoles_2BZB
	
	
	Button RealFermiSurfaceTable_Final,pos={5,200},font="Times New Roman",size={41,20},title="Final",proc=Table_Final
	ValDisplay val_NumberofPointsFinal,pos={50,202},font="Times New Roman",size={27,20},title="",fSize=12
	ValDisplay val_NumberofPointsFinal,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofPointsFinal,value=root:SchematicFermiSurface:NoFSPoints_Final
	Button ExpandFinal,pos={83,200},size={50,20},font="Times New Roman",title="Expand",proc=ExpandFinal	
//	Button RemoveFinal,pos={120,363},size={90,15},title="RemoveFinal",proc=RemoveFinal
	ValDisplay val_IntegratedArea_Final,pos={137,202},font="Times New Roman",size={50,30},title="",fSize=12
	ValDisplay val_IntegratedArea_Final,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_IntegratedArea_Final,value=root:SchematicFermiSurface:IntegratedArea_Final		
	ValDisplay val_NumberofHoles_Final,pos={192,202},font="Times New Roman",size={50,30},title="",fSize=12
	ValDisplay val_NumberofHoles_Final,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_NumberofHoles_Final,value=root:SchematicFermiSurface:NumberofHoles_Final	
	
	
    Button RemoveAll,pos={60,222},size={120,20},font="Times New Roman",title="RemoveALL",proc=RemoveALL	

       
       
////    SetDrawEnv linethick= 2.00
//// 	DrawLine 387, 5, 387, 450
       
////	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 14
////	DrawText 450,20,"Get MDC on Fermi Surface " 

	Button GetMDConFS,pos={255,5},size={160,25},font="Times New Roman",title="Get MDC on Fermi Surface",proc=GetMDConFS    	

	SetVariable MDCShowFlag,proc=SetVarProc,pos={250,35},font="Times New Roman",size={75,25},title="MDCFlag",fSize=10
	SetVariable MDCShowFlag,limits={0,inf,1},value=root:SchematicFermiSurface:MDCShowFlag	
	
	SetVariable MDCShowOffset,proc=SetVarProc,pos={340,35},font="Times New Roman",size={80,25},title="Offset",fSize=10
	SetVariable MDCShowOffset,limits={-inf,inf,1},value=root:SchematicFermiSurface:MDCShowOffset
	
	SetVariable MDCShowBind,proc=SetVarProc,pos={250,53},font="Times New Roman",size={75,25},title="Bind",fSize=10
	SetVariable MDCShowBind,limits={1,5,1},value=root:SchematicFermiSurface:MDCShowBind	
	
	SetVariable EnergyPosition,proc=SetVarProc,pos={340,53},font="Times New Roman",size={80,25},title="Energy",fSize=10
	SetVariable EnergyPosition,limits={-2,1,0.001},value=root:SchematicFermiSurface:EnergyPosition		
	


 

//// 	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 14
////	DrawText 450,185,"Get EDC on Fermi Surface " 
	Button GetEDConFS,pos={255,77},size={160,25},font="Times New Roman",title="Get EDCs on Fermi Surface",proc=GetEDConFS 
	   
	SetVariable EDCShowFlag,proc=SetVarProc,pos={248,105},font="Times New Roman",size={53,25},title="Flag",fSize=10
	SetVariable EDCShowFlag,limits={0,inf,1},value=root:SchematicFermiSurface:EDCShowFlag	

	SetVariable EDCShowBind,proc=SetVarProc,pos={303,105},font="Times New Roman",size={53,25},title="Bind",fSize=10
	SetVariable EDCShowBind,limits={1,5,1},value=root:SchematicFermiSurface:EDCShowBind

	SetVariable EDCShowOffset,proc=SetVarProc,pos={360,105},font="Times New Roman",size={65,25},title="Offset",fSize=10
	SetVariable EDCShowOffset,limits={-inf,inf,1},value=root:SchematicFermiSurface:EDCShowOffset


	
	SetVariable EDCPlotMode,proc=SetVarProc,pos={250,125},font="Times New Roman",size={75,25},title="PlotMode",fSize=10
	SetVariable EDCPlotMode,limits={0,1,1},value=root:SchematicFermiSurface:EDCPlotMode	
	
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 10
	SetDrawEnv fname= "Times New Roman"
	DrawText 335,130,"0--Original "  
	SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 10
    SetDrawEnv fname= "Times New Roman"
	DrawText 335,142,"1--Symmetrized "	
	
	

	Button EDCSimulation,pos={250,147},font="Times New Roman",size={75,20},title="SimuSymEDC",proc=SimulateSymmEDC		
	
	SetVariable EDCBackGround,proc=SetVarProc,pos={334,147},font="Times New Roman",size={88,25},title="BKGD",fSize=10
	SetVariable EDCbackGround,limits={-inf,inf,1},value=root:SchematicFermiSurface:EDCFitBackground
		
	SetVariable EDCGapSize,proc=SetVarProc,pos={250,169},font="Times New Roman",size={77,25},title="Gap",fSize=10
	SetVariable EDCGapSize,limits={-inf,inf,0.001},value=root:SchematicFermiSurface:EDCFitGapSize
	
	
	SetVariable EDCGamma0,proc=SetVarProc,pos={334,169},font="Times New Roman",size={88,25},title="Gm0",fSize=10
	SetVariable EDCGamma0,limits={0,inf,1},value=root:SchematicFermiSurface:EDCFitGamma0
		
	SetVariable EDCGamma1,proc=SetVarProc,pos={250,187},font="Times New Roman",size={77,25},title="Gm1",fSize=10
	SetVariable EDCGamma1,limits={-inf,inf,0.001},value=root:SchematicFermiSurface:EDCFitGamma1	
	
	
	SetVariable EDCPrefactor,proc=SetVarProc,pos={334,187},font="Times New Roman",size={88,25},title="Prefactor",fSize=10
	SetVariable EDCPrefactor,limits={0,inf,1},value=root:SchematicFermiSurface:EDCFitPrefactor	
	
	SetVariable EDCERange,proc=SetVarProc,pos={250,205},font="Times New Roman",size={80,25},title="ERange",fSize=10
	SetVariable EDCERange,limits={0,inf,1},value=root:SchematicFermiSurface:EDCERange
	
	SetVariable EDCFitFlag,proc=SetVarProc,pos={334,205},font="Times New Roman",size={88,25},title="EDCFitFlag",fSize=10
	SetVariable EDCFitFlag,limits={0,10,1},value=root:SchematicFermiSurface:EDCFitFlag	
		

			
	Button FitEDConFS,pos={275,222},font="Times New Roman",size={120,20},title="Fit SymmEDCs",proc=FitSymmEDConFS

	Button GapTable,pos={6,249},font="Times New Roman",size={120,28},title="Get SC Gap Table",proc=GetSCGapTable

	
    SetDrawEnv textrgb= (65280,0,0),fstyle= 1,fsize= 10
	SetDrawEnv fname= "Times New Roman"
	DrawText 138,258,"D=Dmax[Bcos(2Theta)+(1-B)cos(6Theta)]"  
	
	SetVariable SCGapMax,proc=SetVarProc,pos={138,260},font="Times New Roman",size={100,25},title="Dmax(meV)",fSize=10
	SetVariable SCGapMax,limits={0,+inf,1},value=root:SchematicFermiSurface:SCGapMax	
	
	
    SetVariable SCGapBValue,proc=SetVarProc,pos={248,260},font="Times New Roman",size={68,25},title="B",fSize=10
	SetVariable SCGapBValue,limits={-inf,+inf,1},value=root:SchematicFermiSurface:SCGapBValue
	
	
    
    	Button PlotGapvsTheta,pos={6,278},font="Times New Roman",size={120,22},title="Plot Gap_ThetaPiPi",proc=PlotSCGap_ThetaPiPi
	Button SimulateSCGapvsTheta,pos={135,278},font="Times New Roman",size={100,22},title="Simulate_ThetaPiPi",proc=SimulateSCGap_ThetaPiPi
	Button FitSCGapvsTheta,pos={245,278},font="Times New Roman",size={85,22},title="Fit_ThetaPiPi",proc=FitSCGap_ThetaPiPi	
      
    
    
    
    Button PloGapvscos2theta,pos={6,302},font="Times New Roman",size={120,22},title="Gap_cos(2ThetaPiPi)",proc=PlotSCGap_cos2ThetaPiPi
	Button SimulateSCGapvscos2Theta,pos={135,302},font="Times New Roman",size={100,22},title="Simul_cos(2TPiPi)",proc=SimulateSCGap_cos2ThetaPiPi
	Button FitSCGapvscos2Theta,pos={245,302},font="Times New Roman",size={85,22},title="Fit_Cos(2TPiPi)",proc=FitSCGap_cos2ThetaPiPi	
	
	
	Button PlotGapvsCosKxMCosKy,pos={6,326},font="Times New Roman",size={120,22},title="Gap_CosKx-CosKy",proc=PlotSCGap_CosKxMCosKy
	Button SimulateSCGapvsCosKxMCosKy,pos={135,326},font="Times New Roman",size={100,22},title="Simul_CosKxMKy",proc=SimulateSCGap_CosKxMCosKy
	Button FitSCGapvsCosKxMCosKy,pos={245,326},font="Times New Roman",size={85,22},title="Fit_CosKxMKy",proc=FitSCGap_CosKxMCosKy

	
	
    Button CleanFolder,pos={340,255},size={85,35},font="Times New Roman",title="CleanFolders",proc=CleanFolder   
   
    Button Done,pos={340,300},size={85,45},font="Times New Roman",title="EXIT",proc=DoneButtonFS
       

    EndMacro



Proc ProposedFS(ctrlName) : ButtonControl
	String ctrlName

	String Curr=GetDataFolder(1)
	SetDataFolder root:SchematicFermiSurface
	
	RemoveALL(ctrlName)
	
	String FSNamex="FS"+root:SchematicFermiSurface:PFermiSurfaceName+"x"
	String FSNamey="FS"+root:SchematicFermiSurface:PFermiSurfaceName+"y"
	
    Variable NoOriPoints=1*root:SchematicFermiSurface:NoFSPoints	
    Variable NoSFSPoints=2*root:SchematicFermiSurface:NoFSPoints	
	
	
	Make/O/N=(root:SchematicFermiSurface:NoFSPoints) 	$FSNamex
	Make/O/N=(root:SchematicFermiSurface:NoFSPoints) 	$FSNamey
       
	
	String WindowName="FS"+root:SchematicFermiSurface:PFermiSurfaceName
	String TableTitle="Initial Fermi Surface Input"+"_"+root:SchematicFermiSurface:PFermiSurfaceName

	        DoWindow $WindowName
	        if(V_flag==0)
	        Edit $FSNamex, $FSNamey as TableTitle
               DoWindow/C $WindowName
	        Else
	        DoWindow/F $WindowName
               Endif
	        
	     AppendToGraph $FSNamey vs $FSNamex
		 ModifyGraph mode($FSNamey)=4,marker($FSNamey)=19,lsize($FSNamey)=2, msize($FSNamey)=4
		 AppendToGraph $FSNamex vs $FSNamey
		 ModifyGraph mode($FSNamex)=4,marker($FSNamex)=19,lsize($FSNamex)=2, msize($FSNamex)=4	
//		 Legend/C/N=text10/J/F=0/A=LB "\\s($FSNamey) OriginalProposed"
       
              IntegratedArea_Initial=CalculateNumberofHoles($FSNamex,$FSNamey)
              NumberofHoles_Initial=1-2*IntegratedArea_Initial
       SetDataFolder Curr

END


Proc RemoveInitialProposedFS()
	 String Curr=GetDataFolder(1)
	 SetDataFolder root:SchematicFermiSurface

	 String FSNamex="FS"+root:SchematicFermiSurface:PFermiSurfaceName+"x"
	 String FSNamey="FS"+root:SchematicFermiSurface:PFermiSurfaceName+"y"
     RemoveFromGraph/Z $FSNamex, $FSNamey
     SetDataFolder Curr
End




Function CalculateNumberofHoles(Wavex,Wavey)
wave Wavex, Wavey 
	String Curr=GetDataFolder(1)
	SetDataFolder root:SchematicFermiSurface
	
      Variable  IntegratedArea
      Variable  NumberofHoles

      Variable NoOriPoints=1*DimSize(Wavex,0)
      Variable NoSFSPoints=2*DimSize(Wavex,0)	
	
   
           Make/O/N=(NoSFSPoints)  SymFSx, SymFSy
	       Variable i=0
	       Do
	       IF(i<NoOriPoints)
	       SymFSx[i]=Wavey[NoOriPoints-i-1]
	       SymFSy[i]=Wavex[NoOriPoints-i-1]
	       ELSE
	       SymFSx[i]=Wavex[i-NoOriPoints]
	       SymFSy[i]=Wavey[i-NoOriPoints]	 
	       ENDIF       
	       i+=1
	       While(i<NoSFSPoints)
	       
	       Duplicate/O SymFSx, OrderSymFSx
	       Duplicate/O SymFSy, OrderSymFSy

           OrderSmalltoLarge(OrderSymFSx,OrderSymFSy)

	       
//            Edit  SymFSx, SymFSy, OrderSymFSx, OrderSymFSy	 

                 
              Variable IntegPoint= 5+NoSFSPoints+1
              Make/O/N=(IntegPoint) Integx, Integy
              Integx[0]=0; Integx[1]=SymFSx[0]/4; Integx[2]=OrderSymFSx[0]/4*2; Integx[3]=OrderSymFSx[0]/4*3; Integx[4]=OrderSymFSx[0]/4*4
              Variable jj=0
              Do
              Integy[jj]=1
              jj+=1
              While(jj<5)
              
              Variable ii=5
              Do
              Integx[ii]=OrderSymFSx[ii-5]
              Integy[ii]=OrderSymFSy[ii-5]
              ii+=1
              While (ii<IntegPoint-1)
              
             Integx[IntegPoint]=1    ;Integy[IntegPoint]=OrderSymFSy[NoSFSPoints]

//           Edit Integx, Integy
      
	        IntegratedArea=XJZIntegral(Integx, Integy)
//	        NumberofHoles=1-2*IntegratedArea
	        
	        Return IntegratedArea
	               
	        SetDataFolder Curr
End




Function ExpandFermiSurface(Wavex, Wavey, BZName)
Wave Wavex, Wavey
String BZName
String Curr=GetDataFolder(1)


	String OriginalFSx="FS_"+BZName+"x"
	String OriginalFSy="FS_"+BZName+"y"
	
	String OriginalSFSx="SFS_"+BZName+"x"
	String OriginalSFSy="SFS_"+BZName+"y"	
	
	String FirstFSx="FirstFS_"+BZName+"x"
	String FirstFSy="FirstFS_"+BZName+"y"		
	
	String SecondFSx="SecondFS_"+BZName+"x"
	String SecondFSy="SecondFS_"+BZName+"y"	
	
	String ThirdFSx="ThirdFS_"+BZName+"x"
	String ThirdFSy="ThirdFS_"+BZName+"y"	
	
	String FourthFSx="FourthFS_"+BZName+"x"
	String FourthFSy="FourthFS_"+BZName+"y"
	
	String ShadowFSx="ShadowFS_"+BZName+"x"
	String ShadowFSy="ShadowFS_"+BZName+"y"	
	
	Variable NoPoints_OFS=1*DimSize(Wavex,0)
	Variable NoPoints_SFS=2*DimSize(Wavex,0)
	Variable NoPoints_FS=8*DimSize(Wavex,0)
	
//	RemoveFromGraph/Z 	$OriginalFSy,$OriginalFSx, $OriginalSFSy, $FirstFSy, $SecondFSy, $ThirdFSy
//	RemoveFromGraph/Z   $FourthFSy 
//	RemoveFromGraph/Z   $ShadowFSy

      Duplicate/O Wavex, $OriginalFSx
      Duplicate/O Wavey, $OriginalFSy
      Wave NOriginalFSx=$OriginalFSx
      Wave NOriginalFSy=$OriginalFSy     

       Make/O/N=(NoPoints_SFS)  $OriginalSFSx, $OriginalSFSy
       Wave    NOriginalSFSx=$OriginalSFSx
       Wave    NOriginalSFSy=$OriginalSFSy      
       
       
	       Variable i=0
	       Do
	       IF(i<NoPoints_OFS)
	       NOriginalSFSx[i]=NOriginalFSy[NoPoints_OFS-i-1]
	       NOriginalSFSy[i]=NOriginalFSx[NoPoints_OFS-i-1]
	       ELSE
	       NOriginalSFSx[i]=NOriginalFSx[i-NoPoints_OFS]
	       NOriginalSFSy[i]=NOriginalFSy[i-NoPoints_OFS]	 
	       ENDIF       
	       i+=1
	       While(i<NoPoints_SFS)
//       Edit $OriginalSFSx, $OriginalSFSy

       OrderSmalltoLarge(NOriginalSFSx,NOriginalSFSy)


       
       Make/O/N=(NoPoints_FS)  $FirstFSx, $FirstFSy
       Wave NFirstFSx=$FirstFSx
       Wave NFirstFSy=$FirstFSy      
       
        	Variable j=0
	       Do													   
	       IF(j<NoPoints_SFS)                                                             
	       NFirstFSx[j]=NOriginalSFSx[NoPoints_SFS-j-1];                       
	       NFirstFSy[j]=2-NOriginalSFSy[NoPoints_SFS-j-1];                   
	       EndIF												    
	       
	       IF(j>=NoPoints_SFS)									    
	       	if(j<(2*NoPoints_SFS))	       						    
	       	NFirstFSx[j]=NOriginalSFSx[j-NoPoints_SFS];                     
	       	NFirstFSy[j]=NOriginalSFSy[j-NoPoints_SFS];                   
	       	endif										           
	       ENDIF												    
	       
	       IF(j>=(2*NoPoints_SFS))								    
	       	if(j<(3*NoPoints_SFS))	     							      	
	       	NFirstFSx[j]=2-NOriginalSFSx[(3*NoPoints_SFS)-j-1];         
	       	NFirstFSy[j]=NOriginalSFSy[(3*NoPoints_SFS)-j-1];           
	       	endif											    
	       ENDIF                                                                                   

	       IF(j>=(3*NoPoints_SFS))                                                        
	       	if(j<(4*NoPoints_SFS))	                                                    	
	       	NFirstFSx[j]=2-NOriginalSFSx[j-(3*NoPoints_SFS)];            
	       	NFirstFSy[j]=2-NOriginalSFSy[j-(3*NoPoints_SFS)];           
	       	endif	                                                                       
	       ENDIF                                                                                   
              
	       j+=1;                                                                                      
	       While(j<NoPoints_FS)                                                            
//       Edit $FirstFSx, $FirstFSy
       
       Make/O/N=(NoPoints_FS)  $SecondFSx, $SecondFSy
       Wave NSecondFSx=$SecondFSx
       Wave NSecondFSy=$SecondFSy       
       Make/O/N=(NoPoints_FS)  $ThirdFSx, $ThirdFSy
       Wave NThirdFSx=$ThirdFSx
       Wave NThirdFSy=$ThirdFSy       
       Make/O/N=(NoPoints_FS)  $FourthFSx, $FourthFSy  
       Wave NFourthFSx=$FourthFSx
       Wave NFourthFSy=$FourthFSy
       Make/O/N=(NoPoints_FS)  $ShadowFSx, $ShadowFSy
       Wave NShadowFSx=$ShadowFSx
       Wave NShadowFSy=$ShadowFSy
       
	RemoveFromGraph/Z 	$OriginalFSy,$OriginalFSx, $OriginalSFSy, $FirstFSy, $SecondFSy, $ThirdFSy
	RemoveFromGraph/Z   $FourthFSy 
	RemoveFromGraph/Z   $ShadowFSy 
                     
       NSecondFSx=NFirstFSx-2;  NSecondFSy=NFirstFSy
       NThirdFSx=NFirstFSx-2;      NThirdFSy=NFirstFSy-2      
       NFourthFSx=    NFirstFSx;      NFourthFSy=NFirstFSy-2
       NShadowFSx=NFirstFSx-1;    NShadowFSy=NFirstFSy-1          
	
	AppendToGraph NFirstFSy vs NFirstFSx
	ModifyGraph mode($FirstFSy)=4,marker($FirstFSy)=19,lsize($FirstFSy)=2, msize($FirstFSy)=4	
	AppendToGraph NSecondFSy vs NSecondFSx
	ModifyGraph mode($SecondFSy)=4,marker($SecondFSy)=19,lsize($SecondFSy)=2, msize($SecondFSy)=4		
	AppendToGraph NThirdFSy vs NThirdFSx
	ModifyGraph mode($ThirdFSy)=4,marker($ThirdFSy)=19,lsize($ThirdFSy)=2, msize($ThirdFSy)=4	
	AppendToGraph NFourthFSy vs NFourthFSx
	ModifyGraph mode($FourthFSy)=4,marker($FourthFSy)=19,lsize($FourthFSy)=2, msize($FourthFSy)=4	
	AppendToGraph NShadowFSy vs NShadowFSx
	ModifyGraph lstyle($ShadowFSy)=1,lsize($ShadowFSy)=2
	
    SetDataFolder Curr



End


Proc ExpandInitialFS(ctrlName): ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)

String InitialFSx="FS"+PFermiSurfaceName+"x"
String InitialFSy="FS"+PFermiSurfaceName+"y"

              ExpandFermiSurface($InitialFSx, $InitialFSy, "")
              IntegratedArea_Initial=CalculateNumberofHoles($InitialFSx, $InitialFSy)
              NumberofHoles_Initial=1-2*IntegratedArea_Initial
SetDataFolder Curr
End

Proc Expand1BZ(ctrlName): ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)
ExpandFermiSurface(FirstKx_1BZ, FirstKy_1BZ, "1BZ")

              IntegratedArea_1BZ=CalculateNumberofHoles(FirstKx_1BZ,FirstKy_1BZ )
              NumberofHoles_1BZ=1-2*IntegratedArea_1BZ


SetDataFolder Curr
End

Proc Expand2BZA(ctrlName): ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)
ExpandFermiSurface(FirstKx_2BZA, FirstKy_2BZA, "2BZA")

              IntegratedArea_2BZA=CalculateNumberofHoles(FirstKx_2BZA,FirstKy_2BZA)
              NumberofHoles_2BZA=1-2*IntegratedArea_2BZA


SetDataFolder Curr
End

Proc Expand2BZB(ctrlName): ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)
ExpandFermiSurface(FirstKx_2BZB, FirstKy_2BZB, "2BZB")

              IntegratedArea_2BZB=CalculateNumberofHoles(FirstKx_2BZB,FirstKy_2BZB)
              NumberofHoles_2BZB=1-2*IntegratedArea_2BZB

SetDataFolder Curr
End


Proc ExpandFinal(ctrlName): ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)
ExpandFermiSurface(FirstKx_Final, FirstKy_Final, "Final")

              IntegratedArea_Final=CalculateNumberofHoles(FirstKx_Final,FirstKy_Final)
              NumberofHoles_Final=1-2*IntegratedArea_Final
              
              DuplicateFinalFS()

SetDataFolder Curr
End

Proc DuplicateFinalFS()
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface
String BZName="Final"
//Original
	String FirstFSx="FirstFS_"+BZName+"x"
	String FirstFSy="FirstFS_"+BZName+"y"		
	
	String SecondFSx="SecondFS_"+BZName+"x"
	String SecondFSy="SecondFS_"+BZName+"y"	
	
	String ThirdFSx="ThirdFS_"+BZName+"x"
	String ThirdFSy="ThirdFS_"+BZName+"y"	
	
	String FourthFSx="FourthFS_"+BZName+"x"
	String FourthFSy="FourthFS_"+BZName+"y"
	
	String ShadowFSx="ShadowFS_"+BZName+"x"
	String ShadowFSy="ShadowFS_"+BZName+"y"
	
//Add FS Name Prefix	
	
	String NFirstFSx=PFermiSurfaceName+"_"+"FirstFS"+"x"
	String NFirstFSy=PFermiSurfaceName+"_"+"FirstFS"+"y"	
	
	String NSecondFSx=PFermiSurfaceName+"_"+"SecondFS"+"x"
	String NSecondFSy=PFermiSurfaceName+"_"+"SecondFS"+"y"	
	
	String NThirdFSx=PFermiSurfaceName+"_"+"ThirdFS_"+"x"
	String NThirdFSy=PFermiSurfaceName+"_"+"ThirdFS"+"y"	
	
	String NFourthFSx=PFermiSurfaceName+"_"+"FourthFS"+"x"
	String NFourthFSy=PFermiSurfaceName+"_"+"FourthFS"+"y"
	
	String NShadowFSx=PFermiSurfaceName+"_"+"ShadowFS"+"x"
	String NShadowFSy=PFermiSurfaceName+"_"+"ShadowFS"+"y"	
		
Duplicate/O $FirstFSx $NFirstFSx
Duplicate/O $FirstFSy $NFirstFSy

Duplicate/O $SecondFSx $NSecondFSx
Duplicate/O $SecondFSy $NSecondFSy

Duplicate/O $ThirdFSx $NThirdFSx
Duplicate/O $ThirdFSy $NThirdFSy

Duplicate/O $FourthFSx $NFourthFSx
Duplicate/O $FourthFSy $NFourthFSy

Duplicate/O $ShadowFSx $NShadowFSx
Duplicate/O $ShadowFSy $NShadowFSy


SetDataFolder Curr
END




Function RemoveFermiSurface(BZName)
String BZName

String Curr=GetDataFolder(1)
	String OriginalFSx="FS_"+BZName+"x"
	String OriginalFSy="FS_"+BZName+"y"
	
	String OriginalSFSx="SFS_"+BZName+"x"
	String OriginalSFSy="SFS_"+BZName+"y"	
	
	String FirstFSx="FirstFS_"+BZName+"x"
	String FirstFSy="FirstFS_"+BZName+"y"	
	
	String SecondFSx="SecondFS_"+BZName+"x"
	String SecondFSy="SecondFS_"+BZName+"y"	
	
	String ThirdFSx="ThirdFS_"+BZName+"x"
	String ThirdFSy="ThirdFS_"+BZName+"y"	
	
	String FourthFSx="FourthFS_"+BZName+"x"
	String FourthFSy="FourthFS_"+BZName+"y"
	
	String ShadowFSx="ShadowFS_"+BZName+"x"
	String ShadowFSy="ShadowFS_"+BZName+"y"	


	RemoveFromGraph/Z 	$OriginalFSy,$OriginalFSx, $OriginalSFSy, $FirstFSy, $SecondFSy, $ThirdFSy
	RemoveFromGraph/Z   $FourthFSy 
	RemoveFromGraph/Z   $ShadowFSy 
	
SetDataFolder Curr
End


Proc RemoveInitialFS(ctrlName) : ButtonControl
	String ctrlName
       String Curr
       RemoveInitialProposedFS()
	RemoveFermiSurface("")
	SetDataFolder Curr
End

Proc Remove1BZ(ctrlName) : ButtonControl
	String ctrlName
      String Curr
      RemoveFermiSurface("1BZ")
	SetDataFolder Curr
End

Proc Remove2BZA(ctrlName) : ButtonControl
	String ctrlName
      String Curr
	RemoveFermiSurface("2BZA")
	SetDataFolder Curr
End

Proc Remove2BZB(ctrlName) : ButtonControl
	String ctrlName
      String Curr
	RemoveFermiSurface("2BZB")
	SetDataFolder Curr
End

Proc RemoveFinal(ctrlName) : ButtonControl
	String ctrlName
      String Curr
	RemoveFermiSurface("Final")
	SetDataFolder Curr
End





Proc Table_Overall(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)


SetDataFolder root:SchematicFermiSurface

root:SchematicFermiSurface:NoFSPoints_Overall=abs(root:PROCESS:ThetaEnd-root:PROCESS:ThetaStart)+1

Make/O/N=(NoFSPoints_Overall) ThetaAngle, FSPointNumber, FSFlag, Kx_Overall, Ky_Overall,CosKxMCosKy, BZThetaGamma, BZThetaPiPi,COS2BZThetaGamma,COS2BZThetaPiPi
Make/T/O/N=(NoFSPoints_Overall)  ProcessImg,DispImage, Note_Overall
ProcessImg=""
DispImage=""


String   NameofProcessImage,NameofDisImage
Variable PositionofT, PositionofT_Pro
Variable StringLen, StringLen_Pro
String   Prename, Prename_Pro
String   AfterName, AfterName_Pro
String   SignofDisTheta, SignofDisTheta_Pro
String   ABSTheta, ABSTheta_Pro
Variable SM, SM_Pro
Variable DisTheta, ProTheta


Variable NumofDisImag=ItemsinList(root:DispersionIMAGE:DispersionFileList,";")
//Print "NumofDisImag=", NumofDisImag
//Print root:DispersionIMAGE:DispersionFileList

Variable NumofProcessImag=ItemsinList(root:PROCESS:ProcessedFileList,";")
//Print root:DispersionIMAGE:DispersionFileList



Variable i=0
Variable jj
Do
ThetaAngle[i]=root:PROCESS:ThetaStart+i

//Find corresponding MDC Images Name and PROCESS Images
jj=0
Do
NameofDisImage=StringFromList(jj,root:DispersionIMAGE:DispersionFileList,";")
NameofProcessImage=StringFromList(jj,root:PROCESS:ProcessedFileList,";")
//Print  "NameofDisImage", NameofDisImage
//Print  "NameofProcessImage", NameofProcessImage
PositionofT=Strsearch(NameofDisImage,"T",0)
PositionofT_Pro=Strsearch(NameofProcessImage,"T",0)
StringLen=Strlen(NameofDisImage)
StringLen_Pro=Strlen(NameofProcessImage)
//Print "StringLen", StringLen
//Print "PositionofT", PositionofT
Prename=NameofDisImage[0,PositionofT]
Prename_Pro=NameofProcessImage[0,PositionofT_Pro]
//Print   "PreName", Prename
AfterName=NameofDisImage[PositionofT+1,StringLen]
AfterName_Pro=NameofProcessImage[PositionofT_Pro+1,StringLen_Pro]
//Print   "AfterName", AfterName
SignofDisTheta=NameofDisImage[StringLen-1,StringLen]
SignofDisTheta_Pro=NameofProcessImage[StringLen_Pro-1,StringLen_Pro]
//Print "SingofDisTheta=", SignofDisTheta
ABSTheta=NameofDisImage[PositionofT+1,StringLen-1]
ABSTheta_Pro=NameofProcessImage[PositionofT_Pro+1,StringLen_Pro-1]
//Print "ABSTheta=", ABSTheta
SM=StringMatch(SignofDisTheta,"n")
SM_Pro=StringMatch(SignofDisTheta_Pro,"N")
//Print "StringMatch=", SM
If (SM==1)
DisTheta=-1*Str2Num(ABSTheta)
Else
DisTheta=1*Str2Num(ABSTheta)
EndIF
//Print "DisTheta=", DisTheta


If (SM_Pro==1)
ProTheta=-1*Str2Num(ABSTheta_Pro)
Else
ProTheta=1*Str2Num(ABSTheta_Pro)
EndIF
//Print "ProTheta=", ProTheta


If (ThetaAngle[i]==DisTheta)
DispImage[i]=NameofDisImage
EndIF

If (ThetaAngle[i]==ProTheta)
ProcessImg[i]=NameofProcessImage
EndIF


jj+=1
While (jj<NumofDisImag)


i+=1
While (i<NoFSPoints_Overall)



Make/O/N=(NoFSPoints_Overall)  EDCFlag, EDCOrder
Make/O/N=(NoFSPoints_Overall)  MDCFlag, MDCOrder
Make/O/T/N=(NoFSPoints_Overall) EDCFitFile

Make/O/N=(NoFSPoints_Overall)  FitFlag, FitEStart, FitEEnd, FitBKGD, FitGap,FitGamma0, FitGamma1,FitPFactor



String WindowName="Exp"+"_Overall_FermiSurface"
String TableTitle="Experimental FermiSurface_Overall"

DoWindow $WindowName
IF(V_Flag==0)
Edit  ThetaAngle,ProcessImg,DispImage, FSPointNumber, FSFlag, Kx_Overall, Ky_Overall, MDCFlag, MDCOrder,EDCFlag, EDCOrder,EDCFitFile,FitFlag,FitEStart,FitEEnd,FitBKGD,FitGap,FitGamma0, FitGamma1,FitPFactor, Note_Overall as TableTitle
ModifyTable width(ThetaAngle)=35,width(ProcessImg)=65,width(DispImage)=60,width(FSPointNumber)=65
ModifyTable width(Note_Overall)=85, width(FSFlag)=40, width(Kx_Overall)=66, width(Ky_Overall)=66
ModifyTable width(EDCFlag)=45,  width(EDCOrder)=50, width(MDCFlag)=45,  width(MDCOrder)=50
ModifyTable width(EDCFitFile)=65,  width(FitFlag)=46, width(FitEStart)=57,  width(FitEEnd)=47
ModifyTable width(FitBKGD)=48,  width(FitGap)=60, width(FitGamma0)=68,  width(FitGamma1)=68, width(FitPFactor)=64

DoWindow/C $WindowName
Else
DoWindow/F $WindowName
EndIF

SetDataFolder Curr
End


Proc GetOverallKxKy(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)
DoWindow/F Exp_Overall_FermiSurface

String TraceNamex=root:PROCESS:SWImageName+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"RRKx"
String TraceNamey=root:PROCESS:SWImageName+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"RRKy"

String WindowName=root:SchematicFermiSurface:PFermiSurfaceName+"_Overall_FermiSurface"
String TableTitle="Experimental FermiSurface_Overall:"+root:SchematicFermiSurface:PFermiSurfaceName


//DoWindow/F $WindowName

Duplicate/O root:IMG:$TraceNamex  TraceRkkx
Duplicate/O root:IMG:$TraceNamey  TraceRkky

//Edit TraceRkkx, TraceRkky

Variable PointsofEachTheta=DimSize(TraceRkkx,0)/(root:PROCESS:ThetaEnd-root:PROCESS:ThetaStart+1)

Variable i
Variable jj
Do

jj=(ThetaAngle[i]-root:PROCESS:ThetaStart)*PointsofEachTheta+FSPointNumber[i]



	IF (FSFlag[i]==FSShowFlag)
	Kx_Overall[i]=TraceRkkx[jj]
	Ky_Overall[i]=TraceRkky[jj]
	EDCFitFile[i]=ProcessImg[i]+Num2Str(FSPointNumber)+"C"
	ELSE
	Kx_Overall[i]=0
	Ky_Overall[i]=0
	EDCFitFile[i]="N/A"
	Endif


i+=1
While (i<root:SchematicFermiSurface:NoFSPoints_Overall)

AppendToGraph Ky_Overall vs Kx_Overall
ModifyGraph mode(Ky_Overall)=3,marker(Ky_Overall)=8,msize(Ky_Overall)=6.5;DelayUpdate
ModifyGraph mrkThick(Ky_Overall)=1.4

PTable_1BZ() 
PTable_2BZA() 
PTable_2BZB() 
PTable_Final() 

SetDataFolder Curr
End


Proc RemoveOverallKxKy(ctrlName):ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

RemoveFromGraph/Z Ky_Overall

SetDataFolder Curr
End





Function NPinBZofInterest(ThetaWave,Wavex, Wavey, xmin,xmax,ymin,ymax)
//Find the number of points in 2nd BZA
Wave ThetaWave, Wavex, Wavey
Variable xmin, xmax, ymin, ymax
Variable NumberofPoints
Variable iLimit=DimSize(ThetaWave,0)

Variable i
Do 

If (Wavex[i]<xmax)
	If (Wavex[i]>xmin)
		If (Wavey[i]>ymin)
			If (Wavey[i]<ymax)

			NumberofPoints+=1
			
			Else
			Endif
		Else
		Endif
	Else
	Endif
Else
Endif

i+=1
While (i<iLimit)

Return NumberofPoints
//Print "NPof2BZA=", NPof2BZA
End



Proc PTable_1BZ() 
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

//Find the number of points in 2nd BZB
NoFSPoints_1BZ=NPinBZofInterest(ThetaAngle,Kx_Overall, Ky_Overall, 0,1,0,1)

Variable iLimit=DimSize(ThetaAngle,0)

Make/O/N=(NoFSPoints_1BZ) ThetaAngle_1BZ, FSPointNumber_1BZ,  FirstKx_1BZ, FirstKy_1BZ
Make/T/O/N=(NoFSPoints_1BZ)  Note_1BZ

Variable j
Variable kk=0
Do 

If (Kx_Overall[j]<1)
	If (Kx_Overall[j]>0)
		If (Ky_Overall[j]>0)
			If (Ky_Overall[j]<1)
			
			ThetaAngle_1BZ[kk]=ThetaAngle[j]
			FSPointNumber_1BZ[kk]=FSPointNumber[j]
                    FirstKx_1BZ[kk]=Kx_Overall[j]
                    FirstKy_1BZ[kk]=Ky_Overall[j]
                    Note_1BZ[kk]=Note_Overall[j]
                    
			kk+=1
//			Print ThetaAngle[i]
			
			Else
			Endif
		Else
		Endif
	Else
	Endif
Else
Endif

j+=1
While (j<iLimit)

             IntegratedArea_1BZ=CalculateNumberofHoles(FirstKx_1BZ,FirstKy_1BZ )
             NumberofHoles_1BZ=1-2*IntegratedArea_1BZ

SetDataFolder Curr
End


Proc Table_1BZ(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

PTable_1BZ()

RemoveALL(ctrlName)
AppendtoGraph FirstKy_1BZ vs FirstKx_1BZ
ModifyGraph mode(FirstKy_1BZ)=3,marker(FirstKy_1BZ)=8,msize(FirstKy_1BZ)=6;DelayUpdate
ModifyGraph mrkThick(FirstKy_1BZ)=1.5
Legend/C/N=text10/J/F=0/A=LB "\\s(FirstKy_1BZ) FirstKy_1BZ"

//String WindowName="Exp"+"_1BZ_FermiSurface"
//String TableTitle="Experimental FermiSurface_1BZ"

//DoWindow $WindowName
//IF(V_Flag==0)
//Edit  ThetaAngle_1BZ, FSPointNumber_1BZ,  FirstKx_1BZ, FirstKy_1BZ, Note_1BZ as TableTitle
//	ModifyTable width(FSPointNumber_1BZ)=105,width(Note_1BZ)=105
//DoWindow/C $WindowName
//Else
//DoWindow/F $WindowName
//EndIF

SetDataFolder Curr
End


Proc PTable_2BZA()
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

//Find the number of points in 2nd BZA
NoFSPoints_2BZA=NPinBZofInterest(ThetaAngle,Kx_Overall, Ky_Overall, -1,0,1,2)


IF (NoFSPoints_2BZA==0)

ELSE

      Make/O/N=(NoFSPoints_2BZA) ThetaAngle_2BZA, FSPointNumber_2BZA, SecondKx_2BZA, SecondKy_2BZA, FirstKx_2BZA, FirstKy_2BZA
      Make/T/O/N=(NoFSPoints_2BZA)  Note_2BZA


	Variable iLimit=DimSize(ThetaAngle,0)
	Variable j
	Variable kk=0
	Do 

	If (Kx_Overall[j]<0)
		If (Kx_Overall[j]>-1)
			If (Ky_Overall[j]>1)
				If (Ky_Overall[j]<2)
			
				ThetaAngle_2BZA[kk]=ThetaAngle[j]
				FSPointNumber_2BZA[kk]=FSPointNumber[j]
	                    SecondKx_2BZA[kk]=Kx_Overall[j]
 	                   SecondKy_2BZA[kk]=Ky_Overall[j]
 	                   Note_2BZA[kk]=Note_Overall[j]
                    
				kk+=1
//			Print ThetaAngle[i]
			
				Else
				Endif
			Else
			Endif
		Else
		Endif
	Else
	Endif

	j+=1
	While (j<iLimit)


	FirstKx_2BZA=-SecondKx_2BZA
	FirstKy_2BZA=2- SecondKy_2BZA


	              IntegratedArea_2BZA=CalculateNumberofHoles(FirstKx_2BZA,FirstKy_2BZA)
	              NumberofHoles_2BZA=1-2*IntegratedArea_2BZA
              
ENDIF

SetDataFolder Curr
End



Proc Table_2BZA(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

PTable_2BZA()
RemoveALL(ctrlName)
AppendtoGraph FirstKy_2BZA vs FirstKx_2BZA
ModifyGraph mode(FirstKy_2BZA)=3,marker(FirstKy_2BZA)=8,msize(FirstKy_2BZA)=6;DelayUpdate
ModifyGraph mrkThick(FirstKy_2BZA)=1.5
Legend/C/N=text10/J/F=0/A=LB "\\s(FirstKy_2BZA) FirstKy_2BZA"


//String WindowName="Exp"+"2ndBZA_FermiSurface"
//String TableTitle="Experimental FermiSurface_2ndBZA"

//DoWindow $WindowName
//IF(V_Flag==0)
//Edit  ThetaAngle_2BZA, FSPointNumber_2BZA, SecondKx_2BZA, SecondKy_2BZA, FirstKx_2BZA, FirstKy_2BZA, Note_2BZA as TableTitle
//	ModifyTable width(FSPointNumber_2BZA)=105,width(SecondKx_2BZA)=86,width(Note_2BZA)=105
//DoWindow/C $WindowName
//Else
//DoWindow/F $WindowName
//EndIF

//SetDataFolder Curr
//End


Proc PTable_2BZB()
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

//Find the number of points in 2nd BZB
NoFSPoints_2BZB=NPinBZofInterest(ThetaAngle,Kx_Overall, Ky_Overall, 1,2,-1,0)

IF (NoFSPoints_2BZB==0)

ELSE


		Variable iLimit=DimSize(ThetaAngle,0)

		Make/O/N=(NoFSPoints_2BZB) ThetaAngle_2BZB, FSPointNumber_2BZB, SecondKx_2BZB, SecondKy_2BZB, FirstKx_2BZB, FirstKy_2BZB
		Make/T/O/N=(NoFSPoints_2BZB)  Note_2BZB

		Variable j
		Variable kk=0
		Do 

		If (Kx_Overall[j]<2)
			If (Kx_Overall[j]>1)
				If (Ky_Overall[j]>-1)
					If (Ky_Overall[j]<0)
			
					ThetaAngle_2BZB[kk]=ThetaAngle[j]
					FSPointNumber_2BZB[kk]=FSPointNumber[j]
       		             SecondKx_2BZB[kk]=Kx_Overall[j]
        		            SecondKy_2BZB[kk]=Ky_Overall[j]
         		           Note_2BZB[kk]=Note_Overall[j]
                    
					kk+=1
//			Print ThetaAngle[i]
			
					Else
					Endif
				Else
				Endif
			Else
			Endif
		Else
		Endif

		j+=1
		While (j<iLimit)


		FirstKx_2BZB=2-SecondKx_2BZB
		FirstKy_2BZB=-SecondKy_2BZB

 		             IntegratedArea_2BZB=CalculateNumberofHoles(FirstKx_2BZB,FirstKy_2BZB)
 		             NumberofHoles_2BZB=1-2*IntegratedArea_2BZB

ENDIF

SetDataFolder Curr
End



Proc Table_2BZB(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)
PTable_2BZB()

AppendtoGraph FirstKy_2BZB vs FirstKx_2BZB
ModifyGraph mode(FirstKy_2BZB)=3,marker(FirstKy_2BZB)=8,msize(FirstKy_2BZB)=6;DelayUpdate
ModifyGraph mrkThick(FirstKy_2BZB)=1.5
Legend/C/N=text10/J/F=0/A=LB "\\s(FirstKy_2BZB) FirstKy_2BZB"



//String WindowName="Exp"+"2ndBZB_FermiSurface"
//String TableTitle="Experimental FermiSurface_2ndBZB"

//DoWindow $WindowName
//IF(V_Flag==0)
//Edit  ThetaAngle_2BZB, FSPointNumber_2BZB, SecondKx_2BZB, SecondKy_2BZB, FirstKx_2BZB, FirstKy_2BZB, Note_2BZB as TableTitle
//ModifyTable width(FSPointNumber_2BZB)=105,width(SecondKx_2BZB)=86,width(Note_2BZB)=105
//DoWindow/C $WindowName
//Else
//DoWindow/F $WindowName
//EndIF

SetDataFolder Curr
End



Proc PTable_Final()
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface

//Find the number of points in 2nd BZB
NoFSPoints_Final=NoFSPoints_1BZ+NoFSPoints_2BZA+NoFSPoints_2BZB

Make/O/N=(NoFSPoints_Final)  FirstKx_Final, FirstKy_Final

Variable i
Do
//Input 1BZ
If (i<NoFSPoints_1BZ)
FirstKx_Final[i]=FirstKx_1BZ[i]
FirstKy_Final[i]=FirstKy_1BZ[i]
Endif
//Input 2BZA
If (i>(NoFSPoints_1BZ-1))
	If (i<(NoFSPoints_1BZ+NoFSPoints_2BZA))
	FirstKx_Final[i]=FirstKx_2BZA[i-NoFSPoints_1BZ]
	FirstKy_Final[i]=FirstKy_2BZA[i-NoFSPoints_1BZ]
	Endif
Endif
//Input 2BZB
If (i>(NoFSPoints_1BZ+NoFSPoints_2BZA-1))
	If (i<(NoFSPoints_1BZ+NoFSPoints_2BZA+NoFSPoints_2BZB))
	FirstKx_Final[i]=FirstKx_2BZB[i-NoFSPoints_1BZ-NoFSPoints_2BZA]
	FirstKy_Final[i]=FirstKy_2BZB[i-NoFSPoints_1BZ-NoFSPoints_2BZA]	
	Endif
Endif

i+=1
While (i<NoFSPoints_Final)


              IntegratedArea_Final=CalculateNumberofHoles(FirstKx_Final,FirstKy_Final)
              NumberofHoles_Final=1-2*IntegratedArea_Final

SetDataFolder Curr
End




Proc Table_Final(ctrlName):ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

RemoveALL(ctrlName)

PTable_Final()

AppendtoGraph FirstKy_1BZ vs FirstKx_1BZ
ModifyGraph mode(FirstKy_1BZ)=3,marker(FirstKy_1BZ)=5,msize(FirstKy_1BZ)=6;DelayUpdate
ModifyGraph mrkThick(FirstKy_1BZ)=1.5,rgb(FirstKy_1BZ)=(65280,0,52224)
AppendtoGraph FirstKy_2BZA vs FirstKx_2BZA
ModifyGraph mode(FirstKy_2BZA)=3,marker(FirstKy_2BZA)=7,msize(FirstKy_2BZA)=6;DelayUpdate
ModifyGraph mrkThick(FirstKy_2BZA)=1.5,rgb(FirstKy_2BZA)=(0,39168,0)
AppendtoGraph FirstKy_2BZB vs FirstKx_2BZB
ModifyGraph mode(FirstKy_2BZB)=3,marker(FirstKy_2BZB)=8,msize(FirstKy_2BZB)=6;DelayUpdate
ModifyGraph mrkThick(FirstKy_2BZB)=1.5

AppendtoGraph FirstKx_1BZ vs FirstKy_1BZ
ModifyGraph mode(FirstKx_1BZ)=3,marker(FirstKx_1BZ)=5,msize(FirstKx_1BZ)=6;DelayUpdate
ModifyGraph mrkThick(FirstKx_1BZ)=1.5,rgb(FirstKx_1BZ)=(65280,0,52224)
AppendtoGraph FirstKx_2BZA vs FirstKy_2BZA
ModifyGraph mode(FirstKx_2BZA)=3,marker(FirstKx_2BZA)=7,msize(FirstKx_2BZA)=6;DelayUpdate
ModifyGraph mrkThick(FirstKx_2BZA)=1.5,rgb(FirstKx_2BZA)=(0,39168,0)
AppendtoGraph FirstKx_2BZB vs FirstKy_2BZB
ModifyGraph mode(FirstKx_2BZB)=3,marker(FirstKx_2BZB)=8,msize(FirstKx_2BZB)=6;DelayUpdate
ModifyGraph mrkThick(FirstKx_2BZB)=1.5




Legend/C/N=text10/J/F=0/A=MC "\\s(FirstKy_1BZ) FirstKy_1BZ\r\\s(FirstKy_2BZA) FirstKy_2BZA\r\\s(FirstKy_2BZB) FirstKy_2BZB"
Legend/C/N=text10/J/A=LB/X=5.16/Y=4.98

String WindowName="Exp"+"FinalFermiSurface"
String TableTitle="Experimental FermiSurface_Final"

DoWindow $WindowName
IF(V_Flag==0)
//Edit  FirstKx_Final, FirstKy_Final as TableTitle
DoWindow/C $WindowName
Else
DoWindow/F $WindowName
EndIF

SetDataFolder Curr

End



Proc RemoveALL(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
//Remove Initial Proposed FS
RemoveInitialProposedFS()

//Remove Expanded FS
RemoveInitialFS(ctrlName)	
	
RemoveOverallKxKy(ctrlName)

RemoveFromGraph/Z FirstKy_1BZ
RemoveFromGraph/Z  FirstKy_2BZA
RemoveFromGraph/Z FirstKy_2BZB

Remove1BZ(ctrlName)
Remove2BZA(ctrlName)	
Remove2BZB(ctrlName)
RemoveFinal(ctrlName)

RemovefromGraph/Z FirstKx_1BZ
RemovefromGraph/Z FirstKx_2BZA
RemovefromGraph/Z FirstKx_2BZB



	SetDataFolder Curr
	
End




Proc DoneButtonFS(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
       DoWindow/K Schematic_Fermi_Surface_Panel
	
	SetDataFolder Curr
	
End



Proc GetEDConFS(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

String EDCWindowName
String SEDCWindowName


IF(root:SchematicFermiSurface:EDCPlotMode==1)
EDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_Symm_"+"EDConFS"
SEDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_Symm_"+"EDConFS"
EndIF

IF(root:SchematicFermiSurface:EDCPlotMode==0)
EDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_Orig_"+"EDConFS"
SEDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_Orig_"+"EDConFS"
EndIF


DoWindow/K $SEDCWindowName

CleanEDCFolder()




SetDataFolder root:SchematicFermiSurface:EDConFS

Variable NofPoints=root:SchematicFermiSurface:NoFSPoints_Overall
Variable i=0
Variable j=0
Variable ThetaA, absThetaA
String   SignofTheta
String   ProImg
Variable FSPointN
Variable EDCOffset=root:SchematicFermiSurface:EDCShowOffset
Variable EDCBinding=root:SchematicFermiSurface:EDCShowBind

String   NameofProcessedImage=StringFromList(0,root:PROCESS:ProcessedFilelist,";")
Variable PositionofT=Strsearch(NameofProcessedImage,"T",0)
String   Prename=NameofProcessedImage[0,PositionofT]

//Print NameofProcessedImage


DoWindow  $SEDCWindowName
If (V_Flag==0)
//Display  as "EDC on Fermi Surface"
Display  as SEDCWindowName



Do

IF (root:SchematicFermiSurface:EDCFlag[i]==root:SchematicFermiSurface:EDCShowFlag)

ThetaA=root:SchematicFermiSurface:ThetaAngle[i]
absThetaA=abs(ThetaA)

	If (ThetaA<0) 
	SignofTheta="N"
	Else
	SignofTheta="P"
	Endif

ProImg=root:SchematicFermiSurface:ProcessImg[i]
FSPointN=root:SchematicFermiSurface:FSPointNumber[i]

EDCOffset=(root:SchematicFermiSurface:EDCShowOffset)*(root:SchematicFermiSurface:EDCOrder[i])

	
IF(root:SchematicFermiSurface:EDCPlotMode==1)
SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
ShowEDCfromImage(root:PROCESS:$ProImg,FSPointN, EDCOffset,EDCBinding)
EndIF


IF(root:SchematicFermiSurface:EDCPlotMode==0)
SetDataFolder root:SchematicFermiSurface:EDConFS:OriginalEDC
ShowEDCfromImage(root:PROCESS:$ProImg,FSPointN, EDCOffset,EDCBinding)
EndIF

Endif

i+=1
While (i<NofPoints)

DoWindow/C  $SEDCWindowName
Else


DoWindow/F $SEDCWindowname
//Remove Curves from the Figure
Make/O/T/N=(NofPoints)  CurvesonFig
Variable iC=0
Do
//CurvesonFig[iC]=WaveName("EDConFS",iC,1)
CurvesonFig[iC]=WaveName(EDCWindowName,iC,1)
RemoveFromGraph/Z $CurvesonFig[iC]
iC+=1
While(iC<NofPoints)


Do

IF (root:SchematicFermiSurface:EDCFlag[i]==root:SchematicFermiSurface:EDCShowFlag)

ThetaA=root:SchematicFermiSurface:ThetaAngle[i]
absThetaA=abs(ThetaA)

	If (ThetaA<0) 
	SignofTheta="N"
	Else
	SignofTheta="P"
	Endif

ProImg=root:SchematicFermiSurface:ProcessImg[i]
FSPointN=root:SchematicFermiSurface:FSPointNumber[i]
EDCOffset=(root:SchematicFermiSurface:EDCShowOffset)*(root:SchematicFermiSurface:EDCOrder[i])


IF(root:SchematicFermiSurface:EDCPlotMode==1)
SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
ShowEDCfromImage(root:PROCESS:$ProImg,FSPointN, EDCOffset,EDCBinding)

EndIF


IF(root:SchematicFermiSurface:EDCPlotMode==0)
SetDataFolder root:SchematicFermiSurface:EDConFS:OriginalEDC
ShowEDCfromImage(root:PROCESS:$ProImg,FSPointN, EDCOffset,EDCBinding)
EndIF



Endif

i+=1
While (i<NofPoints)



Endif

ModifyGraph zero(bottom)=2
////ModifyGraph width={Aspect,0.6}
ModifyGraph rgb=(0,15872,65280)
ModifyGraph margin(top)=7,margin(right)=7, margin(left)=58,margin(bottom)=58
Label left "\\Z16\\f01EDC Intensity (A. U.)"
Label bottom "\\Z16E - E\\BF\\M\\Z16 (eV)"
ModifyGraph mirror=2,fStyle=1,fSize=12,axThick=2,standoff=0
Legend/C/N=text0/A=LT
ModifyGraph tick=2
ShowInfo


//Make Table List of Symmetrized EDCs

////SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC

////SymEDCFileList=WaveList("*F*C",";","DIMS:1")
////Variable NoofSymEDC=ItemsinList(SymEDCFileList,";")

////Print "EDCList=", SymEDCFileList
////Print "Number of EDCs=", NoofSymEDC

////Make/O/T/N=(NoofSymEDC) EDCFiles,EDCNote 
////Make/O/N=(NoofSymEDC)  EDCFitFlag=0, FitEStart=0,FitEEnd=0, EDC_BKGD=0, EDC_Gap=0, EDC_Gamma0=0, EDC_Gamma1=0,EDC_PFactor=0


////Variable iFitEDC
////Do
////EDCFiles[iFitEDC]=StringFromList(iFitEDC,SymEDCFileList,";")
////iFitEDC+=1
////While(iFitEDC<NoofSymEDC)


////DoWindow EDConFS_Table
////IF(V_Flag==0)
////Edit  EDCFiles,EDCFitFlag,FitEStart, FitEEnd,EDC_BKGD,EDC_Gap,EDC_Gamma0,EDC_Gamma1, EDC_PFactor, EDCNote as "SymmetrizedEDCs on FermiSurface"
////DoWindow/C EDConFS_Table
////ELSE
////DoWindow/F EDConFS_Table
////EndIF
		

SetDataFolder Curr

End





Proc FitSymmEDConFS(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

String SEDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_EDConFS"

    SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
   
    DoWindow/F $SEDCWindowName
   
//Kill Fitted Curves in root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
	    String KilledFittedList=WaveList("fit_*F*C",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      Print "FittedCurve=", FittedCurve
//	      RemoveFromGraph/Z $FittedCurve
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList) 
	      
	    //abort  
   
    Variable SN, EN, lim
    Variable i,j 
	String ToFitEDCList, ToFitEDC_Name
	Variable w0,w1,w2,w3,w4
	ToFitEDCList=WaveList("*F*C",";","DIMS:1")
	Variable NoofEDCCurves=ItemsinList(ToFitEDCList,";")
	
       SN=0
//     EN=NoofEDCCurves-1
       EN=root:SchematicFermiSurface:NoFSPoints_Overall
       
       Variable EDCBackground=root:SchematicFermiSurface:EDCFitBackGround
       Variable EDCGapSize=root:SchematicFermiSurface:EDCFitGapSize
       Variable EDCGamma0=root:SchematicFermiSurface:EDCFitGamma0
       Variable EDCGamma1=root:SchematicFermiSurface:EDCFitGamma1
       Variable EDCPreFactor=root:SchematicFermiSurface:EDCFitPreFactor
       
      
       w0=EDCBackground
       w1=EDCGapSize
       w2=EDCGamma0
       w3=EDCGamma1
       w4=EDCPreFactor
       
       
       		
	Make/O SymEDCFitcoeff={w0, w1, w2,w3,w4}
	Redimension/D  SymEDCFitcoeff 
	lim=EN+1
////	Make/O/N=((EN-SN+1)) EDCFit_Background=0, EDCFit_Gapsize=0, EDCFit_Gamma0=0, EDCFit_Gamma1=0, EDCFit_PreFactor=0
	i=SN
    Variable EDCFit_Start
    Variable EDCFit_End
        
	DO
		
	IF (	root:SchematicFermiSurface:EDCFlag[i]==root:SchematicFermiSurface:EDCShowFlag)
		IF (root:SchematicFermiSurface:FitFlag[i]==root:SchematicFermiSurface:EDCFitFlag)
		
		
////		ToFitEDC_Name=StringFromList(i,ToFitEDCList,";")
		ToFitEDC_Name=root:SchematicFermiSurface:EDCFitFile[i]
		
		FuncFit XJZSymmEDCFit SymEDCFitCoeff root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:$ToFitEDC_Name[root:SchematicFermiSurface:FitEStart[i],root:SchematicFermiSurface:FitEEnd[i]] /D

////	    EDC_BKGD[i]=SymEDCFitCoeff[0]
////	    EDC_Gap[i]=SymEDCFitCoeff[1]
////	    EDC_Gamma0[i]=SymEDCFitCoeff[2]
////	    EDC_Gamma1[i]=SymEDCFitCoeff[3]
////	    EDC_PFactor[i]=SymEDCFitCoeff[4]
	    
////	    root:SchematicFermiSurface:FitBKGD[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:EDC_BKGD[i]
////	    root:SchematicFermiSurface:FitGap[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[1]
////	    root:SchematicFermiSurface:FitGamma0[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[2]
////	    root:SchematicFermiSurface:FitGamma1[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[3]
////	    root:SchematicFermiSurface:FitPFactor[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[4]

	    root:SchematicFermiSurface:FitBKGD[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[0]
	    root:SchematicFermiSurface:FitGap[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[1]
	    root:SchematicFermiSurface:FitGamma0[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[2]
	    root:SchematicFermiSurface:FitGamma1[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[3]
	    root:SchematicFermiSurface:FitPFactor[i]=root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:SymEDCFitCoeff[4]



    
	    
	    Else
	    EndIF
	    
	Else
	ENDIF    

		i+=1
	While(i<lim)


SetDataFolder Curr
End




Proc FitSymmEDConFS_Old(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

String SEDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_EDConFS"

    SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
   
    DoWindow/F $SEDCWindowName
   
//Kill Fitted Curves in root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
	    String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      RemoveFromGraph/Z $FittedCurve
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)   
   
    Variable SN, EN, lim
    Variable i,j 
	String ToFitEDCList, ToFitEDC_Name
	Variable w0,w1,w2,w3,w4
	ToFitEDCList=WaveList("*F*C",";","DIMS:1")
	Variable NoofEDCCurves=ItemsinList(ToFitEDCList,";")
	
       SN=0
       EN=NoofEDCCurves-1
       Variable EDCBackground=root:SchematicFermiSurface:EDCFitBackGround
       Variable EDCGapSize=root:SchematicFermiSurface:EDCFitGapSize
       Variable EDCGamma0=root:SchematicFermiSurface:EDCFitGamma0
       Variable EDCGamma1=root:SchematicFermiSurface:EDCFitGamma1
       Variable EDCPreFactor=root:SchematicFermiSurface:EDCFitPreFactor
       
      
       w0=EDCBackground
       w1=EDCGapSize
       w2=EDCGamma0
       w3=EDCGamma1
       w4=EDCPreFactor
       
       
       		
	Make/O SymEDCFitcoeff={w0, w1, w2,w3,w4}
	Redimension/D  SymEDCFitcoeff 
	lim=EN+1
	Make/O/N=((EN-SN+1)) EDCFit_Background=0, EDCFit_Gapsize=0, EDCFit_Gamma0=0, EDCFit_Gamma1=0, EDCFit_PreFactor=0
	i=SN
////        Variable EDCFit_Start=-abs(root:SchematicFermiSurface:EDCERange)
////        Variable EDCFit_End=abs(root:SchematicFermiSurface:EDCERange)
        
	DO
		IF (EDCFitFlag[i]==root:SchematicFermiSurface:EDCFitFlag)
		
		ToFitEDC_Name=StringFromList(i,ToFitEDCList,";")
		FuncFit XJZSymmEDCFit SymEDCFitcoeff root:SchematicFermiSurface:EDConFS:SymmetrizedEDC:$ToFitEDC_Name[FitEStart[i],FitEEnd[i]] /D
	    EDC_BKGD[i]=SymEDCFitCoeff[0]
	    EDC_Gap[i]=SymEDCFitCoeff[1]
	    EDC_Gamma0[i]=SymEDCFitCoeff[2]
	    EDC_Gamma1[i]=SymEDCFitCoeff[3]
	    EDC_PFactor[i]=SymEDCFitCoeff[4]
	    Else
	    EndIF

		i+=1
	While(i<lim)


SetDataFolder Curr
End




Proc SimulateSymmEDC(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

String SEDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_EDConFS"

SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC

Make/O/N=400   AASimulatedEDC
Make/O/C/N=400 TSelfEnergy

Variable GapSize=root:SchematicFermiSurface:EDCFitGapSize        //When the gap is zero, the A(k,w) is a perfect Lorentian.
Variable Gamm0=root:SchematicFermiSurface:EDCFitGamma0           //For Overdoped it is zero, for underdoped but in superconducting state it is also zero.
Variable Gamma1=root:SchematicFermiSurface:EDCFitGamma1
Variable BKGD=root:SchematicFermiSurface:EDCFitBackGround
Variable PreFactor=root:SchematicFermiSurface:EDCFitPreFactor
Variable ERange=root:SchematicFermiSurface:EDCERange


Setscale/I x, -ERange, ERange, AASimulatedEDC
Setscale/I x, -ERange, ERange, TSelfEnergy
////Setscale/I x, -0.3, 0.3, ReSEnergy
////Setscale/I x, -0.3, 0.3, ImSEnergy

TSelfEnergy=cmplx(Real((GapSize)^2/cmplx(x+0.000001,Gamm0)),-Gamma1+Imag((GapSize)^2/cmplx(x+0.000001,Gamm0)))
////ReSEnergy=Real(TSelfEnergy)
////ImSEnergy=Imag(TSelfEnergy)

AASimulatedEDC=PreFactor*abs(Imag(TSelfEnergy))/((x-Real(TSelfEnergy))^2+Imag(TSelfEnergy)^2)+BKGD

////Display ReSEnergy

RemovefromGraph/Z AASimulatedEDC

AppendtoGraph AASimulatedEDC
ModifyGraph rgb(AASimulatedEDC)=(65280,0,0)


Print "SEDCWindowName=", SEDCWindowName
DoWindow $SEDCWindowName


////IF(V_Flag==0)

////		DoWindow SimulatedEDCWindow
////		If (V_flag==0)
////		Display AASimulatedEDC as "Simulated EDC"
////		DoWindow/C SimulatedEDCWindow

////		Else
////		DoWindow/F SimulatedEDCWindow
////		Endif
		
////ELSE



////		DoWindow SimulatedEDCWindow
////		If (V_flag==0)
//////		Display AASimulatedEDC as "Simulated EDC"

////		DoWindow/C SimulatedEDCWindow

////		Else
////		DoWindow/F SimulatedEDCWindow
////		Endif	

////ENDIF

SetDataFolder Curr
End






Proc GetMDConFS(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)
String MDCWindowName="F"+num2str(root:SchematicFermiSurface:MDCShowFlag)+"_MDConFS"


NewDataFolder/O/S root:SchematicFermiSurface:MDConFS

CleanMDCFolder()
XJZGetDispersionEkImage(ctrlName)

Variable  NofPoints=root:SchematicFermiSurface:NoFSPoints_Overall
Variable j=0
Variable ThetaA, absThetaA
String   SignofTheta
String   ProImg
Variable FSPointN
Variable MDCOffset=root:SchematicFermiSurface:MDCShowOffset
Variable MDCBinding=root:SchematicFermiSurface:MDCShowBind


String   NameofProcessedImage=StringFromList(1,root:DispersionIMAGE:DispersionFileList,";")
//Print    "NameofProcessedImage", NameofProcessedImage
Variable PositionofT=Strsearch(NameofProcessedImage,"T",0)
String   Prename=NameofProcessedImage[0,PositionofT]
//Print   "PreName", Prename




//Find the point number of the Energy Position
Variable EWaveDimension
//EWaveDimension=Dimsize(root:DispersionIMAGE:$NameofProcessedImage,1)
//Make/O/N=(EWaveDimension) EReference
//EReference=ReferenceWaveY(root:DispersionIMAGE:$NameofProcessedImage)
Variable PositionofE
//PositionofE=PositionofValue(EReference,root:SchematicFermiSurface:EnergyPosition)

//Print PositionofEf



DoWindow  $MDCWindowName
If (V_Flag==0)
////Display  as "MDC on Fermi Surface"
Display  as MDCWindowName
ModifyGraph width={Aspect,1.2}
ModifyGraph tick=2


Variable i=0
Do

IF (root:SchematicFermiSurface:MDCFlag[i]==root:SchematicFermiSurface:MDCShowFlag)
    ThetaA=root:SchematicFermiSurface:ThetaAngle[i]
    absThetaA=abs(ThetaA)

//	If (ThetaA<0) 
//	SignofTheta="N"
//	Else
//	SignofTheta="P"
//	Endif

ProImg=root:SchematicFermiSurface:DispImage[i]
///Print "ProImg=",ProImg

EWaveDimension=Dimsize(root:DispersionIMAGE:$ProImg,1)
////Print "EWaveDimension=",EWaveDimension
Make/O/N=(EWaveDimension) EReference
//Edit root:DispersionIMAGE:$ProImg
EReference=ReferenceWaveY(root:DispersionIMAGE:$ProImg)
PositionofE=PositionofValue(EReference,root:SchematicFermiSurface:EnergyPosition)

////print , EwaveDimension, PositionofE


//MDCOffset=(root:SchematicFermiSurface:MDCShowOffset)*(j-1)
MDCOffset=(root:SchematicFermiSurface:MDCShowOffset)*(root:SchematicFermiSurface:MDCOrder[i])
	
ShowMDCfromImage(root:DispersionIMAGE:$ProImg,PositionofE, MDCOffset,MDCBinding)

Endif

i+=1
While (i<NofPoints)


DoWindow/C  $MDCWindowName
Else



DoWindow/F $MDCWindowname

//Remove Curves from the Figure
Make/O/T/N=(NofPoints)  CurvesonFig
Variable iC=0
Do
CurvesonFig[iC]=WaveName(MDCWindowName,iC,1)
RemoveFromGraph/Z $CurvesonFig[iC]
iC+=1
While(iC<NofPoints)



Variable i=0
Do


IF (root:SchematicFermiSurface:MDCFlag[i]==root:SchematicFermiSurface:MDCShowFlag)
ThetaA=root:SchematicFermiSurface:ThetaAngle[i]
absThetaA=abs(ThetaA)

//	If (ThetaA<0) 
//	SignofTheta="N"
//	Else
//	SignofTheta="P"
//	Endif
//ProImg=Prename+num2str(absThetaA)+SignofTheta
ProImg=root:SchematicFermiSurface:DispImage[i]
//Print "ProImg",ProImg


EWaveDimension=Dimsize(root:DispersionIMAGE:$ProImg,1)
Make/O/N=(EWaveDimension) EReference
EReference=ReferenceWaveY(root:DispersionIMAGE:$ProImg)
PositionofE=PositionofValue(EReference,root:SchematicFermiSurface:EnergyPosition)
//print , EwaveDimension, PositionofE


//MDCOffset=(root:SchematicFermiSurface:MDCShowOffset)*(j-1)
MDCOffset=(root:SchematicFermiSurface:MDCShowOffset)*(root:SchematicFermiSurface:MDCOrder[i])
	
ShowMDCfromImage(root:DispersionIMAGE:$ProImg,PositionofE, MDCOffset,MDCBinding)

Endif

i+=1
While (i<NofPoints)

Endif

ModifyGraph zero(bottom)=2
//ModifyGraph width={Aspect,0.8}
ModifyGraph margin(top)=7,margin(right)=7, margin(left)=58,margin(bottom)=58
Label left "\\Z16\\f01MDC Intensity (A. U.)";DelayUpdate
Label bottom "\\Z16momentum (\\F'Symbol'p\\F'Arial'/a)"
ModifyGraph mirror=2,fStyle=1,fSize=12,axThick=2,standoff=0
Legend/C/N=text0/F=0/A=LB

ShowInfo



SetDataFolder Curr

End


Proc GetSCGapTable(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

DoWindow SCGapTable

If (V_Flag==0)

Edit ThetaAngle, FSPointNumber,Kx_Overall, Ky_Overall,BZThetaGamma,BZThetaPiPi, CosKxMCosKy,COS2BZThetaGamma,COS2BZThetaPiPi, FitGap  as "SC Gap Table"

BZThetaGamma=atan(Ky_Overall/Kx_Overall)*180/3.1416


BZThetaPiPi=atan((1-Kx_Overall)/(1-Ky_Overall))*180/3.1416


CosKxMCosKy=abs(cos(Kx_Overall*pi)-cos(Ky_Overall*pi))

COS2BZThetaGamma=COS(2*BZThetaGamma*3.1416/180)

COS2BZThetaPiPi=COS(2*BZThetaPiPi*3.1416/180)

DoWindow/C SCGapTable
Else
DoWindow/F SCGapTable

BZThetaGamma=atan(Ky_Overall/Kx_Overall)*180/3.1416

BZThetaPiPi=atan((1-Kx_Overall)/(1-Ky_Overall))*180/3.1416

CosKxMCosKy=abs(cos(Kx_Overall*pi)-cos(Ky_Overall*pi))

COS2BZThetaGamma=COS(2*BZThetaGamma*3.1416/180)

COS2BZThetaPiPi=COS(2*BZThetaPiPi*3.1416/180)


Endif


SetDataFolder Curr

End


Proc PlotSCGap_ThetaPiPi(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

DoWindow SCGap_ThetaPiPi
If (V_Flag==0)
Duplicate/O FitGap PFitGap_TPiPi
Duplicate/O BZThetaPiPi PBZThetaPiPi
PFitGap_TPiPi=1000*abs(FitGap)
Display PFitGap_TPiPi vs PBZThetaPiPi
ModifyGraph mode=3,marker=19
ModifyGraph rgb(PFitGap_TPiPi)=(0,15872,65280)

Duplicate/O FitGap NFitGap_TPiPi
Duplicate/O BZThetaPiPi NBZThetaPiPi
NBZThetaPiPi=90-BZThetaPiPi
NFitGap_TPiPi=1000*abs(FitGap)
AppendToGraph NFitGap_TPiPi vs NBZThetaPiPi
ModifyGraph mode=3,marker(NFitGap_TPiPi)=8,rgb(NFitGap_TPiPi)=(0,15872,65280)


////Duplicate/O FitGap PFitGap_TPiPi
////PFitGap_TPiPi*=1000
////AppendToGraph PFitGap_TPiPi vs BZThetaPiPi
////ModifyGraph mode=3,marker=16
////ModifyGraph rgb(PFitGap_TPiPi)=(0,52224,0)

////Duplicate/O FitGap NFitGap_TPiPi
////Duplicate/O BZThetaPiPi NBZThetaPiPi
////NBZThetaPiPi=90-BZThetaPiPi
////NFitGap_TPiPi*=1000
////Duplicate/O BZThetaPiPi NBZThetaPiPi
////NBZThetaPiPi=90-BZThetaPiPi
////AppendToGraph NFitGap_TPiPi vs NBZThetaPiPi
////ModifyGraph mode=3,marker(NFitGap_TPiPi)=5,rgb(NFitGap_TPiPi)=(0,52224,0)



SetAxis bottom 0,90 
ModifyGraph margin(left)=55,margin(bottom)=55
Label left "\\F'Times New Roman'\\Z16\\f01Gap Size (meV)";DelayUpdate
Label bottom "\\F'Times New Roman'\\Z16\\f01Theta_PiPi"
ModifyGraph manTick(bottom)={0,5,0,0},manMinor(bottom)={0,0}
ModifyGraph standoff=0
ModifyGraph tick=2
ModifyGraph mirror=2,fStyle=1,fSize=12,axThick=2

Legend/C/N=text0/F=0/A=MC


DoWindow/C SCGap_ThetaPiPi
Else
DoWindow/F SCGap_ThetaPiPi
Duplicate/O FitGap PFitGap_TPiPi
Duplicate/O BZThetaPiPi PBZThetaPiPi
PFitGap_TPiPi*=1000

Duplicate/O FitGap NFitGap_TPiPi
Duplicate/O BZThetaPiPi NBZThetaPiPi
NBZThetaPiPi=90-BZThetaPiPi
NFitGap_TPiPi*=1000


Endif



SetDataFolder Curr

End




Proc SimulateSCGap_ThetaPiPi(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

Make/O/N=200 SimulatedSCGap_T, SimTheta
Setscale/I x 0, pi/2, SimulatedSCGap_T
Setscale/I x 0, pi/2, SimTheta


SimulatedSCGap_T=abs(SCGapMax*(SCGapBValue*cos(2*x)+(1-SCGapBValue)*cos(6*x)))
SimTheta=x*180/pi

AppendtoGraph SimulatedSCGap_T vs SimTheta
ModifyGraph lsize(SimulatedSCGap_T)=2,rgb(SimulatedSCGap_T)=(0,15872,65280)

SetDataFolder Curr

End


Proc FitSCGap_ThetaPiPi(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface


    Variable w0=root:SchematicFermiSurface:SCGapMax
    Variable w1=root:SchematicFermiSurface:SCGapBValue
	Make/O SCGapFitcoeff={w0, w1}
	Redimension/D  SCGapFitcoeff 

		FuncFit XJZSCGapForm SCGapFitcoeff root:SchematicFermiSurface:NFitGap_TPiPi  /D /X=root:SchematicFermiSurface:NBZThetaPiPi
		FuncFit XJZSCGapForm SCGapFitcoeff root:SchematicFermiSurface:PFitGap_TPiPi  /D /X=root:SchematicFermiSurface:PBZThetaPiPi
		
	Variable FitDMax=w0
	Variable FitBValue=w1
	
////    	Print "FittedDMax=", FitDMax
//// 	Print "FittedBValue=", FitBValue
		
		ModifyGraph lsize(fit_NFitGap_TPiPi)=2,lsize(fit_PFitGap_TPiPi)=2

SetDataFolder Curr

End





Proc PlotSCGap_cos2ThetaPiPi(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

DoWindow SCGap_Cos2ThetaPiPi
If (V_Flag==0)
Duplicate/O FitGap PFitGapPiPi
PFitGapPiPi*=1000
Display PFitGapPiPi vs COS2BZThetaPiPi
ModifyGraph mode=3,marker=19

Duplicate/O FitGap NFitGapPiPi
Duplicate/O COS2BZThetaPiPi NCOS2BZThetaPiPi
NCOS2BZThetaPiPi=-COS2BZThetaPiPi
NFitGapPiPi*=1000
AppendToGraph NFitGapPiPi vs NCOS2BZThetaPiPi
ModifyGraph mode=3,marker(NFitGapPiPi)=8,rgb(NFitGapPiPi)=(0,15872,65280)
SetAxis bottom -1,1 
ModifyGraph margin(left)=55,margin(bottom)=55
Label left "\\F'Times New Roman'\\Z16\\f01Gap Size (meV)";DelayUpdate
Label bottom "\\Z16\\f01cos(2ThetaPiPi)"
ModifyGraph standoff=0
ModifyGraph tick=2
ModifyGraph mirror=2,fStyle=1,fSize=12,axThick=2

DoWindow/C SCGap_Cos2ThetaPiPi
Else

Duplicate/O FitGap PFitGapPiPi
PFitGapPiPi*=1000

Duplicate/O FitGap NFitGapPiPi
Duplicate/O COS2BZThetaPiPi NCOS2BZThetaPiPi
NCOS2BZThetaPiPi=-COS2BZThetaPiPi
NFitGapPiPi*=1000

DoWindow/F SCGap_Cos2ThetaPiPi


Endif



SetDataFolder Curr

End



Proc SimulateSCGap_Cos2ThetaPiPi(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

Make/O/N=200 PSimulatedSCGap_Cos2ThetaPiPi,NSimulatedSCGap_Cos2ThetaPiPi 
Setscale/I x 0, 1, PSimulatedSCGap_Cos2ThetaPiPi
PSimulatedSCGap_Cos2ThetaPiPi=SCGapMax*x

Setscale/I x -1, 0, NSimulatedSCGap_Cos2ThetaPiPi
NSimulatedSCGap_Cos2ThetaPiPi=-SCGapMax*x

AppendtoGraph PSimulatedSCGap_Cos2ThetaPiPi
ModifyGraph lsize(PSimulatedSCGap_Cos2ThetaPiPi)=2,rgb(PSimulatedSCGap_Cos2ThetaPiPi)=(0,15872,65280)

AppendtoGraph NSimulatedSCGap_Cos2ThetaPiPi
ModifyGraph lsize(NSimulatedSCGap_Cos2ThetaPiPi)=2,rgb(NSimulatedSCGap_Cos2ThetaPiPi)=(0,15872,65280)


SetDataFolder Curr

End


Proc FitSCGap_cos2ThetaPiPi(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

Make/O/N=200 SimulatedSCGap, SimCos2Theta
Setscale/I x 0, pi/2, SimulatedSCGap
Setscale/I x 0, pi/2, SimCos2Theta


SimulatedSCGap=abs(SCGapMax*(SCGapBValue*cos(2*x)+(1-SCGapBValue)*cos(6*x)))
SimCos2Theta=cos(2*x)

AppendtoGraph SimulatedSCGap vs SimCos2Theta
ModifyGraph lsize(SimulatedSCGap)=2,rgb(SimulatedSCGap)=(0,15872,65280)

SetDataFolder Curr

End




Function XJZSCGapForm(w,x)
	//w[0]   Maximum gap size;
	//w[1]   B value;

	wave w; Variable x

	return abs(w[0]*(w[1]*cos(2*x*pi/180)+(1-w[1])*cos(6*x*pi/180)))
	
END


Proc PlotSCGap_CosKxMCosKy(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

DoWindow SCGap_CosKxMCosKy
If (V_Flag==0)
Duplicate/O FitGap PFitGap_CosKxKy
Duplicate/O CosKxMCosKy PCosKxMCosKyDB2
PFitGap_CosKxKy*=1000
PCosKxMCosKyDB2=CosKxMCosKy/2
Display PFitGap_CosKxKy vs PCosKxMCosKyDB2
ModifyGraph mode=3,marker=19
ModifyGraph rgb(PFitGap_CosKxKy)=(0,15872,65280)

////Duplicate/O FitGap NFitGap_CosKxKy
////Duplicate/O CosKxMCosKy NCosKxMCosKyDB2
////NCosKxMCosKyDB2=1-PCosKxMCosKyDB2
////NFitGap_CosKxKy*=1000
////AppendToGraph NFitGap_CosKxKy vs NCosKxMCosKyDB2
////ModifyGraph mode=3,marker(NFitGap_CosKxKy)=8,rgb(NFitGap_CosKxKy)=(0,15872,65280)

SetAxis bottom 0,1 
ModifyGraph margin(left)=55,margin(bottom)=55
Label left "\\F'Times New Roman'\\Z16\\f01Gap Size (meV)";DelayUpdate
Label bottom "\\F'Times New Roman'\\Z16\\f01[cos(k\\Bx\\M\\Z16)-cos(k\\By\\M\\Z16)]/2"
ModifyGraph standoff=0
ModifyGraph tick=2
ModifyGraph mirror=2,fStyle=1,fSize=12,axThick=2
ShowInfo
DoWindow/C SCGap_CosKxMCosKy
Else
DoWindow/F SCGap_CosKxMCosKy
Duplicate/O FitGap PFitGap_CosKxKy
PFitGap_CosKxKy*=1000

Duplicate/O CosKxMCosKy PCosKxMCosKyDB2
PCosKxMCosKyDB2=CosKxMCosKy/2


Endif



SetDataFolder Curr

End




Proc SimulateSCGap_CosKxMCosKy(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface

Make/O/N=2 SimulatedSCGap_CosKxMCosKy
Setscale/I x 0, 1, SimulatedSCGap_CosKxMCosKy

SimulatedSCGap_CosKxMCosKy=SCGapMax*x

AppendtoGraph SimulatedSCGap_CosKxMCosKy
ModifyGraph lsize(SimulatedSCGap_CosKxMCosKy)=2

SetDataFolder Curr

End


Proc FitSCGap_CosKxMCosKy(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface


    Variable w0=root:SchematicFermiSurface:SCGapMax
    Variable w1=root:SchematicFermiSurface:SCGapBValue
	Make/O SCGapFitcoeff={w0, w1}
	Redimension/D  SCGapFitcoeff 

		FuncFit XJZSCGapForm SCGapFitcoeff root:SchematicFermiSurface:NFitGap_TGamma  /D /X=root:SchematicFermiSurface:NBZThetaGamma
		FuncFit XJZSCGapForm SCGapFitcoeff root:SchematicFermiSurface:PFitGap_TGamma  /D /X=root:SchematicFermiSurface:BZThetaGamma
		
	Variable FitDMax=w0
	Variable FitBValue=w1
	
////    	Print "FittedDMax=", FitDMax
//// 	Print "FittedBValue=", FitBValue
		
		ModifyGraph lsize(fit_NFitGap_T)=2,lsize(fit_PFitGap_TGamma)=2

SetDataFolder Curr

End





Proc CleanFolder(ctrlName) : ButtonControl
String ctrlName
CleanEDCFolder()
CleanMDCFolder()
End



Proc CleanEDCFolder()
String Curr=GetDataFolder(1)
SetDataFolder root:SchematicFermiSurface:EDConFS
String EDCList= WaveList("*F*P*T*",";","DIMS:1")
Variable  NofEDC=ItemsinList(EDCList, ";")
Variable i=0
String EDC_Kill
Do
EDC_Kill=StringFromList(i,EDCList,";")
KillWaves/Z $EDC_Kill
i+=1
While(i<NofEDC)

   
//Kill Fitted Curves in root:SchematicFermiSurface:EDConFS
	      String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	  Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	  String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)   


SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
String EDCListS= WaveList("*F*P*T*",";","DIMS:1")
Variable  NofEDCS=ItemsinList(EDCListS, ";")
Variable iS=0
String EDCS_Kill
Do
EDCS_Kill=StringFromList(iS,EDCListS,";")
KillWaves/Z $EDCS_Kill
iS+=1
While(iS<NofEDCS)

//Kill Fitted Curves in root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
	      String SKilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	  Variable SNoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	  String SFittedCurve
	      Variable iSFit=0
	      Do
	      SFittedCurve=StringFromList(iSFit,SKilledFittedList,";")
	      KillWaves/Z  $SFittedCurve
	      iSFit+=1
	      While(iSFit<SNoofKilledFittedList)  




SetDataFolder root:SchematicFermiSurface:EDConFS:OriginalEDC
String EDCListO= WaveList("*F*P*T*",";","DIMS:1")
Variable  NofEDCO=ItemsinList(EDCListO, ";")
Variable iO=0
String EDCO_Kill
Do
EDCO_Kill=StringFromList(iO,EDCListO,";")
KillWaves/Z $EDCO_Kill
iO+=1
While(iO<NofEDCO)

//Kill Fitted Curves in root:SchematicFermiSurface:EDConFS:OriginalEDC
	      String OKilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	  Variable ONoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	  String OFittedCurve
	      Variable iOFit=0
	      Do
	      OFittedCurve=StringFromList(iOFit,OKilledFittedList,";")
	      KillWaves/Z  $OFittedCurve
	      iOFit+=1
	      While(iOFit<ONoofKilledFittedList)  





SetDataFolder Curr
End

Proc CleanMDCFolder()
String Curr=GetDataFolder(1)

SetDataFolder root:SchematicFermiSurface:MDConFS
String MDCList= WaveList("*F*P*T*",";","DIMS:1")
Variable  NofMDC=ItemsinList(MDCList, ";")
Variable i=0
String MDC_Kill
Do
MDC_Kill=StringFromList(i,MDCList,";")
KillWaves/Z $MDC_Kill
i+=1
While(i<NofMDC)

SetDataFolder Curr
End







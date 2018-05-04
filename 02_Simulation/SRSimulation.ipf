#pragma rtGlobals=1		// Use modern global access method.

#pragma rtGlobals=1		// Use modern global access method.
///#include "List_util"
//#include "00XJZHandyFunctions"


menu "SR Simulation"
        "-"
	"Synchrotron Simulation", SR_Simulation()       	

end	
		
Proc SR_Simulation()

	DoWindow/F SR_simulation_Window
	if (V_flag==0)
	
		NewDataFolder/O/S root:BasicVariables
		String/G filpath, filnam, fileList
		String/G folderList="Select New Folder;Summarize Folder;-;"
		Variable/G SR_Energy,  SR_Current,  SR_Gamma
		Variable/G UL_Period, UL_Number, UL_Harmonics, UL_K
//		Make/O/N=(20) Estart, Eend, Estep, Epass
//		Make/O/N=(20) Astart, Aend
//		string/G skind, smode0
 
// 	       NewDataFolder/O/S root:OriginalData
//	       String/G OriginalFileList=WaveList("A*",";","DIMS:2")
//	       Variable/G NoofOriginalFile=ItemsinList(OriginalFileList,";")
//	       String/G Original1DFileList=WaveList("A*",";","DIMS:1")
//	       Variable/G Noof1DOriginalFile=ItemsinList(Original1DFileList,";")
 
 		
		SetDataFolder root:
		SR_Simulation_Window()
		
	endif
End


Window SR_Simulation_Window() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(155,108,780,580)
	ModifyPanel cbRGB=(65535,65535,65535)

	SetDrawLayer UserBack
	SetDrawEnv fsize= 16
        SetDrawEnv fstyle= 1
        SetDrawEnv textrgb= (0,12800,52224)
        SetDrawEnv fstyle= 5	
	DrawText 12,30,"Storage Ring"                 //Storage ring
	
	SetDrawLayer UserBack
	SetDrawEnv fsize= 16
        SetDrawEnv fstyle= 1
        SetDrawEnv textrgb= (0,12800,52224)
        SetDrawEnv fstyle= 5	
	DrawText 12,140,"Undulator"                    //Undulator
	
	
	

	
	
//	SetDrawEnv fillfgc= (48896,49152,65280)
//	DrawRRect 9,41,245,245                              //SR Simulation
	
	
//	PopupMenu popFolder,pos={10,0},size={100,30},proc=SelectFolderSES,title="Set Data Folder"
//	PopupMenu popFolder,mode=0,value= #"root:SES:folderList"
	SetVariable setSREnergy,pos={10,35},size={180,20},title="Energy  (GeV)",fSize=12
//	SetVariable setSREnergy, 	proc=NCalculateSRGamma
	SetVariable setSREnergy,limits={-Inf,Inf,1},value= root:BasicVariables:SR_Energy
	
	SetVariable setSRCurrent,pos={220,35},size={180,20},title="Current (mA)",fSize=12
	SetVariable setSRCurrent,limits={-Inf,Inf,1},value= root:BasicVariables:SR_Current	
	
	Button CalGammaButton,pos={5,72},size={140,35},proc=CalculateSRGamma,title="Calculate Gamma"
	
	ValDisplay val_SRGamma,pos={156,80},size={65,20},title="",fSize=12
	ValDisplay val_SRGamma,limits={0,0,0},barmisc={0,1000},value= #"root:BasicVariables:SR_Gamma"
	
	
	SetVariable UL_Period,pos={10,150},size={180,20},title="UL Period(cm)",fSize=12
	SetVariable UL_Period,limits={-Inf,Inf,1},value= root:BasicVariables:UL_Period
	
	SetVariable UL_Number,pos={220,150},size={180,20},title="UL Number   ",fSize=12
	SetVariable UL_Number,limits={-Inf,Inf,1},value= root:BasicVariables:UL_Number
	
	SetVariable UL_Harmonics,pos={430,150},size={180,20},title="UL Harmonics",fSize=12
	SetVariable UL_Harmonics,limits={-Inf,Inf,1},value= root:BasicVariables:UL_Harmonics	
	
	
	Button CalKButton,pos={5,180},size={140,35},proc=CalculateK,title="Calculate K"
	
	ValDisplay val_ULK,pos={156,190},size={65,20},title="",fSize=12
	ValDisplay val_ULK,limits={0,0,0},barmisc={0,1000},value= #"root:BasicVariables:UL_K"		
	
//	PopupMenu popup_file,pos={14,44},size={123,19},proc=SelectFileSES,title="File"
//	PopupMenu popup_file,mode=14,popvalue="LRS_000000.pxt",value= #"root:SES:fileList\t\t"
	
//	Button FileUpdate,pos={180,45},size={50,25},proc=UpdateFolderSES,title="Update"


	
	
//	ValDisplay val_Nreg,pos={20,130},size={60,14},title="# region",fSize=10
//	ValDisplay val_Nreg,limits={0,0,0},barmisc={0,1000},value= #"root:SES:nregion"

//	Button PlotButton1,pos={13,233},size={55,20},proc=PlotSES,title="Display"
//	Button PlotButton2,pos={123,233},size={55,20},proc=PlotSES,title="Append"
	
//	Button LoadAllButton,pos={10,212},size={90,20},proc=LoadAll,title="LoadALLFiles"
//	Button LoadAllUPDATE,pos={10,232},size={90,20},proc=LoadAll,title="UPDATE"	
//	ValDisplay val_TotalNumOriginalFiles,pos={110,212},size={115,14},title="Total#ofFiles",fSize=10
//	ValDisplay val_TotalNumOriginalFiles,limits={0,0,0},barmisc={0,1000}
//	ValDisplay val_TotalNumOriginalFiles,value= #"root:SES:numfiles"

//        Button Data,pos={125,338},size={70,20},title="DA Alone",proc=DataAnalysisAlone
//        Button Alalysis,pos={125,370},size={70,20},title="Combined",proc=DataAnalysisCombined         
	
        Button EXIT,pos={550,400},size={60,50},title="EXIT", proc=EXITSRSimulation     
      

EndMacro





Proc CalculateSRGamma(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	Variable EMass=9.1*10^(-31)                              //Eelctron mass, in unit of Kg
	Variable LightV=3*10^(8)                                     //Light speed, in unit of Meter*Second^(-1)
	
	root:BasicVariables:SR_Gamma=root:BasicVariables:SR_Energy*1.602*10^(5)/9.1/9
	
	SetDataFolder Curr
End


Proc CalculateK(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
// K=eB_0Lambda_u/2pimc = 0.934Lambda_u[cm]*B_0[T]
	
	root:BasicVariables:SR_Gamma=root:BasicVariables:SR_Energy*1.602*10^(5)/9.1/9
	
	SetDataFolder Curr
End




Proc EXITSRSimulation(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
        DoWindow/K SR_Simulation_Window
	
	SetDataFolder Curr
	
End

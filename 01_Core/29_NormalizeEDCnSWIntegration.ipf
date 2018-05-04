#pragma rtGlobals=1		// Use modern global access method.

menu "NorEDC"
"Normalize EDC and Spectral Weight Integration",  NormalizeEDC_SWIntegration()
end


Proc NormalizeEDC_SWIntegration()

	DoWindow/F NormalizeEDC_and_SWIntegration
	if (V_Flag==0)
	
	 NewDataFolder/O/S root:NorEDC_SWInt
	 String/G FileList
	 String/G  NormalizeEDCy, NormalizeEDCx
	 Variable/G NorEF_Start=NumVarOrDefault("root:NorEDC_SWInt:NorEF_Start",0)
	  Variable/G NorEF_End=NumVarOrDefault("root:NorEDC_SWInt:NorEF_End",0)
	 Variable/G NorVB_Start=NumVarOrDefault("root:NorEDC_SWInt:NorVB_Start",0)
	  Variable/G NorVB_End=NumVarOrDefault("root:NorEDC_SWInt:NorVB_End",0)
	 
	 String/G SWEDCy, SWEDCx
	 Variable/G SW_Start=NumVarOrDefault("root:NorEDC_SWInt:SW_Start",0)
	 Variable/G SW_End=NumVarOrDefault("root:NorEDC_SWInt:SW_End",0)
	 
	 String/G   FigFolderName=StrVarOrDefault("root:NorEDC_SWInt:FigFolderName","")
	 
	 
	 Variable/G IntSW
	  
	NormalizeEDC_and_SWIntegration()

        Endif
        
END


Window NormalizeEDC_and_SWIntegration():Panel
	PauseUpdate; Silent 1     //Building window .......
	
	NewPanel/W=(100, 100, 600,580)
	
	SetDrawEnv linefgc= (0,39168,0),linethick= 3.00       //Normalize EDC frame
	DrawRRect 4,6,487,242
	
	SetDrawEnv linefgc= (0,15872,65280),fillpat= 0,linethick= 2.00
	DrawRRect 13,109,201,233	
	
	SetDrawEnv linefgc= (0,15872,65280),fillpat= 0,linethick= 2.00
	DrawRRect  293,109,478,233		
	
	
	SetDrawEnv linefgc= (0,39168,0),linethick= 3.00       //Spectral Weight Integration
	DrawRRect 4,249,487,440	
	
	
	
	
	
	SetDrawLayer UserBack
	SetDrawEnv textrgb= (52224,0,0),fsize= 18	
	DrawText 170, 30, "Normalize EDC"
	
	Button UpdateEDC pos={10, 45}, size={85,40}, proc=UpdateEDC, title="Update EDC"	

	PopupMenu popup_EDCy, pos={90,40}, size={150,20}, proc=SelectEDCy, title="EDCy to be Normalized"
	PopupMenu popup_EDCy, mode=14, popvalue="L0F2t20P9T18N56", value=#"root:NorEDC_SWInt:FileList\t\t"
	PopupMenu popup_EDCx, pos={90,70}, size={150,20}, proc=SelectEDCx, title="EDCx to be Normalized"
	PopupMenu popup_EDCx, mode=14, popvalue="EL0F2t20P9T18N56", value=#"root:NorEDC_SWInt:FileList\t\t"
	
	Button DisplayEDC pos={380, 45}, size={100,40}, proc=DisplayEDC, title="Display EDC"

	SetDrawLayer UserBack
	SetDrawEnv textrgb= (52224,0,0),fsize= 16	
	DrawText 40, 130, "Normalize Above Ef"	
	

	SetDrawLayer UserBack
	SetDrawEnv textrgb= (52224,0,0),fsize= 16	
	DrawText 320, 130, "Normalize Using VB"	
	
	SetVariable Set_EfStart, pos={20, 140}, size={170, 20}, title="Energy Start = Ef +", fsize=12
	SetVariable Set_EfStart, Limits={-inf,+inf, 0.1}, value=root:NorEDC_SWInt:NorEF_Start
	SetVariable Set_EfEnd,  pos={20, 160}, size={170, 20}, title="Energy  End = Ef +", fsize=12
	SetVariable Set_EfEnd, Limits={-inf,+inf, 0.1}, value=root:NorEDC_SWInt:NorEF_End	
	
	SetVariable Set_VBStart, pos={300, 140}, size={170, 20}, title="Energy Start = Ef +", fsize=12
	SetVariable Set_VBStart, Limits={-inf,+inf, 0.1}, value=root:NorEDC_SWInt:NorVB_Start
	SetVariable Set_VBEnd,  pos={300, 160}, size={170, 20}, title="Energy  End = Ef +", fsize=12
	SetVariable Set_VBEnd, Limits={-inf,+inf, 0.1}, value=root:NorEDC_SWInt:NorVB_End	
	
	Button NorAboveEf pos={25,190}, size={160,30}, proc=Nor_EDC_Above_EF, title="Normalize above Ef"
	
	Button NorUsingVB pos={305,190}, size={160,30}, proc=Nor_EDC_Using_VB, title="Normalize Using VB"
	
	
	SetDrawLayer UserBack
	SetDrawEnv textrgb= (52224,0,0),fsize= 18	
	DrawText 120, 280, "Spectral Weight Integration"
	
	PopupMenu popup_NorEDCy, pos={30,300}, size={150,20}, proc=SelectNorEDCy, title="EDCy to be Integrated"
	PopupMenu popup_NorEDCy, mode=14, popvalue="L0F2t20P9T18N56", value=#"root:NorEDC_SWInt:FileList\t\t"
	PopupMenu popup_NorEDCx, pos={30,330}, size={150,20}, proc=SelectNorEDCx, title="EDCx to be Integrated"
	PopupMenu popup_NorEDCx, mode=14, popvalue="EL0F2t20P9T18N56", value=#"root:NorEDC_SWInt:FileList\t\t"
		
	Button DisplayNorEDC pos={350, 305}, size={120,40}, proc=DisplayNorEDC, title="Display Nor EDC"
	
	SetVariable Set_IntStart, pos={20, 370}, size={240, 20}, title="Integration Energy Start = Ef +", fsize=12
	SetVariable Set_IntStart, Limits={-inf,+inf, 0.1}, value=root:NorEDC_SWInt:SW_Start
	SetVariable Set_IntEnd,  pos={20, 390}, size={240, 20}, title="Integration Energy  End = Ef +", fsize=12
	SetVariable Set_IntEnd, Limits={-inf,+inf, 0.1}, value=root:NorEDC_SWInt:SW_End	

	Button Integration pos={350,370}, size={120,40}, proc=SWIntegration, title="SW Integration"
	
	
	ValDisplay val_IntSW,pos={20,410},size={240,40},title="Integrated Spectral Weight =  ",fSize=12
	ValDisplay val_IntSW,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_IntSW, value= #"root:NorEDC_SWInt:IntSW"

	
//      SetVariable set_FigFolderName,proc=SetVarProc,pos={200,445},size={180,30},title="FigFolderName",fSize=12
       SetVariable set_FigFolderName,pos={10,452},size={210,60},title="FigFolder",fSize=12     
       SetVariable set_FigFolderName,limits={-inf,inf,1},value= root:NorEDC_SWInt:FigFolderName
       
       
 	Button EDCForFig pos={230, 445}, size={150,30}, proc=EDC_For_Figure, title="Create EDCs for Figure"	
	
        Button EXITNorEDC pos={405,445}, size={80, 30}, proc=ExitNorEDC, title="EXIT"
	

EndMacro



Proc UpdateEDC(ctrlName):ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	root:NorEDC_SWInt:FileList=Wavelist("*", ";", "DIMS:1")
	
        SetDataFolder Curr
END


Proc SelectEDCy(ctrlName,popNum,popStr):PopupMenuControl
	String ctrlName
	Variable popNUm
	String popStr
	
	UpdateEDC(ctrlName)
	
	root:NorEDC_SWInt:NormalizeEDCy=popStr
	
END


Proc SelectEDCx(ctrlName,popNum,popStr):PopupMenuControl
	String ctrlName
	Variable popNUm
	String popStr
	
	UpdateEDC(ctrlName)
	
	root:NorEDC_SWInt:NormalizeEDCx=popStr
	
END	


Proc DisplayEDC(ctrlName):ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	Display  $root:NorEDC_SWInt:NormalizeEDCy vs $root:NorEDC_SWInt:NormalizeEDCx
	
	ShowInfo
	
        SetDataFolder Curr
END


Proc Nor_EDC_Above_EF(ctrlName):ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

        String NorEf_EDCy="EF_"+root:NorEDC_SWInt:NormalizeEDCy
        String NorEf_EDCx="EF_"+root:NorEDC_SWInt:NormalizeEDCx
        
        Duplicate/O   $root:NorEDC_SWInt:NormalizeEDCy $NorEf_EDCy
        Duplicate/O   $root:NorEDC_SWInt:NormalizeEDCx $NorEf_EDCx       
       
	Display  $NorEf_EDCy vs $NorEf_EDCx
	
	$NorEf_EDCy/=areaXY($root:NorEDC_SWInt:NormalizeEDCx, $root:NorEDC_SWInt:NormalizeEDCy, root:NorEDC_SWInt:NorEF_Start, root:NorEDC_SWInt:NorEF_End)
	
	ShowInfo
	
         root:NorEDC_SWInt:FileList=Wavelist("*", ";", "DIMS:1")
	
	SetDataFolder Curr
END


Proc Nor_EDC_Using_VB(ctrlName):ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

        String NorVB_EDCy="VB_"+root:NorEDC_SWInt:NormalizeEDCy
        String NorVB_EDCx="VB_"+root:NorEDC_SWInt:NormalizeEDCx
        
        Duplicate/O   $root:NorEDC_SWInt:NormalizeEDCy $NorVB_EDCy
        Duplicate/O   $root:NorEDC_SWInt:NormalizeEDCx $NorVB_EDCx       
       
	Display  $NorVB_EDCy vs $NorVB_EDCx
	
	$NorVB_EDCy/=areaXY($root:NorEDC_SWInt:NormalizeEDCx, $root:NorEDC_SWInt:NormalizeEDCy, root:NorEDC_SWInt:NorVB_Start, root:NorEDC_SWInt:NorVB_End)
	
	ShowInfo
	
         root:NorEDC_SWInt:FileList=Wavelist("*", ";", "DIMS:1")
	
	SetDataFolder Curr
END


Proc SelectNorEDCy(ctrlName,popNum,popStr):PopupMenuControl
	String ctrlName
	Variable popNUm
	String popStr
	
	UpdateEDC(ctrlName)
	
	root:NorEDC_SWInt:SWEDCy=popStr
	
END


Proc SelectNorEDCx(ctrlName,popNum,popStr):PopupMenuControl
	String ctrlName
	Variable popNUm
	String popStr
	
	UpdateEDC(ctrlName)
	
	root:NorEDC_SWInt:SWEDCx=popStr
	
END


Proc DisplayNorEDC(ctrlName):ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	Display  $root:NorEDC_SWInt:SWEDCy vs $root:NorEDC_SWInt:SWEDCx
	
	ShowInfo
	
        SetDataFolder Curr
END


Proc SWIntegration(ctrlName):ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	Variable SW_Area
	
	Print root:NorEDC_SWInt:SWEDCx
	Print root:NorEDC_SWInt:SWEDCy
	Print root:NorEDC_SWInt:SW_Start
	Print root:NorEDC_SWInt:SW_End
	
        SW_Area=areaXY($root:NorEDC_SWInt:SWEDCx, $root:NorEDC_SWInt:SWEDCy, root:NorEDC_SWInt:SW_Start, root:NorEDC_SWInt:SW_End)
	
	Print "Integrated Area=", SW_Area
	
	root:NorEDC_SWInt:IntSW=SW_Area
	
        SetDataFolder Curr
END


Proc EDC_for_Figure(ctrlName):ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	String EDCFolderName=root:NorEDC_SWInt:FigFolderName
	NewDataFolder/O/S root:$EDCFolderName
	

	SetDataFolder Curr	
	
	
	String PlotEDCy=root:NorEDC_SWInt:SWEDCy+"_F"
	String PlotEDCx=root:NorEDC_SWInt:SWEDCx+"_F"
	
	Duplicate/O  $(root:NorEDC_SWInt:SWEDCy) $PlotEDCy
	Duplicate/O  $(root:NorEDC_SWInt:SWEDCx) $PlotEDCx			
	
        Duplicate/O  $(root:NorEDC_SWInt:SWEDCy)     root:$(root:NorEDC_SWInt:FigFolderName):$PlotEDCy
        Duplicate/O  $(root:NorEDC_SWInt:SWEDCx)     root:$(root:NorEDC_SWInt:FigFolderName):$PlotEDCx
	
	
        SetDataFolder Curr
END




Proc ExitNorEDC(ctrlName):ButtonControl
	string ctrlName
	string Curr=GetDataFolder(1)
	
	DoWindow/K NormalizeEDC_and_SWIntegration
	
	SetDataFolder Curr
End

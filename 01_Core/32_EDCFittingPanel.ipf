#pragma rtGlobals=1		// Use modern global access method.

Proc EDCFittingPanel( )
   
    String Curr=GetDataFolder(1)
    
	DoWindow/F EDC_Fitting_Panel
	if (V_flag==0)
		NewDataFolder/O/S root:EDCFittingPanel
		NewDataFolder/O/S root:EDCFittingPanel:EDCParameters
		

		
	    Variable/G  EDCFileDimensionFlag
	    
		Variable/G  ShowEDCMode=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:ShowEDCMode",100)	    
	    
	    Variable/G  EDC1DShowMode	    

	
		Variable/G  CropYStart=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:CropYStart",100)
		Variable/G  CropYEnd=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:CropYEnd",100)
		Variable/G  CropEnergyStart=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:CropEnergyStart",100)
		Variable/G  CropEnergyEnd=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:CropEnergyEnd",100)
		Variable/G  EDCStart=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCStart",100)
		Variable/G  EDCEnd=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCEnd",100)
		Variable/G  ErToler =NumVarOrDefault("root:EDCFittingPanel:EDCParameters:ErToler",100)		
		
		
		Variable/G  NumberofLorentzian=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:NumberofLorentzian",100)		
		Variable/G  EDCBackground=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCBackground",100)
		Variable/G  EDC2Background=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDC2Background",100)				
		Variable/G  EDCHeight=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCHeight",100)
		Variable/G  EDC2Height=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDC2Height",100)
		Variable/G  EDCPosition=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCPosition",100)
		Variable/G  EDC2Position=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDC2Position",100)
		Variable/G  EDCFWHM =NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCFWHM ",100)				
		Variable/G  EDC2FWHM =NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDC2FWHM ",100)
		Variable/G  EDCCurveStart =NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCCurveStart",100)		
		Variable/G  EDCCurveEnd =NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCCurveEnd",100)		
		Variable/G  EDCTemperature=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCTemperature",100)
		
		Variable/G  SBackground=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SBackground",100)
		Variable/G  SGap=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SGap",100)	
		Variable/G  SGm0=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SGm0",100)
		Variable/G  SGm1=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SGm1",100)		
		Variable/G  SPreFactor=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SPreFactor",100)	
		Variable/G  SEStartPoint=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SEStartPoint",100)	
    		Variable/G  SEEndPoint=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SEEndPoint",100)
    		Variable/G  SimuERange=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:SimuERange",100)

    		Variable/G  EDCFitFlag=NumVarOrDefault("root:EDCFittingPanel:EDCParameters:EDCFitFlag",100)

 	       String/G    EDC1DFileList_Intensity
 	       String/G    EDC1DFileList_Energy 	       
 	       String/G    EDC2DImageList
 	       
	       String/G    Temp1DEDCIntensity_Name 	       
	       String/G    Temp1DEDCEnergy_Name  	
	       String/G    EDC1DWindowName       

           Variable/G  WaveXStep1D
	       Variable/G  DataPoint, NXImage, NYImage
	       
	       
	    NewDataFolder/O/S root:EDCFittingPanel:EDC1DFiles
	    String/G    ToFit1DEDCList
	    Variable/G  Numof1DEDC
		NewDataFolder/O/S root:EDCFittingPanel:EDC2DFiles   


       EDC_Fitting_Panel( )
       Endif
       
       SetDataFolder Curr	
    
End

Window EDC_Fitting_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(0,101,576,438)
	ModifyPanel cbRGB=(48896,65280,48896)
	SetDrawLayer UserBack


	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 109,3,572,95                                  //Show 2D and 1D Data


	SetDrawEnv fillfgc= (0,65280,65280)
	DrawRRect 5,80,105,270                                  //Process 2-Dimensional Data
	
    SetDrawEnv fillfgc= (16384,65280,65280)
	DrawRRect 110,100,290,334                               //Fit Original EDC Lorentzian initialization
	

	SetDrawEnv fillfgc= (16384,65280,65280)
	DrawRRect 295,100,420,334                               //Fit Original EDC Gap Function initialization
	

	SetDrawEnv fillfgc= (16384,65280,65280)
	DrawRRect 430,100,570,334                               //Fit Symmetrized EDC Gap Function initialization
	
	
	
//	PopupMenu SetEDCFolder,pos={3,1},size={20,20},font="Times New Roman", proc=SelectFolderEDCFitting,title="SetEDCDataFolder"
//	PopupMenu SetEDCFolder,mode=0, value= #"root:SES:folderList"
	
//    SetVariable setlib,pos={140,3},size={325,20},font="Times New Roman",title=" ",fSize=10
//	SetVariable setlib,limits={-Inf,Inf,1},value= root:SES:filpath
	

    PopupMenu popup_FileDimension,pos={4,2},size={100,25},font="Times New Roman",proc=EDCFileDimensionSelection,title="FileDimen"
	PopupMenu popup_FileDimension,mode=1,popvalue="1D",value= #"\"1D;2D\""
	
	
	SetVariable set_EDCOverallMode,proc=SetVarProc,pos={4,25},size={100,45},font="Times New Roman",title="EDCFitMode",fSize=10
	SetVariable set_EDCOverallMode,limits={0,2,1},value=root:EDCFittingPanel:EDCParameters:ShowEDCMode
	
	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 10
	DrawText 4,50,"0-Ori_Lorentzian" 
	
	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 10
	DrawText 4,60,"1-Ori_GapF" 	
	
	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 10
	DrawText 4,70,"2-Symm_GapF" 		
	
	
	
	
	
	
	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 14
	DrawText 140,20,"Show2DImage" 
	
////    SetDrawLayer UserBack
////	SetDrawEnv fname= "Times New Roman"
////	SetDrawEnv fsize= 14
////	DrawText 280,20,"ShowSingleEDC" 
	
	
    SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 14
	DrawText 450,20,"ShowMultipleEDCs"
	
	
	
	

    PopupMenu Show2DEDCImage,pos={112,22},size={100,35}, font="Times New Roman",proc=Show2DEDCImage,title=""
    PopupMenu Show2DEDCImage,mode=6,popvalue="F5t17O90PP27T15P",value= #"root:EDCFittingPanel:EDCParameters:EDC2DImageList\t\t"
    
    
    SetVariable set_OEDCTemperature,pos={115,50},size={120,25},font="Times New Roman",title="Temperature (K)",fSize=10
    SetVariable set_OEDCtemperature,limits={0,inf,1},value=root:EDCFittingPanel:EDCParameters:EDCTemperature     
    
    
       
    PopupMenu popup_EDC1DMode,pos={252,3},size={45,38},font="Times New Roman",proc=EDCModeSelection,title="ShowSingleEDCMode"
	PopupMenu popup_EDC1DMode,mode=1,popvalue="????",value= #"\"X Y;Y Only\""       
    
    
    PopupMenu Select1DEDCInt,pos={254,22},size={220,35}, font="Times New Roman",proc=Select1DEDCIntensity,title="IntY"
    PopupMenu Select1DEDCInt,mode=6,popvalue="ZF5t24O90PP27T20P100",value= #"root:EDCFittingPanel:EDCParameters:EDC1DFileList_Intensity\t\t"     
    
    
    PopupMenu Select1DEDCEnergy,pos={254,42},size={220,35}, font="Times New Roman",proc=Select1DEDCEnergy,title="E_X"
    PopupMenu Select1DEDCEnergy,mode=6,popvalue="EZF5t24O90PP27T20P12",value= #"root:EDCFittingPanel:EDCParameters:EDC1DFileList_Energy\t\t" 
           
    
    	Button Plot1DEDC,pos={284,68},size={114,20},title="Plot_1D_EDC",font="Times New Roman",proc=PLOT1DEDC
    	
    	
    	
    	
    	Button SymmEDCFitInit,pos={450,28},size={114,16},title="MultiEDCTable",font="Times New Roman",proc=MultiEDCFitTable
    
    SetVariable set_EDCFitFlag,proc=SetVarProc,pos={470,48},size={86,25},font="Times New Roman",title="EDCFitFlag",fSize=10	
	SetVariable set_EDCFitFlag,limits={-10,10,1},value= root:EDCFittingPanel:EDCParameters:EDCFitFlag	
	
    Button PlotMultiEDCs,pos={450,68},size={114,20},title="PlotMultiEDCs",font="Times New Roman",proc=PlotMultiEDCs
	
    	
    	
    	
    	
    	
    	
    
    
    
////	SetDrawLayer UserBack
////	SetDrawEnv fname= "Times New Roman"
////	SetDrawEnv fsize= 12
////	DrawText 20,81,"Crop Image"
	
	
	SetVariable set_CropYStart,proc=SetVarProc,pos={10,85},size={85,25},font="Times New Roman",title="Y  Start",fSize=10
	SetVariable set_CropYStart,limits={-25,25,0.1},value=root:EDCFittingPanel:EDCParameters:CropYStart
	SetVariable set_CropYEnd,proc=SetVarProc,pos={25,103},size={70,25},font="Times New Roman",title="End",fSize=10
	SetVariable set_CropYEnd,limits={0,25,0.1},value=root:EDCFittingPanel:EDCParameters:CropYEnd
	SetVariable set_CropEnergyStart,proc=SetVarProc,pos={10,128},size={85,25},font="Times New Roman",title="E Start",fSize=10
	SetVariable set_CropEnergyStart,limits={-inf,inf,0.1},value=root:EDCFittingPanel:EDCParameters:CropEnergyStart
	SetVariable set_CropEnergyEnd,pos={25,146},size={70,25},title="End",font="Times New Roman",fSize=10
	SetVariable set_CropEnergyEnd,limits={-inf,inf,0.1},value=root:EDCFittingPanel:EDCParameters:CropEnergyEnd
	SetVariable set_EDCStart,proc=SetVarProc,pos={10,171},size={85,25},title="EDCStart",font="Times New Roman",fSize=10
	SetVariable set_EDCStart,limits={-inf,inf,0.1},value=root:EDCFittingPanel:EDCParameters:EDCStart
	SetVariable set_EDCEnd,proc=SetVarProc,pos={25,189},size={70,25},font="Times New Roman",title="End",fSize=10
	SetVariable set_EDCEnd,limits={-inf,inf,0.1},value=root:EDCFittingPanel:EDCParameters:EDCEnd
////	SetVariable set_ShowEDCMode,proc=SetVarProc,pos={10,159},size={87,25},title="ShowEDCMode",fSize=10
////SetVariable set_ShowEDCMode,limits={0,1,1}, value= root:EDCFittingPanel:EDCParameters:ShowEDCMode
    
////   	SetDrawLayer UserBack
//// 	SetDrawEnv fname= "Times New Roman"
//// 	SetDrawEnv fsize= 10
//// 	DrawText 10,185,"0-Origin  1-Symmetr" 
    
 	SetVariable set_ErTolerence,pos={8,215},size={95,25},font="Times New Roman",title="EStep_meV",fSize=10
	SetVariable set_ErTolerence,limits={0.1,2,0.05},value= root:EDCFittingPanel:EDCParameters:ErToler       

    Button ProcessFermiButton pos={8,235},size={94,30},font="Times New Roman",proc=ProcessEDCFile,title="EDCs from 2DImg",fsize=10


	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 12
	DrawText 134,115,"0.OriginalEDC_Lorentzian"
	
//	   PopupMenu popup_OEDCNumberofLorentzian,pos={120,70},size={100,20},font="Times New Roman",proc=NumberofLorentzianSelection_EDC,title="#ofEDCLorentzians?",fSize=10
//	   PopupMenu popup_OEDCNumberofLorentzian,mode=1,font="Times New Roman", popvalue="?",value= #"\"1;2\""

      SetVariable set_OEDCNumberofLorentzian,pos={115,130},size={168,20},font="Times New Roman",title="Number of Lorentzian ?",fSize=10
      SetVariable set_OEDCNumberofLorentzian,limits={1,2,1},value= root:EDCFittingPanel:EDCParameters:NumberofLorentzian


      SetVariable set_OEDCBackground,pos={115,146},size={80,25},font="Times New Roman",title="BKGD",fSize=10
      SetVariable set_OEDCBackground,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDCBackground
      
      SetVariable set_OEDCBackground1,pos={200,146},size={82,25},font="Times New Roman",title="BKGD2",fSize=10
      SetVariable set_OEDCBackground1,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDC2Background 
      
      
          
      SetVariable set_OEDCHeight,pos={115,166},size={80,25},font="Times New Roman",title="Height",fSize=10
      SetVariable set_OEDCHeight,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDCHeight
      
      SetVariable set_OEDCHeight1,pos={200,166},size={82,25},font="Times New Roman",title="Height2",fSize=10
      SetVariable set_OEDCHeight1,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDC2Height      
      
      SetVariable set_OEDCPosition,pos={115,186},size={80,25},font="Times New Roman",title="Position",fSize=10
      SetVariable set_OEDCPosition,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDCPosition 
      SetVariable set_OEDCPosition1,pos={200,186},size={82,25},font="Times New Roman",title="Position2",fSize=10
      SetVariable set_OEDCPosition1,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDC2Position         
           
      SetVariable set_OEDCFWHM,pos={115,206},size={80,25},font="Times New Roman",title="FWHM",fSize=10
      SetVariable set_OEDCFWHM,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDCFWHM    
      SetVariable set_OEDCFWHM1,pos={200,206},size={82,25},font="Times New Roman",title="FWHM2",fSize=10
      SetVariable set_OEDCFWHM1,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:EDC2FWHM

      SetVariable set_OEDCStartingCurve,pos={115,230},size={80,25},font="Times New Roman",title="EDCStart",fSize=10
      SetVariable set_OEDCStartingCurve,limits={0,inf,1},value= root:EDCFittingPanel:EDCParameters:EDCCurveStart    
      SetVariable set_OEDCEndingCurve,pos={200,230},size={82,25},font="Times New Roman",title="End",fSize=10
      SetVariable set_OEDCEndingCurve,limits={0,inf,1},value= root:EDCFittingPanel:EDCParameters:EDCCurveEnd
      
	  Button OriLorSimulate,pos={158,276},size={80,25},title="SIMULATE",font="Times New Roman",proc=EDCSimulate
	  Button OriLorFit,pos={158,305},size={80,25},title="SymmEDCFIT",font="Times New Roman",proc=EDCFunctionFit      

      
	
	
////	SetDrawLayer UserBack
////	SetDrawEnv fname= "Times New Roman"
////	SetDrawEnv fsize= 12
////	DrawText 302,81,"SymmEDC Fit Init"
	
	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 12
	DrawText 305,115,"1.OriginalEDC_GapF"	
	

	
	SetVariable set_OriSBackground,proc=SetVarProc,pos={308,130},size={110,25},font="Times New Roman",title="SBackground",fSize=10	
	SetVariable set_OriSBackground,limits={-inf,inf,10},value= root:EDCFittingPanel:EDCParameters:SBackground
	SetVariable set_OriSGap,proc=SetVarProc,pos={308,148},size={110,25},font="Times New Roman",title="PeakPosition",fSize=10
	SetVariable set_OriSGap,limits={-inf,inf,10},value= root:EDCFittingPanel:EDCParameters:SGap
	SetVariable set_OriSGm0,proc=SetVarProc,pos={308,166},size={110,25},font="Times New Roman",title="Gm0 ",fSize=10
	SetVariable set_OriSGm0,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SGm0
	SetVariable set_OriSGm1,proc=SetVarProc,pos={308,184},size={110,25},font="Times New Roman",title="Gm1",fSize=10
	SetVariable set_OriSGm1,limits={-inf,inf,1},value=root:EDCFittingPanel:EDCParameters:SGm1
	SetVariable set_OriSPrefactor,proc=SetVarProc,pos={308,202},size={110,25},font="Times New Roman",title="Prefactor",fSize=10
	SetVariable set_OriSPrefactor,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SPrefactor
	SetVariable set_OriSEStartPoint,proc=SetVarProc,pos={308,220},size={110,25},font="Times New Roman",title="EStart",fSize=10
	SetVariable set_OriSEStartPoint,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SEStartPoint
	SetVariable set_OriSEEndPoint,proc=SetVarProc,pos={308,238},size={110,25},font="Times New Roman",title="EEnd",fSize=10
	SetVariable set_OriSEEndPoint,limits={0,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SEEndPoint
	
    SetVariable set_OriSimuERange,proc=SetVarProc,pos={308,256},size={110,25},font="Times New Roman",title="SimuERange",fSize=10
	SetVariable set_OriSimuerange,limits={0,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SimuERange
	
		
	Button OriSimulate,pos={318,276},size={80,25},title="SIMULATE",font="Times New Roman",proc=EDCSimulate
	Button OriFit,pos={318,305},size={80,25},title="SymmEDCFIT",font="Times New Roman",proc=EDCFunctionFit
	

	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv fsize= 12
	DrawText 435,115,"2.SymmetrizedEDC_GapF"	
	

	
	SetVariable set_SymSBackground,proc=SetVarProc,pos={445,130},size={110,25},font="Times New Roman",title="SBackground",fSize=10	
	SetVariable set_SymSBackground,limits={-inf,inf,10},value= root:EDCFittingPanel:EDCParameters:SBackground
	SetVariable set_SymSGap,proc=SetVarProc,pos={445,148},size={110,25},font="Times New Roman",title="PeakPosition",fSize=10
	SetVariable set_SymSGap,limits={-inf,inf,10},value= root:EDCFittingPanel:EDCParameters:SGap
	SetVariable set_SymSGm0,proc=SetVarProc,pos={445,166},size={110,25},font="Times New Roman",title="Gm0 ",fSize=10
	SetVariable set_SymSGm0,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SGm0
	SetVariable set_SymSGm1,proc=SetVarProc,pos={445,184},size={110,25},font="Times New Roman",title="Gm1",fSize=10
	SetVariable set_SymSGm1,limits={-inf,inf,1},value=root:EDCFittingPanel:EDCParameters:SGm1
	SetVariable set_SymSPrefactor,proc=SetVarProc,pos={445,202},size={110,25},font="Times New Roman",title="Prefactor",fSize=10
	SetVariable set_SymSPrefactor,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SPrefactor
	SetVariable set_SymSEStartPoint,proc=SetVarProc,pos={445,220},size={110,25},font="Times New Roman",title="EStart",fSize=10
	SetVariable set_SymSEStartPoint,limits={-inf,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SEStartPoint
	SetVariable set_SymSEEndPoint,proc=SetVarProc,pos={445,238},size={110,25},font="Times New Roman",title="EEnd",fSize=10
	SetVariable set_SymSEEndPoint,limits={0,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SEEndPoint
	
    SetVariable set_SymSimuERange,proc=SetVarProc,pos={445,256},size={110,25},font="Times New Roman",title="SimuERange",fSize=10
	SetVariable set_SymSimuerange,limits={0,inf,0.1},value= root:EDCFittingPanel:EDCParameters:SimuERange
	
		
	Button SymSimulate,pos={465,276},size={80,25},title="SIMULATE",font="Times New Roman",proc=EDCSimulate
	Button SymFit,pos={465,305},size={80,25},title="SymmEDCFIT",font="Times New Roman",proc=EDCFunctionFit



	
	Button Clean,pos={10,275},size={80,25},title="CLEAN",font="Times New Roman",proc=XJZEDCClean
	Button Exit,pos={10,305},size={80,25},title="EXIT",font="Times New Roman",proc=XJZEDCDoneBotton
	
	
	EndMacro
	
	
	
//Proc SelectFolderEDCFitting(ctrlName,popNum,popStr) : PopupMenuControl
//-------------------
	String ctrlName
	Variable popNum
	String popStr
	
	SetDataFolder root:SES:
	if (popNum==2)						//print "Summarize Folder"
		SummarizeSESfolder(filpath)
	else
		if (popNum==1)						//print "Select Folder"
			NewPath/O/Q/M="Select SES Data Library" SESdata				//dialog selection
			string/G filpath
			Pathinfo SESdata
			filpath=S_path
			folderList=folderList+filpath+";"
		endif
		if (popNum>3)							//print "Select Existing Folder"
			filpath=StringFromList(popNum-1,folderList)
			//print popNum, filpath
			NewPath/O/Q SESdata filpath
		endif
		fileList=IndexedFile( SESdata, -1, ".pxt")	
		//filelist=ReduceList( fullfilelist, "*.pxt" )
		numfiles=ItemsInList( fileList, ";")
	endif
	SetDataFolder root:
End	
	
	
Proc EDCFileDimensionSelection(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String Curr=GetDataFolder(1)
	
         root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag=popNum
         
         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Intensity=WaveList("*F*t*P*",";","DIMS:1")	
         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Energy=WaveList("*F*t*P*",";","DIMS:1")	         
                  
         root:EDCFittingPanel:EDCParameters:EDC2DImageList=WaveList("*F*t*P*",";","DIMS:2")	         
         
         
	SetDataFolder Curr
End



Proc Show2DEDCImage(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	

         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Intensity=WaveList("*F*t*P*",";","DIMS:1")	
         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Energy=WaveList("*F*t*P*",";","DIMS:1")         
         root:EDCFittingPanel:EDCParameters:EDC2DImageList=WaveList("*F*t*P*",";","DIMS:2")	  


	
        String EDCImageName="EDC"+popStr
        

	   String Curr=GetDataFolder(1)

                		 DoWindow $EDCImageName
	     	   		  if(V_flag==0)

                         Display; AppendImage $popStr

                		    DoWindow/C $EDCImageName
	     			    ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
	     	   		 Else
	     	   		 DoWindow/F EDCImageName
	     	   		 Endif


	SetDataFolder Curr
End




Proc Select1DEDCIntensity(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	

         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Intensity=WaveList("*F*t*P*",";","DIMS:1")	         
         root:EDCFittingPanel:EDCParameters:EDC2DImageList=WaveList("*",";","DIMS:2")	  

         root:EDCFittingPanel:EDCParameters:Temp1DEDCIntensity_Name=popStr
         
         root:EDCFittingPanel:EDCParameters:EDC1DWindowName=popStr       
         
    
End


Proc Select1DEDCEnergy(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	

         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Energy=WaveList("*F*t*P*",";","DIMS:1")	         
         root:EDCFittingPanel:EDCParameters:EDC2DImageList=WaveList("*",";","DIMS:2")	  

         root:EDCFittingPanel:EDCParameters:Temp1DEDCEnergy_Name=popStr
    
End


Proc EDCModeSelection(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String Curr=GetDataFolder(1)
	
         root:EDCFittingPanel:EDCParameters:EDC1DShowMode=popNum
         
   
         IF (popNum==1)        
         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Energy=WaveList("*",";","DIMS:1")	          
         EndIF         
         
         IF (popNum==2)
         root:EDCFittingPanel:EDCParameters:EDC1DFileList_Energy=""          
         EndIF
         
         
	SetDataFolder Curr
End




Function Plot1DEDC(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
    
    SVar EDC1DName=root:EDCFittingPanel:EDCParameters:EDC1DWindowName
   	String EDC1DWindowName="EDC1D_"+EDC1DName
    	SVar Temp1DIntensity=root:EDCFittingPanel:EDCParameters:Temp1DEDCIntensity_Name
    	SVar Temp1dEnergy=root:EDCFittingPanel:EDCParameters:Temp1DEDCEnergy_Name
    	NVar EDC1DShowMode=root:EDCFittingPanel:EDCParameters:EDC1DShowMode


////Print EDC1DShowMode
    
    DoWindow $EDC1DWindowName 
    
    
    IF (V_Flag==0)  
    
    
    			If (EDC1DShowMode==1)
            Display $Temp1DIntensity vs $Temp1DEnergy
            Else
            Display $Temp1DIntensity
            Endif
    
            ModifyGraph mode=3,marker=8,msize=2, rgb=(0,12800,52224)
    
    
    DoWindow/C  $EDC1DWindowName
    
    Else
    
    DoWindow/F  $EDC1DWindowName      

    EndIF

   ShowInfo

   SetDataFolder Curr
	
End





Proc EDCSimulate(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

String SEDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_EDConFS"

SetDataFolder root:EDCFittingPanel:EDCParameters

Make/O/N=400   AASimulatedEDC
Make/O/C/N=400 TSelfEnergy

Variable GapSize= root:EDCFittingPanel:EDCParameters:SGap      //When the gap is zero, the A(k,w) is a perfect Lorentian.
Variable Gamm0=root:EDCFittingPanel:EDCParameters:SGm0         //For Overdoped it is zero, for underdoped but in superconducting state it is also zero.
Variable Gamma1=root:EDCFittingPanel:EDCParameters:SGm1
Variable BKGD= root:EDCFittingPanel:EDCParameters:SBackground
Variable PreFactor= root:EDCFittingPanel:EDCParameters:SPrefactor
Variable ERange=root:EDCFittingPanel:EDCParameters:SimuERange


Setscale/I x, -ERange, ERange, AASimulatedEDC
Setscale/I x, -ERange, ERange, TSelfEnergy

TSelfEnergy=cmplx(Real((GapSize)^2/cmplx(x+0.000001,Gamm0)),-Gamma1+Imag((GapSize)^2/cmplx(x+0.000001,Gamm0)))


AASimulatedEDC=PreFactor*abs(Imag(TSelfEnergy))/((x-Real(TSelfEnergy))^2+Imag(TSelfEnergy)^2)+BKGD



RemovefromGraph/Z AASimulatedEDC

AppendtoGraph AASimulatedEDC
ModifyGraph rgb(AASimulatedEDC)=(65280,0,0)


SetDataFolder Curr
End






Proc  ProcessEDCFile(ctrlName) : ButtonControl
	 String ctrlName

        String curr=GetDataFolder(1)
        String OriginalFermiImage=root:FermiLevelFromAu:TempFermiName
        String ProcessedFermiImage="Pro_"+root:FermiLevelFromAu:TempFermiName

        DoWindow/K Au2D_OriginalFermiImage
        DoWindow Processed_Fermi_Image
        If (V_Flag==0)	        
 
        SetDataFolder root:FermiLevelFromAu
	
//     Crop Image
 
      Duplicate/O/R=(FermiEnergyStart,FermiEnergyEnd)(FermiAngleStart,FermiAngleEnd) $OriginalFermiImage, $ProcessedFermiImage

//    Normalize Y
                 XJZImginfo($ProcessedFermiImage)
		make/o/n=(ny) ytmp
		SetScale/P x ymin, yinc, "" ytmp
		ytmp = XJZAREA2D( $ProcessedFermiImage, FermiNorYStart, FermiNorYEnd, x )
		$ProcessedFermiImage /= ytmp[q]
		
	         Display; AppendImage $ProcessedFermiImage
	         ModifyImage $ProcessedFermiImage ctab= {*,*,PlanetEarth,1}
	         

         DoWindow/C Processed_Fermi_Image	 
	         
	 Else
         DoWindow/F Processed_Fermi_Image	 
	 Endif  
	 
	 ShowEDCImageSpectra()      

       SetDataFolder Curr

End


Proc EDCFunctionFit(ctrlName): ButtonControl
	String ctrlName
       String Curr=GetDataFolder(1)

      IF (root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag==2)
      
     				If(root:EDCFittingPanel:EDCParameters:ShowEDCMode==0)
     				Duplicate/O/R=(root:FermiLevelFromAu:FitEnergyStart,root:FermiLevelFromAu:FitEnergyEnd)(FermiAngleStart,FermiAngleEnd) $ProcessedFermiImage, ImageForFermiLevel 
	 				EDCImageSpectraForFitting()  
    	 				XJ2D_Original_EDCFunctionFit()
     				ShowFittedEDCInfo()
////     				Print "DimFalg=", root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag
////     				Print "ShowEDCMode=", root:EDCFittingPanel:EDCParameters:ShowEDCMode
     				Endif  
     				
       				If(root:EDCFittingPanel:EDCParameters:ShowEDCMode==0)
     				Duplicate/O/R=(root:FermiLevelFromAu:FitEnergyStart,root:FermiLevelFromAu:FitEnergyEnd)(FermiAngleStart,FermiAngleEnd) $ProcessedFermiImage, ImageForFermiLevel 
	 				EDCImageSpectraForFitting()  
    	 				XJ2D_Symm_EDCFunctionFit()
     				ShowFittedEDCInfo()
////     				Print "DimFalg=", root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag
////     				Print "ShowEDCMode=", root:EDCFittingPanel:EDCParameters:ShowEDCMode
     				
     				Endif  
     				       
      ENDIF

    					
      IF (root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag==1)    					
    					If (root:EDCFittingPanel:EDCParameters:ShowEDCMode==0)
    								if (root:EDCFittingPanel:EDCParameters:EDC1DShowMode==1)
    								XJ1DOriginal_XY_EDCFunctionFit()
////    								Print "DimFalg=", root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag
////     				             Print "ShowEDCMode=", root:EDCFittingPanel:EDCParameters:ShowEDCMode  
////     				             Print "EDC1DDataMode=", root:EDCFittingPanel:EDCParameters:EDC1DShowMode 
    								
    	    				             endif
    					
    					            if (root:EDCFittingPanel:EDCParameters:EDC1DShowMode==2)
    								XJ1DOriginal_YOnly_EDCFunctionFit()
////    								Print "DimFalg=", root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag
////     				             Print "ShowEDCMode=", root:EDCFittingPanel:EDCParameters:ShowEDCMode  
////     				             Print "EDC1DDataMode=", root:EDCFittingPanel:EDCParameters:EDC1DShowMode 
    								
    	    				            endif   
    	    				            
    	    				
    	    				                            
                     Endif 
                     
                     
                    
                    If (root:EDCFittingPanel:EDCParameters:ShowEDCMode==1)
    								if (root:EDCFittingPanel:EDCParameters:EDC1DShowMode==1)
    								XJ1D_Symm_XY_EDCFunctionFit()
////    								Print "DimFalg=", root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag
////     				             Print "ShowEDCMode=", root:EDCFittingPanel:EDCParameters:ShowEDCMode  
////     				             Print "EDC1DDataMode=", root:EDCFittingPanel:EDCParameters:EDC1DShowMode 
    								
    	    				             endif
 
 
    					            if (root:EDCFittingPanel:EDCParameters:EDC1DShowMode==2)
////    								XJ1D_Symm_YOnly_OneEDCFit()
    								
    								XJ1D_Symm_YOnly_MultiEDCFit( )
////    								Print "DimFalg=", root:EDCFittingPanel:EDCParameters:EDCFileDimensionFlag
////     				             Print "ShowEDCMode=", root:EDCFittingPanel:EDCParameters:ShowEDCMode  
////     				             Print "EDC1DDataMode=", root:EDCFittingPanel:EDCParameters:EDC1DShowMode 
    							    endif   
    							                    
                     Endif  
    	  
     	  
     ENDIF    
     
       
     SetDataFolder Curr

End




Proc XJ1D_Symm_YOnly_OneEDCFit( )
String ctrlName
String Curr=GetDataFolder(1)

   
//Kill Fitted Curves in root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
////	    String KilledFittedList=WaveList("fit_*F*C",";","DIMS:1")
////       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
////       	String FittedCurve
////	      Variable iFit=0
////	      Do
////	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
////	      Print "FittedCurve=", FittedCurve
//	      RemoveFromGraph/Z $FittedCurve
////	      KillWaves/Z  $FittedCurve
////	      iFit+=1
////	      While(iFit<NoofKilledFittedList) 
	      
	    //abort  
   
 	String ToFitEDC_Name
	Variable w0,w1,w2,w3,w4
       
       Variable EDCBackground=root:EDCFittingPanel:EDCParameters:SBackground
       Variable EDCGapSize=root:EDCFittingPanel:EDCParameters:SGap
       Variable EDCGamma0=root:EDCFittingPanel:EDCParameters:SGm0
       Variable EDCGamma1=root:EDCFittingPanel:EDCParameters:SGm1
       Variable EDCPreFactor=root:EDCFittingPanel:EDCParameters:SPrefactor
       
      
       w0=EDCBackground
       w1=EDCGapSize
       w2=EDCGamma0
       w3=EDCGamma1
       w4=EDCPreFactor
       
       
       		
	Make/O SymEDCFitcoeff={w0, w1, w2,w3,w4}
	Redimension/D  SymEDCFitcoeff 
    Variable EDCFit_Start=root:EDCFittingPanel:EDCParameters:SEStartPoint
    Variable EDCFit_End=root:EDCFittingPanel:EDCParameters:SEEndPoint
        
	
		
		ToFitEDC_Name=root:EDCFittingPanel:EDCParameters:Temp1DEDCIntensity_Name
		
     	FuncFit XJZSymmEDCFit SymEDCFitCoeff $ToFitEDC_Name[EDCFit_Start,EDCFit_End] /D
////		FuncFit XJZSymmEDCFit SymEDCFitCoeff ZF5t17O90PP27T15P170[EDCFit_Start,EDCFit_End] /D		


SetDataFolder Curr

End


Proc MultiEDCFitTable(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

String   TemEDC1DFileList=WaveList("*F*t*O*P*",";","DIMS:1")
Variable TemNumof1DEDC=	ItemsinList(TemEDC1DFileList,";") 

////Print TemEDC1DFileList

////root:EDCFittingPanel:EDC1DFiles:ToFit1DEDCList=TemEDC1DFileList

////root:EDCFittingPanel:EDC1DFiles:Numof1DEDC=TemNumof1DEDC

////SetDataFolder root:EDCFittingPanel:EDC1DFiles


XJZCleanFittedEDC() 

Make/O/N=(TemNumof1DEDC) EDCFitFlag,FitEStart, FitEEnd, FitBKGD, FitPeakPos, FitGamma0, FitGamma1, FitPreFactor,Momentum
Make/O/T/N=(TemNumof1DEDC) EDC1DName, NoteEDC
EDC1DName=""

String TableWinName
Variable PositionofComma=Strsearch(Curr,"t:",0)
Variable LengthofFolder=StrLen(Curr)
String FolderName=Curr[5,LengthofFolder-2]

////Print "Foldername=", FolderName

Variable PositionofComma2=StrSearch(FolderName,":",0)
Variable LengthofFolder2=StrLen(FolderName)
String FolderName2
IF (PositionofComma2==-1)
FolderName2=FolderName
Else
Foldername2=FolderName[PositionofComma2+1,LengthofFolder2-1]
EndIF

////Print "FolderName2=", FolderName2

Variable PositionofComma3=StrSearch(FolderName2,":",0)
Variable LengthofFolder3=StrLen(FolderName2)
String FolderName3
IF (PositionofComma3==-1)
FolderName3=FolderName2
Else
FolderName3=FolderName2[0,PositionofComma3-1]+"_"+FolderName2[PositionofComma3+1,LengthofFolder3-1]
EndIF

TableWinName=FolderName3
////Print "TableWinName=", TableWinName


String TableWindowName="EDC1D_"+TableWinName
////Print TableWindowname
DoWindow $TableWindowName



If (V_Flag==0)

Edit EDC1DName, EDCFitFlag,FitEStart, FitEEnd,FitBKGD,FitPeakPos, FitGamma0, FitGamma1, FitPreFactor,Momentum, NoteEDC  as TableWindowName

Variable iEDC=0
Do
EDC1DName[iEDC]=StringFromList(iEDC,TemEDC1DFileList,";")

iEDC+=1
While(iEDC<TemNumof1DEDC)

DoWindow/C $TableWindowName
Else
DoWindow/F $TableWindowName

Variable iEDC=0
Do
EDC1DName[iEDC]=StringFromList(iEDC,TemEDC1DFileList,";")

iEDC+=1
While(iEDC<TemNumof1DEDC)


Endif


SetDataFolder Curr

End






Proc XJ1D_Symm_YOnly_MultiEDCFit( )
String ctrlName
String Curr=GetDataFolder(1)

////String SEDCWindowName="F"+num2str(root:SchematicFermiSurface:EDCShowFlag)+"_EDConFS"

////    SetDataFolder root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
   
////    DoWindow/F $SEDCWindowName
   
//////Kill Fitted Curves in root:SchematicFermiSurface:EDConFS:SymmetrizedEDC
////	    String KilledFittedList=WaveList("fit_*F*C",";","DIMS:1")
////       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
////       	String FittedCurve
////	      Variable iFit=0
////	      Do
////	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
////	      Print "FittedCurve=", FittedCurve
//////	      RemoveFromGraph/Z $FittedCurve
////	      KillWaves/Z  $FittedCurve
////	      iFit+=1
////	      While(iFit<NoofKilledFittedList) 
	      
	    //abort  
	    
String EDCWinName
Variable PositionofComma=Strsearch(Curr,"t:",0)
Variable LengthofFolder=StrLen(Curr)
String FolderName=Curr[5,LengthofFolder-2]

////Print "Foldername=", FolderName

Variable PositionofComma2=StrSearch(FolderName,":",0)
Variable LengthofFolder2=StrLen(FolderName)
String FolderName2
IF (PositionofComma2==-1)
FolderName2=FolderName
Else
Foldername2=FolderName[PositionofComma2+1,LengthofFolder2-1]
EndIF

////Print "FolderName2=", FolderName2

Variable PositionofComma3=StrSearch(FolderName2,":",0)
Variable LengthofFolder3=StrLen(FolderName2)
String FolderName3
IF (PositionofComma3==-1)
FolderName3=FolderName2
Else
FolderName3=FolderName2[0,PositionofComma3-1]+"_"+FolderName2[PositionofComma3+1,LengthofFolder3-1]
EndIF

EDCWinName=FolderName3
Print "EDCWinName=", EDCWinName


String EDCWindowName="EDC_"+EDCWinName
////Print TableWindowname
DoWindow $EDCWindowName  

If (V_Flag==0)

Display as  EDCWindowName 
DoWindow/C $EDCWindowName  
Else
DoWindow/F $EDCWindowName  
EndIf 
	    
	    
   
    Variable SN, EN, lim
    Variable i,j 
	String ToFitEDCList, ToFitEDC_Name
	Variable w0,w1,w2,w3,w4
	ToFitEDCList=WaveList("*F*t*O*P*",";","DIMS:1")
	Variable NoofEDCCurves=ItemsinList(ToFitEDCList,";")
	
       SN=0
//     EN=NoofEDCCurves-1
//     EN=root:SchematicFermiSurface:NoFSPoints_Overall
       EN=NoofEDCCurves    
       
       Variable EDCBackground=root:EDCFittingPanel:EDCParameters:SBackground
       Variable EDCGapSize=root:EDCFittingPanel:EDCParameters:SGap
       Variable EDCGamma0=root:EDCFittingPanel:EDCParameters:SGm0
       Variable EDCGamma1=root:EDCFittingPanel:EDCParameters:SGm1
       Variable EDCPreFactor=root:EDCFittingPanel:EDCParameters:SPrefactor
       
      
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
		
	IF (	EDCFitFlag[i]==root:EDCFittingPanel:EDCParameters:EDCFitFlag)
		
		
////		ToFitEDC_Name=StringFromList(i,ToFitEDCList,";")
		ToFitEDC_Name=EDC1DName[i]
		
//////		AppendtoGraph $ToFitEDC_Name
//////		ModifyGraph mode($ToFitEDC_Name)=3,marker($ToFitEDC_Name)=8;DelayUpdate
//////        ModifyGraph rgb($ToFitEDC_Name)=(0,15872,65280)
		
		FuncFit XJZSymmEDCFit SymEDCFitCoeff $ToFitEDC_Name[FitEStart[i],FitEEnd[i]] /D

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

	    FitBKGD[i]=SymEDCFitCoeff[0]
	    FitPeakPos[i]=SymEDCFitCoeff[1]
	    FitGamma0[i]=SymEDCFitCoeff[2]
	    FitGamma1[i]=SymEDCFitCoeff[3]
	    FitPreFactor[i]=SymEDCFitCoeff[4]

	    
	Else
	ENDIF    

		i+=1
	While(i<lim)


SetDataFolder Curr
End





Proc PlotMultiEDCs(ctrlName) : ButtonControl
String ctrlName
String Curr=GetDataFolder(1)

	    
String EDCWinName
Variable PositionofComma=Strsearch(Curr,"t:",0)
Variable LengthofFolder=StrLen(Curr)
String FolderName=Curr[5,LengthofFolder-2]

////Print "Foldername=", FolderName

Variable PositionofComma2=StrSearch(FolderName,":",0)
Variable LengthofFolder2=StrLen(FolderName)
String FolderName2
IF (PositionofComma2==-1)
FolderName2=FolderName
Else
Foldername2=FolderName[PositionofComma2+1,LengthofFolder2-1]
EndIF

////Print "FolderName2=", FolderName2

Variable PositionofComma3=StrSearch(FolderName2,":",0)
Variable LengthofFolder3=StrLen(FolderName2)
String FolderName3
IF (PositionofComma3==-1)
FolderName3=FolderName2
Else
FolderName3=FolderName2[0,PositionofComma3-1]+"_"+FolderName2[PositionofComma3+1,LengthofFolder3-1]
EndIF

EDCWinName=FolderName3
////Print "EDCWinName=", EDCWinName


String EDCWindowName="EDC_"+EDCWinName
////Print TableWindowname
DoWindow $EDCWindowName  

If (V_Flag==0)

Display as  EDCWindowName 
DoWindow/C $EDCWindowName  
Else
DoWindow/F $EDCWindowName  
EndIf 
	    
	    
   
    Variable SN, EN, lim
    Variable i,j 
	String ToFitEDCList, ToFitEDC_Name
	Variable w0,w1,w2,w3,w4
	ToFitEDCList=WaveList("*F*t*O*P*",";","DIMS:1")
	Variable NoofEDCCurves=ItemsinList(ToFitEDCList,";")
	
       SN=0
//     EN=NoofEDCCurves-1
//     EN=root:SchematicFermiSurface:NoFSPoints_Overall
       EN=NoofEDCCurves    
       
       Variable EDCBackground=root:EDCFittingPanel:EDCParameters:SBackground
       Variable EDCGapSize=root:EDCFittingPanel:EDCParameters:SGap
       Variable EDCGamma0=root:EDCFittingPanel:EDCParameters:SGm0
       Variable EDCGamma1=root:EDCFittingPanel:EDCParameters:SGm1
       Variable EDCPreFactor=root:EDCFittingPanel:EDCParameters:SPrefactor
       
      
       w0=EDCBackground
       w1=EDCGapSize
       w2=EDCGamma0
       w3=EDCGamma1
       w4=EDCPreFactor
             
        		
	Make/O SymEDCFitcoeff={w0, w1, w2,w3,w4}
	Redimension/D  SymEDCFitcoeff 
	lim=EN
////	Make/O/N=((EN-SN+1)) EDCFit_Background=0, EDCFit_Gapsize=0, EDCFit_Gamma0=0, EDCFit_Gamma1=0, EDCFit_PreFactor=0
	i=SN
    Variable EDCFit_Start
    Variable EDCFit_End
        
	DO
		
	IF (	EDCFitFlag[i]==root:EDCFittingPanel:EDCParameters:EDCFitFlag)
		
		
////		ToFitEDC_Name=StringFromList(i,ToFitEDCList,";")
		ToFitEDC_Name=EDC1DName[i]
		
		AppendtoGraph $ToFitEDC_Name
		ModifyGraph rgb($ToFitEDC_Name)=(0,15872,65280)
		
////		FuncFit XJZSymmEDCFit SymEDCFitCoeff $ToFitEDC_Name[FitEStart[i],FitEEnd[i]] /D


////    FitBKGD[i]=SymEDCFitCoeff[0]
////	    FitPeakPos[i]=SymEDCFitCoeff[1]
////	    FitGamma0[i]=SymEDCFitCoeff[2]
////	    FitGamma1[i]=SymEDCFitCoeff[3]
////	    FitPreFactor[i]=SymEDCFitCoeff[4]

	    
	Else
	ENDIF    

		i+=1
	While(i<lim)
	
	
	ShowInfo
	


SetDataFolder Curr
End














Function ShowEDCImageSpectra( )

	String Curr=GetDataFolder(1)
	SVar TempName=root:FermiLevelFromAu:TempFermiName
	String ProcessedFermiImage="Pro_"+TempName
	
//Kill EDC Curves in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledEDCList=WaveList("AuFermi*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	      Variable iEDC=0
	      Do
	      EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	      KillWaves/Z  $EDCCurve
	      iEDC+=1
	      While(iEDC<NoofKilledEDCList)
	      
//Kill Fitted Curves in root:FermiLevelFromAu
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	      
        Duplicate/O $ProcessedFermiImage, AuImage
//	Display; AppendImage AuImage
        	
	 variable/G nx, ny
	 variable/G xmin, xinc, xmax, ymin, yinc, ymax
        
        XJZImginfo(AuImage)

                String EnergyReference="Reference_Energy_Fermi"
	        Make/O/N=(nx) $EnergyReference
	        Wave ReferenceEnergy=$EnergyReference
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
       	 	
                String AngleReference="Reference_Angle_Fermi"
	        Make/O/N=(ny) $AngleReference
	        Wave ReferenceAngle=$AngleReference
                Variable jj=0
      	        Do
        		ReferenceAngle[jj]=ymin+yinc*jj
        		jj=jj+1
       	 	While(jj<ny) 
       	 	

                Make/O/N=(nx) AuFermi0
                AuFermi0=AuImage[p] [0]


                 String EDC
                 String EDCName
                 Variable i=1             
                
                 DoWindow Au_Fermi_Spectra
	         if(V_flag==0)
	         
                 Display  AuFermi0 vs ReferenceEnergy as "Fermi Spectra"
                 ModifyGraph mode(AuFermi0)=4,marker(AuFermi0)=8
                 ModifyGraph rgb(AuFermi0)=(0,15872,65280)
        		DoWindow/C Au_Fermi_Spectra
	         
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
                AppendToGraph EDCC vs ReferenceEnergy 
                ModifyGraph mode($EDCName)=4,marker($EDCName)=8
                ModifyGraph rgb($EDCName)=(0,15872,65280)                
	        i=i+1
	        While(i<ny) 
	        
	            		
	        	else
	        		DoWindow/F Au_Fermi_Spectra
	       
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
	        i=i+1
	        While(i<ny) 		
	        	endif  
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
                 
                 
	         SetDataFolder Curr  
	       
End


Function EDCImageSpectraForFitting( )

	String Curr=GetDataFolder(1)
	SVar TempName=root:FermiLevelFromAu:TempFermiName
	String ProcessedFermiImage="Pro_"+TempName
	
//Kill EDC Curves in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledEDCList=WaveList("AuFermi*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	      Variable iEDC=0
	      Do
	      EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	      KillWaves/Z  $EDCCurve
	      iEDC+=1
	      While(iEDC<NoofKilledEDCList)
	      
//Kill Fitted Curves in root:FermiLevelFromAu
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	      
       Duplicate/O ImageForFermiLevel, AuImage
//     Display; AppendImage AuImage
        	
	 variable/G nx, ny
	 variable/G xmin, xinc, xmax, ymin, yinc, ymax
        
         XJZImginfo(AuImage)

                String EnergyReference="Reference_Energy_Fermi"
	        Make/O/N=(nx) $EnergyReference
	        Wave ReferenceEnergy=$EnergyReference
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
       	 	
                String AngleReference="Reference_Angle_Fermi"
	        Make/O/N=(ny) $AngleReference
	        Wave ReferenceAngle=$AngleReference
                Variable jj=0
      	        Do
        		ReferenceAngle[jj]=ymin+yinc*jj
        		jj=jj+1
       	 	While(jj<ny) 
       	 	

                Make/O/N=(nx) AuFermi0
                AuFermi0=AuImage[p] [0]


                 String EDC
                 String EDCName
                 Variable i=1             
                
                 DoWindow Au_Fermi_Spectra
	         if(V_flag==0)
	         
                 Display  AuFermi0 vs ReferenceEnergy as "Fermi Spectra"
                 ModifyGraph mode(AuFermi0)=4,marker(AuFermi0)=8
                 ModifyGraph rgb(AuFermi0)=(0,15872,65280)
        		DoWindow/C Au_Fermi_Spectra
	         
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
                AppendToGraph EDCC vs ReferenceEnergy 
                ModifyGraph mode($EDCName)=4,marker($EDCName)=8
                ModifyGraph rgb($EDCName)=(0,15872,65280)                
	        i=i+1
	        While(i<ny) 
	        
	            		
	        	else
	        		DoWindow/F Au_Fermi_Spectra
	       
	         Do
                 EDCName="AuFermi"+num2str(i)
                 Make/O/N=(nx) $EDCName
                 Wave EDCC=$EDCName
                 EDCC=AuImage[p] [i]
	        i=i+1
	        While(i<ny) 		
	        	endif  
                
                 ModifyGraph zero(bottom)=3
                 ModifyGraph mirror=2
                 
                 
	         SetDataFolder Curr  
	       
End


//Fermi Function Fit
Function XJEDCFit(w,y)


//   T=1K     k_BT=1.38062*10^(-23) J 
//   1meV=1.60219*10^(-19)*10^(-3)=1.60219*10^(-22) J

//   Therefore,  1K --> 1.38062*0.1/1.60219=0.08617meV
//                 300K-->25.85 meV


//Fermi level:      10~90% width:  4.40k_B T
//                  12~88% width:  3.98k_B T  ---corresponding to Lorentzian convolution




	//w[0]   constant background;
	//w[1]   Height of the Fermi Step; 
	//w[2]   Full Width at Half maximum;
	//w[3]   Fermi Edge position;
	wave w; Variable y
	
//	return w[0] + w[1]/(exp(4400*(y-w[3])/w[2])+1)
	
	variable val
//	val=w[0] + w[1]/(exp(4400*(y-w[3])/w[2])+1)                //10~90% width
	val=w[0] + w[1]/(exp(3980*(y-w[3])/w[2])+1)                //12~88% width	
	
	Return Val
	
//	NVar dw=w[0] + w[1]/(exp(4400*(x-w[3])/w[2])+1)
//	return dw(x)
	
END

//Fermi Function Fit
Function XJ1DEDCFit(w,x)


	//w[0]   constant background;
	//w[1]   Height of the Fermi Step; 
	//w[2]   Full Width at Half maximum;
	//w[3]   Fermi Edge position;
	//w[4]   Background Slope;
	wave w; Variable x

//	return w[0] + w[1]/(exp(4400*(x-w[3])/w[2])+1)+w[4]*x    //10~90% width
	return w[0] + w[1]/(exp(3980*(x-w[3])/w[2])+1)+w[4]*x    //12~88% width
	
END




//Fit Fermi Function with convolution
//-----------------------------------------------------------------------------------------
Function  EDCFit(w,y)
	Wave  w
	Variable  y
	string  sName="FitTemp"
	NVar EStart=root:FermiLevelFromAu:FitEnergyStart
	NVar EEnd=root:FermiLevelFromAu:FitEnergyEnd
	NVar dT=root:FermiLevelFromAu:WaveXStep1D
	NVar STemp=root:FermiLevelFromAu:Temperature
	
	Variable Fitnmpt=ceil(abs(EEnd-EStart)/dT)

//First, make a Gaussian

	Make/O/N=401 ConvG
	Setscale/P x -dT*200, dT, ConvG
	ConvG= exp(-(x/(w[2]/1000))^2)

	Variable sumConvG
	sumConvG=sum(ConvG, -inf, inf)
	ConvG/=sumConvG
	
//Second, make a new wave

Make/O/N=(Fitnmpt)  $sName
Setscale/I x, EStart, EEnd, $sName
        Variable TempE=STemp*0.025/300
	Wave dw=$sName
	dw=w[1]/(exp((y-w[3])/TempE)+1)
	Convolve/A ConvG,dw
	dw+=w[0]

	wave  wr=$sName
	return wr(y)

End
//-----------------------------------------------------------------------------------------------------------------







Function EDCCalculate(ctrlName): ButtonControl
String ctrlName

String curr=GetDataFolder(1)

SetDataFolder root:FermiLevelFromAu
 
 
      NVAR   DimensionFlag=root:FermiLevelFromAu:FileDimensionFlag
      SVAR   TempName=root:FermiLevelFromAu:TempFermiName
      WAVE  TempWave=$TempName
      NVar     DataPointNumber=root:FermiLevelFromAu:DataPoint
                   DataPointNumber=DimSize(TempWave,0) 
      Print  DimensionFlag,DataPointNumber, TempName
      Print XJZMinofWave(TempWave), XJZMaxofWave(TempWave)
 
 Make/O/N=(DataPointNumber) CalculatedFermiCurve
 NVAR ES=FitEnergyStart
 NVAR EN=FitEnergyEnd
 NVAR BG=Background
 NVAR BGSlope=BackgroundSlope
 NVAR FH=FermiHeight
 NVAR FL=FermiLevel
 NVAR FW=FWHM 
      BG=XJZMinofWave(TempWave)
      FH=XJZMaxofWave(TempWave) -MinofWave(TempWave)
 
Setscale x ES, EN, CalculatedFermiCurve
CalculatedFermiCurve=BG + FH/(exp(3980*(x-FL)/FW)+1)+x*BGSlope
//CalculatedFermiCurve=BG + FH/(exp(4400*(x-FL)/FW)+1)+x*BGSlope
RemoveFromGraph/Z  CalculatedFermiCurve
AppendToGraph CalculatedFermiCurve 
ModifyGraph mode(CalculatedFermiCurve)=0,lsize(CalculatedFermiCurve)=3;DelayUpdate
ModifyGraph rgb(CalculatedFermiCurve)=(65280,0,0)
 
 SetDataFolder curr

End

         
Function XJ2DEDCFunctionFit()
        String Curr=GetDataFolder(1)
        SetDataFolder root:FermiLevelFromAu
        Variable SN, EN, lim
        Variable i,j 
	String FermiList, Fermi_Name
	Variable w0,w1,w2,w3
	FermiList=WaveList("AuFermi*",";","DIMS:1")
	Variable NoofFermiCurves=ItemsinList(FermiList,";")
	
       SN=0
       EN=NoofFermiCurves-1
       NVar AuBackground=root:FermiLevelFromAu:Background
       NVar AuFermiHeight=root:FermiLevelFromAu:FermiHeight
       NVar AuFWHM=root:FermiLevelFromAu:FWHM
       NVar AuFermiLevel=root:FermiLevelFromAu:FermiLevel	
       
       w0=AuBackground
       w1=AuFermiHeight
       w2=AuFWHM
       w3=AuFermiLevel		
	Make/O Fermicoeff={w0, w1, w2,w3}
	Redimension/D  Fermicoeff 
	lim=EN+1
	Make/O/N=((EN-SN+1)) Fermi_Background=0, Fermi_Height=0, Fermi_FWHM=0, Fermi_Level=0, Fermi_Level2D_0=0,Fermi_Angle
	i=SN
        NVar Fermi_EnergyStart=root:FermiLevelFromAu:FitEnergyStart
        NVar Fermi_EnergyEnd=root:FermiLevelFromAu:FitEnergyEnd
        NVar FermiLevelAve2D=root:FermiLevelFromAu:FermiLevelAverage2D
        Wave AuEnergyReference=root:FermiLevelFromAu:Reference_Angle_Fermi
	do
		Fermi_Name=StringFromList(i,FermiList,";")
		FuncFit XJEDCFit Fermicoeff root:FermiLevelFromAu:$Fermi_Name  /D /X=root:FermiLevelFromAu:Reference_Energy_Fermi
	        Fermi_Background[i]=Fermicoeff[0]
	        Fermi_Height[i]=Fermicoeff[1]
	        Fermi_FWHM[i]=Fermicoeff[2]
	        Fermi_Level[i]=Fermicoeff[3]
                Fermi_Angle[i]=AuEnergyReference[i]
		i+=1
	while(i<lim)

         FermiLevelAve2D=XJZAverageofWave(root:FermiLevelFromAu:Fermi_Level)
         Print "Average Fermi Level 2D:", FermiLevelAve2D
         Fermi_Level2D_0=Fermi_Level-FermiLevelAve2D

		
		SetDataFolder Curr
		
         End        
         
         
         
Proc XJ1DEDCFunctionFit()
        String Curr=GetDataFolder(1)
        SetDataFolder root:FermiLevelFromAu

       String Fermi1D_Name
       String FermiEDC="Au"+TempFermiName
       String FitCurve="fit_"+FermiEDC

       Variable Fermi1D_Background,  Fermi1D_BackgroundSlope, Fermi1D_Height, Fermi1D_FWHM, Fermi1D_FWHMError, Fermi1D_Level, Fermi1D_LevelError
	   Variable Fermi_EnergyStart=root:FermiLevelFromAu:FitEnergyStart
	   Variable Fermi_EnergyEnd=root:FermiLevelFromAu:FitEnergyEnd
	   Variable NumofX, Xminimum, Xincrement, XMaximum

	   Duplicate/O/R=(root:FermiLevelFromAu:FitEnergyStart,root:FermiLevelFromAu:FitEnergyEnd) $TempFermiName, $FermiEDC
          
	   NumofX=DimSize($FermiEDC, 0)
	   Xminimum=DimOffset($FermiEDC,0)
	   Xincrement=round(DimDelta($FermiEDC,0) * 1E6) / 1E6	
 	   XMaximum=Xminimum+Xincrement*(NumofX-1)
 	   

        root:FermiLevelFromAu:Background=XJZMinofWave($FermiEDC)
        root:FermiLevelFromAu:FermiHeight=XJZMaxofWave($FermiEDC)-MinofWave($FermiEDC)

        Variable w0,w1,w2,w3,w4
        w0=root:FermiLevelFromAu:Background
//        w0=0
        w1=root:FermiLevelFromAu:FermiHeight
//        w0=MinofWave($FermiEDC)
//        w1=MaxofWave($FermiEDC)-MinofWave($FermiEDC)
        w2=root:FermiLevelFromAu:FWHM
        w3=root:FermiLevelFromAu:FermiLevel
        w4=root:FermiLevelFromAu:BackgroundSlope
//      Make/O Fermicoeff={w0, w1, w2, w3,w4}	   
        Make/O Fermicoeff={w0, w1, w2, w3}	
        Redimension/D  Fermicoeff   
 	   
 	   
//	   Print NumofX, Xminimum, Xmaximum, Fermi_EnergyStart, Fermi_EnergyEnd
           Make/O/N=(NumofX) Fit1DEnergyAxis
                Variable ii=0
      	        Do
        		Fit1DEnergyAxis[ii]=Xminimum+Xincrement*ii
       		ii=ii+1
       	 	While(ii<NumofX)

               RemoveFromGraph/Z  $FitCurve 
               RemoveFromGraph/Z  CalculatedFermiCurve
	        FuncFit XJFermiFit Fermicoeff root:FermiLevelFromAu:$FermiEDC  /D /X=Fit1DEnergyAxis
//		FuncFit EDCFit  Fermicoeff root:FermiLevelFromAu:$FermiEDC /X=Fit1DEnergyAxis
//	        FuncFitMD ConvFunc(Fermicoeff,  root:FermiLevelFromAu:$FermiEDC, Fit1DEnergyAxis)	        
	        	        
	        Append $fitCurve  
	        Fermi1D_Background=Fermicoeff[0]
	        Fermi1D_Height=Fermicoeff[1]
	        Fermi1D_FWHM=Fermicoeff[2]
	        Fermi1D_Level=Fermicoeff[3]
	        Fermi1D_BackgroundSlope=Fermicoeff[4]
	        Fermi1D_FWHMError=W_sigma[2]
	        Fermi1D_LevelError=W_sigma[3]
	        
	        String FermiLevelLabel="Fermi Level= ("+num2str(Fermi1D_Level)+ " +/- " + num2str(Fermi1D_LevelError) +   ")eV"
	        String FWHMLabel="12~88%Width= ("+num2str(Fermi1D_FWHM) +  " +/- " + num2str(Fermi1D_FWHMError) +   ")meV"
	        Textbox/K/N=text0
	        Textbox/K/N=text1
	        Textbox/N=text0/F=0/A=RT FermiLevelLabel
	        AppendText/N=text0 FWHMLabel      
	        Print "Fermi Level= (", Fermi1D_Level, "+", Fermi1D_LevelError, ") eV"
	        Print "12~88%Width= (", Fermi1D_FWHM,"+", Fermi1D_FWHMError, ") meV"
		
		SetDataFolder Curr
		
         End


Proc ShowFittedEDCInfo()
      
       String Curr=GetDataFolder(1)
             
       SetDataFolder root:FermiLevelFromAu
       String WindowName="Au"+TempFermiName
       String EfLevel="Ef"+TempFermiName
       String EfAngle="Ang"+TempFermiName
       String EfFWHM="Wd"+TempFermiName
       Duplicate/O Fermi_Level $EfLevel
       Duplicate/O Fermi_Angle $EfAngle
       Duplicate/O Fermi_FWHM $EfFWHM
       
       DoWindow $WindowName
       
       If(V_flag==0)
       Display $EfLevel vs $EfAngle
//     Display Fermi_Level vs Fermi_Angle
       ModifyGraph mode=4,marker=19
       AppendToGraph/R $EfFWHM vs $EfAngle
//     AppendToGraph/R Fermi_FWHM vs Fermi_Angle
       ModifyGraph rgb($EfFWHM)=(0,15872,65280)
//     ModifyGraph rgb(Fermi_FWHM)=(0,15872,65280)
       ModifyGraph mode=4
       ModifyGraph mirror(bottom)=2
       ModifyGraph standoff(left)=0,standoff(bottom)=0
       Label left "\\Z12\\f01\\K(65280,0,0)Fitted Fermi Level (eV) "
       Label bottom "\\Z12\\f01Analyzer Angle (Degrees)"
       Label right "\\Z12\\f01\\K(0,15872,65280)Fitted FWHM (meV)"
       DoWindow/C $WindowName
       Else
       DoWindow/F $WindowName
       Endif  
       
       
        SetDataFolder Curr	

END

Proc XJZCleanFittedEDC()

	String Curr=GetDataFolder(1)
	
	//Kill Fitted EDCs in root:PROCESSEDIMAGESpectra
	SetDataFolder root:PROCESSEDIMAGESpectra
	String ToBeKilledFitList=WaveList("Fit*F*t*P*T*",";","DIMS:1")
       	Variable NoofKilledFitList=ItemsinList(ToBeKilledFitList,";")
          String File1D
	      Variable iFile1D=0
	      Do
	      File1D=StringFromList(iFile1D,ToBeKilledFitList,";")
	      KillWaves/Z  $File1D
	      iFile1D+=1
	      While(iFile1D<NoofKilledFitList)
	      
	      
	SetDataFolder Curr
	
End



Function XJZEDCDoneBotton(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
//Execute XJZClean(ctrlName)

	
	//Kill duplicated files 1D in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledFileList1D=WaveList("A*",";","DIMS:1")
       	Variable NoofKilledFileList1D=ItemsinList(ToBeKilledFileList1D,";")
       	String File1D
	      Variable iFile1D=0
	      Do
	      File1D=StringFromList(iFile1D,ToBeKilledFileList1D,";")
	      KillWaves/Z  $File1D
	      iFile1D+=1
	      While(iFile1D<NoofKilledFileList1D)
	      
	      
	//Kill duplicated files 2D in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledFileList2D=WaveList("A*",";","DIMS:2")
       	Variable NoofKilledFileList2D=ItemsinList(ToBeKilledFileList2D,";")
       	String File2D
	      Variable iFile2D=0
	      Do
	      File2D=StringFromList(iFile2D,ToBeKilledFileList2D,";")
	      KillWaves/Z  $File2D
	      iFile2D+=1
	      While(iFile1D<NoofKilledFileList2D)	      
	      
	      	
	
	
	//Kill EDC Curves in root:FermiLevelFromAu
	SetDataFolder root:FermiLevelFromAu
	String ToBeKilledEDCList=WaveList("Au*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	      Variable iEDC=0
	      Do
	      EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	      KillWaves/Z  $EDCCurve
	      iEDC+=1
	      While(iEDC<NoofKilledEDCList)
	
	//Kill Fitted Curves in root:FermiLevelFromAu
	String KilledFittedList=WaveList("*fit_*",";","DIMS:1")
       	Variable NoofKilledFittedList=ItemsinList(KilledFittedList,";")
       	String FittedCurve
	      Variable iFit=0
	      Do
	      FittedCurve=StringFromList(iFit,KilledFittedList,";")
	      KillWaves/Z  $FittedCurve
	      iFit+=1
	      While(iFit<NoofKilledFittedList)	      
	
	DoWindow/K EDC_Fitting_Panel
	
	SetDataFolder Curr
	
End


Function XJZMaxofWave(Wave0)
Wave Wave0
Variable DimofWave0=dimsize(Wave0,0)
Variable MaxofWave=0
Variable i=0
Do
If (Wave0[i]>MaxofWave)
MaxofWave=Wave0[i]
Else
Endif
i+=1
While(i<DimofWave0)
Return MaxofWave
End


Function XJZMinofWave(Wave0)
Wave Wave0
Variable DimofWave0=dimsize(Wave0,0)
Variable MinofWave=Wave0[0]
Variable i=1
Do
If (Wave0[i]<MinofWave)
MinofWave=Wave0[i]
Else
Endif
i+=1
While(i<DimofWave0)
Return MinofWave
End


Function XJZAverageofWave(Wave0)
Wave Wave0
Variable DimofWave0=dimsize(Wave0,0)
Variable SumofWave0, AverageofWave0
Variable i=0
SumofWave0=0

Do
SumofWave0+=Wave0[i]
i+=1
While(i<DimofWave0)
AverageofWave0=SumofWave0/DimofWave0
Return AverageofWave0
End
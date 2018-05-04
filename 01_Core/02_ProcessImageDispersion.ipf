#pragma rtGlobals=1		// Use modern global access method.

Proc ARPES_Analysis_SES2002()
//-----------------
	pauseupdate;silent 1
    DoWindow/K HERS_ARPES_Analysis_Panel
    DoWindow/K Load_data_SES2002   
               
	DoWindow/F HERS_ARPES_Analysis_SES2002
	if (V_flag==0)
	
//	       NewDataFolder/O/S root:OriginalData
//	       String/G OriginalFileList=WaveList("A*",";","DIMS:2")
//	       Variable/G NoofOriginalFile=ItemsinList(OriginalFileList,";")
//	       String/G Original1DFileList=WaveList("A*",";","DIMS:1")
//	       Variable/G Noof1DOriginalFile=ItemsinList(Original1DFileList,";")


		NewDataFolder/O/S root:PROCESS
		
		//--------------------Added by JXW------------------------------------
		//Define switch selections for MDC2d or EDC2d FS mapping
		variable/G edc2d,mdc2d
		string/G root:PROCESS:timeremain=""
		//--------------------Added by JXW------------------------------------
		
		Variable/G DataSource=NumVarOrDefault("root:PROCESS:DataSource",1)

		Variable/G  CropStart=NumVarOrDefault("root:PROCESS:CropStart",5), CropEnd=NumVarOrDefault("root:PROCESS:CropEnd",24)
		Variable/G  EnergyStart=NumVarOrDefault("root:PROCESS:EnergyStart",50), EnergyEnd=NumVarOrDefault("root:PROCESS:EnergyEnd",50)
		Variable/G  NorYStart=NumVarOrDefault("root:PROCESS:NorYStart",50), NorYEnd=NumVarOrDefault("root:PROCESS:NorYEnd",50)
		Variable/G  DetectorCenterAngle=NumVarOrDefault("root:PROCESS:DetectorCenterAngle",50)
		
		
		Variable/G NorYFlag=NumVarOrDefault("root:PROCESS:NorYFlag",1)
		
		Variable/G  ZeroFermi=NumVarOrDefault("root:PROCESS:ZeroFermi",50), FermiCorrection=NumVarOrDefault("root:PROCESS:FermiCorrection",1)
		Variable/G TempFermiCorrection2D, TempTemperature2D
		Variable/G  ThetaAngle=NumVarOrDefault("root:PROCESS:ThetaAngle",0.0)
                Variable/G PhiAngle=NumVarOrDefault("root:PROCESS:PhiAngle",0.0)
                Variable/G OmegaAngle=NumVarOrDefault("root:PROCESS:OmegaAngle",0.0)               
                String/G   NewNamePrefix=StrVarOrDefault("root:PROCESS:NewNamePrefix","")
                
                Variable/G ProcessedImageFlag=NumVarOrDefault("root:PROCESS:ProcessedImageFlag",0.0)
                Variable/G ProIMGDisplayMode=NumVarOrDefault("root:PROCESS:ProIMGDisplayMode",0) 
                
                String/G   EDCNamePrefix=StrVarOrDefault("root:PROCESS:EDCNamePrefix","")
                Variable/G  MDC_EE=NumVarOrDefault("root:PROCESS:MDC_EE",0) 
                Variable/G  bindnumber_MDC=NumVarOrDefault("root:PROCESS:bindnumber_MDC",0)  
                
                
                           
                Variable/G EDCDisplayMode=NumVarOrDefault("root:PROCESS:EDCDisplayMode",0)              
                Variable/G SpectraOffset=NumVarOrDefault("root:PROCESS:SpectraOffset",0.0)
                Variable/G SpectraBind=NumVarOrDefault("root:PROCESS:SpectraBind",1)
                Variable/G ProcessedImageEnergyStart=NumVarOrDefault("root:PROCESS:ProcessedImageEnergyStart",-1) 
                Variable/G ProcessedImageEnergyEnd=NumVarOrDefault("root:PROCESS:ProcessedImageEnergyEnd",0.1)
                Variable/G ShowEDCNoStart=NumVarOrDefault("root:PROCESS:ShowEDCNoStart",0) 
                Variable/G ShowEDCNoEnd=NumVarOrDefault("root:PROCESS:ShowEDCNoEnd",1)   
                Variable/G ShowEDCEveryNumber=NumVarOrDefault("root:PROCESS:ShowEDCEveryNumber",1) 
                Variable/G ErToler=NumVarOrDefault("root:PROCESS:ErToler",1) 
                Variable/G ShowEDCNumberMode=NumVarOrDefault("root:PROCESS:ShowEDCNumberMode",1) 
                Variable/G FermiFuncRemoveMode=NumVarOrDefault("root:PROCESS:FermiFuncRemoveMode",1) 
                
                Variable/G ConvolutionEResolution=NumVarOrDefault("root:PROCESS:ConvolutionEResolution",1) 
                   
                Variable/G BGSubCurveNo=NumVarOrDefault("root:PROCESS:BGSubCurveNo",1)                  
		         Variable/G PhotonEnergy=NumVarOrDefault("root:PROCESS:PhotonEnergy",21.2)
		         Variable/G WorkFunction=NumVarOrDefault("root:PROCESS:WorkFunction",4.3)                     
                Variable/G LatticeConstant=NumVarOrDefault("root:PROCESS:LatticeConstant",3.8)
                Variable/G ThetaOffset=NumVarOrDefault("root:PROCESS:ThetaOffset",0.0)
                Variable/G PhiOffset=NumVarOrDefault("root:PROCESS:PhiOffset",0.0)
                Variable/G OmegaOffset=NumVarOrDefault("root:PROCESS:OmegaOffset",0.0)
                Variable/G RotationAngle=NumVarOrDefault("root:PROCESS:RotationAngle",0.0)
                Variable/G KxOffset=NumVarOrDefault("root:PROCESS:KxOffset",0.0), KyOffset=NumVarOrDefault("root:PROCESS:KyOffset",0.0)
                Variable/G ThetaStart=NumVarOrDefault("root:PROCESS:ThetaStart",-18), ThetaEnd=NumVarOrDefault("root:PROCESS:ThetaEnd",25)
                Variable/G IntegrationStart=NumVarOrDefault("root:PROCESS:IntegrationStart",-0.03), IntegrationEnd=NumVarOrDefault("root:PROCESS:IntegrationEnd",0.03)
                String/G   SWImageName=StrVarOrDefault("root:PROCESS:SWImageName","SW")
                String/G   ProcessedFileList=WaveList("*F*P*T*",";","DIMS:2")
                String/G   ProcessedFileList, ProcessedFilNam,ProcessedNum
                Variable/G KxStart=NumVarOrDefault("root:PROCESS:KxStart",-1), KxEnd=NumVarOrDefault("root:PROCESS:KxEnd",1)
                Variable/G KyStart=NumVarOrDefault("root:PROCESS:KyStart",-1), KyEnd=NumVarOrDefault("root:PROCESS:KyEnd",1)
                Variable/G KxPointNumber=NumVarOrDefault("root:PROCESS:KxPointNumber",100)
                Variable/G KyPointNumber=NumVarOrDefault("root:PROCESS:KyPointNumber",100)
                Variable/G LegendHigh=NumVarOrDefault("root:PROCESS:LegendHigh",1)
                Variable/G LegendLow=NumVarOrDefault("root:PROCESS:LegendLow",0)
                Variable/G DispersionImageFlag=NumVarOrDefault("root:PROCESS:DispersionImageFlag",0.0)
                Variable/G EDCSmoothingTimes=NumVarOrDefault("root:PROCESS:EDCSmoothingTimes",100)
                Variable/G MDCSmoothingTimes=NumVarOrDefault("root:PROCESS:MDCSmoothingTimes",100)
                Variable/G CurBindE=NumVarOrDefault("root:PROCESS:CurBindE",1)
                Variable/G CurBindK=NumVarOrDefault("root:PROCESS:CurBindK",1)
                Variable/G CurBindi0=NumVarOrDefault("root:PROCESS:CurBindi0",0.01)
                
                //ZWT  
                Variable/G InteFactor=NumVarOrDefault("root:PROCESS:InteFactor",2) 
                InteFactor=2
                String/G EKPiovera
                String/G EK1overA
                String/G EKALL
                Variable/G GetAllEKV
                String/G root:Process:ALLOriginalImage
                String/G DispersionFileList
                //ZWT            

        NewDataFolder/O/S root:FermiLevelFromAu
                	
		Variable/G CorrectionFlag=NumVarOrDefault("root:FermiLevelFromAu:CorrectionFlag",0), CorrectionFlag=0


		NewDataFolder/O/S root:PROCESSEDIMAGESpectra

		Variable/G EDCBackground= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDCBackground",0.0)
		Variable/G EDCHeight= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDCHeight",0.0)		
		Variable/G EDCFWHM= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDCFWHM",0.0)			
		Variable/G EDCPosition= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDCPosition",0.0)
		Variable/G EDC2Height= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDC2Height",0.0)			
		Variable/G EDC2FWHM= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDC2FWHM",0.0)			
		Variable/G EDC2Position= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDC2Position",0.0)
		Variable/G EDC3Height= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDC3Height",0.0)			
		Variable/G EDC3FWHM= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDC3FWHM",0.0)			
		Variable/G EDC3Position= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDC3Position",0.0)		
		Variable/G EDCCurveStart= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDCCurveStart",0.0)		
		Variable/G EDCCurveEnd= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDCCurveEnd",0.0)
		Variable/G EDCTemperature= NumVarOrDefault("root:PROCESSEDIMAGESpectra:EDCTemperature",0.0)		
		
		Variable/G NumberofLorentzianPeaks_EDC
		String/G   ThetaAngleForEDCPlot	
		String/G   TempEDCName
		
		
		
		
		NewDataFolder/O/S root:BackGroundSubtractedSpectra
		
		NewDataFolder/O/S root:BackGroundSubtractedImage
				
		NewDataFolder/O/S root:IMG
		String/G NName
		String/G imgnam, imgfldr, imgproc, imgproc_undo, exportn
		make/o/n=(10,10) image0, image, image_undo
		make/o/n=10 profileH, profileH_x, profileV, profileV_y
		Make/O HairY0={0,0,0,NaN,Inf,0,-Inf}
		Make/O HairX0={-Inf,0,Inf,NaN,0,0,0}
		variable/G nx, ny, center, width
		variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0, dmin, dmax
		variable/G numpass=1			//# of filter passes
		variable/G gammaa=1
		make/o/n=256 pmap=p
		
		
		NewDataFolder/O/S root:IMG:ThetaPhiImage	
		NewDataFolder/O/S root:IMG:KxKyImage				
		
		
		
		NewDataFolder/O/S root:DispersionIMAGE
		String/G DispersionFileList
		Variable/G BindingECorrectionMode=NumVarOrDefault("root:DispersionIMAGE:BindingECorrectionMode",0.0)
		
		NewDataFolder/O/S root:DispersionIMAGE_1overA
		
		
	    NewDataFolder/O/S root:DispersionIMAGE_EbCorrected		
		String/G DispersionFileList_EbCorrected
		Variable/G InterStep=NumVarOrDefault("root:DispersionIMAGE_EbCorrected:InterStep",0.0)
		
	    NewDataFolder/O/S root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated		
		String/G DispersionFileList_EbC_Rotated	
		
	    NewDataFolder/O/S root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG		
			
		
		
				
		
	    NewDataFolder/O/S root:MDCSpectra
	    Variable/G MDCSpectraOffset=NumVarOrDefault("root:MDCSpectra:MDCSpectraOffset",0.0)
	    Variable/G MDCBindNumber=NumVarOrDefault("root:MDCSpectra:MDCBindNumber",0.0)	       
		Variable/G DispersionEnergyStart= NumVarOrDefault("root:MDCSpectra:DispersionEnergyStart",0.0)
		Variable/G DispersionEnergyEnd= NumVarOrDefault("root:MDCSpectra:DispersionEnergyEnd",0.0)
		Variable/G DispersionMomentumStart= NumVarOrDefault("root:MDCSpectra:DispersionMomentumStart",0.0)
		Variable/G DispersionMomentumEnd= NumVarOrDefault("root:MDCSpectra:DispersionMomentumEnd",0.0)
		Variable/G MDCBackground= NumVarOrDefault("root:MDCSpectra:MDCBackground",0.0)
		Variable/G MDCHeight= NumVarOrDefault("root:MDCSpectra:MDCHeight",0.0)
	    Variable/G InvMDCHeight= NumVarOrDefault("root:MDCSpectra:InvMDCHeight",0.0)
		Variable/G MDCFWHM= NumVarOrDefault("root:MDCSpectra:MDCFWHM",0.0)			
		Variable/G MDCPosition= NumVarOrDefault("root:MDCSpectra:MDCPosition",0.0)
		Variable/G MDC2Height= NumVarOrDefault("root:MDCSpectra:MDC2Height",0.0)
		Variable/G InvMDC2Height= NumVarOrDefault("root:MDCSpectra:InvMDC2Height",0.0)		
		Variable/G MDC2FWHM= NumVarOrDefault("root:MDCSpectra:MDC2FWHM",0.0)			
		Variable/G MDC2Position= NumVarOrDefault("root:MDCSpectra:MDC2Position",0.0)
		Variable/G MDC3Height= NumVarOrDefault("root:MDCSpectra:MDC3Height",0.0)
		Variable/G InvMDC3Height= NumVarOrDefault("root:MDCSpectra:InvMDC3Height",0.0)					
		Variable/G MDC3FWHM= NumVarOrDefault("root:MDCSpectra:MDC3FWHM",0.0)			
		Variable/G MDC3Position= NumVarOrDefault("root:MDCSpectra:MDC3Position",0.0)		
		Variable/G MDCCurveStart= NumVarOrDefault("root:MDCSpectra:MDCCurveStart",0.0)		
		Variable/G MDCCurveEnd= NumVarOrDefault("root:MDCSpectra:MDCCurveEnd",0.0)
		Variable/G NumberofLorentzianPeaks
		newdatafolder/O root:ARToFData
		variable/G root:PROCESS:showprogress=0
		
		
		
		String/G ThetaAngleForMDCPlot	
		String/G TempMDCName
		
		setdatafolder root:ARToFData
		string/G nameprestr=strVarOrDefault("root:ARToFData:nameprestr","")
		
		NewDataFolder/O/S root:DispersionFrom2ndDerivative
		
		NewDataFolder/O/S root:DispersionFrom2ndDerivative:EDC2ndD
		
		NewDataFolder/O/S root:DispersionFrom2ndDerivative:MDC2ndD		
		
		NewDataFolder/O/S root:ThreeDImages
		
		NewDataFolder/O/S root:MDCFittedParameters
		
		NewDataFolder/O/S root:EKxKyIntensityData
		
		SetDataFolder root:
		
		ARPES_Analysis()

	endif
End


Window ARPES_Analysis() : Panel 
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1/W=(56,45,841,533)
	ModifyPanel fixedSize=1, frameStyle=1
	SetDrawLayer UserBack
	SetDrawEnv fillfgc= (65280,32768,58880)
	DrawRRect 405,365,569,409
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 3,40,197,160
	SetDrawEnv fillfgc= (40960,65280,16384)
	DrawRRect 3,163,197,254
	SetDrawEnv fillfgc= (0,43520,65280)
	DrawRRect 1,257,198,435
	SetDrawEnv fillfgc= (40960,65280,16384)
	DrawRRect 204,3,402,267
	SetDrawEnv fillfgc= (40960,65280,16384)
	DrawRRect 202,269,401,412
	SetDrawEnv fillfgc= (0,43520,65280)
	DrawRRect 203,417,403,483
	SetDrawEnv fillfgc= (32768,40704,65280)
	DrawRRect 405,4,567,67
	SetDrawEnv fillfgc= (48896,52992,65280)
	DrawRRect 405,69,568,249
	SetDrawEnv fillfgc= (65280,32768,58880)
	DrawRRect 405,251,569,299
	SetDrawEnv fillfgc= (0,65280,33024)
	DrawRRect 572,4,776,97
	SetDrawEnv fillfgc= (0,65280,33024)
	DrawRRect 573,102,776,185
	SetDrawEnv fillfgc= (32768,65280,65280)
	DrawRRect 575,190,777,299
	SetDrawEnv fillfgc= (32768,65280,65280)
	DrawRRect 573,304,778,482
	SetDrawEnv fsize= 10
	DrawText 160,12,"0-IOP"
	SetDrawEnv fsize= 10
	DrawText 160,22,"1-HiSor"
	SetDrawEnv fillfgc= (65495,2134,34028),fsize= 10
	DrawText 117,349,"0-No Nor"
	SetDrawEnv fsize= 10
	DrawText 116,359,"1-Energy Range"
	SetDrawEnv fsize= 9
	DrawText 148,404,"0-No"
	SetDrawEnv fsize= 9
	DrawText 148,414,"1-Yes"
	SetDrawEnv fillfgc= (65495,2134,34028),fsize= 14
	DrawText 210,20,"Processed Image and EDCs"
	SetDrawEnv fsize= 10
	DrawText 325,192,"0-All"
	SetDrawEnv fsize= 10
	DrawText 325,202,"1-DefineEDC#"
	SetDrawEnv fillfgc= (65495,2134,34028)
	DrawText 230,286,"EDC Fitting Initialization"
	SetDrawEnv fillfgc= (65495,2134,34028)
	DrawText 610,207,"MDC Fitting Initialization"
	SetDrawEnv fillfgc= (65495,2134,34028)
	DrawText 586,319,"Dispersion From 2nd Derivative"
	SetDrawEnv fillfgc= (32768,40704,65280)
	DrawRRect 404,301,569,362
	SetDrawEnv fname= "@Arial Unicode MS",fstyle= 1
	DrawText 406,383,"If all failed,please try this."
	PopupMenu popFolder,pos={3,1},size={106,20},proc=SelectFolderSES,title="SetDataFolder"
	PopupMenu popFolder,font="Times New Roman",mode=0,value= #"root:SES:folderList"
	SetVariable set_DataSource,pos={119,4},size={40,16},proc=SetVarProc,title="S"
	SetVariable set_DataSource,font="Times New Roman",fSize=10
	SetVariable set_DataSource,limits={0,1,1},value= root:PROCESS:DataSource
	SetVariable setlib,pos={3,24},size={190,16},title=" ",font="Times New Roman"
	SetVariable setlib,fSize=10,value= root:SES:filpath
	PopupMenu popup_file,pos={5,43},size={157,20},proc=SelectFileSES,title="File"
	PopupMenu popup_file,font="Times New Roman"
	PopupMenu popup_file,mode=15,popvalue="20061123170157.pxt",value= #"root:SES:fileList\t\t"
	Button FileUpdate,pos={144,43},size={50,22},proc=UpdateFolderSES,title="UPDATE"
	Button FileUpdate,font="Times New Roman"
	SetVariable val_kind,pos={7,68},size={110,16},title="Mode"
	SetVariable val_kind,font="Times New Roman",fSize=10,value= root:SES:skind
	ValDisplay val_Ep,pos={130,68},size={60,13},title="Pass E"
	ValDisplay val_Ep,font="Times New Roman",fSize=10
	ValDisplay val_Ep,limits={0,0,0},barmisc={0,1000},value= #"root:SES:Epass[0]"
	ValDisplay val_Nreg,pos={7,86},size={60,13},title="# Region"
	ValDisplay val_Nreg,font="Times New Roman",fSize=10
	ValDisplay val_Nreg,limits={0,0,0},barmisc={0,1000},value= #"root:SES:nregion"
	ValDisplay val_dwell,pos={130,86},size={60,13},title="Dwell"
	ValDisplay val_dwell,font="Times New Roman",fSize=10
	ValDisplay val_dwell,limits={0,0,0},barmisc={0,1000},value= #"root:SES:dwell[0]"
	Button StepMinus,pos={5,105},size={25,25},proc=StepFileSES,title="<<"
	Button StepMinus,font="Times New Roman"
	Button StepPlus,pos={34,105},size={25,25},proc=StepFileSES,title=">>"
	Button StepPlus,font="Times New Roman"
	Button PlotButton1,pos={64,105},size={60,25},proc=PlotSES,title="Display"
	Button PlotButton1,font="Times New Roman"
	Button PlotButton2,pos={134,105},size={60,25},proc=PlotSES,title="Append"
	Button PlotButton2,font="Times New Roman"
	Button LoadAllButton,pos={25,134},size={140,22},proc=LoadAll,title="Load ALL Files"
	Button LoadAllButton,font="Times New Roman"
	Button SetParameterButton,pos={7,171},size={80,30},proc=SetParameter,title="Set TABLE"
	Button SetParameterButton,font="Times New Roman"
	ValDisplay val_TotalNumOriginalFiles,pos={93,173},size={100,13},title="Total#ofFiles"
	ValDisplay val_TotalNumOriginalFiles,font="Times New Roman",fSize=10
	ValDisplay val_TotalNumOriginalFiles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_TotalNumOriginalFiles,value= #"root:SES:numfiles"
	ValDisplay val_2DNumOriginalFiles,pos={92,187},size={50,13},title="#2D"
	ValDisplay val_2DNumOriginalFiles,font="Times New Roman",fSize=10
	ValDisplay val_2DNumOriginalFiles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_2DNumOriginalFiles,value= #"root:OriginalData:NoofOriginalFile"
	ValDisplay val_1DNumOriginalFiles,pos={142,188},size={50,13},title="#1D"
	ValDisplay val_1DNumOriginalFiles,font="Times New Roman",fSize=10
	ValDisplay val_1DNumOriginalFiles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_1DNumOriginalFiles,value= #"root:OriginalData:Noof1DOriginalFile"
	PopupMenu OriginalImage_file,pos={6,207},size={185,20},bodyWidth=140,proc=SelectOriginalImage,title="Show2D"
	PopupMenu OriginalImage_file,font="Times New Roman"
	PopupMenu OriginalImage_file,mode=54,popvalue="A20090508174209",value= #"root:OriginalData:OriginalFileList\t\t"
	PopupMenu Original1DFile_file,pos={6,229},size={185,20},bodyWidth=140,proc=SelectOriginal1DFile,title="Show1D"
	PopupMenu Original1DFile_file,font="Times New Roman"
	PopupMenu Original1DFile_file,mode=6,popvalue="A20061123122000",value= #"root:OriginalData:Original1DFileList\t\t"
	Button ProcessButton,pos={11,258},size={180,24},proc=XJZProcess,title="Process Image"
	Button ProcessButton,font="Times New Roman",fSize=12
	SetVariable set_CropStart,pos={14,284},size={97,16},bodyWidth=50,proc=SetVarProc,title="AngleStart"
	SetVariable set_CropStart,font="Times New Roman",fSize=10
	SetVariable set_CropStart,limits={-20,10,0.1},value= root:PROCESS:cropstart
	SetVariable set_CropEnd,pos={123,284},size={70,16},bodyWidth=50,proc=SetVarProc,title="End"
	SetVariable set_CropEnd,font="Times New Roman",fSize=10
	SetVariable set_CropEnd,limits={0,30,0.1},value= root:PROCESS:cropend
	SetVariable set_EnergyStart,pos={10,301},size={101,16},bodyWidth=50,proc=SetVarProc,title="EnergyStart"
	SetVariable set_EnergyStart,font="Times New Roman",fSize=10
	SetVariable set_EnergyStart,limits={-inf,inf,0.1},value= root:PROCESS:energystart
	SetVariable set_EnergyEnd,pos={123,301},size={70,16},bodyWidth=50,title="End"
	SetVariable set_EnergyEnd,font="Times New Roman",fSize=10
	SetVariable set_EnergyEnd,limits={-inf,inf,0.1},value= root:PROCESS:energyend
	SetVariable set_NorYStart,pos={16,318},size={95,16},bodyWidth=50,proc=SetVarProc,title="NorYStart"
	SetVariable set_NorYStart,font="Times New Roman",fSize=10
	SetVariable set_NorYStart,limits={-inf,inf,0.1},value= root:PROCESS:norystart
	SetVariable set_NorYEnd,pos={123,318},size={70,16},bodyWidth=50,proc=SetVarProc,title="End"
	SetVariable set_NorYEnd,font="Times New Roman",fSize=10
	SetVariable set_NorYEnd,limits={-inf,inf,0.1},value= root:PROCESS:noryend
	SetVariable set_NorYMode,pos={9,340},size={102,16},bodyWidth=50,proc=SetVarProc,title="NorY Mode"
	SetVariable set_NorYMode,font="Times New Roman",fSize=10
	SetVariable set_NorYMode,limits={0,1,1},value= root:PROCESS:NorYFlag
	SetVariable set_ZeroFermi,pos={41,358},size={70,16},bodyWidth=50,proc=SetVarProc,title="E_F"
	SetVariable set_ZeroFermi,font="Times New Roman",fSize=9
	SetVariable set_ZeroFermi,limits={-inf,inf,0.001},value= root:PROCESS:zerofermi
	SetVariable set_Newname,pos={121,359},size={70,16},bodyWidth=30,proc=SetVarProc,title="ImgPrefix"
	SetVariable set_Newname,font="Times New Roman",fSize=9
	SetVariable set_Newname,value= root:PROCESS:NewNamePrefix
	SetVariable set_ProcessedImageFlag,pos={8,376},size={102,16},bodyWidth=50,title="ProcessFlag"
	SetVariable set_ProcessedImageFlag,font="Times New Roman",fSize=10
	SetVariable set_ProcessedImageFlag,limits={0,10,1},value= root:PROCESS:ProcessedImageFlag
	SetVariable set_DetectorCenter,pos={118,376},size={73,16},bodyWidth=30,proc=SetVarProc,title="DetCenter"
	SetVariable set_DetectorCenter,font="Times New Roman",fSize=9
	SetVariable set_DetectorCenter,value= root:PROCESS:DetectorCenterAngle
	SetVariable set_FermiFuncRemoveMode,pos={6,395},size={136,16},bodyWidth=50,title="RemoveFermiFunc?"
	SetVariable set_FermiFuncRemoveMode,font="Times New Roman",fSize=10
	SetVariable set_FermiFuncRemoveMode,limits={0,1,1},value= root:PROCESS:FermiFuncRemoveMode
	SetVariable set_ConERes,pos={7,413},size={185,16},bodyWidth=60,proc=SetVarProc,title="ConvolutionEResolution(meV)"
	SetVariable set_ConERes,font="Times New Roman",fSize=9
	SetVariable set_ConERes,value= root:PROCESS:ConvolutionEResolution
	PopupMenu ProcessedImage_file,pos={208,21},size={192,20},bodyWidth=120,proc=SelectProcessedImage,title="ShowProIMG"
	PopupMenu ProcessedImage_file,font="Times New Roman"
	PopupMenu ProcessedImage_file,mode=1,popvalue="F2t20O450PP0PT340P",value= #"root:PROCESS:ProcessedFileList\t\t"
	PopupMenu ProcessedImageSpectra_file,pos={209,91},size={191,20},bodyWidth=120,proc=ProcessedSpectra,title="Show   EDCs "
	PopupMenu ProcessedImageSpectra_file,font="Times New Roman"
	PopupMenu ProcessedImageSpectra_file,mode=1,popvalue="mF2t16O0PP26T0P",value= #"root:PROCESS:ProcessedFileList\t\t"
	PopupMenu popup_EDCDisplayMode,pos={207,112},size={192,20},bodyWidth=85,proc=EDCDisplayModeSelection,title="EDC Display Mode  "
	PopupMenu popup_EDCDisplayMode,font="Times New Roman"
	PopupMenu popup_EDCDisplayMode,mode=2,popvalue="unEVEN_up",value= #"\"EVEN;unEVEN_up;unEVEN_down;EVENSymmetrized;unEVENSymmetrized_up;unEVENSymmetrized_down\""
	SetVariable set_ProcessedSpectraEnergyStart,pos={212,133},size={101,16},bodyWidth=50,title="EnergyStart"
	SetVariable set_ProcessedSpectraEnergyStart,font="Times New Roman",fSize=10
	SetVariable set_ProcessedSpectraEnergyStart,limits={-inf,inf,0.01},value= root:PROCESS:ProcessedImageEnergyStart
	SetVariable set_ProcessedSpectraEnergyEnd,pos={325,134},size={70,16},bodyWidth=50,title="End"
	SetVariable set_ProcessedSpectraEnergyEnd,font="Times New Roman",fSize=10
	SetVariable set_ProcessedSpectraEnergyEnd,limits={-inf,inf,0.01},value= root:PROCESS:ProcessedImageEnergyEnd
	SetVariable set_ProcessedImageSpectraBind,pos={208,151},size={106,16},bodyWidth=50,title="BindNumber"
	SetVariable set_ProcessedImageSpectraBind,font="Times New Roman",fSize=10
	SetVariable set_ProcessedImageSpectraBind,limits={1,50,1},value= root:PROCESS:SpectraBind
	SetVariable set_ProcessedImageSpectraOffset,pos={320,151},size={76,16},bodyWidth=50,title="Offset"
	SetVariable set_ProcessedImageSpectraOffset,font="Times New Roman",fSize=10
	SetVariable set_ProcessedImageSpectraOffset,value= root:PROCESS:SpectraOffset
	SetVariable set_ShowEDCWay,pos={206,169},size={108,16},bodyWidth=50,title="ShEDCEvery"
	SetVariable set_ShowEDCWay,font="Times New Roman",fSize=10
	SetVariable set_ShowEDCWay,limits={1,10,1},value= root:PROCESS:ShowEDCEveryNumber
	SetVariable set_ErToler,pos={315,168},size={82,16},bodyWidth=50,title="ErmeV"
	SetVariable set_ErToler,font="Times New Roman",fSize=10
	SetVariable set_ErToler,limits={0.05,2,0.05},value= root:PROCESS:ErToler
	SetVariable set_ShowEDCNumberMode,pos={209,187},size={105,16},bodyWidth=30,title="ShowEDC#Mode"
	SetVariable set_ShowEDCNumberMode,font="Times New Roman",fSize=10
	SetVariable set_ShowEDCNumberMode,limits={0,1,1},value= root:PROCESS:ShowEDCNumberMode
	SetVariable set_ShowEDCNoStart,pos={207,205},size={104,16},bodyWidth=50,title="ShEDCStart"
	SetVariable set_ShowEDCNoStart,font="Times New Roman",fSize=10
	SetVariable set_ShowEDCNoStart,limits={0,inf,1},value= root:PROCESS:ShowEDCNoStart
	SetVariable set_ShowEDCNoEnd,pos={324,204},size={70,16},bodyWidth=50,title="End"
	SetVariable set_ShowEDCNoEnd,font="Times New Roman",fSize=10
	SetVariable set_ShowEDCNoEnd,limits={1,inf,1},value= root:PROCESS:ShowEDCNoEnd
	SetVariable set_EDCNamePrefix,pos={207,222},size={150,16},proc=SetVarProc,title="EDC Name Prefix"
	SetVariable set_EDCNamePrefix,font="Times New Roman",fSize=10
	SetVariable set_EDCNamePrefix,value= root:PROCESS:EDCNamePrefix
	PopupMenu EbCorDisImageSpectra_file,pos={206,243},size={194,20},bodyWidth=120,proc=EDCsFromDispersionImage,title="DisIMGEDCs"
	PopupMenu EbCorDisImageSpectra_file,font="Times New Roman"
	PopupMenu EbCorDisImageSpectra_file,mode=1,popvalue="YDmF2t16O0PP26T0P",value= #"root:DispersionIMAGE_EbCorrected:DispersionFileList_EbCorrected\t\t"
	PopupMenu popup_EDCNumberofLorentzian,pos={209,285},size={190,20},bodyWidth=50,proc=NumberofLorentzianSelection_EDC,title="Number of EDC Lorentzians?"
	PopupMenu popup_EDCNumberofLorentzian,font="Times New Roman",fSize=11
	PopupMenu popup_EDCNumberofLorentzian,mode=1,popvalue="?",value= #"\"1;2\""
	SetVariable set_EDCTemperature,pos={205,305},size={104,16},bodyWidth=50,title="Temperature"
	SetVariable set_EDCTemperature,font="Times New Roman",fSize=10
	SetVariable set_EDCTemperature,limits={0,inf,1},value= root:PROCESSEDIMAGESpectra:EDCTemperature
	SetVariable set_EDCBackground,pos={318,306},size={82,16},bodyWidth=50,title="BKGD"
	SetVariable set_EDCBackground,font="Times New Roman",fSize=10
	SetVariable set_EDCBackground,limits={-inf,inf,0.1},value= root:PROCESSEDIMAGESpectra:EDCBackground
	SetVariable set_EDCHeight,pos={223,322},size={86,16},bodyWidth=50,title="Height1"
	SetVariable set_EDCHeight,font="Times New Roman",fSize=10
	SetVariable set_EDCHeight,limits={-inf,inf,0.1},value= root:PROCESSEDIMAGESpectra:EDCHeight
	SetVariable set_EDCHeight1,pos={315,323},size={86,16},bodyWidth=50,title="Height2"
	SetVariable set_EDCHeight1,font="Times New Roman",fSize=10
	SetVariable set_EDCHeight1,limits={-inf,inf,0.1},value= root:PROCESSEDIMAGESpectra:EDC2Height
	SetVariable set_EDCPosition,pos={221,339},size={88,16},bodyWidth=50,title="Position"
	SetVariable set_EDCPosition,font="Times New Roman",fSize=10
	SetVariable set_EDCPosition,limits={-inf,inf,0.1},value= root:PROCESSEDIMAGESpectra:EDCPosition
	SetVariable set_EDCPosition1,pos={307,340},size={93,16},bodyWidth=50,title="Position2"
	SetVariable set_EDCPosition1,font="Times New Roman",fSize=10
	SetVariable set_EDCPosition1,limits={-inf,inf,0.1},value= root:PROCESSEDIMAGESpectra:EDC2Position
	SetVariable set_EDCFWHM,pos={223,356},size={86,16},bodyWidth=50,title="FWHM"
	SetVariable set_EDCFWHM,font="Times New Roman",fSize=10
	SetVariable set_EDCFWHM,limits={-inf,inf,0.1},value= root:PROCESSEDIMAGESpectra:EDCFWHM
	SetVariable set_EDCFWHM1,pos={309,357},size={91,16},bodyWidth=50,title="FWHM2"
	SetVariable set_EDCFWHM1,font="Times New Roman",fSize=10
	SetVariable set_EDCFWHM1,limits={-inf,inf,0.1},value= root:PROCESSEDIMAGESpectra:EDC2FWHM
	SetVariable set_EDCStartingCurve,pos={216,373},size={93,16},bodyWidth=50,title="EDCStart"
	SetVariable set_EDCStartingCurve,font="Times New Roman",fSize=10
	SetVariable set_EDCStartingCurve,limits={0,inf,1},value= root:PROCESSEDIMAGESpectra:EDCCurveStart
	SetVariable set_EDCEndingCurve,pos={315,374},size={85,16},bodyWidth=50,title="End     "
	SetVariable set_EDCEndingCurve,font="Times New Roman",fSize=10
	SetVariable set_EDCEndingCurve,limits={0,inf,1},value= root:PROCESSEDIMAGESpectra:EDCCurveEnd
	PopupMenu DispersionEDC_file,pos={212,391},size={186,20},bodyWidth=120,proc=DispersionFromEDC_VariousPeaks,title="Disper_EDC"
	PopupMenu DispersionEDC_file,font="Times New Roman"
	PopupMenu DispersionEDC_file,mode=6,popvalue="MF1t15O0PP2",value= #"root:DispersionIMAGE:DispersionFileList\t\t"
	PopupMenu BGSubEDC_file,pos={207,419},size={191,20},bodyWidth=120,proc=BackGroundSubtractedEDC,title="BGSub_EDC "
	PopupMenu BGSubEDC_file,font="Times New Roman"
	PopupMenu BGSubEDC_file,mode=6,popvalue="LSCO0P ",value= #"root:PROCESS:ProcessedFileList\t\t"
	PopupMenu BGSubImage_file,pos={206,440},size={192,20},bodyWidth=120,proc=BackGroundSubtractedImage,title="BGSub_IMG "
	PopupMenu BGSubImage_file,font="Times New Roman"
	PopupMenu BGSubImage_file,mode=6,popvalue="LSCO0P ",value= #"root:PROCESS:ProcessedFileList\t\t"
	SetVariable set_BGSubReference,pos={205,462},size={181,18},bodyWidth=50,proc=SetVarProc,title="EDC Index to be Subtracted"
	SetVariable set_BGSubReference,font="Times New Roman",fSize=11
	SetVariable set_BGSubReference,value= root:PROCESS:BGSubCurveNo
	SetVariable set_hv,pos={419,8},size={136,18},bodyWidth=80,title="h\\F'symbol'u\\F'Times' (eV)     "
	SetVariable set_hv,font="Times New Roman",fSize=12
	SetVariable set_hv,limits={-inf,inf,0.1},value= root:PROCESS:PhotonEnergy
	SetVariable set_wfct,pos={415,27},size={141,18},bodyWidth=80,title="Work Func."
	SetVariable set_wfct,font="Times New Roman",fSize=12
	SetVariable set_wfct,limits={-inf,inf,0.1},value= root:PROCESS:WorkFunction
	SetVariable set_LatticeConstant,pos={414,46},size={142,18},bodyWidth=80,proc=SetVarProc,title="L. Cons.(A)"
	SetVariable set_LatticeConstant,font="Times New Roman",fSize=12
	SetVariable set_LatticeConstant,limits={-inf,inf,0.001},value= root:PROCESS:LatticeConstant
	SetVariable set_ThetaOffset,pos={415,71},size={141,16},bodyWidth=80,proc=SetVarProc,title="Offset:Theta   "
	SetVariable set_ThetaOffset,font="Times New Roman",fSize=10
	SetVariable set_ThetaOffset,limits={-inf,inf,0.1},value= root:PROCESS:ThetaOffset
	SetVariable set_PhiOffset,pos={443,88},size={113,16},bodyWidth=80,proc=SetVarProc,title="Phi     "
	SetVariable set_PhiOffset,font="Times New Roman",fSize=10
	SetVariable set_PhiOffset,limits={-inf,inf,0.1},value= root:PROCESS:PhiOffset
	SetVariable set_OmegaOffset,pos={444,105},size={112,16},bodyWidth=80,proc=SetVarProc,title="Omega"
	SetVariable set_OmegaOffset,font="Times New Roman",fSize=10
	SetVariable set_OmegaOffset,limits={-inf,inf,0.1},value= root:PROCESS:OmegaOffset
	SetVariable set_Integrationstart,pos={408,124},size={148,16},bodyWidth=80,proc=SetVarProc,title="EnergyStart(eV)"
	SetVariable set_Integrationstart,font="Times New Roman",fSize=10
	SetVariable set_Integrationstart,limits={-inf,inf,0.01},value= root:PROCESS:IntegrationStart
	SetVariable set_Integrationend,pos={411,141},size={145,16},bodyWidth=80,proc=SetVarProc,title="EnergyEnd(eV)"
	SetVariable set_Integrationend,font="Times New Roman",fSize=10
	SetVariable set_Integrationend,limits={-inf,inf,0.01},value= root:PROCESS:IntegrationEnd
	SetVariable set_ImageName,pos={409,231},size={145,16},bodyWidth=65,proc=SetVarProc,title="Image Name Prefix"
	SetVariable set_ImageName,font="Times New Roman",fSize=10
	SetVariable set_ImageName,value= root:PROCESS:SWImageName
	SetVariable set_KxStart,pos={409,160},size={85,18},bodyWidth=45,proc=SetVarProc,title="KxStart"
	SetVariable set_KxStart,font="Times New Roman",fSize=11
	SetVariable set_KxStart,limits={-inf,inf,0.1},value= root:PROCESS:KxStart
	SetVariable set_KxEnd,pos={496,160},size={67,18},bodyWidth=45,proc=SetVarProc,title="End"
	SetVariable set_KxEnd,font="Times New Roman",fSize=11
	SetVariable set_KxEnd,limits={-inf,inf,0.1},value= root:PROCESS:KxEnd
	SetVariable set_KyStart,pos={410,179},size={85,18},bodyWidth=45,proc=SetVarProc,title="KyStart"
	SetVariable set_KyStart,font="Times New Roman",fSize=11
	SetVariable set_KyStart,limits={-inf,inf,0.1},value= root:PROCESS:KyStart
	SetVariable set_KyEnd,pos={496,179},size={67,18},bodyWidth=45,proc=SetVarProc,title="End"
	SetVariable set_KyEnd,font="Times New Roman",fSize=11
	SetVariable set_KyEnd,limits={-inf,inf,0.1},value= root:PROCESS:KyEnd
	SetVariable set_KxPointNumber,pos={416,198},size={79,18},bodyWidth=45,proc=SetVarProc,title="#ofKx"
	SetVariable set_KxPointNumber,font="Times New Roman",fSize=11
	SetVariable set_KxPointNumber,limits={0,1000,10},value= root:PROCESS:KxPointNumber
	SetVariable set_KyPointNumber,pos={500,198},size={63,18},bodyWidth=45,proc=SetVarProc,title="Ky"
	SetVariable set_KyPointNumber,font="Times New Roman",fSize=11
	SetVariable set_KyPointNumber,limits={0,1000,10},value= root:PROCESS:KyPointNumber
	Button ThirdBZButton,pos={453,413},size={45,22},proc=XJZThirdBZ,title="HexBZ"
	Button ThirdBZButton,font="Times New Roman"
	Button SecondBZButton,pos={404,413},size={50,22},proc=XJZSecondBZ,title="BZLines"
	Button SecondBZButton,font="Times New Roman"
	Button ImageLegend,pos={498,413},size={40,22},proc=XJZLegend,title="Legend"
	Button ImageLegend,font="Times New Roman"
	Button PTOMappingButton,pos={406,383},size={80,24},proc=PTO_FS,title="GetFS"
	Button PTOMappingButton,font="Times New Roman",fSize=16
	Button Trance2,pos={487,383},size={80,24},proc=HYLiuTracePlot,title="Add/RmTrace"
	Button Trance2,font="Times New Roman"
	Button GetDispersionImageButton,pos={575,6},size={120,22},proc=ZWTGetDispersionEkImage,title="Get E-k Image"
	Button GetDispersionImageButton,font="Times New Roman"
	PopupMenu DispersionImagePiA_file,pos={576,31},size={195,20},bodyWidth=140,proc=ShowDispersionImagePiA,title="E\\Bk\\M(N)(\\F'Symbol'p/\\F'Arial'a)"
	PopupMenu DispersionImagePiA_file,font="Times New Roman"
	PopupMenu DispersionImagePiA_file,mode=27,popvalue="NDF3t25O0PP10T2P",value= #"root:PROCESS:DispersionFileList\t\t"
	PopupMenu MDCStack_file,pos={575,106},size={198,20},bodyWidth=140,proc=ZWTShowMDC,title="MDCStack"
	PopupMenu MDCStack_file,font="Times New Roman"
	PopupMenu MDCStack_file,mode=6,popvalue="F2t15O140PP30T0P",value= #"root:Process:EKPiovera"
	SetVariable set_MDCStackSpectraOffset,pos={580,130},size={89,16},bodyWidth=60,title="Offset "
	SetVariable set_MDCStackSpectraOffset,font="Times New Roman",fSize=10
	SetVariable set_MDCStackSpectraOffset,value= root:MDCSpectra:MDCSpectraOffset
	SetVariable set_MDCStackBindNumber,pos={676,130},size={95,16},bodyWidth=60,title="  Bind#"
	SetVariable set_MDCStackBindNumber,font="Times New Roman",fSize=10
	SetVariable set_MDCStackBindNumber,limits={1,inf,1},value= root:MDCSpectra:MDCBindNumber
	SetVariable set_DispersionEnergyStart,pos={577,148},size={92,16},bodyWidth=60,title="EStart "
	SetVariable set_DispersionEnergyStart,font="Times New Roman",fSize=10
	SetVariable set_DispersionEnergyStart,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionEnergyStart
	SetVariable set_DispersionEnergyEnd,pos={679,148},size={92,16},bodyWidth=60,title="    End"
	SetVariable set_DispersionEnergyEnd,font="Times New Roman",fSize=10
	SetVariable set_DispersionEnergyEnd,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionEnergyEnd
	SetVariable set_DispersionMomentumStart,pos={578,166},size={91,16},bodyWidth=60,title="kStart "
	SetVariable set_DispersionMomentumStart,font="Times New Roman",fSize=10
	SetVariable set_DispersionMomentumStart,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionMomentumStart
	SetVariable set_DispersionMomentumEnd,pos={691,166},size={80,16},bodyWidth=60,title="End"
	SetVariable set_DispersionMomentumEnd,font="Times New Roman",fSize=10
	SetVariable set_DispersionMomentumEnd,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionMomentumEnd
	PopupMenu popup_NumberofLorentzian,pos={578,212},size={139,20},bodyWidth=40,proc=NumberofLorentzianSelection,title="Number of Lorentzians?"
	PopupMenu popup_NumberofLorentzian,font="Times New Roman",fSize=10
	PopupMenu popup_NumberofLorentzian,mode=1,popvalue="1",value= #"\"1;2;3;4;5\""
	Button FitAllImage,pos={722,211},size={52,20},proc=FitAllImage_MDC_ZWT,title="Fit All"
	SetVariable set_MDCBackground,pos={580,234},size={92,16},bodyWidth=60,title="BKGD"
	SetVariable set_MDCBackground,font="Times New Roman",fSize=10
	SetVariable set_MDCBackground,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCBackground
	SetVariable set_MDCHeight,pos={677,234},size={97,16},bodyWidth=60,title="Height  "
	SetVariable set_MDCHeight,font="Times New Roman",fSize=10
	SetVariable set_MDCHeight,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCHeight
	SetVariable set_MDCFWHM,pos={577,255},size={96,16},bodyWidth=60,title="FWHM"
	SetVariable set_MDCFWHM,font="Times New Roman",fSize=10
	SetVariable set_MDCFWHM,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCFWHM
	SetVariable set_MDCPosition,pos={676,255},size={98,16},bodyWidth=60,title="Position"
	SetVariable set_MDCPosition,font="Times New Roman",fSize=10
	SetVariable set_MDCPosition,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCPosition
	PopupMenu DispersionMDC_file,pos={577,275},size={197,20},bodyWidth=135,proc=ZWTMDCLorentzFitting,title="MDC_Disp"
	PopupMenu DispersionMDC_file,font="Times New Roman"
	PopupMenu DispersionMDC_file,mode=1,popvalue="F2t20O450PP0PT340P",value= #"root:Process:ALLOriginalImage"
	PopupMenu EDCDispersion2Der_file,pos={580,322},size={188,20},bodyWidth=131,proc=EDCDisperionFrom2DerivativeZWT,title="EDC_2Der"
	PopupMenu EDCDispersion2Der_file,font="Times New Roman"
	PopupMenu EDCDispersion2Der_file,mode=1,popvalue="F4t16O450PP350PT20P",value= #"root:Process:ALLOriginalImage"
	PopupMenu MDCDispersion2Der_file,pos={575,344},size={193,20},bodyWidth=131,proc=MDCDisperionFrom2DerivativeZWT,title="MDC_2Der"
	PopupMenu MDCDispersion2Der_file,font="Times New Roman"
	PopupMenu MDCDispersion2Der_file,mode=27,popvalue="F2t15O140PP30T0P",value= #"root:Process:ALLOriginalImage"
	SetVariable set_SmoothingTimesEDC,pos={576,372},size={120,14},title="SmoothTimes EDC"
	SetVariable set_SmoothingTimesEDC,fSize=10,value= root:PROCESS:EDCSmoothingTimes
	SetVariable set_SmoothingTimesMDC,pos={700,370},size={70,16},title="MDC"
	SetVariable set_SmoothingTimesMDC,font="Times New Roman",fSize=10
	SetVariable set_SmoothingTimesMDC,value= root:PROCESS:MDCSmoothingTimes
	Button CLEAN,pos={407,447},size={87,31},proc=ClearFolder,title="CLEAN FOLDER"
	Button CLEAN,font="Times New Roman",fSize=10
	Button EXIT,pos={498,447},size={60,31},proc=EXITHERSSES2002,title="EXIT"
	Button EXIT,font="Times New Roman",fSize=10
	CheckBox EDC2d,pos={409,218},size={68,14},proc=Checkedc2d,title="\\Z11EDC2ndFS"
	CheckBox EDC2d,font="Times New Roman",variable= root:PROCESS:edc2d
	CheckBox MDC2d,pos={497,217},size={71,14},proc=Checkmdc2d,title="\\Z11MDC2ndFS"
	CheckBox MDC2d,font="Times New Roman",variable= root:PROCESS:mdc2d
	CheckBox GetAllEK,pos={695,12},size={72,16},proc=GetaLLEK,title="\\Z14All Image"
	CheckBox GetAllEK,font="Times New Roman",variable= root:PROCESS:GetALlEKV
	Button Trace,pos={407,277},size={80,20},proc=KxKyImage_Trace_XJZIOP,title="Add Trace"
	Button Trace,font="Times New Roman"
	Button RemoveTrace,pos={487,277},size={80,20},proc=KxKyImage_RemoveTrace_XJZIOP,title="Remove Trace"
	Button RemoveTrace,font="Times New Roman"
	Button SymmetrizeFS,pos={539,413},size={30,22},proc=SyFS_ZWT,title="Sym"
	Button SymmetrizeFS,font="Times New Roman"
	SetVariable InteFactor_V,pos={409,257},size={89,18},bodyWidth=40,title="IntFactor"
	SetVariable InteFactor_V,font="Times New Roman"
	SetVariable InteFactor_V,limits={0,10,1},value= root:PROCESS:InteFactor
	Button KxKyImage_B,pos={502,253},size={65,25},proc=KxKyImage_XJIOP,title="\\Z16GetFS"
	Button KxKyImage_B,font="Times New Roman"
	PopupMenu EKImage_pi,pos={577,52},size={194,20},bodyWidth=140,proc=GetEKImagePiovera_XJZIOP,title="E-K(\\F'Symbol'p/\\F'Arial'a)  "
	PopupMenu EKImage_pi,font="Times New Roman"
	PopupMenu EKImage_pi,mode=1,popvalue="F4t16O450PP350PT20P",value= #"root:Process:EKPiovera"
	PopupMenu EKImage_A,pos={579,73},size={192,20},bodyWidth=140,proc=GetEKImage1overA_XJZIOP,title="E-K(1/A) "
	PopupMenu EKImage_A,font="Times New Roman"
	PopupMenu EKImage_A,mode=1,popvalue="F2t15O140PP30T0P",value= #"root:PROCESS:EK1overA"
	Button get3ddata,pos={511,302},size={57,22},proc=interp2d_image1,title="Get3D"
	Button get3ddata,font="@Arial Unicode MS",fSize=16
	ValDisplay showprogress1,pos={408,324},size={158,17},bodyWidth=158
	ValDisplay showprogress1,font="@Arial Unicode MS",format="%.0f"
	ValDisplay showprogress1,limits={0,100,0},barmisc={0,25},highColor= (0,26112,0)
	ValDisplay showprogress1,value= #"root:PROCESS:showprogress"
	SetVariable nameprestr,pos={407,303},size={102,20},bodyWidth=45,title="\\F'@Arial Unicode MS'NamePre"
	SetVariable nameprestr,value= root:ARToFData:nameprestr
	SetVariable showprogress2,pos={408,342},size={158,20},bodyWidth=60,title="\\F'@Arial Unicode MS'Time Remain  "
	SetVariable showprogress2,font="@Arial Unicode MS",fStyle=1
	SetVariable showprogress2,valueBackColor=(0,43520,65280)
	SetVariable showprogress2,value= root:PROCESS:timeremain
	SetVariable version,pos={55,458},size={86,20},fSize=16,value= _STR:"2012-07-27"
	PopupMenu EDC_Cur,pos={577,392},size={187,20},proc=Curvature_1DEDC,title="EDC_Cur"
	PopupMenu EDC_Cur,mode=1,popvalue="F4t16O450PP350PT20P",value= #"root:Process:ALLOriginalImage"
	PopupMenu MDC_Cur,pos={576,413},size={187,20},proc=Curvature_1DMDC,title="MDC_Cur"
	PopupMenu MDC_Cur,mode=1,popvalue="F4t16O450PP350PT20P",value= #"root:Process:ALLOriginalImage"
	PopupMenu TwoD_Cur,pos={582,435},size={181,20},proc=Curvature_2D,title="2D_Cur"
	PopupMenu TwoD_Cur,mode=1,popvalue="F4t16O450PP350PT20P",value= #"root:Process:ALLOriginalImage"
	SetVariable BindE_cur,pos={577,460},size={62,16},title="BindE"
	SetVariable BindE_cur,limits={1,inf,1},value= root:PROCESS:CurBindE
	SetVariable BindK_cur,pos={642,460},size={62,16},title="BindK"
	SetVariable BindK_cur,value= root:PROCESS:CurBindK
	SetVariable i_Cur,pos={708,460},size={65,16},title="i"
	SetVariable i_Cur,limits={0,inf,0.001},value= root:PROCESS:CurBindi0
	SetVariable set_MDCStackBindNumber1,pos={203,66},size={64,16},bodyWidth=29,title="  Bind#"
	SetVariable set_MDCStackBindNumber1,font="Times New Roman",fSize=10
	SetVariable set_MDCStackBindNumber1,limits={1,inf,1},value= root:PROCESS:bindnumber_MDC
	SetVariable set_DispersionEnergyEnd1,pos={272,66},size={58,16},bodyWidth=48,title="E"
	SetVariable set_DispersionEnergyEnd1,font="Times New Roman",fSize=10
	SetVariable set_DispersionEnergyEnd1,limits={-inf,inf,0.1},value= root:PROCESS:MDC_EE
	Button FitMDC,pos={336,65},size={53,18},proc=FitMoreLorentzian_MDC,title="FitMDC"
	PopupMenu ProcessedImage_file1,pos={204,42},size={196,20},bodyWidth=120,proc=show_MDC,title="ShowProMDC"
	PopupMenu ProcessedImage_file1,font="Times New Roman"
	PopupMenu ProcessedImage_file1,mode=1,popvalue="F2t20O450PP0PT340P",value= #"root:PROCESS:ProcessedFileList\t\t"
EndMacro

//Add by ZWT, 20091231
proc GetallEK(CtrlName,Checked):CheckBoxControl
	String CtrlName
	Variable Checked
	setdatafolder root:PROCESS
	CheckBox GetAllEK,disable=1
	CheckBox GetAllEK,Disable=0
	if(GetallEKV==0)
 		EKPiOvera=WaveList("*",";","DIMS:2")
 		EK1Overa=WaveList("*",";","DIMS:2")
 		DispersionFileList=WaveList("*",";","DIMS:2")
 		//setdatafolder root:DispersionIMAGE
 		//Killwaves/A/Z
 		//setdatafolder root:EKImage_Interpolated:one_over_A
 		//KillWaves/A/Z
 		//Setdatafolder root:EKImage_Interpolated:Pi_over_a
 		//KillWaves/A/Z
 	else
 		EKPiOvera=""
 		EK1Overa=""
 		DispersionFileList=""
	endif
	
end

///ZWTend


//This is conbined for SES200

Proc ARPES_Analysis_SES200()
//-----------------


        DoWindow/K Load_Data_SES200
        DoWindow/K HERS_ARPES_Analysis_Panel
        
               
	DoWindow/F HERS_ARPES_Analysis_SES200
	if (V_flag==0)
	
//	       NewDataFolder/O/S root:OriginalData
//	       String/G OriginalFileList=WaveList("A*",";","DIMS:2")
//	       Variable/G NoofOriginalFile=ItemsinList(OriginalFileList,";")
//	       String/G Original1DFileList=WaveList("A*",";","DIMS:1")
//	       Variable/G Noof1DOriginalFile=ItemsinList(Original1DFileList,";")
 

		NewDataFolder/O/S root:PROCESS

		Variable/G  CropStart=NumVarOrDefault("root:PROCESS:CropStart",5), CropEnd=NumVarOrDefault("root:PROCESS:CropEnd",24)
		Variable/G  EnergyStart=NumVarOrDefault("root:PROCESS:EnergyStart",50), EnergyEnd=NumVarOrDefault("root:PROCESS:EnergyEnd",50)
		Variable/G  NorYStart=NumVarOrDefault("root:PROCESS:NorYStart",50), NorYEnd=NumVarOrDefault("root:PROCESS:NorYEnd",50)
		
		Variable/G NorYFlag=NumVarOrDefault("root:PROCESS:NorYFlag",1)
		
		Variable/G  ZeroFermi=NumVarOrDefault("root:PROCESS:ZeroFermi",50), FermiCorrection=NumVarOrDefault("root:PROCESS:FermiCorrection",50)
		Variable/G TempFermiCorrection2D, TempTemperature2D
		Variable/G  ThetaAngle=NumVarOrDefault("root:PROCESS:ThetaAngle",0.0)
                 Variable/G PhiAngle=NumVarOrDefault("root:PROCESS:PhiAngle",0.0)
                 String/G     NewNamePrefix=StrVarOrDefault("root:PROCESS:NewNamePrefix","")
                Variable/G ProcessedImageFlag=NumVarOrDefault("root:PROCESS:ProcessedImageFlag",0.0)
                Variable/G ProIMGDisplayMode=NumVarOrDefault("root:PROCESS:ProIMGDisplayMode",0)                
                Variable/G EDCDisplayMode=NumVarOrDefault("root:PROCESS:EDCDisplayMode",0)              
                Variable/G SpectraOffset=NumVarOrDefault("root:PROCESS:SpectraOffset",0.0)
                Variable/G SpectraBind=NumVarOrDefault("root:PROCESS:SpectraBind",1)
                Variable/G ProcessedImageEnergyStart=NumVarOrDefault("root:PROCESS:ProcessedImageEnergyStart",-1) 
                Variable/G ProcessedImageEnergyEnd=NumVarOrDefault("root:PROCESS:ProcessedImageEnergyEnd",0.1)
                Variable/G BGSubCurveNo=NumVarOrDefault("root:PROCESS:BGSubCurveNo",1)  
		        Variable/G  PhotonEnergy=NumVarOrDefault("root:PROCESS:PhotonEnergy",21.2)
	            Variable/G  WorkFunction=NumVarOrDefault("root:PROCESS:WorkFunction",4.3)                     
                Variable/G LatticeConstant=NumVarOrDefault("root:PROCESS:LatticeConstant",3.8)
                Variable/G ThetaOffset=NumVarOrDefault("root:PROCESS:ThetaOffset",0.0), PhiOffset=NumVarOrDefault("root:PROCESS:PhiOffset",0.0)
                Variable/G RotationAngle=NumVarOrDefault("root:PROCESS:RotationAngle",0.0)
                Variable/G KxOffset=NumVarOrDefault("root:PROCESS:KxOffset",0.0), KyOffset=NumVarOrDefault("root:PROCESS:KyOffset",0.0)
                Variable/G ThetaStart=NumVarOrDefault("root:PROCESS:ThetaStart",-18), ThetaEnd=NumVarOrDefault("root:PROCESS:ThetaEnd",25)
                Variable/G IntegrationStart=NumVarOrDefault("root:PROCESS:IntegrationStart",-0.03), IntegrationEnd=NumVarOrDefault("root:PROCESS:IntegrationEnd",0.03)
                String/G SWImageName=StrVarOrDefault("root:PROCESS:SWImageName","SW")
                String/G ProcessedFileList=WaveList("*F*P*T*",";","DIMS:2")
                String/G ProcessedFileList, ProcessedFilNam,ProcessedNum
                Variable/G KxStart=NumVarOrDefault("root:PROCESS:KxStart",-1), KxEnd=NumVarOrDefault("root:PROCESS:KxEnd",1)
                Variable/G KyStart=NumVarOrDefault("root:PROCESS:KyStart",-1), KyEnd=NumVarOrDefault("root:PROCESS:KyEnd",1)
                Variable/G KxPointNumber=NumVarOrDefault("root:PROCESS:KxPointNumber",100)
                Variable/G KyPointNumber=NumVarOrDefault("root:PROCESS:KyPointNumber",100)
                Variable/G LegendHigh=NumVarOrDefault("root:PROCESS:LegendHigh",1)
                Variable/G LegendLow=NumVarOrDefault("root:PROCESS:LegendLow",0)
                Variable/G DispersionImageFlag=NumVarOrDefault("root:PROCESS:DispersionImageFlag",0.0)
                Variable/G SmoothingTimes=NumVarOrDefault("root:PROCESS:SmoothingTimes",100)
                
                
                	NewDataFolder/O/S root:FermiLevelFromAu
                	
		Variable/G CorrectionFlag=NumVarOrDefault("root:FermiLevelFromAu:CorrectionFlag",1), CorrectionFlag=1
                
                
                

		NewDataFolder/O/S root:PROCESSEDIMAGESpectra
		
		NewDataFolder/O/S root:BackGroundSubtractedSpectra
		
		NewDataFolder/O/S root:BackGroundSubtractedImage
				
		NewDataFolder/O/S root:IMG
		String/G NName
		String/G imgnam, imgfldr, imgproc, imgproc_undo, exportn
		make/o/n=(10,10) image0, image, image_undo
		make/o/n=10 profileH, profileH_x, profileV, profileV_y
		Make/O HairY0={0,0,0,NaN,Inf,0,-Inf}
		Make/O HairX0={-Inf,0,Inf,NaN,0,0,0}
		variable/G nx, ny, center, width
		variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0, dmin, dmax
		variable/G numpass=1			//# of filter passes
		variable/G gammaa=1
		make/o/n=256 pmap=p
		
		NewDataFolder/O/S root:DispersionIMAGE
		String/G DispersionFileList
		
		NewDataFolder/O/S root:DispersionIMAGE_1overA		
		String/G DispersionFileList_1OA	
		
		
	    NewDataFolder/O/S root:MDCSpectra
	    Variable/G MDCSpectraOffset=NumVarOrDefault("root:MDCSpectra:MDCSpectraOffset",0.0)
	    Variable/G MDCBindNumber=NumVarOrDefault("root:MDCSpectra:MDCBindNumber",0.0)	       
		Variable/G DispersionEnergyStart= NumVarOrDefault("root:MDCSpectra:DispersionEnergyStart",0.0)
		Variable/G DispersionEnergyEnd= NumVarOrDefault("root:MDCSpectra:DispersionEnergyEnd",0.0)
		Variable/G DispersionMomentumStart= NumVarOrDefault("root:MDCSpectra:DispersionMomentumStart",0.0)
		Variable/G DispersionMomentumEnd= NumVarOrDefault("root:MDCSpectra:DispersionMomentumEnd",0.0)
		Variable/G MDCBackground= NumVarOrDefault("root:MDCSpectra:MDCBackground",0.0)
		Variable/G MDCHeight= NumVarOrDefault("root:MDCSpectra:MDCHeight",0.0)			
		Variable/G MDCFWHM= NumVarOrDefault("root:MDCSpectra:MDCFWHM",0.0)			
		Variable/G MDCPosition= NumVarOrDefault("root:MDCSpectra:MDCPosition",0.0)
		Variable/G MDC2Height= NumVarOrDefault("root:MDCSpectra:MDC2Height",0.0)			
		Variable/G MDC2FWHM= NumVarOrDefault("root:MDCSpectra:MDC2FWHM",0.0)			
		Variable/G MDC2Position= NumVarOrDefault("root:MDCSpectra:MDC2Position",0.0)
		Variable/G MDC3Height= NumVarOrDefault("root:MDCSpectra:MDC3Height",0.0)			
		Variable/G MDC3FWHM= NumVarOrDefault("root:MDCSpectra:MDC3FWHM",0.0)			
		Variable/G MDC3Position= NumVarOrDefault("root:MDCSpectra:MDC3Position",0.0)		
		Variable/G MDCCurveStart= NumVarOrDefault("root:MDCSpectra:MDCCurveStart",0.0)		
		Variable/G MDCCurveEnd= NumVarOrDefault("root:MDCSpectra:MDCCurveEnd",0.0)
		Variable/G NumberofLorentzianPeaks
		String/G ThetaAngleForMDCPlot	
		String/G TempMDCName
		
		NewDataFolder/O/S root:DispersionFrom2ndDerivative
		
		NewDataFolder/O/S root:ThreeDImages
		
		NewDataFolder/O/S root:MDCFittedParameters
		
		NewDataFolder/O/S root:MDCFitPara_Zerokand1overA	
			
		SetDataFolder root:
		
		HERS_ARPES_Analysis_SES200()

	endif
End




Window HERS_ARPES_Analysis_SES200() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(155,108,1075,535)
	ModifyPanel cbRGB=(65535,65535,65535)
//	SetDrawLayer UserBack
//	DrawText 76,20,"Data Folder"
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 11,48,257,228                              //Load Data one by one and infos
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 11,233,257,343                             //Load Data and show	
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 11,348,257,400                         //Make Data Tables
//	SetDrawEnv fillfgc= (48896,49152,65280)
//	DrawRRect 10,175,235,208                           //Photon Energy and Work function
	SetDrawEnv fillfgc=(40960,65280,16384)
	DrawRRect 270,3,499,183                              //Process Image 
	SetDrawEnv fillfgc=(40960,65280,16384)
	DrawRRect 270,186,499,335                          //Processed Images and Spectra
	SetDrawEnv fillfgc=(0,43520,65280)
	DrawRRect 270,345,499,420                        //Background Subtracted Images and Spectra
	SetDrawEnv fillfgc=(65280,0,0)
	DrawRRect 508,27,703,52                        //Photon Energy and work function	
	SetDrawEnv fillfgc=(40960,65280,16384)
	DrawRRect 508,57,703,262                        //Spectral Weight Image Parameters
	SetDrawEnv fillfgc=(65280,0,26112)
	DrawRRect 508,263,703,355                        //Spectral Weight Image
        SetDrawEnv fillfgc= (65280,2048,33792)
	DrawRRect 507,358,704,386                       //3D Images	
	SetDrawEnv fillfgc= (0,65280,33024)
	DrawRRect 708,18,917,97                              //Energy-Momentum Image	
	SetDrawEnv fillfgc= (0,65280,33024)
	DrawRRect 708,101,917,188                            //MDC Stack
        SetDrawEnv fillfgc= (32768,65280,65280)
	DrawRRect 708,211,917,336                          //Dispersion from MDC
        SetDrawEnv fillfgc= (32768,65280,65280)
	DrawRRect 708,345,917,393                          //Dispersion from 2nd Derivative
	
	
	Button buttonSetLib,pos={10,1},size={120,18},proc=SelectFolderHERS,title="Set Data Folder"
	SetVariable setlib,pos={10,21},size={245,14},title=" ",fSize=9
	SetVariable setlib,limits={-Inf,Inf,1},value= root:HERS:filpath
	
	PopupMenu popup_file,pos={10,54},size={140,19},proc=SelectFileHERS,title="File"
	PopupMenu popup_file,mode=6,popvalue="2041729_2A.spc",value= #"root:HERS:fileList\t\t"
	Button FileUpdate,pos={192,55},size={60,25},proc=SelectFolderHERS,title="Update"

	ValDisplay val_Nreg,pos={17,88},size={70,14},title="# region",fSize=10
	ValDisplay val_Nreg,limits={0,0,0},barmisc={0,1000},value= #"root:HERS:nregion"

	SetVariable val_region,pos={94,88},size={90,14},title=" ",fSize=10
	SetVariable val_region,limits={-Inf,Inf,1},value= root:HERS:rgnnam
	
        ValDisplay val_Nloop,pos={189,88},size={68,14},title="# loop",fSize=10
	ValDisplay val_Nloop,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_Nloop,value= #"root:HERS:nloop[0]"
	
	ValDisplay val_Ep,pos={17,108},size={43,14},title="Ep",fSize=10
	ValDisplay val_Ep,limits={0,0,0},barmisc={0,1000},value= #"root:HERS:Epass[0]"
	
        SetVariable val_kind,pos={74,108},size={48,14},title=" ",fSize=10
	SetVariable val_kind,limits={-Inf,Inf,1},value= root:HERS:skind0	
	
	SetVariable val_mode,pos={138,108},size={46,14},title=" ",fSize=10
	SetVariable val_mode,limits={-Inf,Inf,1},value= root:HERS:smode0	
	
	ValDisplay val_Enpts,pos={189,108},size={68,14},title="# pts",fSize=10
	ValDisplay val_Enpts,limits={0,0,0},barmisc={0,1000}	
	
	ValDisplay val_Estart,pos={16,128},size={70,14},title="Ei",fSize=10
	ValDisplay val_Estart,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_Estart,value= #"root:HERS:Estart[0]"
	ValDisplay val_Eend,pos={100,128},size={70,14},title="Ef",fSize=10
	ValDisplay val_Eend,limits={0,0,0},barmisc={0,1000},value= #"root:HERS:Eend[0]"
	ValDisplay val_Estep,pos={185,128},size={70,14},title="Einc",fSize=10
	ValDisplay val_Estep,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_Estep,value= #"root:HERS:Estep[0]"

	ValDisplay val_Enpts,value= #"root:HERS:Enpts[0]"
	ValDisplay val_Dwell,pos={33,148},size={80,14},title="Dwell",fSize=10
	ValDisplay val_Dwell,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_Dwell,value= #"root:HERS:Dwell[0]"
	ValDisplay val_Nsweep,pos={135,148},size={80,14},title="# Sweep",fSize=10
	ValDisplay val_Nsweep,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_Nsweep,value= #"root:HERS:Nsweep[0]"
	
	ValDisplay val_Astart,pos={16,175},size={70,14},title="Ai",fSize=10
	ValDisplay val_Astart,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_Astart,value= #"root:HERS:Astart[0]"
	ValDisplay val_Aend,pos={100,175},size={70,14},title="Af",fSize=10
	ValDisplay val_Aend,limits={0,0,0},barmisc={0,1000},value= #"root:HERS:Aend[0]"
	ValDisplay val_Astep,pos={185,175},size={70,14},title="Ainc",fSize=10
	ValDisplay val_Astep,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_Astep,value= #"root:HERS:Astep[0]"

	Button StepMinus,pos={30,197},size={25,25},proc=StepFileSES,title="<<"
	Button StepPlus,pos={65,197},size={25,25},proc=StepFileSES,title=">>"
	Button PlotButton1,pos={102,197},size={65,25},proc=PlotSES,title="Display"
	Button PlotButton2,pos={185,197},size={65,25},proc=PlotSES,title="Append"
	
	Button LoadAllButton,pos={30,237},size={90,20},proc=LoadAll,title="LoadALLFiles"
	Button LoadAllUPDATE,pos={30,257},size={90,20},proc=LoadAll,title="UPDATE"	
	ValDisplay val_TotalNumOriginalFiles,pos={130,237},size={115,14},title="Total#ofFiles",fSize=10
	ValDisplay val_TotalNumOriginalFiles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_TotalNumOriginalFiles,value= #"root:SES:numfiles"

	
	ValDisplay val_2DNumOriginalFiles,pos={130,251},size={50,14},title="#2D",fSize=10
	ValDisplay val_2DNumOriginalFiles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_2DNumOriginalFiles,value= #"root:OriginalData:NoofOriginalFile"
	
	ValDisplay val_1DNumOriginalFiles,pos={195,251},size={50,14},title="#1D",fSize=10
	ValDisplay val_1DNumOriginalFiles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_1DNumOriginalFiles,value= #"root:OriginalData:Noof1DOriginalFile"

	
	PopupMenu OriginalImage_file,pos={35,280},size={200,10}, proc=SelectOriginalImage,title="Original2DImage"
	PopupMenu OriginalImage_file,mode=6,popvalue="A06042000 ",value= #"root:OriginalData:OriginalFileList\t\t" 
	
	PopupMenu Original1DFile_file,pos={35,316},size={200,10}, proc=SelectOriginal1DFile,title="Original 1D File   "
	PopupMenu Original1DFile_file,mode=6,popvalue="A06042000 ",value= #"root:OriginalData:Original1DFileList\t\t" 	

	SetDrawEnv fillfgc= (65495,2134,34028)
	Button SetParameterButton pos={16,352},size={235,20},proc=SetParameter,title="Set Experimental Parameter:1D and 2D"

	SetDrawEnv fillfgc= (65495,2134,34028)
	Button SetParameter1DButton pos={21,377},size={100,20},proc=SetParameter1D,title="Set 1D Only"
	
	SetDrawEnv fillfgc= (65495,2134,34028)
	Button SetParameter2DButton pos={140,377},size={100,20},proc=SetParameter2D,title="Set 2D Only"	

        Button Data,pos={70,404},size={160,20},title="Data Analysis Alone",proc=DataAnalysisAlone
//        Button Alalysis,pos={125,363},size={60,29},title="Analysis",proc=DataAnalysis         
	
//       SetDrawLayer UserBack
//       DrawText 125,330,"Data Analysis"
//       SetDrawEnv fillfgc= (65495,2134,34028)  		

//        Button Data,pos={125,338},size={70,20},title="DA Alone",proc=DataAnalysisAlone
//        Button Alalysis,pos={125,370},size={70,20},title="Combined",proc=DataAnalysisCombined                
	
//        Button EXIT,pos={218,335},size={40,58},title="EXIT",proc=EXITLoadSES200        
	

      
	
	SetDrawLayer UserBack
	DrawText 340,18,"Processing Image"
//	SetDrawLayer UserBack
//	DrawText 250,30,"Crop Image"
	SetDrawEnv fillfgc= (65495,2134,34028)
	SetVariable set_CropStart,proc=SetVarProc,pos={275,20},size={123,25},title="Angle  Start",fSize=10
	SetVariable set_CropStart,limits={-20,10,0.1},value=root:PROCESS:cropstart
	SetVariable set_CropEnd,proc=SetVarProc,pos={412,20},size={82,25},title="End",fSize=10
	SetVariable set_CropEnd,limits={0,30,0.1},value= root:PROCESS:cropend
	SetVariable set_EnergyStart,proc=SetVarProc,pos={275,35},size={123,25},title="EnergyStart",fSize=10
	SetVariable set_EnergyStart,limits={-inf,inf,0.1},value=root:PROCESS:energystart
	SetVariable set_EnergyEnd,pos={412,35},size={82,25},title="End",fSize=10
	SetVariable set_EnergyEnd,limits={-inf,inf,0.1},value= root:PROCESS:energyend
	SetVariable set_NorYStart,proc=SetVarProc,pos={275,52},size={123,25},title="NorY  Start ",fSize=10
	SetVariable set_NorYStart,limits={-inf,inf,0.1},value=root:PROCESS:norystart
	SetVariable set_NorYEnd,proc=SetVarProc,pos={412,52},size={82,25},title="End",fSize=10
	SetVariable set_NorYEnd,limits={-inf,inf,0.1},value=root:PROCESS:noryend
	
		
	PopupMenu popup_NorYMode,pos={275,75},size={130,10},proc=NorYModeSelection,title="NorY Mode"
	PopupMenu popup_NorYMode,mode=1,popvalue="No",value= #"\"No;E Range;Smoothing Line\""
	
	PopupMenu popup_FermiCorrection,pos={268,70},size={60,25},proc=FermiLevelShiftCorrection,title="Correct Ef_A Variation?"
	PopupMenu popup_FermiCorrection,mode=1,popvalue="NO",value= #"\"YES;NO\""
	SetVariable set_ZeroFermi,proc=SetVarProc,pos={275,95},size={115,25},title="Au E(F)",fSize=10
	SetVariable set_ZeroFermi,limits={-inf,inf,0.001},value=root:PROCESS:zerofermi
	SetVariable set_FermiCorrection,proc=SetVarProc,pos={404,95},size={89,25},title="Shift",fSize=10
	SetVariable set_FermiCorrection,limits={-inf,inf,0.001},value=root:PROCESS:FermiCorrection	
	SetVariable set_Newname,proc=SetVarProc,pos={275,115},size={187,25},title="Image Name Prefix",fSize=10
	SetVariable set_Newname, value= root:PROCESS:NewNamePrefix
 	SetVariable set_ProcessedImageFlag,pos={311,135},size={160,25},title="ProcessImageFlag ",fSize=10
	SetVariable set_ProcessedImageFlag,limits={0,10,1},value= root:PROCESS:ProcessedImageFlag
	
       Button ProcessButton pos={319,154},size={125,25},proc=XJZProcess,title="Process Image",fsize=10
        
	PopupMenu ProcessedImage_file,pos={275,192},size={180,10}, proc=SelectProcessedImage,title="ProIMG"
	PopupMenu ProcessedImage_file,mode=6,popvalue="LSCO0P ",value= #"root:PROCESS:ProcessedFileList\t\t" 
	PopupMenu popup_ProIMGDisplayMode,pos={275,225},size={130,10},proc=ProIMGDisplayModeSelection,title="IMG Display Mode"
	PopupMenu popup_ProIMGDisplayMode,mode=1,popvalue="Normal",value= #"\"Normal;Rotate 90\""
	
	PopupMenu ProcessedImageSpectra_file,pos={275,246},size={180,10}, proc=ProcessedSpectra,title="EDCs   "
	PopupMenu ProcessedImageSpectra_file,mode=6,popvalue="LSCO0P ",value= #"root:PROCESS:ProcessedFileList\t\t" 
	PopupMenu popup_EDCDisplayMode,pos={275,270},size={130,10},proc=EDCDisplayModeSelection,title="EDC Display Mode"
	PopupMenu popup_EDCDisplayMode,mode=1,popvalue="Even",value= #"\"EVEN;unEVEN_up;unEVEN_down;EVENSymmetrized;unEVENSymmetrized_up;unEVENSymmetrized_down\""


	SetVariable set_ProcessedImageSpectraOffset,pos={280,295},size={85,25},title="Offset ",fSize=10
	SetVariable set_ProcessedImageSpectraOffset,limits={-inf,inf,1},value= root:PROCESS:SpectraOffset  
	SetVariable set_ProcessedImageSpectraBind,pos={373,295},size={118,25},title="Bind Number",fSize=10
	SetVariable set_ProcessedImageSpectraBind,limits={1,150,1},value= root:PROCESS:SpectraBind 
	
	SetVariable set_ProcessedSpectraEnergyStart,pos={280,313},size={123,25},title="EnergyStart",fSize=10
	SetVariable set_ProcessedSpectraEnergyStart,limits={-10,inf,0.01},value= root:PROCESS:ProcessedImageEnergyStart   
	
	SetVariable set_ProcessedSpectraEnergyEnd,pos={410,313},size={81,25},title="End",fSize=10
	SetVariable set_ProcessedSpectraEnergyEnd,limits={-10,inf,0.01},value= root:PROCESS:ProcessedImageEnergyEnd
	
	PopupMenu BGSubEDC_file,pos={275,350},size={155,10}, proc=BackGroundSubtractedEDC,title="BGSub_EDC"
	PopupMenu BGSubEDC_file,mode=6,popvalue="LSCO0P ",value= #"root:PROCESS:ProcessedFileList\t\t" 
	
	PopupMenu BGSubImage_file,pos={275,370},size={155,10}, proc=BackGroundSubtractedImage,title="BGSub_IMG "
	PopupMenu BGSubImage_file,mode=6,popvalue="LSCO0P ",value= #"root:PROCESS:ProcessedFileList\t\t" 
	
	SetVariable set_BGSubReference,proc=SetVarProc,pos={280,395},size={200,25},title="EDC # to be Subtracted",fSize=10
	SetVariable set_BGSubReference, value= root:PROCESS:BGSubCurveNo
	
	
       
        
//  SetDrawLayer UserBack
//	DrawText 500,15,"Spectral Weight Integration"
//	SetDrawEnv fillfgc= (65495,2134,34028)
 
       Button ThetaPhiPlotButton pos={560,4},size={115,20},proc=XJZThetaPhi,title="Theta-Phi Image"
       SetVariable set_hv,pos={513,31},size={70,19},title="hv",fSize=11
       SetVariable set_hv,limits={-Inf,Inf,0.1},value= root:Process:PhotonEnergy
       SetVariable set_wfct,pos={591,31},size={110,19},title="Workfunc",fSize=11
       SetVariable set_wfct,limits={-Inf,Inf,0.1},value= root:Process:WorkFunction      
       SetVariable set_LatticeConstant,proc=SetVarProc,pos={513,60},size={189,20},title="Lattice Constant   (A) ",fSize=10
       SetVariable set_LatticeConstant,limits={-inf,inf,0.01},value= root:PROCESS:LatticeConstant

       SetVariable set_RotationAngle,proc=SetVarProc,pos={512,110},size={189,20},title="Rotation Angle (Deg)",fSize=10
       SetVariable set_RotationAngle,limits={-inf,inf,0.1},value= root:PROCESS:RotationAngle      
       
       SetVariable set_ThetaOffset,proc=SetVarProc,pos={512,80},size={180,20},title="Offset:Theta",fSize=10
       SetVariable set_ThetaOffset,limits={-inf,inf,0.1},value= root:PROCESS:ThetaOffset
       SetVariable set_PhiOffset,proc=SetVarProc,pos={565,120},size={127,20},title="Phi",fSize=10
       SetVariable set_PhiOffset,limits={-inf,inf,0.1},value= root:PROCESS:PhiOffset   

       SetVariable set_KxOffset,proc=SetVarProc,pos={512,140},size={108,20},title="Kx Offset",fSize=10
       SetVariable set_KxOffset,limits={-inf,inf,0.01},value= root:PROCESS:KxOffset
       SetVariable set_KyOffset,proc=SetVarProc,pos={625,140},size={75,20},title="Ky",fSize=10
       SetVariable set_KyOffset,limits={-inf,inf,0.01},value= root:PROCESS:KyOffset
       SetVariable set_ThetaStart,proc=SetVarProc,pos={512,161},size={180,20},title="Theta Start (Deg)",fSize=10
       SetVariable set_ThetaStart,limits={-inf,inf,0.1},value= root:PROCESS:ThetaStart
       SetVariable set_ThetaEnd,proc=SetVarProc,pos={512,179},size={180,20},title="              End (Deg)",fSize=10
       SetVariable set_ThetaEnd,limits={-inf,inf,0.1},value= root:PROCESS:ThetaEnd
       SetVariable set_Integrationstart,proc=SetVarProc,pos={512,201},size={180,20},title="IntEnergy Start (eV)",fSize=10
       SetVariable set_Integrationstart,limits={-inf,inf,0.01},value= root:PROCESS:IntegrationStart
       SetVariable set_Integrationend,proc=SetVarProc,pos={512,219},size={180,20},title= "                     End (eV)",fSize=10
       SetVariable set_Integrationend,limits={-inf,inf,0.01},value= root:PROCESS:IntegrationEnd
       SetVariable set_ImageName,proc=SetVarProc,pos={512,240},size={180,20},title="Image Name Prefix",fSize=10
       SetVariable set_ImageName,limits={-inf,inf,1},value= root:PROCESS:SWImageName
       
       Button ContourPlotButton pos={512,267},size={85,20},proc=XJZKyKxContour,title="Ky-Kx Contour"
       Button ImagePlotButton pos={605,266},size={50,24},proc=XJZKyKx,title="IMAGE"
       Button TracePlotButton pos={660,267},size={40,20},proc=XJZTracePlot,title="Trace"
      SetVariable set_KxStart,proc=SetVarProc,pos={512,292},size={116,20},title="KxStart(Pi/a)",fSize=10
      SetVariable set_KxStart,limits={-inf,inf,0.1},value= root:PROCESS:KxStart
      SetVariable set_KxEnd,proc=SetVarProc,pos={630,292},size={70,20},title="End",fSize=10
      SetVariable set_KxEnd,limits={-inf,inf,0.1},value= root:PROCESS:KxEnd
     
      SetVariable set_KyStart,proc=SetVarProc,pos={512,312},size={116,20},title="KyStart(Pi/a)",fSize=10
      SetVariable set_KyStart,limits={-inf,inf,0.1},value= root:PROCESS:KyStart
      SetVariable set_KyEnd,proc=SetVarProc,pos={630,312},size={70,20},title="End",fSize=10
      SetVariable set_KyEnd,limits={-inf,inf,0.1},value= root:PROCESS:KyEnd  
        
      SetVariable set_KxPointNumber,proc=SetVarProc,pos={512,332},size={116,20},title="#ofPointsKx",fSize=10
      SetVariable set_KxPointNumber,limits={0,1000,10},value= root:PROCESS:KxPointNumber
      SetVariable set_KyPointNumber,proc=SetVarProc,pos={630,332},size={70,20},title="Ky  ",fSize=10
      SetVariable set_KyPointNumber,limits={0,1000,10},value= root:PROCESS:KyPointNumber
      
      Button Make3DButtonEThetaPhi pos={512,360},size={100,24},proc=XJZ3DEThetaPhi,title="3D:E-Theta-Phi",fsize=15
      Button Make3DButtonEKxKy        pos={616,360},size={85,24},proc=XJZ3DEKxKy,title="3D:E-Kx-Ky",fsize=15           
 
      SetDrawLayer UserBack
      DrawText 525,402,"BZLines"   
      
      Button FirstBZButton pos={512,402},size={33,20},proc=XJZ1stBZ,title="1st"
      Button SecondBZButton pos={552,402},size={33,20},proc=XJZSecondBZ,title="2nd"
      
      Button ImageLegend pos={598,389},size={35,36},proc=XJZLegend,title="LGD"
      SetVariable set_LegendHigh,proc=SetVarProc,pos={635,389},size={70,20},title="High",fSize=10
      SetVariable set_LegendHigh,limits={0,1000,0.1},value= root:PROCESS:LegendHigh
      SetVariable set_LegendLow,proc=SetVarProc,pos={635,408},size={70,20},title="Low ",fSize=10
      SetVariable set_LegendLow,limits={0,1000,0.1},value= root:PROCESS:LegendLow
      
      
      
      SetDrawLayer UserBack
      DrawText 755,17,"Dispersion from MDC"
      SetDrawEnv fillfgc= (65495,2134,34028)
      
      Button GetDispersionImageButton pos={735,21},size={165,22},proc=XJZGetDispersionEkImage,title="Get Dispersion E-k Image"   
      
//      SetVariable set_DispersionImageFlag,pos={711,44},size={133,25},title="DispersionFlag",fSize=10
//      SetVariable set_DispersionImageFlag,limits={-inf,inf,1},value= root:PROCESS:DispersionImageFlag
           
      PopupMenu DispersionImagePiA_file,pos={705,44},size={180,10}, proc=ShowDispersionImagePiA,title="E-k (pi/a) "
      PopupMenu DispersionImagePiA_file,mode=6,popvalue="Dis060400 ",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 

      PopupMenu DispersionImage1OA_file,pos={705,70},size={180,10}, proc=ShowDispersionImage1OA,title="E-k (1/A) "
      PopupMenu DispersionImage1OA_file,mode=6,popvalue="Dis060400 ",value= #"root:DispersionIMAGE_1overA:DispersionFileList_1OA\t\t"      
      

      PopupMenu MDCStack_file,pos={705,103},size={180,10}, proc=XJZMDCStack_WithBind,title="MDCStack"
      PopupMenu MDCStack_file,mode=6,popvalue="Dis060400 ",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 
      
      SetVariable set_MDCStackSpectraOffset,pos={715,129},size={85,25},title="Offset ",fSize=10
      SetVariable set_MDCStackSpectraOffset,limits={-inf,inf,1},value= root:MDCSpectra:MDCSpectraOffset 
      
      SetVariable set_MDCStackBindNumber,pos={816,129},size={90,25},title="    Bind#",fSize=10
      SetVariable set_MDCStackBindNumber,limits={1,inf,1},value= root:MDCSpectra:MDCBindNumber      
      
      SetVariable set_DispersionEnergyStart,pos={715,146},size={85,25},title="EStart ",fSize=10
      SetVariable set_DispersionEnergyStart,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionEnergyStart  
      SetVariable set_DispersionEnergyEnd,pos={816,146},size={90,25},title="       End",fSize=10
      SetVariable set_DispersionEnergyEnd,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionEnergyEnd  
      
      SetVariable set_DispersionMomentumStart,pos={715,166},size={85,25},title="kStart ",fSize=10
      SetVariable set_DispersionMomentumStart,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionMomentumStart  
      SetVariable set_DispersionMomentumEnd,pos={816,166},size={90,25},title="       End",fSize=10
      SetVariable set_DispersionMomentumEnd,limits={-inf,inf,0.1},value= root:MDCSpectra:DispersionMomentumEnd 
      
      SetDrawLayer UserBack
      DrawText 725,210,"Fitting Initialization Parameters"
      SetDrawEnv fillfgc= (65495,2134,34028)    
 
 	  PopupMenu popup_NumberofLorentzian,pos={720,211},size={100,20},proc=NumberofLorentzianSelection,title="Number of Lorentzians?",fSize=10
	  PopupMenu popup_NumberofLorentzian,mode=1,popvalue="1",value= #"\"1;2;3;4;5\""

      SetVariable set_MDCBackground,pos={715,237},size={85,25},title="BKGD",fSize=10
      SetVariable set_MDCBackground,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCBackground
      SetVariable set_MDCHeight,pos={813,237},size={93,25},title="  Height",fSize=10
      SetVariable set_MDCHeight,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCHeight 
      SetVariable set_MDCFWHM,pos={715,255},size={85,25},title="FWHM",fSize=10
      SetVariable set_MDCFWHM,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCFWHM
      SetVariable set_MDCPosition,pos={813,255},size={93,25},title="Position",fSize=10
      SetVariable set_MDCPosition,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCPosition

      SetVariable set_StartingCurve,pos={715,286},size={102,25},title="MDCStart",fSize=10
      SetVariable set_StartingCurve,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCCurveStart    
      SetVariable set_EndingCurve,pos={822,286},size={82,25},title="End ",fSize=10
      SetVariable set_EndingCurve,limits={-inf,inf,0.1},value= root:MDCSpectra:MDCCurveEnd
       
      PopupMenu DispersionMDC_file,pos={705,308},size={170,8}, proc=DispersionFromMDC_VariousPeaks,title="DispersionMDC"
      PopupMenu DispersionMDC_file,mode=6,popvalue="Dis060400 ",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 
      
      PopupMenu Dispersion2Der_file,pos={704,347},size={170,10}, proc=DisperionFrom2Derivative,title="Dis2Derivative"
      PopupMenu Dispersion2Der_file,mode=6,popvalue="Dis060400 ",value= #"root:DispersionIMAGE:DispersionFileList\t\t" 
      
      SetVariable set_SmoothingTimes,pos={715,371},size={170,25},title="Smoothing Times",fSize=10
      SetVariable set_SmoothingTimes,limits={-inf,inf,1},value= root:PROCESS:SmoothingTimes     
    
      Button CLEAN,pos={712,395},size={115,25},title="CLEAN FOLDER",proc=ClearFolder
      Button EXIT,pos={840,395},size={75,25},title="EXIT",proc=EXITHERSSES200      
      
EndMacro







Function EXITHERSAnalysis(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
        DoWindow/K HERS_ARPES_Analysis_Panel
	
	SetDataFolder Curr
	
End




Function EXITHERSSES2002(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	 ClearFolder(ctrlName) 
        DoWindow/K ARPES_Analysis
	
	SetDataFolder Curr
	
End



Function EXITHERSSES200(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
        DoWindow/K HERS_ARPES_Analysis_SES200
	
	SetDataFolder Curr
	
End
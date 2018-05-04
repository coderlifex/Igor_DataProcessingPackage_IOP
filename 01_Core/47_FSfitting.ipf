#pragma rtGlobals=1		// Use modern global access method. 

Proc FitFSPanel( )   
    newdatafolder/o root:FSfitting
    setdatafolder root:FSfitting
    variable/G numberofIntegrationMDCpeaks,IntegrationMDCBackground,IntegrationMDCHeight1,IntegrationMDCFWHM1,IntegrationMDCPeakPosition1
    variable/G IntegrationMDCHeight2,IntegrationMDCFWHM2,IntegrationMDCPeakPosition2,IntegrationMDCHeight3,IntegrationMDCFWHM3,IntegrationMDCPeakPosition3 
    variable/G FSfitting_startnumber,FSfitting_endnumber,MDCoffset,EDCstartnumber,EDCendnumber,EDCenergystart,EDCenergyend,EDCoffset,delta0
    variable/G fittingway,inte_start_forfitting,inte_end_forfitting,typeofgap,EDCfitBackground,EDCfitHeight,EDCfitdelta,EDCfitgamma1,EDCfitgamma0
	
	
	 DoWindow/F  FS_MDCIntegration_Fit_Panel
	 if (V_flag==0)
	 
	 Fermi_surface_fitting_panel() 
       
     Endif
        
End

Window Fermi_surface_fitting_panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel/K=1/W=(1024,140,1650,747)
	//ShowTools/A
	SetDrawLayer UserBack
	SetDrawEnv linefgc= (44032,29440,58880)
	SetDrawEnv save
	SetDrawEnv fillpat= 3,textrgb= (32768,54528,65280)
	SetDrawEnv save
	SetDrawEnv fillpat= -1
	SetDrawEnv save
	SetDrawEnv linefgc= (65280,32768,58880),fillpat= 1,fillfgc= (44032,29440,58880)
	SetDrawEnv save
	SetDrawEnv fillfgc= (48896,52992,65280)
	SetDrawEnv save
	SetDrawEnv linefgc= (32768,40704,65280),fillfgc= (65280,48896,48896)
	SetDrawEnv save
	SetDrawEnv fillfgc= (57344,65280,48896)
	SetDrawEnv save
	SetDrawEnv fillfgc= (65280,54528,48896)
	DrawRect 4,57,623,309
	SetDrawEnv fillfgc= (65280,65280,48896)
	SetDrawEnv save
	SetDrawEnv fillfgc= (51456,44032,58880)
	DrawRRect 3,1,623,54
	DrawRRect 4,311,623,433
	SetDrawEnv fillfgc= (48896,52992,65280)
	DrawRRect 3,547,623,603
	SetDrawEnv fillfgc= (49152,65280,32768)
	DrawRRect 3,435,621,544
	SetDrawEnv linefgc= (0,0,0),fillfgc= (65495,2134,34028),fname= "Times New Roman",fsize= 18,textrgb= (0,0,0)
	DrawText 181,81,"Maximum intensity fitting on FS"
	SetDrawEnv linefgc= (0,0,0),fillfgc= (65495,2134,34028),fname= "Times New Roman",fsize= 18,textrgb= (0,0,0)
	DrawText 142,460,"Fit EDC at Kf use a phenomenology method"
	SetVariable numberofIntegrationMDCpeaks,pos={6,212},size={170,18},title="number of peaks:"
	SetVariable numberofIntegrationMDCpeaks,fSize=15
	SetVariable numberofIntegrationMDCpeaks,limits={-inf,inf,0.1},value= root:FSfitting:numberofIntegrationMDCpeaks
	SetVariable IntegrationMDCHeight1,pos={7,238},size={170,18},title="Height1  "
	SetVariable IntegrationMDCHeight1,fSize=15
	SetVariable IntegrationMDCHeight1,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCHeight1
	SetVariable IntegrationMDCFWHM1,pos={6,262},size={170,18},title="FWHM1 "
	SetVariable IntegrationMDCFWHM1,fSize=15
	SetVariable IntegrationMDCFWHM1,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCFWHM1
	SetVariable IntegrationMDCPeakPosition1,pos={7,286},size={170,18},title="Position1"
	SetVariable IntegrationMDCPeakPosition1,fSize=15
	SetVariable IntegrationMDCPeakPosition1,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCPeakPosition1
	SetVariable IntegrationMDCHeight2,pos={219,237},size={170,18},title="Height2  "
	SetVariable IntegrationMDCHeight2,fSize=15
	SetVariable IntegrationMDCHeight2,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCHeight2
	SetVariable IntegrationMDCFWHM2,pos={220,262},size={170,18},title="FWHM2 "
	SetVariable IntegrationMDCFWHM2,fSize=15
	SetVariable IntegrationMDCFWHM2,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCFWHM2
	SetVariable IntegrationMDCPeakPosition2,pos={220,285},size={170,18},title="Position2"
	SetVariable IntegrationMDCPeakPosition2,fSize=15
	SetVariable IntegrationMDCPeakPosition2,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCPeakPosition2
	SetVariable IntegrationMDCHeight3,pos={444,235},size={170,18},title="Height3  "
	SetVariable IntegrationMDCHeight3,fSize=15
	SetVariable IntegrationMDCHeight3,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCHeight3
	SetVariable IntegrationMDCFWHM3,pos={444,259},size={170,18},title="FWHM3 "
	SetVariable IntegrationMDCFWHM3,fSize=15
	SetVariable IntegrationMDCFWHM3,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCFWHM3
	SetVariable IntegrationMDCPeakPosition3,pos={444,284},size={170,18},title="Position3"
	SetVariable IntegrationMDCPeakPosition3,fSize=15
	SetVariable IntegrationMDCPeakPosition3,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCPeakPosition3
	SetVariable set_MDCBackground,pos={218,210},size={248,18},title="IntegrationMDCBackground"
	SetVariable set_MDCBackground,fSize=15
	SetVariable set_MDCBackground,limits={-inf,inf,0.1},value= root:FSfitting:IntegrationMDCBackground
	Button Fit,pos={500,200},size={114,29},proc=FS_MDCIntegration_Fit,title="Fit"
	Button Fit,fSize=20
	Button showMDC,pos={392,127},size={220,27},proc=FS_fitting,title="Show MDCWaves for fitting"
	Button showMDC,fSize=15,fStyle=0
	SetVariable startcutnumber,pos={6,132},size={180,18},title="Start Cut Number"
	SetVariable startcutnumber,fSize=15
	SetVariable startcutnumber,limits={-inf,inf,0.1},value= root:FSfitting:FSfitting_startnumber
	SetVariable endcutnumber,pos={203,131},size={180,18},title="End  Cut  Number"
	SetVariable endcutnumber,fSize=15
	SetVariable endcutnumber,limits={-inf,inf,0.1},value= root:FSfitting:FSfitting_endnumber
	PopupMenu chosethewaytofit,pos={8,170},size={307,20},bodyWidth=200,proc=chose_fittingway,title="Chose Fitting Way"
	PopupMenu chosethewaytofit,mode=1,popvalue="Fit the MDC at Ef only",value= #"\"Fit the MDC at Ef only;Fit IntegrationMDC\""
	Button SetOveralltable,pos={41,16},size={149,25},proc=Set_Overall_table,title="Set Overall table"
	Button showEDCatKf,pos={40,403},size={132,25},proc=show_EDCs_atKf,title="Show EDCs at Kf"
	SetVariable offset,pos={80,100},size={110,18},title="OffSet",fSize=15
	SetVariable offset,limits={-inf,inf,0.1},value= root:FSfitting:MDCoffset
	SetVariable offset1,pos={437,351},size={110,18},title="OffSet",fSize=15
	SetVariable offset1,limits={-inf,inf,0.1},value= root:FSfitting:EDCoffset
	Button SymmEDCs,pos={259,403},size={100,25},proc=show_symmEDCs_atKf,title="Show Symm EDCs"
	SetVariable endnumber,pos={10,370},size={180,18},title="end  cut  number"
	SetVariable endnumber,fSize=15
	SetVariable endnumber,limits={-inf,inf,0.1},value= root:FSfitting:EDCendnumber
	SetVariable startnumber,pos={9,337},size={180,18},title="start cut number"
	SetVariable startnumber,fSize=15
	SetVariable startnumber,limits={-inf,inf,0.1},value= root:FSfitting:EDCstartnumber
	SetVariable energyend,pos={203,370},size={200,18},title="Energy   End(ev)"
	SetVariable energyend,fSize=15
	SetVariable energyend,limits={-inf,inf,0.1},value= root:FSfitting:EDCenergyend
	SetVariable energystart,pos={203,337},size={200,18},title="Energy Start(ev)"
	SetVariable energystart,fSize=15
	SetVariable energystart,limits={-inf,inf,0.1},value= root:FSfitting:EDCenergystart
	Button showyourchosenEf,pos={276,17},size={173,25},proc=show_your_chosen_Ef_onFS,title="Show your chosen Ef on FS"
	Button showMDCsatEf,pos={233,96},size={125,24},proc=show_MDCs_at_Ef,title="Show MDCs at Ef"
	Button showgapvsPHIpipi,pos={184,562},size={189,27},proc=show_gap_VS_phifrompipi,title="Show Gap VS Phi from PiPi"
	Button ShowgapvsDwave,pos={408,561},size={180,27},proc=show_gap_VS_Dwave,title="Show Gap VS Dwave"
	SetVariable intestart,pos={319,170},size={170,18},title="Inte_start(ev)"
	SetVariable intestart,fSize=15
	SetVariable intestart,limits={-inf,inf,0.1},value= root:FSfitting:inte_start_forfitting
	SetVariable inteend,pos={494,169},size={122,18},title="end(ev)",fSize=15
	SetVariable inteend,limits={-inf,inf,0.1},value= root:FSfitting:inte_end_forfitting
	SetVariable delta0,pos={27,566},size={110,18},title="Delta0",fSize=15
	SetVariable delta0,limits={-inf,inf,0.1},value= root:FSfitting:delta0
	PopupMenu thetypeofgap,pos={26,474},size={251,20},bodyWidth=120,proc=chosetypeofgap,title="Chose the type of gap"
	PopupMenu thetypeofgap,mode=1,popvalue="normal gap",value= #"\"normal gap;pseudogap\""
	SetVariable delta,pos={150,514},size={150,18},title="Delta(ev)",fSize=15
	SetVariable delta,limits={-inf,inf,0.1},value= root:FSfitting:EDCfitdelta
	SetVariable Gamma1,pos={310,514},size={150,18},title="Gamma1(ev)",fSize=15
	SetVariable Gamma1,limits={-inf,inf,0.1},value= root:FSfitting:EDCfitgamma1
	SetVariable Gamma0,pos={467,514},size={150,18},title="Gamma0(ev)",fSize=15
	SetVariable Gamma0,limits={-inf,inf,0.1},value= root:FSfitting:EDCfitgamma0
	Button Fit1,pos={494,469},size={114,29},proc=fit_use_a_phenomenology_method,title="Fit"
	Button Fit1,fSize=20
	SetVariable height,pos={17,514},size={120,18},title="Height",fSize=15
	SetVariable height,limits={-inf,inf,0.1},value= root:FSfitting:EDCfitHeight
	SetVariable background,pos={304,474},size={150,18},title="Background",fSize=15
	SetVariable background,limits={-inf,inf,0.1},value= root:FSfitting:EDCfitBackground
EndMacro



Proc chose_fittingway(ctrlName,popNum,popStr) : PopupMenuControl
     String ctrlName
	 Variable popNum
	 String popStr
	 setdatafolder root:FSfitting
	 variable/G fittingway
	 if(cmpstr(popStr,"Fit the MDC at Ef only")==0)
	 fittingway=0
	 endif
	 
     if(cmpstr(popStr,"Fit IntegrationMDC")==0)
     fittingway=1
     endif
    
   
END



proc show_MDCs_at_Ef(ctrlName) : ButtonControl 
   String ctrlName
   setdatafolder root:FSfitting
   PauseUpdate;Silent 1
   
   Variable show_MDC_PhotonE=root:PROCESS:PhotonEnergy
   Variable show_MDC_WorkFunc=root:Process:WorkFunction
   Variable show_MDC_LC=root:PROCESS:LatticeConstant
   Variable show_MDC_K0=0.5118*show_MDC_LC/3.1416*Sqrt(show_MDC_PhotonE-show_MDC_WorkFunc)
   Variable show_Phioffset=root:process:PhiOffset
    
   variable numberofProcessedImage=dimsize(ProcessedImage,0)
   variable kk=FSfitting_startnumber
   Dowindow/k show_MDCs_at_Ef 
   Dowindow show_MDCs_at_Ef
   display as "show_MDCs_at_Ef"
   Do
     duplicate/o root:process:$ProcessedImage[kk], temp_ProcessedImage
     make/o/n=(dimsize(temp_ProcessedImage,1))  show_MDCintensity,show_MDCk,show_MDC_AngleY
     show_MDCintensity=temp_ProcessedImage[(0-dimoffset(temp_ProcessedImage,0))/dimdelta(temp_ProcessedImage,0)][p]
     print (0-dimoffset(temp_ProcessedImage,0))/dimdelta(temp_ProcessedImage,0)
     show_MDC_AngleY=dimoffset(temp_ProcessedImage,1)+dimdelta(temp_ProcessedImage,1)*x
     show_MDCk=show_MDC_K0*sin((Phi[kk]-show_MDC_AngleY-show_Phioffset)*pi/180)
     duplicate/o show_MDCintensity $ProcessedImage[kk]+"_mdc"
     $ProcessedImage[kk]+"_mdc"+=(kk-FSfitting_startnumber)*MDCoffset
     
     appendtograph $ProcessedImage[kk]+"_mdc" vs show_MDCk
     
     kk+=1
   while(kk<FSfitting_endnumber+1)
     ModifyGraph mirror=2
     ModifyGraph axThick=2
     Label bottom "\\Z16K//"
     Label left "\\Z16intensity"
   dowindow/c  show_MDCs_at_Ef
   end



Proc FS_fitting(ctrlName) : ButtonControl 
   String ctrlName
   SetDataFolder  root:PROCESS
   String ProcessedFSfittingfileList= WaveList("!*_CT",";","DIMS:2"),FSfitting_prostring
   //print ProcessedFSfittingfileList
   variable ProcessedFSfittinglimit=ItemsInList(ProcessedFSfittingfileList, ";")
   setdatafolder root:FSfitting
   variable FSfitting_pronumber
   String/G Tempname

   FSfitting_pronumber=FSfitting_startnumber
   setdatafolder root:FSfitting
 
   IF( root:FSfitting:fittingway==1)
   Dowindow/k showMDCforfitting
   Dowindow showMDCforfitting 
   display as "show_MDC_for_fitting"
   DO
   SetDataFolder  root:PROCESS
   FSfitting_prostring=stringfromlist(FSfitting_pronumber,ProcessedFSfittingfileList,";")
   //print FSfitting_prostring
   duplicate/o $FSfitting_prostring,root:FSfitting:tempimage
   setdatafolder root:FSfitting
   PauseUpdate;Silent 1
   make/O/N=(dimsize(tempimage,1)) IntegrationMDC,AngleY
   AngleY=Dimdelta(TempImage,1)*x+Dimoffset(TempImage,1)
  // print AngleY
   SetScale/P x Dimoffset(TempImage,1),Dimdelta(TempImage,1), "" IntegrationMDC
   IntegrationMDC=XJZAREA2D(tempimage,inte_start_forfitting,inte_end_forfitting,x)
   Tempname="Inte_"+FSfitting_prostring
   duplicate/o root:FSfitting:IntegrationMDC,$Tempname
   appendtograph $Tempname vs AngleY
   if (FSfitting_pronumber==FSfitting_startnumber)
   ModifyGraph lsize=5,rgb=(4352,4352,4352)
   endif
   FSfitting_pronumber+=1
   WHILE(FSfitting_pronumber<min(FSfitting_endnumber+1,ProcessedFSfittinglimit))
   setdatafolder root:FSfitting
   Dowindow/c showMDCforfitting
 ENDIF
 
 
   IF(root:FSfitting:fittingway==0)
   Dowindow/k showMDCforfitting
   Dowindow showMDCforfitting 
   display as "show_MDC_for_fitting"
   DO
   SetDataFolder  root:PROCESS
   
   FSfitting_prostring=stringfromlist(FSfitting_pronumber,ProcessedFSfittingfileList,";")
   //print FSfitting_prostring
   duplicate/o $FSfitting_prostring,root:FSfitting:tempimage
   setdatafolder root:FSfitting
   PauseUpdate;Silent 1
   make/O/N=(dimsize(tempimage,1)) MDCatEf,AngleY
   //print Dimdelta(TempImage,1)
   AngleY=Dimdelta(TempImage,1)*x+Dimoffset(TempImage,1)
  // print AngleY
   MDCatEf=tempimage[(0-dimoffset(tempimage,0))/dimdelta(tempimage,0)][p]
   Tempname="MDCEf_"+FSfitting_prostring
   duplicate/o root:FSfitting:MDCatEf,$Tempname
   appendtograph $Tempname vs AngleY
   if (FSfitting_pronumber==FSfitting_startnumber)
   ModifyGraph lsize=5,rgb=(4352,4352,4352)
   endif
   FSfitting_pronumber+=1
   WHILE(FSfitting_pronumber<min(FSfitting_endnumber+1,ProcessedFSfittinglimit))
   setdatafolder root:FSfitting
   Dowindow/c showMDCforfitting
 
 ENDIF

 End
 
 
   
  Proc FS_MDCIntegration_Fit(ctrlName) : ButtonControl 
    String ctrlName
	String Curr=GetDataFolder(1) 
	PauseUpdate;Silent 1
    String MDCList
	Variable w0,w1,w2,w3,w4,w5, w6, w7, w8, w9, w10
	
   
    MDCList=TraceNameList("", ";",1)
    Variable MDCNum=ItemsInlist(MDCList)
   // PRINT  MDCNum,MDCList
    make/O/N=(MDCNum)  PhiforCut,ThetaforCut,OmegaforCut 
    
	   w0=root:FSfitting:IntegrationMDCBackground
       w1=root:FSfitting:IntegrationMDCHeight1
       w2=root:FSfitting:IntegrationMDCFWHM1
       w3=root:FSfitting:IntegrationMDCPeakPosition1	
       w4=1
       w5=root:FSfitting:IntegrationMDCHeight2
       w6=root:FSfitting:IntegrationMDCFWHM2
       w7=root:FSfitting:IntegrationMDCPeakPosition2	
       w8=root:FSfitting:IntegrationMDCHeight3
       w9=root:FSfitting:IntegrationMDCFWHM3
       w10=root:FSfitting:IntegrationMDCPeakPosition3	
       Make/O co_OnePeak={w0, w1, w2,w3,w4}
       Make/O co_TwoPeak={w0, w1, w2,w3,w4,w5,w6,w7}     
       Make/O co_ThreePeak={w0, w1, w2,w3,w4,w5,w6,w7,w8,w9,w10}   
       Redimension/D co_OnePeak;DelayUpdate
       Redimension/D co_TwoPeak;DelayUpdate
       Redimension/D co_ThreePeak;DelayUpdate
         
       
	
	Variable jj,ii
	Make/O/N=(MDCNum) Background=0, Height1=0, FWHM1=0, FWHMError1=0,Position1=0, PositionError1=0
	Make/O/N=(MDCNum) Height2=0, FWHM2=0, FWHMError2=0, Position2=0, PositionError2=0
    Make/O/N=(MDCNum) Height3=0, FWHM3=0, FWHMError3=0, Position3=0, PositionError3=0

	jj=0
	DO
	Tempname=StringFromList(jj,MDCList,";")
	
	 IF(numberofIntegrationMDCpeaks==1)	    

		FuncFit/N=1/Q=1 XJLorentzianFit_OnePeak co_OnePeak $Tempname /D /X= AngleY	
		
            Background[jj]=co_OnePeak[0]
	        Height1[jj]=co_OnePeak[1]
	        FWHM1[jj]=co_OnePeak[2]
	        Position1[jj]=co_OnePeak[3]
	        FWHMError1[jj]=W_sigma[2]
	        PositionError1[jj]=W_sigma[3]
	       // print Position1[jj]
	       // print (AngleY[1]-AngleY[0]),(Position1[jj]-AngleY[0]),round ((Position1[jj]-AngleY[0])/(AngleY[1]-AngleY[0]))
	        
	        numberoftheEDCatKf[FSfitting_startnumber+jj]=round ((Position1[jj]-AngleY[0])/(AngleY[1]-AngleY[0]))
	     
	        ENDIF
	        
	        
	       IF(numberofIntegrationMDCpeaks==2)	
	       
		FuncFit/N=1/Q=1 XJLorentzianFit_TwoPeak co_TwoPeak $Tempname /D /X= AngleY	
		
		
            Background[jj]=co_TwoPeak[0]
	        Height1[jj]=co_TwoPeak[1]
	        FWHM1[jj]=co_TwoPeak[2]
	        Position1[jj]=co_TwoPeak[3]
            Height2[jj]=co_TwoPeak[5]
	        FWHM2[jj]=co_TwoPeak[6]
	        Position2[jj]=co_TwoPeak[7]	        
                
	        FWHMError1[jj]=W_sigma[2]
	        PositionError1[jj]=W_sigma[3]
	        FWHMError2[jj]=W_sigma[6]
	        PositionError2[jj]=W_sigma[7]               
	        ENDIF	
	        
	        
	    IF(numberofIntegrationMDCpeaks==3)	

	    FuncFit/N=1/Q=1 XJLorentzianFit_ThreePeak co_ThreePeak $Tempname /D /X= AngleY	
		
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
           
                
            FWHMError1[jj]=W_sigma[2]
	        PositionError1[jj]=W_sigma[3]
	        FWHMError2[jj]=W_sigma[6]
	        PositionError2[jj]=W_sigma[7]    
            FWHMError3[jj]=W_sigma[9]
	        PositionError3[jj]=W_sigma[10]               
           ENDIF
                
      ii=0
      do
      if(cmpstr(Tempname,"Inte_"+root:OriginalData:ProcessedImage[ii])==0 ||cmpstr(Tempname,"MDCEf_"+root:OriginalData:ProcessedImage[ii])==0)
      PhiforCut[jj]=root:OriginalData:Phi_Angle[ii]
      ThetaforCut[jj]=root:OriginalData:Theta_Angle[ii]
      OmegaforCut[jj]=root:OriginalData:Omega_Angle[ii]
      endif
      ii+=1
      while(ii<numpnts(root:OriginalData:ProcessedImage))
      
            jj+=1
		
	WHILE(jj<MDCNum)
    
  
  
  Variable FSfitting_PhotonE=root:PROCESS:PhotonEnergy
  Variable FSfitting_WorkFunc=root:Process:WorkFunction
  Variable FSfitting_LC=root:PROCESS:LatticeConstant
  Variable FSfitting_K0=0.5118*FSfitting_LC/3.1416*Sqrt(FSfitting_PhotonE-FSfitting_WorkFunc)
  
  
  IF(numberofIntegrationMDCpeaks==1)
  make/o/n=(dimsize(Position1,0)) FSfitting_phiwave,FSfitting_thetawave,FSfitting_omegawave,FSfitting_Ky,FSfitting_Kx,FSfitting_RKy,FSfitting_RKx
  //print Position1
  FSfitting_phiwave=-Position1(x)
  FSfitting_phiwave+=PhiforCut(x)
  FSfitting_thetawave=ThetaforCut(x)
  FSfitting_omegawave=OmegaforCut(x)
  
 
  FSfitting_phiwave-=root:PROCESS:PhiOffset
  FSfitting_omegawave-=root:PROCESS:OmegaOffset
  FSfitting_thetawave-=root:PROCESS:ThetaOffset
 
  
 // print FSfitting_phiwave
 // print FSfitting_omegawave
  //print FSfitting_thetawave
  
  FSfitting_Ky=FSfitting_K0*sin(3.1416/180*FSfitting_thetawave)*cos(3.1416/180*FSfitting_phiwave)
  FSfitting_Kx=FSfitting_K0*sin(3.1416/180*FSfitting_phiwave)  
  FSfitting_RKy=sqrt(FSfitting_Ky*FSfitting_Ky+FSfitting_Kx*FSfitting_Kx)*sin((atan2(FSfitting_Ky,FSfitting_Kx))+FSfitting_omegawave*3.1416/180) 
  FSfitting_RKx=sqrt(FSfitting_Ky*FSfitting_Ky+FSfitting_Kx*FSfitting_Kx)*cos((atan2(FSfitting_Ky,FSfitting_Kx))+FSfitting_omegawave*3.1416/180)  
  
  ENDIF
  
  IF(numberofIntegrationMDCpeaks==2)
  make/o/n=(dimsize(Position1,0)+dimsize(Position2,0)) FSfitting_phiwave,FSfitting_thetawave,FSfitting_omegawave,FSfitting_Ky,FSfitting_Kx,FSfitting_RKy,FSfitting_RKx
  FSfitting_phiwave[0,(dimsize(Position1,0)-1)]=-Position1(x)
  FSfitting_phiwave[0,(dimsize(Position1,0)-1)]+=PhiforCut(x)  
  FSfitting_phiwave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]=-Position2(p-(dimsize(Position1,0)))
  FSfitting_phiwave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]+=PhiforCut(p-(dimsize(Position1,0)))
  
  FSfitting_thetawave[0,(dimsize(Position1,0)-1)]=ThetaforCut(x)
  FSfitting_thetawave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]=ThetaforCut(p-(dimsize(Position1,0)))
  
  FSfitting_omegawave[0,(dimsize(Position1,0)-1)]=OmegaforCut(x)
  FSfitting_omegawave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]=OmegaforCut(p-(dimsize(Position1,0)))
  
  FSfitting_phiwave-=root:PROCESS:PhiOffset
  FSfitting_omegawave-=root:PROCESS:OmegaOffset
  FSfitting_thetawave-=root:PROCESS:ThetaOffset
  
  FSfitting_Ky=FSfitting_K0*sin(3.1416/180*FSfitting_thetawave)*cos(3.1416/180*FSfitting_phiwave)
  FSfitting_Kx=FSfitting_K0*sin(3.1416/180*FSfitting_phiwave)  
  FSfitting_RKy=sqrt(FSfitting_Ky*FSfitting_Ky+FSfitting_Kx*FSfitting_Kx)*sin((atan2(FSfitting_Ky,FSfitting_Kx))+FSfitting_omegawave*3.1416/180) 
  FSfitting_RKx=sqrt(FSfitting_Ky*FSfitting_Ky+FSfitting_Kx*FSfitting_Kx)*cos((atan2(FSfitting_Ky,FSfitting_Kx))+FSfitting_omegawave*3.1416/180)   
  
  ENDIF  
  
  
  IF(numberofIntegrationMDCpeaks==3)
  make/o/n=(dimsize(Position1,0)+dimsize(Position2,0)+dimsize(Position3,0)) FSfitting_phiwave,FSfitting_thetawave,FSfitting_omegawave,FSfitting_Ky,FSfitting_Kx,FSfitting_RKy,FSfitting_RKx
  FSfitting_phiwave[0,(dimsize(Position1,0)-1)]=-Position1(x)
  FSfitting_phiwave[0,(dimsize(Position1,0)-1)]+=PhiforCut(x)  
  FSfitting_phiwave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]=-Position2(p-(dimsize(Position1,0)))
  FSfitting_phiwave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]+=PhiforCut(p-(dimsize(Position1,0)))
  FSfitting_phiwave[dimsize(Position1,0)+dimsize(Position2,0),(dimsize(Position1,0)+dimsize(Position2,0)+dimsize(Position3,0)-1)]=-Position3(p-(dimsize(Position1,0)+dimsize(Position2,0)))
  FSfitting_phiwave[dimsize(Position1,0)+dimsize(Position2,0),(dimsize(Position1,0)+dimsize(Position2,0)+dimsize(Position3,0)-1)]+=PhiforCut(p-(dimsize(Position1,0)+dimsize(Position2,0)))
  
  FSfitting_thetawave[0,(dimsize(Position1,0)-1)]=ThetaforCut(x)
  FSfitting_thetawave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]=ThetaforCut(p-(dimsize(Position1,0)))
  FSfitting_thetawave[dimsize(Position1,0)+dimsize(Position2,0),(dimsize(Position1,0)+dimsize(Position2,0)+dimsize(Position3,0)-1)]=ThetaforCut(p-(dimsize(Position1,0)+dimsize(Position2,0)))
  
  FSfitting_omegawave[0,(dimsize(Position1,0)-1)]=OmegaforCut(x)
  FSfitting_omegawave[dimsize(Position1,0),(dimsize(Position1,0)+dimsize(Position2,0)-1)]=OmegaforCut(p-(dimsize(Position1,0)))
  FSfitting_omegawave[dimsize(Position1,0)+dimsize(Position2,0),(dimsize(Position1,0)+dimsize(Position2,0)+dimsize(Position3,0)-1)]=OmegaforCut(p-(dimsize(Position1,0)+dimsize(Position2,0)))

  FSfitting_phiwave-=root:PROCESS:PhiOffset
  FSfitting_omegawave-=root:PROCESS:OmegaOffset
  FSfitting_thetawave-=root:PROCESS:ThetaOffset
  
  FSfitting_Ky=FSfitting_K0*sin(3.1416/180*FSfitting_thetawave)*cos(3.1416/180*FSfitting_phiwave)
  FSfitting_Kx=FSfitting_K0*sin(3.1416/180*FSfitting_phiwave)  
  FSfitting_RKy=sqrt(FSfitting_Ky*FSfitting_Ky+FSfitting_Kx*FSfitting_Kx)*sin((atan2(FSfitting_Ky,FSfitting_Kx))+FSfitting_omegawave*3.1416/180) 
  FSfitting_RKx=sqrt(FSfitting_Ky*FSfitting_Ky+FSfitting_Kx*FSfitting_Kx)*cos((atan2(FSfitting_Ky,FSfitting_Kx))+FSfitting_omegawave*3.1416/180)     
  
  ENDIF
  
 AppendToGraph FSfitting_Ky vs FSfitting_RKx
 ModifyGraph mode=3,marker=8,mrkThick=2 
   
  SetDataFolder Curr 
 end
  
  
Proc Set_Overall_table(ctrlName) : ButtonControl 
   String ctrlName
   setdatafolder root:process 
   variable i=0
   String ImageFile
   variable/G limitofProcessedFileList=ItemsInList(ProcessedFileList, ";")
   print limitofProcessedFileList
   If(limitofProcessedFileList>0)
   make/o/t/n=(limitofProcessedFileList) ProcessedImage
   
   do 
     ImageFile=StringFromList(i,ProcessedFileList,";")
     ProcessedImage[i]=ImageFile
     i=i+1
    while(i<limitofProcessedFileList)
    
   duplicate/o ProcessedImage, root:FSfitting:ProcessedImage
   KillWaves/Z ProcessedImage
   setdatafolder root:FSfitting
   variable/G limitofProcessedList=root:process:limitofProcessedFileList
   make/o/t/n=(limitofProcessedList)   ExperimentalNote
   make/o/n=(limitofProcessedList)   Theta,Phi,Omega,gap,numberoftheEDCatKf
   //setdatafolder root:OriginalData 
   //variable numofTheta_Angle=dimsize(Theta_Angle)
   //setdatafolder root:FSfitting
   variable ii=0,j=0,limitofj=dimsize(root:OriginalData:Theta_Angle,0)
   do
     do
       if(cmpstr(ProcessedImage[ii],root:OriginalData:ProcessedImage[j])==0)
       Theta[ii]=root:OriginalData:Theta_Angle[j]
       Phi[ii]=root:OriginalData:Phi_Angle[j]
       Omega[ii]=root:OriginalData:Omega_Angle[j]
       endif
       j+=1
       while(j<limitofj)
     j=0
     ii+=1
   while(ii<limitofProcessedList)
   
 
   DoWindow overallTable
	        if(V_flag==0)

      		Edit ProcessedImage as "Overall_table"
      		AppendToTable Theta
      		AppendToTable Phi
      		AppendToTable Omega
      		AppendToTable gap
      		AppendToTable numberoftheEDCatKf
           AppendToTable ExperimentalNote
           DoWindow/C  overallTable
           else
           DoWindow/F overallTable
	       endif
  ENDIF
  
  END
  
  
  
  
  
  proc show_EDCs_atKf(ctrlName) : ButtonControl 
  String ctrlName
  setdatafolder root:FSfitting
  PauseUpdate;Silent 1
  Dowindow/k showEDC
  Dowindow showEDC 
  display as "Show_EDCs_atKf"
  variable jj=EDCstartnumber
  string tempstring=ProcessedImage[EDCstartnumber],tempstringEDC
  variable tempnumber,lengthofEDC=dimsize(root:process:$tempstring,0),startpoint,endpoint
  make/o/n=(lengthofEDC) tempEDC,energy
  setscale/p x 0,1,tempEDC
  setscale/p x 0,1,energy
  energy=dimoffset(root:process:$tempstring,0)+dimdelta(root:process:$tempstring,0)*x
 
  
  do
    tempstring=ProcessedImage[jj]
    tempnumber=numberoftheEDCatKf[jj]
    tempEDC=root:process:$tempstring[p][tempnumber]
    tempstringEDC=tempstring+"_EDC"
    
    startpoint=(EDCenergystart-dimoffset(root:process:$tempstring,0))/(dimdelta(root:process:$tempstring,0))
    endpoint=(EDCenergyend-dimoffset(root:process:$tempstring,0))/(dimdelta(root:process:$tempstring,0))
    //print startpoint,endpoint 
    duplicate/o/r=(startpoint,endpoint)   tempEDC  $tempstringEDC
    duplicate/o/r=(startpoint,endpoint)   energy   tempenergy
    $tempstringEDC+=(jj-EDCstartnumber)*EDCoffset
    AppendToGraph  $tempstringEDC VS tempenergy
    jj+=1
   while(jj<EDCendnumber+1)
   Label bottom "E(ev)"
   Label left "\\Z16intensity"
   ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
   ModifyGraph zero(bottom)=3
   ModifyGraph mirror=2
   DoWindow/C showEDC
 
 END
 
 
 
 proc show_symmEDCs_atKf(ctrlName) : ButtonControl 
  String ctrlName
  setdatafolder root:FSfitting
  PauseUpdate;Silent 1
  Dowindow/k showsymmEDC
  Dowindow showsymmEDC
  display as "Show_symmEDCs_atKf"
  variable jj=EDCstartnumber
  string tempstring=ProcessedImage[EDCstartnumber],tempstringEDC
  variable tempnumber,lengthofEDC=dimsize(root:process:$tempstring,0),startpoint,endpoint
  make/o/n=(lengthofEDC) tempEDC
  setscale/p x 0,1,tempEDC
  
  do
    tempstring=ProcessedImage[jj]
    tempnumber=numberoftheEDCatKf[jj]
    tempEDC=root:process:$tempstring[p][tempnumber]
    tempstringEDC=tempstring+"_symmEDC"
    
    startpoint=(EDCenergystart-dimoffset(root:process:$tempstring,0))/(dimdelta(root:process:$tempstring,0))
    endpoint=(EDCenergyend-dimoffset(root:process:$tempstring,0))/(dimdelta(root:process:$tempstring,0))
    
    duplicate/o/r=(startpoint,endpoint)   tempEDC  $tempstringEDC
    setscale/I x EDCenergystart,EDCenergyend,   $tempstringEDC
    $tempstringEDC+=(jj-EDCstartnumber)*EDCoffset
    
    WaveSymmetrize($tempstringEDC,0)
    Duplicate/O EnWave $tempstringEDC
    
    AppendToGraph  $tempstringEDC 
    jj+=1
   while(jj<EDCendnumber+1)
   Label bottom "E(ev)"
   Label left "\\Z16intensity"
   ModifyGraph zero(bottom)=3
   ModifyGraph mirror=2
   ModifyGraph fStyle(bottom)=1,axThick=2,standoff=0
   DoWindow/C showsymmEDC
 END
 
 
 proc show_your_chosen_Ef_onFS(ctrlName) : ButtonControl 
      String ctrlName
      setdatafolder  root:FSfitting
      variable ProcessedImagenumber=dimsize(ProcessedImage,0)
      make/o/n=(ProcessedImagenumber)  show_thetawave,show_phiwave,show_omegawave,show_Kx,show_Ky,show_RKx,show_RKy,show_deltaphi
      string tempstr_ProcessedImage
      variable k=0
      DO
      tempstr_ProcessedImage=ProcessedImage[k]
      show_deltaphi[k]=dimoffset(root:process:$tempstr_ProcessedImage,1)+numberoftheEDCatKf[k]*dimdelta(root:process:$tempstr_ProcessedImage,1)
      show_phiwave[k]=Phi[k]-show_deltaphi[k]-root:process:PhiOffset
      show_thetawave[k]=Theta[k]-root:process:ThetaOffset
      show_omegawave[k]=Omega[k]-root:process:OmegaOffset
      k+=1
      while(k<ProcessedImagenumber)
      
     
      Variable show_PhotonE=root:PROCESS:PhotonEnergy
      Variable show_WorkFunc=root:Process:WorkFunction
      Variable show_LC=root:PROCESS:LatticeConstant
      Variable show_K0=0.5118*show_LC/pi*Sqrt(show_PhotonE-show_WorkFunc)
    
      show_Ky=show_K0*sin(pi/180*show_thetawave)*cos(3.1416/180*show_phiwave)
      show_Kx=show_K0*sin(pi/180*show_phiwave)  
      show_RKy=sqrt(show_Ky*show_Ky+show_Kx*show_Kx)*sin((atan2(show_Ky,show_Kx))+show_omegawave*pi/180) 
      show_RKx=sqrt(show_Ky*show_Ky+show_Kx*show_Kx)*cos((atan2(show_Ky,show_Kx))+show_omegawave*pi/180) 
      
      appendtograph  show_RKy vs show_RKx
      ModifyGraph mode=3,marker(show_RKy)=8
      
      END
      
      
      
 proc show_gap_VS_phifrompipi(ctrlName) : ButtonControl 
      String ctrlName
      setdatafolder  root:FSfitting
      make/o/n=(dimsize(ProcessedImage,0))  phifrompipi,standardDwave
      variable kk=0,temp_y,temp_x
      Do
      temp_y=1-show_RKy[kk]
      temp_x=1-show_RKx[kk]
      phifrompipi[kk]=atan2(temp_y,temp_x)*180/pi
      standardDwave[kk]=delta0*abs(cos(2*phifrompipi[kk]/180*pi))
      kk+=1
      While(kk<(dimsize(ProcessedImage,0)))
      //print phifrompipi
     
      dowindow/k gap_VS_phi
      dowindow gap_VS_phi
      display as "Gap vs Phi"
      appendtograph  gap vs  phifrompipi
      ModifyGraph mode=3,marker=11
      Label bottom "\\Z12Phi(degree)"
      Label left "\\Z12Gap Size(mev)"
      ModifyGraph axThick=3
      ModifyGraph mirror=2
      ModifyGraph mrkThick=1,rgb=(0,15872,65280)
      appendtograph standardDwave vs phifrompipi
      ModifyGraph lsize(standardDwave)=2
      dowindow/c gap_VS_phi
   
      
      
 END
 
 
  proc show_gap_VS_Dwave(ctrlName) : ButtonControl 
      String ctrlName
      setdatafolder  root:FSfitting
      make/o/n=2 referencelinex,referenceliney
      referencelinex[0]=0
      referencelinex[1]=delta0
      referenceliney[0]=0
      referenceliney[1]=delta0
      
      dowindow/k gap_VS_Dwave
      dowindow gap_VS_Dwave
      display as "Gap vs Dwave"
      appendtograph  gap vs  standardDwave
      ModifyGraph mode=3,marker=11
      Label bottom "\\Z12 Delta0*cos(2*phi)"
      Label left "\\Z12Gap Size(mev)"
      ModifyGraph axThick=3
      ModifyGraph mirror=2
      ModifyGraph mrkThick=1,rgb=(0,15872,65280)
      appendtograph referenceliney vs referencelinex
      ModifyGraph lstyle(referenceliney)=9,rgb(referenceliney)=(0,0,0)
      ModifyGraph lsize(referenceliney)=2
      ModifyGraph rgb(referenceliney)=(65280,0,0)
      dowindow/c gap_VS_Dwave
 
      
 END
      
      
      
      
Proc chosetypeofgap(ctrlName,popNum,popStr) : PopupMenuControl
     String ctrlName
	 Variable popNum
	 String popStr
	 setdatafolder root:FSfitting
	 variable/G typeofgap
	 if(cmpstr(popStr,"normal gap")==0)
	 typeofgap=0
	 endif
	 
     if(cmpstr(popStr,"pseudogap")==0)
     typeofgap=1
     endif
    
   
END


 
 
Proc fit_use_a_phenomenology_method(ctrlName) : ButtonControl 
    String ctrlName
	String Curr=GetDataFolder(1) 
	PauseUpdate;Silent 1
    String EDCList,TempEDCname 
    EDCList=TraceNameList("", ";",1)
    
    Variable EDCNum=ItemsInlist(EDCList)
    
    variable v0,v1,v2,v3,v4,v5
	   v0=root:FSfitting:EDCfitBackground
       v1=root:FSfitting:EDCfitHeight
       v2=root:FSfitting:EDCfitdelta
       v3=root:FSfitting:EDCfitgamma1	
       v4=root:FSfitting:EDCfitgamma0
       v5=1
       Make/O co_EDCfit_normalgap={v0,v1,v2,v3}
       Make/O co_EDCfit_pseudogap={v0,v1,v2,v3,v4} 
       Redimension/D co_EDCfit_normalgap;DelayUpdate
       Redimension/D co_EDCfit_pseudogap;DelayUpdate
       
       
	
	Variable kk
	Make/O/N=(EDCNum) EDCBackground=0, EDCHeight=0, EDCdelta=0, EDCdeltaError=0, EDCgamma1=0, EDCgamma1Error=0, EDCgamma0=0, EDCgamma0Error=0

	kk=0
	DO
	TempEDCname=StringFromList(kk,EDCList,";")
	
	make/o/n=(dimsize($TempEDCname,0)) TempEDCx
	TempEDCx=dimoffset($TempEDCname,0)+dimdelta($TempEDCname,0)*x
	
	 IF(root:FSfitting:typeofgap==0)	    

	 FuncFit/N=1/Q=1/ODR=0/NTHR=0 Norman_gap_func co_EDCfit_normalgap  $TempEDCname /D /X= TempEDCx
		
            EDCBackground[kk]=co_EDCfit_normalgap[0]
	        EDCHeight[kk]=co_EDCfit_normalgap[1]
	        EDCdelta[kk]=co_EDCfit_normalgap[2]
	        EDCgamma1[kk]=co_EDCfit_normalgap[3]
	        EDCdeltaError[kk]=W_sigma[2]
	        EDCgamma1Error[kk]=W_sigma[3]
	       
     ENDIF
     
     IF(root:FSfitting:typeofgap==1)
     
     FuncFit/N=1/Q=1/ODR=0/NTHR=0 Norman_pseudogap_func co_EDCfit_pseudogap  $TempEDCname /D /X= TempEDCx
		
            EDCBackground[kk]=co_EDCfit_pseudogap[0]
	        EDCHeight[kk]=co_EDCfit_pseudogap[1]
	        EDCdelta[kk]=co_EDCfit_pseudogap[2]
	        EDCgamma1[kk]=co_EDCfit_pseudogap[3]
	        EDCgamma0[kk]=co_EDCfit_pseudogap[4]
	        EDCdeltaError[kk]=W_sigma[2]
	        EDCgamma1Error[kk]=W_sigma[3]
	        EDCgamma0Error[kk]=W_sigma[4]
	       
     ENDIF
     gap[EDCstartnumber+kk]=EDCdelta[kk]*1000
     kk+=1
   While(kk<EDCNum)
   
End

function Norman_gap_func(v,x)
    
    wave v
    variable x
    return v[0]+x+v[1]*(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))/((x-v[2]^2*x/(x^2+0.0001^2))^2+(v[3]+v[2]^2*0.0001/(x^2+0.0001^2))^2)
end

function Norman_pseudogap_func(v,x)

    wave v
    variable x
    return v[0]+x+v[1]*(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))/((x-v[2]^2*x/(x^2+v[4]^2))^2+(v[3]+v[2]^2*v[4]/(x^2+v[4]^2))^2)
end
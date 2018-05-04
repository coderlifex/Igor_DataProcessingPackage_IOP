#pragma rtGlobals=1		// Use modern global access method.
proc show_MDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
   newdatafolder/o/s root:fit_MDC
     variable/G  numberoftheEDCatKf_1
     variable/G numberoftheEDCatKf_2
     variable/G numberoftheEDCatKf_3
	 variable/G numberofMDCpeaks
	 
	 variable/G MDCBackground
     variable/G MDCHeight1
     variable/G MDCFWHM1
     variable/G MDCPeakPosition1	
       
     variable/G MDCHeight2
     variable/G MDCFWHM2
     variable/G MDCPeakPosition2	
     
     variable/G MDCHeight3
     variable/G MDCFWHM3
     variable/G MDCPeakPosition3	
     
     
   PauseUpdate;Silent 1
   variable EE=root:process:MDC_EE
   variable bindnumber=root:process:bindnumber_MDC
   variable ii=0
   
   Dowindow/k show_MDCs 
   Dowindow show_MDCs
   display as "show_MDCs"
    
     duplicate/o root:process:$popStr, temp_ProcessedImage
     make/o/n=(dimsize(temp_ProcessedImage,1))  show_MDCintensity,show_MDC_AngleY
     Do
     show_MDCintensity+=temp_ProcessedImage[round((EE-dimoffset(temp_ProcessedImage,0))/dimdelta(temp_ProcessedImage,0))-round(bindnumber/2)+ii][p]
     ii+=1
     WHILE(ii<bindnumber)
     show_MDCintensity/=bindnumber
    // print round((EE-dimoffset(temp_ProcessedImage,0))/dimdelta(temp_ProcessedImage,0))
     show_MDC_AngleY=dimoffset(temp_ProcessedImage,1)+dimdelta(temp_ProcessedImage,1)*x
    // print EE
     if(EE<0)
     duplicate/o show_MDCintensity $popStr+"MDC_at"+"N"+num2str(abs((EE*1000)))
     appendtograph  $popStr+"MDC_at"+"N"+num2str(abs((EE*1000))) vs show_MDC_AngleY
     else
     duplicate/o show_MDCintensity $popStr+"MDC_at"+"P"+num2str(abs((EE*1000)))
     appendtograph  $popStr+"MDC_at"+"P"+num2str(abs((EE*1000))) vs show_MDC_AngleY
     endif
     
     ModifyGraph mirror=2
     ModifyGraph axThick=2
     Label bottom "\\Z16K//"
     Label left "\\Z16intensity"
   dowindow/c  show_MDCs
   end




Proc FitMoreLorentzian_MDC(CtrlName):ButtonControl
	String CtrlName
	pauseupdate;silent 1
   
    setdatafolder root:fit_MDC
	 
	DoWindow/F More_Lorentzian_Fit_MDC
	if (V_flag==0)
	
       More_Lorentzian_Fit_MDC()
       
       Endif
       
 
    End



Window More_Lorentzian_Fit_MDC() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1/W=(277,364,901,598)
	ModifyPanel cbRGB=(64512,62423,1327)
	ShowTools/A
	SetDrawLayer UserBack
	SetDrawEnv fillfgc= (16384,65280,65280)
	DrawRRect 618,190,1,40
	DrawText 685,195,"Fitting Initialization Parameters"
	SetVariable set_MDCBackground,pos={225,44},size={170,18},title="BKGD   "
	SetVariable set_MDCBackground,fSize=15
	SetVariable set_MDCBackground,limits={-inf,inf,0.1},value= root:fit_MDC:MDCBackground
	SetVariable set_MDC1Height,pos={6,68},size={170,18},title="Height1  ",fSize=15
	SetVariable set_MDC1Height,limits={-inf,inf,0.1},value= root:fit_MDC:MDCHeight1
	SetVariable set_MDC1FWHM,pos={6,100},size={170,18},title="FWHM1 ",fSize=15
	SetVariable set_MDC1FWHM,limits={-inf,inf,0.1},value= root:fit_MDC:MDCFWHM1
	SetVariable set_MDC1Position,pos={6,130},size={170,18},title="Position1"
	SetVariable set_MDC1Position,fSize=15
	SetVariable set_MDC1Position,limits={-inf,inf,0.1},value= root:fit_MDC:MDCPeakPosition1
	SetVariable set_MDC2Height,pos={226,69},size={170,18},title="Height2  ",fSize=15
	SetVariable set_MDC2Height,limits={-inf,inf,0.1},value= root:fit_MDC:MDCHeight2
	SetVariable set_MDC2FWHM,pos={226,100},size={170,18},title="FWHM2 ",fSize=15
	SetVariable set_MDC2FWHM,limits={-inf,inf,0.1},value= root:fit_MDC:MDCFWHM2
	SetVariable set_MDC2Position,pos={226,130},size={170,18},title="Position2"
	SetVariable set_MDC2Position,fSize=15
	SetVariable set_MDC2Position,limits={-inf,inf,0.1},value= root:fit_MDC:MDCPeakPosition2
	SetVariable set_MDC3Height,pos={446,69},size={170,18},title="Height3  ",fSize=15
	SetVariable set_MDC3Height,limits={-inf,inf,0.1},value= root:fit_MDC:MDCHeight3
	SetVariable set_MDC3FWHM,pos={446,100},size={170,18},title="FWHM3 ",fSize=15
	SetVariable set_MDC3FWHM,limits={-inf,inf,0.1},value= root:fit_MDC:MDCFWHM3
	SetVariable set_MDC3Position,pos={446,129},size={170,18},title="Position3"
	SetVariable set_MDC3Position,fSize=15
	SetVariable set_MDC3Position,limits={-inf,inf,0.1},value= root:fit_MDC:MDCPeakPosition3
	SetVariable numberofMDCpeaks,pos={211,9},size={210,18},title="Number of MDC peaks "
	SetVariable numberofMDCpeaks,fSize=15
	SetVariable numberofMDCpeaks,limits={-inf,inf,0.1},value= root:fit_MDC:numberofMDCpeaks
	Button Fit,pos={247,198},size={115,29},proc=fit_MDC,title="Fit",fSize=20
	Button Fit,fStyle=1
	ValDisplay EDCnumber,pos={6,160},size={150,16},title="Peak1_number",fSize=15
	ValDisplay EDCnumber,fStyle=1,limits={0,0,0},barmisc={0,1000}
	ValDisplay EDCnumber,value= #"root:fit_MDC:numberoftheEDCatKf_1"
	ValDisplay EDCnumber2,pos={225,160},size={150,16},title="Peak2_number",fSize=15
	ValDisplay EDCnumber2,fStyle=1,limits={0,0,0},barmisc={0,1000}
	ValDisplay EDCnumber2,value= #"root:fit_MDC:numberoftheEDCatKf_2"
	ValDisplay EDCnumber3,pos={446,160},size={150,16},title="Peak3_number",fSize=15
	ValDisplay EDCnumber3,fStyle=1,limits={0,0,0},barmisc={0,1000}
	ValDisplay EDCnumber3,value= #"root:fit_MDC:numberoftheEDCatKf_3"
EndMacro







Proc fit_MDC(ctrlName) : ButtonControl 
    String ctrlName
	String Curr=GetDataFolder(1) 
	PauseUpdate;Silent 1
	setdatafolder root:fit_MDC
	Variable w0,w1,w2,w3,w4,w5, w6, w7, w8, w9, w10
	  
    
	   w0=root:fit_MDC:MDCBackground
       w1=root:fit_MDC:MDCHeight1
       w2=root:fit_MDC:MDCFWHM1
       w3=root:fit_MDC:MDCPeakPosition1	
       w4=1
       w5=root:fit_MDC:MDCHeight2
       w6=root:fit_MDC:MDCFWHM2
       w7=root:fit_MDC:MDCPeakPosition2	
       w8=root:fit_MDC:MDCHeight3
       w9=root:fit_MDC:MDCFWHM3
       w10=root:fit_MDC:MDCPeakPosition3	
       Make/O co_OnePeak={w0, w1, w2,w3,w4}
       Make/O co_TwoPeak={w0, w1, w2,w3,w4,w5,w6,w7}     
       Make/O co_ThreePeak={w0, w1, w2,w3,w4,w5,w6,w7,w8,w9,w10}   
       Redimension/D co_OnePeak;DelayUpdate
       Redimension/D co_TwoPeak;DelayUpdate
       Redimension/D co_ThreePeak;DelayUpdate
         


  
	
	 IF(numberofMDCpeaks==1)	    

		FuncFit/N=1/Q=1 XJLorentzianFit_OnePeak co_OnePeak show_MDCintensity /D /X= show_MDC_AngleY	
		
           // Background[jj]=co_OnePeak[0]
	       // Height1[jj]=co_OnePeak[1]
	       // FWHM1[jj]=co_OnePeak[2]
	       // Position1[jj]=co_OnePeak[3]
	       // FWHMError1[jj]=W_sigma[2]
	       // PositionError1[jj]=W_sigma[3]
	       // print Position1[jj]
	       // print (AngleY[1]-AngleY[0]),(Position1[jj]-AngleY[0]),round ((Position1[jj]-AngleY[0])/(AngleY[1]-AngleY[0]))
	        
	        numberoftheEDCatKf_1=round ((co_OnePeak[3]-show_MDC_AngleY[0])/(show_MDC_AngleY[1]-show_MDC_AngleY[0]))
	        
	     
	        ENDIF
	        
	        
	       IF(numberofMDCpeaks==2)	
	       
		FuncFit/N=1/Q=1 XJLorentzianFit_TwoPeak co_TwoPeak show_MDCintensity /D /X= show_MDC_AngleY	
		
		
          //  Background[jj]=co_TwoPeak[0]
	       // Height1[jj]=co_TwoPeak[1]
	      //  FWHM1[jj]=co_TwoPeak[2]
	      //  Position1[jj]=co_TwoPeak[3]
          //  Height2[jj]=co_TwoPeak[5]
	      //  FWHM2[jj]=co_TwoPeak[6]
	      //  Position2[jj]=co_TwoPeak[7]	        
                
	     //   FWHMError1[jj]=W_sigma[2]
	     //   PositionError1[jj]=W_sigma[3]
	     //   FWHMError2[jj]=W_sigma[6]
	     //   PositionError2[jj]=W_sigma[7]   
	        
	        numberoftheEDCatKf_1=round ((co_TwoPeak[3]-show_MDC_AngleY[0])/(show_MDC_AngleY[1]-show_MDC_AngleY[0]))
	        numberoftheEDCatKf_2=round ((co_TwoPeak[7]-show_MDC_AngleY[0])/(show_MDC_AngleY[1]-show_MDC_AngleY[0]))
	                    
	        ENDIF	
	        
	        
	    IF(numberofMDCpeaks==3)	

	    FuncFit/N=1/Q=1 XJLorentzianFit_ThreePeak co_ThreePeak show_MDCintensity /D /X= show_MDC_AngleY	
		
          //  Background[jj]=co_ThreePeak[0]
	      //  Height1[jj]=co_ThreePeak[1]
	      //  FWHM1[jj]=co_ThreePeak[2]
	      //  Position1[jj]=co_ThreePeak[3]
          //  Height2[jj]=co_ThreePeak[5]
	      //  FWHM2[jj]=co_ThreePeak[6]
	      //  Position2[jj]=co_ThreePeak[7]
         //   Height3[jj]=co_ThreePeak[8]
	     //   FWHM3[jj]=co_ThreePeak[9]
	     //   Position3[jj]=co_ThreePeak[10]        	        
           
                
         //   FWHMError1[jj]=W_sigma[2]
	      //  PositionError1[jj]=W_sigma[3]
	      //  FWHMError2[jj]=W_sigma[6]
	     //   PositionError2[jj]=W_sigma[7]    
         //   FWHMError3[jj]=W_sigma[9]
	     //   PositionError3[jj]=W_sigma[10]               
         
            
            
            numberoftheEDCatKf_1=round ((co_ThreePeak[3]-show_MDC_AngleY[0])/(show_MDC_AngleY[1]-show_MDC_AngleY[0]))
	        numberoftheEDCatKf_2=round ((co_ThreePeak[7]-show_MDC_AngleY[0])/(show_MDC_AngleY[1]-show_MDC_AngleY[0]))
	        numberoftheEDCatKf_3=round ((co_ThreePeak[10]-show_MDC_AngleY[0])/(show_MDC_AngleY[1]-show_MDC_AngleY[0]))               
      
         ENDIF

  
  appendtograph  fit_show_MDCintensity
  ModifyGraph lsize(fit_show_MDCintensity)=2,rgb(fit_show_MDCintensity)=(0,0,0)
  TextBox/C/N=text0/A=RT/X=10.00/Y=10.00  "\\Z14\\f01Peak1number="+num2str(numberoftheEDCatKf_1)+"\r\\Z14\\f01Peak2number="+num2str(numberoftheEDCatKf_2)+"\r\\Z14\\f01Peak3number="+num2str(numberoftheEDCatKf_3)
  ModifyGraph width=340.157,height={Aspect,0.8}
  
 end
  
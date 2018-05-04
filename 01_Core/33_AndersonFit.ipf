#pragma rtGlobals=1		// Use modern global access method.

Proc AndersonEDCFitPanel()
     
     String Curr=GetDataFolder(1)
     Dowindow/F AndersonEDC_Fit
     if (V_flag==0)
        Newdatafolder/O/S root:AndersonEDCFit

        Variable/G FitEDCEnergyStart=NumVarOrDefault("root:AndersonEDCFit:FitEDCEnergyStart",100)
        Variable/G FitEDCEnergyEnd=NumVarOrDefault("root:AndersonEDCFit:FitEDCEnergyEnd",100)
        Variable/G holedopinglevel=NumVarOrDefault("root:AndersonEDCFit:holedopinglevel",100)

        Variable/G Peakposition=NumVarOrDefault("root:AndersonEDCFit:Peakposition",100)
        Variable/G FWHM=NumVarOrDefault("root:AndersonEDCFit:FWHM",100)
        Variable/G Temperature=NumVarOrDefault("root:AndersonEDCFit:Temperature",100)
        Variable/G Background=NumVarOrDefault("root:AndersonEDCFit:Background",100)

        String/G   EDCFileList
        String/G   TempEDCName
        Variable/G Nameflag

        
        SetDataFolder root:PROCESSEDIMAGESpectra
           root:AndersonEDCFit:EDCFileList=WaveList("EEF*",";","DIMS:1")
     
        SetDataFolder root:AndersonEDCFit 
    
     
        
        
        AndersonEDC_Fit()
     endif
     SetDataFolder Curr
     
end

Window AndersonEDC_Fit() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(609,195,803,440)
	ModifyPanel cbRGB=(48896,39152,55280)
	SetDrawLayer UserBack
	SetDrawEnv fillfgc= (62896,50152,45280)
	DrawRRect 9,26,188,236
	PopupMenu popup_name,pos={4,5},size={187,20},bodyWidth=150,proc=Namelist,title="\\F'@Arial Unicode MS'Name"
	PopupMenu popup_name,mode=6,popvalue="Bi2201",value= #"\"Bi2201;Bi2212\""
	Button EDCFitButton,pos={22,201},size={161,25},proc=AndersonFit,title="Fit"
	Button EDCFitButton,font="@Arial Unicode MS",fSize=12
	SetVariable set_EnergyStart,pos={22,57},size={160,20},proc=SetVarProc,title="\\F'@Arial Unicode MS'EnStart "
	SetVariable set_EnergyStart,fSize=12
	SetVariable set_EnergyStart,limits={-inf,inf,0.1},value= root:IMG2MATRIX:FitEDCEnergyStart
	SetVariable set_EnergyEnd,pos={23,78},size={160,20},proc=SetVarProc,title="\\F'@Arial Unicode MS'EnEnd"
	SetVariable set_EnergyEnd,fSize=12
	SetVariable set_EnergyEnd,limits={-inf,inf,0.01},value= root:IMG2MATRIX:FitEDCEnergyEnd
	SetVariable set_holedoping,pos={22,34},size={160,20},proc=SetVarProc,title="\\F'@Arial Unicode MS'HDopping"
	SetVariable set_holedoping,fSize=12
	SetVariable set_holedoping,limits={0,1,0.01},value= root:IMG2MATRIX:holedopinglevel
	SetVariable set_Peakposition,pos={21,126},size={160,20},proc=SetVarProc,title="\\F'@Arial Unicode MS'PPosition(mev)"
	SetVariable set_Peakposition,fSize=12
	SetVariable set_Peakposition,limits={-inf,inf,0.1},value= root:IMG2MATRIX:Peakposition
	SetVariable set_FWHM,pos={22,147},size={160,20},proc=SetVarProc,title="\\F'@Arial Unicode MS'FWHM (mev)   "
	SetVariable set_FWHM,fSize=12,value= root:IMG2MATRIX:FWHM
	SetVariable set_Temperature,pos={20,176},size={160,20},proc=SetVarProc,title="\\F'@Arial Unicode MS'Temperature(K)"
	SetVariable set_Temperature,fSize=12
	SetVariable set_Temperature,limits={0,inf,0.1},value= root:IMG2MATRIX:Temperature
	SetVariable set_Background,pos={22,105},size={160,20},proc=SetVarProc,title="\\F'@Arial Unicode MS'Background "
	SetVariable set_Background,fSize=12
	SetVariable set_Background,limits={-inf,inf,10},value= root:IMG2MATRIX:Background
EndMacro

Proc Namelist(ctrlName,popNum,popStr) : PopupMenuControl
    String ctrlName
    Variable popNum
    String popStr
    
    String Curr=GetDataFolder(1)
	SetDataFolder root:AndersonEDCFit
    
    If(stringmatch(popStr,"Bi2201"))
    root:AndersonEDCFit:Nameflag=1
    endif
    
    If(stringmatch(popStr,"Bi2212"))
    root:AndersonEDCFit:Nameflag=2
    endif
    
    SetDataFolder Curr
End



Proc ShowOrigEDC(ctrlName,popNum,popStr) £º PopupMenuControl
    String ctrlName
    Variable popNum
    String popStr
    String EDCName="N"+popStr
    root:AndersonEDCFit:TempEDCName=popstr
    
    //print root:AndersonEDCFit:TempEDCName
    
    String Curr=GetDataFolder(1)
    SetDataFolder root:AndersonEDCFit
    
    //If(V_flag==0) 
       Duplicate/o root:PROCESSEDIMAGESpectra:$popstr root:AndersonEDCFit:$TempEDCName
       Display root:PROCESSEDIMAGESpectra:$TempEDCName
       ModifyGraph rgb=(16384,28160,65280),mode=3,marker=19
      // DoWindow/C $EDCName
       //Duplicate/O/R 
       
   // Else
       DoWindow/F $EDCName
   // Endif
    
    SetDataFolder Curr

End



Proc AndersonFit(ctrlName) : ButtonControl
    String ctrlName
    String Curr=GetDataFolder(1)
    //SetDataFolder root:AndersonEDCFit
    //Pauseupdate;silent 1
    
    If (Nameflag==1)
    
    PYYAndersonFit_Bi2201()
    
    Endif
    
    If (Nameflag==2)
    
    PYYAndersonFit_Bi2212()
    
    Endif
    
    SetDataFolder Curr
    

End     



//Anderson fit
Function AndersonFit_EDC_Bi2201(w,x) : FitFunc
    //constp=p
    //w[0]=Temperature //10~90% width,h/(2*pi*kB*T)=4400/(10~90% width),
    //Fermi level:      10~90% width:  4.40k_B T
    //w[1]=Vf*k
    //w[2]=AT,T(mev)=0.08617*T(K)
    //w[3]=constant background
    wave w
    Variable x
    Variable constp,Temp
    //constp=0.18
    NVAR holedopinglevel=root:IMG2MATRIX:holedopinglevel
    constp=0.25*(1-holedopinglevel)*(1-holedopinglevel)
    NVAR Temperature=root:IMG2MATRIX:Temperature
    Temp=Temperature
   // Variable constB
   //Variable Relateholedoping,constp
  // Relateholedoping=root:AndersonEDCFit:holedopinglevel
  // constp=0.25*(1-Relateholedoping)*(1-Relateholedoping)
    
     
    Variable val1
    Variable val2
    val1=sin((1-constp)*(pi/2-atan2(x-w[0],w[1])))
    //val2=val1/((exp(4.4*x/w[0])+1)*(((x-w[1])*(x-w[1])+w[2]*w[2])^((1-constp)/2)))
    //val2=w[3]*(val1/((exp(11594.2*x/Temp)+1)*(((x-w[0])*(x-w[0])+w[1]*w[1])^((1-constp)/2)))+w[2]/(exp(11594.2*x/Temp)+1))
   // val2=(w[3]*val1)/((exp(11594.2*x/Temp)+1)*(((x-w[0])*(x-w[0])+w[1]*w[1])^((1-constp)/2)))+w[2]/(exp(11594.2*x/Temp)+1)
    val2=(w[3]*val1)/((exp(11608.7*x/Temp)+1)*(((x-w[0])*(x-w[0])+w[1]*w[1])^((1-constp)/2)))+w[2]/(exp(11608.7*x/Temp)+1)
    
    Return val2
END 

Function AndersonFit_EDC_Bi2212(w,x) : FitFunc
    //constp=p
    //w[0]=Temperature //10~90% width,h/(2*pi*kB*T)=4400/(10~90% width),
    //Fermi level:      10~90% width:  4.40k_B T
    //w[1]=Vf*k
    //w[2]=AT,T(mev)=0.08617*T(K)
    //w[3]=constant background
    wave w
    Variable x
    Variable constp,Temp
    //constp=0.18
    NVAR holedopinglevel=root:IMG2MATRIX:holedopinglevel
    constp=0.25*(1-holedopinglevel)*(1-holedopinglevel)
    NVAR Temperature=root:IMG2MATRIX:Temperature
    Temp=Temperature
   // Variable constB
   //Variable Relateholedoping,constp
  // Relateholedoping=root:AndersonEDCFit:holedopinglevel
  // constp=0.25*(1-Relateholedoping)*(1-Relateholedoping)
    
     
    Variable val1
    Variable val2
    val1=sin((1-constp)*(pi/2-atan2(x-w[0],w[1])))
    //val2=val1/((exp(4.4*x/w[0])+1)*(((x-w[1])*(x-w[1])+w[2]*w[2])^((1-constp)/2)))
    val2=(w[2]*val1)/((exp(11608.7*x/Temp)+1)*(((x-w[0])*(x-w[0])+w[1]*w[1])^((1-constp)/2)))
    
    Return val2
END 




function PYYAndersonFit_Bi2201() 
    
     String Curr=GetDataFolder(1)
     //SetDataFolder root:AndersonEDCFit
     
   
      
    //string namepre=nameofwave(tmpwave)
     
     
     wave tmpwave=waverefindexed("",0,1)
     String EDC="N"+nameofwave(tmpwave)
     String FitCurve="fit_"+nameofwave(tmpwave)
     
     Variable Relatedoping,FermilevelFWHM,EDCpeakposition,EDCFWHM,EDCbackground
     
     nvar EDC_EnergyStart=root:IMG2MATRIX:FitEDCEnergyStart
     nvar EDC_EnergyEnd=root:IMG2MATRIX:FitEDCEnergyEnd
     nvar Peakposition=root:IMG2MATRIX:Peakposition
     nvar FWHM=root:IMG2MATRIX:FWHM
     nvar Background=root:IMG2MATRIX:Background
     nvar Temperature=root:IMG2MATRIX:Temperature
     nvar holedopinglevel=root:IMG2MATRIX:holedopinglevel
     
     Variable NumofX, Xminimum, Xincrement, XMaximum
     
     //Duplicate/O/R=(EDC_EnergyStart,EDC_EnergyEnd) $TempEDCName,$EDC
     Duplicate/O/R=(EDC_EnergyStart,EDC_EnergyEnd) tmpwave,$EDC
     
     NumofX=DimSize($EDC,0)
     Xminimum=DimOffset($EDC,0)
     Xincrement=round(DimDelta($EDC,0)*1E6)/1E6
     XMaximum=Xminimum+Xincrement*(NumofX-1)
     
  
     Variable w0,w1,w2,w3

     w0=Peakposition
     w1=FWHM
     w2=Background
     w3=MaxofWave($EDC)-MinofWave($EDC)
     
     //input data(mev)
     //w0/=1000
     w0/=1000
     w1/=1000
     //w3=root:AndersonEDCFit:Background
     
     
     Make/O EDCcoeff={w0,w1,w2,w3}
     Redimension/D EDCcoeff
     
     Make/O/N=(NumofX) FitEDCEnergyAxis
     Variable i=0
     Do
         FitEDCEnergyAxis[i]=Xminimum+Xincrement*i
         i+=1
     while(i<NumofX)
     
     //Variable Relateholedoping=root:AndersonEDCFit:holedopinglevel
     //Variable constp=0.25*(1-Relateholedoping)*(1-Relateholedoping)
      //Variable constB=MinofWave($EDC)
  
      RemoveFromGraph/Z $FitCurve
     FuncFit AndersonFit_EDC_Bi2201,EDCcoeff,$EDC /D /X=FitEDCEnergyAxis
     
     // $FitCurve=constB+$FitCurve
     // Append $FitCurve
     //Relatedoping=EDCcoeff[0]
     //FermilevelFWHM=EDCcoeff[0]
     
     EDCpeakposition=EDCcoeff[0]
     EDCFWHM=EDCcoeff[1]
     EDCbackground=EDCcoeff[2]
     
     //display results(mev)
     //FermilevelFWHM*=1000
     EDCpeakposition*=1000
     EDCFWHM*=1000
     
     
     
     String EDCpeakLabel="Vf*K= " +num2str(EDCpeakposition)+ "meV"
     String EDCFWHMLabel="\F'symbol'Gamma=  "+num2str(EDCFWHM)+ "meV"
     String TemperatureLabel="T= "+num2str(Temperature)+ "K"
     //String BackgroundLabel="B="+num2str(constB)
     String BackgroundLabel="B="+num2str(EDCbackground)
     String holedopinglevelLable="Hole doping="+num2str(holedopinglevel)
     //String constpLable="p="+num2str(constp)
     
     Textbox/K/N=text0
     Textbox/N=text0/F=0/A=LT EDCpeakLabel
     AppendText/N=text0 EDCFWHMLabel
     AppendText/N=text0 TemperatureLabel
     AppendText/N=text0 BackgroundLabel
     AppendText/N=text0 holedopinglevelLable
    // AppendText/N=text0 constpLable
     Print "Vf*K= ",EDCpeakposition, " meV"
     Print "AT= ",EDCFWHM, " meV"
     Print "T=",Temperature,"K"
     //Print "B=",constB
     Print "B=",EDCbackground
     Print "Hole doping=",holedopinglevel
    // Print "p=",constp
     
     SetDataFolder Curr
     

End  

Proc PYYAndersonFit_Bi2212() 
        String Curr=GetDataFolder(1)
     //SetDataFolder root:AndersonEDCFit
     
   
      
    //string namepre=nameofwave(tmpwave)
     
     
     wave tmpwave=waverefindexed("",0,1)
     String EDC="N"+nameofwave(tmpwave)
     String FitCurve="fit_"+nameofwave(tmpwave)
     
     Variable Relatedoping,FermilevelFWHM,EDCpeakposition,EDCFWHM,EDCbackground
     
     nvar EDC_EnergyStart=root:IMG2MATRIX:FitEDCEnergyStart
     nvar EDC_EnergyEnd=root:IMG2MATRIX:FitEDCEnergyEnd
     nvar Peakposition=root:IMG2MATRIX:Peakposition
     nvar FWHM=root:IMG2MATRIX:FWHM
     nvar Background=root:IMG2MATRIX:Background
     nvar Temperature=root:IMG2MATRIX:Temperature
     nvar holedopinglevel=root:IMG2MATRIX:holedopinglevel
     
     Variable NumofX, Xminimum, Xincrement, XMaximum
     
     //Duplicate/O/R=(EDC_EnergyStart,EDC_EnergyEnd) $TempEDCName,$EDC
     Duplicate/O/R=(EDC_EnergyStart,EDC_EnergyEnd) tmpwave,$EDC
     
     NumofX=DimSize($EDC,0)
     Xminimum=DimOffset($EDC,0)
     Xincrement=round(DimDelta($EDC,0)*1E6)/1E6
     XMaximum=Xminimum+Xincrement*(NumofX-1)
     
  
     Variable w0,w1,w2,w3

     w0=Peakposition
     w1=FWHM
     w2=Background
     w3=MaxofWave($EDC)-MinofWave($EDC)
     
     //input data(mev)
     //w0/=1000
     w0/=1000
     w1/=1000
     //w3=root:AndersonEDCFit:Background
     
     
     Make/O EDCcoeff={w0,w1,w2,w3}
     Redimension/D EDCcoeff
     
     Make/O/N=(NumofX) FitEDCEnergyAxis
     Variable i=0
     Do
         FitEDCEnergyAxis[i]=Xminimum+Xincrement*i
         i+=1
     while(i<NumofX)
     
     //Variable Relateholedoping=root:AndersonEDCFit:holedopinglevel
     //Variable constp=0.25*(1-Relateholedoping)*(1-Relateholedoping)
      //Variable constB=MinofWave($EDC)
  
      RemoveFromGraph/Z $FitCurve
     FuncFit AndersonFit_EDC_Bi2212,EDCcoeff,$EDC /D /X=FitEDCEnergyAxis
     
     // $FitCurve=constB+$FitCurve
     // Append $FitCurve
     //Relatedoping=EDCcoeff[0]
     //FermilevelFWHM=EDCcoeff[0]
     
     EDCpeakposition=EDCcoeff[0]
     EDCFWHM=EDCcoeff[1]
     EDCbackground=EDCcoeff[2]
     
     //display results(mev)
     //FermilevelFWHM*=1000
     EDCpeakposition*=1000
     EDCFWHM*=1000
     
     
     
     String EDCpeakLabel="Vf*K= " +num2str(EDCpeakposition)+ "meV"
     String EDCFWHMLabel="\F'symbol'Gamma=  "+num2str(EDCFWHM)+ "meV"
     String TemperatureLabel="T= "+num2str(Temperature)+ "K"
     //String BackgroundLabel="B="+num2str(constB)
     String BackgroundLabel="B="+num2str(EDCbackground)
     String holedopinglevelLable="Hole doping="+num2str(holedopinglevel)
     //String constpLable="p="+num2str(constp)
     
     Textbox/K/N=text0
     Textbox/N=text0/F=0/A=LT EDCpeakLabel
     AppendText/N=text0 EDCFWHMLabel
     AppendText/N=text0 TemperatureLabel
     AppendText/N=text0 BackgroundLabel
     AppendText/N=text0 holedopinglevelLable
    // AppendText/N=text0 constpLable
     Print "Vf*K= ",EDCpeakposition, " meV"
     Print "AT= ",EDCFWHM, " meV"
     Print "T=",Temperature,"K"
     //Print "B=",constB
     Print "B=",EDCbackground
     Print "Hole doping=",holedopinglevel
    // Print "p=",constp
     
     SetDataFolder Curr

End




#pragma rtGlobals=1		// Use modern global access method.
menu "BCSgapFit"
"Start",BCSgapFit()
end

proc BCSgapFit()
DoWindow/F EBCSgapFit
if(V_flag==0)
NewDataFolder/O/S root:BCSgapFit
Variable/G gap
Variable/G background
Variable/G Intensity
Variable/G gammal
Variable/G Vkfactor
EBCSgapFit1()
endif
end

Window EBCSgapFit1() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(836,114,982,257) as "EDCsFit"
	SetVariable gammal,pos={23,53},size={103,16},title="Gamma"
	SetVariable gammal,value= root:BCSgapFit:gammal
	SetVariable gap,pos={22,10},size={106,16},title="Gap"
	SetVariable gap,value= root:BCSgapFit:gap
	SetVariable background,pos={24,92},size={103,16},title="Background"
	SetVariable background,value=root:BCSgapFit:background
	SetVariable Intensity,pos={23,73},size={104,16},title="Intensity"
	SetVariable Intensity,value= root:BCSgapFit:Intensity
	Button EDCFitP,pos={49,113},size={50,20},proc=ButtonProc1,title="EBCSgapFit"
EndMacro
            

Function ButtonProc1(ctrlName) : ButtonControl
	String ctrlName
	String AllofEDCName
	NVar gap0=gap
    NVar gammal0=gammal
    NVar background0=background
    NVar Intensity0=Intensity
    NVar Vkfactor0=Vkfactor
    Make/O/n=4 coefwave
    coefwave[0]=gap0
    coefwave[1]=gammal0   
    coefwave[2]=Intensity0
    coefwave[3]=background0
	AllofEDCName=TraceNameList("",";",1)
	//Print AllofEDCName
	Variable ii=0
	String EDCName
	Variable NumofEDC=ItemsInList(AllofEDCName,";")
	Make/O/n=(NumofEDC) FittedGap
	Make/O/n=(NumofEDC) FittedGamma
	Make/O/n=(NumofEDC) FittedBackground
	Make/O/n=(NumofEDC) FittedIntensity
	print numofedc
    
  do
    EDCName=StringFromList(ii,AllofEDCName,";")
    FuncFit/H="00000"/L=2000 LorEDCFit1 coefwave root:PROCESSEDIMAGESpectra:EEF3t50O450NP350NT20P235(-0.04,0.005) /D
   // Redimension/N=500 fit_data // change to 500 points
    //SetScale x 13, 20, fit_data // set domain from 13 to 20
    //fit_data= coefwave[1]*(coefwave[2]+coefwave[3]^2*coefwave[4]/(x^2+coefwave[4]^2))/((x-coefwave[3]^2*x/(x^2+coefwave[4]^2))^2+(coefwave[2]+coefwave[3]^2*coefwave[4]/(x^2+coefwave[4]^2))^2)+coefwave[0]
	FittedGap[ii]=coefwave[0]
	FittedGamma[ii]=coefwave[1]	
	FittedIntensity[ii]=coefwave[2]
	FittedBackground[ii]=coefwave[3]
    ii+=1
  while (ii<NumofEDC)
    
    
End

Function LorEDCFit1(coefWave,x)
   Wave coefWave 
   Variable x
   Return coefwave[2]*(1/((x-coefwave[0])^2+coefwave[1]^2)+1/((x+coefwave[0])^2+coefwave[1]^2))+coefwave[3]
End
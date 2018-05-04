#pragma rtGlobals=1		// Use modern global access method.

Proc  EDCatFermiSurfacePanel()
DoWindow/F EDC_At_FermiSurface_Panel
If (V_Flag==0)
          NewDataFolder/O/S  root:EDCatFermiSurface
          String/G     NamePrefix=StrVarOrDefault("root:EDCatFermiSurface:NamePrefix","")
		  Variable/G  ProcessFlag=NumVarOrDefault("root:EDCatFermiSurface:ProcessFlag",0.0)
		  Variable/G  Temperature=NumVarOrDefault("root:EDCatFermiSurface:Temperature",0.0)		  
		  Variable/G  EDCOffset=NumVarOrDefault("root:EDCatFermiSurface:EDCOffset",0.0)
		  Variable/G  NumberofEDCs=NumVarOrDefault("root:EDCatFermiSurface:NumberofEDCs",0.0)		  
		  	  
EDC_At_FermiSurface_Panel()

Endif
End



Window EDC_At_FermiSurface_Panel(): Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(100,100,350,450)
	ModifyPanel cbRGB=(64512,62423,1327)
	SetDrawLayer UserBack
	DrawRRect 9,19,240,200                              //Load Data
	SetDrawEnv fillfgc= (48896,49152,65280)



	SetVariable set_NamePrefix,proc=SetVarProc,pos={17,26},size={220,14},title="Name  Prefix",fSize=15
	SetVariable set_NamePrefix, value= root:EDCatFermiSurface:NamePrefix
	
	SetVariable set_ProcessFlag,proc=SetVarProc,pos={17,56},size={220,14},title="Process Flag",fSize=15
	SetVariable set_ProcessFlag, value= root:EDCatFermiSurface:ProcessFlag

	SetVariable set_Temperature,proc=SetVarProc,pos={17,86},size={220,14},title="Temperature",fSize=15
	SetVariable set_Temperature, value= root:EDCatFermiSurface:Temperature


	SetVariable set_NumberofEDCs,proc=SetVarProc,pos={17,126},size={220,14},title="No. of  EDCs",fSize=15
	SetVariable set_NumberofEDCs, value= root:EDCatFermiSurface:NumberofEDCs

	
	SetVariable set_EDCOffset,proc=SetVarProc,pos={17,165},size={220,14},title="EDC  Offset  ",fSize=15
	SetVariable set_EDCOffset, value= root:EDCatFermiSurface:EDCOffset
	
	Button buttonSetParameter,pos={30,215},size={170,25},proc=SetParameters,title="Set Parameters"
	
	Button buttonGetEDC,pos={30,255},size={170,40},proc=GetEDCatFS,title="Get EDC at FS"	
	
	Button buttonDone,pos={60,310},size={100,35},proc=DoneButtonEDC,title="Done"		
	
EndMacro



Proc SetParameters(ctrlName):ButtonControl
	String ctrlName
	String curr=GetDataFolder(1)

SetDataFolder root:EDCatFermiSurface

Make/O/N=(root:EDCatFermiSurface:NumberofEDCs) PhiAngle, ThetaAngle, EDCNumber

DoWindow InitialParameters
If(V_Flag==0)

Edit PhiAngle, ThetaAngle, EDCNumber as "Initial Parameters for Getting EDC on FS"
DoWindow/C InitialParameters
Else
DoWindow/F InitialParameters
Endif

SetdataFolder curr

End



Proc GetEDCatFS(ctrlName):BottonControl
        String ctrlName 
        
String curr=GetDataFolder(1)

SetDataFolder root:EDCatFermiSurface

Make/O/T/N=(root:EDCatFermiSurface:NumberofEDCs) EDCIntensity, EDCEnergy

Variable i=0
String TempIntensity, TempEnergy
Do

EDCIntensity[i]=NamePrefix+"F"+num2str(ProcessFlag)+"t"+num2str(Temperature)+"P"+num2str(PhiAngle[i])+"T"+num2str(ThetaAngle[i])+"N"+num2str(EDCNumber[i])
EDCEnergy[i]="E"+NamePrefix+"F"+num2str(ProcessFlag)+"t"+num2str(Temperature)+"P"+num2str(PhiAngle[i])+"T"+num2str(ThetaAngle[i])+"N"+num2str(EDCNumber[i])

Duplicate/O root:ProcessedImageSpectra:$EDCIntensity[i]    root:EDCatFermiSurface:$EDCIntensity[i]
Duplicate/O root:ProcessedImageSpectra:$EDCEnergy[i]    root:EDCatFermiSurface:$EDCEnergy[i]

i+=1
While(i<NumberofEDCS)


DoWindow EDCatFermiSurface
If (V_Flag==0)
Display $EDCIntensity[0] vs $EDCEnergy[0] as "EDC at Fermi Surface"
ModifyGraph lsize($EDCIntensity[0])=3
Variable j=1
Do
$EDCIntensity[j]+=j*EDCOffset

AppendtoGraph  $EDCIntensity[j] vs $EDCEnergy[j]
ModifyGraph lsize($EDCIntensity[j])=3;DelayUpdate
j+=1
While (j<NumberofEDCS)
Legend/C/N=text0/F=0/A=MC
ModifyGraph width={Aspect,0.5}
ModifyGraph zero(bottom)=1
Label bottom "\\Z14\\f01Energy (eV)"

DoWindow/C EDCatFermiSurface
Else 

Variable k=1
Do
$EDCIntensity[k]+=k*EDCOffset
k+=1
While (k<NumberofEDCS)

DoWindow/F EDCatFermiSurface
Endif


End

Proc DoneButtonEDC(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
       DoWindow/K EDC_At_FermiSurface_Panel
	
	SetDataFolder Curr
	
End
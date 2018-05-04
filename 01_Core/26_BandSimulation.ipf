#pragma rtGlobals=1		// Use modern global access method.

//menu "Band Simulation"
//	"-"
//	"t-J Model", TJBandDispersionPanel()
//End



Proc TJBandDispersionPanel()

	DoWindow tJ_Band_Simulation_Panel
	if (V_flag==0)
	
	       NewDataFolder/O/S root:tJBandSimulation
	       Variable/G tValue=NumVarOrDefault("root:tJBandSimulation:tValue",5)
	       Variable/G tPrimeValue=NumVarOrDefault("root:tJBandSimulation:tPrimeValue",5)
	       Variable/G tDoublePValue=NumVarOrDefault("root:tJBandSimulation:tDoublePValue",5)
	       Variable/G tTriplePValue=NumVarOrDefault("root:tJBandSimulation:tTriplePValue	",5)	       
	       Variable/G tz=NumVarOrDefault("root:tJBandSimulation:tz",5)
	       Variable/G tbi=NumVarOrDefault("root:tJBandSimulation:tbi",5)	       
	       Variable/G ChemicalPotential=NumVarOrDefault("root:tJBandSimulation:ChemicalPotential",5)
	       
	       Variable/G kxstart=NumVarOrDefault("root:tJBandSimulation:kxstart",5)
	       Variable/G kyStart=NumVarOrDefault("root:tJBandSimulation:kyStart",5)
	       Variable/G kzStart=NumVarOrDefault("root:tJBandSimulation:kzStart",5)

	       Variable/G kxEnd=NumVarOrDefault("root:tJBandSimulation:kxEnd",5)
	       Variable/G kyEnd=NumVarOrDefault("root:tJBandSimulation:kyEnd",5)
	       Variable/G kzEnd=NumVarOrDefault("root:tJBandSimulation:kzEnd",5)
	       
	       Variable/G NumberofKDispersionPoints=NumVarOrDefault("root:tJBandSimulation:NumberofKDispersionPoints",5)	       
//	       Variable/G EnergyStart=NumVarOrDefault("root:tJBandSimulation:EnergyStart",5)
//	       Variable/G EnergyEnd=NumVarOrDefault("root:tJBandSimulation:EnergyEnd",5)

//	       Variable/G NumberofEPoints=NumVarOrDefault("root:tJBandSimulation:NumberofEPoints",5)

	       String/G DispersionName=StrVarOrDefault("root:tJBandSimulation:DispersionName","")	       
		      
		   Variable/G BandType=NumVarOrDefault("root:tJBandSimulation:BandType",5)       
	       
	       
	       Variable/G NumberofOverallKPoints=NumVarOrDefault("root:tJBandSimulation:NumberofOverallKPoints",5)	  
	            
	       Variable/G EnergyofInterest=NumVarOrDefault("root:tJBandSimulation:EnergyofInterest",5)	       
	       String/G FermiSurfaceName=StrVarOrDefault("root:tJBandSimulation:FermiSurfaceName","")
	       
	       

	      
	
		tJ_Band_Simulation_Panel()
		DoWindow/C tJ_Band_Simulation_Panel	
		
		Else
		DoWindow/F tJ_Band_Simulation_Panel			
			
	    Endif
End

Window tJ_Band_Simulation_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(155,113,480,430)
	ModifyPanel cbRGB=(40960,65280,16384)
	SetDrawLayer UserBack
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,15872,65280), fsize=16
	DrawText 76,20,"Set Simulation Parameters"

	
	SetVariable val_tValue,pos={10,26},size={100,14},font="Times New Roman",title="t(eV)  ",fSize=12
	SetVariable val_tValue,limits={-Inf,Inf,1},value= root:tJBandSimulation:tValue	
	
	SetVariable val_tPrimeValue,pos={115,26},size={100,14},font="Times New Roman",title="t'(eV)",fSize=12
	SetVariable val_tPrimeValue,limits={-Inf,Inf,1},value= root:tJBandSimulation:tPrimeValue		
	
	SetVariable val_tDoublePValue,pos={220,26},size={100,14},font="Times New Roman",title="t''(eV)",fSize=12
	SetVariable val_tDoublePValue,limits={-Inf,Inf,1},value= root:tJBandSimulation:tDoublePValue	
	
	SetVariable val_tTripleP,pos={10,50},size={100,14},font="Times New Roman",title="t'''(eV)",fSize=12
	SetVariable val_tTripleP,limits={-Inf,Inf,1},value= root:tJBandSimulation:tTriplePValue	
	
		
	SetVariable val_tZ,pos={115,50},size={100,14},font="Times New Roman",title="tz(eV)",fSize=12
	SetVariable val_tZ,limits={-Inf,Inf,1},value= root:tJBandSimulation:tZ
	
	SetVariable val_tbi,pos={220,50},size={100,14},font="Times New Roman",title="tbi(eV)",fSize=12
	SetVariable val_tbi,limits={-Inf,Inf,1},value= root:tJBandSimulation:tbi	
	

	SetVariable val_ChemicalPotential,pos={10,75},size={205,14},font="Times New Roman",title="Chemical Potential (eV): ",fSize=12
	SetVariable val_ChemicalPotential,limits={-Inf,Inf,1},value= root:tJBandSimulation:ChemicalPotential


	SetVariable val_kxStart,pos={10,95},size={115,14},font="Times New Roman",title="KxStart(pi/a)",fSize=12
	SetVariable val_KxStart,limits={-Inf,Inf,1},value= root:tJBandSimulation:kxStart	
	SetVariable val_kyStart,pos={130,95},size={90,14},font="Times New Roman",title="KyStart",fSize=12
	SetVariable val_KyStart,limits={-Inf,Inf,1},value= root:tJBandSimulation:kyStart	
	SetVariable val_KzStart,pos={230,95},size={90,14},font="Times New Roman",title="KzStart",fSize=12
	SetVariable val_KzStart,limits={-Inf,Inf,1},value= root:tJBandSimulation:kzStart
	
	
			
	SetVariable val_kxEnd,pos={10,115},size={115,14},font="Times New Roman",title="KxEnd(pi/a) ",fSize=12
	SetVariable val_KxEnd,limits={-Inf,Inf,1},value= root:tJBandSimulation:kxEnd	
	SetVariable val_kyEnd,pos={130,115},size={90,14},font="Times New Roman",title="KyEnd ",fSize=12
	SetVariable val_KyEnd,limits={-Inf,Inf,1},value= root:tJBandSimulation:kyEnd	
	SetVariable val_kzEnd,pos={230,115},size={90,14},font="Times New Roman",title="KzEnd ",fSize=12
	SetVariable val_KzEnd,limits={-Inf,Inf,1},value= root:tJBandSimulation:kzEnd
	
	SetVariable val_KPoints,pos={54,135},size={200,14},font="Times New Roman",title="NumberofKPoints_Dispersion",fSize=12
	SetVariable val_KPoints,limits={-Inf,Inf,1},value= root:tJBandSimulation:NumberofKDispersionPoints	
	
	
	SetVariable val_DispersionName,pos={10,155},size={140,14},font="Times New Roman",title="DispersionPreName",fSize=12
	SetVariable val_DispersionName,limits={-Inf,Inf,1},value= root:tJBandSimulation:DispersionName	

	SetVariable val_BandType,pos={155,155},size={90,14},font="Times New Roman",title="BandType",fSize=12
	SetVariable val_BandType,limits={0,1,1},value= root:tJBandSimulation:BandType

	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,0,0), fsize=10
	DrawText 248,167,"0-Bonding"
	SetDrawEnv fname= "Times New Roman"
	SetDrawEnv textrgb= (0,0,0), fsize=10	
	DrawText 248,177,"1-AntiBonding"
	
	SetVariable val_kzEnd,pos={230,115},size={90,14},font="Times New Roman",title="KzEnd ",fSize=12
	SetVariable val_KzEnd,limits={-Inf,Inf,1},value= root:tJBandSimulation:kzEnd			
	
	Button GetSimulatedDispersion,pos={70,175},size={160,25},font="Times New Roman",proc=GetSimulatedDispersion,title="Get Simulated Dispersion"
	
	
	
////	Button GetSimulatedVelocity,pos={70,215},size={160,25},font="Times New Roman",proc=GetSimulatedVelocity,title="Show Simulated Velocity"
	




	SetVariable val_FermiSurfaceNumberofKPoints,pos={54,215},size={190,14},font="Times New Roman",title="#ofKPointsforFS",fSize=12
	SetVariable val_FermiSurfaceNumberofKPoints,limits={-Inf,Inf,1},value= root:tJBandSimulation:NumberofOverallKPoints
		
	SetVariable val_BindingEnergy,pos={54,235},size={190,14},font="Times New Roman",title="Set Binding Energy(eV)",fSize=12
	SetVariable val_BindingEnergy,limits={-Inf,Inf,1},value= root:tJBandSimulation:energyofInterest
	
	
	SetVariable val_FermiSurfaceName,pos={54,255},size={220,14},font="Times New Roman",title="Fermi Surface PreName",fSize=12
	SetVariable val_FermiSurfaceName,limits={-Inf,Inf,1},value= root:tJBandSimulation:FermiSurfaceName	
	
	
	Button GetFermiSurface,pos={70,285},size={160,25},font="Times New Roman",proc=GetFermiSurface,title="Get Fermi Surface"			
		
	
	Button DoneandExit,pos={260,275},size={60,35},font="Times New Roman",proc=DoneandExit,title="Exit"

	
	
      
EndMacro



Proc  GetSimulatedDispersion(ctrlName) : ButtonControl
	 String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:tJBandSimulation
String DispersionWindowName="tJ_"+root:tJBandSimulation:DispersionName
String DispersionE="E_"+root:tJBandSimulation:DispersionName
String Velocity="V_"+root:tJBandSimulation:DispersionName
String DispersionK="K_"+root:tJBandSimulation:DispersionName
Variable  KxS=root:tJBandSimulation:kxStart*Pi
Variable  KyS=root:tJBandSimulation:kyStart*Pi
Variable  KzS=root:tJBandSimulation:kzStart*Pi

Variable  KxE=root:tJBandSimulation:kxEnd*Pi
Variable  KyE=root:tJBandSimulation:kyEnd*Pi
Variable  KzE=root:tJBandSimulation:kzEnd*Pi

Variable  KPoint=root:tJBandSimulation:NumberofkDispersionPoints
Variable ChemicalU=root:tJBandSimulation:ChemicalPotential


Variable t0=root:tJBandSimulation:tValue
Variable t1=root:tJBandSimulation:tPrimeValue
Variable t2=root:tJBandSimulation:tDoublePValue
Variable t3=root:tJBandSimulation:tTriplePValue
Variable tz=root:tJBandSimulation:tZ
Variable tbi=root:tJBandSimulation:tbi


Make/O/N=(KPoint)  EDispersion_ab, EDispersion_c, EDispersion_All, KKx, KKy, KKz, MagnitudeofK
////SetScale x  KxS, KxE, EDispersion_ab
////SetScale x  KxS, KxE, EDispersion_c
////SetScale x  KxS, KxE, KKx
////SetScale x  KxS, KxE, KKy
////SetScale x  KxS, KxE, KKy
////SetScale x  KxS, KxE, MagnitudeofK

////KKx=x

//If (KxE==KxS)
Variable ik=0

Do
KKx[ik]=KxS+ik*(KxE-KxS)/(KPoint-1)
KKy[ik]=KyS+ik*(KyE-KyS)/(KPoint-1)
KKz[ik]=KzS+ik*(KzE-KzS)/(KPoint-1)
MagnitudeofK[ik] = sqrt((KKx[ik]-KxS)^2+(KKy[ik]-KyS)^2+(KKz[ik]-KzS)^2)/Pi

ik+=1
While (ik<KPoint)



//EDispersion=t0*1+t1*0.5*(cos(KKx)+cos(KKy))+t2*cos(KKx)*cos(KKy)+t3*0.5*(cos(2*KKx)+cos(2*KKy))+t4*0.5*(cos(2*KKx)*cos(KKy)+cos(KKx)*cos(2*KKy))+t5*cos(2*KKx)*cos(2*KKy)-ChemicalU

EDispersion_ab=-2*t0*(cos(KKx)+cos(KKy))-4*t1*cos(KKx)*cos(KKy)-2*t2*(cos(2*KKx)+cos(2*KKy))-4*t3*(cos(2*KKx)*cos(KKy)+cos(KKx)*cos(2*KKy))

//For Bi2212
Duplicate/O EDispersion_c  Sxy
Duplicate/O EDispersion_c  AzPrime
Duplicate/O EDispersion_c  TTz

Sxy=cos(KKx/2)*cos(KKy/2)
AzPrime=4*tz*Sxy

If (root:tJBandSimulation:BandType==0)

TTz=sqrt(tbi^2 + AzPrime^2 + 2*tbi*AzPrime*cos(KKz/2))
Else
TTz=-sqrt(tbi^2 + AzPrime^2 + 2*tbi*AzPrime*cos(KKz/2))
EndIf

EDispersion_c=-TTz*((cos(KKx)- cos(kky))^2/4+0.0001)

EDispersion_All=EDispersion_ab+EDispersion_c-root:tJBandSimulation:ChemicalPotential

//See reference R. S. Markiewicz et al. PRB 72(2005) 054519.


///Edit KKx, KKy,KKz, MagnitudeofK
Duplicate/O EDispersion_All root:tJBandSimulation:$DispersionE
Duplicate/O MagnitudeofK root:tJBandSimulation:$DispersionK


////Duplicate/O EDispersion root:tJBandSimulation:$Velocity
////Differentiate $Velocity


String Text0="("+num2Str(root:tJBandSimulation:kxStart)+","+num2Str(root:tJBandSimulation:kyStart)+")"+"--"+"("+num2Str(root:tJBandSimulation:kxEnd)+","+num2Str(root:tJBandSimulation:kyEnd)+")"

       DoWindow $DispersionWindowName
       
       If(V_flag==0)
	   Display $DispersionE vs $DispersionK
       TextBox/C/N=text0/F=0/A=LT Text0
       DoWindow/C $DispersionWindowName
       Else
       DoWindow/F $DispersionWindowName
       TextBox/C/N=text0/F=0/A=LT Text0
       Endif  
       ModifyGraph zero(left)=2

       
SetDataFolder Curr	
End

Proc  GetSimulatedVelocity(ctrlName) : ButtonControl
	 String ctrlName
String Curr=GetDataFolder(1)
SetDataFolder root:tJBandSimulation
String VelocityWindowName="Velocity_"+root:tJBandSimulation:DispersionName
String Velocity="V_"+root:tJBandSimulation:DispersionName
String DispersionK="K_"+root:tJBandSimulation:DispersionName

$Velocity*=3.8/Pi

////String Text0="("+num2Str(root:tJBandSimulation:kxStart)+","+num2Str(root:tJBandSimulation:kyStart)+")"+"--"+"("+num2Str(root:tJBandSimulation:kxEnd)+","+num2Str(root:tJBandSimulation:kyEnd)+")"
////
    ////   DoWindow $VelocityWindowName
       ////
       ////If(V_flag==0)
	   ////Display $Velocity vs $DispersionK
       ////TextBox/C/N=text0/F=0/A=LT Text0
       ////ModifyGraph margin(left)=72,margin(bottom)=72
       ////ModifyGraph standoff=0
       ////ModifyGraph mirror=2
       ////Label bottom "\\Z16\\f01Momentum (\\F'Symbol'p\\F'Arial'/a)"
       ////Label left "\\Z16\\f01Velocity (eV*A)"
       ////ModifyGraph lsize( $Velocity)=2
       
       
       ////DoWindow/C $VelocityWindowName
       ////Else
       ////DoWindow/F $VelocityWindowName
       ////TextBox/C/N=text0/F=0/A=LT Text0
       ////Endif  


       
SetDataFolder Curr	
End
	 
	 
	 
	 
	 
	 



Proc  GetFermiSurface(ctrlName) : ButtonControl
	 String ctrlName
String Curr=GetDataFolder(1)
 
 
       
SetDataFolder Curr	
End



Proc  DoneandExit(ctrlName) : ButtonControl
	 String ctrlName
String Curr=GetDataFolder(1)
 
 
 DoWindow/K tJ_Band_Simulation_Panel
 
       
SetDataFolder Curr	
End
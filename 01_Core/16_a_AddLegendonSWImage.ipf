#pragma rtGlobals=1		// Use modern global access method.


Function XJZLegend(ctrlName) : ButtonControl
	String ctrlName
	
       String curr=GetDataFolder(1)	
       SetDataFolder root:IMG
       
NVAR Low=root:PROCESS:LegendLow
NVAR High=root:PROCESS:LegendHigh
NVAR KyPoint=root:PROCESS:KyPointNumber

Low=0
High=1
KyPoint=10
Make/O/N=(1,KyPoint) vlegend
SetScale/I y Low,High,"", vlegend
SetScale/I x 0,1,"", vlegend
vlegend=y
Appendimage/R=vbar/B=hbar vlegend
ModifyImage vlegend ctab= {*,*,PlanetEarth,1}
ModifyGraph axisEnab(hbar)={0.98,1},freePos(vbar)={-0.5,hbar};
ModifyGraph freePos(hbar)={0,vbar}
ModifyGraph noLabel(hbar)=2,axThick(hbar)=0


      SetDataFolder curr

End
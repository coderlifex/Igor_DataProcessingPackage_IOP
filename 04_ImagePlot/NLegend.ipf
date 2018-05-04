#pragma rtGlobals=1		// Use modern global access method.

Menu "Legend"

"Make Image Legend", Legend()

End


Proc XJZLegend()
	
       String curr=GetDataFolder(1)	
       
Make/O/N=(1,100) NLegend
SetScale/I y 0,1,"", NLegend
SetScale/I x 0,1,"", NLegend
NLegend=y
Appendimage/R=vbar/B=hbar NLegend
ModifyImage NLegend ctab= {*,*,PlanetEarth,1}
ModifyGraph axisEnab(hbar)={0.98,1},freePos(vbar)={-0.5,hbar};
ModifyGraph freePos(hbar)={0,vbar}
ModifyGraph noLabel(hbar)=2,axThick(hbar)=0


      SetDataFolder curr

End
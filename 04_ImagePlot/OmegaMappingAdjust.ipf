#pragma rtGlobals=1		// Use modern global access method.
menu  "AngleCali"
	"go", AC_AngleCali()
end

proc AC_AngleCali()
dowindow/f AngleCaliPanel
if(v_flag!=1)
variable/g AC_DeltaPhi
variable/g AC_DeltaTheta
variable/g AC_Omega
variable/g AC_newDeltaPhi
variable/g AC_newDeltaTheta
variable/g AC_newOmega
 AngleCaliPanel()
endif

end

Window AngleCaliPanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(919,401,1260,597)
	ShowTools/A
	SetVariable DeltaPhi,pos={26,37},size={104,18},title="DeltaPhi"
	SetVariable DeltaPhi,value= AC_DeltaPhi
	SetVariable Omega,pos={99,5},size={108,18},title="Omega",value= AC_Omega
	Button AngleCalibate,pos={94,109},size={102,33},proc=AC_AngleCalc,title="AngleCalibate"
	SetVariable NewDeltaPhi,pos={2,157},size={153,18},title="NewDeltaPhi"
	SetVariable NewDeltaPhi,value= AC_newDeltaPhi
	SetVariable NewOmega,pos={91,79},size={128,18},title="NewOmega"
	SetVariable NewOmega,value= AC_newOmega
	SetVariable DeltaTheta,pos={165,37},size={125,18},title="DeltaTheta"
	SetVariable DeltaTheta,value= AC_DeltaTheta
	SetVariable NewDeltaTheta,pos={171,155},size={162,18},title="NewDeltaTheta"
	SetVariable NewDeltaTheta,value= AC_newDeltaTheta
EndMacro

function AC_AngleCalc(ctrlName) : ButtonControl
String ctrlName

nvar DeltaPhi=AC_DeltaPhi
nvar DeltaTheta=AC_DeltaTheta
nvar Omega=AC_Omega
nvar Phi_Angle=AC_newDeltaPhi
nvar Theta_Angle=AC_newDeltaTheta
nvar Omega_Angle=AC_newOmega

 	DeltaPhi*=pi/180
	DeltaTheta*=pi/180
	Omega*=pi/180
	Omega_Angle*=pi/180

variable DeltaOmega=Omega_Angle-Omega
variable x, y, x1,y1
x=sin(DeltaTheta)*cos(DeltaPhi)
y=-sin(DeltaPhi)
x1=cos(DeltaOmega)*x-sin(DeltaOmega)*y
y1=sin(DeltaOmega)*x+cos(DeltaOmega)*y
Phi_Angle=-asin(y1)*180/pi
Theta_Angle=asin(x1/sqrt(1-y1^2))*180/pi
Theta_Angle=round(Theta_Angle*100)/100
Phi_Angle=round(Phi_Angle*100)/100

 	DeltaPhi*=180/pi
	DeltaTheta*=180/pi
	Omega*=180/pi
	Omega_Angle*=180/pi

end

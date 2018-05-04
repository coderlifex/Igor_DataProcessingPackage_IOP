#pragma rtGlobals=1		// Use modern global access method.

//Usage:calulate the map area by ARTof
//Principle: An energy of hv produce a related emmited electron sphere with radius of K0. The projected area can be 
//obtained by cutting this shpere with a plane which is defined by the vector(kx,ky,kz) which corresponds to center of 
//the analyser window( defined by omega,theta,phi and K0).

function calculate_map_area()

nvar PhotonE=root:MomentumMap:PhotonEnergy
nvar WorkFunc= root:MomentumMap:WorkFunction
nvar LC=root:MomentumMap:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
nvar RAngle=root:MomentumMap:RotationAngle
nvar Theta0=root:MomentumMap:ThetaAngle
nvar Phi0=root:MomentumMap:PhiAngle
nvar DetectorAngle0=root:MomentumMap:DetectorAngle
nvar artofflag=root:MomentumMap:ARToFFlag
nvar BZShowmode=root:MomentumMap:BZShowMode
nvar fromline2artof=root:MomentumMap:fromline2artof

dowindow/F MomentumMap
variable xmin,xinc,ymin,yinc

if(BZShowmode==0)

make/O/N=(200,200) artof_area=0
xmin=-1
ymin=-1
xinc=0.01
yinc=0.01

setscale x,-1,1,artof_area
setscale y,-1,1,artof_area

endif 

if((BZShowmode==1)||(BZShowmode==2))

make/O/N=(400,400) artof_area=0
xmin=-2
ymin=-2
xinc=0.01
yinc=0.01

setscale x,-2,2,artof_area
setscale y,-2,2,artof_area

endif

variable RK0=K0*sin(3.1416/180*(DetectorAngle0/2))



variable k_o=K0*cos(3.1416/180*(DetectorAngle0/2))
variable kx=K_o*sin(3.1416/180*Phi0)
variable ky=K_o*sin(3.1416/180*Theta0)*cos(3.1416/180*Phi0)
variable kz=K_o*cos(3.1416/180*Theta0)*cos(3.1416/180*Phi0)

variable Rkx=sqrt(kx*kx+ky*ky)*cos((atan2(ky,kx))+RAngle*pi/180)
variable Rky=sqrt(kx*kx+ky*ky)*sin((atan2(ky,kx))+RAngle*pi/180)
variable Rkz=kz
//print Rkx,Rky,"RRR"
variable xx,yy,zz
variable ii=0,jj=0
do
	jj=0
	do
		
		xx=xmin+ii*xinc
		yy=ymin+jj*yinc
		
		if(Rkz!=0)
		zz=Rkz-(Rkx*xx+Rky*yy-Rkx*Rkx-Rky*Rky)/Rkz
			
			if((xx*xx+yy*yy+zz*zz)<=K0*K0)	
		    artof_area[ii][jj]=1
		
		    endif
		endif
		
		if(Rkz==0)
		
			if((Rkx==0)&&(Rky!=0))
		
		    	if(abs(yy-Rky)<=0.01)
		    		if(xx*xx<=K0*K0-yy*yy)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		    
		    if((Rkx!=0)&&(Rky==0))
		    	
		    	if(abs(xx-Rky)<=0.01)
		    		if(yy*yy<=K0*K0-xx*xx)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		    
		    if((Rkx!=0)&&(Rky!=0))
		    
		    	if(abs(Rkx*xx+Rky*yy-Rkx*Rkx-Rky*Rky)<=0.01)
		    		if((xx*xx+yy*yy)<=K0*K0)
		    		artof_area[ii][jj]=1
		    		endif
		    	endif
		    endif
		endif
		    
		
		
	jj+=1
	while(jj<400)
	ii+=1
while(ii<400)


string ctrlName=""
	
	if(BZShowmode==0)
	if((V_Flag==0)||(fromline2artof==1))
		dowindow/K MomentumMap
		Display/K=1 as "Momentum Map";AppendImage artof_area
		XJZSecondBZ(ctrlName)
		ModifyImage artof_area ctab= {*,*,Terrain256,1}
		ModifyGraph standoff=0
		ModifyGraph rgb=(0,0,0)
		ModifyGraph lsize=2
		ModifyGraph fStyle=1
		ModifyGraph width={Aspect,1}
		Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		ModifyGraph width=368.504,height=368.504
		dowindow/C MomentumMap
		fromline2artof=0
	endif
	
	RemoveFromGraph/Z Hexy
	SetAxis bottom -1,1 
    SetAxis left -1,1  
	endif

	if(BZShowmode==1)
	if((V_Flag==0)||(fromline2artof==1))
	dowindow/K MomentumMap
	Display/K=1 as "Momentum Map";AppendImage artof_area
	XJZSecondBZ(ctrlName)
	ModifyImage artof_area ctab= {*,*,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=2
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMap
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	SetAxis bottom -2,2 
    SetAxis left -2,2 
	endif
	
    IF (BZShowmode==2)    
	if((V_Flag==0)||(fromline2artof==1))
	dowindow/K MomentumMap
	Display/K=1 as "Momentum Map";AppendImage artof_area
	XJZSecondBZ(ctrlName)
	ModifyImage artof_area ctab= {*,*,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=2
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMap
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	XJZThirdBZ(ctrlName)      
	ModifyGraph rgb(Hexy)=(0,65280,0) 
    ModifyGraph lsize(Hexy)=2  
    
	SetAxis bottom -2,2 
    SetAxis left -2,2 	                              
    ENDIF


end



Function fromlinetoartof(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar aaa=root:MomentumMap:fromline2artof
	
	aaa=1


End

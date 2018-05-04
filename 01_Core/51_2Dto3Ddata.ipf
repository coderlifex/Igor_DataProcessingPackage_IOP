#pragma rtGlobals=1		// Use modern global access method.
#include <All Gizmo Procedures>


function interp2d_image1(ctrlname):ButtonControl
	string ctrlname
	
	
	variable ttt=ticks
	Execute "creatfolderandvariablefor3D()"
	///////////edc and mdc2nd 
	nvar mdc2d=root:PROCESS:mdc2d
	nvar edc2d=root:PROCESS:edc2d
	if(mdc2d||edc2d)
	edcandmdc2nd()
	endif
	////////////////////
	
	setdatafolder root:PROCESS
	//nvar PhotonE=root:ARToFData:PhotonEnergy
	//nvar WorkFunc=root:ARToFData:WorkFunction
	//nvar LC=root:ARToFData:LatticeConstant
	svar nameprefix=root:PROCESS:NewNamePreFix
	nvar processedimageflag=root:PROCESS:ProcessedImageFlag
	string filterstr=nameprefix+"F"+num2str(processedimageflag)
	
	//string namelist=wavelist("!image*",";","DIMS:2")
	string namelist=wavelist(filterstr+"*",";","DIMS:2")
	
	//string namelist=wavelist("!image*",";","DIMS:2")
	variable itemnum,ii=0,jj=0,kk=0
	variable kpnts,energypnts
	
	//itemnum=itemsinlist(namelist)
	string tmpstr=stringfromlist(0,namelist)
	kpnts=dimsize($tmpstr,1)
	energypnts=dimsize($tmpstr,0)
	
	variable detect_s0,detect_e0,phidel,detect_s,detect_e
	detect_s0=dimoffset($tmpstr,1)
	detect_e0=dimoffset($tmpstr,1)+(dimsize($tmpstr,1)-1)*dimdelta($tmpstr,1)
	phidel=dimdelta($tmpstr,1)
	
	variable Emin,Einc
	Emin=dimoffset($tmpstr,0)
	Einc=dimdelta($tmpstr,0)
	
	
	
	wave theta_angle=root:OriginalData:Theta_Angle
	wave phi_angle=root:OriginalData:Phi_Angle
	wave omega_angle=root:OriginalData:Omega_Angle
	wave processflag=root:OriginalData:ProcessFlag
	wave intensityscale=root:OriginalData:intensityscale /////不同phi角scale值不一样
	//nvar processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar thetaoffset=root:PROCESS:ThetaOffset
	nvar phioffset=root:PROCESS:PhiOffset
	nvar omegaoffset=root:PROCESS:OmegaOffset
	nvar offsettheta=root:ARToFData:offsettheta
	nvar offsetomega=root:ARToFData:offsetomega
	nvar offsetphi=root:ARToFData:offsetphi
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	nvar showprogress=root:PROCESS:showprogress
	
	offsettheta=thetaoffset
	offsetomega=omegaoffset
	offsetphi=phioffset
	
	nvar kxpntnum=root:PROCESS:KxPointNumber
	nvar kypntnum=root:PROCESS:KyPointNumber
	
	
	variable theta_value,theta0,thetaexist=0,ll,thetapos,thetaposl,thetaposr,theta1,theta2,namda,vphi1,vphi2
	string tmpstr1,tmpstr2,imagethetaorder,imagename111
	variable firstimage=0,iexist=0,xxx,xxxmedia,theta_gap,thetapnts
	variable thetamin,thetamax,phimin,phimax,theta_del
	svar nameprestr=root:ARToFData:nameprestr
	//created3dwavename=nameprestr+"F"+	num2str(processedimageflag)+"Cuts2Dto3D"
	
	variable theta_start,theta_end,Phi0,RAngle,datapntnum,ifind1=0,ifind2,phinum=0
	string phianglelistname=nameprestr+"F"+num2str(processedimageflag)+"phianglelist"
	make/O/N=10 $phianglelistname,scalenum
	//make/O/N=500 thetawave=0
	wave phianglelist=$phianglelistname

	datapntnum=dimsize(theta_angle,0)
	
	variable iifirstphi=1
	ii=0
	variable iii
	do
		if(processedimageflag==processflag[ii])
			
			if(iifirstphi==1)
			phianglelist[phinum]=phi_angle[ii]
			scalenum[phinum]=intensityscale[ii]
			phinum+=1
			iifirstphi=0
			endif
			
			if(iifirstphi==0)
				iii=0
				do
					if(phianglelist[iii]==phi_angle[ii])
					break
					endif
				iii+=1
				while(iii<phinum)
				
				if(iii==phinum)
				phianglelist[phinum]=phi_angle[ii]
				scalenum[phinum]=intensityscale[ii]
				phinum+=1
				endif
			endif	
			
		endif
		ii+=1
	while(ii<datapntnum)
	redimension/N=(phinum) phianglelist,scalenum
	duplicate/O phianglelist root:ARToFData:$phianglelistname
	variable iiphi=0,currphi,thetanum


	////////////////begin to creat prepare 2D image
	string thetawavestr
	variable xx,yy,totaltime,currtime,now,justnow,timeused,ttt1=0,ttt2=0,ttt3=0,ttt4=0
	svar timeremain=root:PROCESS:timeremain
	
	//totaltime=thetapnts*phinum+energypnts
	currtime=0
	justnow=ticks
	do
	currphi=phianglelist[iiphi]
	ifind1=0
	thetanum=0
	ii=0


	


	//theta_start=theta_angle[ifind2-ifind1+1]
	//theta_end=theta_angle[ifind2]

//print phiangle
//print ifind1,ifind2,theta_start,theta_end
	//ii=0
	//do
	//	if((processedimageflag==processflag[ii])&&(phi_angle[ii]==currphi))
	//		if(theta_start>theta_angle[ii])
	//		theta_start=theta_angle[ii]
	//		endif
			
	//		if(theta_end<theta_angle[ii])
	//		theta_end=theta_angle[ii]
	//		endif
//		endif
//		ii+=1
//	while(ii<datapntnum)
//print ifind1,ifind2,theta_start,theta_end,Phi0,Rangle 

////offset将有3D处理面板中读入
//theta_start=theta_start-thetaoffset
//theta_end=theta_end-thetaoffset






//print theta_start,theta_end,kpnts,itemnum,energypnts
//creat Image111
if(currphi<0)
imagethetaorder="imagethetaorderPhiN"+num2str(-currphi*10)
thetawavestr="thetawavestr"+num2str(-currphi*10)
else
imagethetaorder="imagethetaorderPhiP"+num2str(currphi*10)
thetawavestr="thetawavestr"+num2str(currphi*10)
endif
make/O/N=500	$imagethetaorder,$thetawavestr
wave image_theta_order=root:PROCESS:$imagethetaorder
wave thetawave=root:PROCESS:$thetawavestr

wave/T processimage=root:OriginalData:ProcessedImage

ii=0
	do
		if((processedimageflag==processflag[ii])&&(phi_angle[ii]==currphi))
		thetawave[ifind1]=theta_angle[ii]
	
		image_theta_order[ifind1]=ii
		ifind1+=1
		endif
		ii+=1
		
	while(ii<datapntnum)
	
	
	thetanum=ifind1
	//print thetanum
	
	redimension/N=(thetanum) thetawave,image_theta_order
	sort thetawave,image_theta_order
	
	theta_start=theta_angle[image_theta_order[0]]
	theta_end=theta_angle[image_theta_order[thetanum-1]]

//ii=0
//jj=0
kk=0
//	jj=0
//	do
//		if(processedimageflag==processflag[jj]&&(phi_angle[jj]==currphi))
//		image_theta_order[ii]=jj
//		ii+=1
//		endif
//		jj+=1
//	while(jj<datapntnum)

//ii=0
//jj=0



//do
	
//	jj=ii
//	do
//		if(Theta_Angle[image_theta_order[jj]]<Theta_Angle[image_theta_order[ii]])
//			xxxmedia=image_theta_order[ii]
//			image_theta_order[ii]=image_theta_order[jj]
//			image_theta_order[jj]=xxxmedia
//		endif
//		jj+=1
//	while(jj<thetanum)
//	ii+=1
//while(ii<thetanum)

if(iiphi==0)
thetamin=Theta_Angle[image_theta_order[0]]
thetamax=Theta_Angle[image_theta_order[thetanum-1]]
else
thetamin=min(thetamin,Theta_Angle[image_theta_order[0]])
thetamax=max(thetamax,Theta_Angle[image_theta_order[thetanum-1]])
endif

//print thetamin,thetamax
theta_gap=10//Theta_Angle[image_theta_order[1]]-Theta_Angle[image_theta_order[0]]
//ii=2
ii=1
do
	if(abs(Theta_Angle[image_theta_order[ii]]-Theta_Angle[image_theta_order[ii-1]])>0.01)///If waves have same theta value, 
	if(theta_gap>Theta_Angle[image_theta_order[ii]]-Theta_Angle[image_theta_order[ii-1]])///only the first wave is used!
		theta_gap=Theta_Angle[image_theta_order[ii]]-Theta_Angle[image_theta_order[ii-1]]///by JXW
	endif																						///2011-08-04 		
	endif
ii+=1
while(ii<thetanum)

//if(theta_gap==0)
//abort "Errors: thetas with the same value exist!!"
//endif

//print theta_gap,"\r***\r"

thetapnts=round((Theta_end-Theta_start)/theta_gap)+1
if(currphi<0)
imagename111="imagePhiN"+num2str(-currphi*10)
else
imagename111="imagePhiP"+num2str(currphi*10)
endif

//print Theta_start,Theta_end,theta_gap////debug
make/O/N=(kpnts,thetapnts,energypnts) $imagename111
wave image111=root:PROCESS:$imagename111
//print energypnts///////////////////////////////////debug
theta0=theta_angle[image_theta_order[0]]


ii=0
jj=0
kk=0
ll=0
//variable xx,yy,totaltime,currtime
totaltime=thetapnts*phinum+energypnts
//currtime=0
do
	//showprogress=(ii+1)/thetapnts*100
	
	now=ticks
	currtime+=1
	showprogress=(currtime)/totaltime*100
	ttt4=ttt3
	ttt3=ttt2
	ttt2=ttt1
	ttt1=now-justnow
	justnow=now
	timeused=(ttt1+ttt2+ttt3+ttt4)/240*(totaltime-currtime)
	sprintf timeremain,"%2.0f : %2.0f",floor(timeused/60),timeused-floor(timeused/60)*60
	ValDisplay showprogress1,win=ARPES_Analysis,value= #"root:PROCESS:showprogress"
	setvariable showprogress2,win=ARPES_Analysis,value= root:PROCESS:timeremain
	//lasttime=now-justnow
	//justnow=now
	
	theta_value=theta0+ii*theta_gap
	thetaexist=0
	
	ll=0
	do
	if(theta_value==theta_angle[image_theta_order[ll]])
	thetaexist=1
	thetapos=ll
	break
	endif
	ll+=1
	while(ll<thetanum)

//print thetaexist		
	if(thetaexist==0)
	ll=0
	do
		if(theta_value<theta_angle[image_theta_order[ll]])
		thetaposl=ll-1
		thetaposr=ll
		break
		endif
		ll+=1
	while(ll<thetanum)
	endif

	if(thetaexist==1)
	tmpstr=processimage[image_theta_order[thetapos]]
	wave tmp=$tmpstr
	endif
	
	if(thetaexist==1)
	jj=0
		do
			kk=0
			////解决不同image不同能量点和不同step的bug JXW 2011-06-28
		
			yy=detect_s0+jj*phidel
			////解决不同image不同能量点和不同step的bug JXW 2011-06-28
			do
			//image111[jj][ii][kk]=tmp[kk][jj]
			xx=Emin+Einc*kk ////解决不同image不同能量点和不同step的bug JXW 2011-06-28
			image111[jj][ii][kk]=interp2d(tmp,xx,yy) ////解决不同image不同能量点和不同step的bug JXW 2011-06-28
			kk+=1
			while(kk<energypnts)
		jj+=1
	while(jj<kpnts)
	endif
	
	if(thetaexist==0)
	jj=0
			do
			kk=0
			////解决不同image不同能量点和不同step的bug JXW 2011-06-28
			
			yy=detect_s0+jj*phidel
			////解决不同image不同能量点和不同step的bug JXW 2011-06-28
			do
			
				theta1=theta_angle[image_theta_order[thetaposl]]
				theta2=theta_angle[image_theta_order[thetaposr]]
				tmpstr1=processimage[image_theta_order[thetaposl]]
				tmpstr2=processimage[image_theta_order[thetaposr]]
				wave tmp1=$tmpstr1
				wave tmp2=$tmpstr2
				namda=(theta2-theta_value)/(theta_value-theta1)
				//image111[jj][ii][kk]=(tmp2[kk][jj]+namda*tmp1[kk][jj])/(1+namda)
				xx=Emin+Einc*kk
				image111[jj][ii][kk]=(interp2d(tmp2,xx,yy)+namda*interp2d(tmp1,xx,yy))/(1+namda)
			
			kk+=1
			while(kk<energypnts)
		jj+=1
	while(jj<kpnts)
	endif
ii+=1
while(ii<thetapnts)

	
image111*=scalenum[iiphi]

detect_s=detect_s0-phianglelist[iiphi]
detect_e=detect_e0-phianglelist[iiphi]


			
theta_del=(theta_end-theta_start)/(thetapnts-1)

//setscale/I x,detect_s,phidel,image111
setscale/I x,detect_s,detect_e,image111		
setscale/P y,theta_start,theta_del,image111
//setscale/P z,dimoffset(tmp,0),dimdelta(tmp,0),image111
setscale/P z,dimoffset(tmp,0),Einc,image111
iiphi+=1

while(iiphi<phinum)


string created3dwavename
svar nameprestr=root:ARToFData:nameprestr
created3dwavename=nameprestr+"F"+	num2str(processedimageflag)+"Cuts2Dto3D"
make/O/N=(kxpntnum,kypntnum,energypnts) root:ARToFData:$created3dwavename
svar namestrfor3D=root:ARToFData:namestrfor3D
namestrfor3D=created3dwavename

wave image222=root:ARToFData:$created3dwavename
//print kxpntnum,kypntnum
image222=0
phimin=wavemin(phianglelist)
phimax=wavemax(phianglelist)

variable kxinc,kyinc

//theta_del=(theta_end-theta_start)/(thetapnts-1)
//print detect_s,detect_e

//////容易引起NaN插值。offset将在3D程序面板中处理
//detect_s=detect_s-phiangle+phioffset
//detect_e=detect_e-phiangle+phioffset
//detect_s=detect_s0-phiangle
//detect_e=detect_e0-phiangle
detect_s=detect_s0-phimax
detect_e=detect_e0-phimin




oriphistart=detect_s////////后续处理
oriphiend=detect_e
orithetastart=thetamin////需要处理。。。。。。。。
orithetaend=thetamax
//////容易引起NaN插值。offset将在3D程序面板中处理
kxinc=(detect_e-detect_s)/(kxpntnum-1)
//kyinc=(theta_end-theta_start)/(kypntnum-1)
kyinc=(thetamax-thetamin)/(kypntnum-1)
//variable mediavalue
//mediavalue=detect_s
//detect_s=-detect_e-phiangle+phioffset
//detect_e=-mediavalue-phiangle+phioffset
///////////////////////
//setscale x,detect_s,detect_e,image111,image222
//print detect_s,detect_e
//setscale/P x,detect_s,phidel,image111
//setscale/P x,detect_s,phidel,image111
//setscale x,detect_s,detect_e,image222
setscale/I x,detect_s,detect_e,image222
//setscale y,theta_start,theta_end,image111,image222
//setscale/P y,theta_start,theta_del,image111
//...setscale y,theta_start,theta_end,image222
setscale/I y,thetamin,thetamax,image222
//setscale/P z,dimoffset(tmp,0),dimdelta(tmp,0),image222
setscale/P z,dimoffset(tmp,0),Einc,image222

//print theta_start,theta_end

string image3Dlist,imagestr
image3Dlist=wavelist("imagePhi*",";","DIMS:3")
variable kx,ky,ee,counter
ii=0;jj=0;kk=0;iii=0
//nvar showprogress=root:PROCESS:showprogress
////----------------////新添加
variable imageitems=itemsinlist(image3Dlist)
if(imageitems==1)
imagestr=stringfromlist(0,image3Dlist)
wave tmp111=$imagestr
endif

if(imageitems==2)
imagestr=stringfromlist(0,image3Dlist)
wave tmp111=$imagestr

imagestr=stringfromlist(1,image3Dlist)
wave tmp222=$imagestr
endif

if(imageitems==3)
imagestr=stringfromlist(0,image3Dlist)
wave tmp111=$imagestr

imagestr=stringfromlist(1,image3Dlist)
wave tmp222=$imagestr

imagestr=stringfromlist(2,image3Dlist)
wave tmp333=$imagestr
endif

if(imageitems==4)
imagestr=stringfromlist(0,image3Dlist)
wave tmp111=$imagestr

imagestr=stringfromlist(1,image3Dlist)
wave tmp222=$imagestr

imagestr=stringfromlist(2,image3Dlist)
wave tmp333=$imagestr

imagestr=stringfromlist(3,image3Dlist)
wave tmp444=$imagestr
endif

if(imageitems==5)
imagestr=stringfromlist(0,image3Dlist)
wave tmp111=$imagestr

imagestr=stringfromlist(1,image3Dlist)
wave tmp222=$imagestr

imagestr=stringfromlist(2,image3Dlist)
wave tmp333=$imagestr

imagestr=stringfromlist(3,image3Dlist)
wave tmp444=$imagestr

imagestr=stringfromlist(4,image3Dlist)
wave tmp555=$imagestr
endif

variable value1,value2,value3,value4,value5
////--------------------------//////////////新添加
if(imageitems==1)
ii=0;jj=0;kk=0;iii=0
do
	//currtime+=1
	//showprogress=(currtime)/totaltime*100
	//showprogress=(ii+1)/energypnts*100
	//ValDisplay showprogress1,value= #"root:PROCESS:showprogress"
	now=ticks
	currtime+=1
	showprogress=(currtime)/totaltime*100
	ttt4=ttt3
	ttt3=ttt2
	ttt2=ttt1
	ttt1=now-justnow
	justnow=now
	timeused=(ttt1+ttt2+ttt3+ttt4)/240*(totaltime-currtime)
	sprintf timeremain,"%2.0f : %2.0f",floor(timeused/60),timeused-floor(timeused/60)*60
	ValDisplay showprogress1,win=ARPES_Analysis,value= #"root:PROCESS:showprogress"
	setvariable showprogress2,win=ARPES_Analysis,value= root:PROCESS:timeremain
	
	ee=Emin+ii*Einc
	jj=0
	do
		kk=0
		do
		kx=detect_s+kk*kxinc
		//ky=theta_start+jj*kyinc
		ky=thetamin+jj*kyinc
			
				///----------------------//////
				//iii=0
				//counter=0
				//do
					//imagestr=stringfromlist(iii,image3Dlist)
					//if(cmpstr("NaN",num2str(interp3D(tmp111,kx,ky,ee))))
						image222[kk][jj][ii]+=interp3D(tmp111,kx,ky,ee)
						//counter+=1
					//endif
			
				//iii+=1
				//while(iii<phinum)
			
				//if(counter)
				//	image222[kk][jj][ii]/=counter
				//endif
			///----------------------//////
		kk+=1
		while(kk<kxpntnum)
		jj+=1
	while(jj<kypntnum)
	ii+=1
while(ii<energypnts)
endif

if(imageitems==2)
ii=0;jj=0;kk=0;iii=0
do
	now=ticks
	currtime+=1
	showprogress=(currtime)/totaltime*100
	ttt4=ttt3
	ttt3=ttt2
	ttt2=ttt1
	ttt1=now-justnow
	justnow=now
	timeused=(ttt1+ttt2+ttt3+ttt4)/240*(totaltime-currtime)
	sprintf timeremain,"%2.0f : %2.0f",floor(timeused/60),timeused-floor(timeused/60)*60
	ValDisplay showprogress1,win=ARPES_Analysis,value= #"root:PROCESS:showprogress"
	setvariable showprogress2,win=ARPES_Analysis,value= root:PROCESS:timeremain
	
	ee=Emin+ii*Einc
	jj=0
	do
		kk=0
		do
		kx=detect_s+kk*kxinc
		//ky=theta_start+jj*kyinc
		ky=thetamin+jj*kyinc
			
				///----------------------//////
				
				counter=0
				
					value1=interp3D(tmp111,kx,ky,ee)
					value2=interp3D(tmp222,kx,ky,ee)
					
					if(numtype(value1)==0)
						image222[kk][jj][ii]+=value1
						counter+=1
					endif
					
					if(numtype(value2)==0)
						image222[kk][jj][ii]+=value2
						counter+=1
					endif
				
			
				if(counter)
					image222[kk][jj][ii]/=counter
				endif
			///----------------------//////
		kk+=1
		while(kk<kxpntnum)
		jj+=1
	while(jj<kypntnum)
	ii+=1
while(ii<energypnts)
endif

if(imageitems==3)
ii=0;jj=0;kk=0;iii=0
do
	now=ticks
	currtime+=1
	showprogress=(currtime)/totaltime*100
	ttt4=ttt3
	ttt3=ttt2
	ttt2=ttt1
	ttt1=now-justnow
	justnow=now
	timeused=(ttt1+ttt2+ttt3+ttt4)/240*(totaltime-currtime)
	sprintf timeremain,"%2.0f : %2.0f",floor(timeused/60),timeused-floor(timeused/60)*60
	ValDisplay showprogress1,win=ARPES_Analysis,value= #"root:PROCESS:showprogress"
	setvariable showprogress2,win=ARPES_Analysis,value= root:PROCESS:timeremain
	
	ee=Emin+ii*Einc
	jj=0
	do
		kk=0
		do
		kx=detect_s+kk*kxinc
		//ky=theta_start+jj*kyinc
		ky=thetamin+jj*kyinc
			
				///----------------------//////
				//iii=0
				counter=0
				
					value1=interp3D(tmp111,kx,ky,ee)
					value2=interp3D(tmp222,kx,ky,ee)
					value3=interp3D(tmp333,kx,ky,ee)
					
					if(numtype(value1)==0)
						image222[kk][jj][ii]+=value1
						counter+=1
					endif
					
					if(numtype(value2)==0)
						image222[kk][jj][ii]+=value2
						counter+=1
					endif
					
					if(numtype(value3)==0)
						image222[kk][jj][ii]+=value3
						counter+=1
					endif
				
			
				if(counter)
					image222[kk][jj][ii]/=counter
				endif
			///----------------------//////
		kk+=1
		while(kk<kxpntnum)
		jj+=1
	while(jj<kypntnum)
	ii+=1
while(ii<energypnts)
endif


if(imageitems==4)
ii=0;jj=0;kk=0;iii=0
do
	now=ticks
	currtime+=1
	showprogress=(currtime)/totaltime*100
	ttt4=ttt3
	ttt3=ttt2
	ttt2=ttt1
	ttt1=now-justnow
	justnow=now
	timeused=(ttt1+ttt2+ttt3+ttt4)/240*(totaltime-currtime)
	sprintf timeremain,"%2.0f : %2.0f",floor(timeused/60),timeused-floor(timeused/60)*60
	ValDisplay showprogress1,win=ARPES_Analysis,value= #"root:PROCESS:showprogress"
	setvariable showprogress2,win=ARPES_Analysis,value= root:PROCESS:timeremain
	
	ee=Emin+ii*Einc
	jj=0
	do
		kk=0
		do
		kx=detect_s+kk*kxinc
		//ky=theta_start+jj*kyinc
		ky=thetamin+jj*kyinc
			
				///----------------------//////
				//iii=0
				counter=0
				
					value1=interp3D(tmp111,kx,ky,ee)
					value2=interp3D(tmp222,kx,ky,ee)
					value3=interp3D(tmp333,kx,ky,ee)
					value4=interp3D(tmp444,kx,ky,ee)
					
					if(numtype(value1)==0)
						image222[kk][jj][ii]+=value1
						counter+=1
					endif
					
					if(numtype(value2)==0)
						image222[kk][jj][ii]+=value2
						counter+=1
					endif
					
					if(numtype(value3)==0)
						image222[kk][jj][ii]+=value3
						counter+=1
					endif
					
					if(numtype(value4)==0)
						image222[kk][jj][ii]+=value4
						counter+=1
					endif
				
			
				if(counter)
					image222[kk][jj][ii]/=counter
				endif
			///----------------------//////
		kk+=1
		while(kk<kxpntnum)
		jj+=1
	while(jj<kypntnum)
	ii+=1
while(ii<energypnts)
endif

if(imageitems==5)
ii=0;jj=0;kk=0;iii=0
do
	now=ticks
	currtime+=1
	showprogress=(currtime)/totaltime*100
	ttt4=ttt3
	ttt3=ttt2
	ttt2=ttt1
	ttt1=now-justnow
	justnow=now
	timeused=(ttt1+ttt2+ttt3+ttt4)/240*(totaltime-currtime)
	sprintf timeremain,"%2.0f : %2.0f",floor(timeused/60),timeused-floor(timeused/60)*60
	ValDisplay showprogress1,win=ARPES_Analysis,value= #"root:PROCESS:showprogress"
	setvariable showprogress2,win=ARPES_Analysis,value= root:PROCESS:timeremain
	
	
	ee=Emin+ii*Einc
	jj=0
	do
		kk=0
		do
		kx=detect_s+kk*kxinc
		//ky=theta_start+jj*kyinc
		ky=thetamin+jj*kyinc
			
				///----------------------//////
				//iii=0
				counter=0
				
					value1=interp3D(tmp111,kx,ky,ee)
					value2=interp3D(tmp222,kx,ky,ee)
					value3=interp3D(tmp333,kx,ky,ee)
					value4=interp3D(tmp444,kx,ky,ee)
					value5=interp3D(tmp555,kx,ky,ee)
					
					if(numtype(value1)==0)
						image222[kk][jj][ii]+=value1
						counter+=1
					endif
					
					if(numtype(value2)==0)
						image222[kk][jj][ii]+=value2
						counter+=1
					endif
					
					if(numtype(value3)==0)
						image222[kk][jj][ii]+=value3
						counter+=1
					endif
					
					if(numtype(value4)==0)
						image222[kk][jj][ii]+=value4
						counter+=1
					endif
					
					if(numtype(value5)==0)
						image222[kk][jj][ii]+=value5
						counter+=1
					endif
				
			
				if(counter)
					image222[kk][jj][ii]/=counter
				endif
			///----------------------//////
		kk+=1
		while(kk<kxpntnum)
		jj+=1
	while(jj<kypntnum)
	ii+=1
while(ii<energypnts)
endif



//duplicate/O image222 Cuts2Dto3D
string killwavelist
killwavelist=wavelist("image*",";","DIMS:3")
iii=0
do
	imagestr=stringfromlist(iii,killwavelist)
	killwaves/Z $imagestr ////debug
	iii+=1
while(iii<phinum)

killwavelist=wavelist("image*",";","DIMS:2")
iii=0
do
	imagestr=stringfromlist(iii,killwavelist)
	killwaves/Z $imagestr
	iii+=1
while(iii<itemsinlist(killwavelist))

killwavelist=wavelist("*",";","DIMS:1")
iii=0
do
	imagestr=stringfromlist(iii,killwavelist)
	killwaves/Z $imagestr////debug
	iii+=1
while(iii<itemsinlist(killwavelist))

killwaves/Z scalenum,$phianglelistname////debug


////recover edc or mdc2nd images
if(edc2d||mdc2d)
recoverorginalimage()
endif
/////////////////////创建kxky区域/////////////////////////////////
	
	
	setdatafolder root:ARToFData
	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc=root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	nvar PhotonE_O=root:PROCESS:PhotonEnergy
	nvar WorkFunc_O=root:PROCESS:WorkFunction
	nvar LC_O=root:PROCESS:LatticeConstant
	
	PhotonE=PhotonE_O
	WorkFunc=WorkFunc_O
	LC=LC_O

	cut2d_area()
	dowindow/F VisualizeARToFData
////////////////////////创建kxky区域/////////////////////////////////
//print (ticks-ttt)/60
end

///////////////////////////////////////////////////////////////////////
function cut2d_area()
	
	setdatafolder root:ARToFData
	
	nvar BZShowmode=root:ARToFData:BZShowMode
	nvar fromline2artof=root:MomentumMap:fromline2artof
	
	svar nameprestr=root:ARToFData:nameprestr
	nvar processedimageflag=root:PROCESS:ProcessedImageFlag
	string phianglelistname=nameprestr+"F"+num2str(processedimageflag)+"phianglelist"
	wave phiangle=root:ARToFData:$phianglelistname
	variable ii,phinum
	//string areaname
	
	if(BZShowmode==0)
	make/O/N=(200,200) cuts2d_area=0
	setscale/I x,-1,1,cuts2d_area
	setscale/I y,-1,1,cuts2d_area
	endif 

	if((BZShowmode==1)||(BZShowmode==2))
	make/O/N=(400,400) cuts2d_area=0
	setscale/I x,-2,2,cuts2d_area
	setscale/I y,-2,2,cuts2d_area
	endif

	if(BZShowmode==3)
	make/O/N=(600,600) cuts2d_area=0
	setscale/I x,-3,3,cuts2d_area
	setscale/I y,-3,3,cuts2d_area
	endif 
	
	if(BZShowmode==4)
	make/O/N=(800,800) cuts2d_area=0
	setscale/I x,-4,4,cuts2d_area
	setscale/I y,-4,4,cuts2d_area
	endif 
	
	phinum=dimsize(phiangle,0)
	ii=0
	do
		wave tmp=cut2d_area_phi(phiangle[ii])
		cuts2d_area+=tmp
		killwaves/Z tmp
		ii+=1
	while(ii<phinum)
	//arealist=wavelist("cuts2d_area*",";","DIMS:2")
	//print arealist
	//areaname=stringfromlist(0,arealist)
	//duplicate/O $areaname cuts2d_area
	
	//ii=1
	//do
	//	areaname=stringfromlist(ii,arealist)
	//	wave tmp=$areaname
	//	cuts2d_area+=tmp
	//	ii+=1
	//while(ii<phinum)
	
	
	dowindow/F MomentumMapArea
	string ctrlName=""
	if(BZShowmode==0)
	if((V_Flag==0)||(fromline2artof==1))
		dowindow/K MomentumMapArea
		Display/K=1 as "Momentum Map";AppendImage cuts2d_area
		XJZSecondBZ(ctrlName)
		ModifyImage cuts2d_area ctab= {0,1,Terrain256,1}
		ModifyGraph standoff=0
		ModifyGraph rgb=(0,0,0)
		ModifyGraph lsize=1
		ModifyGraph fStyle=1
		ModifyGraph width={Aspect,1}
		Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		ModifyGraph width=368.504,height=368.504
		dowindow/C MomentumMapArea
		fromline2artof=0
	endif
	
	RemoveFromGraph/Z Hexy
	SetAxis bottom -1,1 
    SetAxis left -1,1  
	endif

	if(BZShowmode==1)
	if((V_Flag==0)||(fromline2artof==1))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage cuts2d_area
	XJZSecondBZ(ctrlName)
	ModifyImage cuts2d_area ctab= {0,1,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	SetAxis bottom -2,2 
    SetAxis left -2,2 
	endif
	
    IF (BZShowmode==2)    
	if((V_Flag==0)||(fromline2artof==1))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage cuts2d_area
	XJZSecondBZ(ctrlName)
	ModifyImage cuts2d_area ctab= {0,1,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	XJZThirdBZ(ctrlName)      
	ModifyGraph rgb(Hexy)=(0,65280,0) 
    ModifyGraph lsize(Hexy)=2  
    
	SetAxis bottom -2,2 
    SetAxis left -2,2 	                              
    ENDIF

	if(BZShowmode==3)
	if((V_Flag==0)||(fromline2artof==1))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage cuts2d_area
	XJZSecondBZ(ctrlName)
	ModifyImage cuts2d_area ctab= {0,1,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	SetAxis bottom -3,3 
    SetAxis left -3,3 
	endif
	
	if(BZShowmode==4)
	if((V_Flag==0)||(fromline2artof==1))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage cuts2d_area
	XJZSecondBZ(ctrlName)
	ModifyImage cuts2d_area ctab= {0,1,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea
	fromline2artof=0
	endif
	RemoveFromGraph/Z Hexy
	SetAxis bottom -4,4 
    SetAxis left -4,4 
	endif
	

end


function/Wave cut2d_area_phi(phi)

variable phi
/////////////cal2Dcuts area

nvar lomegaoffset1=root:ARToFData:lomegaoffset1
nvar lomegaoffset2=root:ARToFData:lomegaoffset2
nvar lthetaoffset1=root:ARToFData:lthetaoffset1
nvar lthetaoffset2=root:ARToFData:lthetaoffset2
nvar lphioffsets=root:ARToFData:lphioffset1
nvar lphioffsete=root:ARToFData:lphioffset2

nvar PhotonE=root:ARToFData:PhotonEnergy
nvar WorkFunc= root:ARToFData:WorkFunction
nvar LC=root:ARToFData:LatticeConstant
//Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
//考虑Eb对测量动量的影响
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
//nvar RAngle=root:ARToFData:RotationAngle
//nvar Theta0=root:ARToFData:ThetaAngle
//nvar Phi0=root:ARToFData:PhiAngle
wave theta_angle=root:OriginalData:Theta_Angle
wave phi_angle=root:OriginalData:Phi_Angle
wave omega_angle=root:OriginalData:Omega_Angle
wave processflag=root:OriginalData:ProcessFlag
wave/T processimage=root:OriginalData:processedimage
string tmpstr
nvar DetectorAngle0=root:ARToFData:DetectorAngle
nvar artofflag=root:MomentumMap:ARToFFlag
nvar BZShowmode=root:ARToFData:BZShowMode
nvar fromline2artof=root:MomentumMap:fromline2artof

nvar processedimageflag=root:PROCESS:ProcessedImageFlag

	//nvar thetaoffset=root:PROCESS:ThetaOffset
	//nvar phioffset=root:PROCESS:PhiOffset
	//nvar omegaoffset=root:PROCESS:OmegaOffset
	
	///offset由3D程序面板设定
	nvar thetaoffset=root:ARToFData:offsettheta
	nvar omegaoffset=root:ARToFData:offsetomega
	nvar phioffset=root:ARToFData:offsetphi
	//offsettheta=thetaoffset
	//offsetomega=omegaoffset
	//offsetphi=phioffset
 	///offset由3D程序面板设定
 	
 	///将offset反映入3D数据
 	
 	offset3D(thetaoffset,phioffset)
 	///将offset反映入3D数据
 	//setdatafolder root:ARToFData

variable xmin,xinc,ymin,yinc,kxpnts,kypnts

string areaname
if(phi<0)
areaname="cuts2d_areaN"+num2str(-10*phi)
else
areaname="cuts2d_areaP"+num2str(10*phi)
endif

if(BZShowmode==0)

make/O/N=(200,200) $areaname
xmin=-1
ymin=-1
xinc=0.01
yinc=0.01
kxpnts=200
kypnts=200
setscale/I x,-1,1,$areaname
setscale/I y,-1,1,$areaname

endif 

if((BZShowmode==1)||(BZShowmode==2))

make/O/N=(400,400) $areaname
xmin=-2
ymin=-2
xinc=0.01
yinc=0.01
kxpnts=400
kypnts=400
setscale/I x,-2,2,$areaname
setscale/I y,-2,2,$areaname

endif

if(BZShowmode==3)

make/O/N=(600,600) $areaname
xmin=-3
ymin=-3
xinc=0.01
yinc=0.01
kxpnts=600
kypnts=600
setscale/I x,-3,3,$areaname
setscale/I y,-3,3,$areaname

endif 

if(BZShowmode==4)

make/O/N=(800,800) $areaname
xmin=-4
ymin=-4
xinc=0.01
yinc=0.01
kxpnts=800
kypnts=800
setscale/I x,-4,4,$areaname
setscale/I y,-4,4,$areaname

endif 

wave cuts2d_area=root:ARToFData:$areaname
variable theta_start,theta_end,Phi0,RAngle,datapntnum,ii,ifind1=0,ifind2



ii=0
datapntnum=dimsize(theta_angle,0)
do
	//if(processedimageflag==processflag[ii])/////phi num>1时出错，修改如下(2011-01-29)：
	if((processedimageflag==processflag[ii])&&(phi==phi_angle[ii]))
	ifind1+=1
	ifind2=ii
	endif
	ii+=1
while(ii<datapntnum)

	
	
ii=0
do
	if((processedimageflag==processflag[ii])&&(phi==phi_angle[ii]))
	tmpstr=processimage[ii]
	break
	endif
	ii+=1
while(ii<datapntnum)

theta_start=theta_angle[ifind2-ifind1+1]
theta_end=theta_angle[ifind2]
//Phi0=phi_angle[ifind2]
Phi0=phi
Rangle=omega_angle[ifind2]
//print ifind1,ifind2,theta_start,theta_end,Phi0,Rangle 
ii=0
do
	if((processedimageflag==processflag[ii])&&(phi==phi_angle[ii]))
		if(theta_start>theta_angle[ii])
		theta_start=theta_angle[ii]
		endif
		if(theta_end<theta_angle[ii])
		theta_end=theta_angle[ii]
		endif
	endif
	ii+=1
while(ii<datapntnum)
//print ifind1,ifind2,theta_start,theta_end,Phi0,Rangle 

theta_start=theta_start-thetaoffset-lthetaoffset1
theta_end=theta_end-thetaoffset-lthetaoffset2
///////phi
Phi0=Phi0-phioffset
Rangle=Rangle-omegaoffset



wave tmp=root:PROCESS:$tmpstr
variable detect_e,detect_s,eemin,eemax,K0min,K0max
detect_s=dimoffset(tmp,1)
detect_e=dimoffset(tmp,1)+(dimsize(tmp,1)-1)*dimdelta(tmp,1)
eemin=dimoffset(tmp,0)
eemax=dimoffset(tmp,0)+(dimsize(tmp,0)-1)*dimdelta(tmp,0)
//print detect_s,detect_e


//考虑Eb对K0的影响//////////////////////////////////////////////
K0min=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+eemin)
K0max=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+eemax)

//variable kx1_s=K0*sin(3.1416/180*(Phi0-15))
//variable kx2_s=K0*sin(3.1416/180*(Phi0+15))
//variable ky1_s=K0*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0-15))
//variable ky2_s=K0*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+15))
variable kx1_s,ky1_s,kx2_s,ky2_s,kx1_e,ky1_e,kx2_e,ky2_e,mediavalue
//////////////////////////////翻转ccd接收角度范围
mediavalue=detect_s
detect_s=-detect_e
detect_e=-mediavalue
//////////////////////////////翻转ccd接收角度范围
variable lphioffset1=-lphioffsets
variable lphioffset2=-lphioffsete

if(Phi0+detect_s>=0)
	 kx1_s=K0min*sin(3.1416/180*(Phi0+detect_s-lphioffset1))
	 kx2_s=K0max*sin(3.1416/180*(Phi0+detect_e-lphioffset1))
	 ky1_s=K0min*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s-lphioffset1))
	 ky2_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e-lphioffset1))
	
	 kx1_e=K0min*sin(3.1416/180*(Phi0+detect_s-lphioffset2))
	 kx2_e=K0max*sin(3.1416/180*(Phi0+detect_e-lphioffset2))
	 ky1_e=K0min*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s-lphioffset2))
	 ky2_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e-lphioffset2))
endif

if(Phi0+detect_e<=0)
	 kx1_s=K0max*sin(3.1416/180*(Phi0+detect_s-lphioffset1))
	 kx2_s=K0min*sin(3.1416/180*(Phi0+detect_e-lphioffset1))
	 ky1_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s-lphioffset1))
	 ky2_s=K0min*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e-lphioffset1))
	
	 kx1_e=K0max*sin(3.1416/180*(Phi0+detect_s-lphioffset2))
	 kx2_e=K0min*sin(3.1416/180*(Phi0+detect_e-lphioffset2))
	 ky1_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s-lphioffset2))
	 ky2_e=K0min*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e-lphioffset2))
endif

if(((Phi0+detect_e)>0&&((Phi0+detect_s)<0)))
	 kx1_s=K0max*sin(3.1416/180*(Phi0+detect_s-lphioffset1))
	 kx2_s=K0max*sin(3.1416/180*(Phi0+detect_e-lphioffset1))
	 ky1_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s-lphioffset1))
	 ky2_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e-lphioffset1))
	
	 kx1_e=K0max*sin(3.1416/180*(Phi0+detect_s-lphioffset2))
	 kx2_e=K0max*sin(3.1416/180*(Phi0+detect_e-lphioffset2))
	 ky1_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s-lphioffset2))
	 ky2_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e-lphioffset2))
endif
//if(Phi0+detect_s>=0)
//	 kx1_s=K0min*sin(3.1416/180*(Phi0+detect_s))
//	 kx2_s=K0max*sin(3.1416/180*(Phi0+detect_e))
//	 ky1_s=K0min*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s))
//	 ky2_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e))
//	
//	 kx1_e=K0min*sin(3.1416/180*(Phi0+detect_s))
//	 kx2_e=K0max*sin(3.1416/180*(Phi0+detect_e))
//	 ky1_e=K0min*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s))
//	 ky2_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e))
//endif

//if(Phi0+detect_e<=0)
//	 kx1_s=K0max*sin(3.1416/180*(Phi0+detect_s))
//	 kx2_s=K0min*sin(3.1416/180*(Phi0+detect_e))
//	 ky1_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s))
//	 ky2_s=K0min*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e))
	
//	 kx1_e=K0max*sin(3.1416/180*(Phi0+detect_s))
//	 kx2_e=K0min*sin(3.1416/180*(Phi0+detect_e))
//	 ky1_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s))
//	 ky2_e=K0min*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e))
//endif

//if(((Phi0+detect_e)>0&&((Phi0+detect_s)<0)))
//	 kx1_s=K0max*sin(3.1416/180*(Phi0+detect_s))
//	 kx2_s=K0max*sin(3.1416/180*(Phi0+detect_e))
//	 ky1_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s))
//	 ky2_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e))
	
//	 kx1_e=K0max*sin(3.1416/180*(Phi0+detect_s))
//	 kx2_e=K0max*sin(3.1416/180*(Phi0+detect_e))
//	 ky1_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s))
//	 ky2_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e))
//endif
/////////////////////////////////////////////////////////////////////////////////////
//print Phi0+detect_s,Phi0+detect_e,K0min,K0max,K0

//未考虑Eb对K0的影响//////////////////////////////////////////////////////////////////
//variable kx1_s=K0*sin(3.1416/180*(Phi0-detect_e))
//variable kx2_s=K0*sin(3.1416/180*(Phi0-detect_s))
//variable ky1_s=K0*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0-detect_e))
//variable ky2_s=K0*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0-detect_s))

//print kx1_s,ky1_s,kx2_s,ky2_s
//variable kx1_e=K0*sin(3.1416/180*(Phi0-15))
//variable kx2_e=K0*sin(3.1416/180*(Phi0+15))
//variable ky1_e=K0*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0-15))
//variable ky2_e=K0*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+15))
//variable kx1_e=K0*sin(3.1416/180*(Phi0-detect_e))
//variable kx2_e=K0*sin(3.1416/180*(Phi0-detect_s))
//variable ky1_e=K0*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0-detect_e))
//variable ky2_e=K0*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0-detect_s))
//////////////////////////////////////////////////////////////////////////////////////
//print kx1_e,ky1_e,kx2_e,ky2_e
variable Rkx1_s=sqrt(kx1_s*kx1_s+ky1_s*ky1_s)*cos((atan2(ky1_s,kx1_s))+Rangle*pi/180)
variable Rky1_s=sqrt(kx1_s*kx1_s+ky1_s*ky1_s)*sin((atan2(ky1_s,kx1_s))+Rangle*pi/180)
variable Rkx2_s=sqrt(kx2_s*kx2_s+ky2_s*ky2_s)*cos((atan2(ky2_s,kx2_s))+Rangle*pi/180)
variable Rky2_s=sqrt(kx2_s*kx2_s+ky2_s*ky2_s)*sin((atan2(ky2_s,kx2_s))+Rangle*pi/180)
//print Rkx1_s,Rky1_s,Rkx2_s,Rky2_s
variable Rkx1_e=sqrt(kx1_e*kx1_e+ky1_e*ky1_e)*cos((atan2(ky1_e,kx1_e))+Rangle*pi/180)
variable Rky1_e=sqrt(kx1_e*kx1_e+ky1_e*ky1_e)*sin((atan2(ky1_e,kx1_e))+Rangle*pi/180)
variable Rkx2_e=sqrt(kx2_e*kx2_e+ky2_e*ky2_e)*cos((atan2(ky2_e,kx2_e))+Rangle*pi/180)
variable Rky2_e=sqrt(kx2_e*kx2_e+ky2_e*ky2_e)*sin((atan2(ky2_e,kx2_e))+Rangle*pi/180)
//print Rkx1_e,Rky1_e,Rkx2_e,Rky2_e
//print xmin,xinc,ymin,yinc
variable xx,yy,zz,zz1,zz2
variable jj=0
ii=0
variable test=0//
//make/O/N=100 testwave
//setscale x,Rkx2_s,Rkx2_e,testwave
//testwave=(Rky2_e-Rky2_s)/(Rkx2_e-Rkx2_s)*(x-Rkx2_e)+Rky2_e

do
	jj=0
	do
	xx=xmin+ii*xinc
	yy=ymin+jj*yinc
	
	if((K0*K0-xx*xx-yy*yy)>=0)
	zz=sqrt(K0*K0-xx*xx-yy*yy)
		if((((yy-Rky2_e)*(Rkx2_e-Rkx2_s)-(Rky2_e-Rky2_s)*(xx-Rkx2_e))>0)&&(((yy-Rky1_e)*(Rkx1_e-Rkx1_s)-(Rky1_e-Rky1_s)*(xx-Rkx1_e))<0))
			
			//if(((tan(Rangle)*xx-yy-tan(theta_start)*sec(Rangle)*zz)>0)&&((tan(Rangle)*xx-yy+tan(theta_end)*sec(Rangle)*zz)<0))
			zz1=(tan(Rangle*pi/180)*xx-yy)/sec(Rangle*pi/180)/tan(-theta_start*pi/180)
			zz2=-(tan(Rangle*pi/180)*xx-yy)/sec(Rangle*pi/180)/tan(theta_end*pi/180)
			///////////modify by jxw 20101215
			if((theta_start<=0)&&(theta_end>=0))
				if((zz>=zz1)&&(zz>=zz2))
				cuts2d_area[ii][jj]=1
				endif
			endif
			
			if((theta_start<=0)&&(theta_end<0))
				if((zz>=zz1)&&(zz<=zz2))
				cuts2d_area[ii][jj]=1
				endif
			endif
			
			if((theta_start>0)&&(theta_end>=0))
				if((zz<=zz1)&&(zz>=zz2))
				cuts2d_area[ii][jj]=1
				endif
			endif
			
			if((theta_start>0)&&(theta_end<0))
				if((zz<=zz1)&&(zz<=zz2))
				cuts2d_area[ii][jj]=1
				endif
			endif
			///////////modify by jxw 20101215
		endif
	endif
	jj+=1
	while(jj<kypnts)
	ii+=1
while(ii<kxpnts)
//print RAngle,theta_start,theta_end
//print test//
//print (yy-Rky2_e)*(Rkx2_e-Rkx2_s)-(Rky2_e-Rky2_s)*(xx-Rkx2_e),(yy-Rky1_e)*(Rkx1_e-Rkx1_s)-(Rky1_e-Rky1_s)*(xx-Rkx1_e)
return cuts2d_area
	
end


///////////////////////
function dispersion2D()

	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	nvar RAngle=root:ARToFData:RotationAngle
	nvar Theta0=root:ARToFData:ThetaAngle
	nvar Phi0=root:ARToFData:PhiAngle
	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	nvar omegaoffset=root:PROCESS:OmegaOffset
	//variable RK0=K0*sin(3.1416/180*(DetectorAngle0/2))
	
	wave theta_angle=root:OriginalData:Theta_Angle
	wave phi_angle=root:OriginalData:Phi_Angle
	wave omega_angle=root:OriginalData:Omega_Angle
	wave processflag=root:OriginalData:ProcessFlag

	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	nvar artofflag=root:MomentumMap:ARToFFlag
	nvar BZShowmode=root:ARToFData:BZShowMode
	nvar fromline2artof=root:MomentumMap:fromline2artof

	nvar processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar thetaoffset=root:PROCESS:ThetaOffset
	nvar phioffset=root:PROCESS:PhiOffset
	nvar omegaoffset=root:PROCESS:OmegaOffset
	
	variable ii,omega,phiangle,datapntnum
	datapntnum=dimsize(processflag,0)
	ii=0
	do
		if(processedimageflag==processflag[ii])
		omega=omega_angle[ii]
		phiangle=phi_angle[ii]
		break
		endif
		ii+=1
	while(ii<datapntnum)
	omega=omega-omegaoffset
	
	
	wave Rky_wave,Rkx_wave
	variable pntnum
	pntnum=dimsize(Rky_wave,0)
	
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	
	variable Emin,Einc,Elength,Ebinding
	Emin=dimoffset($tmp[V_Value],2)
	Einc=dimdelta($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	//print tmp[V_Value]
	//print Emin,Einc,Elength,Emin+(Elength-1)*Einc
	string/G Sanglex,Sangley,Eanglex,Eangley
	variable/G Sx,Sy,Ex,Ey
	variable jj=0,xx,yy,ee
	
	nvar holdimageornot=root:ARToFData:holdimageornot
	
	string EKImageArbCutname
	if(holdimageornot==1)
	EKImageArbCutname="EKImageArbCut"+num2str(itemsinlist(wavelist("EKImageArbCut*",";","DIMS:2"))+1)
	else
	EKImageArbCutname="EKImageArbCut"
	endif
	
	
	
	
	make/O/N=(pntnum,Elength) $EKImageArbCutname=0
	
	wave EKImageArbCut=$EKImageArbCutname
	variable kx,ky,theta,phi,interp_value
	
	ii=0
	jj=0
	
	do
	ee=Emin+jj*Einc
		ii=0
		do
		xx=Rkx_wave[ii]
		yy=Rky_wave[ii]
		
		kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
		ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
		
		///需要修改调整
		////考虑能量对动量的修正
		K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
		
		phi=-asin(kx/K0)
		theta=asin(ky/K0/cos(phi))
	
		theta=theta*180/pi
		phi=phi*180/pi
		
		//if(ii==0)
			
		//	sprintf Sanglex,"%.2f",xx
			//Sanglex=num2str(xx)
		//	Sx=xx
		//	sprintf Sangley,"%.2f",yy
			//Sangley=num2str(yy)
		//	Sy=yy
		//	endif
		
		//jj=0
		//do
		//ee=Emin+jj*Einc
		//EKImageArbCut[ii][jj]=interp3D($tmp[V_Value],phi,theta,ee)
		//jj+=1
		//while(jj<Elength)
		EKImageArbCut[ii][jj]=interp3D($tmp[V_Value],phi,theta,ee)
		ii+=1
	while(ii<pntnum)
	jj+=1
while(jj<Elength)
	
			
			sprintf Sanglex,"%.2f",Rkx_wave[0]
			//Sanglex=num2str(xx)
			Sx=Rkx_wave[0]
			sprintf Sangley,"%.2f",Rky_wave[0]
			//Sangley=num2str(yy)
			Sy=Rky_wave[0]
			
			sprintf Eanglex,"%.2f",Rkx_wave[pntnum-1]
			//Sanglex=num2str(xx)
			Ex=Rkx_wave[pntnum-1]
			sprintf Eangley,"%.2f",Rky_wave[pntnum-1]
			//Sangley=num2str(yy)
			Ey=Rky_wave[pntnum-1]
	
	string Scutinfor="("+Sanglex+","+Sangley+")"
	string Ecutinfor="("+Eanglex+","+Eangley+")"
	
	
	
	setscale/P y,Emin,Einc,EKImageArbCut
	setscale/I x,0,sqrt((Ey-Sy)^2+(Ex-Sx)^2),EKImageArbCut
	////debug
	//print Sx,Sy,Ex,Ey
	//print sqrt((Ey-Sy)^2+(Ex-Sx)^2)
	if(holdimageornot==0)
	dowindow/K EKImageARToF
	display/K=1; appendimage EKImageArbCut
	ModifyImage EKImageArbCut ctab= {*,*,PlanetEarth256,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	ModifyGraph tick(bottom)=2,noLabel(bottom)=0
	TextBox/C/N=text1/X=-45/Y=-58/F=0/A=MC "\\f01\\Z15"+Scutinfor
	TextBox/C/N=text2/X=40/Y=-58/F=0/A=MC "\\f01\\Z15"+Ecutinfor
	ModifyGraph width=283.465,height=396.85
	Label bottom "\\F'Times'\\Z18K//(\\F'symbol'p/\\F'Times'a)"
	dowindow/C EKImageARToF
	endif
	
	if(holdimageornot==1)
	//dowindow/K EKImageARToF
	display/K=1; appendimage EKImageArbCut
	ModifyImage $EKImageArbCutname ctab= {*,*,PlanetEarth256,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	ModifyGraph tick(bottom)=2,noLabel(bottom)=0
	TextBox/C/N=text1/X=-45/Y=-58/F=0/A=MC "\\f01\\Z15"+Scutinfor
	TextBox/C/N=text2/X=40/Y=-58/F=0/A=MC "\\f01\\Z15"+Ecutinfor
	ModifyGraph width=283.465,height=396.85
	Label bottom "\\F'Times'\\Z18K//(\\F'symbol'p/\\F'Times'a)"
	//dowindow/C EKImageARToF
	endif
end




Function fromcut2artof(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar artof_flag=root:ARToFData:artof_flag
	nvar fromline2artof=root:MomentumMap:fromline2artof
	
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2
	
	if(artof_flag==0)
	
	//SetVariable omega,win=VisualizeARToFData,disable=2
	//SetVariable theta,win=VisualizeARToFData,disable=2
	//SetVariable phi,win=VisualizeARToFData,disable=2
	setvariable theta1,win=VisualizeARToFData,disable=0
	setvariable offsetomega,win=VisualizeARToFData,disable=0
	setvariable offsettheta,win=VisualizeARToFData,disable=0
	setvariable offsetphi,win=VisualizeARToFData,disable=0
	fromline2artof=1
	endif
	
	if(artof_flag==1)
	
	SetVariable omega,win=VisualizeARToFData,disable=0
	SetVariable theta,win=VisualizeARToFData,disable=0
	SetVariable phi,win=VisualizeARToFData,disable=0
	
	setvariable theta1,win=VisualizeARToFData,disable=2
	setvariable offsetomega,win=VisualizeARToFData,disable=2
	setvariable offsettheta,win=VisualizeARToFData,disable=2
	setvariable offsetphi,win=VisualizeARToFData,disable=2
	lthetaoffset1=0
	lthetaoffset2=0
	lphioffset1=0
	lphioffset2=0
	fromline2artof=0
	endif
	
End



Function getarbEDC(ctrlName) : ButtonControl
	String ctrlName

nvar bindingnumEDC=root:ARToFData:bindingnumEDC
nvar EkimageEDCkpos=root:ARToFData:EkimageEDCkpos

nvar kxkyposcursor=root:ARToFData:kxkyposcursor

	
wave tmp=root:ARToFData:EKImageArbCut


variable kx,kx0,Emin,Einc,Energypnts,xmin,xinc,xpnts

xmin=dimoffset(tmp,0)
xinc=dimdelta(tmp,0)
xpnts=dimsize(tmp,0)


Emin=dimoffset(tmp,1)
Einc=dimdelta(tmp,1)
Energypnts=dimsize(tmp,1)
//print xmin,Emin
make/O/N=(Energypnts) EDC4ArbCut=0
setscale/P x,Emin,Einc,EDC4ArbCut

variable ii,jj,ee

if(kxkyposcursor==0)
	if(strlen(CsrInfo(A,"EKImageARToF"))>0)
	kx0=xcsr(A,"EKImageARToF")
	EkimageEDCkpos=kx0
	endif
	kx0=EkimageEDCkpos
endif


if(kxkyposcursor==1)
	kx0=EkimageEDCkpos
endif
//kx0=xcsr(A)
make/O/N=2 EkimageEDCkposx,EkimageEDCkposy
EkimageEDCkposx={kx0,kx0}
EkimageEDCkposy={Emin,Emin+(Energypnts-1)*Einc}

///get momentum position
nvar Sx=root:ARToFData:Sx
nvar Sy=root:ARToFData:Sy
nvar Ex=root:ARToFData:Ex
nvar Ey=root:ARToFData:Ey
svar Sanglex=root:ARToFData:Sanglex
svar Sangley=root:ARToFData:Sangley
svar Eanglex=root:ARToFData:Eanglex
svar Eangley=root:ARToFData:Sangley

variable kxpos,kypos,xmax,namda
string kposinfor

xmax=xmin+(xpnts-1)*xinc
if(kx0!=0)
namda=(xmax-kx0)/kx0
endif

if(kx0!=0)
kxpos=(Ex+namda*Sx)/(1+namda)
kypos=(Ey+namda*Sy)/(1+namda)
else
kxpos=Sx
kypos=Sy
endif

sprintf kposinfor,"EDC:(%.2f,%.2f) pi/a",kxpos,kypos

variable value1
ii=0
jj=0
do
	ee=Emin+ii*Einc
	jj=-bindingnumEDC/2
	do
		kx=kx0+jj*xinc
		if((kx<=(xmin+xinc*(xpnts-1)))&&(kx>=xmin))
			value1=interp2D(tmp,kx,ee)
			if(numtype(value1)==0)
			EDC4ArbCut[ii]+=value1
			endif
		endif
		
		jj+=0.5
	while(jj<=bindingnumEDC/2)
	ii+=1
while(ii<Energypnts)

dowindow/F EDC4ArbCut_Panel
if(V_Flag==0)
display/K=1 EDC4ArbCut
dowindow/C EDC4ArbCut_Panel
ModifyGraph mirror=2,fStyle=1,standoff=0
Label bottom "\\f01\\Z15E-E\\Bf\\M\\Z15(eV)"
ModifyGraph mode=4,marker=19,msize=1.5
endif
TextBox/C/N=EDCbox/F=0/A=MC "\\f01\\Z15"+kposinfor
removefromgraph/Z/W=EKImageARToF EkimageEDCkposy
appendtograph/W=EKImageARToF EkimageEDCkposy vs EkimageEDCkposx
End


Function getarbMDC(ctrlName) : ButtonControl
	String ctrlName

nvar bindingnumMDC=root:ARToFData:bindingnumMDC
nvar kxkyposcursor=root:ARToFData:kxkyposcursor
nvar EkimageMDCEpos=root:ARToFData:EkimageMDCEpos

wave tmp=root:ARToFData:EKImageArbCut

variable ee,ee0,Emin,Einc,Energypnts,xmin,xinc,xpnts

xmin=dimoffset(tmp,0)
xinc=dimdelta(tmp,0)
xpnts=dimsize(tmp,0)


Emin=dimoffset(tmp,1)
Einc=dimdelta(tmp,1)
Energypnts=dimsize(tmp,1)
//print xmin,Emin
make/O/N=(xpnts) MDC4ArbCut=0
setscale/P x,xmin,xinc,MDC4ArbCut

variable ii,jj,kx

if(kxkyposcursor==0)
	if(strlen(CsrInfo(A,"EKImageARToF"))>0)
	ee0=vcsr(A,"EKImageARToF")
	EkimageMDCEpos=ee0
	endif
	ee0=EkimageMDCEpos
endif


if(kxkyposcursor==1)
	ee0=EkimageMDCEpos
endif
//ee0=vcsr(A)
//print ee0
make/O/N=2 EkimageMDCEposx,EkimageMDCEposy
EkimageMDCEposx={xmin,xmin+(xpnts-1)*xinc}
EkimageMDCEposy={ee0,ee0}

///get energy position
nvar Sx=root:ARToFData:Sx
nvar Sy=root:ARToFData:Sy
nvar Ex=root:ARToFData:Ex
nvar Ey=root:ARToFData:Ey
svar Sanglex=root:ARToFData:Sanglex
svar Sangley=root:ARToFData:Sangley
svar Eanglex=root:ARToFData:Eanglex
svar Eangley=root:ARToFData:Sangley

string eepos



sprintf eepos,"MDC: Eb=%.3feV(%.2f,%.2f)->(%.2f,%.2f)pi/a",ee0,Sx,Sy,Ex,Ey



ii=0
jj=0
do
	kx=xmin+ii*xinc
	jj=-bindingnumMDC/2
	do
		ee=ee0+jj*Einc
		if((ee<=(Emin+Einc*(Energypnts-1)))&&(ee>=Emin))
		MDC4ArbCut[ii]+=interp2D(tmp,kx,ee)
		endif
		
		jj+=0.5
	while(jj<=bindingnumMDC/2)
	ii+=1
while(ii<xpnts)

dowindow/F MDC4ArbCut_Panel
if(V_Flag==0)
display/K=1 MDC4ArbCut
ModifyGraph mirror=2,fStyle=1,standoff=0;DelayUpdate
ModifyGraph mode=4,marker=19,msize=1.5
Label bottom "\\Z15Momentum"

dowindow/C MDC4ArbCut_Panel
endif
TextBox/C/N=EDCbox/F=0/A=MC "\\f01\\Z15"+eepos
removefromgraph/Z/W=EKImageARToF EkimageMDCEposy
appendtograph/W=EKImageARToF EkimageMDCEposy vs EkimageMDCEposx

End

Function getEDC2nd(ctrlName) : ButtonControl
	String ctrlName

	setdatafolder root:ARToFData
	wave tmp=root:ARToFData:EKImageArbCut 
	nvar smoothnumEDC=root:ARToFData:smoothnumEDC
 
	string EDC2ndname="EDC2nd"+num2str(smoothnumEDC)+"ArbCut"
	
	duplicate/O tmp $EDC2ndname
	//wave tmp2=root:ARToFData:$EDC2ndname
	EDC2dFS1(EDC2ndname,smoothnumEDC)

	dowindow/K EDC2ndEKImage
	display/K=1; appendimage $EDC2ndname
	ModifyImage $EDC2ndname ctab= {*,*,PlanetEarth256,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	ModifyImage $EDC2ndname ctab= {0,*,PlanetEarth256,1}
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width={Aspect,0.6}
	dowindow/C EDC2ndEKImage
	
End

Function getMDC2nd(ctrlName) : ButtonControl
	String ctrlName

	setdatafolder root:ARToFData
	wave tmp=root:ARToFData:EKImageArbCut 
	nvar smoothnumMDC=root:ARToFData:smoothnumMDC
 
	string MDC2ndname="MDC2nd"+num2str(smoothnumMDC)+"ArbCut"
	duplicate/O tmp $MDC2ndname
	//wave tmp2=root:ARToFData:$EDC2ndname
	MDC2dFS1(MDC2ndname,smoothnumMDC)

	dowindow/K MDC2ndEKImage
	display/K=1; appendimage $MDC2ndname
	ModifyImage $MDC2ndname ctab= {*,*,PlanetEarth256,1}
	ModifyGraph standoff=0
	ModifyGraph fStyle=1
	ModifyImage $MDC2ndname ctab= {0,*,PlanetEarth256,1}
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width={Aspect,0.6}
	dowindow/C MDC2ndEKImage
End

Function MDC2dFS1(popStr,smoothnumMDC)
	
	String popStr
	    	            		
        variable smoothnumMDC
//      String SecDImageName="SecD_"+"ST"+num2str(SmoothTimes)+popStr	
//        String SecDImageName="SecD_"+"MDC"+num2str(SmoothTimes)+popStr	        
//        String SecondDImage="MDC"+num2str(SmoothTimes)+popStr	
       variable smoothtimes=smoothnumMDC
        String Curr=GetDataFolder(1) 
        String Notation=popStr  	
	
       //Duplicate/O  root:DispersionIMAGE:$popStr, root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage
//     MatrixTranspose  root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage


       //SetDataFolder root:DispersionFrom2ndDerivative:MDC2ndD
       WAVE SecDImage= $popStr
       Duplicate/O SecDImage, TempSecDImage
        
       Variable/G nx, ny
	   Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
       XJZImginfo(SecDImage)


            String ReferenceEnergyWave="TokillEngy"+popStr
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 

                 String   EDC0="Tokill"+popStr+"0"
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=TempSecDImage[p] [0]
                 Differentiate EDCC;         Differentiate EDCC
                 Smooth/E=2 SmoothTimes, EDCC
                                  Variable k=0
                                  Do
                                  SecDImage[k] [0]=EDCC[k]
                                  k=k+1
                                  While(k<nx)
	         
                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=1         

	         
	         Variable ll
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p][i]
                 Differentiate EDCSpectra;   Differentiate EDCSpectra                 
                 Smooth/E=2 SmoothTimes, EDCSpectra
//               variable n=numpnts(EDCSpectra)
//               EDCSpectra[0,1]=0;	EDCSpectra[n-2,n-1]=0
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)
	        i=i+1
	        While(i<ny) 
       
//这段可能多余	            		
	      	        			       
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p] [i]
                 Differentiate EDCSpectra;      Differentiate EDCSpectra
                 Smooth/E=2 SmoothTimes, EDCSpectra
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)        
	         i=i+1
	        While(i<ny) 
         SecDImage=-SecDImage



                
//                DoWindow $SecDImageName
//	            if(V_flag==0)
//	            MatrixTranspose   SecDImage          
//                Display; AppendImage SecDImage
//                Textbox/N=text0/F=0/A=MT Notation  
//              ModifyImage $SecondDImage ctab= {*,0,Rainbow,1}
//                ModifyImage $SecondDImage ctab= {-0.01,0,PlanetEarth,1}
//                ModifyGraph standoff=0
//                ModifyGraph zero(left)=3
//                Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
//                ModifyGraph width={Aspect,0.5}
//                ModifyGraph margin(left)=26
//                ModifyGraph margin(right)=5
//                ModifyGraph margin(top)=5
                
//                DoWindow/C $SecDImageName
                
//               Else
//             MatrixTranspose   SecDImage   
//               DoWindow/F $SecDImageName 
//               Endif 
//             Print "Till here"
//				ShowInfo
//Kill EDC Curves in Root:DispersionFrom2ndDerivative
	    String ToBeKilledEDCList=WaveList("Tokill*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	    Variable iEDC=0
	    Do
	    EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	    KillWaves/Z  $EDCCurve
	    iEDC+=1
	    While(iEDC<NoofKilledEDCList)
                
                
	
	SetDataFolder curr
END


Function EDC2dFS1(popStr,smoothnumEDC)
	
	String popStr
	    	            		
        variable   smoothnumEDC
//      String SecDImageName="SecD_"+"ST"+num2str(SmoothTimes)+popStr	
//        String SecDImageName="SecD_"+"MDC"+num2str(SmoothTimes)+popStr	        
//        String SecondDImage="MDC"+num2str(SmoothTimes)+popStr	
        String Curr=GetDataFolder(1) 
        String Notation=popStr  	
	variable smoothtimes=smoothnumEDC
       //Duplicate/O  root:DispersionIMAGE:$popStr, root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage
      MatrixTranspose  $popStr


       //SetDataFolder root:DispersionFrom2ndDerivative:MDC2ndD
       WAVE SecDImage= $popStr
       Duplicate/O SecDImage, TempSecDImage
        
       Variable/G nx, ny
	   Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
       XJZImginfo(SecDImage)


            String ReferenceEnergyWave="TokillEgy"+popStr
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 

                 String   EDC0="Tokill"+popStr+"0"
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=TempSecDImage[p] [0]
                 Differentiate EDCC;         Differentiate EDCC
                 Smooth/E=2 SmoothTimes, EDCC
                                  Variable k=0
                                  Do
                                  SecDImage[k] [0]=EDCC[k]
                                  k=k+1
                                  While(k<nx)
	         
                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=1         

	         
	         Variable ll
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p][i]
                 Differentiate EDCSpectra;   Differentiate EDCSpectra                 
                 Smooth/E=2 SmoothTimes, EDCSpectra
//               variable n=numpnts(EDCSpectra)
//               EDCSpectra[0,1]=0;	EDCSpectra[n-2,n-1]=0
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)
	        i=i+1
	        While(i<ny) 
       
//这段可能多余	            		
	      	        			       
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p] [i]
                 Differentiate EDCSpectra;      Differentiate EDCSpectra
                 Smooth/E=2 SmoothTimes, EDCSpectra
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)        
	         i=i+1
	        While(i<ny) 
	SecDImage=-SecDImage
	 MatrixTranspose  $popStr


                
//                DoWindow $SecDImageName
//	            if(V_flag==0)
//	            MatrixTranspose   SecDImage          
//                Display; AppendImage SecDImage
//                Textbox/N=text0/F=0/A=MT Notation  
//              ModifyImage $SecondDImage ctab= {*,0,Rainbow,1}
//                ModifyImage $SecondDImage ctab= {-0.01,0,PlanetEarth,1}
//                ModifyGraph standoff=0
//                ModifyGraph zero(left)=3
//                Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
//                ModifyGraph width={Aspect,0.5}
//                ModifyGraph margin(left)=26
//                ModifyGraph margin(right)=5
//                ModifyGraph margin(top)=5
                
//                DoWindow/C $SecDImageName
                
//               Else
//             MatrixTranspose   SecDImage   
//               DoWindow/F $SecDImageName 
//               Endif 
//             Print "Till here"
//				ShowInfo
//Kill EDC Curves in Root:DispersionFrom2ndDerivative
	    String ToBeKilledEDCList=WaveList("Tokill*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	    Variable iEDC=0
	    Do
	    EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	    KillWaves/Z  $EDCCurve
	    iEDC+=1
	    While(iEDC<NoofKilledEDCList)
                
                
	
	SetDataFolder curr
END

Function clearEKImage(ctrlName) : ButtonControl
	String ctrlName
	
	string tobekillname,tmpstr
	variable ii=0
	tobekillname=wavelist("EKImageArbCut*",";","DIMS:2")
	do
		tmpstr=stringfromlist(ii,tobekillname)
		killwaves/Z $tmpstr
		ii+=1
	while(ii<itemsinlist(tobekillname))
	

End

Function disablesliderornot(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar holdintensityimage=root:ARToFData:holdintensityimage
	
	nvar arrowsornot=root:ARToFData:arrowsornot
	
	if(holdintensityimage==1)
	Slider energypostion,disable=2
	CheckBox arrowsornot,disable=2
	arrowsornot=0
	usingarrowornot(ctrlName,checked)
	
	endif
	
	if(holdintensityimage==0)
	Slider energypostion,disable=0
	CheckBox arrowsornot,disable=0
	endif

End

Function disableholdornot(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	nvar savewaveornot=root:ARToFData:savewaveornot
	nvar holdintensityimage=root:ARToFData:holdintensityimage
	if(savewaveornot==0)
	CheckBox holdintensityimageornot,disable=2
	holdintensityimage=0
	Slider energypostion,disable=0
	disablesliderornot(ctrlName,checked)
	endif
	
	if(savewaveornot==1)
	CheckBox holdintensityimageornot,disable=0
	disablesliderornot(ctrlName,checked)
	endif

End

proc creatfolderandvariablefor3D()
	
	dowindow VisualizeARToFData
	if(V_Flag==0)
	newdatafolder/O/S root:ARToFData
	Variable/G  PhotonEnergy=NumVarOrDefault("root:ARToFData:PhotonEnergy",6.994)
	Variable/G  WorkFunction=NumVarOrDefault("root:ARToFData:WorkFunction",4.3)
	Variable/G  LatticeConstant=NumVarOrDefault("root:ARToFData:LatticeConstant",3.8)
	Variable/G  RotationAngle=NumVarOrDefault("root:ARToFData:RotationAngle",0)
	Variable/G  ThetaAngle=NumVarOrDefault("root:ARToFData:ThetaAngle",0)
	Variable/G  PhiAngle=NumVarOrDefault("root:ARToFData:PhiAngle",0)
	Variable/G  DetectorAngle=NumVarOrDefault("root:ARToFData:DetectorAngle",30)
    Variable/G  BZShowMode=NumVarOrDefault("root:ARToFData:BZShowMode",0)
    Variable/G  degreeormomentum=NumVarOrDefault("root:ARToFData:degreeormomentum",0)
    Variable/G  Energywindow=NumVarOrDefault("root:ARToFData:Eenergywindow",10)
    Variable/G  kxstart=NumVarOrDefault("root:ARToFData:kxstart",0)
    Variable/G  kxend=NumVarOrDefault("root:ARToFData:kxend",0)
    Variable/G  kystart=NumVarOrDefault("root:ARToFData:kystart",0)
    Variable/G  kyend=NumVarOrDefault("root:ARToFData:kyend",0)
    Variable/G  kxpntnum=NumVarOrDefault("root:ARToFData:kxpntnum",0)
    Variable/G  kypntnum=NumVarOrDefault("root:ARToFData:kypntnum",0)
    Variable/G  bindingenergy=NumVarOrDefault("root:ARToFData:bindingenergy",0)
    Variable/G	 artof_flag=NumVarOrDefault("root:ARToFData:artof_flag",0)
    Variable/G	 bindingnumEDC=NumVarOrDefault("root:ARToFData:bindingnumEDC",0)
    Variable/G	 bindingnumMDC=NumVarOrDefault("root:ARToFData:bindingnumMDC",0)
    Variable/G	 smoothnumEDC=NumVarOrDefault("root:ARToFData:smoothnumEDC",0)
    Variable/G	 smoothnumMDC=NumVarOrDefault("root:ARToFData:smoothnumMDC",0)
    Variable/G	 savewaveornot=NumVarOrDefault("root:ARToFData:savewaveornot",0)
    Variable/G	 holdimageornot=NumVarOrDefault("root:ARToFData:holdimageornot",0)
	Variable/G  holdintensityimage=NumVarOrDefault("root:ARToFData:holdintensityimage",0)
	Variable/G  setcutkx_s=NumVarOrDefault("root:ARToFData:setcutkx_s",0)
	Variable/G  setcutky_s=NumVarOrDefault("root:ARToFData:setcutky_s",0)
	//Variable/G  setcutkx_e=NumVarOrDefault("root:ARToFData:setcutkx_e",0)
	//Variable/G  setcutky_e=NumVarOrDefault("root:ARToFData:setcutky_e",0)
	//Variable/G  cursorornot=NumVarOrDefault("root:ARToFData:cursorornot",0)
	Variable/G  arrowsornot=NumVarOrDefault("root:ARToFData:arrowsornot",0)
	Variable/G  deltaenergy=NumVarOrDefault("root:ARToFData:deltaenergy",0)
	Variable/G  lowcolorz=NumVarOrDefault("root:ARToFData:lowcolorz",0)
	Variable/G  highcolorz=NumVarOrDefault("root:ARToFData:highcolorz",0)
	Variable/G  inverseornot=NumVarOrDefault("root:ARToFData:inverseornot",0)
	Variable/G  costomizeenergystart=NumVarOrDefault("root:ARToFData:costomizeenergystart",0)
	Variable/G  costomizeenergyend=NumVarOrDefault("root:ARToFData:costomizeenergyend",0)
	Variable/G  costomizeenergy=NumVarOrDefault("root:ARToFData:costomizeenergy",0)
	Variable/G  offsettheta=NumVarOrDefault("root:ARToFData:offsettheta",0)
	Variable/G  offsetomega=NumVarOrDefault("root:ARToFData:offsetomega",0)
	Variable/G  offsetphi=NumVarOrDefault("root:ARToFData:offsetphi",0)
	variable/G	 orithetastart=NumVarOrDefault("root:ARToFData:orithetastart",0)
	variable/G	 orithetaend=NumVarOrDefault("root:ARToFData:orithetaend",0)
	variable/G	 oriphistart=NumVarOrDefault("root:ARToFData:oriphistart",0)
	variable/G	 oriphiend=NumVarOrDefault("root:ARToFData:oriphiend",0)
	
	variable/G	 thetaangle1=NumVarOrDefault("root:ARToFData:thetaangle1",0)
	variable/G	 ktolerance=NumVarOrDefault("root:ARToFData:ktolerance",0)
	variable/G	 cal2dareaornot=NumVarOrDefault("root:ARToFData:cal2dareaornot",0)
	variable/G	 adjustoffset=NumVarOrDefault("root:ARToFData:adjustoffset",0)
	variable/G	 EDCkxpos=NumVarOrDefault("root:ARToFData:EDCkxpos",0)
	variable/G	 EDCkypos=NumVarOrDefault("root:ARToFData:EDCkypos",0)
	variable/G	 EkimageEDCkpos=NumVarOrDefault("root:ARToFData:EkimageEDCkpos",0)
	variable/G	 EkimageMDCEpos=NumVarOrDefault("root:ARToFData:EkimageMDCEpos",0)
	variable/G	 kxkyposcursor=NumVarOrDefault("root:ARToFData:kxkyposcursor",0)
	variable/G	 kpathpntnum=NumVarOrDefault("root:ARToFData:kpathpntnum",0)
	variable/G	 lomegaoffset1=NumVarOrDefault("root:ARToFData:lomegaoffset1",0)
	variable/G	 lomegaoffset2=NumVarOrDefault("root:ARToFData:lomegaoffset2",0)
	variable/G	 lthetaoffset1=NumVarOrDefault("root:ARToFData:lthetaoffset1",0)
	variable/G	 lthetaoffset2=NumVarOrDefault("root:ARToFData:lthetaoffset2",0)
	variable/G	 lphioffset1=NumVarOrDefault("root:ARToFData:lphioffset1",0)
	variable/G	 lphioffset2=NumVarOrDefault("root:ARToFData:lphioffset2",0)
	
	variable/G	pauseornot=NumVarOrDefault("root:ARToFData:pauseornot",0)
	//Variable/G  stopautoshowflag=NumVarOrDefault("root:ARToFData:stopautoshowflag",0)
	//Variable/G  stopmovieflag=NumVarOrDefault("root:ARToFData:stopmovieflag",0)
	Variable/G  framespersecond=NumVarOrDefault("root:ARToFData:framespersecond",10)
	string/G arbdispersion_pre=strVarOrDefault("root:ARToFData:arbdispersion_pre","")
	string/G artofdatanamelist=strVarOrDefault("root:ARToFData:artofdatanamelist","")
	string/G kpathnodes=strVarOrDefault("root:ARToFData:kpathnodes","")
	string/G namestrfor3D
	string/G choosecolortablename=strVarOrDefault("root:ARToFData:choosecolortablename","PlanetEarth")
	make/O/T/N=0 artofdatanamelist4listbox
	endif
end

Function usingarrowstodraw(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	variable event
	nvar arrowsornot=root:ARToFData:arrowsornot
	nvar bindingenergy=root:ARToFData:bindingenergy
	nvar deltaenergy=root:ARToFData:deltaenergy
	svar choosecolortablename=root:ARToFData:choosecolortablename	 
	//variable sliderValue
	
	SetVariable bindingenergy,limits={-10,10,deltaenergy/1000}
	
	controlinfo/W=VisualizeARToFData Dispersion
	if(V_Value)
	dispersionandfit(ctrlName,0)
	TabControl Dispersion,win=VisualizeARToFData,value=0
	endif
	
	if(arrowsornot==1)
	//getintensity2d_arbE(bindingenergy)
	dowindow IntensityVSK
	if(V_Flag)
	slider energypostion,value=bindingenergy
	usingarrow(bindingenergy)
	choosecolortable(ctrlName,0,choosecolortablename)
	endif
	endif

End


Function usingarrowornot(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar arrowsornot=root:ARToFData:arrowsornot
	
	
	if(arrowsornot==1)
	Button intensityvskmovie,disable=0
	Button playintensityvskmovie,disable=0
	SetVariable deltaenergy,disable=0
	SetVariable autoEstart,disable=0
	SetVariable autoEend,disable=0
	CheckBox costomizeErange4movie,disable=0
	Button autoshow,disable=0
	//Button stopshow,disable=0
	//Button stopmoviehere,disable=0
	SetVariable framespersecond,disable=0
	endif
	
	if(arrowsornot==0)
	Button intensityvskmovie,disable=2
	Button playintensityvskmovie,disable=2
	SetVariable deltaenergy,disable=2
	SetVariable autoEstart,disable=2
	SetVariable autoEend,disable=2
	CheckBox costomizeErange4movie,disable=2
	Button autoshow,disable=2
	//Button stopshow,disable=2
	//Button stopmoviehere,disable=2
	SetVariable framespersecond,disable=2
	endif
End

Function cusorsornot(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	nvar cursorornot=root:ARToFData:cursorornot
	cursorornot=0
	if(cursorornot==1)
	SetVariable setcutkx_s,disable=2
	SetVariable setcutky_s,disable=2
	//SetVariable setcutkx_e,disable=2
	//SetVariable setcutky_e,disable=2
	button getcusors,disable=2
	endif
	
	if(cursorornot==0)
	SetVariable setcutkx_s,disable=0
	SetVariable setcutky_s,disable=0
	//SetVariable setcutkx_e,disable=0
	//SetVariable setcutky_e,disable=0
	button getcusors,disable=0
	endif

End

function calcuts2D_area()
	
	setdatafolder root:ARToFData
	
	nvar BZShowmode=root:ARToFData:BZShowMode
	nvar fromline2artof=root:MomentumMap:fromline2artof
	
	svar nameprestr=root:ARToFData:nameprestr
	nvar processedimageflag=root:PROCESS:ProcessedImageFlag
	string phianglelistname=nameprestr+"F"+num2str(processedimageflag)+"phianglelist"
	wave phiangle=root:ARToFData:$phianglelistname
	variable ii,phinum
	
	//string areaname
	
	if(BZShowmode==0)
	make/O/N=(200,200) cuts2d_area=0
	setscale/I x,-1,1,cuts2d_area
	setscale/I y,-1,1,cuts2d_area
	endif 

	if((BZShowmode==1)||(BZShowmode==2))
	make/O/N=(400,400) cuts2d_area=0
	setscale/I x,-2,2,cuts2d_area
	setscale/I y,-2,2,cuts2d_area
	endif

	if(BZShowmode==3)
	make/O/N=(600,600) cuts2d_area=0
	setscale/I x,-3,3,cuts2d_area
	setscale/I y,-3,3,cuts2d_area
	endif 
	
	phinum=dimsize(phiangle,0)
	ii=0
	do
		wave tmp=cut2d_area_phi(phiangle[ii])
		cuts2d_area+=tmp
		killwaves/Z tmp
		ii+=1
	while(ii<phinum)

end

function offset3D(thetaoffset,phioffset)
variable thetaoffset
variable phioffset

	nvar artof_flag=root:ARToFData:artof_flag
	nvar Theta0=root:ARToFData:ThetaAngle
	nvar Phi0=root:ARToFData:PhiAngle
	
	if(artof_flag==0)
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	dowindow VisualizeARToFData
	
	if(V_Flag==1)
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	if(waveexists($tmp[V_Value]))
	setscale/I x,(oriphistart+phioffset),(oriphiend+phioffset),$tmp[V_Value]
	setscale/I y,(orithetastart-thetaoffset),(orithetaend-thetaoffset),$tmp[V_Value]
	return 0
	endif
	endif
	
	
	svar namestrfor3D=root:ARToFData:namestrfor3D
	wave tmpwave=root:ARToFData:$namestrfor3D
	setscale/I x,(oriphistart+phioffset),(oriphiend+phioffset),tmpwave
	setscale/I y,(orithetastart-thetaoffset),(orithetaend-thetaoffset),tmpwave
	endif
	
	if(artof_flag==1)
	dowindow VisualizeARToFData
	
	if(V_Flag==1)
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	if(waveexists($tmp[V_Value]))
	setscale/I x,(-15+phi0-phioffset),(15+phi0-phioffset),$tmp[V_Value]
	setscale/I y,(-15+Theta0-thetaoffset),(15+Theta0-thetaoffset),$tmp[V_Value]
	return 0
	endif
	endif
	endif
end

Function gettraces(ctrlName) : ButtonControl
	String ctrlName

	
	newdatafolder/O/S root:ARToFData:traces
	
	killwaves/A ////modified by JXW 2011-03-03
	
	setdatafolder root:PROCESS
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)

	wave theta_angle=root:OriginalData:Theta_Angle
	wave phi_angle=root:OriginalData:Phi_Angle
	wave omega_angle=root:OriginalData:Omega_Angle
	wave processflag=root:OriginalData:ProcessFlag
	wave/T processimage=root:OriginalData:ProcessedImage
	
	nvar processedimageflag=root:PROCESS:ProcessedImageFlag
	nvar offsettheta=root:ARToFData:offsettheta
	nvar offsetomega=root:ARToFData:offsetomega
	nvar offsetphi=root:ARToFData:offsetphi
	
	
	////adding Lienear offset 
	nvar lomegaoffset1=root:ARToFData:lomegaoffset1
	nvar lomegaoffset2=root:ARToFData:lomegaoffset2
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffsets=root:ARToFData:lphioffset1
	nvar lphioffsete=root:ARToFData:lphioffset2
	variable lphioffset1=-lphioffsets
	variable lphioffset2=-lphioffsete
	
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	variable lthetainter=(lthetaoffset1*orithetaend-lthetaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lthetacof=(lthetaoffset2-lthetaoffset1)/(orithetaend-orithetastart)
	
	variable lphiinter=(lphioffset1*orithetaend-lphioffset2*orithetastart)/(orithetaend-orithetastart)
	variable lphicof=(lphioffset2-lphioffset1)/(orithetaend-orithetastart)
	
	variable lomegainter=(lomegaoffset1*orithetaend-lomegaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lomegacof=(lomegaoffset2-lomegaoffset1)/(orithetaend-orithetastart)
	////adding Lienear offset 	
	
	variable phimin,phiinc,phimax,phi,theta,omega,ii=0,cutsnum
	cutsnum=dimsize(theta_angle,0)
	string Rkx,Rky,tmpstr
	
	make/O/N=50 root:ARToFData:traces:phivalue,root:ARToFData:traces:Kx,root:ARToFData:traces:Ky
	wave phi0=root:ARToFData:traces:phivalue
	wave Kx=root:ARToFData:traces:Kx
	wave Ky=root:ARToFData:traces:Ky
	do
		if(processedimageflag==processflag[ii])
			tmpstr=processimage[ii]
			wave tmp=$tmpstr
			phimin=dimoffset(tmp,1)
			phiinc=dimdelta(tmp,1)
			phimax=phimin+(dimsize(tmp,1)-1)*phiinc
			
			phi=phi_angle[ii]
			theta=theta_angle[ii]
			omega=omega_angle[ii]
			

			Rkx="Rkx"+tmpstr
			Rky="Rky"+tmpstr
			
			make/O/N=50 root:ARToFData:traces:$Rkx
			make/O/N=50 root:ARToFData:traces:$Rky
			
			wave Rkxwave=root:ARToFData:traces:$Rkx
			wave Rkywave=root:ARToFData:traces:$Rky
			
			//phi0=phimin+(phimax-phimin)/49*x+phi-offsetphi
		
			
			
			phi0=-phimax+(phimax-phimin)/49*x+phi-offsetphi
			
			if(Phi>90)
			phi0=-(180+phi0)
			endif
			
			
			theta=theta-offsettheta
			omega=omega-offsetomega
			
			phi0=phi0-lphiinter-lphicof*(theta+offsettheta)
			theta=theta-lthetainter-lthetacof*(theta+offsettheta)
			
			
			Ky=K0*sin(3.1416/180*theta)*cos(3.1416/180*(phi0)) 
        	Kx=K0*sin(3.1416/180*(phi0)) 
        	
        	
        	Rkywave=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+omega*3.1416/180) 
			Rkxwave=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+omega*3.1416/180)  
			
			appendtograph Rkywave VS Rkxwave
			ModifyGraph rgb($Rky)=(0,0,0)
			
				endif
				ii+=1	
	while(ii<cutsnum)
	setdatafolder root:ARToFData
end

Function removetraces(ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:ARToFData:traces
	variable ii,itemnum
	string toberemovelist,tmp
	toberemovelist=wavelist("Rky*",";","DIMS:1")
	itemnum=itemsinlist(toberemovelist)
	ii=0
	do
		tmp=stringfromlist(ii,toberemovelist)
			
		removefromgraph $tmp	
		ii+=1
	while(ii<itemnum)
	setdatafolder root:ARToFData

End

function edcandmdc2nd()

	SetDataFolder  root:PROCESS
	nvar edc2d=root:PROCESS:edc2d
	nvar mdc2d=root:PROCESS:mdc2d
   
   string backprocessfilelist=WaveList("!image*",";","DIMS:2"),oriback_procstring,desback_procstring,edc_procstring,mdc_procstring
   variable ii=0,imagelistlimit
   
   if(edc2d==1)
   		
   
   imagelistlimit=itemsinlist(backprocessfilelist)
   newdatafolder/O root:PROCESS:edc 
   do
   		oriback_procstring=stringfromlist(ii,backprocessfilelist)
   		duplicate/O $oriback_procstring root:PROCESS:edc:$oriback_procstring
   		ii+=1
   	while(ii<imagelistlimit)
   	
   	ii=0
   	do
   		edc_procstring=stringfromlist(ii,backprocessfilelist)
   		MDC2dFS(edc_procstring)
   		ii+=1
   	while(ii<imagelistlimit)
   	killwaves/Z TempSecDImage
   	endif
  
  
   	if(mdc2d==1)	
   		
   imagelistlimit=itemsinlist(backprocessfilelist)
   newdatafolder/O root:PROCESS:mdc
   do
   		oriback_procstring=stringfromlist(ii,backprocessfilelist)
   		duplicate/O $oriback_procstring root:PROCESS:mdc:$oriback_procstring
   		ii+=1
   	while(ii<imagelistlimit)
   
   	ii=0
   	do
   		mdc_procstring=stringfromlist(ii,backprocessfilelist)
   		EDC2dFS(mdc_procstring)
   		ii+=1
   	while(ii<imagelistlimit)
   	killwaves/Z TempSecDImage
   	endif
   	

end

function recoverorginalimage()

	string curr
	curr=getdatafolder(1)
	
	nvar mdc2d=root:PROCESS:mdc2d
	nvar edc2d=root:PROCESS:edc2d
	
	string namelist,tmpstr
	variable ii=0
	
	if(edc2d==1)
	setdatafolder root:PROCESS:edc
	namelist=wavelist("*",";","DIMS:2")
	ii=0
	do
		tmpstr=stringfromlist(ii,namelist)
		duplicate/O $tmpstr root:PROCESS:$tmpstr
		killwaves/Z $tmpstr
		ii+=1
	while(ii<itemsinlist(namelist))
	endif
	
	if(mdc2d==1)
	setdatafolder root:PROCESS:mdc
	namelist=wavelist("*",";","DIMS:2")
	ii=0
	do
		tmpstr=stringfromlist(ii,namelist)
		duplicate/O $tmpstr root:PROCESS:$tmpstr
		killwaves/Z $tmpstr
		ii+=1
	while(ii<itemsinlist(namelist))
	endif
end

Function sycomegaoffset(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar omegaoffset=root:PROCESS:OmegaOffset
	nvar offsetomega=root:ARToFData:offsetomega
	omegaoffset=offsetomega
	
	showintensityvsk_adjustoffset()

End

Function sycthetaoffset(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar thetaoffset=root:PROCESS:ThetaOffset
	nvar offsettheta=root:ARToFData:offsettheta
	thetaoffset=offsettheta
	
	showintensityvsk_adjustoffset()

End

Function sycphioffset(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	nvar phioffset=root:PROCESS:PhiOffset
	nvar offsetphi=root:ARToFData:offsetphi
	phioffset=offsetphi
	
	showintensityvsk_adjustoffset()
End

proc getEDCstack(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData
	dowindow/F getedcstackpanel
	if(V_Flag==0)
	

	variable/G	 edcstack_offset=NumVarOrDefault("root:ARToFData:edcstack_offset",0)
	variable/G	 edcstack_bindingnum=NumVarOrDefault("root:ARToFData:edcstack_bindingnum",0)
	variable/G	 edcstack_energystart=NumVarOrDefault("root:ARToFData:edcstack_energystart",0)
	variable/G	 edcstack_energyend=NumVarOrDefault("root:ARToFData:edcstack_energyend",0)
	variable/G	 edcstack_kstart=NumVarOrDefault("root:ARToFData:edcstack_kstart",0)
	variable/G	 edcstack_kend=NumVarOrDefault("root:ARToFData:edcstack_kend",0)
	variable/G	 edcstack_symmetrizeornot=NumVarOrDefault("root:ARToFData:symmetrizeornot",0)
	variable/G	 edcstack_err=NumVarOrDefault("root:ARToFData:edcstack_err",0)
	getedcstackpanel()
	endif
   setdatafolder curr

End

Function getedcstackmain(ctrlName) : ButtonControl
	String ctrlName
string curr=getdatafolder(1)
	
	newdatafolder/O :EDCStack
	nvar MDCstackoffset=root:ARToFData:edcstack_offset
	nvar MDCstackbindingnum=root:ARToFData:edcstack_bindingnum
	nvar MDCstackEstart=root:ARToFData:edcstack_energystart
	nvar MDCstackEend=root:ARToFData:edcstack_energyend
	nvar MDCstackKstart=root:ARToFData:edcstack_kstart
	nvar MDCstackKend=root:ARToFData:edcstack_kend
	nvar syornot=root:ARToFData:edcstack_symmetrizeornot
	nvar err=root:ARToFData:edcstack_err
	string imagenameslist
	imagenameslist=imagenamelist("",";")
	//string tmpstr
	Variable p1= strsearch(imagenameslist, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif
	imagenameslist=imagenameslist[0,p1-1]
	
	wave tmp=ImageNameToWaveRef("",imagenameslist)////////
	
	string edcnamepre=imagenameslist
	

	//print nameofwave(tmp)
	variable Emin,Einc,Epnts,Emax,xmin,xinc,xpnts,ee0,ii,jj,kk,ee,kk0,bindingnumMDC,kx,Emin0,Emax0,kmax0,kmin0
	bindingnumMDC=MDCstackbindingnum
	
	//xmin=dimoffset(tmp,0)
	//xinc=dimdelta(tmp,0)
	//xpnts=dimsize(tmp,0)


	
	//Einc=dimdelta(tmp,1)
	//Epnts=dimsize(tmp,1)
	xmin=MDCstackKstart
	xinc=dimdelta(tmp,0)
	if(xinc<0)
		xinc=-xinc
	endif
	xpnts=round((MDCstackKend-MDCstackKstart)/xinc+1)
	kmin0=dimoffset(tmp,0)
	kmax0=kmin0+(dimsize(tmp,0)-1)*xinc
	
	Emin0=dimoffset(tmp,1)
	Emin=MDCstackEstart
	Einc=dimdelta(tmp,1)		
	Epnts=round(abs((MDCstackEend-MDCstackEstart)/Einc)+1)
	
	Emax0=Emin0+(dimsize(tmp,1)-1)*Einc
	string EDCtracename,firstMDCtrace
	//print MDCstackKend,MDCstackKstart,xinc,Einc,xpnts
	dowindow/K EDCStackPanel
	setdatafolder :EDCStack
	killwaves/Z/A
	setdatafolder curr
	
	display/K=1 
	
	//print Emin,Epnts,Einc
	//reverse the fitting order if E_end<E_start
	if(MDCstackEend<MDCstackEstart)
	Einc=-Einc
	endif
	//reverse the fitting order if E_end<E_start
	
	ii=0
	jj=0
	kk=0
	do
	kk0=xmin+kk*xinc

	if(kk0<0)
	//sprintf MDCtracename,"HValueN%.0fmeV",-ee0*1000
	sprintf EDCtracename,edcnamepre+"N%.0f",-kk0*1000
	else
	//sprintf MDCtracename,"HValueP%.0fmeV",ee0*1000
	sprintf EDCtracename,edcnamepre+"P%.0f",kk0*1000
	endif
	
	
	make/O/N=(Epnts) :EDCStack:$EDCtracename
	wave EDC4ArbCut=:EDCStack:$EDCtracename
	
	ii=0
	do
		ee=Emin+ii*Einc
		jj=-bindingnumMDC/2
		do
			kx=kk0+jj*xinc
			if((kx<=kmax0)&&(kx>=kmin0))
			EDC4ArbCut[ii]+=interp2D(tmp,kx,ee)
			endif
		
		//jj+=1
		jj+=0.5
		while(jj<=bindingnumMDC/2)
	
		
		EDC4ArbCut[ii]+=MDCstackoffset*kk
		
	ii+=1
	while(ii<Epnts)
	//print ee0,Einc
	if(syornot==0)
	setscale/P x,Emin,Einc,EDC4ArbCut
	appendtograph EDC4ArbCut
	endif
	
	if(syornot==1)
	setscale/P x,Emin,Einc,EDC4ArbCut
	wave symmwave=WaveSymmetrizeJXW(EDC4ArbCut,0)
	duplicate/O symmwave :EDCStack:$EDCtracename
	appendtograph  :EDCStack:$EDCtracename
	endif

	kk+=MDCstackbindingnum
	while(kk<xpnts)
	

	
	ModifyGraph tick=2,mirror=2
	//Label left "\\Z15MDCIntensity"
	//Label bottom "\\Z15K//"
	//ModifyGraph width={Aspect,0.7}
	dowindow/C EDCStackPanel
	
	setdatafolder curr
	

End

Function/Wave WaveSymmetrizeJXW2(Wave1D,SymmValue)

Wave Wave1D
Variable  SymmValue
NVar ErToler=root:ARToFData:edcstack_err


    Variable NXO, XminO, XincO, XmaxO
	NXO=DimSize(Wave1D, 0)
	XminO=DimOffset(Wave1D,0)
    XincO=round(DimDelta(Wave1D,0) * 1E6) / 1E6	
	XmaxO=XminO+(NXO-1)*XincO

////    Variable  NxInterWave1D=Round(XincO/ErToler*1000)*NXO
////    Variable  NNxInterWave1D=Round((XmaxO-XminO)/ErToler*1000+1)
    
    Variable  NxInterWave1D=Round((XmaxO-XminO)/ErToler*1000+1)  
    
    
////    Print "Nx=", NxInterWave1D
////    Print "NNx=", NNxInterWave1D

// Print "Xinc=", XincO, "ErToler=", ErToler, "NxInterWaveD=",  NxInterWave1D
//  	Print "XminO=", XminO, "XmaxO=", XmaxO, "XincO=", XincO	
	
	
    Interpolate2/T=1/N=(NxInterWave1D)/Y=Wave1D_L Wave1D
    
    
    Variable NX, Xmin, Xinc, Xmax
	NX=DimSize(Wave1D_L, 0)
	Xmin=DimOffset(Wave1D_L,0)
    Xinc=round(DimDelta(Wave1D_L,0) * 1E6) / 1E6	
	Xmax=Xmin+(NX-1)*Xinc  
	
    Duplicate/O Wave1D_L NWave1D  

    Variable NXL, NXR
    
    IF ((Xmax-SymmValue)<0)    
       NXL=NX
       NXR=0
    EndIF
     
    
    
    IF ((Xmin-SymmValue)>0)    
       NXR=NX
       NXL=0
    EndIF  
    
    
    
    IF ((Xmax-SymmValue)>=0)    
         
         IF ((Xmin-SymmValue)<=0)      
         NXL=Round((SymmValue-Xmin)/Xinc)
         NXR=Round(NX-NXL)
         EndIF       
        
    EndIF
    
//  Print "NXL=", NXL, "NXR=", NXR
    
//  Variable NWaveD=2*max(NXL,NXR)
    Variable NWaveD
    
    IF (NXL>=NXR)
        NWaveD=Round((2*SymmValue-2*Xmin)/Xinc)+1
    Else
        NWaveD=Round((2*Xmax-2*SymmValue)/Xinc)+1 
    EndIF 
    
    
    Variable NWavemin, NWavemax
    
    
    IF(NXL>=NXR)
        NWavemin=Xmin
        NWavemax=2*SymmValue-Xmin
    Else 
        NWavemax=Xmax
        NWavemin=2*SymmValue-Xmax
    EndIF
    
/// Print "Xmin=", Xmin,"Xmax=", Xmax, "NWaveD=",NWaveD, "NWavemin=", NWavemin, "NWavemax=", NWavemax    
    
    Make/O/N=(NWaveD)  EnWave, EnWaveL, EnWaveR
    Setscale/I x, (NWavemin),(NWavemax), EnWave
    Setscale/I x, (NWavemin), (NWavemax), EnWaveL  
    Setscale/I x, (NWavemin), (NWavemax), EnWaveR    
     
    EnWaveL=0
    EnWaveR=0
    
    Variable i
  
   
    i=0    
    DO   
        IF (NXL>=NXR)
            IF (i<NX)
            EnWaveL[i]=NWave1D[i]
            Else
            EnWaveL[i]=NWave1D[NX-1]
            EndIF
//      EnWaveR[NXL-NXR+i]=NWave1D[NX-i]
        Else
//      EnWaveR[NXR-NXL+i]=NWave1D[i]
        
            IF (i<NX)
            EnWaveL[i]=NWave1D[NX-1-i]
            Else
            EnWave[i]=NWave1D[0]
            EndIF 
        
        
        
//      Print NX, EnWaveL[i], Wave1D[NX-1-i]     
        EndIF
        
        EnWaveR[NWaveD-i-1]=EnWaveL[i]
        
             
    i+=1    
    While (i<NWaveD)
    
    EnWave=EnwaveL + EnWaveR
    

////Edit EnWave, EnWaveL, EnWaveR    
//Display EnWave

Return EnWave
    
End

Window getedcstackpanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(728,190,937,329) 
	ModifyPanel fixedSize=1, frameStyle=1
	SetVariable edcstack_offset,pos={17,18},size={80,20},title="\\F'@Arial Unicode MS'Offset"
	SetVariable edcstack_offset,value= root:ARToFData:edcstack_offset
	SetVariable edcstack_bindingnum,pos={109,18},size={90,20},title="\\F'@Arial Unicode MS'Bind#"
	SetVariable edcstack_bindingnum,value= root:ARToFData:edcstack_bindingnum
	SetVariable edcstack_energystart,pos={16,44},size={90,20},title="\\F'@Arial Unicode MS'EStart"
	SetVariable edcstack_energystart,value= root:ARToFData:edcstack_energystart
	SetVariable edcstack_energyend,pos={110,45},size={90,20},title="\\F'@Arial Unicode MS'EEnd"
	SetVariable edcstack_energyend,value= root:ARToFData:edcstack_energyend
	SetVariable edcstack_kstart,pos={16,67},size={90,20},title="\\F'@Arial Unicode MS'KStart"
	SetVariable edcstack_kstart,value= root:ARToFData:edcstack_kstart
	SetVariable edcstack_kend,pos={110,68},size={90,20},title="\\F'@Arial Unicode MS'KEnd"
	SetVariable edcstack_kend,value= root:ARToFData:edcstack_kend
	CheckBox edcstack_syornot,pos={17,95},size={71,16},title="\\F'@Arial Unicode MS'Symornot"
	CheckBox edcstack_syornot,variable= root:ARToFData:edcstack_symmetrizeornot
	Button edcstack_get,pos={15,116},size={183,20},proc=getedcstackmain,title="\\F'@Arial Unicode MS'GetStack"
	SetVariable edcstack_err,pos={96,94},size={70,20},title="\\F'@Arial Unicode MS'Err"
	SetVariable edcstack_err,value= root:ARToFData:edcstack_err
EndMacro


Function getkxkyEDC(ctrlName) : ButtonControl
	String ctrlName
	

	controlinfo/W=VisualizeARToFData Dispersion
	if(V_Value)
	dispersionandfit(ctrlName,0)
	TabControl Dispersion,win=VisualizeARToFData,value=0
	endif
	
	setdatafolder root:ARToFData
	nvar artof_flag

	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant
	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
	nvar RAngle=root:ARToFData:RotationAngle
	nvar Theta0=root:ARToFData:ThetaAngle
	nvar Phi0=root:ARToFData:PhiAngle
	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	nvar/Z omegaoffset=root:PROCESS:OmegaOffset
	//nvar/Z omegaoffset=root:ARToFData:offsetomega
	svar choosecolortablename=root:ARToFData:choosecolortablename
	//variable RK0=K0*sin(3.1416/180*(DetectorAngle0/2))
	
	//wave/Z theta_angle=root:OriginalData:Theta_Angle
	//wave/Z phi_angle=root:OriginalData:Phi_Angle
	wave/Z omega_angle=root:OriginalData:Omega_Angle
	wave/Z processflag=root:OriginalData:ProcessFlag

	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	nvar artofflag=root:MomentumMap:ARToFFlag
	nvar BZShowmode=root:ARToFData:BZShowMode
	nvar fromline2artof=root:MomentumMap:fromline2artof
	
	////adding Lienear offset 
	nvar lomegaoffset1=root:ARToFData:lomegaoffset1
	nvar lomegaoffset2=root:ARToFData:lomegaoffset2
	nvar lthetaoffset1=root:ARToFData:lthetaoffset1
	nvar lthetaoffset2=root:ARToFData:lthetaoffset2
	nvar lphioffset1=root:ARToFData:lphioffset1
	nvar lphioffset2=root:ARToFData:lphioffset2
	
	nvar orithetastart=root:ARToFData:orithetastart
	nvar orithetaend=root:ARToFData:orithetaend
	nvar oriphistart=root:ARToFData:oriphistart
	nvar oriphiend=root:ARToFData:oriphiend
	
	variable lthetainter=(lthetaoffset1*orithetaend-lthetaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lthetacof=(lthetaoffset2-lthetaoffset1)/(orithetaend-orithetastart)
	
	variable lphiinter=(lphioffset1*orithetaend-lphioffset2*orithetastart)/(orithetaend-orithetastart)
	variable lphicof=(lphioffset2-lphioffset1)/(orithetaend-orithetastart)
	
	variable lomegainter=(lomegaoffset1*orithetaend-lomegaoffset2*orithetastart)/(orithetaend-orithetastart)
	variable lomegacof=(lomegaoffset2-lomegaoffset1)/(orithetaend-orithetastart)
	////adding Lienear offset 	

	nvar/Z processedimageflag=root:PROCESS:ProcessedImageFlag

	nvar/Z thetaoffset=root:PROCESS:ThetaOffset
	nvar/Z phioffset=root:PROCESS:PhiOffset
	nvar/Z omegaoffset=root:PROCESS:OmegaOffset
	nvar omegaoffset=root:ARToFData:offsetomega
	
	variable ii,omega,datapntnum
	datapntnum=dimsize(processflag,0)
	
	ii=0
	if(artof_flag==0)
	do
		if(processedimageflag==processflag[ii])
		omega=omega_angle[ii]
		//phiangle=phi_angle[ii]
		break
		endif
		ii+=1
	while(ii<datapntnum)
	omega=omega-omegaoffset
	endif
	
	if(artof_flag==1)
	omega=Rangle-omegaoffset
	endif
	
	//wave Rky_wave,Rkx_wave
	//variable pntnum
	//pntnum=dimsize(Rky_wave,0)
	
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=$S_Value
	
	variable Emin,Einc,Elength,Ebinding
	Emin=dimoffset($tmp[V_Value],2)
	Einc=dimdelta($tmp[V_Value],2)
	Elength=dimsize($tmp[V_Value],2)
	
	string Sxx,Syy
	
	variable jj=0,kk=0,xx,yy,ee,xx0,yy0
		
	make/O/N=(Elength) KxKyEDC=0
	
	
	variable kx,ky,theta,phi,interp_value
	
	nvar kxkyposcursor=root:ARToFData:kxkyposcursor
	nvar EDCkxpos=root:ARToFData:EDCkxpos
	nvar EDCkypos=root:ARToFData:EDCkypos
	
	
	if(kxkyposcursor==0)
	xx0=xcsr(A,"IntensityVSK")
	yy0=vcsr(A,"IntensityVSK")
	EDCkxpos=xx0
	EDCkypos=yy0
	else
	xx0=EDCkxpos
	yy0=EDCkypos
	endif
	
	make/O/N=1 EDCkposinforx,EDCkposinfory
	 EDCkposinforx=xx0
	 EDCkposinfory=yy0
	 
	nvar ktolerance=root:ARToFData:ktolerance
	

	///----fix phi>90 bug
	variable vv
	nvar v1=root:ARToFData:oriphiend
	nvar v2=root:ARToFData:oriphistart
	vv=min(abs(v1),abs(v2))
	///----fix phi>90 bug	
	//print Emin
	jj=0
	ii=0
	kk=0
	do
	ee=Emin+jj*Einc
		
		ii=-ktolerance/2
		do
			kk=-ktolerance/2
			do
			
				xx=xx0+ii*0.01
				yy=yy0+kk*0.01
			
				kx=cos(omega*pi/180)*xx+sin(omega*pi/180)*yy
				ky=-sin(omega*pi/180)*xx+cos(omega*pi/180)*yy
		
		
				K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+ee)
		
				if(artof_flag==0)
				phi=-asin(kx/K0)
				endif
				if(artof_flag==1)
				phi=asin(kx/K0)
				endif
		
				theta=asin(ky/K0/cos(phi))
	
				theta=theta*180/pi
				phi=phi*180/pi	
				
				///----fix phi>90 bug
				if(vv>90)
				phi=-(180+phi)
				endif
				///--fix phi>90 bug
				if(!artof_flag)
				theta=(theta+lthetainter+lthetacof*thetaoffset)/(1-lthetacof)//+thetaoffset
				phi=phi+lphiinter+lphicof*(theta+thetaoffset)
				endif
				if(cmpstr("NaN",num2str(interp3D($tmp[V_Value],phi,theta,ee))))
				KxKyEDC[jj]+=interp3D($tmp[V_Value],phi,theta,ee)
				endif
			kk+=1
			while(kk<=ktolerance/2)
		ii+=1
		while(ii<=ktolerance/2)
	
	jj+=1
while(jj<Elength)
	
	setscale/P x,Emin,Einc,KxKyEDC
	
	string kxkyedcinfor
	sprintf kxkyedcinfor,"(Kx,Ky)=(%.2f,%.2f)",xx0,yy0
	removefromgraph/Z/W=IntensityVSK EDCkposinfory
	appendtograph/W=IntensityVSK EDCkposinfory vs EDCkposinforx
	ModifyGraph/W=IntensityVSK mode(EDCkposinfory)=3,marker(EDCkposinfory)=19,msize(EDCkposinfory)=5
	//ModifyGraph/W=IntensityVSK
	dowindow/F ArbKxKyEDC
	if(V_Flag==0)
	display/K=1 KxKyEDC
	
	ModifyGraph mirror=2,fStyle=1,standoff=0
	ModifyGraph tick(left)=2,noLabel(left)=1;DelayUpdate
	Label left "\\Z14EDC Intensity"
	Label bottom "\\f01\\Z15E-E\\Bf\\M\\Z15(eV)"
	dowindow/C ArbKxKyEDC	
	endif	
	TextBox/W=ArbKxKyEDC/C/N=EDCbox/F=0/A=MC "\\f01\\Z15"+kxkyedcinfor			
	dowindow/F VisualizeARToFData

End

Function calcutsarea(ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:ARToFData
	nvar omega0000=root:ARToFData:Rotationangle
	nvar theta0000=root:ARToFData:thetaangle
	nvar theta10000=root:ARToFData:thetaangle1
	nvar phi0000=root:ARToFData:phiangle


	
	nvar PhotonE=root:ARToFData:PhotonEnergy
	nvar WorkFunc= root:ARToFData:WorkFunction
	nvar LC=root:ARToFData:LatticeConstant

	Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)


	nvar DetectorAngle0=root:ARToFData:DetectorAngle
	nvar BZShowmode=root:ARToFData:BZShowMode





variable xmin,xinc,ymin,yinc,kxpnts,kypnts




if(BZShowmode==0)

make/O/N=(200,200) calcuts_area=0
xmin=-1
ymin=-1
xinc=0.01
yinc=0.01
kxpnts=200
kypnts=200
setscale/I x,-1,1,calcuts_area
setscale/I y,-1,1,calcuts_area

endif 

if((BZShowmode==1)||(BZShowmode==2))

make/O/N=(400,400)calcuts_area=0
xmin=-2
ymin=-2
xinc=0.01
yinc=0.01
kxpnts=400
kypnts=400
setscale/I x,-2,2,calcuts_area
setscale/I y,-2,2,calcuts_area

endif

if(BZShowmode==3)

make/O/N=(600,600) calcuts_area=0
xmin=-3
ymin=-3
xinc=0.01
yinc=0.01
kxpnts=600
kypnts=600
setscale/I x,-3,3,calcuts_area
setscale/I y,-3,3,calcuts_area

endif 


variable theta_start,theta_end,Phi0,RAngle,ii


theta_start=theta0000
theta_end=theta10000

Phi0=phi0000

Rangle=omega0000


variable detect_e,detect_s,K0min,K0max


K0min=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
K0max=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)

variable kx1_s,ky1_s,kx2_s,ky2_s,kx1_e,ky1_e,kx2_e,ky2_e,mediavalue

detect_s=-DetectorAngle0/2
detect_e=DetectorAngle0/2



if(Phi0+detect_s>=0)
	 kx1_s=K0min*sin(3.1416/180*(Phi0+detect_s))
	 kx2_s=K0max*sin(3.1416/180*(Phi0+detect_e))
	 ky1_s=K0min*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s))
	 ky2_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e))
	
	 kx1_e=K0min*sin(3.1416/180*(Phi0+detect_s))
	 kx2_e=K0max*sin(3.1416/180*(Phi0+detect_e))
	 ky1_e=K0min*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s))
	 ky2_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e))
endif

if(Phi0+detect_e<=0)
	 kx1_s=K0max*sin(3.1416/180*(Phi0+detect_s))
	 kx2_s=K0min*sin(3.1416/180*(Phi0+detect_e))
	 ky1_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s))
	 ky2_s=K0min*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e))
	
	 kx1_e=K0max*sin(3.1416/180*(Phi0+detect_s))
	 kx2_e=K0min*sin(3.1416/180*(Phi0+detect_e))
	 ky1_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s))
	 ky2_e=K0min*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e))
endif

if(((Phi0+detect_e)>0&&((Phi0+detect_s)<0)))
	 kx1_s=K0max*sin(3.1416/180*(Phi0+detect_s))
	 kx2_s=K0max*sin(3.1416/180*(Phi0+detect_e))
	 ky1_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_s))
	 ky2_s=K0max*sin(3.1416/180*theta_start)*cos(3.1416/180*(Phi0+detect_e))
	
	 kx1_e=K0max*sin(3.1416/180*(Phi0+detect_s))
	 kx2_e=K0max*sin(3.1416/180*(Phi0+detect_e))
	 ky1_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_s))
	 ky2_e=K0max*sin(3.1416/180*theta_end)*cos(3.1416/180*(Phi0+detect_e))
endif

//print kx1_e,ky1_e,kx2_e,ky2_e
variable Rkx1_s=sqrt(kx1_s*kx1_s+ky1_s*ky1_s)*cos((atan2(ky1_s,kx1_s))+Rangle*pi/180)
variable Rky1_s=sqrt(kx1_s*kx1_s+ky1_s*ky1_s)*sin((atan2(ky1_s,kx1_s))+Rangle*pi/180)
variable Rkx2_s=sqrt(kx2_s*kx2_s+ky2_s*ky2_s)*cos((atan2(ky2_s,kx2_s))+Rangle*pi/180)
variable Rky2_s=sqrt(kx2_s*kx2_s+ky2_s*ky2_s)*sin((atan2(ky2_s,kx2_s))+Rangle*pi/180)
//print Rkx1_s,Rky1_s,Rkx2_s,Rky2_s
variable Rkx1_e=sqrt(kx1_e*kx1_e+ky1_e*ky1_e)*cos((atan2(ky1_e,kx1_e))+Rangle*pi/180)
variable Rky1_e=sqrt(kx1_e*kx1_e+ky1_e*ky1_e)*sin((atan2(ky1_e,kx1_e))+Rangle*pi/180)
variable Rkx2_e=sqrt(kx2_e*kx2_e+ky2_e*ky2_e)*cos((atan2(ky2_e,kx2_e))+Rangle*pi/180)
variable Rky2_e=sqrt(kx2_e*kx2_e+ky2_e*ky2_e)*sin((atan2(ky2_e,kx2_e))+Rangle*pi/180)
//print Rkx1_e,Rky1_e,Rkx2_e,Rky2_e
//print xmin,xinc,ymin,yinc
variable xx,yy,zz,zz1,zz2
variable jj=0
ii=0
variable test=0


do
	jj=0
	do
	xx=xmin+ii*xinc
	yy=ymin+jj*yinc
	
	if((K0*K0-xx*xx-yy*yy)>=0)
	zz=sqrt(K0*K0-xx*xx-yy*yy)
		if((((yy-Rky2_e)*(Rkx2_e-Rkx2_s)-(Rky2_e-Rky2_s)*(xx-Rkx2_e))>0)&&(((yy-Rky1_e)*(Rkx1_e-Rkx1_s)-(Rky1_e-Rky1_s)*(xx-Rkx1_e))<0))
			
			zz1=(tan(Rangle*pi/180)*xx-yy)/sec(Rangle*pi/180)/tan(-theta_start*pi/180)
			zz2=-(tan(Rangle*pi/180)*xx-yy)/sec(Rangle*pi/180)/tan(theta_end*pi/180)
			
			//////////modify by JXW 20101215
			if((theta_start<=0)&&(theta_end>=0))
				if((zz>=zz1)&&(zz>=zz2))
				calcuts_area[ii][jj]=1
				endif
			endif
			
			if((theta_start<=0)&&(theta_end<0))
				if((zz>=zz1)&&(zz<=zz2))
				calcuts_area[ii][jj]=1
				endif
			endif
			
			if((theta_start>0)&&(theta_end>=0))
				if((zz<=zz1)&&(zz>=zz2))
				calcuts_area[ii][jj]=1
				endif
			endif
			
			if((theta_start>0)&&(theta_end<0))
				if((zz<=zz1)&&(zz<=zz2))
				calcuts_area[ii][jj]=1
				endif
			endif
		///////////modify by JXW 20101215	
		endif
	endif
	jj+=1
	while(jj<kypnts)
	ii+=1
while(ii<kxpnts)


	
	
	
	
	
	dowindow/F MomentumMapArea
	
	if(BZShowmode==0)
	if((V_Flag==0))
		dowindow/K MomentumMapArea
		Display/K=1 as "Momentum Map";AppendImage calcuts_area
		XJZSecondBZ(ctrlName)
		ModifyImage calcuts_area ctab= {0,1,Terrain256,1}
		ModifyGraph standoff=0
		ModifyGraph rgb=(0,0,0)
		ModifyGraph lsize=1
		ModifyGraph fStyle=1
		ModifyGraph width={Aspect,1}
		Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
		ModifyGraph width=368.504,height=368.504
		dowindow/C MomentumMapArea

	endif
	
	RemoveFromGraph/Z Hexy
	SetAxis bottom -1,1 
    SetAxis left -1,1  
	endif

	if(BZShowmode==1)
	if((V_Flag==0))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage calcuts_area
	XJZSecondBZ(ctrlName)
	ModifyImage calcuts_area ctab= {0,1,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea

	endif
	RemoveFromGraph/Z Hexy
	SetAxis bottom -2,2 
    SetAxis left -2,2 
	endif
	
    IF (BZShowmode==2)    
	if((V_Flag==0))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage calcuts_area
	XJZSecondBZ(ctrlName)
	ModifyImage calcuts_area ctab= {0,1,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea

	endif
	RemoveFromGraph/Z Hexy
	XJZThirdBZ(ctrlName)      
	ModifyGraph rgb(Hexy)=(0,65280,0) 
    ModifyGraph lsize(Hexy)=2  
    
	SetAxis bottom -2,2 
    SetAxis left -2,2 	                              
    ENDIF

	if(BZShowmode==3)
	if((V_Flag==0))
	dowindow/K MomentumMapArea
	Display/K=1 as "Momentum Map";AppendImage calcuts_area
	XJZSecondBZ(ctrlName)
	ModifyImage calcuts_area ctab= {0,1,Terrain256,1}
	ModifyGraph standoff=0
	ModifyGraph lsize=1
	ModifyGraph fStyle=1
	ModifyGraph width={Aspect,1}
	ModifyGraph rgb=(0,0,0)
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph width=368.504,height=368.504
	dowindow/C MomentumMapArea

	endif
	RemoveFromGraph/Z Hexy
	SetAxis bottom -3,3 
    SetAxis left -3,3 
	endif
	
	

End

Function dispersionandfit(ctrlName,tabNum) : TabControl
	String ctrlName
	Variable tabNum
	
	SetVariable setcutkx_s,win=VisualizeARToFData,disable=(tabnum!=0)
	SetVariable setcutky_s,win=VisualizeARToFData,disable=(tabnum!=0)
	PopupMenu kpntpos,win=VisualizeARToFData,disable=(tabnum!=0)
	Button clearknodes,win=VisualizeARToFData,disable=(tabnum!=0)
	SetVariable kpathpntnum,win=VisualizeARToFData,disable=(tabnum!=0)
	Button ShowKNodesInfor,win=VisualizeARToFData,disable=(tabnum!=0)
	//SetVariable setcutkx_e,win=VisualizeARToFData,disable=(tabnum!=0)
	//SetVariable setcutky_e,win=VisualizeARToFData,disable=(tabnum!=0)
	//CheckBox cursorornot,win=VisualizeARToFData,disable=(tabnum!=0)
	Button getcusors,win=VisualizeARToFData,disable=(tabnum!=0)
	Button creatcut,win=VisualizeARToFData,disable=(tabnum!=0)
	CheckBox holdimage,win=VisualizeARToFData,disable=(tabnum!=0)
	Button showEkimage,win=VisualizeARToFData,disable=(tabnum!=0)
	Button clearEKImage,win=VisualizeARToFData,disable=(tabnum!=0)
	button getarbEDC,win=VisualizeARToFData,disable=(tabnum!=0)
	setvariable bindingnumEDC,win=VisualizeARToFData,disable=(tabnum!=0)
	SetVariable EkimageEDCKpos,win=VisualizeARToFData,disable=(tabnum!=0)
	Button getarbMDC,win=VisualizeARToFData,disable=(tabnum!=0)
	SetVariable bindingnumMDC,win=VisualizeARToFData,disable=(tabnum!=0)
	SetVariable EkimageMDCEpos,win=VisualizeARToFData,disable=(tabnum!=0)
	button getEDCstack,win=VisualizeARToFData,disable=(tabnum!=0)
	//Button getarbKEDC,win=VisualizeARToFData,disable=(tabnum!=0)
	//SetVariable ktolerance,win=VisualizeARToFData,disable=(tabnum!=0)
	//SetVariable EDCkxpos,win=VisualizeARToFData,disable=(tabnum!=0)
	//SetVariable EDCkypos,win=VisualizeARToFData,disable=(tabnum!=0)
	Button getarbEDC2nd,win=VisualizeARToFData,disable=(tabnum!=0)
	SetVariable smoothnumEDC,win=VisualizeARToFData,disable=(tabnum!=0)
	Button getarbMDC2nd,win=VisualizeARToFData,disable=(tabnum!=0)
	SetVariable smoothnumMDC,win=VisualizeARToFData,disable=(tabnum!=0)
	
	
	variable checked
	if(tabnum==0)
	refreshartofdata(ctrlname)
	cusorsornot(ctrlName,checked)
	disableEDCMDC(ctrlName,checked)
	endif
	
	SetVariable MDCstackoffset,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable MDCstackbindingnum,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable MDCstackEstart,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable MDCstackEend,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable MDCstackKstart,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable MDCstackKend,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable FittingLorentznum,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable Fittingbackground1,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable fittingheight1,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable fittingfwhm1,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable fittingposition1,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable Fittingbackground2,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable fittingheight2,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable fittingfwhm2,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable fittingposition2,win=VisualizeARToFData,disable=(tabnum!=1)
	Button MDCStacks,win=VisualizeARToFData,disable=(tabnum!=1)
	Button MDCfitting,win=VisualizeARToFData,disable=(tabnum!=1)
	//PopupMenu showfitteddispersion,win=VisualizeARToFData,disable=(tabnum!=1)
	//PopupMenu showfitteddispersion,mode=1,popvalue="Yes",value= #"\"Yes;No\""
	SetVariable energynearEF,win=VisualizeARToFData,disable=(tabnum!=1)
	SetVariable energyfarEF,win=VisualizeARToFData,disable=(tabnum!=1)
	//PopupMenu showrealenergy,win=VisualizeARToFData,disable=(tabnum!=1)
	//PopupMenu showimageenergy,win=VisualizeARToFData,disable=(tabnum!=1)
	//PopupMenu showimageenergy,win=VisualizeARToFData,disable=(tabnum!=1)
	Button showdispersion,disable=(tabnum!=1)
	Button ShowfittedDispersion,disable=(tabnum!=1)
	Button showcutpos,disable=(tabnum!=1)
	Button ShowImageEnergy,disable=(tabnum!=1)


	
	if(tabnum==1)
	loretznum("",1,"","")
	endif
	if(tabnum==1)
			setdatafolder root:ARToFData
			string artofdatanamelist
         	wave/T fittednamelist=root:ARToFData:MDCFit:fittednamelist
			//svar imagelist
			variable ii,itemnum
			artofdatanamelist=wavelist("EKImage*",";","DIMS:2")
			itemnum=itemsinlist(artofdatanamelist)
			redimension/N=(itemnum) fittednamelist
			ii=0
			do
			fittednamelist[ii]=stringfromlist(ii,artofdatanamelist)
			//print stringfromlist(ii,artofdatanamelist)
			ii+=1
			while(ii<itemnum)
	
			ListBox artofdata,listWave=root:ARToFData:MDCFit:fittednamelist
	
	endif
	return 0
End

Function showdispersion(ctrlName) : ButtonControl
	String ctrlName
	svar choosecolortablename=root:ARToFData:choosecolortablename
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=root:ARToFData:MDCFit:$S_Value
	dowindow/K DispersionImage
	display/K=1
	appendimage $tmp[V_Value]
	variable popNum
	choosecolortable(ctrlName,popNum,choosecolortablename)
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	Label bottom "\\F'Times'\\Z18K//(\\F'symbol'p/\\F'Times'a)"
	ModifyGraph width={Aspect,0.7}
	dowindow/C DispersionImage
End

Function MDCStacks(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData:MDCFit
	newdatafolder/O/S root:ARToFData:MDCFit:MDCsStack
	nvar MDCstackoffset=root:ARToFData:MDCFit:MDCstackoffset
	nvar MDCstackbindingnum=root:ARToFData:MDCFit:MDCstackbindingnum
	nvar MDCstackEstart=root:ARToFData:MDCFit:MDCstackEstart
	nvar MDCstackEend=root:ARToFData:MDCFit:MDCstackEend
	nvar MDCstackKstart=root:ARToFData:MDCFit:MDCstackKstart
	nvar MDCstackKend=root:ARToFData:MDCFit:MDCstackKend
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp1=root:ARToFData:MDCFit:$S_Value
	wave tmp=root:ARToFData:$tmp1[V_Value]
	variable Emin,Einc,Epnts,Emax,xmin,xinc,xpnts,ee0,ii,jj,kk,ee,bindingnumMDC,kx,Emin0,Emax0
	bindingnumMDC=MDCstackbindingnum
	
	//xmin=dimoffset(tmp,0)
	//xinc=dimdelta(tmp,0)
	//xpnts=dimsize(tmp,0)


	
	//Einc=dimdelta(tmp,1)
	//Epnts=dimsize(tmp,1)
	xmin=MDCstackKstart
	xinc=dimdelta(tmp,0)
	xpnts=round((MDCstackKend-MDCstackKstart)/xinc+1)
	
	Emin0=dimoffset(tmp,1)
	Emin=MDCstackEstart
	Einc=dimdelta(tmp,1)
	Epnts=round((MDCstackEend-MDCstackEstart)/Einc+1)
	Emax0=Emin0+(dimsize(tmp,1)-1)*Einc
	string MDCtracename,firstMDCtrace
	
	dowindow/K MDCStackPanel
	killwaves/Z/A
	display/K=1 
	
	ii=0
	jj=0
	kk=0
	do
	ee0=Emin+kk*Einc
	if(ee0<0)
	sprintf MDCtracename,"MDCEbN%.0fmeV",-ee0*1000
	else
	sprintf MDCtracename,"MDCEbP%.0fmeV",ee0*1000
	endif
	
	if(kk==0)
	firstMDCtrace=MDCtracename
	endif
	
	make/O/N=(xpnts) $MDCtracename
	wave MDC4ArbCut=$MDCtracename
	ii=0
	do
		kx=xmin+ii*xinc
		jj=-bindingnumMDC/2
		do
			ee=ee0+jj*Einc
			if((ee<=Emax0)&&(ee>=Emin0))
			MDC4ArbCut[ii]+=interp2D(tmp,kx,ee)
			endif
		
		jj+=0.5
		while(jj<=bindingnumMDC/2)
		MDC4ArbCut[ii]+=MDCstackoffset*kk
	ii+=1
	while(ii<xpnts)
	
	setscale/P x,xmin,xinc,MDC4ArbCut
	appendtograph MDC4ArbCut

	kk+=MDCstackbindingnum
	while(kk<Epnts)
	
	removefromgraph $firstMDCtrace
	appendtograph $firstMDCtrace
	ModifyGraph lsize($firstMDCtrace)=2,rgb($firstMDCtrace)=(512,0,62976)
	ModifyGraph tick=2,mirror=2
	Label left "\\Z15MDCIntensity"
	Label bottom "\\Z15K//"
	ModifyGraph width={Aspect,0.7}
	dowindow/C MDCStackPanel
	setdatafolder curr
	
End


function MDCfitting(ctrlName) : ButtonControl
	String ctrlName
	
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData:MDCFit
	newdatafolder/O/S root:ARToFData:MDCFit:MDCsStack
	
	nvar MDCstackoffset=root:ARToFData:MDCFit:MDCstackoffset
	nvar MDCstackbindingnum=root:ARToFData:MDCFit:MDCstackbindingnum
	nvar MDCstackEstart=root:ARToFData:MDCFit:MDCstackEstart
	nvar MDCstackEend=root:ARToFData:MDCFit:MDCstackEend
	nvar MDCstackKstart=root:ARToFData:MDCFit:MDCstackKstart
	nvar MDCstackKend=root:ARToFData:MDCFit:MDCstackKend
	nvar FittingLorentznum=root:ARToFData:MDCFit:FittingLorentznum
	
	nvar Fittingbackground1=root:ARToFData:MDCFit:Fittingbackground1
	nvar fittingheight1=root:ARToFData:MDCFit:fittingheight1
	nvar fittingfwhm1=root:ARToFData:MDCFit:fittingfwhm1
	nvar fittingposition1=root:ARToFData:MDCFit:fittingposition1
	nvar Fittingbackground2=root:ARToFData:MDCFit:Fittingbackground2
	nvar fittingheight2=root:ARToFData:MDCFit:fittingheight2
	nvar fittingfwhm2=root:ARToFData:MDCFit:fittingfwhm2
	nvar fittingposition2=root:ARToFData:MDCFit:fittingposition2
	
	variable b1,h1,f1,p1,b2,h2,f2,p2
	b1=Fittingbackground1
	h1=fittingheight1
	f1=fittingfwhm1
	p1=fittingposition1
	b2=Fittingbackground2
	h2=fittingheight2
	f2=fittingfwhm2
	p2=fittingposition2
	
		Make/O co_OnePeak={b1, h1, f1,p1,0},E_sigma={0,0,0,0,0}
       Make/O co_TwoPeak={b1, h1, f1,p1,0,h2,f2,p2},E2_sigma={0,0,0,0,0,0,0,0}    
       
       Redimension/D co_OnePeak,E_sigma
       Redimension/D co_TwoPeak,E2_sigma
	
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp1=root:ARToFData:MDCFit:$S_Value
	wave tmp=root:ARToFData:$tmp1[V_Value]
	variable Emin,Einc,Epnts,Emax,xmin,xinc,xpnts,ee0,ii,jj,kk,ee,kx,Emin0,Emax0

	MDCstackoffset=0
	xmin=MDCstackKstart
	xinc=dimdelta(tmp,0)
	xpnts=round((MDCstackKend-MDCstackKstart)/xinc+1)
	
	Emin0=dimoffset(tmp,1)
	Emin=MDCstackEstart
	Einc=dimdelta(tmp,1)
	Epnts=round((MDCstackEend-MDCstackEstart)/Einc+1)
	Emax0=Emin0+(dimsize(tmp,1)-1)*Einc
	
	string heightname1,heightname2,fwhmname1,fwhmname2,positionname1,positionname2
	string errheightname1,errheightname2,errfwhmname1,errfwhmname2,errpositionname1,errpositionname2
	if(FittingLorentznum==1)
		heightname1="Hgh1"+tmp1[V_Value]
		fwhmname1="FWHM1"+tmp1[V_Value]
		positionname1="POS1"+tmp1[V_Value]
		errheightname1="HghErr1"+tmp1[V_Value]
		errfwhmname1="FWHMErr1"+tmp1[V_Value]
		errpositionname1="POSErr1"+tmp1[V_Value]
	
		heightname2=""
		fwhmname2=""
		positionname2=""
		errheightname2=""
		errfwhmname2=""
		errpositionname2=""
		make/O/N=(Epnts) root:ARToFData:MDCFit:$heightname1,root:ARToFData:MDCFit:$fwhmname1,root:ARToFData:MDCFit:$positionname1
		make/O/N=(Epnts) root:ARToFData:MDCFit:$errheightname1,root:ARToFData:MDCFit:$errfwhmname1,root:ARToFData:MDCFit:$errpositionname1
		wave hh1=root:ARToFData:MDCFit:$heightname1
		wave ff1=root:ARToFData:MDCFit:$fwhmname1
		wave pp1=root:ARToFData:MDCFit:$positionname1
		wave ehh1=root:ARToFData:MDCFit:$errheightname1
		wave eff1=root:ARToFData:MDCFit:$errfwhmname1
		wave epp1=root:ARToFData:MDCFit:$errpositionname1
	endif
	
	if(FittingLorentznum==2)
		heightname1="Hgh1"+tmp1[V_Value]
		fwhmname1="FWHM1"+tmp1[V_Value]
		positionname1="POS1"+tmp1[V_Value]
		errheightname1="HghErr1"+tmp1[V_Value]
		errfwhmname1="FWHMErr1"+tmp1[V_Value]
		errpositionname1="POSErr1"+tmp1[V_Value]
	
		heightname2="Hgh2"+tmp1[V_Value]
		fwhmname2="FWHM2"+tmp1[V_Value]
		positionname2="POS2"+tmp1[V_Value]
		errheightname2="HghErr2"+tmp1[V_Value]
		errfwhmname2="FWHMErr2"+tmp1[V_Value]
		errpositionname2="POSErr2"+tmp1[V_Value]
		
		make/O/N=(Epnts) root:ARToFData:MDCFit:$heightname1,root:ARToFData:MDCFit:$fwhmname1,root:ARToFData:MDCFit:$positionname1
		make/O/N=(Epnts) root:ARToFData:MDCFit:$errheightname1,root:ARToFData:MDCFit:$errfwhmname1,root:ARToFData:MDCFit:$errpositionname1
		make/O/N=(Epnts) root:ARToFData:MDCFit:$heightname2,root:ARToFData:MDCFit:$fwhmname2,root:ARToFData:MDCFit:$positionname2
		make/O/N=(Epnts) root:ARToFData:MDCFit:$errheightname2,root:ARToFData:MDCFit:$errfwhmname2,root:ARToFData:MDCFit:$errpositionname2
		wave hh1=root:ARToFData:MDCFit:$heightname1
		wave ff1=root:ARToFData:MDCFit:$fwhmname1
		wave pp1=root:ARToFData:MDCFit:$positionname1
		wave hh2=root:ARToFData:MDCFit:$heightname2
		wave ff2=root:ARToFData:MDCFit:$fwhmname2
		wave pp2=root:ARToFData:MDCFit:$positionname2
		wave ehh1=root:ARToFData:MDCFit:$errheightname1
		wave eff1=root:ARToFData:MDCFit:$errfwhmname1
		wave epp1=root:ARToFData:MDCFit:$errpositionname1
		wave ehh2=root:ARToFData:MDCFit:$errheightname2
		wave eff2=root:ARToFData:MDCFit:$errfwhmname2
		wave epp2=root:ARToFData:MDCFit:$errpositionname2
	endif	
	
	string energyname="Eng"+tmp1[V_Value]
	make/O/N=(Epnts) root:ARToFData:MDCFit:$energyname
	wave energywave=root:ARToFData:MDCFit:$energyname
	
	
	string MDCtracename
	ii=0
	jj=0
	
	ii=0
	kk=0
	do
	
	ee0=Emin+ii*Einc
	if(ee0<0)
		sprintf MDCtracename,"MDCEbN%.0fmeV",-ee0*1000
	else
		sprintf MDCtracename,"MDCEbP%.0fmeV",ee0*1000
	endif	
	energywave[kk]=ee0
	wave MDC4ArbCut=$MDCtracename
	
	if(FittingLorentznum==1)
		
			FuncFit/W=2/N=1/Q=1 XJLorentzianFit_OnePeak co_OnePeak MDC4ArbCut (MDCstackKstart,MDCstackKend)  /D//E=E_sigma
			hh1[kk]=co_OnePeak[1]
			ff1[kk]=co_OnePeak[2]
			pp1[kk]=co_OnePeak[3]
			ehh1[kk]=E_sigma[1]
			eff1[kk]=E_sigma[2]
			epp1[kk]=E_sigma[3]
			//h1=co_OnePeak[1]
			//f1=co_OnePeak[2]
		
		
	endif
	
	if(FittingLorentznum==2)
		
			FuncFit/W=2/N=1/Q=1 XJLorentzianFit_TwoPeak co_TwoPeak MDC4ArbCut (MDCstackKstart,MDCstackKend)  /D//E=E2_sigma
			hh1[kk]=co_TwoPeak[1]
			ff1[kk]=co_TwoPeak[2]
			pp1[kk]=co_TwoPeak[3]
			hh2[kk]=co_TwoPeak[5]
			ff2[kk]=co_TwoPeak[6]
			pp2[kk]=co_TwoPeak[7]
			
			//ehh1[kk]=E_sigma[1]
			//eff1[kk]=E_sigma[2]
			//epp1[kk]=E_sigma[3]
			//ehh2[kk]=E_sigma[5]
			//eff2[kk]=E_sigma[6]
			//epp2[kk]=E_sigma[7]
			
			
		
		
	endif
	kk+=1
	ii+=MDCstackbindingnum
	while(ii<Epnts)
	
	 if(FittingLorentznum==1)
	 	redimension/D/N=(kk) hh1
		redimension/D/N=(kk) ff1
		redimension/D/N=(kk) pp1
		//wave ehh1
		//wave eff1
		//wave epp1
	endif
	
	if(FittingLorentznum==2)
	 	redimension/D/N=(kk) hh1
		redimension/D/N=(kk) ff1
		redimension/D/N=(kk) pp1
		redimension/D/N=(kk) hh2
		redimension/D/N=(kk) ff2
		redimension/D/N=(kk) pp2
		//wave ehh1
		//wave eff1
		//wave epp1
	endif
	redimension/D/N=(kk) energywave
	setdatafolder curr
End

Function loretznum(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	nvar FittingLorentznum=root:ARToFData:MDCFit:FittingLorentznum
	if(FittingLorentznum==1)
	SetVariable Fittingbackground2,disable=2
	SetVariable fittingheight2,disable=2
	SetVariable fittingfwhm2,disable=2
	SetVariable fittingposition2,disable=2

	endif
	
	if(FittingLorentznum==2)
	SetVariable Fittingbackground2,disable=0
	SetVariable fittingheight2,disable=0
	SetVariable fittingfwhm2,disable=0
	SetVariable fittingposition2,disable=0

	endif
	

End

Function showfitteddispersion(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData:MDCFit
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=root:ARToFData:MDCFit:$S_Value
	nvar FittingLorentznum=root:ARToFData:MDCFit:FittingLorentznum
	string nametodisplayy1="",nametodisplayx1="",nametodisplayx2=""
	
	dowindow/K FittedDispersion
	display/K=1
	if(FittingLorentznum==1)
	nametodisplayy1="Eng"+tmp[V_Value]
	nametodisplayx1="POS1"+tmp[V_Value]
	appendtograph $nametodisplayy1 vs $nametodisplayx1
	endif
	
	if(FittingLorentznum==2)
	nametodisplayy1="Eng"+tmp[V_Value]
	nametodisplayx1="POS1"+tmp[V_Value]
	nametodisplayx2="POS2"+tmp[V_Value]
	appendtograph $nametodisplayy1 vs $nametodisplayx1
	appendtograph $nametodisplayy1 vs $nametodisplayx2
	endif
	
	Label left "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	Label bottom "\\F'Times'\\Z18K//(\\F'symbol'p/\\F'Times'a)"
	ModifyGraph width={Aspect,0.7}
	ModifyGraph mode=4,marker=19
	ModifyGraph mirror=2
	dowindow/C FittedDispersion
	setdatafolder curr
End

Function showrealenergy(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData:MDCFit
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=root:ARToFData:MDCFit:$S_Value
	nvar FittingLorentznum=root:ARToFData:MDCFit:FittingLorentznum
	nvar energynearEF=root:ARToFData:MDCFit:energynearEF
	nvar energyfarEF=root:ARToFData:MDCFit:energyfarEF
	string energyname,kposname
	string realenergyname
	
	energyname="Eng"+tmp[V_Value]
	kposname="POS1"+tmp[V_Value]
	wave energy=$energyname
	
	variable ebare,knearEF,kfarEF,epnts,ii,kpos
	epnts=dimsize($energyname,0)
	knearEF=interp(energynearEF,$energyname,$kposname)
	kfarEF=interp(energyfarEF,$energyname,$kposname)
	
	if(FittingLorentznum==1)
	realenergyname="Real"+tmp[V_Value]
	make/O/N=(epnts) $realenergyname
	
	wave tmp1=$realenergyname
	ii=0
	do
		kpos=interp(energy[ii],$energyname,$kposname)
		ebare=energynearEF+(energyfarEF-energynearEF)/(kfarEF-knearEF)*(kpos-knearEF)
		tmp1[ii]=energy[ii]-ebare
		ii+=1
	while(ii<epnts)
	endif
	tmp1*=1000
	
End

Function showimageenergy(ctrlName) : ButtonControl
	String ctrlName

	showrealenergy(ctrlName)
	
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData:MDCFit
	controlinfo/W=VisualizeARToFData artofdata
	wave/T tmp=root:ARToFData:MDCFit:$S_Value
	nvar FittingLorentznum=root:ARToFData:MDCFit:FittingLorentznum
	nvar energynearEF=root:ARToFData:MDCFit:energynearEF
	nvar energyfarEF=root:ARToFData:MDCFit:energyfarEF
	string energyname,kposname,fwhmname
	string realenergyname,imageenergyname
	
	energyname="Eng"+tmp[V_Value]
	kposname="POS1"+tmp[V_Value]
	fwhmname="FWHM1"+tmp[V_Value]
	
	wave wavefwhmname=$fwhmname
	wave energy=$energyname
	
	variable ebare,knearEF,kfarEF,epnts,ii,kpos
	epnts=dimsize($energyname,0)
	knearEF=interp(energynearEF,$energyname,$kposname)
	kfarEF=interp(energyfarEF,$energyname,$kposname)
	
	if(FittingLorentznum==1)
	realenergyname="Real"+tmp[V_Value]
	imageenergyname="Image"+tmp[V_Value]
	make/O/N=(epnts) $imageenergyname
	
	wave tmp1=$imageenergyname
	tmp1=wavefwhmname*(energyfarEF-energynearEF)/(kfarEF-knearEF)*1000
	endif

	dowindow/K ImageEnergyImage
	display/K=1
	appendtograph/L=left tmp1 vs $energyname
	appendtograph/R=right $realenergyname vs $energyname
	Label left "\\Z15Image Energy(meV)"
	Label right "\\Z15Real Energy(meV)"
	Label bottom "\\F'Times'\\Z18\\f01E-E\\BF\\M\\Z18(eV)"
	ModifyGraph mode=4,marker=19
	ModifyGraph mirror(bottom)=2
	ModifyGraph rgb($imageenergyname)=(0,0,52224)
	Legend/C/N=text0/F=0/A=MC
	dowindow/C ImageEnergyImage
	setdatafolder curr
End

Function showcutpos(ctrlName) : ButtonControl
	String ctrlName
	
	string curr=getdatafolder(1)
	setdatafolder root:ARToFData
	nvar BZshowmode=BZshowmode
	
	
	string name1="Rkx_wave",name2="Rky_wave",cutsarea="cuts2D_area"
	wave tmpx=$name1
	wave tmpy=$name2
	wave tmp=$cutsarea
	
	dowindow/K MomentumPanel
	display/K=1
	appendimage tmp
	removefromgraph/Z tmpy
	appendtograph tmpy vs tmpx
	ModifyGraph standoff=0
	ModifyImage $cutsarea ctab= {*,*,Terrain256,1}
	ModifyGraph lsize($name2)=2
	ModifyGraph width={Aspect,1}
	Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	XJZSecondBZ(ctrlName)
	if(BZshowmode==0)
	SetAxis bottom -1,1
	setaxis left -1,1
	endif
	if(BZshowmode==1)
	SetAxis bottom -2,2
	setaxis left -2,2
	endif
	
	if(BZshowmode==3)
	SetAxis bottom -3,3
	setaxis left -3,3
	endif
	
	dowindow/C MomentumPanel
	setdatafolder curr
	
End



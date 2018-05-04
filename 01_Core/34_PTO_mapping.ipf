#pragma rtGlobals=1		// Use modern global access method.

Window FS_Panel(): Panel
    if (WinType("PTO_map_Panel")==7)
      DoWindow/F NicePanel
    else
    NewPanel /K=1/W=(500,30,720,380) as "PTO_map_Panel"  
    
    GroupBox InfoPanel,pos={10,2},size={200,100},title="Info"
    SetVariable set_hv,pos={20,20},size={180,30},title="Photon Energy (eV)",fSize=12
	SetVariable set_hv,limits={-Inf,Inf,0.1},value=root:PROCESS:PhotonEnergy
	SetVariable set_wfct,pos={20,50},size={180,30},title="Workfunction      ",fSize=12
	SetVariable set_wfct,limits={-Inf,Inf,0.1},value= root:PROCESS:WorkFunction
	SetVariable set_LatticeConstant,pos={20,80},size={180,30},title="Lattice Const (A) ",fSize=12
    SetVariable set_LatticeConstant,limits={-inf,inf,0.01},value= root:PROCESS:LatticeConstant
       
    GroupBox OffsetPanel,pos={10,105},size={100,100},title="Offset"
    SetVariable set_PhiOffset,pos={20,120},size={80,30},title="Phi  ",fSize=12
	SetVariable set_PhiOffset,limits={-Inf,Inf,0.1},value=root:PROCESS:PhiOffset
	SetVariable set_OmegaOffset,pos={20,150},size={80,30},title="Omega",fSize=12
	SetVariable set_OmegaOffset,limits={-Inf,Inf,0.1},value=root:PROCESS:OmegaOffset
	SetVariable set_ThetaOffset,pos={20,180},size={80,20},title="Theta",fSize=12
    SetVariable set_ThetaOffset,limits={-inf,inf,0.1},value=root:PROCESS:ThetaOffset  
    
    GroupBox IntegratEn,pos={110,105},size={100,100},title="IntegratE(eV)"
	SetVariable set_Estart,pos={120,140},size={80,20},title="ST",fSize=12
    SetVariable set_Estart,limits={-inf,inf,0.1},value=root:PROCESS:IntegrationStart
	SetVariable set_Eend,pos={120,170},size={80,20},title="ED",fSize=12
    SetVariable set_Eend,limits={-inf,inf,0.1},value=root:PROCESS:IntegrationEnd    
    
    GroupBox KxKyPanel,pos={10,210},size={200,100},title="KxKy_Parameters"
	SetVariable set_KxStart,pos={20,225},size={100,20},title="KxStart",fSize=12
    SetVariable set_KxStart,limits={-inf,inf,0.1},value=root:PROCESS:KxStart
	SetVariable set_KxEnd,pos={125,225},size={80,20},title="End",fSize=12
    SetVariable set_KxEnd,limits={-inf,inf,0.1},value=root:PROCESS:KxEnd
 	SetVariable set_KyStart,pos={20,255},size={100,20},title="KyStart",fSize=12
    SetVariable set_KyStart,limits={-inf,inf,0.1},value=root:PROCESS:KyStart
	SetVariable set_KyEnd,pos={125,255},size={80,20},title="End",fSize=12
    SetVariable set_KyEnd,limits={-inf,inf,0.1},value=root:PROCESS:KyEnd
 	SetVariable set_KxPnts,pos={20,285},size={100,20},title="PointsKx",fSize=12
    SetVariable set_KxPnts,limits={-inf,inf,0.1},value=root:PROCESS:KxPointNumber
	SetVariable set_KyPnts,pos={125,285},size={80,20},title="Ky",fSize=12
    SetVariable set_KyPnts,limits={-inf,inf,0.1},value=root:PROCESS:KyPointNumber
     
           
    Button PTOmap,pos={60,315},size={80,20},title="Make Plot", proc=PTO_FS
    
    endif

End


Proc  PTO_FS(ctrlName) : ButtonControl
   String ctrlName
   string curr=GetDataFolder(1)
   //Setdatafolder root:FS
	//pauseupdate;silent 1

       
 	SetDataFolder  root:PROCESS
   
   //------------------------Added by JXW---------------------------------------------
   //Perform EDC2d or MDC2d FS Mapping
   
   //EDC2d Mapping
   if(edc2d==1)	//check if edc2d switch is slected
   		
   //copy the original wavelist
   string backprocessfilelist=WaveList("!*_CT",";","DIMS:2"),oriback_procstring,desback_procstring,edc_procstring
   variable ii=0,imagelistlimit
   imagelistlimit=itemsinlist(backprocessfilelist)
   newdatafolder/O root:PROCESS:edc 
   do
   		oriback_procstring=stringfromlist(ii,backprocessfilelist)
   		//desback_procstring=stringfromlist(ii,backprocessfilelist)+"_bk"
   		duplicate/O $oriback_procstring root:PROCESS:edc:$oriback_procstring
   		ii+=1
   	while(ii<imagelistlimit)
   	// EDC2d of original processed file
   	setdatafolder root:PROCESS:edc
   	ii=0
   	do
   		edc_procstring=stringfromlist(ii,backprocessfilelist)
   		MDC2dFS(edc_procstring)
   		ii+=1
   	while(ii<imagelistlimit)
   	killwaves/Z TempSecDImage
   	endif
  
   //MDC2d Mapping	
   	if(root:PROCESS:mdc2d==1)	//check if edc2d switch is slected
   		
   //copy the original wavelist
   string backprocessfilelist=WaveList("!*_CT",";","DIMS:2"),oriback_procstring,desback_procstring,mdc_procstring
   variable ii=0,imagelistlimit
   imagelistlimit=itemsinlist(backprocessfilelist)
   newdatafolder root:PROCESS:mdc
   do
   		oriback_procstring=stringfromlist(ii,backprocessfilelist)
   		//desback_procstring=stringfromlist(ii,backprocessfilelist)+"_bk"
   		duplicate/O $oriback_procstring root:PROCESS:mdc:$oriback_procstring
   		ii+=1
   	while(ii<imagelistlimit)
   	// EDC2d of original processed file
   	setdatafolder root:PROCESS:mdc
   	ii=0
   	do
   		mdc_procstring=stringfromlist(ii,backprocessfilelist)
   		EDC2dFS(mdc_procstring)
   		ii+=1
   	while(ii<imagelistlimit)
   	killwaves/Z TempSecDImage
   	endif
   	
//---------------------------------Added by JXW--------------------------------------------   
   
    String ProcessedImagefileList= WaveList("!*_CT",";","DIMS:2"),PTO_procstring//,procimage
  	Variable ProcessedImagelimit=ItemsInList( ProcessedImagefileList, ";") 

   Setdatafolder root:IMG
 //  Killwaves/Z/A
   Make/O/N=0 PTO_phiwave, PTO_thetawave, PTO_omegawave, PTO_intewave
   Make/O/T/N=0 PTO_mappedwave
   
   variable PTO_imappedwavefind,PTO_ii,PTO_ptowaveN, PTO_procnum, PTO_mappedwaveN 
   Variable PTO_ny,PTO_xmin,PTO_ymin,PTO_xinc,PTO_yinc
   Variable PTO_ifinder
//   String procimage
       
    PTO_procnum=0
    do
    PTO_procstring=stringfromlist(PTO_procnum,ProcessedImagefilelist,";")
    PTO_imappedwavefind=0  
    PTO_mappedwaveN=numpnts(PTO_mappedwave) 
    PTO_ptowaveN=numpnts(PTO_phiwave)
    
     do 
      if((PTO_mappedwaveN==0)||(cmpstr(PTO_procstring,PTO_mappedwave[PTO_imappedwavefind])==0))
       break
      endif
       PTO_imappedwavefind+=1
     while(PTO_imappedwavefind<PTO_mappedwaveN)
   
     if(PTO_imappedwavefind==PTO_mappedwaveN)
       Redimension/N=(PTO_mappedwaveN+1) PTO_mappedwave
       PTO_mappedwave[PTO_mappedwaveN]=PTO_procstring
    //edit by jxw
       if(root:PROCESS:edc2d==1)
       PTO_ny=DimSize(root:PROCESS:edc:$PTO_procstring,1)
	   endif
	   if(root:PROCESS:mdc2d==1)
	   PTO_ny=DimSize(root:PROCESS:mdc:$PTO_procstring,1)
	   endif
	   if(root:PROCESS:edc2d==0&&root:PROCESS:mdc2d==0)
	   PTO_ny=DimSize(root:PROCESS:$PTO_procstring,1) //the original
	   endif
	//edit by jxw   	   
//       print ny,ptowaveN
       Redimension/N=(PTO_ptowaveN+PTO_ny) PTO_phiwave, PTO_thetawave, PTO_omegawave, PTO_intewave
       

		
       PTO_ifinder=0 
      do
//       procimage=root:OriginalData:ProcessedImage[ifinder]
       if(cmpstr(PTO_procstring,root:OriginalData:ProcessedImage[PTO_ifinder])==0)
         
         //edit by jxw
         if(root:PROCESS:edc2d==1)
         PTO_ymin=DimOffset(root:PROCESS:edc:$PTO_procstring,1)
         PTO_yinc=round(DimDelta(root:PROCESS:edc:$PTO_procstring,1)* 1E6) / 1E6
         endif
         if(root:PROCESS:mdc2d==1)
         PTO_ymin=DimOffset(root:PROCESS:mdc:$PTO_procstring,1)
         PTO_yinc=round(DimDelta(root:PROCESS:mdc:$PTO_procstring,1)* 1E6) / 1E6
         endif
         if(root:PROCESS:edc2d==0&&root:PROCESS:mdc2d==0)
          PTO_ymin=DimOffset(root:PROCESS:$PTO_procstring,1)
         PTO_yinc=round(DimDelta(root:PROCESS:$PTO_procstring,1)* 1E6) / 1E6
         endif
         
 //        ii=0
 //        do
             
  //         phiwave[ptowaveN+ii]=root:OriginalData:Phi_Angle[ifinder]-(ymin+yinc*ii)
  //         thetawave[ptowaveN,ptowaveN+ii]=root:OriginalData:Theta_Angle[ifinder]
  //         omegawave[ptowaveN,ptowaveN+ii]=root:OriginalData:Omega_Angle[ifinder]
 //        ii+=1
 //        while(ii<ny)
         PTO_phiwave[PTO_ptowaveN,PTO_ptowaveN+PTO_ny-1]=root:OriginalData:Phi_Angle[PTO_ifinder]-(PTO_ymin+PTO_yinc*(p-PTO_ptowaveN))
         PTO_thetawave[PTO_ptowaveN,PTO_ptowaveN+PTO_ny-1]=root:OriginalData:Theta_Angle[PTO_ifinder]
         PTO_omegawave[PTO_ptowaveN,PTO_ptowaveN+PTO_ny-1]=root:OriginalData:Omega_Angle[PTO_ifinder]
         
        Make/O/N=(PTO_ny) PTO_intetmp
		SetScale/P x PTO_ymin, PTO_yinc, "" PTO_intetmp
		if(root:PROCESS:edc2d==1)
		PTO_intetmp = XJZAREA2D(root:PROCESS:edc:$PTO_procstring,root:PROCESS:IntegrationStart, root:PROCESS:IntegrationEnd, x)
		endif
		if(root:PROCESS:mdc2d==1)
		PTO_intetmp = XJZAREA2D(root:PROCESS:mdc:$PTO_procstring,root:PROCESS:IntegrationStart, root:PROCESS:IntegrationEnd, x)
		endif
		if(root:PROCESS:edc2d==0&&root:PROCESS:mdc2d==0)
		PTO_intetmp = XJZAREA2D(root:PROCESS:$PTO_procstring,root:PROCESS:IntegrationStart, root:PROCESS:IntegrationEnd, x)
		endif
		PTO_intewave[PTO_ptowaveN,PTO_ptowaveN+PTO_ny-1]=PTO_intetmp[p-PTO_ptowaveN]
//         print ptowaveN, ptowaveN+ny
         break 
        endif
         PTO_ifinder+=1        
        while(PTO_ifinder<numpnts(root:OriginalData:ProcessedImage))
        
       endif 
       
     PTO_procnum+=1   
     while(PTO_procnum<ProcessedImagelimit)
  
  PTO_ptowaveN=numpnts(PTO_phiwave)
  Variable PTO_PhotonE=root:PROCESS:PhotonEnergy
  Variable PTO_WorkFunc=root:Process:WorkFunction
  Variable PTO_LC=root:PROCESS:LatticeConstant
  Variable PTO_K0=0.5118*PTO_LC/3.1416*Sqrt(PTO_PhotonE-PTO_WorkFunc)
  Make/O/N=(PTO_ptowaveN) PTO_Ky,PTO_Kx,PTO_RKy,PTO_RKx,PTO_RRKy,PTO_RRKx

PTO_thetawave-=root:PROCESS:ThetaOffset
PTO_phiwave-=root:PROCESS:PhiOffset
PTO_omegawave-=root:PROCESS:OmegaOffset
PTO_Ky=PTO_K0*sin(3.1416/180*PTO_thetawave)*cos(3.1416/180*PTO_phiwave) 
PTO_Kx=PTO_K0*sin(3.1416/180*PTO_phiwave)
PTO_RKy=sqrt(PTO_Ky*PTO_Ky+PTO_Kx*PTO_Kx)*sin((atan2(PTO_Ky,PTO_Kx))+PTO_omegawave*3.1416/180) 
PTO_RKx=sqrt(PTO_Ky*PTO_Ky+PTO_Kx*PTO_Kx)*cos((atan2(PTO_Ky,PTO_Kx))+PTO_omegawave*3.1416/180) 
PTO_RRKy=PTO_RKy 
PTO_RRKx=PTO_RKx 

Killwaves/Z PTO_Kx,PTO_Ky,PTO_RKx,PTO_RKy,PTO_intetmp,PTO_tmp
//print time()////debug1

Display;AppendXYZContour PTO_intewave vs {PTO_RRKx,PTO_RRky};DelayUpdate


DoWindow/C PTO_ContourPlot
String PTO_name="PTO_"+root:PROCESS:NewNamePrefix

FSmap(PTO_name,root:PROCESS:IntegrationEnd,root:PROCESS:IntegrationStart)
//print "****"
//print time()
//print "--------------"
//print time()
TextBox/C/N=text1/F=0/A=MC num2str(root:PROCESS:IntegrationStart*1000)+" ~ "+num2str(root:PROCESS:IntegrationEnd*1000)+" meV"

DoWindow/K PTO_ContourPlot
//print time()
//---------------------------Added by JXW------------------------------------
//Remeving the 2nd files
 curr=getdatafolder(1)
 setdatafolder root:PROCESS
 if(root:PROCESS:edc2d==1)
 setdatafolder root:PROCESS:edc
 endif
 if(root:PROCESS:mdc2d==1)
 setdatafolder root:PROCESS:mdc
 endif
 if((root:PROCESS:edc2d==1)||(root:PROCESS:mdc2d==1))
 string recoverfilelist=wavelist("!*_CT",";","DIMS:2"),backedfile,orifile
 variable rei=0,fileslimit,namelen
 fileslimit=itemsinlist(recoverfilelist)
 if(fileslimit>0)
 	do
 		backedfile=stringfromlist(rei,recoverfilelist)
 		killwaves/Z $backedfile
 		rei+=1
 	while(rei<fileslimit)
 endif
 endif
 //------------------------Added by JXW------------------------------------

//print time()///debug4
End

Function FSmap(PTO_name,PTO_Estart,PTO_Eend)



    String PTO_name
    Variable PTO_Estart,PTO_Eend
    NVAR PTO_KxPoint=root:PROCESS:KxPointNumber
	NVAR PTO_KyPoint=root:PROCESS:KyPointNumber
	NVAR PTO_NKxStart=root:PROCESS:KxStart
	NVAR PTO_NKxEnd=root:PROCESS:KxEnd
	NVAR PTO_NKyStart=root:PROCESS:KyStart
	NVAR PTO_NKyEnd=root:PROCESS:KyEnd
	SVAR PTO_SW=root:PROCESS:SWImageName
	NVAR PTO_Flag=root:PROCESS:ProcessedImageFlag
	NVAR SWInteStart=root:PROCESS:IntegrationStart
	NVAR SWInteEnd=root:PROCESS:IntegrationEnd
////	PTO_name=PTO_name+num2str(abs(PTO_Eend-PTO_Estart)*1000)+"meV"
	Make/O/N=(PTO_KxPoint,PTO_KyPoint) PTO_RRImageName
	Setscale/i x PTO_NKxStart,PTO_NKxEnd,"" PTO_RRImageName
	Setscale/i y PTO_NKyStart,PTO_NKyEnd,"" PTO_RRImageName
	//print "-------------start contourZ-------------"
	//print time()  //
	PTO_RRImageName=ContourZ("","PTO_intewave",0,x,y)
	//print time()//
	//print "-------------end contourZ-------------"
	//print "-------------start display-------------"
	//print time()
		 Variable IntegrationStartforName=SWInteStart*1000
	     Variable IntegrationEndforName=SWInteEnd*1000
	     String StartSign, EndSign
	     
	      If (IntegrationStartforName<0)
	      IntegrationStartforName*=-1
	      StartSign="n"
	      else
	      StartSign="p"
	      Endif

	     If (IntegrationEndforName<0)
	     IntegrationEndforName*=-1
	     EndSign="n"
	     else
	     EndSign="p"
	     Endif
	//------------------------------edit by JXW------------------------
    NVAR   smoothtimes=root:PROCESS:MDCSmoothingTimes
    NVAR 	edc2d=root:PROCESS:edc2d
    NVAR	mdc2d=root:PROCESS:mdc2d
    String PTOWindowName
    
    if((edc2d==0)&&(mdc2d==0))
     PTOWindowName=PTO_SW+"PTOKyKx"+"F"+num2str(PTO_Flag)+StartSign+num2str(abs(IntegrationStartforName))+EndSign+num2str(abs(IntegrationEndforName))+"meV"
   
    PTO_Name=PTO_SW+"PTOKyKx"+"F"+num2str(PTO_Flag)+"E"+StartSign+num2str(abs(IntegrationStartforName))+EndSign+num2str(abs(IntegrationEndforName))+"meV"	     
	endif
	
	if((edc2d==1)&&(mdc2d==0))
	 PTOWindowName="EDC"+num2str(smoothtimes)+PTO_SW+"PTOKyKx"+"F"+num2str(PTO_Flag)+StartSign+num2str(abs(IntegrationStartforName))+EndSign+num2str(abs(IntegrationEndforName))+"meV"
   
    PTO_Name="EDC"+num2str(smoothtimes)+PTO_SW+"PTOKyKx"+"F"+num2str(PTO_Flag)+"E"+StartSign+num2str(abs(IntegrationStartforName))+EndSign+num2str(abs(IntegrationEndforName))+"meV"	
	endif
	
	if((mdc2d==1)&&(edc2d==0))
	 PTOWindowName="MDC"+num2str(smoothtimes)+PTO_SW+"PTOKyKx"+"F"+num2str(PTO_Flag)+StartSign+num2str(abs(IntegrationStartforName))+EndSign+num2str(abs(IntegrationEndforName))+"meV"
   
    PTO_Name="MDC"+num2str(smoothtimes)+PTO_SW+"PTOKyKx"+"F"+num2str(PTO_Flag)+"E"+StartSign+num2str(abs(IntegrationStartforName))+EndSign+num2str(abs(IntegrationEndforName))+"meV"	
	endif
	//---------------------------edited by JXW----------------------------------------
	Duplicate/O PTO_RRImageName  $PTO_Name
	
	print "****"
	print time()
	DoWindow $PTOWindowName
	         if(V_flag==0)
	
	        Display;appendimage $PTO_name
	//print time()
	        ModifyImage $PTO_name ctab= {*,*,PlanetEarth,1}
	        ModifyGraph width={Plan,1,bottom,left}
	        ModifyGraph standoff=0
	        ModifyGraph fStyle=1
	        ModifyGraph fSize=12
	        SetAxis left PTO_NKyStart,PTO_NKyEnd;DelayUpdate
                SetAxis bottom PTO_NKxStart,PTO_NKxEnd
                Textbox/C/N=text0/A=RT/F=0 ImageLabel 
                ModifyGraph margin(left)=58,margin(bottom)=58
                Label left "\\Z16\\f01k\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	            Label bottom "\\Z16\\f01k\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	        ShowInfo
	        	         
//////	        Execute "XJZSecondBZN()"	         
	        	         
                DoWindow/C $PTOWindowName
   	        	            		
	        	else
	        	
	        	DoWindow/F $PTOWindowName
	        	
	        	Endif

	
////	ModifyImage $PTO_name ctab= {*,*,PlanetEarth,1}
////	PTO_name="FS"+PTO_name
////	DoWindow/C $PTO_name
    //print time()
    //print "-------------end display-------------"
end	

//proc FSmap2()
//    Variable KkxPoint=root:PROCESS:KxPointNumber
//	Variable KkyPoint=root:PROCESS:KyPointNumber
//	Variable NKkxStart=root:PROCESS:KxStart
	//Variable NKkxEnd=root:PROCESS:KxEnd
//	Variable NKkyStart=root:PROCESS:KyStart
//	Variable NKkyEnd=root:PROCESS:KyEnd
 
//    Setdatafolder root:FS
//    Duplicate/O RRKx, TripWave
//    Redimension/N=(-1,3) TripWave
    
//    TripWave[][0]= RRKx[p]
//    TripWave[][1]= RRKy[p]
//    TripWave[][2]= intewave[p]
    
//    Variable dx,dy
//    dx=(NKkxEnd-NKkxStart)/(KkxPoint-1)
//    dy=(NKkyEnd-NKkyStart)/(KkyPoint-1)
    
//    ImageInterpolate/S={(NKkxStart),(dx),(NKkxEnd),(NKkyStart),(dy),(NKkyEnd)} Voronoi, TripWave
    
//    Duplicate/O M_InterpolatedImage, Rimage
//	KillWaves/Z M_InterpolatedImage,TripWave
//	Display;appendimage Rimage
//	ModifyImage Rimage ctab= {*,*,PlanetEarth,1}
//	DoWindow/C FSmap2
	
//end
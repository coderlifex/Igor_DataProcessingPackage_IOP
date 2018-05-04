#pragma rtGlobals=1		// Use modern global access method.


Proc  XJZKyKx_Attach(ctrlName) : ButtonControl
	      String ctrlName

         String curr=GetDataFolder(1)	

	     Variable IntegrationStartforName=root:PROCESS:IntegrationStart*1000
	     Variable IntegrationEndforName=root:PROCESS:IntegrationEnd*1000
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
	    
	     
	     
          String FinalImage=root:PROCESS:SWImageName+"ThetaPhi"+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"E"+StartSign+num2str(IntegrationStartforName)+"_"+EndSign+num2str(IntegrationEndforName)+"meV"	     
	      String FImage=root:PROCESS:SWImageName+"_"+"ThetaPhi"+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"E"+StartSign+num2str(IntegrationStartforName)+"_"+EndSign+num2str(IntegrationEndforName)+"meV"	 

//        print "FImage=", FImage
	        
     
	     SetDataFolder root:OriginalData
	     
	     String OriginalImagefileList= WaveList("!*_CT",";","DIMS:2")
  	     Variable OriginalImagelimit=ItemsInList( OriginalImagefileList, ";")   
//       Print OriginalImageLimit

 	      SetDataFolder  root:PROCESS
          String ProcImage0, ProcImage
          String IntegrationWaveName

          String ProcessedImagefileList= WaveList("!*_CT",";","DIMS:2")
  	      Variable ProcessedImagelimit=ItemsInList( ProcessedImagefileList, ";")
//        Print ImagefileList,limit

              Variable iOriginalImage
              Variable iFindAngle
              Variable iFindImage           
              Variable ValTheta
              Variable ii=0
              Variable NTheta=abs(root:PROCESS:ThetaEnd-root:PROCESS:ThetaStart)+1
              Variable j
              
              
      	       ProcImage0=stringfromlist(0,ProcessedImagefilelist,";")   	       
//  	           print ProcImage0
        	       Duplicate/O root:PROCESS:$ProcImage0  root:IMG:NImage
        	       
       	       
               SetDataFolder root:IMG
               Variable/G x1_Integration, x2_Integration
	           x1_Integration=root:PROCESS:IntegrationStart
               x2_Integration=root:PROCESS:IntegrationEnd
             
               Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
               XJZImginfo(NImage)
               nx=DimSize(Nimage, 0); 	ny=DimSize(Nimage, 1)
               xmin=DimOffset(Nimage,0);  ymin=DimOffset(Nimage,1);
               xinc=round(DimDelta(Nimage,0) * 1E6) / 1E6	
	           yinc=round(DimDelta(Nimage,1)* 1E6) / 1E6
//             print nx, ny
             
                Make/O/N=(ny) ReferenceWave
                ii=0
      	        Do
        		   ReferenceWave[ii]=ymin+yinc*ii
        		   ii=ii+1
       	       While(ii<ny)
 
        
                Make/O/N=(ny,NTheta) SWImage
                Setscale/I y root:PROCESS:ThetaStart, root:PROCESS:ThetaEnd, SWImage
                Setscale/I x ymin, ymax, SWImage  
                
                SWImage=0
                
               
               
            String Image1DName
            Variable Phi_Shift           
            String Curren

         SetDataFolder root:IMG:ThetaPhiImage
         String ThetaPhiImg
         String ThetaPhiImageFileList= WaveList("!*_CT",";","DIMS:2")
//       ThetList=ProcessImageFileList
	     Variable ThetaPhiImagelimit=ItemsInList(ThetaPhiImageFileList, ";")
//	     print ProcessImageFileList, ProcessedImagelimit
	     Variable iTPImage=0
	     String TPImg
	     Do
	     TPImg=StringFromList(iTPImage,ThetaPhiImageFilelist,";")
	     KillWaves/Z  $TPImg
	     iTPImage+=1
	     While(iTPImage<ThetaPhiImagelimit)
	     Print "ThetaPhiImageFileList=", ThetaPhiImageFileList

         SetDataFolder  root:IMG          
            
               
            DoWindow $FImage
//        	    if(V_flag==0)
        	    
            Display;AppendImage  SWImage

               
               
               iOriginalImage=0
               Do

                 ValTheta=root:PROCESS:ThetaStart+iOriginalImage
                          	
                  root:IMG:NImage=0
                  
             	 iFindAngle=0            
            	       DO
              	   If (ValTheta==root:OriginalData:Theta_Angle[iFindAngle])
              	       ProcImage=root:OriginalData:ProcessedImage[iFindAngle]
              	
             		       iFindImage=0
             			   Do      	 
              			   If (cmpstr(ProcImage,StringFromList(iFindImage,ProcessedImagefilelist,";"))==0)
//              			   root:PhiAngle=root:Phi_Angle[iFindAngle]
                            Phi_Shift=root:OriginalData:Phi_Angle[iFindAngle] 
                            Image1DName="N"+ProcImage

                			   Duplicate/O root:PROCESS:$ProcImage  root:IMG:NImage
             			   EndIF
            			       iFindImage=iFindImage+1
              			   While(iFindImage<ProcessedImagelimit)       	            

//              	           Print "Image1DName=", Image1DName
//              	           Print "ValTheta=", ValTheta
              	           
              	    Else
              	    Endif
             	  iFindAngle=iFindAngle+1
                   WHILE(iFindAngle<OriginalImagelimit)
      
             SetDataFolder root:IMG
             Make/O/N=(ny) ytmp
		     SetScale/P x ymin, yinc, "" ytmp
		     ytmp = XJZAREA2D( Nimage, x1_Integration, x2_integration, x )
    
//          Display ytmp vs ReferenceWave

//	        SWImage[ ] [iOriginalImage]=ytmp[p]*root:OriginalData:IntensityScale
//	        SWImage[ ] [iOriginalImage]=ytmp[p]
           
            
            SetDataFolder root:IMG:ThetaPhiImage
            
            Make/O/N=(root:IMG:ny,1) $Image1DName
 	        $Image1DName[ ] [0]=root:IMG:ytmp[p]	
	
//          Setscale/I y root:PROCESS:ThetaStart, root:PROCESS:ThetaEnd, $Image1DName
            Setscale/I y ValTheta,ValTheta+1, $Image1DName
            Setscale/I x root:IMG:ymin-Phi_shift, root:IMG:ymax-Phi_Shift, $Image1DName
            

	        AppendImage $Image1DName
	        ModifyImage $Image1DName ctab= {*,*,PlanetEarth,1}
	        ModifyGraph manTick(left)={0,5,0,0},manMinor(left)={4,0}
	        
	
	    iOriginalImage=iOriginalImage+1
	    While(iOriginalImage<NTheta)
	    
	    
	    


Variable PhotonE=root:PROCESS:PhotonEnergy
Variable WorkFunc=root:Process:WorkFunction
Variable LC=root:PROCESS:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
Variable RAngle=root:PROCESS:RotationAngle



    Make/O/N=(ny*NTheta) ThetaWave,PhiWave,TiltWave,OmegaWave,IntensityWave
    Make/O/N=(ny*NTheta) Ky, Kx, RKy, RKx,RRKy, RRKx
 
	Variable iThetaWave,iPhiWave,iFindPhiAngle, jFindImage
	Variable VarPhiAngle, VarOmegaAngle
	iThetaWave=0
	Variable ThetaValue
	Do
	        ThetaValue=iThetaWave+root:PROCESS:ThetaStart
	        		
	        		 iFindPhiAngle=0
	        		 Do
	        		 if (ThetaValue==root:OriginalData:Theta_Angle[iFindPhiAngle])
	        		         
	        		                		         
	        		           jFindImage=0
             			   Do      	 
              			   if (cmpstr(root:OriginalData:ProcessedImage[iFindPhiAngle],StringFromList(jFindImage,ProcessedImagefilelist,";"))==0)
              			   
              			   VarPhiAngle=root:OriginalData:Phi_Angle[iFindPhiAngle]
	        		 	       VarOmegaAngle=root:OriginalData:Omega_Angle[iFindPhiAngle]
              			   
              			   Endif
            			       jFindImage=jFindImage+1
              			   While(jFindImage<ProcessedImagelimit)
	        		         
	        		         
	       		 Else
	        		 Endif
        		
	        		 iFindPhiAngle=iFindPhiAngle+1
	        		 While(iFindPhiAngle<OriginalImageLimit)
	        		
	        
		iPhiWave=0
		Do
		  ThetaWave[iThetaWave*ny+iPhiWave]=ThetaValue	-root:PROCESS:ThetaOffset	 
 	 	  PhiWave[iThetaWave*ny+iPhiWave]= (root:PROCESS:CropStart+root:PROCESS:CropEnd)/2-ReferenceWave[iPhiWave]
 	 	  TiltWave[iThetaWave*ny+iPhiWave]=VarPhiAngle-root:PROCESS:PhiOffset 
         OmegaWave[iThetaWave*ny+iPhiWave]=VarOmegaAngle-root:PROCESS:OmegaOffset    
		 IntensityWave[iThetaWave*ny+iPhiWave]=SWImage[iPhiWave][iThetaWave]  
		 
		  Ky[iThetaWave*ny+iPhiWave]=K0*sin(3.1416/180*ThetaWave[iPhiWave])*cos(3.1416/180*(PhiWave[iPhiWave]+TiltWave[iPhiWave])) 
         Kx[iThetaWave*ny+iPhiWave]=K0*sin(3.1416/180*(PhiWave[iPhiWave]+TiltWave[iPhiWave]))
         RKy[iThetaWave*ny+iPhiWave]=sqrt(Ky[iThetaWave*ny+iPhiWave]^2+Kx[iThetaWave*ny+iPhiWave]^2)*sin((atan2(Ky[iThetaWave*ny+iPhiWave],Kx[iThetaWave*ny+iPhiWave]))+OmegaWave[iPhiWave]*3.1416/180) 
         RKx[iThetaWave*ny+iPhiWave]=sqrt(Ky[iThetaWave*ny+iPhiWave]^2+Kx[iThetaWave*ny+iPhiWave]^2)*cos((atan2(Ky[iThetaWave*ny+iPhiWave],Kx[iThetaWave*ny+iPhiWave]))+OmegaWave[iPhiWave]*3.1416/180) 
         RRKy[iThetaWave*ny+iPhiWave]=RKy[iThetaWave*ny+iPhiWave]+root:PROCESS:KyOffset 
         RRKx[iThetaWave*ny+iPhiWave]=RKx[iThetaWave*ny+iPhiWave]+root:PROCESS:KxOffset 

	    
		 iPhiWave+=1
         While(iPhiWave<ny)
       
       iThetaWave=iThetaWave+1
       
      While(iThetaWave<NTheta)
 	       
      Display;AppendXYZContour IntensityWave vs {RRKx,RRky}         
        
//   Edit ThetaWave,PhiWave, TiltWave, IntensityWave



//NThetaWave=ThetaWave-root:PROCESS:ThetaOffset
//NPhiWave=PhiWave
//NTiltWave=TiltWave-root:PROCESS:PhiOffset 
//NOmegaWave=OmegaWave-root:PROCESS:OmegaOffset 

//Edit NThetaWave, NPhiWave 
////Ky=K0*sin(3.1416/180*NThetaWave)  
////Kx=K0*sin(3.1416/180*NPhiWave)*cos(3.1416/180*NThetaWave) 
//found the formula is not right on 01/10/2003 and corrected
//Ky=K0*sin(3.1416/180*NThetaWave)*cos(3.1416/180*NPhiWave) 
//Kx=K0*sin(3.1416/180*NPhiWave)

//on 01/13/2003 more complete formula to separate detector angle and tilt angle
//NThetaWave--Analyzer rotation angle or cryostat rotation angle
//NPhiWave-- Detector angle
//NTiltWave-- sample tilt angle
//Edit NThetaWave,NPhiWave, NTiltWave, IntensityWave


//Ky=K0*sin(3.1416/180*NThetaWave)*cos(3.1416/180*NPhiWave) 
////Kx=K0*sin(3.1416/180*NPhiWave)
//Kx=K0*(sin(3.1416/180*NPhiWave)*cos(3.1416/180*NTiltWave)+sin(3.1416/180*NTiltWave)*cos(3.1416/180*NPhiWave)*cos(3.1416/180*NThetaWave))


//on 02/09/2007 Check the formula again and feel it should be the old ones
//NThetaWave--Analyzer rotation angle or cryostat rotation angle
//NPhiWave-- Detector angle
//NTiltWave-- sample tilt angle

SetDataFolder curr

End









Function     XJZKyKx(ctrlName) : ButtonControl
	String ctrlName

        
        
        String curr=GetDataFolder(1)
        NVAR InteEnergyStartLabel=root:PROCESS:IntegrationStart
        NVAR InteEnergyEndLabel=root:PROCESS:IntegrationEnd
        String ImageLabel=num2str(InteEnergyStartLabel*1000)+"~"+num2str(InteEnergyEndLabel*1000) + "meV"

//-----------------------Added by JXW-------------------------
 //Perform EDC2d or MDC2d FS Mapping
   setdatafolder root:PROCESS
   //EDC2d Mapping
  nvar edc2d=root:PROCESS:edc2d
  nvar mdc2d=root:PROCESS:mdc2d
  string backprocessfilelist,oriback_procstring,desback_procstring,edc_procstring,mdc_procstring
  variable ii=0,imagelistlimit
  if(edc2d==1)	//check if edc2d switch is slected
   		
   //back up the original wavelist
   backprocessfilelist=WaveList("!*_CT",";","DIMS:2")
 	ii=0
   imagelistlimit=itemsinlist(backprocessfilelist)
   do
   		oriback_procstring=stringfromlist(ii,backprocessfilelist)
   		desback_procstring=stringfromlist(ii,backprocessfilelist)+"_bk"
   		duplicate/O $oriback_procstring $desback_procstring
   		ii+=1
   	while(ii<imagelistlimit)
   	// EDC2d of original processed file
   	ii=0
   	do
   		edc_procstring=stringfromlist(ii,backprocessfilelist)
   		MDC2dFS(edc_procstring)
   		ii+=1
   	while(ii<imagelistlimit)
   	killwaves/Z TempSecDImage
   	endif
  
   //MDC2d Mapping	
   	if(mdc2d==1)	//check if edc2d switch is slected
   		
   //back up the original wavelist
   backprocessfilelist=WaveList("!*_CT",";","DIMS:2")
   ii=0
   imagelistlimit=itemsinlist(backprocessfilelist)
   do
   		oriback_procstring=stringfromlist(ii,backprocessfilelist)
   		desback_procstring=stringfromlist(ii,backprocessfilelist)+"_bk"
   		duplicate/O $oriback_procstring $desback_procstring
   		ii+=1
   	while(ii<imagelistlimit)
   	// EDC2d of original processed file
   	ii=0
   	do
   		mdc_procstring=stringfromlist(ii,backprocessfilelist)
   		EDC2dFS(mdc_procstring)
   		ii+=1
   	while(ii<imagelistlimit)
   	killwaves/Z TempSecDImage
   	endif
   	
//---------------------------------Added by JXW--------------------------------------------   
	    DoWindow ContourPlot
        	    if(V_flag==0)
        	    
            Execute "PXJZKyKxContour()"
            SetDataFolder root:IMG
            Display;AppendXYZContour IntensityWave vs {RRKx,RRky} 
	    DoWindow/C ContourPlot
 	         
            else
        	    DoWindow/K ContourPlot
            Execute "PXJZKyKxContour()"
            SetDataFolder root:IMG
            Display;AppendXYZContour IntensityWave vs {RRKx,RRky} 
	    DoWindow/C ContourPlot
  	    Endif  

        //  Edit root:IMG:RRKx, root:IMG:RRKy,  root:IMG:IntensityWave

        SetDataFolder root:IMG
      
	NVAR Imageflag=root:PROCESS:ProcessedImageFlag
	SVAR ImageName=root:PROCESS:SWImageName
	
	//Display;AppendXYZContour IntensityWave vs {RRKx,RRky}

	NVAR KxPoint=root:PROCESS:KxPointNumber
	NVAR KyPoint=root:PROCESS:KyPointNumber
	NVAR NKxStart=root:PROCESS:KxStart
	NVAR NKxEnd=root:PROCESS:KxEnd
	NVAR NKyStart=root:PROCESS:KyStart
	NVAR NKyEnd=root:PROCESS:KyEnd
	NVAR ImageFlag=root:PROCESS:ProcessedImageFlag
	SVAR SWImageName=root:PROCESS:SWImageName
	NVAR IntegrationStartforName=root:PROCESS:IntegrationStart
	NVAR IntegrationEndforName=root:PROCESS:IntegrationEnd	
	NVAR KxS=root:PROCESS:KxStart
	NVAR KxE=root:PROCESS:KxEnd
	NVAR KyS=root:PROCESS:KyStart
	NVAR KyE=root:PROCESS:KyEnd	
	
	String SignStart
	String SignEnd
	Variable NIntegrationStartforName=IntegrationStartforName*1000
	If (NIntegrationStartforName<0)
	NIntegrationStartforName*=-1
	SignStart="n"
	else 
	SignStart="p"
	Endif
	
	
	Variable NIntegrationEndforName=IntegrationEndforName*1000
	If (NIntegrationEndforName<0)
	SignEnd="n"
	NIntegrationEndforName*=-1	
	else 
	SignEnd="p"
	Endif
	
//--------------------------edited by JXW------------------------------
	NVAR   smoothtimes=root:PROCESS:MDCSmoothingTimes
    NVAR 	edc2d=root:PROCESS:edc2d
    NVAR	mdc2d=root:PROCESS:mdc2d	
	String/G     RImageName
	String       WindowName
	
	if((edc2d==0)&&(mdc2d==0))
	RImageName=ImageName+"F"+num2str(ImageFlag)+"E"+SignStart+num2str(NIntegrationStartforName)+"_"+SignEnd+num2str(NIntegrationEndforName)+"meV"
	WindowName=ImageName+"KyKx"+"F"+num2str(ImageFlag)+"E"+SignStart+num2str(NIntegrationStartforName)+"_"+SignEnd+num2str(NIntegrationEndforName)+"meV"
	endif
	
	if((edc2d==1)&&(mdc2d==0))
	RImageName="EDC"+num2str(smoothtimes)+ImageName+"F"+num2str(ImageFlag)+"E"+SignStart+num2str(NIntegrationStartforName)+"_"+SignEnd+num2str(NIntegrationEndforName)+"meV"
	WindowName="EDC"+num2str(smoothtimes)+ImageName+"KyKx"+"F"+num2str(ImageFlag)+"E"+SignStart+num2str(NIntegrationStartforName)+"_"+SignEnd+num2str(NIntegrationEndforName)+"meV"
	endif
	
	if((mdc2d==1)&&(edc2d==0))
	RImageName="MDC"+num2str(smoothtimes)+ImageName+"F"+num2str(ImageFlag)+"E"+SignStart+num2str(NIntegrationStartforName)+"_"+SignEnd+num2str(NIntegrationEndforName)+"meV"
	WindowName="MDC"+num2str(smoothtimes)+ImageName+"KyKx"+"F"+num2str(ImageFlag)+"E"+SignStart+num2str(NIntegrationStartforName)+"_"+SignEnd+num2str(NIntegrationEndforName)+"meV"
	endif
	
//------------------------edited by JXW---------------------------------
//	String       Windowname="Any"

	       Make/O/N=(KxPoint,KyPoint) RRImageName
	       Setscale/i x NKxStart,NKxEnd,"" RRImageName
	       Setscale/i y NKyStart,NKyEnd,"" RRImageName
	       RRImageName=contourz("","IntensityWave",0,x,y)
               Duplicate/O RRImageName  $RImageName
               
                 DoWindow $WindowName
	         if(V_flag==0)
	
	        Display;appendimage $RImageName
	        ModifyImage $RImageName ctab= {*,*,PlanetEarth,1}
	        ModifyGraph width={Plan,1,bottom,left}
	        ModifyGraph standoff=0
	        ModifyGraph fStyle=1
	        ModifyGraph fSize=12
	        SetAxis left KyS,KyE ;DelayUpdate
                SetAxis bottom KxS,KxE
                Textbox/C/N=text0/A=RT/F=0 ImageLabel 
                ModifyGraph margin(left)=58,margin(bottom)=58
                Label left "\\Z16\\f01k\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	        Label bottom "\\Z16\\f01k\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	        ShowInfo
	        	         
                DoWindow/C $WindowName
   	        	            		
	        	else
	        	
	        	DoWindow/F $WindowName
	        	
	        	Endif
	        	
	        DoWindow/K ContourPlot
	        
	        String TraceNamex=ImageName+"F"+num2str(ImageFlag)+"RRKx"
            String TraceNamey=ImageName+"F"+num2str(ImageFlag)+"RRKy"
	        Duplicate/O RRKx  $TraceNamex
            Duplicate/O RRKy  $TraceNamey
        
//---------------------------Added by JXW------------------------------------
//Recovering the original processed files
 setdatafolder root:PROCESS
 curr=getdatafolder(1)
 setdatafolder root:PROCESS
 string recoverfilelist=wavelist("*_bk",";","DIMS:2"),backedfile,orifile
 variable rei=0,fileslimit,namelen
 fileslimit=itemsinlist(recoverfilelist)
 if(fileslimit>0)
 	do
 		backedfile=stringfromlist(rei,recoverfilelist)
 		namelen=strlen(backedfile)
 		orifile=backedfile[0,namelen-4]
 		duplicate/O $backedfile $orifile
 		killwaves/Z $backedfile
 		rei+=1
 	while(rei<fileslimit)
 endif
 //------------------------Added by JXW------------------------------------        
        
        
        
	        	
SetDataFolder curr

End

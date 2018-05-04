#pragma rtGlobals=1		// Use modern global access method.



Proc     XJZKyKxContour(ctrlName) : ButtonControl
	     String ctrlName
	     
	     String curr=GetDataFolder(1)
	     
	      DoWindow ContourPlot
          
          If(V_flag==0)
        	    
          Execute "PXJZKyKxContour()"
          SetDataFolder root:IMG
          Display;AppendXYZContour IntensityWave vs {RRKx,RRky}       	    
 	     
 	      DoWindow/C ContourPlot
  	         
          Else
            DoWindow/K ContourPlot
            Execute "PXJZKyKxContour()"
            SetDataFolder root:IMG
            Display;AppendXYZContour IntensityWave vs {RRKx,RRky}       	    
 	    
 	     DoWindow/C ContourPlot
 	     
  	     Endif  
  	    
  	    SetDataFolder curr
              
	        
End	    
	     
     
	     
Proc    PXJZKyKxContour()

         String curr=GetDataFolder(1)	

	     SetDataFolder root:OriginalData
	     
	     String OriginalImagefileList= WaveList("!*_CT",";","DIMS:2")
  	     Variable OriginalImagelimit=ItemsInList( OriginalImagefileList, ";")   
//       Print OriginalImageLimit

 	     SetDataFolder  root:PROCESS


        
         String ProcImage0, ProcImage
         String IntegrationWaveName

          String ProcessedImagefileList= WaveList("!*_bk",";","DIMS:2")
  	      Variable ProcessedImagelimit=ItemsInList( ProcessedImagefileList, ";")
//        Print ImagefileList,limit

              Variable iOriginalImage
              Variable iFindAngle
              Variable iFindImage           
              Variable ValTheta
              //Variable ii=0
              variable ii=0
              Variable NTheta=abs(root:PROCESS:ThetaEnd-root:PROCESS:ThetaStart)+1
              Variable j
              

      	       ProcImage0=stringfromlist(0,ProcessedImagefilelist,";")   	       

        	       Duplicate/O $ProcImage0  root:IMG:NImage
        	       
       	       
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
                SWImage=0
               
            iOriginalImage=0
            DO

                 ValTheta=root:PROCESS:ThetaStart+iOriginalImage
                          	
                  root:IMG:NImage=0
                  
             	 iFindAngle=0            
            	 Do
              	 If (ValTheta==root:OriginalData:Theta_Angle[iFindAngle])
              	     ProcImage=root:OriginalData:ProcessedImage[iFindAngle]
              	
             		       iFindImage=0
             			   Do      	 
              			   IF (cmpstr(ProcImage,StringFromList(iFindImage,ProcessedImagefilelist,";"))==0)
//              			   root:PhiAngle=root:Phi_Angle[iFindAngle] 
                			   Duplicate/O root:PROCESS:$ProcImage  root:IMG:NImage
                		       EndIF
            			       iFindImage=iFindImage+1
              			   While(iFindImage<ProcessedImagelimit)
              	        
              	 else
              	 Endif
             	 iFindAngle=iFindAngle+1
                While(iFindAngle<OriginalImagelimit)
      
                 SetDataFolder root:IMG
                 Make/O/N=(ny) ytmp
		         SetScale/P x ymin, yinc, "" ytmp
		         ytmp = XJZAREA2D(Nimage, x1_Integration, x2_integration, x)
    
//               Display ytmp vs ReferenceWave

	           SWImage[ ] [iOriginalImage]=ytmp[p]
		
	         iOriginalImage=iOriginalImage+1
	         WHILE(iOriginalImage<NTheta)
	        
	        Setscale/I y root:PROCESS:ThetaStart, root:PROCESS:ThetaEnd, SWImage
            Setscale/I x ymin, ymax, SWImage
	         
	         
//       Edit ProcImageTheta_Wave, ProcImagePhi_Wave, ProcImagePhiCorrection_Wave	
//       Edit SWImage 






    Make/O/N=(ny*NTheta) ThetaWave,PhiWave,TiltWave,OmegaWave,NThetaWave, NPhiWave,NTiltWave,NOmegaWave,IntensityWave
    Make/O/N=(ny*NTheta) Ky, Kx, RKy, RKx,RRKy, RRKx
 
	Variable iThetaWave,iPhiWave,iFindPhiAngle, jFindImage
	Variable VarPhiAngle, VarPhiAngleCorrection,VarOmegaAngle,VarOmegaAngleCorrection,VarIntensityScale
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
	        		 	       VarPhiAngleCorrection=root:OriginalData:Phi_Correction[iFindPhiAngle]
	        		 	       VarOmegaAngle=root:OriginalData:Omega_Angle[iFindPhiAngle]
	        		 	       VarPhiAngleCorrection=root:OriginalData:Phi_Correction[iFindPhiAngle]
	        		 	       VarIntensityScale=root:OriginalData:IntensityScale[iFindPhiAngle]
              			   
              			   Endif
            			       jFindImage=jFindImage+1
              			   While(jFindImage<ProcessedImagelimit)
	        		         
	        		         
	       		 Else
	        		 Endif
        		
	        		 iFindPhiAngle=iFindPhiAngle+1
	        		 While(iFindPhiAngle<OriginalImageLimit)
	        		
	        
		  iPhiWave=0
		  Do
		  ThetaWave[iThetaWave*ny+iPhiWave]=ThetaValue		 
// 	 	  PhiWave[iThetaWave*ny+iPhiWave]= (root:PROCESS:CropStart+root:PROCESS:CropEnd)/2-ReferenceWave[iPhiWave]
//        Changed on 2007/06/28, If the Start and End are different, this would cause error
//        Change into the detectorcenterangle 	 	  
  	 	  PhiWave[iThetaWave*ny+iPhiWave]= root:PROCESS:DetectorCenterAngle-ReferenceWave[iPhiWave]	 	  
 	 	  
 	 	  
 	 	  TiltWave[iThetaWave*ny+iPhiWave]=VarPhiAngle-VarPhiAngleCorrection
          OmegaWave[iThetaWave*ny+iPhiWave]=VarOmegaAngle-VarOmegaAngleCorrection
		  IntensityWave[iThetaWave*ny+iPhiWave]=SWImage[iPhiWave][iThetaWave] 
//		  IntensityWave[iThetaWave*ny+iPhiWave]=VarIntensityScale*SWImage[iPhiWave][iThetaWave] 		   
		 		    
	      iPhiWave=iPhiWave+1
          While(iPhiWave<ny)
         
         
       
    iThetaWave=iThetaWave+1
    While(iThetaWave<NTheta)
          
        
//   Edit ThetaWave,PhiWave, TiltWave, IntensityWave

Variable PhotonE=root:PROCESS:PhotonEnergy
Variable WorkFunc=root:Process:WorkFunction
Variable LC=root:PROCESS:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
Variable RAngle=root:PROCESS:RotationAngle-root:PROCESS:OmegaOffset

NThetaWave=ThetaWave-root:PROCESS:ThetaOffset
NPhiWave=PhiWave
NTiltWave=TiltWave-root:PROCESS:PhiOffset 
NOmegaWave=OmegaWave-root:PROCESS:OmegaOffset 

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
////Ky=K0*sin(3.1416/180*NThetaWave)*cos(3.1416/180*(NPhiWave+NTiltWave)) 
////Kx=K0*sin(3.1416/180*(NPhiWave+NTiltWave))
////RKy=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+RAngle*3.1416/180) 
////RKx=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+RAngle*3.1416/180) 
////RRKy=RKy+root:PROCESS:KyOffset 
////RRKx=RKx+root:PROCESS:KxOffset 


//2007/04/06 Feel that the IOP ARPES geometry should be different from Berkeley HERS Geometry.
//Decide to make two different parts for each
//Do not find anything wrong with the formula

//For ALS HERS
//NThetaWave--Analyzer rotation angle or cryostat rotation angle
//NPhiWave-- Detector angle
//NTiltWave-- sample tilt angle
////Ky=K0*sin(3.1416/180*NThetaWave)*cos(3.1416/180*(NPhiWave+NTiltWave)) 
////Kx=K0*sin(3.1416/180*(NPhiWave+NTiltWave))
////RKy=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+RAngle*3.1416/180) 
////RKx=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+RAngle*3.1416/180) 
////RRKy=RKy+root:PROCESS:KyOffset 
////RRKx=RKx+root:PROCESS:KxOffset 


//For IOP ARPES
//NThetaWave--Sample tilt angle 
//NPhiWave-- Detector angle
//NTiltWave-- Croystat rotation angle relative to analyzer axis
Ky=K0*sin(3.1416/180*NThetaWave)*cos(3.1416/180*(NPhiWave+NTiltWave)) 
Kx=K0*sin(3.1416/180*(NPhiWave+NTiltWave))
RKy=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+RAngle*3.1416/180) 
RKx=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+RAngle*3.1416/180) 
RRKy=RKy+root:PROCESS:KyOffset 
RRKx=RKx+root:PROCESS:KxOffset 





SetDataFolder curr

End





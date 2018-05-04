#pragma rtGlobals=1		// Use modern global access method.



Function  XJZAREA2D( img, x1, x2, y0 )
//====================
	wave img
	variable x1, x2, y0
	
	variable nx=DimSize( img, 0)
	make/O/n=(nx) tmp
	CopyScales img, tmp
	tmp=img(x)( y0)
	
	return area( tmp, x1, x2)
End








Proc     XJZThetaPhi_Attachment(ctrlName) : ButtonControl
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
        	    if(V_flag==0)
        	    
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
//      Edit ProcImageTheta_Wave, ProcImagePhi_Wave, ProcImagePhiCorrection_Wave
            
                       	           
            DoWindow/C $FImage
 	         
             Else
             
             DoWindow/K $FImage            
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
    
//         Display ytmp vs ReferenceWave

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
//      Edit ProcImageTheta_Wave, ProcImagePhi_Wave, ProcImagePhiCorrection_Wave
            
                       	           
            DoWindow/C $FImage
             Endif                        
               
                        

	

SetDataFolder Curr


End






	     
	
	
Proc     XJZThetaPhi(ctrlName) : ButtonControl
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

            DoWindow $FImage
        	    if(V_flag==0)
        	    
	         PXJZThetaPhi()
	         Duplicate/O root:IMG:SWImage  root:IMG:$FinalImage
           
	         Display;AppendImage  root:IMG:$FinalImage
	         ModifyImage $FinalImage ctab= {*,*,PlanetEarth,1}
	         ModifyGraph manTick(left)={0,5,0,0},manMinor(left)={4,0}

 	         DoWindow/C $FImage
 	         
              else
             PXJZThetaPhi()
	         Duplicate/O root:IMG:SWImage  root:IMG:$FinalImage
	         DoWindow/F $FImage
                Endif
              
              SetDataFolder curr
 
END	
	     
	     
Proc    PXJZThetaPhi()	

           String Current=GetDataFolder(1)     
     
	     SetDataFolder root:OriginalData
	     
	     String OriginalImagefileList= WaveList("!*_CT",";","DIMS:2")
  	     Variable OriginalImagelimit=ItemsInList( OriginalImagefileList, ";")   
//            Print OriginalImageLimit

 	       SetDataFolder  root:PROCESS
               String ProcImage0, ProcImage
               String IntegrationWaveName

            String ProcessedImagefileList= WaveList("!*_CT",";","DIMS:2")
  	      Variable ProcessedImagelimit=ItemsInList( ProcessedImagefileList, ";")
//          Print ImagefileList,limit

              Variable iOriginalImage
              Variable iFindAngle
              Variable iFindImage           
              Variable ValTheta
              Variable ii=0
              Variable NTheta=abs(root:PROCESS:ThetaEnd-root:PROCESS:ThetaStart)+1
              Variable j
              
              
//     	ProcImage0=root:OriginalData:ProcessedImage[0]
      	       ProcImage0=stringfromlist(0,ProcessedImagefilelist,";")   	       
//    	       print ProcImage0
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
               Do

                 ValTheta=root:PROCESS:ThetaStart+iOriginalImage
                          	
                  root:IMG:NImage=0
                  
             	 iFindAngle=0            
            	       DO
              	 if (ValTheta==root:OriginalData:Theta_Angle[iFindAngle])
              	        ProcImage=root:OriginalData:ProcessedImage[iFindAngle]
              	
             		       iFindImage=0
             			   Do      	 
              			   if (cmpstr(ProcImage,StringFromList(iFindImage,ProcessedImagefilelist,";"))==0)
//              			   root:PhiAngle=root:Phi_Angle[iFindAngle] 
                			   Duplicate/O root:PROCESS:$ProcImage  root:IMG:NImage
             			   EndIF
            			   iFindImage=iFindImage+1
              			   While(iFindImage<ProcessedImagelimit)
              	        
              	 else
              	 Endif
             	 iFindAngle=iFindAngle+1
              WHILE(iFindAngle<OriginalImagelimit)
      
             SetDataFolder root:IMG
             Make/O/N=(ny) ytmp
		     SetScale/P x ymin, yinc, "" ytmp
		      ytmp = XJZAREA2D( Nimage, x1_Integration, x2_integration, x )
    
 //         Display ytmp vs ReferenceWave

//	        SWImage[ ] [iOriginalImage]=ytmp[p]*root:OriginalData:IntensityScale
	        SWImage[ ] [iOriginalImage]=ytmp[p]
	
	
	 iOriginalImage=iOriginalImage+1
	 While(iOriginalImage<NTheta)
	 
	 
//   Edit ProcImageTheta_Wave, ProcImagePhi_Wave, ProcImagePhiCorrection_Wave
//   Edit SWImage	


Setscale/I y root:PROCESS:ThetaStart, root:PROCESS:ThetaEnd, SWImage
Setscale/I x ymin, ymax, SWImage

Variable IntegrationStartforName=-root:PROCESS:IntegrationStart*1000


String FinalImage="ThetaPhi"+"F"+num2str(root:PROCESS:ProcessedImageFlag)+root:PROCESS:SWImageName+num2str(IntegrationStartforName)+"meV"
Duplicate/O SWImage  root:IMG:$FinalImage

SetDataFolder Current

End




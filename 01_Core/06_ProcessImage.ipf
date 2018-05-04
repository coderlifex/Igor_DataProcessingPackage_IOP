#pragma rtGlobals=1		// Use modern global access method.



Proc  XJZProcess(ctrlName) : ButtonControl
	 String ctrlName
	 pauseupdate;silent 1
     root:OriginalData:ProcessedImage="N/A"
     //variable getallEK=root:Process:GetAllEK1
     pauseupdate;silent 1
 	 XJZNewImg()
 	 ///ZWT
 	 setdatafolder root:PROCESS
 	 if(GetallEKV==0)
 	 	EKPiOvera=WaveList("*",";","DIMS:2")
 		EK1Overa=WaveList("*",";","DIMS:2")
 		DispersionFileList=WaveList("*",";","DIMS:2")
 	 endif
 	 ALLOriginalImage=WaveList("*",";","DIMS:2")
 	 ///ZWT
         
End


Proc KillProcessedImage()
		String curr1=GetDataFolder(1)
		
         SetDataFolder root:Process
         String ProcessedImg
         String ProcessImageFileList= WaveList("!*_CT",";","DIMS:2")
         ProcessedFileList=ProcessImageFileList
	     variable ProcessedImagelimit=ItemsInList( ProcessImageFileList, ";")
//	     print ProcessImageFileList, ProcessedImagelimit
	     Variable iProcessedImage=0
	     Do
	     ProcessedImg=StringFromList(iProcessedImage,ProcessImageFilelist,";")
	     KillWaves/Z  $ProcessedImg
	     iProcessedImage=iProcessedImage+1
	     While(iProcessedImage<ProcessedImagelimit)
	     
         SetDataFolder curr1
End





Proc XJZNewImg() 
pauseupdate;silent 1
KillProcessedImage()


pauseupdate;silent 1
String Curr=GetDataFolder(1)

//	PickImage( )

//	string img=root:IMG:imgfldr+root:IMG:imgnam
	string img
          SetDataFolder root:OriginalData
          //String ImagefileList= WaveList("!R*",";","DIMS:2")
	      Variable limit=Dimsize(ProcessFlag,0)
          Variable i=0
    	      Do        
   	          //img=StringFromList(i,Imagefilelist,";")
   	          img=OriginalImage[i]
    	          Duplicate/o $img  root:IMG:Image
		
              root:PROCESS:ThetaAngle= root:OriginalData:Theta_Angle[i]
              root:PROCESS:PhiAngle=root:OriginalData:Phi_Angle[i]
              root:PROCESS:OmegaAngle=root:OriginalData:Omega_Angle[i]             
             
              If (root:OriginalData:ProcessFlag[i]==root:PROCESS:ProcessedImageFlag)
              root:PROCESS:TempFermiCorrection2D=root:OriginalData:Ef_Correction[i]
              root:PROCESS:TempTemperature2D=root:OriginalData:Temperature2D[i]
//            print "root:PROCESS:TempFermiCorrection2D",root:PROCESS:TempFermiCorrection2D
              CropNorYZeroFermi()
              ProcessedImage[i]=root:IMG:NName
              endif
              
    	      i=i+1
   	While (i<limit)
   	        
	SetDataFolder Curr
	End



Proc CropNorYZeroFermi()
 
   	PauseUpdate; Silent 1
        String Curr=GetDataFolder(1)
        
        SetDataFolder root:
	
//     Crop Image

	  SetDataFolder root:IMG

	       Variable/G x1_crop, x2_crop, y1_crop, y2_crop
	       Variable/G root:IMG:x1_crop=root:PROCESS:energystart, root:IMG:x2_crop=root:PROCESS:energyend
	       Variable/G root:IMG:y1_crop=root:PROCESS:cropstart, root:IMG:y2_crop=root:PROCESS:cropend
 
      Duplicate/O/R=(x1_crop,x2_crop)(y1_crop,y2_crop) Image, NImage
        

        

//    Normalize Y

		Variable/G x1_norm, x2_norm
		x1_norm=root:PROCESS:norystart
		x2_norm=root:PROCESS:noryend
		
		Variable NormMode=root:PROCESS:NorYFlag

        XJZImginfo(NImage)
		make/o/n=(ny) ytmp
		SetScale/P x ymin, yinc, "" ytmp
		ytmp = XJZAREA2D( NImage, x1_norm, x2_norm, x )
		
		IF (NormMode==0)
////		NImage /= ytmp[0]
		NImage /= Mean(ytmp)	                       ////modified on 2007/10/22	to reduce edge effect		
		Else	
		NImage /= ytmp[q]
		EndIF
	
		
//     Set Fermi Level to zero

                    
		SetScale/P x xmin-root:PROCESS:zerofermi-root:PROCESS:FermiCorrection-root:PROCESS:TempFermiCorrection2D, xinc,"" NImage
		

//     Divide the Image with Fermi Function
	    
	   Variable FermiNorm=root:PROCESS:FermiFuncRemoveMode
	   Variable FermiTemp=root:PROCESS:TempTemperature2D
	   
	    XJZImginfo(NImage)
	    Duplicate/O NImage, FermiF
		Make/O/N=(nx,ny) FermiF
		SetScale/P x xmin, xinc, "" FermiF
		SetScale/P y ymin, yinc, "" FermiF
////  	FermiF = 1/(exp(1200*x/FermiTemp)+1)
	    FermiF = 1/(exp(11605.4*x/FermiTemp)+1)+0.0001              //2007/03/26 corrected the formula  
	    
	   
	   If (FermiNorm==1)
	   
       Make/O/N=(401) GForEDCConvolution
       Setscale/I x -0.2, 0.2, GForEDCConvolution
       Variable CEResolution=root:PROCESS:ConvolutionEResolution
       
            If (CEResolution==0)
            CEResolution=0.001
            Endif      
       
       
       Variable ERforC=CEResolution/1000/2/sqrt(ln(2))
       GForEDCConvolution=exp(-(x/ERforC)^2)
	 
	   Convolve/A GForEDCConvolution,FermiF   
	   
	   
	   
	   NImage/= FermiF
       EndIF
	  
	  
////Reverse the Detector Angle so Plus means larger K, Minus means smaller K.	  
	  
////	  	    XJZImginfo(NImage)
////           SetScale/P y ymax, -yinc,"" NImage
 	  
	  

//         Reverse the angle direction depending on the data source

//2007/10/11, should reverse the order of the detector angle, to be more complete

 

//Way 1, it works but slow
     //   XJZImginfo(NImage)
     //   IF (root:PROCESS:DataSource==1)
          
     //   Duplicate/O NImage TempImage
          
    //    Variable i=0
     //   Variable j
          
     //   DO
                   
    //    j=0
    //   Do
    //   TempImage[i][j]=NImage[i][ny-j]
    //  j+=1
    //    While (j<ny)
        
   //      i+=1
   //  While(i<nx)
          
          
   //  NImage=tempImage
                  
    
  //  SetScale/P y -ymax, yinc,"" NImage
      
  ////     SetScale/P y ymax, -yinc,"" NImage
   //      ENDIF
       
       
//Way 2, a better way? Not yet.

//way 2  added by HJF-------------------------------------------------------------------------------------------------------------------------------

       XJZImginfo(NImage)
       IF (root:PROCESS:DataSource==1)
         
       Duplicate/O NImage  tempimage
         
        Variable k=0
        DO
        Duplicate/O/R=(xmin,xmax)(ymax-yinc*k,ymax-yinc*k) NImage,tempwave
        tempimage[][k]=tempwave[p]
        k+=1
        while(k<ny)
         NImage=tempimage
         SetScale/P y -ymax, yinc,"" NImage  
        ENDIF 
//    added by HJF----------------------------------------------------------------------------------------------------------------------------------       
        
          

//////          IF (root:PROCESS:DataSource==1)
//////          SetScale/P y ymax, -yinc,"" NImage
          
////      SetScale/P y ymax, -yinc,"" NImage

//////          Reverse/DIM=1  NImage
//////          ENDIF       
       
       
	   



//     Put Processed Image in PROCESS and Display
		String/G NName
		String SignName
		If (root:PROCESS:ThetaAngle<0) 
			SignName="N"
			else
			SignName="P"
		endif
		
		Variable/G root:PROCESS:PositiveThetaAngle=0
		
	      String curr1= GetDataFolder(1)
          SetDataFolder root:
	      String ImagefileList= WaveList("!*_CT",";","DIMS:2")	                 //Loaded Images
	      variable limit=ItemsInList( ImagefileList, ";")
	      SetDataFolder curr1
		
		
		If (root:PROCESS:ThetaAngle<0)
			root:PROCESS:PositiveThetaAngle=-root:PROCESS:ThetaAngle
			else
			root:PROCESS:PositiveThetaAngle=root:PROCESS:ThetaAngle
		Endif
		
		
		
		String SignName_Omega
		If (root:PROCESS:OmegaAngle<0) 
			SignName_Omega="N"
			else
			SignName_Omega="P"
		endif		
		
		String SignName_Phi
		If (root:PROCESS:PhiAngle<0) 
			SignName_Phi="N"
			else
			SignName_Phi="P"
		endif		
		
		
		
		
		NName=root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"t"+num2str(round(root:PROCESS:TempTemperature2D))
		NName+="O"+num2str(round(10*abs(root:PROCESS:OmegaAngle)))+SignName_Omega+"P"+num2str(round(10*abs(root:PROCESS:PhiAngle)))+SignName_Phi+"T"+num2str(round(10*root:PROCESS:PositiveThetaAngle))+SignName
//	    NName=root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"t"+num2str(root:PROCESS:TempTemperature2D)+"P"+num2str(root:PROCESS:PhiAngle)+"T"+num2str(root:PROCESS:PositiveThetaAngle)+SignName

	
//// 	NName=root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"P"+num2str(root:PROCESS:PhiAngle)+"T"+num2str(root:PROCESS:PositiveThetaAngle)+SignName

		duplicate/O NImage root:PROCESS:$NName
                	 

	    SetDataFolder root:PROCESS
	    String/G ProcessedFileList=WaveList("*F*P*T*",";","DIMS:2")
	
	
	    
	   

	    
	    
	    
	        		        
	    SetDataFolder curr

End
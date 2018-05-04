#pragma rtGlobals=1		// Use modern global access method.


Proc  XJZ3DEThetaPhi(ctrlName) : ButtonControl
	 String ctrlName
	 
	 String curr=GetDataFolder(1)
	 
	 XJZMake3DEThetaPhiImage()
 	 Show3DImage()
 	 
 	 SetDataFolder curr
       
End

 Proc  XJZ3DEKxKy(ctrlName) : ButtonControl
	 String ctrlName
	 
	 String curr=GetDataFolder(1)
	 
	 Make3DEKxKyImage()
 	 Show3DImage()
 	 
 	 SetDataFolder curr
       
End


 
 
Proc Show3DImage()
	MakeSlicer()
	MakeCrossSlices()
End


Proc XJZMake3DEThetaPhiImage()

String Curr=GetDataFolder(1)

SetDataFolder root:ThreeDImages
Variable ThreeDThetaStart=root:PROCESS:ThetaStart
Variable ThreeDThetaEnd=root:PROCESS:ThetaEnd
Variable NumberofAngle=ThreeDThetaEnd -ThreeDThetaStart+1
Make/O/N=(NumberofAngle) ThreeDThetaWave, ThreeDPhiWave
Make/O/T/N=(NumberofAngle) ThreeDImageWave
Variable NumberofAllImages=numpnts(root:OriginalData:ProcessFlag)

Variable  iThreeD=0
Variable  jThreeD=0

Do 

       If (abs((root:OriginalData:ProcessFlag[iThreeD])-(root:PROCESS:ProcessedImageFlag))<0.1)
       If (root:originalData:Theta_Angle[iThreeD]>ThreeDThetaStart-1)
       If (root:OriginalData:Theta_Angle[iThreeD]<ThreeDThetaEnd+1)       
       
       ThreeDThetaWave[jThreeD]=root:OriginalData:Theta_Angle[iThreeD]
       ThreeDPhiWave[jThreeD]=root:OriginalData:Phi_Angle[iThreeD]
       ThreeDImageWave[jThreeD]=root:OriginalData:ProcessedImage[iThreeD]
        jThreeD+=1
        Endif
        Endif
        Endif
 
iThreeD+=1
While (iThreeD<NumberofAllImages)


       String Temp3D=root:ThreeDImages:ThreeDImageWave[0]
       Duplicate/O  root:PROCESS:$Temp3D  root:ThreeDImages:Temp3DImage

        variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax
	nx=DimSize(Temp3DImage, 0); 	ny=DimSize(Temp3DImage, 1)
	xmin=DimOffset(Temp3DImage,0);  ymin=DimOffset(Temp3DImage,1);
	xinc=round(DimDelta(Temp3DImage,0) * 1E6) / 1E6	
	yinc=round(DimDelta(Temp3DImage,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1)
	
	
	Make/o/n=(ny,NumberofAngle,nx) ThreeDIMAGE        //Phi, Theta, Energy
	Variable iTheta
	Variable Thetafor3D
	Variable iFindTheta
	String ImageNamefor3D

         iTheta=0
         Do 

		Thetafor3D=ThreeDThetaStart+iTheta
		
		iFindTheta=0	
		Do 
		If (abs((root:ThreeDImages:ThreeDThetaWave[iFindTheta])-Thetafor3D)<0.1)
		ImageNamefor3D=root:ThreeDImages:ThreeDImageWave[iFindTheta]
		Print ImageNamefor3D
		ThreeDIMAGE[ ] [iTheta ] [ ]=root:Process:$ImageNamefor3D[r][p]
		Endif
		iFindTheta+=1
	        While(iFindTheta<NumberofAngle)
	        
         iTheta+=1	
 	While(iTheta<NumberofAngle)
 	
 	SetScale/I z xmin, xmax, ThreeDIMAGE
 	SetScale/I x ymin, ymax, ThreeDIMAGE
 	SetScale/I y ThreeDThetaStart, ThreeDThetaEnd, ThreeDIMAGE
 	
 	Print "X--Phi, Y--Theta, Z--Energy"
	
      
SetDataFolder Curr

End





Proc Make3DEKxKyImage()

String Curr=GetDataFolder(1)

SetDataFolder root:ThreeDImages
Variable ThreeDThetaStart=root:PROCESS:ThetaStart
Variable ThreeDThetaEnd=root:PROCESS:ThetaEnd
Variable NumberofAngle=ThreeDThetaEnd -ThreeDThetaStart+1
Make/O/N=(NumberofAngle) ThreeDThetaWave, ThreeDPhiWave
Make/O/T/N=(NumberofAngle) ThreeDImageWave
Variable NumberofAllImages=numpnts(root:ProcessFlag)

Variable  iThreeD=0
Variable  jThreeD=0

Do 

       If (abs((root:ProcessFlag[iThreeD])-(root:PROCESS:ProcessedImageFlag))<0.1)
       If (root:Theta_Angle[iThreeD]>ThreeDThetaStart-1)
       If (root:Theta_Angle[iThreeD]<ThreeDThetaEnd+1)       
       
       ThreeDThetaWave[jThreeD]=root:Theta_Angle[iThreeD]
       ThreeDPhiWave[jThreeD]=root:Phi_Angle[iThreeD]
       ThreeDImageWave[jThreeD]=root:ProcessedImage[iThreeD]
        jThreeD+=1
        Endif
        Endif
        Endif
 
iThreeD+=1
While (iThreeD<NumberofAllImages)


       String Temp3D=root:ThreeDImages:ThreeDImageWave[0]
       Duplicate/O  root:PROCESS:$Temp3D  root:ThreeDImages:Temp3DImage

        variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax
	nx=DimSize(Temp3DImage, 0); 	ny=DimSize(Temp3DImage, 1)
	xmin=DimOffset(Temp3DImage,0);  ymin=DimOffset(Temp3DImage,1);
	xinc=round(DimDelta(Temp3DImage,0) * 1E6) / 1E6	
	yinc=round(DimDelta(Temp3DImage,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1)
	
	
	//x--Energy
	//y--Phi Angle
	Make/o/n=(nx,ny,NumberofAngle) ThreeDIMAGE
	
	Variable iTheta
	Variable Thetafor3D
	Variable iFindTheta
	String ImageNamefor3D


         iTheta=0
         Do 

		Thetafor3D=ThreeDThetaStart+iTheta
		
		iFindTheta=0	
		Do 
		If (abs((root:ThreeDImages:ThreeDThetaWave[iFindTheta])-Thetafor3D)<0.1)
		ImageNamefor3D=root:ThreeDImages:ThreeDImageWave[iFindTheta]
		ThreeDIMAGE[ ] [ ] [iTheta ]=root:Process:$ImageNamefor3D[p][q]
		Endif
		iFindTheta+=1
	        While(iFindTheta<NumberofAngle)
	        
         iTheta+=1	
 	While(iTheta<NumberofAngle)
 	
 	SetScale/I x xmin, xmax, ThreeDIMAGE
 	SetScale/I y ymin, ymax, ThreeDIMAGE
 	SetScale/I z ThreeDThetaStart, ThreeDThetaEnd, ThreeDIMAGE
	
      
SetDataFolder Curr

End




Proc MakeSlicer()
	CreateSlicer // If error, install the Graphical Slicer XOP
	ModifySlicer srcWave=root:ThreeDImages:ThreeDIMAGE
//	ModifySlicer Theta = 50
//	ModifySlicer Phi = 50
End


Proc MakeCrossSlices()
	ModifySlicer update=0 // If error, install the Graphical Slicer XOP
	ModifySlicer NewWidthSlice=0.5, NewLengthSlice=0.5, NewHeightSlice=0.5
	ModifySlicer update=1
End


Proc ScanSlice(type)
	Variable type
	silent 1
	ModifySlicer Slicetype=type, SelectSlice=0 // If error, install the Graphical Slicer XOP
	Variable i=0
	do
		ModifySlicer MoveSlice=i/10
		i+=1
	while(i<10)
End

Proc MakeCube()
	ModifySlicer Clear // If error, install the Graphical Slicer XOP
	ModifySlicer NewWidthSlice=1, NewLengthSlice=0, NewHeightSlice=1
End

Function ClearFolder(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	
	//Kill _info Files in root:OriginalData
	SetDataFolder root:OriginalData
	String ToBeKilledwaveslist=WaveList("*_info",";","DIMS:1")
       	Variable NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
       	String Killedwave
	      Variable ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	  
	   //Kill waves in root:FermiLevelFromAu   
	      
	 SetDataFolder root:FermiLevelFromAu
	   ToBeKilledwaveslist=WaveList("AuFermi*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	       ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	      
	      ToBeKilledwaveslist=WaveList("*fit*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	       ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
      
	      
	   //Kill EDC Curves in Root:PROCESSEDIMAGESpectra
	SetDataFolder root:PROCESSEDIMAGESpectra
	ToBeKilledwaveslist=WaveList("*F*P*T*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	       ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
      
	     
	//Kill EDC Curves in Root:BackGroungSubtractedSpectra
	SetDataFolder root:BackGroundSubtractedSpectra
      ToBeKilledwaveslist=WaveList("*F*P*T*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)   
	     
	//Kill Images in Root:BackGroungSubtractedImage
	SetDataFolder root:BackGroundSubtractedImage
       	 ToBeKilledwaveslist=WaveList("BG_*",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves) 
	     
	//Kill Images in Root:IMG
	SetDataFolder root:IMG
       ToBeKilledwaveslist=WaveList("*meV",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)  	
	
	//Kill images in root:dispersionImage
	SetDataFolder root:DispersionIMAGE
       ToBeKilledwaveslist=WaveList("*F*t*P*",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)  
	      
	      //Kill images in root:dispersionImage_EbCorrected
	SetDataFolder root:DispersionIMAGE_EbCorrected
       ToBeKilledwaveslist=WaveList("*F*t*P*",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves) 
	      
	        //Kill images in root:dispersionImage_EbCorrected:DispersionIMAG_Rotated
	SetDataFolder root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated
       ToBeKilledwaveslist=WaveList("*F*t*P*",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)	
	      
	        //Kill images in root:dispersionImage_EbCorrected:EDCsFromCorrectedDisIMAG
	SetDataFolder root:DispersionIMAGE_EbCorrected:EDCsFromCorrectedDisIMAG
       ToBeKilledwaveslist=WaveList("",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	
	
	
	     
	//Kill MDC Curves in root:MDCSpectra
	SetDataFolder root:MDCSpectra
	   
      ToBeKilledwaveslist=WaveList("D*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)

   
       	ToBeKilledwaveslist=WaveList("KRef*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	      
	      
	      
	//Kill MDC Fitted Curves in root:MDCSpectra
//      SetDataFolder root:MDCSpectra
      ToBeKilledwaveslist=WaveList("fit_*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	      
	       ToBeKilledwaveslist=WaveList("*meV*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	//Kill MDC Fitted Curves in root:MDCSpectra

//      SetDataFolder root:MDCSpectra
       ToBeKilledwaveslist=WaveList("MFL*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	            
	//Kill Images in Root:DispersionFrom2ndDerivative
	SetDataFolder root:DispersionFrom2ndDerivative
       ToBeKilledwaveslist=WaveList("ST*",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	
	
	//Kill self energy in root:selfenergyfromMDC
	Newdatafolder/O root:selfenergyfromMDC
	SetDataFolder root:selfenergyfromMDC
       ToBeKilledwaveslist=WaveList("*SE*",";","DIMS:1")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	
	//Kill iamges in root:DispersionIMAGE_1overA
	Newdatafolder/O root:DispersionIMAGE_1overA
	SetDataFolder root:DispersionIMAGE_1overA
       ToBeKilledwaveslist=WaveList("*E*t*P*",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)
	  //kill images in root:EKImage_Interpolated:Pi_over_a
	  Newdatafolder/O root:EKImage_Interpolated
	  Newdatafolder/O root:EKImage_Interpolated:Pi_over_a
	  SetDataFolder root:EKImage_Interpolated:Pi_over_a
       ToBeKilledwaveslist=WaveList("**F*t*P",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)    
	      
	      Newdatafolder/O root:EKImage_Interpolated:one_over_a
	  SetDataFolder root:EKImage_Interpolated:one_over_a
       ToBeKilledwaveslist=WaveList("*F*t*P*",";","DIMS:2")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves) 
	//kill images and traces in root:MDCandEDC
	newdatafolder/o root:MDCandEDC
		SetDataFolder root:MDCandEDC
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)    
	      
	      //kill waves in Simulation folder 
	      
	      newdatafolder/o root:ARPESSimulation
		SetDataFolder root:ARPESSimulation
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)     
	       newdatafolder/o root:ARPESSimulatedImage
		SetDataFolder root:ARPESSimulatedImage
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)     

	 newdatafolder/o root:ARPESSimulatedSpectra
		SetDataFolder root:ARPESSimulatedSpectra
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)  
	      
	       newdatafolder/o root:ARPESSimulateddispersion
		SetDataFolder root:ARPESSimulatedDispersion
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)    
	      
	       newdatafolder/o root:ARPESRealSefromMDC
		SetDataFolder root:ARPESRealSefromMDC
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)       
	       newdatafolder/o root:ARPESSimulatedSelfEnergy
		SetDataFolder  root:ARPESSimulatedSelfEnergy
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)  
	     //Killwaves in root:MomentumMap
	        newdatafolder/o root:MomentumMap
		SetDataFolder  root:MomentumMap
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)  
	      
	      //Killwaves in root:SchematicFermiSurface
	      //killwaves in root:acarpes
	      newdatafolder/o root:acarpes
		SetDataFolder  root:acarpes
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)  
	  
	  
	   newdatafolder/o root:winglobals
	    newdatafolder/o root:winglobals:ImageTool
	   
		SetDataFolder root:winglobals:ImageTool
       ToBeKilledwaveslist=WaveList("*",";","")
        NoofKilledwaves=ItemsinList(ToBeKilledwaveslist,";")
	      ii=0
	      Do
	      Killedwave=StringFromList(ii,ToBeKilledwavesList,";")
	      KillWaves/Z  $Killedwave
	      ii+=1
	      While(ii<NoofKilledwaves)  
	  
	SetDataFolder Curr
	
End


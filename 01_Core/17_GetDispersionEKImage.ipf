#pragma rtGlobals=1		// Use modern global access method.


proc ZWTGetDispersionEkImage(CtrlName): ButtonControl
	String CtrlName
	pauseupdate;silent 1
	variable GetALLEK=root:Process:GetallEKV
	//print getallEK
	String TempName
	///ZWT
	setdatafolder root:originalData
	variable loops=Dimsize(ProcessFlag,0)
	Variable ii=0
	Variable jj=0
	Variable hh=0
	Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
	String TempWaveName,EKName,GraphN
	Variable DeltaK
	///ZWTEND
	pauseupdate;silent 1
	if(GetALlEK)
		NewDatafolder/O/S root:EKImage_Interpolated:one_over_A
		Killwaves/A/Z
      	NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a 
      	Killwaves/A/Z
		SetDataFolder root:OriginalData
        root:OriginalData:OriginalFileList=WaveList("A*",";","DIMS:2")
        root:OriginalData:NoofOriginalFile=ItemsinList(OriginalFileList,";")
        root:OriginalData:Original1DFileList=WaveList("A*",";","DIMS:1")      
        root:OriginalData:Noof1DOriginalFile=ItemsinList(Original1DFileList,";")  
        Variable NumberofOriginalFiles= root:OriginalData:NoofOriginalFile
        Variable PhotonEnergy=root:PROCESS:PhotonEnergy
		Variable WorkFunction=root:PROCESS:WorkFunction
		Variable LatticeConstant=root:PROCESS:LatticeConstant
		Variable PhiOffset=root:PROCESS:PhiOffset
             
        If(NumberofOriginalFiles>0)   
             SetDataFolder root:DispersionIMAGE
             String DispersionImg
             String DispersionImageFileList= WaveList("*",";","DIMS:2")
             String ToKillDispersionFileList= WaveList("*D*",";","DIMS:2")
	      	  Variable DispersionImagelimit=ItemsInList( DispersionImageFileList, ";")
	         Variable ToKillDispersionImagelimit=ItemsInList(ToKillDispersionFileList, ";")
	         Variable iToKillDispersionImage=0
	         Do
	        	 DispersionImg=StringFromList(iToKillDispersionImage,ToKillDispersionFilelist,";")
	     		 KillWaves/Z  $DispersionImg
	     		 iToKillDispersionImage=iToKillDispersionImage+1
	    	 While(iToKillDispersionImage<ToKillDispersionImagelimit)
	         SetDataFolder root:DispersionIMAGE_1overA
             String DispersionImg1overA
             String DispersionImage1overAFileList= WaveList("*",";","DIMS:2")
             String ToKillDispersion1overAFileList= WaveList("*D*",";","DIMS:2")
	      	  Variable DispersionImage1overAlimit=ItemsInList( DispersionImage1overAFileList, ";")
	         Variable ToKillDispersion1overAlimit=ItemsInList(ToKillDispersion1overAFileList, ";")
             Variable iToKillDispersionImage1overA=0
	         Do
	        	 DispersionImg1overA=StringFromList(iToKillDispersionImage1overA,ToKillDispersion1overAFilelist,";")
	    		 KillWaves/Z  $DispersionImg1overA
	     		 iToKillDispersionImage1overA=iToKillDispersionImage1overA+1
	     	 While(iToKillDispersionImage1overA<ToKillDispersion1overAlimit)
			SetDataFolder root:OriginalData
			Variable NumberofImages=numpnts(root:OriginalData:DispersionFlag)
			Variable DisTheta, AbsoluteTheta, DisPhi, DisOmega,NDisTheta, NDisPhi, DisPhimin, DisPhimax, kmin, kmax,TempTem
			String   ThetaSign, PhiSign, OmegaSign
			String   DisImage, DisImageName
			Variable PhotonE=root:PROCESS:PhotonEnergy
			Variable WorkFunc=root:Process:WorkFunction
			Variable LC=root:PROCESS:LatticeConstant
			Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
			Variable  iDispersion=0
			
			
			Setdatafolder root:OriginalData


			Do
				IF (abs((root:OriginalData:DispersionFlag[iDispersion])-(root:PROCESS:DispersionImageFlag))<0.1)
      				if (abs((root:OriginalData:ProcessFlag[iDispersion])-(root:PROCESS:ProcessedImageFlag))<0.1)
      					DisTheta=root:OriginalData:Theta_Angle[iDispersion]
     					DisPhi=root:OriginalData:Phi_Angle[iDispersion]
      					DisOmega=root:OriginalData:Omega_Angle[iDispersion]      
      					DisImage=root:OriginalData:ProcessedImage[iDispersion]
      					TempTem=root:OriginalData:Temperature2D[iDispersion]     
       					NDisTheta=DisTheta-root:PROCESS:ThetaOffset
       					NDisPhi=DisPhi-root:PROCESS:PhiOffset 

       					if (DisTheta<0)
       						ThetaSign="N"
       						AbsoluteTheta=-DisTheta
       					else
      						ThetaSign="P"
       						AbsoluteTheta=DisTheta
      					Endif
       
       					if (DisPhi<0)
      						PhiSign="N"
       					else
       						PhiSign="P"
       					Endif
      
       					if (DisOmega<0)
       						OmegaSign="N"
       					else
      						OmegaSign="P"
       					Endif     
    					Duplicate/O  root:PROCESS:$DisImage  root:IMG:TempdisImage
    					SetDataFolder root:IMG
						variable/G nx, ny
						variable/G xmin, xinc, xmax, ymin, yinc, ymax
						nx=DimSize(TempdisImage, 0); 	ny=DimSize(TempdisImage, 1)
						xmin=DimOffset(TempdisImage,0);  ymin=DimOffset(TempdisImage,1);
						xinc=round(DimDelta(TempdisImage,0) * 1E6) / 1E6	
						yinc=round(DimDelta(TempdisImage,1)* 1E6) / 1E6
						xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1);
    					DisPhimin=root:PROCESS:DetectorCenterAngle-ymax+NDisPhi
 						DisPhimax=root:PROCESS:DetectorCenterAngle-ymin+NDisPhi
       					kmin=K0*sin(3.1416/180*DisPhimin)   
       					kmax=K0*sin(3.1416/180*DisPhimax)       
       					SetScale/I y kmax, kmin, TempdisImage
       					MatrixTranspose TempdisImage
       					DisImageName="ND"+root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"t"+num2str(TempTem)
       					DisImageName+="O"+ num2str(round(abs(DisOmega)))+OmegaSign + "P"+num2str(round(abs(DisPhi)))+"T"+num2str(round(Abs(DisTheta)))+ThetaSign 
       					TempName=root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"t"+num2str(TempTem)
       					Duplicate/O TempdisImage root:DispersionIMAGE:$DisImageName 
       					MatrixTranspose TempdisImage
       					SetScale/I y kmax*3.1416/(root:PROCESS:LatticeConstant), kmin*3.1416/(root:PROCESS:LatticeConstant), TempdisImage     
       					MatrixTranspose TempdisImage     
       					Duplicate/O TempdisImage root:DispersionIMAGE_1overA:$DisImageName
       					
       					//////////////////////////////////////////////////////////////////////////////////////////////////////
       					//Get Interpolated E-K Pi/a, byZWT,20091231
       					/////////////////////////////////////////////////////////////////////////////////////////////////////
       					pauseupdate;silent 1
       					ii=iDispersion
       					Setdatafolder root:OriginalData
						TempPhi=Phi_Angle[ii]
						tempWavename=ProcessedImage[ii]
						EKName="EK"+tempWaveName+"_PiOvera"
						//GraphN="Image"+tempWaveName+"PiOvera"
						setdatafolder root:EKImage_Interpolated:Pi_over_a 
						duplicate/O root:PROCESS:$TempWaveName,tempImage
						Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
						Make/O/N=(Dimsize(tempImage,0)) EE
			
						PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
						MinE=leftx(TempImage)
						MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
						SetScale/I x MinE,MaxE,"", EE
						EE=x
						MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
						MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
						MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MaxK=0.5118*LatticeConstant/pi*MaxK
						MinK=0.5118*LatticeConstant/pi*MinK
						SetScale/I x MinK,MaxK,"", KK
						DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
						kk=x
						Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
						jj=0
						Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
						PhiAngle=tempPhi-PhiOffset-PhiAngle
						do
							MDCIntensity=TempImage[jj][p]
							MDCKp=0.5118*LatticeConstant/pi*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
							Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
							lowKn=round((MDCKp[0]-kk[0])/deltaK)
							HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
							tempMDC[0,highkn-1]=NaN
							tempMDC[lowkn+1,dimsize(tempMDC,0)]=NaN
							$EKName[][jj]=TempMDC[p]
							SetScale/I x minK,maxk,"", $EKName
							SetScale/I y minE,maxE,"", $EKName
							jj=jj+1
						while(jj<Dimsize(TempImage,0))
						killwaves/Z tempImage,PhiAngle,KK,TempMDC,EE,MDCIntensity,MDCKp
						/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//Get Interpolated E-K 1/A, byZWT,20091231
						/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       					Setdatafolder root:OriginalData
						TempPhi=Phi_Angle[ii]
						tempWavename=ProcessedImage[ii]
						EKName="EK"+tempWaveName+"_1Overa"
						setdatafolder root:EKImage_INterpolated:one_over_A
						duplicate/O root:PROCESS:$TempWaveName,tempImage
						Make/O/N=(Dimsize(tempImage,1)) PhiAngle,KK,TempMDC
						Make/O/N=(Dimsize(tempImage,0)) EE
						PhiAngle=DimDelta(TempImage,1)*x+Dimoffset(TempImage,1)
						MinE=leftx(TempImage)
						MaxE=leftx(Tempimage)+dimdelta(TempImage,0)*(Dimsize(TempImage,0)-1)
						SetScale/I x MinE,MaxE,"", EE
						EE=x
						MaxK=max(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
						MaxK=Max(MaxK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MaxK=Max(MaxK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MinK=min(sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])),sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[0])))
						MinK=Min(MinK,sqrt(PhotonEnergy+MinE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MinK=Min(MinK,sqrt(PhotonEnergy+MaxE-WorkFunction)*sin(pi/180*(tempPhi-PhiOffset-PhiAngle[Dimsize(Phiangle,0)])))
						MaxK=0.5118*MaxK
						MinK=0.5118*MinK
						SetScale/I x MinK,MaxK,"", KK
						DeltaK=(Maxk-MinK)/(Dimsize(kk,0)-1)
						kk=x
						Make/O/N=(Dimsize(PhiAngle,0),Dimsize(TempImage,0)) $EKName
						jj=0
						Make/O/N=(dimsize(TempImage,1)) MDCIntensity,MDCKp
						PhiAngle=tempPhi-PhiOffset-PhiAngle
						do
							MDCIntensity=TempImage[jj][p]
							MDCKp=0.5118*sqrt(PhotonEnergy-WorkFunction+EE[jj])*sin(PhiAngle*pi/180)
							Interpolate2/T=2/E=2/I=3/X=KK/Y=TempMDC MDCKp,MDCIntensity
							lowKn=round((MDCKp[0]-kk[0])/deltaK)
							HighKn=round((MDCKp[dimsize(MDCKp,0)]-kk[0])/deltaK)
							tempMDC[0,highkn-1]=NaN
							tempMDC[lowkn+1,dimsize(tempMDC,0)]=NaN
							$EKName[][jj]=TempMDC[p]
							SetScale/I x minK,maxk,"", $EKName
							SetScale/I y minE,maxE,"", $EKName
							jj=jj+1
						while(jj<Dimsize(TempImage,0))
						
						killwaves/Z tempImage,PhiAngle,KK,TempMDC,EE,MDCIntensity,MDCKp
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//ZWTEND

       					
       					
       					
       					    
       					
 	   				Endif      
      			EndIF
      			
				iDispersion=iDispersion+1
		While (iDispersion<NumberofImages)
		Else
		Endif
	SetDataFolder root:DispersionIMAGE
	root:PROCESS:DispersionFileList= WaveList("*",";","DIMS:2")
	setdatafolder root:EKImage_Interpolated:Pi_over_a
	root:Process:EKPiovera=WaveList("*",";","DIMS:2")
	setdatafolder root:EKImage_Interpolated:one_over_A
	root:Process:EK1overA=WaveList("*",";","DIMS:2")
	endif
end

Proc XJZGetDispersionEkImage(ctrlName): ButtonControl
	String ctrlName
	pauseupdate;silent 1	
    String curr=GetDataFolder(1)

    IF (root:DispersionIMAGE:BindingECorrectionMode==0)
    
    XJZGetDispersionEkImage_NEbCor()
    
    Else
    XJZGetDispersionEkImage_NEbCor()
       
    XJZGetDispersionEkImage_WEbCor()
    EndIF



    SetDataFolder curr
    END
    
    





//This is a procedure to get dispersion image without Eb correction--2007/05/18
Proc XJZGetDispersionEkImage_NEbCor( )
//	String ctrlName
		pauseupdate;silent 1
            String curr=GetDataFolder(1)
            
            SetDataFolder root:OriginalData
            root:OriginalData:OriginalFileList=WaveList("A*",";","DIMS:2")
            root:OriginalData:NoofOriginalFile=ItemsinList(OriginalFileList,";")
            root:OriginalData:Original1DFileList=WaveList("A*",";","DIMS:1")      
            root:OriginalData:Noof1DOriginalFile=ItemsinList(Original1DFileList,";")  
             Variable NumberofOriginalFiles= root:OriginalData:NoofOriginalFile
             
             If(NumberofOriginalFiles>0)   
             
             SetDataFolder root:DispersionIMAGE
             String DispersionImg
             String DispersionImageFileList= WaveList("*",";","DIMS:2")
             String ToKillDispersionFileList= WaveList("*D*",";","DIMS:2")
	      Variable DispersionImagelimit=ItemsInList( DispersionImageFileList, ";")
	      Variable ToKillDispersionImagelimit=ItemsInList(ToKillDispersionFileList, ";")

	     Variable iToKillDispersionImage=0
	     Do
	     DispersionImg=StringFromList(iToKillDispersionImage,ToKillDispersionFilelist,";")
	     KillWaves/Z  $DispersionImg
	     iToKillDispersionImage=iToKillDispersionImage+1
	     While(iToKillDispersionImage<ToKillDispersionImagelimit)
	         SetDataFolder root:DispersionIMAGE_1overA
             String DispersionImg1overA
             String DispersionImage1overAFileList= WaveList("*",";","DIMS:2")
             String ToKillDispersion1overAFileList= WaveList("*D*",";","DIMS:2")
	      Variable DispersionImage1overAlimit=ItemsInList( DispersionImage1overAFileList, ";")
	      Variable ToKillDispersion1overAlimit=ItemsInList(ToKillDispersion1overAFileList, ";")

	     Variable iToKillDispersionImage1overA=0
	     Do
	     DispersionImg1overA=StringFromList(iToKillDispersionImage1overA,ToKillDispersion1overAFilelist,";")
	     KillWaves/Z  $DispersionImg1overA
	     iToKillDispersionImage1overA=iToKillDispersionImage1overA+1
	     While(iToKillDispersionImage1overA<ToKillDispersion1overAlimit)
SetDataFolder root:OriginalData
Variable NumberofImages=numpnts(root:OriginalData:DispersionFlag)
Variable DisTheta, AbsoluteTheta, DisPhi, DisOmega,NDisTheta, NDisPhi, DisPhimin, DisPhimax, kmin, kmax,TempTem
String   ThetaSign, PhiSign, OmegaSign
String   DisImage, DisImageName
Variable PhotonE=root:PROCESS:PhotonEnergy
Variable WorkFunc=root:Process:WorkFunction
Variable LC=root:PROCESS:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
Variable  iDispersion=0

Do

      IF (abs((root:OriginalData:DispersionFlag[iDispersion])-(root:PROCESS:DispersionImageFlag))<0.1)
      if (abs((root:OriginalData:ProcessFlag[iDispersion])-(root:PROCESS:ProcessedImageFlag))<0.1)
      DisTheta=root:OriginalData:Theta_Angle[iDispersion]
      DisPhi=root:OriginalData:Phi_Angle[iDispersion]
      DisOmega=root:OriginalData:Omega_Angle[iDispersion]      
      DisImage=root:OriginalData:ProcessedImage[iDispersion]
      TempTem=root:OriginalData:Temperature2D[iDispersion]     
       NDisTheta=DisTheta-root:PROCESS:ThetaOffset
       NDisPhi=DisPhi-root:PROCESS:PhiOffset 

       if (DisTheta<0)
       ThetaSign="N"
       AbsoluteTheta=-DisTheta
       else
       ThetaSign="P"
       AbsoluteTheta=DisTheta
       Endif
       
       if (DisPhi<0)
       PhiSign="N"
       else
       PhiSign="P"
       Endif
       
       
       if (DisOmega<0)
       OmegaSign="N"
       else
       OmegaSign="P"
       Endif     
    Duplicate/O  root:PROCESS:$DisImage  root:IMG:TempdisImage
    SetDataFolder root:IMG
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax
	nx=DimSize(TempdisImage, 0); 	ny=DimSize(TempdisImage, 1)
	xmin=DimOffset(TempdisImage,0);  ymin=DimOffset(TempdisImage,1);
	xinc=round(DimDelta(TempdisImage,0) * 1E6) / 1E6	
	yinc=round(DimDelta(TempdisImage,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1);
    DisPhimin=root:PROCESS:DetectorCenterAngle-ymax+NDisPhi
 	DisPhimax=root:PROCESS:DetectorCenterAngle-ymin+NDisPhi
        kmin=K0*sin(3.1416/180*DisPhimin)   
        kmax=K0*sin(3.1416/180*DisPhimax)       
       SetScale/I y kmax, kmin, TempdisImage
       MatrixTranspose TempdisImage
       DisImageName="ND"+root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"t"+num2str(TempTem)
       DisImageName+="O"+ num2str(round(abs(DisOmega)))+OmegaSign + "P"+num2str(round(abs(DisPhi)))+"T"+num2str(round(Abs(DisTheta)))+ThetaSign     
       Duplicate/O TempdisImage root:DispersionIMAGE:$DisImageName 
       MatrixTranspose TempdisImage
       SetScale/I y kmax*3.1416/(root:PROCESS:LatticeConstant), kmin*3.1416/(root:PROCESS:LatticeConstant), TempdisImage     
       MatrixTranspose TempdisImage     
       Duplicate/O TempdisImage root:DispersionIMAGE_1overA:$DisImageName
 	   Endif      
      EndIF     
iDispersion=iDispersion+1
While (iDispersion<NumberofImages)
Else
Endif
SetDataFolder root:DispersionIMAGE
root:DispersionIMAGE:DispersionFileList= WaveList("!*_CT",";","DIMS:2")
SetDataFolder curr
End










//This is a procedure with Eb correction--2007/05/18

Proc XJZGetDispersionEkImage_WEbCor( )
//	String ctrlName
		pauseupdate;silent 1
            String curr=GetDataFolder(1)
            SetDataFolder root:OriginalData
            root:OriginalData:OriginalFileList=WaveList("A*",";","DIMS:2")
            root:OriginalData:NoofOriginalFile=ItemsinList(OriginalFileList,";")
            root:OriginalData:Original1DFileList=WaveList("A*",";","DIMS:1")      
            root:OriginalData:Noof1DOriginalFile=ItemsinList(Original1DFileList,";")  
            
             
             Variable NumberofOriginalFiles= root:OriginalData:NoofOriginalFile
//           print "NumberofOriginalFiles=", NumberofOriginalFiles
             



IF(NumberofOriginalFiles>0)   

            
             SetDataFolder root:DispersionIMAGE
             String DispersionImg
             String DispersionImageFileList= WaveList("*",";","DIMS:2")
             String ToKillDispersionFileList= WaveList("*D*",";","DIMS:2")
//           Print "DispersionImageFileList=", DispersionImageFileList
//           Print "ToKillDispersionFileList=", ToKillDispersionFileList
	      Variable DispersionImagelimit=ItemsInList( DispersionImageFileList, ";")
	      Variable ToKillDispersionImagelimit=ItemsInList(ToKillDispersionFileList, ";")

////	     Variable iToKillDispersionImage=0
////	     Do
////	     DispersionImg=StringFromList(iToKillDispersionImage,ToKillDispersionFilelist,";")
////	     KillWaves/Z  $DispersionImg
////	     iToKillDispersionImage=iToKillDispersionImage+1
////	     While(iToKillDispersionImage<ToKillDispersionImagelimit)
	     
	     
	     SetDataFolder root:DispersionIMAGE_EbCorrected
             String DispersionImg_EbC
             String DispersionFileList_EbC= WaveList("*",";","DIMS:2")
             String ToKillDispersionFileList_EbC= WaveList("YD*",";","DIMS:2")
//             Print "DispersionImageFileList_EbC=", DispersionImageFileList_EbC
//             Print "ToKillDispersionFileList_EbC=", ToKillDispersionFileList_EbC
	      Variable DispersionImagelimit_EbC=ItemsInList( DispersionFileList_EbCorrected, ";")
	      Variable ToKillDispersionImagelimit_EbC=ItemsInList(ToKillDispersionFileList_EbC, ";")

	     Variable iToKillDispersionImage_EbC=0
	     Do
	     DispersionImg_EbC=StringFromList(iToKillDispersionImage_EbC,ToKillDispersionFilelist_EbC,";")
	     KillWaves/Z  $DispersionImg_EbC
	     iToKillDispersionImage_EbC+=1
	     While(iToKillDispersionImage_EbC<ToKillDispersionImagelimit_EbC)
	     
     
	     

////SetDataFolder root:OriginalData

SetDataFolder root:DispersionIMAGE

Variable NumberofImages=numpnts(root:OriginalData:DispersionFlag)
Variable DisTheta, AbsoluteTheta, DisPhi, DisOmega,NDisTheta, NDisPhi, DisPhimin, DisPhimax, kmin, kmax,TempTem
String   ThetaSign, PhiSign, OmegaSign
String   DisImage, DisImageName
Variable PhotonE=root:PROCESS:PhotonEnergy
Variable WorkFunc=root:Process:WorkFunction
Variable LC=root:PROCESS:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
//Print "K0=", K0





Variable NX_E_Min
Variable NX_E_Max
Variable NX_E_Dim


//Y direction -- momentum axis needs to change
Variable NY_K_Min
Variable NY_K_Max
Variable NY_K_Step
Variable NY_K_Dim

Variable BEnergy

Variable ik, iY,iFImage


Variable  DetPhimin,DetPhimax


Variable  iDispersion=0


Do

      IF (abs((root:OriginalData:DispersionFlag[iDispersion])-(root:PROCESS:DispersionImageFlag))<0.1)
      if (abs((root:OriginalData:ProcessFlag[iDispersion])-(root:PROCESS:ProcessedImageFlag))<0.1)
      DisTheta=root:OriginalData:Theta_Angle[iDispersion]
      DisPhi=root:OriginalData:Phi_Angle[iDispersion]
      DisOmega=root:OriginalData:Omega_Angle[iDispersion]      
      DisImage=root:OriginalData:ProcessedImage[iDispersion]
      TempTem=root:OriginalData:Temperature2D[iDispersion]
            
       NDisTheta=DisTheta-root:PROCESS:ThetaOffset
       NDisPhi=DisPhi-root:PROCESS:PhiOffset 

       if (DisTheta<0)
       ThetaSign="N"
       AbsoluteTheta=-DisTheta
       else
       ThetaSign="P"
       AbsoluteTheta=DisTheta
       Endif
       
       if (DisPhi<0)
       PhiSign="N"
       else
       PhiSign="P"
       Endif
       
       
       if (DisOmega<0)
       OmegaSign="N"
       else
       OmegaSign="P"
       Endif     
       
  
 
     

 
    Duplicate/O  root:PROCESS:$DisImage  root:IMG:TempdisImage
//  Display; AppendImage root:IMG:TempdisImage

    SetDataFolder root:IMG
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax
	nx=DimSize(TempdisImage, 0); 	ny=DimSize(TempdisImage, 1)
	xmin=DimOffset(TempdisImage,0);  ymin=DimOffset(TempdisImage,1);
	xinc=round(DimDelta(TempdisImage,0) * 1E6) / 1E6	
	yinc=round(DimDelta(TempdisImage,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1);
	
////    DetPhimin=(ymin+ymax)/2-ymax
//// 	DetPhimax=(ymin+ymax)/2-ymin	
 	
 //2007/06/29  Change (ymin+ymax)/2 into DetecorCenterAngle
 
    DetPhimin=root:PROCESS:DetectorCenterAngle-ymax
 	DetPhimax=root:PROCESS:DetectorCenterAngle-ymin	 	
	
	
 	SetScale/I y, DetPhimin, DetPhimax, TempdisImage     /////Make the angle symmetrical so in the following it will not cause problem
 	
 	
////   DisPhimin=(ymin+ymax)/2-ymax+NDisPhi
//// 	DisPhimax=(ymin+ymax)/2-ymin+NDisPhi	
 	

//2007/06/29  Change (ymin+ymax)/2 into DetectorCenterAngle
    DisPhimin=root:PROCESS:DetectorCenterAngle-ymax+NDisPhi
 	DisPhimax=root:PROCESS:DetectorCenterAngle-ymin+NDisPhi	
 	



////////////////////////////////////////////////////////////////////////////////////////////



//Define the dimension of the New Dispersion Image

//X direction -- Energy direction is the same
NX_E_Min=xmin
NX_E_Max=xmax
NX_E_Dim=nx


//Y direction -- momentum axis needs to change
NY_K_Min=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+NX_E_Min)*sin(3.1416/180*DisPhimin)-0.01
NY_K_Max=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+NX_E_Max)*sin(3.1416/180*DisPhimax)+0.01
NY_K_Step=root:DispersionIMAGE_EbCorrected:InterStep 
NY_K_Dim=Round(Abs((NY_K_Max-NY_K_Min)/NY_K_Step))



Print "E_Min=", NX_E_Min
Print "E_Max=", NX_E_Max
Print "E_Dimension=", NX_E_Dim

Print "K_Min=", NY_K_Min
Print "K_Max=", NY_K_Max
Print "K_Dimension=", NY_K_Dim


Make/O/N=(NX_E_Dim,NY_K_Dim) Tem_New_DisImage
Setscale/I x, NX_E_Min, NX_E_Max, Tem_New_DisImage
SetScale/I y, NY_K_Min, NY_K_Max, Tem_New_DisImage



Make/O/N=(ny) TemOri_Angle_Y, TemOri_K_Y, TemOri_Int


Make/O/N=(NY_K_Dim) Tem_K_Int



ik=0
DO


                     //Get Corresponding Binding Energy
                     BEnergy=xmin + ik*xinc                     
                     
////                 Print ik, "BEnergy=", BEnergy 

                     //Get TemOri_Angle_Y, TemOri_K_Y, TemOri_Int
                     iY=0
                     Do
                     TemOri_Angle_Y[iY]=ymin+iY*yinc
                     
                     TemOri_K_Y[iY]=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+BEnergy)*sin(3.1416/180*(TemOri_Angle_Y[iY]+NDisPhi))
                                          
                     TemOri_Int[ny-iY]=TempdisImage[ik][iY]
                     
                     iY+=1
                     While(iY<ny)
                     
//                    Edit TemOri_Angle_Y, TemOri_K_Y,  TemOri_Int
                  
                     
                     //Get Tem_K_Int                                 
                     Tem_K_Int=ReMakeWave(TemOri_Int,TemOri_K_Y,NY_K_Min,NY_K_Max,NY_K_Step)

//                     Edit  TemOri_Int, Tem_K_Int                     
                     //Give Tem_K_Int to TemNewImage
                     
                     iFImage=0
                     Do
                     
                     Tem_New_DisImage[ik][iFImage]=Tem_K_Int[iFImage]                     
                     
                     iFImage+=1
                     While(iFImage<NY_K_Dim)
                     
                     IF ((ik/10-Round(ik/10))==0)
                     Print iDispersion,"/",NumberofImages, "__",    ik,"/",NX_E_Dim
                     EndIF
                    
ik+=1
While (ik<nx)


       DisImageName="YD"+root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"t"+num2str(TempTem)
       DisImageName+="O"+ num2str(round(abs(DisOmega)))+OmegaSign + "P"+num2str(DisPhi)+"T"+num2str(Abs(DisTheta))+ThetaSign
       
       Duplicate/O Tem_New_disImage root:DispersionIMAGE_EbCorrected:DispersionIMAG_Rotated:$DisImageName
       
       MatrixTranspose Tem_New_DisImage        

       Duplicate/O Tem_New_disImage root:DispersionIMAGE_EbCorrected:$DisImageName   
       



       
////       MatrixTranspose Tem_New_DisImage
          
	    
////        ny=DimSize(Tem_New_DisImage, 1)
////	    yinc=round(DimDelta(Tem_New_DisImage,1)* 1E6) / 1E6       		    
////	    ymin=DimOffset(Tem_New_DisImage,1)
////	    ymax=ymin+yinc*(ny-1);
       
       
       
////       
////      SetScale/I y ymin*3.1416/(root:PROCESS:LatticeConstant), ymax*3.1416/(root:PROCESS:LatticeConstant), Tem_New_DisImage 
////       MatrixTranspose Tem_New_DisImage
       
////       Duplicate/O Tem_New_DisImage root:DispersionIMAGE_1overA:$DisImageName
       
//     Display; AppendImage root:DispersionIMAGE:$DisImageName



	     Endif
      
      
      
      EndIF
       
iDispersion+=1
While (iDispersion<NumberofImages)


Endif

SetDataFolder root:DispersionIMAGE
root:DispersionIMAGE:DispersionFileList= WaveList("!*_CT",";","DIMS:2")


SetDataFolder root:DispersionIMAGE_EbCorrected
root:DispersionIMAGE_EbCorrected:DispersionFileList_Ebcorrected= WaveList("!*_CT",";","DIMS:2")

SetDataFolder curr
End
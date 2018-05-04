#pragma rtGlobals=1		// Use modern global access method.



Proc GetEKxKyIntenTable(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	String TableWindowName="EXYI_"+popStr

	String Curr=GetDataFolder(1)
	
	SetDataFolder root:EKxKyIntensityData
	
////  1.	Select Target File, and find corresponding Theta, Phi, and Omega

	     
	   Variable DimofProcessedImage=DimSize(root:OriginalData:ProcessedImage,0)
	     
//	     Print DimofProcessedImage

//    2. Find corresponding number in the wave, 
//       and Get corresponding Theta, Phi, and Omega for this particular processed Image

      
      Variable iTarget
      Variable RealTheta, TempTheta, TempPhi, TempOmega
      
      Variable iFind=0      
      Do
           
      IF (cmpstr(popStr,root:OriginalData:ProcessedImage[iFind])==0)
      iTarget=iFind
      RealTheta=root:OriginalData:Theta_Angle[iFind]
      TempTheta=root:OriginalData:Theta_Angle[iFind]-root:PROCESS:ThetaOffset
      TempPhi=root:OriginalData:Phi_Angle[iFind]-root:PROCESS:PhiOffset 
      TempOmega=root:PROCESS:RotationAngle   
      
	  EndIF	
	  
	  iFind+=1
	  While (iFind<DimofProcessedImage)
	  
//	  Print "iTarget=", iTarget

      Print "Start getting E-Kx-Ky-Intensity Table......"
	    
	     
//    3.Get Detector Wave
      String TempImgName=root:OriginalData:ProcessedImage[iTarget]
      

      Variable E_Dim=DimSize(root:PROCESS:$TempImgName, 0)  
      Variable E_Min=DimOffset(root:PROCESS:$TempImgName,0)
      Variable E_inc=Round(DimDelta(root:PROCESS:$TempImgName,0)* 1E6)/1E6

      Variable DeAng_Dim=DimSize(root:PROCESS:$TempImgName, 1)  
      Variable DeAng_Min=DimOffset(root:PROCESS:$TempImgName,1)
      Variable DeAng_inc=Round(DimDelta(root:PROCESS:$TempImgName,1)* 1E6)/1E6
            


      //Make angle reference wave
                   Make/O/N=(DeAng_dim) DeAng_Reference
                   Variable ii
                   ii=0
      	           Do
        		       DeAng_Reference[ii]=DeAng_Min+DeAng_inc*ii
        		       ii=ii+1
       	 	       While(ii<DeAng_Dim)

      Duplicate/O DeAng_Reference TempDet_Wave
      TempDet_Wave=root:PROCESS:DetectorCenterAngle-DeAng_Reference	
      
      
      //Make Energy reference wave
                   Make/O/N=(E_dim) E_Reference
                   Variable jj
                   jj=0
      	           Do
        		       E_Reference[jj]=E_Min+E_inc*jj
        		       jj=jj+1
       	 	       While(jj<E_Dim)


//   4. Make Energy, Kx, Ky, and Intensity Waves, Dimension 


    String ThetaName=popStr+"_Theta"
    String EnergyName=popStr+"_E"
    String KxName=popStr+"_Kx"
    String KyName=popStr+"_Ky"
    String IntensityName=popStr+"_Int"
 
    Make/O/N=(DeAng_dim*E_dim) $ThetaName, $EnergyName, $KxName, $KyName, $IntensityName
 
Variable PhotonE=root:PROCESS:PhotonEnergy
Variable WorkFunc=root:Process:WorkFunction
Variable LC=root:PROCESS:LatticeConstant
Variable K0
Variable RAngle=root:PROCESS:RotationAngle

Variable Ky, Kx

Variable i, j

i=0
DO


      j=0
       
      Do 

        $ThetaName[i*DeAng_Dim+j]=RealTheta
        
        $EnergyName[i*DeAng_Dim+j]=E_Reference[i]
        
        K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc+E_Reference[i])        

        Ky=K0*sin(3.1416/180*TempTheta)*cos(3.1416/180*(TempDet_Wave[j]+TempPhi)) 
	    Kx=K0*sin(3.1416/180*(TempDet_Wave[j]+TempPhi))
	    
	    $KxName[i*DeAng_Dim+j]=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+TempOmega*3.1416/180) 
	    
	    $KyName[i*DeAng_Dim+j]=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+TempOmega*3.1416/180) 
	    
        $IntensityName[i*DeAng_Dim+j]=root:PROCESS:$TempImgName[i][j]

       j+=1
       While (j<DeAng_Dim)

i+=1

                     IF ((i/10-Round(i/10))==0)
                     Print i, "/", E_Dim
                     EndIF


WHILE (i<E_Dim)

             DoWindow $TableWindowName
            
             If (V_flag==0)
             
             Edit $ThetaName,$EnergyName,$KxName, $KyName, $IntensityName as TableWindowName

             DoWindow/C $TableWindowName
	         Else
	        		
	         DoWindow/F $TableWindowName
             
             EndIf



SetDataFolder curr

End


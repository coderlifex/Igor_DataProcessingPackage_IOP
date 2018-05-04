#pragma rtGlobals=1		// Use modern global access method.


Proc ShowDispersionImagePiA(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
    String EKImage="E_k"+popStr
    String AttachName=popstr
    Variable GetALLEK=root:PRocess:GetALLEKV
   	
	if(GetallEK==0)
		Variable PFlag=root:PROCESS:ProcessedImageFlag
		Variable PhotonEnergy=root:PROCESS:PhotonEnergy
		Variable WorkFunction=root:PROCESS:WorkFunction
		Variable LatticeConstant=root:PROCESS:LatticeConstant
		Variable PhiOffset=root:PROCESS:PhiOffset
		Variable K0=0.5118*LatticeConstant/3.1416*Sqrt(PhotonEnergy-WorkFunction)
		Newdatafolder/O/S root:DispersionIMAGE
		//NewDatafolder/O/S root:EKImage_Interpolated:Pi_over_a
		Killwaves/A/Z
		Setdatafolder root:OriginalData
		variable loops=Dimsize(ProcessFlag,0)
		Variable ii=0
		Variable jj=0
		Variable hh=0
		Variable tempPhi,MaxK,MinK,MinE,MaxE,LowKn,HighKn
		String TempWaveName,EKName,GraphN
		pauseupdate;silent 1
		ii=0
		do
			if(stringmatch(PopStr,ProcessedImage[ii]))

				Setdatafolder root:OriginalData
			
				TempPhi=Phi_Angle[ii]
				tempWavename=ProcessedImage[ii]
				EKName="ND"+tempWaveName
				setdatafolder root:DispersionIMAGE
				duplicate/O root:PROCESS:$TempWaveName,$EKName
				Make/O/N=(Dimsize($EKName,1)) PhiAngle
				PhiAngle=DimDelta($EKName,1)*x+Dimoffset($EKName,1)
				//Print DimDelta($EKName,1)
				Maxk=K0*sin(pi/180*(TempPhi-PhiOffset-PhiAngle[0]))
				mink=K0*sin(pi/180*(TempPhi-PhiOffset-PhiAngle[dimsize(PhiAngle,0)-1]))
				//print phiangle[0],PhiAngle[dimsize(PhiAngle,0)-1]
				matrixtranspose $EKName
				SetScale/I x maxk, mink, $EKName
				//SetScale/I x mink, maxk, $EKName
				EKImage="E_K"+tempWaveName
				popStr=EKName
				AttachName=EKName
				Break
			endif
			ii=ii+1
		while(ii<loops)	
	endif
   	SetDataFolder root:DispersionIMAGE     
	print EKImage
    DoWindow $EKImage
	if(V_flag==0)
		Display; AppendImage $popStr
       DoWindow/C $EKImage
	   ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
	   Label bottom "\\u#2\\Z14\\f01K// (\\F'Symbol'p\\F'Arial'/a)"
	   Label left "\\Z14\\f01E - E\\BF\\M\\Z14 (eV)"
	   ModifyGraph lsize=2
       ModifyGraph axThick=2,standoff=0
       ModifyGraph fStyle=1  
       ModifyGraph tick=2
       ModifyGraph margin(left)=36
       ModifyGraph margin(top)=7,margin(right)=7
       ModifyGraph width=198.425
       ModifyGraph height={Aspect,1.8}
  //     ModifyGraph width={Aspect,0.5}  
       //ModifyGraph width=0
       Textbox/N=text0/F=0  AttachName
	 else
	   DoWindow/F $EKImage
	 endif  
	        	
		
End	  



Proc ShowDispersionImageEbCorrected(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
    String EKImage="E_kEbC"+popStr
    String AttachName=popstr
   	
	String Curr=GetDataFolder(1)
   	SetDataFolder root:DispersionIMAGE_EbCorrected   

             DoWindow $EKImage
	         if(V_flag==0)
	         
	         Display; AppendImage $popStr
        	  DoWindow/C $EKImage
	         ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
//	         ModifyImage $popStr ctab= {*,*,Terrain,0}

             Label bottom "\\u#2\\Z16K\\B||\\M\\Z16 (\\F'Symbol'p\\F'Times New Roman'/a)"
	         Label left "\\Z14\\f01E - E\\BF\\M\\Z14 (eV)"
	         ModifyGraph lsize=2
                ModifyGraph axThick=2,standoff=0
                ModifyGraph fStyle=1  
                ModifyGraph tick=2
                ModifyGraph margin(left)=36
                ModifyGraph margin(top)=7,margin(right)=7
                ModifyGraph width={Aspect,0.5}  
                Textbox/N=text0/F=0  AttachName
          
	        	else
	        DoWindow/F $EKImage
	        	endif  
	        	
		SetDataFolder Curr
End	       
#pragma rtGlobals=1		// Use modern global access method.


Proc ProIMGDisplayModeSelection(ctrlName,popNum,popStr) : PopupMenuControl
//---------------------------------
	String ctrlName
	Variable popNum
	String popStr
	String Curr=GetDataFolder(1)
	
	if (cmpstr(popStr,"Normal")==0)
       root:PROCESS:ProIMGDisplayMode=0
//       Print "ProIMGDisplayMode=", root:PROCESS:ProIMGDisplayMode, "Normal Display"
	endif
	if (cmpstr(popStr,"Rotate 90")==0)
       root:PROCESS:ProIMGDisplayMode=1
//       Print "ProIMGDisplayMode=", root:PROCESS:ProIMGDisplayMode, "Rotate 90 Degrees"
	endif
		
	SetDataFolder Curr
End




Proc SelectProcessedImage(ctrlName,popNum,popStr) : PopupMenuControl
//-----------------------------
	String ctrlName
	Variable popNum
	String popStr
       String ImageName="IMg"+popStr
       String RotateIMG="R"+popStr
       
       Print ImageName
	
	String Curr=GetDataFolder(1)
	SetDataFolder root:PROCESS
	Variable ImageNameLength=strlen(popStr)
//	Variable Positionoft=strsearch(popStr,"t",0)
//	String ThetaAngleForImage=popStr[Positionoft,ImageNameLength-1]
	String ThetaAngleForImage=popStr
	
	If (root:Process:ProIMGDisplayMode==1)
	Duplicate/O $popStr $RotateIMG
	MatrixTranspose $RotateIMG
	Else
	Endif
	

                 DoWindow $ImageName
	          if(V_flag==0)

					If (root:Process:ProIMGDisplayMode==1)
			              Display/K=1; AppendImage $RotateIMG
//			              ModifyImage $RotateIMG ctab= {*,*,PlanetEarth,1}
			              ModifyImage $RotateIMG ctab= {*,*,Terrain,0}

                               DoWindow/C $ImageName			              
	                           Textbox/N=text0/F=0  ThetaAngleForImage
//	                           TextBox/C/N=text0/A=MT/X=33.96/Y=4.91/E=2 ThetaAngleForImage
					Else
				                Display/K=1; AppendImage $popStr
                               DoWindow/C $ImageName
//	                           ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
	                           ModifyImage $popStr ctab= {*,*,Terrain,0}	                           
	                           Textbox/N=text0/F=0  ThetaAngleForImage
	                           Endif
 		
	          else
	          DoWindow/F $ImageName
	                            RemoveImage/Z $popStr, $RotateIMG
					If (root:Process:ProIMGDisplayMode==1)
			              AppendImage $RotateIMG
//	                           ModifyImage $RotateIMG ctab= {*,*,PlanetEarth,1}
	                            ModifyImage $RotateIMG ctab= {*,*,Terrain,0}
					Else
					AppendImage $popStr
//	                           ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
	                           ModifyImage $popStr ctab= {*,*,Terrain,0}
	                           Endif	          
          
	          endif  

	SetDataFolder Curr
End
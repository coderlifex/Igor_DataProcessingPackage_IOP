#pragma rtGlobals=1		// Use modern global access method.

Proc SelectOriginalImage(ctrlName,popNum,popStr) : PopupMenuControl
//-----------------------------
	String ctrlName
	Variable popNum
	String popStr
      String ImageName="Ori"+popStr
	
	String Curr=GetDataFolder(1)
	SetDataFolder root:OriginalData

                DoWindow $ImageName
	         if(V_flag==0)

	         Display; AppendImage $popStr
        		 DoWindow/C $ImageName
	         ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
 		
	        	else
	        DoWindow/F $ImageName
	        	endif  

		SetDataFolder Curr
End


Proc SelectOriginal1DFile(ctrlName,popNum,popStr) : PopupMenuControl
//-----------------------------
	String ctrlName
	Variable popNum
	String popStr
        String FileName="Ori1D_"+popStr
	
	String Curr=GetDataFolder(1)
	SetDataFolder root:OriginalData

                DoWindow $FileName
	         if(V_flag==0)

	         Display $popStr
        		 DoWindow/C $FileName
 		
	        	else
	        DoWindow/F $FileName
	        	endif  

		SetDataFolder Curr
End      
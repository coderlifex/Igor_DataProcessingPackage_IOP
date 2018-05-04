#pragma rtGlobals=1		// Use modern global access method.


Proc XJZSetParameter() 
       String curr= GetDataFolder(1)
	pauseupdate;silent 1
	Set1DParameter() 	
	Set2DParameter() 
	
      SetDataFolder root:OriginalData	
      root:OriginalData:OriginalFileList=WaveList("A*",";","DIMS:2")
      root:OriginalData:NoofOriginalFile=ItemsinList(OriginalFileList,";")
      root:OriginalData:Original1DFileList=WaveList("A*",";","DIMS:1")      
      root:OriginalData:Noof1DOriginalFile=ItemsinList(Original1DFileList,";") 
      
        	
       SetDataFolder curr

End

Proc SetParameter(ctrlName) : ButtonControl
       String ctrlName
       String curr= GetDataFolder(1)
	

	  Set1DParameter() 
	  Set2DParameter() 
	
	
      SetDataFolder root:OriginalData
      root:OriginalData:OriginalFileList=WaveList("!*_info",";","DIMS:2")
      root:OriginalData:NoofOriginalFile=ItemsinList(OriginalFileList,";")
      root:OriginalData:Original1DFileList=WaveList("A*",";","DIMS:1")      
      root:OriginalData:Noof1DOriginalFile=ItemsinList(Original1DFileList,";") 
      
      	
      SetDataFolder curr

End


Proc SetParameter1D(ctrlName) : ButtonControl
       String ctrlName
       String curr= GetDataFolder(1)
	

	  Set1DParameter() 
	
      SetDataFolder root:OriginalData
      root:OriginalData:OriginalFileList=WaveList("!*_info",";","DIMS:2")
      root:OriginalData:NoofOriginalFile=ItemsinList(OriginalFileList,";")
      root:OriginalData:Original1DFileList=WaveList("A*",";","DIMS:1")      
      root:OriginalData:Noof1DOriginalFile=ItemsinList(Original1DFileList,";") 
      
      	
       SetDataFolder curr

End


Proc SetParameter2D(ctrlName) : ButtonControl
       String ctrlName
       String curr= GetDataFolder(1)
	

	Set2DParameter() 
	
	
      SetDataFolder root:OriginalData
      root:OriginalData:OriginalFileList=WaveList("!*_info",";","DIMS:2")
      root:OriginalData:NoofOriginalFile=ItemsinList(OriginalFileList,";")
      root:OriginalData:Original1DFileList=WaveList("A*",";","DIMS:1")      
      root:OriginalData:Noof1DOriginalFile=ItemsinList(Original1DFileList,";") 
      
      	
       SetDataFolder curr

End



Proc Set1DParameter() 
       String curr= GetDataFolder(1)
       SetDataFolder root:OriginalData
       String Imagefile1DList= WaveList("A*",";","DIMS:1")	                 //Loaded Images
       Variable limit1D=ItemsInList( Imagefile1DList, ";")
       If (limit1D>0)
       Make/O/T/N=(limit1D) Original1DFile, ExperimentNote
       Make/O/N=(limit1D) Theta_Angle1D, Phi_Angle1D, Temperature1D, BLI0_1D

		Variable i1D=0
		String Image1DFile
		Variable/G PhiAngle
		Do
		Image1DFile=StringFromList(i1D,Imagefile1DList,";")
		Original1DFile[i1D]=Image1DFile
	    i1D=i1D+1
	    while (i1D<limit1D)	
	        DoWindow Info1D_Table
	        if(V_flag==0)
	        		Edit Original1DFile, Theta_Angle1D, Phi_Angle1D,Temperature1D, BLI0_1D, ExperimentNote as "1D InformationTable"
	        		DoWindow/C Info1D_Table
	        	else
	        		DoWindow/F Info1D_Table
	        	endif
	        	
	 Else
	 Endif	        	
        	
	        	SetDataFolder curr

End



Proc Set2DParameter() 
    String curr= GetDataFolder(1)
    SetDataFolder root:OriginalData
    String ImagefileList= WaveList("!*_CT",";","DIMS:2")	                 //Loaded Images
	Variable limit=ItemsInList( ImagefileList, ";")
    If (limit>0)
	Make/O/T/N=(limit) OriginalImage, ProcessedImage,ExperimentalNote
//	Make/O/N=(limit) Theta_Angle, Phi_Angle, Omega_Angle, Temperature2D, BLI0_2D,ProcessFlag
	Make/O/N=(limit) Theta_Angle, Phi_Angle, Omega_Angle, Temperature2D, Sweeps,ProcessFlag	
	Make/O/N=(limit) Ef_Correction,Phi_Correction,IntensityScale,DispersionFlag
	Make/O/N=(limit) Ef_Correction,IntensityScale,DispersionFlag

//Set Default IntensityScale==1
      Variable j=0
      Do
      If (IntensityScale[j]==0)
      IntensityScale=1
      Else
      Endif  
      j+=1    
      While (j<Limit)
      
	
		Variable i=0
		String ImageFile
		Variable/G PhiAngle
		
		Do
		    ImageFile=StringFromList(i,ImagefileList,";")
		    OriginalImage[i]=ImageFile
	        i=i+1
	        while (i<limit)	
	        DoWindow Info2D_Table
	        if(V_flag==0)

      		Edit OriginalImage as "2D InformationTable"
      		ModifyTable width(OriginalImage)=100
      		AppendToTable Theta_Angle
      		ModifyTable width(Theta_Angle)=68
      		AppendToTable  Phi_Angle
      		ModifyTable width(Phi_Angle)=64
      		AppendToTable  Omega_Angle
      		ModifyTable width(Omega_Angle)=67  		      		
      		AppendToTable Temperature2D
      		ModifyTable width(Temperature2D)=79
//       	AppendToTable Sweeps
//      		ModifyTable width(Sweeps)=79     		
     		AppendToTable Ef_Correction
//      		AppendToTable Phi_Correction
//      		AppendToTable BLI0_2D
//          ModifyTable width(BLI0_2D)=50
      		AppendToTable IntensityScale
      		ModifyTable width(IntensityScale)=65
      		AppendToTable ProcessFlag
      		ModifyTable width(ProcessFlag)=68
      		AppendToTable ProcessedImage
      		ModifyTable width(ProcessedImage)=88
     		AppendToTable  ExperimentalNote
     		ModifyTable width(ExperimentalNote)=200
//     		AppendToTable DispersionFlag
   
        		DoWindow/C Info2D_Table
	        	else
        		DoWindow/F Info2D_Table
	        	endif
	        	
	        	
	  Else
	  Endif
	        	
        	
	        	SetDataFolder curr

End



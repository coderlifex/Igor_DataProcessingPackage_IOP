#pragma rtGlobals=1		// Use modern global access method.


Proc MomentumMapPanel( )
   
    String Curr=GetDataFolder(1)
	DoWindow/F Momentum_Map_Panel
	if (V_flag==0)
	NewDataFolder/O/S root:MomentumMap
	Variable/G  PhotonEnergy=NumVarOrDefault("root:MomentumMap:PhotonEnergy",100)
	Variable/G  WorkFunction=NumVarOrDefault("root:MomentumMap:WorkFunction",100)
	Variable/G  LatticeConstant=NumVarOrDefault("root:MomentumMap:LatticeConstant",100)
	Variable/G  RotationAngle=NumVarOrDefault("root:MomentumMap:RotationAngle",100)
	Variable/G  ThetaAngle=NumVarOrDefault("root:MomentumMap:ThetaAngle",100)
	Variable/G  PhiAngle=NumVarOrDefault("root:MomentumMap:PhiAngle",100)
	Variable/G  DetectorAngle=NumVarOrDefault("root:MomentumMap:DetectorAngle",100)
    Variable/G  BZShowMode=NumVarOrDefault("root:MomentumMap:BZShowMode",100)
    Variable/G  SSWaveVector=NumVarOrDefault("root:MomentumMap:SSWaveVector",100)
    variable/G  ARToFFlag=NumVarOrDefault("root:MomentumMap:ARToFFlag",0)   
	variable/G	 fromline2artof=NumVarOrDefault("root:MomentumMap:fromline2artof",0) 
	
       Momentum_Map_Panel( )
       Endif
       SetDataFolder Curr	
    
End

Window Momentum_Map_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(605,74,1194,326)
	ModifyPanel cbRGB=(64512,62423,1327)
	SetDrawLayer UserBack
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 10,10,226,241
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 230,10,402,190
	SetDrawEnv fillfgc= (48896,49152,65280)
	DrawRRect 411,10,583,190
	SetDrawEnv fname= "Times New Roman"
	DrawText 155,190,"0-1st Zone"
	SetDrawEnv fname= "Times New Roman"
	DrawText 155,201,"1-2nd Zone"
	SetDrawEnv fname= "Times New Roman"
	DrawText 155,212,"2-Hex Zone"
	SetDrawEnv fillfgc= (65495,2134,34028),fname= "Times New Roman",fsize= 10
	DrawText 276,30,"Bonding_Ori"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 276,53,"Bonding_1S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 276,76,"Bonding_2S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 276,105,"ABonding_Ori"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 276,128,"ABonding_1S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 276,151,"ABonding_2S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 276,180,"ALLOriBands"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 458,30,"BBShadow_Ori"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 458,53,"BBShadow_1S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 458,76,"BBShadow_2S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 458,105,"ABShadow_Ori"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 458,128,"ABShadow_1S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 458,151,"ABShadow_2S"
	SetDrawEnv fname= "Times New Roman",fsize= 10
	DrawText 458,180,"ALLShadow"
	SetVariable set_hv,pos={24,20},size={200,20},title="Photon Energy hv      "
	SetVariable set_hv,font="Times New Roman",fSize=15
	SetVariable set_hv,limits={-inf,inf,0.1},value= root:MomentumMap:PhotonEnergy
	SetVariable set_wfct,pos={24,43},size={200,20},title="Workfunction            "
	SetVariable set_wfct,font="Times New Roman",fSize=15
	SetVariable set_wfct,limits={-inf,inf,0.1},value= root:MomentumMap:WorkFunction
	SetVariable set_LatticeConstant,pos={24,66},size={200,20},proc=SetVarProc,title="Lattice Constant (A) "
	SetVariable set_LatticeConstant,font="Times New Roman",fSize=15
	SetVariable set_LatticeConstant,limits={-inf,inf,0.01},value= root:MomentumMap:LatticeConstant
	SetVariable set_RotationAngle,pos={24,89},size={200,20},proc=SetVarProc,title="Rotation Angle (Deg)"
	SetVariable set_RotationAngle,font="Times New Roman",fSize=15
	SetVariable set_RotationAngle,limits={-inf,inf,0.1},value= root:MomentumMap:RotationAngle
	SetVariable set_ThetaAngle,pos={24,112},size={200,20},proc=SetVarProc,title="Theta Angle (Deg)   "
	SetVariable set_ThetaAngle,font="Times New Roman",fSize=15
	SetVariable set_ThetaAngle,limits={-inf,inf,0.1},value= root:MomentumMap:ThetaAngle
	SetVariable set_PhiAngle,pos={24,135},size={200,20},proc=SetVarProc,title="Phi Angle (Deg)       "
	SetVariable set_PhiAngle,font="Times New Roman",fSize=15
	SetVariable set_PhiAngle,limits={-inf,inf,0.1},value= root:MomentumMap:PhiAngle
	SetVariable set_DetectorAngle,pos={24,158},size={200,20},proc=SetVarProc,title="DetectorAngle (Deg)"
	SetVariable set_DetectorAngle,font="Times New Roman",fSize=15
	SetVariable set_DetectorAngle,limits={-inf,inf,0.1},value= root:MomentumMap:DetectorAngle
	SetVariable Set_BZShowMode,pos={24,184},size={115,20},title="Which BZ?"
	SetVariable Set_BZShowMode,font="Times New Roman",fSize=15
	SetVariable Set_BZShowMode,limits={0,2,1},value= root:MomentumMap:BZShowMode
	Button CalculateMap,pos={13,206},size={140,32},proc=CalculateMap,title="Get K Location"
	Button CalculateMap,font="Times New Roman",fSize=14
	Button Add_Ori_Bondingband,pos={235,15},size={40,20},proc=Add_Ori_BondingBand,title="Add"
	Button Add_Ori_Bondingband,font="Times New Roman",fSize=14
	Button Remove_Ori_Bondingband,pos={338,15},size={60,20},proc=Remove_Ori_BondingBand,title="Remove"
	Button Remove_Ori_Bondingband,font="Times New Roman",fSize=14
	Button Add_1stOrderS_Bondingband,pos={235,38},size={40,20},proc=Add_1stOrderS_BondingBand,title="Add"
	Button Add_1stOrderS_Bondingband,font="Times New Roman",fSize=14
	Button Remove_1stOrderS_Bondingband,pos={338,38},size={60,20},proc=Remove_1stOrderS_BondingBand,title="Remove"
	Button Remove_1stOrderS_Bondingband,font="Times New Roman",fSize=14
	Button Add_2ndOrderS_Bondingband,pos={235,61},size={40,20},proc=Add_2ndOrderS_BondingBand,title="Add"
	Button Add_2ndOrderS_Bondingband,font="Times New Roman",fSize=14
	Button Remove_2ndOrderS_Bondingband,pos={338,61},size={60,20},proc=Remove_2ndOrderS_BondingBand,title="Remove"
	Button Remove_2ndOrderS_Bondingband,font="Times New Roman",fSize=14
	Button Add_Ori_AntiBondingband,pos={235,90},size={40,20},proc=Add_Ori_ABondingBand,title="Add"
	Button Add_Ori_AntiBondingband,font="Times New Roman",fSize=14
	Button Remove_Ori_ABondingband,pos={338,90},size={60,20},proc=Remove_Ori_ABondingBand,title="Remove"
	Button Remove_Ori_ABondingband,font="Times New Roman",fSize=14
	Button Add_1stOrderS_AntiBondingband,pos={235,113},size={40,20},proc=Add_1stOrderS_ABondingBand,title="Add"
	Button Add_1stOrderS_AntiBondingband,font="Times New Roman",fSize=14
	Button Remove_1stOrderS_ABondingband,pos={338,113},size={60,20},proc=Remove_1stOrderS_ABondingBand,title="Remove"
	Button Remove_1stOrderS_ABondingband,font="Times New Roman",fSize=14
	Button Add_2ndOrderS_AntiBondingband,pos={235,136},size={40,20},proc=Add_2ndOrderS_ABondingBand,title="Add"
	Button Add_2ndOrderS_AntiBondingband,font="Times New Roman",fSize=14
	Button Remove_2ndOrderS_ABondingband,pos={338,136},size={60,20},proc=Remove_2ndOrderS_ABondingBand,title="Remove"
	Button Remove_2ndOrderS_ABondingband,font="Times New Roman",fSize=14
	Button Add_ALLOriBand,pos={235,165},size={40,20},proc=Add_ALLOriBand,title="Add"
	Button Add_ALLOriBand,font="Times New Roman",fSize=14
	Button Remove_ALLOriBand,pos={338,165},size={60,20},proc=Remove_ALLOriBand,title="Remove"
	Button Remove_ALLOriBand,font="Times New Roman",fSize=14
	Button Add_Ori_BBShadowband,pos={417,15},size={40,20},proc=Add_Ori_BBShadowBand,title="Add"
	Button Add_Ori_BBShadowband,font="Times New Roman",fSize=14
	Button Remove_Ori_BBShadowband,pos={523,15},size={60,20},proc=Remove_Ori_BBShadowBand,title="Remove"
	Button Remove_Ori_BBShadowband,font="Times New Roman",fSize=14
	Button Add_1stOrderS_BBShadowband,pos={417,38},size={40,20},proc=Add_1stOrderS_BBShadowBand,title="Add"
	Button Add_1stOrderS_BBShadowband,font="Times New Roman",fSize=14
	Button Remove_1stOrderS_BBShadowband,pos={523,38},size={60,20},proc=Remove_1stOrderS_BBShadowBand,title="Remove"
	Button Remove_1stOrderS_BBShadowband,font="Times New Roman",fSize=14
	Button Add_2ndOrderS_BBShadowband,pos={417,61},size={40,20},proc=Add_2ndOrderS_BBShadowBand,title="Add"
	Button Add_2ndOrderS_BBShadowband,font="Times New Roman",fSize=14
	Button Remove_2ndOrderS_BBShadowband,pos={523,61},size={60,20},proc=Remove_2ndOrderS_BBShadowBand,title="Remove"
	Button Remove_2ndOrderS_BBShadowband,font="Times New Roman",fSize=14
	Button Add_Ori_ABShadowband,pos={417,90},size={40,20},proc=Add_Ori_ABShadowBand,title="Add"
	Button Add_Ori_ABShadowband,font="Times New Roman",fSize=14
	Button Remove_Ori_ABShadowband,pos={523,90},size={60,20},proc=Remove_Ori_ABShadowBand,title="Remove"
	Button Remove_Ori_ABShadowband,font="Times New Roman",fSize=14
	Button Add_1stOrderS_ABShadowband,pos={417,113},size={40,20},proc=Add_1stOrderS_ABShadowBand,title="Add"
	Button Add_1stOrderS_ABShadowband,font="Times New Roman",fSize=14
	Button Remove_1stOrderS_ABShadowband,pos={523,113},size={60,20},proc=Remove_1stOrderS_ABShadowBand,title="Remove"
	Button Remove_1stOrderS_ABShadowband,font="Times New Roman",fSize=14
	Button Add_2ndOrderS_ABShadowband,pos={417,136},size={40,20},proc=Add_2ndOrderS_ABShadowBand,title="Add"
	Button Add_2ndOrderS_ABShadowband,font="Times New Roman",fSize=14
	Button Remove_2ndOrderS_ABShadowband,pos={523,136},size={60,20},proc=Remove_2ndOrderS_ABShadowBand,title="Remove"
	Button Remove_2ndOrderS_ABShadowband,font="Times New Roman",fSize=14
	Button Add_AllShadowBand,pos={417,165},size={40,20},proc=Add_ALLShadowBand,title="Add"
	Button Add_AllShadowBand,font="Times New Roman",fSize=14
	Button Remove_ALLShadowBand,pos={523,165},size={60,20},proc=Remove_ALLShadowBand,title="Remove"
	Button Remove_ALLShadowBand,font="Times New Roman",fSize=14
	SetVariable set_SWaveVector,pos={235,210},size={150,20},title="SSWavevector "
	SetVariable set_SWaveVector,font="Times New Roman",fSize=14
	SetVariable set_SWaveVector,limits={0,inf,0.1},value= root:MomentumMap:SSWaveVector
	Button MakeFermiSurface,pos={410,200},size={120,40},proc=MakeFermiSurface,title="MakeFermiSurface"
	Button MakeFermiSurface,font="Times New Roman",fSize=14
	Button kMapDone,pos={535,200},size={50,40},proc=kMapDoneButton,title="DONE"
	Button kMapDone,font="Times New Roman",fSize=14
	CheckBox artof,pos={164,218},size={48,14},proc=fromlinetoartof,title="ARToF"
	CheckBox artof,variable= root:MomentumMap:ARToFFlag
EndMacro


Function MakeFermiSurface(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	SetDatafolder root:MomentumMap	
	
	Make/O BondingBand_KX
    Make/O BondingBand_KY
    
    Make/O AntiBondingBand_KX
    Make/O AntiBondingBand_KY
    
     DoWindow OriFermiSurface_Table
	        if(V_flag==0)
	        		Edit BondingBand_KX, BondingBand_KY, AntiBondingBand_KX, AntiBondingBand_KY as "Make Fermi Surface"
	        		DoWindow/C OriFermiSurface_Table
	        	else
	        		DoWindow/F OriFermiSurface_Table
	        	endif
    
  
	SetDataFolder Curr
	
End



Proc CalBi2212FermiSurface()

	String Curr=GetDataFolder(1)
	
	SetDatafolder root:MomentumMap	


////Make Umklapp Bands***************************************

//(1). Bonding Fermi surface around (pi,pi).

	 Make/O Bi2212FS_BB_8_Kx={0.188,0.189,0.189,0.189,0.189,0.191,0.192,0.196,0.201,0.208,0.214,0.222,0.234,0.247,0.260,0.274,0.289,0.304,0.320,0.335,0.349,0.369}
     Make/O Bi2212FS_BB_8_Ky={1.000,0.922,0.889,0.857,0.824,0.790,0.763,0.730,0.695,0.660,0.636,0.607,0.576,0.545,0.516,0.489,0.467,0.446,0.424,0.404,0.387,0.370}



//  ExpandFermiSurface(FirstKx_1BZ, FirstKy_1BZ, "1BZ")
////   ExpandFermiSurface2(BondingBand_KX, BondingBand_KY, "1BZ")


    Make/O/N=44 Bi2212FS_BB_4_Ky, Bi2212FS_BB_4_Kx
    Variable BB4i=0
    Do
    Bi2212FS_BB_4_Kx[BB4i]=Bi2212FS_BB_8_Kx[BB4i]
    Bi2212FS_BB_4_Ky[BB4i]=Bi2212FS_BB_8_Ky[BB4i]  
    Bi2212FS_BB_4_Kx[BB4i+22]=Bi2212FS_BB_8_Ky[21-BB4i]
    Bi2212FS_BB_4_Ky[BB4i+22]=Bi2212FS_BB_8_Kx[21-BB4i]      
    BB4i+=1
    While (BB4i<22)
    

    Make/O/N=88 Bi2212FS_BB_2_Ky, Bi2212FS_BB_2_Kx
    Variable BB2i=0
    Do    
    Bi2212FS_BB_2_Kx[BB2i]=Bi2212FS_BB_4_Kx[BB2i]
    Bi2212FS_BB_2_Ky[BB2i]=Bi2212FS_BB_4_Ky[BB2i]  
    Bi2212FS_BB_2_Kx[BB2i+44]=2-Bi2212FS_BB_4_Kx[43-BB2i]
    Bi2212FS_BB_2_Ky[BB2i+44]=Bi2212FS_BB_4_Ky[43-BB2i]      
    BB2i+=1
    While (BB2i<44)
    
    
    Make/O/N=176 Bi2212FS_BB_1_Ky, Bi2212FS_BB_1_Kx
    Variable BB1i=0
    Do
    Bi2212FS_BB_1_Kx[BB1i]=Bi2212FS_BB_2_Kx[BB1i]
    Bi2212FS_BB_1_Ky[BB1i]=Bi2212FS_BB_2_Ky[BB1i]  
    Bi2212FS_BB_1_Kx[BB1i+88]=Bi2212FS_BB_2_Kx[87-BB1i]
    Bi2212FS_BB_1_Ky[BB1i+88]=2-Bi2212FS_BB_2_Ky[87-BB1i]            
    BB1i+=1
    While (BB1i<88)   
    
    
 
 
////Make Original Bonding Fermi Surface    
    Duplicate/O Bi2212FS_BB_1_Kx  Bi2212FS_BB_Ori1_X     
    Duplicate/O Bi2212FS_BB_1_Ky  Bi2212FS_BB_Ori1_Y
  
    Duplicate/O Bi2212FS_BB_1_Kx  Bi2212FS_BB_Ori2_X 
    Bi2212FS_BB_Ori2_X = Bi2212FS_BB_1_Kx - 2 
    Duplicate/O Bi2212FS_BB_1_Ky  Bi2212FS_BB_Ori2_Y
	            
    Duplicate/O Bi2212FS_BB_1_Kx  Bi2212FS_BB_Ori3_X 
    Bi2212FS_BB_Ori3_X = Bi2212FS_BB_1_Kx - 2 
    Duplicate/O Bi2212FS_BB_1_Ky  Bi2212FS_BB_Ori3_Y	            
    Bi2212FS_BB_Ori3_Y = Bi2212FS_BB_1_Ky - 2 	            
	            
    Duplicate/O Bi2212FS_BB_1_Kx  Bi2212FS_BB_Ori4_X 
    Bi2212FS_BB_Ori4_X = Bi2212FS_BB_1_Kx - 0
    Duplicate/O Bi2212FS_BB_1_Ky  Bi2212FS_BB_Ori4_Y	            
    Bi2212FS_BB_Ori4_Y = Bi2212FS_BB_1_Ky - 2 	
    
    
    //Duplicate/O FirstFS_1BZx  Bi2212FS_BB_Ori1_X     
    //Duplicate/O FirstFS_1BZy  Bi2212FS_BB_Ori1_Y
  
    //Duplicate/O SecondFS_1BZx  Bi2212FS_BB_Ori2_X 
    //Duplicate/O SecondFS_1BZy  Bi2212FS_BB_Ori2_Y
	            
    //Duplicate/O ThirdFS_1BZx  Bi2212FS_BB_Ori3_X 
    //Duplicate/O ThirdFS_1BZy  Bi2212FS_BB_Ori3_Y	                   
	            
    //Duplicate/O FourthFS_1BZx  Bi2212FS_BB_Ori4_X 
    //Duplicate/O FourthFS_1BZy  Bi2212FS_BB_Ori4_Y	             	
    
    
 
 ////Make First-Order Superstructure Bonding Fermi Surface 
    Variable S1Vector=root:MomentumMap:SSWaveVector
   

//Left Side First Order Superstructure Band

    Duplicate/O Bi2212FS_BB_Ori1_X   SS1L_Bi2212FS_BB_Ori1_X  
    SS1L_Bi2212FS_BB_Ori1_X=Bi2212FS_BB_Ori1_X - 1*S1Vector
    Duplicate/O Bi2212FS_BB_Ori1_Y   SS1L_Bi2212FS_BB_Ori1_Y
    SS1L_Bi2212FS_BB_Ori1_Y=Bi2212FS_BB_Ori1_Y - 1*S1Vector
    

    Duplicate/O Bi2212FS_BB_Ori2_X   SS1L_Bi2212FS_BB_Ori2_X 
    SS1L_Bi2212FS_BB_Ori2_X=Bi2212FS_BB_Ori2_X - 1*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori2_Y   SS1L_Bi2212FS_BB_Ori2_Y
    SS1L_Bi2212FS_BB_Ori2_Y=Bi2212FS_BB_Ori2_Y - 1*S1Vector
      
      
    Duplicate/O Bi2212FS_BB_Ori3_X   SS1L_Bi2212FS_BB_Ori3_X 
    SS1L_Bi2212FS_BB_Ori3_X=Bi2212FS_BB_Ori3_X - 1*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori3_Y   SS1L_Bi2212FS_BB_Ori3_Y
    SS1L_Bi2212FS_BB_Ori3_Y=Bi2212FS_BB_Ori3_Y - 1*S1Vector
    
    Duplicate/O Bi2212FS_BB_Ori4_X   SS1L_Bi2212FS_BB_Ori4_X 
    SS1L_Bi2212FS_BB_Ori4_X=Bi2212FS_BB_Ori4_X - 1*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori4_Y   SS1L_Bi2212FS_BB_Ori4_Y
    SS1L_Bi2212FS_BB_Ori4_Y=Bi2212FS_BB_Ori4_Y - 1*S1Vector  
    

//Right Side First Order Superstructure Band

    Duplicate/O Bi2212FS_BB_Ori1_X   SS1R_Bi2212FS_BB_Ori1_X  
    SS1R_Bi2212FS_BB_Ori1_X=Bi2212FS_BB_Ori1_X + 1*S1Vector
    Duplicate/O Bi2212FS_BB_Ori1_Y   SS1R_Bi2212FS_BB_Ori1_Y
    SS1R_Bi2212FS_BB_Ori1_Y=Bi2212FS_BB_Ori1_Y + 1*S1Vector
    

    Duplicate/O Bi2212FS_BB_Ori2_X   SS1R_Bi2212FS_BB_Ori2_X 
    SS1R_Bi2212FS_BB_Ori2_X=Bi2212FS_BB_Ori2_X + 1*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori2_Y   SS1R_Bi2212FS_BB_Ori2_Y
    SS1R_Bi2212FS_BB_Ori2_Y=Bi2212FS_BB_Ori2_Y + 1*S1Vector
      
      
    Duplicate/O Bi2212FS_BB_Ori3_X   SS1R_Bi2212FS_BB_Ori3_X 
    SS1R_Bi2212FS_BB_Ori3_X=Bi2212FS_BB_Ori3_X + 1*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori3_Y   SS1R_Bi2212FS_BB_Ori3_Y
    SS1R_Bi2212FS_BB_Ori3_Y=Bi2212FS_BB_Ori3_Y + 1*S1Vector
    
    Duplicate/O Bi2212FS_BB_Ori4_X   SS1R_Bi2212FS_BB_Ori4_X 
    SS1R_Bi2212FS_BB_Ori4_X=Bi2212FS_BB_Ori4_X + 1*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori4_Y   SS1R_Bi2212FS_BB_Ori4_Y
    SS1R_Bi2212FS_BB_Ori4_Y=Bi2212FS_BB_Ori4_Y + 1*S1Vector   
    



////Make Second-Order Superstructure Bonding Fermi Surface 
  

//Left Side Second Order Superstructure Band

    Duplicate/O Bi2212FS_BB_Ori1_X   SS2L_Bi2212FS_BB_Ori1_X  
    SS2L_Bi2212FS_BB_Ori1_X=Bi2212FS_BB_Ori1_X - 2*S1Vector
    Duplicate/O Bi2212FS_BB_Ori1_Y   SS2L_Bi2212FS_BB_Ori1_Y
    SS2L_Bi2212FS_BB_Ori1_Y=Bi2212FS_BB_Ori1_Y - 2*S1Vector
    

    Duplicate/O Bi2212FS_BB_Ori2_X   SS2L_Bi2212FS_BB_Ori2_X 
    SS2L_Bi2212FS_BB_Ori2_X=Bi2212FS_BB_Ori2_X - 2*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori2_Y   SS2L_Bi2212FS_BB_Ori2_Y
    SS2L_Bi2212FS_BB_Ori2_Y=Bi2212FS_BB_Ori2_Y - 2*S1Vector
      
      
    Duplicate/O Bi2212FS_BB_Ori3_X   SS2L_Bi2212FS_BB_Ori3_X 
    SS2L_Bi2212FS_BB_Ori3_X=Bi2212FS_BB_Ori3_X - 2*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori3_Y   SS2L_Bi2212FS_BB_Ori3_Y
    SS2L_Bi2212FS_BB_Ori3_Y=Bi2212FS_BB_Ori3_Y - 2*S1Vector
    
    Duplicate/O Bi2212FS_BB_Ori4_X   SS2L_Bi2212FS_BB_Ori4_X 
    SS2L_Bi2212FS_BB_Ori4_X=Bi2212FS_BB_Ori4_X - 2*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori4_Y   SS2L_Bi2212FS_BB_Ori4_Y
    SS2L_Bi2212FS_BB_Ori4_Y=Bi2212FS_BB_Ori4_Y - 2*S1Vector  
    

//Right Side Second Order Superstructure Band

    Duplicate/O Bi2212FS_BB_Ori1_X   SS2R_Bi2212FS_BB_Ori1_X  
    SS2R_Bi2212FS_BB_Ori1_X=Bi2212FS_BB_Ori1_X + 2*S1Vector
    Duplicate/O Bi2212FS_BB_Ori1_Y   SS2R_Bi2212FS_BB_Ori1_Y
    SS2R_Bi2212FS_BB_Ori1_Y=Bi2212FS_BB_Ori1_Y + 2*S1Vector
    

    Duplicate/O Bi2212FS_BB_Ori2_X   SS2R_Bi2212FS_BB_Ori2_X 
    SS2R_Bi2212FS_BB_Ori2_X=Bi2212FS_BB_Ori2_X + 2*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori2_Y   SS2R_Bi2212FS_BB_Ori2_Y
    SS2R_Bi2212FS_BB_Ori2_Y=Bi2212FS_BB_Ori2_Y + 2*S1Vector
      
      
    Duplicate/O Bi2212FS_BB_Ori3_X   SS2R_Bi2212FS_BB_Ori3_X 
    SS2R_Bi2212FS_BB_Ori3_X=Bi2212FS_BB_Ori3_X + 2*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori3_Y   SS2R_Bi2212FS_BB_Ori3_Y
    SS2R_Bi2212FS_BB_Ori3_Y=Bi2212FS_BB_Ori3_Y + 2*S1Vector
    
    Duplicate/O Bi2212FS_BB_Ori4_X   SS2R_Bi2212FS_BB_Ori4_X 
    SS2R_Bi2212FS_BB_Ori4_X=Bi2212FS_BB_Ori4_X + 2*S1Vector  
    Duplicate/O Bi2212FS_BB_Ori4_Y   SS2R_Bi2212FS_BB_Ori4_Y
    SS2R_Bi2212FS_BB_Ori4_Y=Bi2212FS_BB_Ori4_Y + 2*S1Vector   
    
    
       
       	            
	            
	
	
//(2). Anti-Bonding Fermi surface around (pi,pi).

	Make/O Bi2212FS_AB_8_Kx={0.097,0.104,0.111,0.130,0.146,0.169,0.193,0.221,0.254,0.282,0.308,0.336,0.360}
    Make/O Bi2212FS_AB_8_Ky={1.000,0.925,0.863,0.787,0.724,0.665,0.606,0.551,0.494,0.452,0.424,0.387,0.363}

    Make/O/N=26 Bi2212FS_AB_4_Ky, Bi2212FS_AB_4_Kx
    Variable AB4i=0
    Do
    Bi2212FS_AB_4_Kx[AB4i]=Bi2212FS_AB_8_Kx[AB4i]
    Bi2212FS_AB_4_Ky[AB4i]=Bi2212FS_AB_8_Ky[AB4i]  
    Bi2212FS_AB_4_Kx[AB4i+13]=Bi2212FS_AB_8_Ky[12-AB4i]
    Bi2212FS_AB_4_Ky[AB4i+13]=Bi2212FS_AB_8_Kx[12-AB4i]      
    AB4i+=1
    While (AB4i<13)
    

    Make/O/N=52 Bi2212FS_AB_2_Ky, Bi2212FS_AB_2_Kx
    Variable AB2i=0
    Do    
    Bi2212FS_AB_2_Kx[AB2i]=Bi2212FS_AB_4_Kx[AB2i]
    Bi2212FS_AB_2_Ky[AB2i]=Bi2212FS_AB_4_Ky[AB2i]  
    Bi2212FS_AB_2_Kx[AB2i+26]=2-Bi2212FS_AB_4_Kx[25-AB2i]
    Bi2212FS_AB_2_Ky[AB2i+26]=Bi2212FS_AB_4_Ky[25-AB2i]      
    AB2i+=1
    While (AB2i<26)
    
    
    Make/O/N=104 Bi2212FS_AB_1_Ky, Bi2212FS_AB_1_Kx
    Variable AB1i=0
    Do
    Bi2212FS_AB_1_Kx[AB1i]=Bi2212FS_AB_2_Kx[AB1i]
    Bi2212FS_AB_1_Ky[AB1i]=Bi2212FS_AB_2_Ky[AB1i]  
    Bi2212FS_AB_1_Kx[AB1i+52]=Bi2212FS_AB_2_Kx[51-AB1i]
    Bi2212FS_AB_1_Ky[AB1i+52]=2-Bi2212FS_AB_2_Ky[51-AB1i]            
    AB1i+=1
    While (AB1i<52)   
    
    
 ////Make Original Anti-Bonding Fermi Surface    
    Duplicate/O Bi2212FS_AB_1_Kx  Bi2212FS_AB_Ori1_X     
    Duplicate/O Bi2212FS_AB_1_Ky  Bi2212FS_AB_Ori1_Y
  
    Duplicate/O Bi2212FS_AB_1_Kx  Bi2212FS_AB_Ori2_X 
    Bi2212FS_AB_Ori2_X = Bi2212FS_AB_1_Kx - 2 
    Duplicate/O Bi2212FS_AB_1_Ky  Bi2212FS_AB_Ori2_Y
	            
    Duplicate/O Bi2212FS_AB_1_Kx  Bi2212FS_AB_Ori3_X 
    Bi2212FS_AB_Ori3_X = Bi2212FS_AB_1_Kx - 2 
    Duplicate/O Bi2212FS_AB_1_Ky  Bi2212FS_AB_Ori3_Y	            
    Bi2212FS_AB_Ori3_Y = Bi2212FS_AB_1_Ky - 2 	            
	            
    Duplicate/O Bi2212FS_AB_1_Kx  Bi2212FS_AB_Ori4_X 
    Bi2212FS_AB_Ori4_X = Bi2212FS_AB_1_Kx - 0
    Duplicate/O Bi2212FS_AB_1_Ky  Bi2212FS_AB_Ori4_Y	            
    Bi2212FS_AB_Ori4_Y = Bi2212FS_AB_1_Ky - 2 	   	
	
	

 ////Make First-Order Superstructure Anti-Bonding Fermi Surface 
   

//Left Side First Order Superstructure Anti-Bonding Band

    Duplicate/O Bi2212FS_AB_Ori1_X   SS1L_Bi2212FS_AB_Ori1_X  
    SS1L_Bi2212FS_AB_Ori1_X=Bi2212FS_AB_Ori1_X - 1*S1Vector
    Duplicate/O Bi2212FS_AB_Ori1_Y   SS1L_Bi2212FS_AB_Ori1_Y
    SS1L_Bi2212FS_AB_Ori1_Y=Bi2212FS_AB_Ori1_Y - 1*S1Vector
    

    Duplicate/O Bi2212FS_AB_Ori2_X   SS1L_Bi2212FS_AB_Ori2_X 
    SS1L_Bi2212FS_AB_Ori2_X=Bi2212FS_AB_Ori2_X - 1*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori2_Y   SS1L_Bi2212FS_AB_Ori2_Y
    SS1L_Bi2212FS_AB_Ori2_Y=Bi2212FS_AB_Ori2_Y - 1*S1Vector
      
      
    Duplicate/O Bi2212FS_AB_Ori3_X   SS1L_Bi2212FS_AB_Ori3_X 
    SS1L_Bi2212FS_AB_Ori3_X=Bi2212FS_AB_Ori3_X - 1*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori3_Y   SS1L_Bi2212FS_AB_Ori3_Y
    SS1L_Bi2212FS_AB_Ori3_Y=Bi2212FS_AB_Ori3_Y - 1*S1Vector
    
    Duplicate/O Bi2212FS_AB_Ori4_X   SS1L_Bi2212FS_AB_Ori4_X 
    SS1L_Bi2212FS_AB_Ori4_X=Bi2212FS_AB_Ori4_X - 1*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori4_Y   SS1L_Bi2212FS_AB_Ori4_Y
    SS1L_Bi2212FS_AB_Ori4_Y=Bi2212FS_AB_Ori4_Y - 1*S1Vector  
    

//Right Side First Order Superstructure Anti-Bonding Band

    Duplicate/O Bi2212FS_AB_Ori1_X   SS1R_Bi2212FS_AB_Ori1_X  
    SS1R_Bi2212FS_AB_Ori1_X=Bi2212FS_AB_Ori1_X + 1*S1Vector
    Duplicate/O Bi2212FS_AB_Ori1_Y   SS1R_Bi2212FS_AB_Ori1_Y
    SS1R_Bi2212FS_AB_Ori1_Y=Bi2212FS_AB_Ori1_Y + 1*S1Vector
    

    Duplicate/O Bi2212FS_AB_Ori2_X   SS1R_Bi2212FS_AB_Ori2_X 
    SS1R_Bi2212FS_AB_Ori2_X=Bi2212FS_AB_Ori2_X + 1*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori2_Y   SS1R_Bi2212FS_AB_Ori2_Y
    SS1R_Bi2212FS_AB_Ori2_Y=Bi2212FS_AB_Ori2_Y + 1*S1Vector
      
      
    Duplicate/O Bi2212FS_AB_Ori3_X   SS1R_Bi2212FS_AB_Ori3_X 
    SS1R_Bi2212FS_AB_Ori3_X=Bi2212FS_AB_Ori3_X + 1*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori3_Y   SS1R_Bi2212FS_AB_Ori3_Y
    SS1R_Bi2212FS_AB_Ori3_Y=Bi2212FS_AB_Ori3_Y + 1*S1Vector
    
    Duplicate/O Bi2212FS_AB_Ori4_X   SS1R_Bi2212FS_AB_Ori4_X 
    SS1R_Bi2212FS_AB_Ori4_X=Bi2212FS_AB_Ori4_X + 1*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori4_Y   SS1R_Bi2212FS_AB_Ori4_Y
    SS1R_Bi2212FS_AB_Ori4_Y=Bi2212FS_AB_Ori4_Y + 1*S1Vector   
    



////Make Second-Order Superstructure Anti-Bonding Fermi Surface 
  

//Left Side Second Order Superstructure Anti-Bonding Band

    Duplicate/O Bi2212FS_AB_Ori1_X   SS2L_Bi2212FS_AB_Ori1_X  
    SS2L_Bi2212FS_AB_Ori1_X=Bi2212FS_AB_Ori1_X - 2*S1Vector
    Duplicate/O Bi2212FS_AB_Ori1_Y   SS2L_Bi2212FS_AB_Ori1_Y
    SS2L_Bi2212FS_AB_Ori1_Y=Bi2212FS_AB_Ori1_Y - 2*S1Vector
    

    Duplicate/O Bi2212FS_AB_Ori2_X   SS2L_Bi2212FS_AB_Ori2_X 
    SS2L_Bi2212FS_AB_Ori2_X=Bi2212FS_AB_Ori2_X - 2*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori2_Y   SS2L_Bi2212FS_AB_Ori2_Y
    SS2L_Bi2212FS_AB_Ori2_Y=Bi2212FS_AB_Ori2_Y - 2*S1Vector
      
      
    Duplicate/O Bi2212FS_AB_Ori3_X   SS2L_Bi2212FS_AB_Ori3_X 
    SS2L_Bi2212FS_AB_Ori3_X=Bi2212FS_AB_Ori3_X - 2*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori3_Y   SS2L_Bi2212FS_AB_Ori3_Y
    SS2L_Bi2212FS_AB_Ori3_Y=Bi2212FS_AB_Ori3_Y - 2*S1Vector
    
    Duplicate/O Bi2212FS_AB_Ori4_X   SS2L_Bi2212FS_AB_Ori4_X 
    SS2L_Bi2212FS_AB_Ori4_X=Bi2212FS_AB_Ori4_X - 2*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori4_Y   SS2L_Bi2212FS_AB_Ori4_Y
    SS2L_Bi2212FS_AB_Ori4_Y=Bi2212FS_AB_Ori4_Y - 2*S1Vector  
    

//Right Side Second Order Superstructure Anti-Bonding Band

    Duplicate/O Bi2212FS_AB_Ori1_X   SS2R_Bi2212FS_AB_Ori1_X  
    SS2R_Bi2212FS_AB_Ori1_X=Bi2212FS_AB_Ori1_X + 2*S1Vector
    Duplicate/O Bi2212FS_AB_Ori1_Y   SS2R_Bi2212FS_AB_Ori1_Y
    SS2R_Bi2212FS_AB_Ori1_Y=Bi2212FS_AB_Ori1_Y + 2*S1Vector
    

    Duplicate/O Bi2212FS_AB_Ori2_X   SS2R_Bi2212FS_AB_Ori2_X 
    SS2R_Bi2212FS_AB_Ori2_X=Bi2212FS_AB_Ori2_X + 2*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori2_Y   SS2R_Bi2212FS_AB_Ori2_Y
    SS2R_Bi2212FS_AB_Ori2_Y=Bi2212FS_AB_Ori2_Y + 2*S1Vector
      
      
    Duplicate/O Bi2212FS_AB_Ori3_X   SS2R_Bi2212FS_AB_Ori3_X 
    SS2R_Bi2212FS_AB_Ori3_X=Bi2212FS_AB_Ori3_X + 2*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori3_Y   SS2R_Bi2212FS_AB_Ori3_Y
    SS2R_Bi2212FS_AB_Ori3_Y=Bi2212FS_AB_Ori3_Y + 2*S1Vector
    
    Duplicate/O Bi2212FS_AB_Ori4_X   SS2R_Bi2212FS_AB_Ori4_X 
    SS2R_Bi2212FS_AB_Ori4_X=Bi2212FS_AB_Ori4_X + 2*S1Vector  
    Duplicate/O Bi2212FS_AB_Ori4_Y   SS2R_Bi2212FS_AB_Ori4_Y
    SS2R_Bi2212FS_AB_Ori4_Y=Bi2212FS_AB_Ori4_Y + 2*S1Vector  
    
    
    
    
////Make Shadow Bands***************************************
  
    ////Make Original Bonding Shadow Fermi Surface   
    
    
    
    Duplicate/O Bi2212FS_BB_Ori1_X   Bi2212FS_BB_OriShadow_X     
    Duplicate/O Bi2212FS_BB_Ori1_Y   Bi2212FS_BB_OriShadow_Y
    Bi2212FS_BB_OriShadow_X=Bi2212FS_BB_Ori1_X-1
    Bi2212FS_BB_OriShadow_Y=Bi2212FS_BB_Ori1_Y-1 
    
    
////Make First-Order Superstructure Bonding Shadow Fermi Surface 
////Variable S1Vector=0.21
   

//Left Side First Order Superstructure Shadow Band

    Duplicate/O Bi2212FS_BB_OriShadow_X   SS1L_Bi2212FS_BB_OriShadow_X  
    SS1L_Bi2212FS_BB_OriShadow_X=Bi2212FS_BB_OriShadow_X - 1*S1Vector
    
    
    
    Duplicate/O Bi2212FS_BB_OriShadow_Y   SS1L_Bi2212FS_BB_OriShadow_Y
    SS1L_Bi2212FS_BB_OriShadow_Y=Bi2212FS_BB_OriShadow_Y - 1*S1Vector
    

//Right Side First Order Superstructure Shadow Band

    Duplicate/O Bi2212FS_BB_OriShadow_X   SS1R_Bi2212FS_BB_OriShadow_X  
    SS1R_Bi2212FS_BB_OriShadow_X=Bi2212FS_BB_OriShadow_X + 1*S1Vector
    
    Duplicate/O Bi2212FS_BB_OriShadow_Y   SS1R_Bi2212FS_BB_OriShadow_Y
    SS1R_Bi2212FS_BB_OriShadow_Y=Bi2212FS_BB_OriShadow_Y + 1*S1Vector



////Make Second-Order Superstructure Bonding Shadow Fermi Surface 
  

//Left Side Second Order Superstructure Shadow Band

    Duplicate/O Bi2212FS_BB_OriShadow_X   SS2L_Bi2212FS_BB_OriShadow_X  
    SS2L_Bi2212FS_BB_OriShadow_X=Bi2212FS_BB_OriShadow_X - 2*S1Vector
    
    Duplicate/O Bi2212FS_BB_OriShadow_Y   SS2L_Bi2212FS_BB_OriShadow_Y
    SS2L_Bi2212FS_BB_OriShadow_Y=Bi2212FS_BB_OriShadow_Y - 2*S1Vector
    

//Right Side Second Order Superstructure Band

  
    Duplicate/O Bi2212FS_BB_OriShadow_X   SS2R_Bi2212FS_BB_OriShadow_X  
    SS2R_Bi2212FS_BB_OriShadow_X=Bi2212FS_BB_OriShadow_X + 2*S1Vector
    
    Duplicate/O Bi2212FS_BB_OriShadow_Y   SS2R_Bi2212FS_BB_OriShadow_Y
    SS2R_Bi2212FS_BB_OriShadow_Y=Bi2212FS_BB_OriShadow_Y + 2*S1Vector
       




 ////Make Original Anti-Bonding Shadow Fermi Surface
    Duplicate/O Bi2212FS_AB_Ori1_X   Bi2212FS_AB_OriShadow_X     
    Duplicate/O Bi2212FS_AB_Ori1_Y   Bi2212FS_AB_OriShadow_Y
    Bi2212FS_AB_OriShadow_X=Bi2212FS_AB_Ori1_X-1
    Bi2212FS_AB_OriShadow_Y=Bi2212FS_AB_Ori1_Y-1 
 
 ////Make First-Order Superstructure Anti-Bonding Shadow Fermi Surface 

   //Left Side First Order Superstructure Anti-Bonding Shadow Band

    Duplicate/O Bi2212FS_AB_OriShadow_X   SS1L_Bi2212FS_AB_OriShadow_X  
    SS1L_Bi2212FS_AB_OriShadow_X=Bi2212FS_AB_OriShadow_X - 1*S1Vector
    
    
    
    Duplicate/O Bi2212FS_AB_OriShadow_Y   SS1L_Bi2212FS_AB_OriShadow_Y
    SS1L_Bi2212FS_AB_OriShadow_Y=Bi2212FS_AB_OriShadow_Y - 1*S1Vector
    

    //Right Side First Order Superstructure Shadow Band

    Duplicate/O Bi2212FS_AB_OriShadow_X   SS1R_Bi2212FS_AB_OriShadow_X  
    SS1R_Bi2212FS_AB_OriShadow_X=Bi2212FS_AB_OriShadow_X + 1*S1Vector
    
    Duplicate/O Bi2212FS_AB_OriShadow_Y   SS1R_Bi2212FS_AB_OriShadow_Y
    SS1R_Bi2212FS_AB_OriShadow_Y=Bi2212FS_AB_OriShadow_Y + 1*S1Vector



////Make Second-Order Superstructure Anti-Bonding Shadow Fermi Surface 
  

//Left Side Second Order Superstructure Anti-Bonding Shadow Band

    Duplicate/O Bi2212FS_AB_OriShadow_X   SS2L_Bi2212FS_AB_OriShadow_X  
    SS2L_Bi2212FS_AB_OriShadow_X=Bi2212FS_AB_OriShadow_X - 2*S1Vector
    
    Duplicate/O Bi2212FS_AB_OriShadow_Y   SS2L_Bi2212FS_AB_OriShadow_Y
    SS2L_Bi2212FS_AB_OriShadow_Y=Bi2212FS_AB_OriShadow_Y - 2*S1Vector
    

//Right Side Second Order Superstructure Anti-Bonding Shadow Band

  
    Duplicate/O Bi2212FS_AB_OriShadow_X   SS2R_Bi2212FS_AB_OriShadow_X  
    SS2R_Bi2212FS_AB_OriShadow_X=Bi2212FS_AB_OriShadow_X + 2*S1Vector
    
    Duplicate/O Bi2212FS_AB_OriShadow_Y   SS2R_Bi2212FS_AB_OriShadow_Y
    SS2R_Bi2212FS_AB_OriShadow_Y=Bi2212FS_AB_OriShadow_Y + 2*S1Vector
       



     

SetDataFolder Curr

End

	



Proc CalculateMap(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)


variable artofflag=root:MomentumMap:ARToFFlag
if(artofflag==0)
	
NewDataFolder/O/S root:MomentumMap:FlagforHex
Variable PhotonE=root:MomentumMap:PhotonEnergy
Variable WorkFunc= root:MomentumMap:WorkFunction
Variable LC=root:MomentumMap:LatticeConstant
Variable K0=0.5118*LC/3.1416*Sqrt(PhotonE-WorkFunc)
Variable RAngle=root:MomentumMap:RotationAngle
Variable Theta0=root:MomentumMap:ThetaAngle
Variable Phi0=root:MomentumMap:PhiAngle
Variable DetectorAngle0=root:MomentumMap:DetectorAngle
Variable/G  flagforHex=NumVarOrDefault("root:MomentumMap:FlagforHex:flagforHex",100)
variable fromlinetoartof=root:MomentumMap:fromline2artof  
SetDataFolder root:MomentumMap:FlagforHex
Make/O/N=50 PhiValue
//PhiValue=-7+14/49*x
PhiValue=-DetectorAngle0/2+DetectorAngle0/49*x

PhiValue+=Phi0


Make/O/N=50 Ky, Kx, RKy, RKx

//print K0

if(fromlinetoartof==1)
DoWindow/K MomentumMap
root:MomentumMap:fromline2artof=0
else
dowindow MomentumMap
endif
dowindow MomentumMap
if(V_flag==0)
        	    

//		Ky=K0*sin(3.1416/180*Theta0)
//		Kx=K0*sin(3.1416/180*PhiValue)*cos(3.1416/180*Theta0)

//     On  Feb. 09,2007, change this formula
		
		 Ky=K0*sin(3.1416/180*Theta0)*cos(3.1416/180*(PhiValue)) 
        Kx=K0*sin(3.1416/180*(PhiValue))  
        
        
		
		
		RKy=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+RAngle*3.1416/180) 
		RKx=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+RAngle*3.1416/180) 

		Display/K=1 RKy vs RKx as "Momentum Map"
		ModifyGraph mode(RKy)=0, lsize(RKy)=6, rgb(RKy)=(0,12800,52224)

                            
              IF (root:MomentumMap:BZShowMode==2)
		      XJZSecondBZ(ctrlName)
		      ModifyGraph width={Aspect,1}
		      ModifyGraph standoff=0
             ModifyGraph margin(left)=42,margin(bottom)=42
             Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
             Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
             
             SetAxis bottom -1,1 
             SetAxis left -1,1    
             ModifyGraph width={Aspect,1}
             ModifyGraph lsize(VLiney4)=2
             ModifyGraph lsize(HLiney2)=2
             ModifyGraph lsize(VLIney3)=2
             ModifyGraph lsize(HLiney3)=2
             ModifyGraph rgb(HLiney2)=(0,0,0)
             ModifyGraph rgb(VLiney4)=(0,0,0)
             ModifyGraph rgb(VLIney3)=(0,0,0)
             ModifyGraph rgb(HLiney3)=(0,0,0)
             ModifyGraph lsize(VLiney2)=2,rgb(VLiney2)=(0,0,0)
             ModifyGraph lsize(HLiney4)=2,rgb(HLiney4)=(0,0,0)
             //RemoveFromGraph VLiney2
             //RemoveFromGraph HLiney4
             
             ModifyGraph axThick=3
             
             ModifyGraph manTick(left)={0,1,0,0},manMinor(left)={0,0};DelayUpdate
             ModifyGraph manTick(bottom)={0,1,0,0},manMinor(bottom)={0,0}
             ModifyGraph tick=2
             ModifyGraph gFont="Times New Roman"
             ModifyGraph mirror=2
             //
             ModifyGraph lsize(HLiney1)=2,rgb(HLiney1)=(0,0,0)
             ModifyGraph lsize(VLiney5)=2,rgb(VLiney5)=(0,0,0)
             //RemoveFromGraph HLiney1
             //RemoveFromGraph VLiney5
             
             ModifyGraph lsize(HLiney5)=2,rgb(Hliney5)=(0,0,0)
             ModifyGraph lsize(VLiney1)=2,rgb(Vliney1)=(0,0,0)
             //
             //RemoveFromGraph HLiney5
             //RemoveFromGraph VLiney1
             //
             ModifyGraph margin(top)=8,margin(right)=8
             
             XJZThirdBZ(ctrlName)          
             ModifyGraph rgb(Hexy)=(0,65280,0) 
             ModifyGraph lsize(Hexy)=2    

             SetAxis left -2,2;DelayUpdate
             SetAxis bottom -2,2
             ModifyGraph width=368.504,height=368.504
             flagforHex=2
         
             ELSE
              XJZSecondBZ(ctrlName)
		      ModifyGraph width={Aspect,1}
		      ModifyGraph standoff=0
             ModifyGraph margin(left)=42,margin(bottom)=42
             Label left "\\Z16\\f01K\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
             Label bottom "\\Z16\\f01K\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
             
             SetAxis bottom -1,1 
             SetAxis left -1,1    
             ModifyGraph width={Aspect,1}
             ModifyGraph lsize(VLiney4)=2
             ModifyGraph lsize(HLiney2)=2
             ModifyGraph lsize(VLIney3)=2
             ModifyGraph lsize(HLiney3)=2
             ModifyGraph rgb(HLiney2)=(0,0,0)
             ModifyGraph rgb(VLiney4)=(0,0,0)
             ModifyGraph rgb(VLIney3)=(0,0,0)
             ModifyGraph rgb(HLiney3)=(0,0,0)
             ModifyGraph lsize(VLiney2)=2,rgb(VLiney2)=(0,0,0)
             ModifyGraph lsize(HLiney4)=2,rgb(HLiney4)=(0,0,0)
             //RemoveFromGraph VLiney2
             //RemoveFromGraph HLiney4
              //
             //RemoveFromGraph HLiney5
             //RemoveFromGraph VLiney1
             //
               //
            //
             ModifyGraph lsize(HLiney1)=2,rgb(HLiney1)=(0,0,0)
             ModifyGraph lsize(VLiney5)=2,rgb(VLiney5)=(0,0,0)
             //RemoveFromGraph HLiney1
             //RemoveFromGraph VLiney5
             
             ModifyGraph lsize(HLiney5)=2,rgb(Hliney5)=(0,0,0)
             ModifyGraph lsize(VLiney1)=2,rgb(Vliney1)=(0,0,0)
             
             ModifyGraph axThick=3
             
             ModifyGraph manTick(left)={0,1,0,0},manMinor(left)={0,0};DelayUpdate
             ModifyGraph manTick(bottom)={0,1,0,0},manMinor(bottom)={0,0}
             ModifyGraph tick=2
             ModifyGraph gFont="Times New Roman"
             ModifyGraph mirror=2
             //RemoveFromGraph HLiney1
             //RemoveFromGraph VLiney5
             ModifyGraph margin(top)=8,margin(right)=8
            ModifyGraph width=368.504,height=368.504
             flagforHex=1
             EndIF 
             
             
             
              IF (root:MomentumMap:BZShowMode==0)
                        
              SetAxis left -1,1;DelayUpdate
              SetAxis bottom -1,1 
                              
              EndIF
              
              IF (root:MomentumMap:BZShowMode==1)
                        
              SetAxis left -2,2;DelayUpdate
              SetAxis bottom -2,2 
                              
              EndIF              
             
                              
                                           
                    
                    
                        
            ShowInfo
             
             

             
 	      DoWindow/C MomentumMap
 	         
               else
	 	  Ky=K0*sin(3.1416/180*Theta0)*cos(3.1416/180*(PhiValue)) 
          Kx=K0*sin(3.1416/180*(PhiValue)) 
	      RKy=sqrt(Ky*Ky+Kx*Kx)*sin((atan2(Ky,Kx))+RAngle*3.1416/180) 
		  RKx=sqrt(Ky*Ky+Kx*Kx)*cos((atan2(Ky,Kx))+RAngle*3.1416/180) 
		  
		  
		 
		  
		  		
           
              IF(root:MomentumMap:BZShowMode==0&&root:MomentumMap:FlagforHex:flagforHex==2)
         
            
              DoWindow/F MomentumMap
              SetAxis left -1,1;DelayUpdate
              SetAxis bottom -1,1 
              RemoveFromGraph Hexy
               flagforHex=1 
              ENDIF
        
              IF (root:MomentumMap:BZShowMode==0&&root:MomentumMap:FlagforHex:flagforHex==1)     
            
              DoWindow/F MomentumMap
              SetAxis left -1,1;DelayUpdate
              SetAxis bottom -1,1 
            
              flagforHex=1   
              ENDIF    
          
              IF (root:MomentumMap:BZShowMode==1&&root:MomentumMap:FlagforHex:flagforHex==2)
             
              DoWindow/F MomentumMap
              SetAxis left -2,2;DelayUpdate
              SetAxis bottom -2,2 
              RemoveFromGraph Hexy 
              
              flagforHex=1 
              ENDIF
                    
              IF (root:MomentumMap:BZShowMode==1&&root:MomentumMap:FlagforHex:flagforHex==1)
              
              DoWindow/F MomentumMap
              SetAxis left -2,2;DelayUpdate
              SetAxis bottom -2,2 
              
              flagforHex=1 
              ENDIF 
              
              IF (root:MomentumMap:BZShowMode==2&&root:MomentumMap:FlagforHex:flagforHex==1)
           
              DoWindow/F MomentumMap
              XJZThirdBZ(ctrlName)          
              SetAxis left -2,2;DelayUpdate
              SetAxis bottom -2,2 
              ModifyGraph rgb(Hexy)=(0,65280,0) 
              ModifyGraph lsize(Hexy)=2
                
              flagforHex=2             
              ENDIF               
	  
	          IF (root:MomentumMap:BZShowMode==2&&root:MomentumMap:FlagforHex:flagforHex==2)
	          DoWindow/F MomentumMap
	          RemoveFromGraph/Z Hexy 
	          XJZThirdBZ(ctrlName)          
              SetAxis left -2,2;DelayUpdate
              SetAxis bottom -2,2 
              ModifyGraph rgb(Hexy)=(0,65280,0) 
              ModifyGraph lsize(Hexy)=2
              flagforHex=2   
              ENDIF
              
	         Endif
endif

if(artofflag==1)

SetDataFolder root:MomentumMap
calculate_map_area()	         
endif	         
SetDataFolder Curr
	
End





Function Add_Ori_BondingBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
		Execute "CalBi2212FermiSurface()"
	
////Original Bonding Band
////             RemoveFromGraph/Z FirstFS_1BZy 
////             RemoveFromGraph/Z SecondFS_1BZy 
////             RemoveFromGraph/Z ThirdFS_1BZy             
////             RemoveFromGraph/Z FourthFS_1BZy
////             RemoveFromGraph/Z ShadowFS_1BZy             

               
             AppendToGraph Bi2212FS_BB_Ori1_Y vs Bi2212FS_BB_Ori1_X
             AppendToGraph Bi2212FS_BB_Ori2_Y vs Bi2212FS_BB_Ori2_X
             AppendToGraph Bi2212FS_BB_Ori3_Y vs Bi2212FS_BB_Ori3_X             
             AppendToGraph Bi2212FS_BB_Ori4_Y vs Bi2212FS_BB_Ori4_X                                         
             ModifyGraph lsize(Bi2212FS_BB_Ori1_Y)=3,rgb(Bi2212FS_BB_Ori1_Y)=(65280,0,0)
             ModifyGraph lsize(Bi2212FS_BB_Ori2_Y)=3,rgb(Bi2212FS_BB_Ori2_Y)=(65280,0,0)            
             ModifyGraph lsize(Bi2212FS_BB_Ori3_Y)=3,rgb(Bi2212FS_BB_Ori3_Y)=(65280,0,0)
             ModifyGraph lsize(Bi2212FS_BB_Ori4_Y)=3,rgb(Bi2212FS_BB_Ori4_Y)=(65280,0,0)  
	
	SetDataFolder Curr
	
End


Function Remove_Ori_BondingBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Original Bonding Band
             RemoveFromGraph/Z Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z Bi2212FS_BB_Ori2_Y 
             RemoveFromGraph/Z Bi2212FS_BB_Ori3_Y             
             RemoveFromGraph/Z Bi2212FS_BB_Ori4_Y   
	
	SetDataFolder Curr
	
End


Function Add_1stOrderS_Bondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
	
////First-Order Bonding Superstructure Band--Left Side                        
             AppendToGraph SS1L_Bi2212FS_BB_Ori1_Y vs SS1L_Bi2212FS_BB_Ori1_X
             AppendToGraph SS1L_Bi2212FS_BB_Ori2_Y vs SS1L_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS1L_Bi2212FS_BB_Ori3_Y vs SS1L_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS1L_Bi2212FS_BB_Ori4_Y vs SS1L_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori1_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori1_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori1_Y)=(65280,0,0)
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori2_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori2_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori2_Y)=(65280,0,0)  
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori3_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori3_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori3_Y)=(65280,0,0)           
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori4_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori4_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori4_Y)=(65280,0,0) 
             
////First-Order Bonding Superstructure Band--Right Side                        
             AppendToGraph SS1R_Bi2212FS_BB_Ori1_Y vs SS1R_Bi2212FS_BB_Ori1_X
             AppendToGraph SS1R_Bi2212FS_BB_Ori2_Y vs SS1R_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS1R_Bi2212FS_BB_Ori3_Y vs SS1R_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS1R_Bi2212FS_BB_Ori4_Y vs SS1R_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori1_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori1_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori1_Y)=(65280,0,0)
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori2_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori2_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori2_Y)=(65280,0,0) 
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori3_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori3_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori3_Y)=(65280,0,0)          
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori4_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori4_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori4_Y)=(65280,0,0)                
             
                    
	
	SetDataFolder Curr
	
End

Function Remove_1stOrderS_Bondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
	
////First-Order Bonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori2_Y             
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori3_Y              
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori4_Y                                                     
          
                      
////First-Order Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori2_Y              
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori3_Y              
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori4_Y 
	
	SetDataFolder Curr
	
End


Function Add_2ndOrderS_Bondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
	
////Second-Order Bonding Superstructure Band--Left Side                        
             AppendToGraph SS2L_Bi2212FS_BB_Ori1_Y vs SS2L_Bi2212FS_BB_Ori1_X
             AppendToGraph SS2L_Bi2212FS_BB_Ori2_Y vs SS2L_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS2L_Bi2212FS_BB_Ori3_Y vs SS2L_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS2L_Bi2212FS_BB_Ori4_Y vs SS2L_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori1_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori1_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori1_Y)=(65280,0,0)
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori2_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori2_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori2_Y)=(65280,0,0) 
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori3_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori3_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori3_Y)=(65280,0,0)            
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori4_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori4_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori4_Y)=(65280,0,0)          
                      
////Second-Order Bonding Superstructure Band--Right Side                        
             AppendToGraph SS2R_Bi2212FS_BB_Ori1_Y vs SS2R_Bi2212FS_BB_Ori1_X
             AppendToGraph SS2R_Bi2212FS_BB_Ori2_Y vs SS2R_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS2R_Bi2212FS_BB_Ori3_Y vs SS2R_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS2R_Bi2212FS_BB_Ori4_Y vs SS2R_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori1_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori1_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori1_Y)=(65280,0,0)
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori2_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori2_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori2_Y)=(65280,0,0)
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori3_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori3_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori3_Y)=(65280,0,0)           
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori4_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori4_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori4_Y)=(65280,0,0)  
	
	SetDataFolder Curr
	
End

Function Remove_2ndOrderS_Bondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Second-Order Bonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori2_Y              
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori3_Y             
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori4_Y                                                     
          
                      
////Second-Order Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori2_Y               
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori3_Y              
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori4_Y   
	
	SetDataFolder Curr
	
End


Function Add_Ori_ABondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap


	Execute "CalBi2212FermiSurface()"
	
////Original Anti-Bonding Band         
             AppendToGraph Bi2212FS_AB_Ori1_Y vs Bi2212FS_AB_Ori1_X
             AppendToGraph Bi2212FS_AB_Ori2_Y vs Bi2212FS_AB_Ori2_X
             AppendToGraph Bi2212FS_AB_Ori3_Y vs Bi2212FS_AB_Ori3_X             
             AppendToGraph Bi2212FS_AB_Ori4_Y vs Bi2212FS_AB_Ori4_X                                         
             ModifyGraph lsize(Bi2212FS_AB_Ori1_Y)=3,rgb(Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(Bi2212FS_AB_Ori2_Y)=3,rgb(Bi2212FS_AB_Ori2_Y)=(65280,0,52224)          
             ModifyGraph lsize(Bi2212FS_AB_Ori3_Y)=3,rgb(Bi2212FS_AB_Ori3_Y)=(65280,0,52224)
             ModifyGraph lsize(Bi2212FS_AB_Ori4_Y)=3,rgb(Bi2212FS_AB_Ori4_Y)=(65280,0,52224)   
	
	SetDataFolder Curr
	
End


Function Remove_Ori_ABondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Original Anti-Bonding Band         
             RemoveFromGraph/Z Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z Bi2212FS_AB_Ori2_Y 
             RemoveFromGraph/Z Bi2212FS_AB_Ori3_Y              
             RemoveFromGraph/Z Bi2212FS_AB_Ori4_Y    
	
	SetDataFolder Curr
	
End


Function Add_1stOrderS_ABondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
		Execute "CalBi2212FermiSurface()"
	
////First-Order AntiBonding Superstructure Band--Left Side                        
             AppendToGraph SS1L_Bi2212FS_AB_Ori1_Y vs SS1L_Bi2212FS_AB_Ori1_X
             AppendToGraph SS1L_Bi2212FS_AB_Ori2_Y vs SS1L_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS1L_Bi2212FS_AB_Ori3_Y vs SS1L_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS1L_Bi2212FS_AB_Ori4_Y vs SS1L_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori1_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori1_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori2_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori2_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori2_Y)=(65280,0,52224)  
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori3_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori3_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)            
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori4_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori4_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori4_Y)=(65280,0,52224)            
                      
////First-Order Anti-Bonding Superstructure Band--Right Side                        
             AppendToGraph SS1R_Bi2212FS_AB_Ori1_Y vs SS1R_Bi2212FS_AB_Ori1_X
             AppendToGraph SS1R_Bi2212FS_AB_Ori2_Y vs SS1R_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS1R_Bi2212FS_AB_Ori3_Y vs SS1R_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS1R_Bi2212FS_AB_Ori4_Y vs SS1R_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori1_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori1_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori2_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori2_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori2_Y)=(65280,0,52224)  
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori3_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori3_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)            
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori4_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori4_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori4_Y)=(65280,0,52224) 
	
	SetDataFolder Curr
	
End

Function Remove_1stOrderS_ABondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////First-Order AntiBonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori2_Y              
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori3_Y              
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori4_Y                                                     
          
                      
////First-Order Anti-Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori2_Y             
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori3_Y             
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori4_Y   
	
	SetDataFolder Curr
	
End


Function Add_2ndOrderS_ABondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
	
////Second-Order Anti-Bonding Superstructure Band--Left Side                        
             AppendToGraph SS2L_Bi2212FS_AB_Ori1_Y vs SS2L_Bi2212FS_AB_Ori1_X
             AppendToGraph SS2L_Bi2212FS_AB_Ori2_Y vs SS2L_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS2L_Bi2212FS_AB_Ori3_Y vs SS2L_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS2L_Bi2212FS_AB_Ori4_Y vs SS2L_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori1_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori1_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori2_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori2_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori2_Y)=(65280,0,52224) 
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori3_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori3_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)           
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori4_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori4_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori4_Y)=(65280,0,52224)           
                      
////Second-Order Anti-Bonding Superstructure Band--Right Side                        
             AppendToGraph SS2R_Bi2212FS_AB_Ori1_Y vs SS2R_Bi2212FS_AB_Ori1_X
             AppendToGraph SS2R_Bi2212FS_AB_Ori2_Y vs SS2R_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS2R_Bi2212FS_AB_Ori3_Y vs SS2R_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS2R_Bi2212FS_AB_Ori4_Y vs SS2R_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori1_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori1_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori2_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori2_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori2_Y)=(65280,0,52224)  
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori3_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori3_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)            
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori4_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori4_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori4_Y)=(65280,0,52224)
	
	
	SetDataFolder Curr
	
End


Function Remove_2ndOrderS_ABondingband(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap

	
////Second-Order Anti-Bonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori2_Y              
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori3_Y             
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori4_Y                                                    
  
                      
////Second-Order Anti-Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori2_Y           
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori3_Y              
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori4_Y   
	
	SetDataFolder Curr
	
End

Function Add_ALLOriBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
	
////Original Bonding Band
             AppendToGraph Bi2212FS_BB_Ori1_Y vs Bi2212FS_BB_Ori1_X
             AppendToGraph Bi2212FS_BB_Ori2_Y vs Bi2212FS_BB_Ori2_X
             AppendToGraph Bi2212FS_BB_Ori3_Y vs Bi2212FS_BB_Ori3_X             
             AppendToGraph Bi2212FS_BB_Ori4_Y vs Bi2212FS_BB_Ori4_X                                         
             ModifyGraph lsize(Bi2212FS_BB_Ori1_Y)=3,rgb(Bi2212FS_BB_Ori1_Y)=(0,15872,65280)
             ModifyGraph lsize(Bi2212FS_BB_Ori2_Y)=3,rgb(Bi2212FS_BB_Ori2_Y)=(0,15872,65280)            
             ModifyGraph lsize(Bi2212FS_BB_Ori3_Y)=3,rgb(Bi2212FS_BB_Ori3_Y)=(0,15872,65280)
             ModifyGraph lsize(Bi2212FS_BB_Ori4_Y)=3,rgb(Bi2212FS_BB_Ori4_Y)=(0,15872,65280)  
             
////First-Order Bonding Superstructure Band--Left Side                        
             AppendToGraph SS1L_Bi2212FS_BB_Ori1_Y vs SS1L_Bi2212FS_BB_Ori1_X
             AppendToGraph SS1L_Bi2212FS_BB_Ori2_Y vs SS1L_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS1L_Bi2212FS_BB_Ori3_Y vs SS1L_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS1L_Bi2212FS_BB_Ori4_Y vs SS1L_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori1_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori1_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori1_Y)=(0,15872,65280)
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori2_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori2_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori2_Y)=(0,15872,65280)  
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori3_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori3_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori3_Y)=(0,15872,65280)            
             ModifyGraph lsize(SS1L_Bi2212FS_BB_Ori4_Y)=2,lstyle(SS1L_Bi2212FS_BB_Ori4_Y)=0,rgb(SS1L_Bi2212FS_BB_Ori4_Y)=(0,15872,65280)            
                      
////First-Order Bonding Superstructure Band--Right Side                        
             AppendToGraph SS1R_Bi2212FS_BB_Ori1_Y vs SS1R_Bi2212FS_BB_Ori1_X
             AppendToGraph SS1R_Bi2212FS_BB_Ori2_Y vs SS1R_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS1R_Bi2212FS_BB_Ori3_Y vs SS1R_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS1R_Bi2212FS_BB_Ori4_Y vs SS1R_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori1_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori1_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori1_Y)=(0,15872,65280)
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori2_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori2_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori2_Y)=(0,15872,65280)  
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori3_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori3_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori3_Y)=(0,15872,65280)            
             ModifyGraph lsize(SS1R_Bi2212FS_BB_Ori4_Y)=2,lstyle(SS1R_Bi2212FS_BB_Ori4_Y)=0,rgb(SS1R_Bi2212FS_BB_Ori4_Y)=(0,15872,65280)               
             
////Second-Order Bonding Superstructure Band--Left Side                        
             AppendToGraph SS2L_Bi2212FS_BB_Ori1_Y vs SS2L_Bi2212FS_BB_Ori1_X
             AppendToGraph SS2L_Bi2212FS_BB_Ori2_Y vs SS2L_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS2L_Bi2212FS_BB_Ori3_Y vs SS2L_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS2L_Bi2212FS_BB_Ori4_Y vs SS2L_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori1_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori1_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori1_Y)=(0,15872,65280)
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori2_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori2_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori2_Y)=(0,15872,65280)  
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori3_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori3_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori3_Y)=(0,15872,65280)            
             ModifyGraph lsize(SS2L_Bi2212FS_BB_Ori4_Y)=1,lstyle(SS2L_Bi2212FS_BB_Ori4_Y)=0,rgb(SS2L_Bi2212FS_BB_Ori4_Y)=(0,15872,65280)            
                      
////Second-Order Bonding Superstructure Band--Right Side                        
             AppendToGraph SS2R_Bi2212FS_BB_Ori1_Y vs SS2R_Bi2212FS_BB_Ori1_X
             AppendToGraph SS2R_Bi2212FS_BB_Ori2_Y vs SS2R_Bi2212FS_BB_Ori2_X             
             AppendToGraph SS2R_Bi2212FS_BB_Ori3_Y vs SS2R_Bi2212FS_BB_Ori3_X             
             AppendToGraph SS2R_Bi2212FS_BB_Ori4_Y vs SS2R_Bi2212FS_BB_Ori4_X                                                    
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori1_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori1_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori1_Y)=(0,15872,65280)
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori2_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori2_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori2_Y)=(0,15872,65280)  
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori3_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori3_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori3_Y)=(0,15872,65280)            
             ModifyGraph lsize(SS2R_Bi2212FS_BB_Ori4_Y)=1,lstyle(SS2R_Bi2212FS_BB_Ori4_Y)=0,rgb(SS2R_Bi2212FS_BB_Ori4_Y)=(0,15872,65280)               
             
             
             
////Original Anti-Bonding Band         
             AppendToGraph Bi2212FS_AB_Ori1_Y vs Bi2212FS_AB_Ori1_X
             AppendToGraph Bi2212FS_AB_Ori2_Y vs Bi2212FS_AB_Ori2_X
             AppendToGraph Bi2212FS_AB_Ori3_Y vs Bi2212FS_AB_Ori3_X             
             AppendToGraph Bi2212FS_AB_Ori4_Y vs Bi2212FS_AB_Ori4_X                                         
             ModifyGraph lsize(Bi2212FS_AB_Ori1_Y)=3,rgb(Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(Bi2212FS_AB_Ori2_Y)=3,rgb(Bi2212FS_AB_Ori2_Y)=(65280,0,52224)          
             ModifyGraph lsize(Bi2212FS_AB_Ori3_Y)=3,rgb(Bi2212FS_AB_Ori3_Y)=(65280,0,52224)
             ModifyGraph lsize(Bi2212FS_AB_Ori4_Y)=3,rgb(Bi2212FS_AB_Ori4_Y)=(65280,0,52224)            
             
////First-Order AntiBonding Superstructure Band--Left Side                        
             AppendToGraph SS1L_Bi2212FS_AB_Ori1_Y vs SS1L_Bi2212FS_AB_Ori1_X
             AppendToGraph SS1L_Bi2212FS_AB_Ori2_Y vs SS1L_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS1L_Bi2212FS_AB_Ori3_Y vs SS1L_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS1L_Bi2212FS_AB_Ori4_Y vs SS1L_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori1_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori1_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori2_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori2_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori2_Y)=(65280,0,52224)  
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori3_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori3_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)            
             ModifyGraph lsize(SS1L_Bi2212FS_AB_Ori4_Y)=2,lstyle(SS1L_Bi2212FS_AB_Ori4_Y)=0,rgb(SS1L_Bi2212FS_AB_Ori4_Y)=(65280,0,52224)            
                      
////First-Order Anti-Bonding Superstructure Band--Right Side                        
             AppendToGraph SS1R_Bi2212FS_AB_Ori1_Y vs SS1R_Bi2212FS_AB_Ori1_X
             AppendToGraph SS1R_Bi2212FS_AB_Ori2_Y vs SS1R_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS1R_Bi2212FS_AB_Ori3_Y vs SS1R_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS1R_Bi2212FS_AB_Ori4_Y vs SS1R_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori1_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori1_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori2_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori2_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori2_Y)=(65280,0,52224)  
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori3_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori3_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)            
             ModifyGraph lsize(SS1R_Bi2212FS_AB_Ori4_Y)=2,lstyle(SS1R_Bi2212FS_AB_Ori4_Y)=0,rgb(SS1R_Bi2212FS_AB_Ori4_Y)=(65280,0,52224)               
             
////Second-Order Anti-Bonding Superstructure Band--Left Side                        
             AppendToGraph SS2L_Bi2212FS_AB_Ori1_Y vs SS2L_Bi2212FS_AB_Ori1_X
             AppendToGraph SS2L_Bi2212FS_AB_Ori2_Y vs SS2L_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS2L_Bi2212FS_AB_Ori3_Y vs SS2L_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS2L_Bi2212FS_AB_Ori4_Y vs SS2L_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori1_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori1_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori2_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori2_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori2_Y)=(65280,0,52224) 
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori3_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori3_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)           
             ModifyGraph lsize(SS2L_Bi2212FS_AB_Ori4_Y)=1,lstyle(SS2L_Bi2212FS_AB_Ori4_Y)=0,rgb(SS2L_Bi2212FS_AB_Ori4_Y)=(65280,0,52224)           
                      
////Second-Order Anti-Bonding Superstructure Band--Right Side                        
             AppendToGraph SS2R_Bi2212FS_AB_Ori1_Y vs SS2R_Bi2212FS_AB_Ori1_X
             AppendToGraph SS2R_Bi2212FS_AB_Ori2_Y vs SS2R_Bi2212FS_AB_Ori2_X             
             AppendToGraph SS2R_Bi2212FS_AB_Ori3_Y vs SS2R_Bi2212FS_AB_Ori3_X             
             AppendToGraph SS2R_Bi2212FS_AB_Ori4_Y vs SS2R_Bi2212FS_AB_Ori4_X                                                    
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori1_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori1_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori1_Y)=(65280,0,52224)
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori2_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori2_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori2_Y)=(65280,0,52224)  
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori3_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori3_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori3_Y)=(65280,0,52224)            
             ModifyGraph lsize(SS2R_Bi2212FS_AB_Ori4_Y)=1,lstyle(SS2R_Bi2212FS_AB_Ori4_Y)=0,rgb(SS2R_Bi2212FS_AB_Ori4_Y)=(65280,0,52224)
	
	SetDataFolder Curr
	
End

Function Remove_ALLOriBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
 	SetDatafolder root:MomentumMap    
     
////Original Bonding Band
             RemoveFromGraph/Z Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z Bi2212FS_BB_Ori2_Y 
             RemoveFromGraph/Z Bi2212FS_BB_Ori3_Y             
             RemoveFromGraph/Z Bi2212FS_BB_Ori4_Y                                          

////First-Order Bonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori2_Y             
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori3_Y              
             RemoveFromGraph/Z SS1L_Bi2212FS_BB_Ori4_Y                                                     
          
                      
////First-Order Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori2_Y              
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori3_Y              
             RemoveFromGraph/Z SS1R_Bi2212FS_BB_Ori4_Y                                                     
              
             
////Second-Order Bonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori2_Y              
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori3_Y             
             RemoveFromGraph/Z SS2L_Bi2212FS_BB_Ori4_Y                                                     
          
                      
////Second-Order Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori1_Y 
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori2_Y               
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori3_Y              
             RemoveFromGraph/Z SS2R_Bi2212FS_BB_Ori4_Y                                                     

             
             
////Original Anti-Bonding Band         
             RemoveFromGraph/Z Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z Bi2212FS_AB_Ori2_Y 
             RemoveFromGraph/Z Bi2212FS_AB_Ori3_Y              
             RemoveFromGraph/Z Bi2212FS_AB_Ori4_Y                                        
         
             
////First-Order AntiBonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori2_Y              
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori3_Y              
             RemoveFromGraph/Z SS1L_Bi2212FS_AB_Ori4_Y                                                     
          
                      
////First-Order Anti-Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori2_Y             
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori3_Y             
             RemoveFromGraph/Z SS1R_Bi2212FS_AB_Ori4_Y                                                    
             
             
////Second-Order Anti-Bonding Superstructure Band--Left Side                        
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori2_Y              
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori3_Y             
             RemoveFromGraph/Z SS2L_Bi2212FS_AB_Ori4_Y                                                    
  
                      
////Second-Order Anti-Bonding Superstructure Band--Right Side                        
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori1_Y 
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori2_Y           
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori3_Y              
             RemoveFromGraph/Z SS2R_Bi2212FS_AB_Ori4_Y                                                  

     
	
	SetDataFolder Curr
	
End


         
    Function Add_Ori_BBShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
		
	Execute "CalBi2212FermiSurface()"
	
   ////Original Bonding Shadow Band
             AppendToGraph Bi2212FS_BB_OriShadow_Y vs Bi2212FS_BB_OriShadow_X                                       
             ModifyGraph lsize(Bi2212FS_BB_OriShadow_Y)=3,rgb(Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)

	
	SetDataFolder Curr
	End


    Function Remove_Ori_BBShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Remove Original Bonding Shadow Band
            RemoveFromGraph/Z Bi2212FS_BB_OriShadow_Y
	
	SetDataFolder Curr
    End
    

    Function Add_1stOrderS_BBShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
	
   ////First-Order Bonding Shadow Band
             AppendToGraph SS1L_Bi2212FS_BB_OriShadow_Y vs SS1L_Bi2212FS_BB_OriShadow_X 
             AppendToGraph SS1R_Bi2212FS_BB_OriShadow_Y vs SS1R_Bi2212FS_BB_OriShadow_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_BB_OriShadow_Y)=2,rgb(SS1L_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
             ModifyGraph lsize(SS1R_Bi2212FS_BB_OriShadow_Y)=2,rgb(SS1R_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
	
	SetDataFolder Curr
	End

    Function Remove_1stOrderS_BBShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Remove First-Order Bonding Shadow Band
            RemoveFromGraph/Z SS1L_Bi2212FS_BB_OriShadow_Y
	        RemoveFromGraph/Z SS1R_Bi2212FS_BB_OriShadow_Y 
	SetDataFolder Curr
    End


    Function Add_2ndOrderS_BBShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
			
   ////2ndOrder Bonding Shadow Band
             AppendToGraph SS2L_Bi2212FS_BB_OriShadow_Y vs SS2L_Bi2212FS_BB_OriShadow_X 
             AppendToGraph SS2R_Bi2212FS_BB_OriShadow_Y vs SS2R_Bi2212FS_BB_OriShadow_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_BB_OriShadow_Y)=1,rgb(SS2L_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
             ModifyGraph lsize(SS2R_Bi2212FS_BB_OriShadow_Y)=1,rgb(SS2R_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
	
	SetDataFolder Curr
	End

   
    Function Remove_2ndOrderS_BBShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Remove 2ndOrder Bonding Shadow Band
            RemoveFromGraph/Z SS2L_Bi2212FS_BB_OriShadow_Y
	        RemoveFromGraph/Z SS2R_Bi2212FS_BB_OriShadow_Y 
	SetDataFolder Curr
    End
 
 
  Function Add_Ori_ABShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
		
	Execute "CalBi2212FermiSurface()"
	
   ////Original Anti-Bonding Shadow Band
             AppendToGraph Bi2212FS_AB_OriShadow_Y vs Bi2212FS_AB_OriShadow_X                                       
             ModifyGraph lsize(Bi2212FS_AB_OriShadow_Y)=3,rgb(Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
	
	SetDataFolder Curr
	End  
   
   
    Function Remove_Ori_ABShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Remove Original Anti-Bonding Shadow Band
            RemoveFromGraph/Z Bi2212FS_AB_OriShadow_Y
	
	SetDataFolder Curr
    End
    

    Function Add_1stOrderS_ABShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
	
   ////First-Order Anti-Bonding Shadow Band
             AppendToGraph SS1L_Bi2212FS_AB_OriShadow_Y vs SS1L_Bi2212FS_AB_OriShadow_X 
             AppendToGraph SS1R_Bi2212FS_AB_OriShadow_Y vs SS1R_Bi2212FS_AB_OriShadow_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_AB_OriShadow_Y)=2,rgb(SS1L_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
             ModifyGraph lsize(SS1R_Bi2212FS_AB_OriShadow_Y)=2,rgb(SS1R_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
	
	SetDataFolder Curr
	End

    Function Remove_1stOrderS_ABShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Remove First-Order Anti-Bonding Shadow Band
            RemoveFromGraph/Z SS1L_Bi2212FS_AB_OriShadow_Y
	        RemoveFromGraph/Z SS1R_Bi2212FS_AB_OriShadow_Y 
	SetDataFolder Curr
    End


    Function Add_2ndOrderS_ABShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
			
   ////2ndOrder Anti-Bonding Shadow Band
             AppendToGraph SS2L_Bi2212FS_AB_OriShadow_Y vs SS2L_Bi2212FS_AB_OriShadow_X 
             AppendToGraph SS2R_Bi2212FS_AB_OriShadow_Y vs SS2R_Bi2212FS_AB_OriShadow_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_AB_OriShadow_Y)=1,rgb(SS2L_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
             ModifyGraph lsize(SS2R_Bi2212FS_AB_OriShadow_Y)=1,rgb(SS2R_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
	
	SetDataFolder Curr
	End

   
    Function Remove_2ndOrderS_ABShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap
	
////Remove 2ndOrder Anti-Bonding Shadow Band
            RemoveFromGraph/Z SS2L_Bi2212FS_AB_OriShadow_Y
	        RemoveFromGraph/Z SS2R_Bi2212FS_AB_OriShadow_Y 
	SetDataFolder Curr
    End
   
   
   
   
    
    
    
   
   Function Add_ALLShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	SetDatafolder root:MomentumMap 
	
		
   ////Original Bonding Shadow Band
             AppendToGraph Bi2212FS_BB_OriShadow_Y vs Bi2212FS_BB_OriShadow_X                                       
             ModifyGraph lsize(Bi2212FS_BB_OriShadow_Y)=3,rgb(Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)

   ////First-Order Bonding Shadow Band
             AppendToGraph SS1L_Bi2212FS_BB_OriShadow_Y vs SS1L_Bi2212FS_BB_OriShadow_X 
             AppendToGraph SS1R_Bi2212FS_BB_OriShadow_Y vs SS1R_Bi2212FS_BB_OriShadow_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_BB_OriShadow_Y)=2,rgb(SS1L_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
             ModifyGraph lsize(SS1R_Bi2212FS_BB_OriShadow_Y)=2,rgb(SS1R_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
   
   ////2ndOrder Bonding Shadow Band
             AppendToGraph SS2L_Bi2212FS_BB_OriShadow_Y vs SS2L_Bi2212FS_BB_OriShadow_X 
             AppendToGraph SS2R_Bi2212FS_BB_OriShadow_Y vs SS2R_Bi2212FS_BB_OriShadow_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_BB_OriShadow_Y)=1,rgb(SS2L_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
             ModifyGraph lsize(SS2R_Bi2212FS_BB_OriShadow_Y)=1,rgb(SS2R_Bi2212FS_BB_OriShadow_Y)=(26112,52224,0)
	
   ////Original Anti-Bonding Shadow Band
             AppendToGraph Bi2212FS_AB_OriShadow_Y vs Bi2212FS_AB_OriShadow_X                                       
             ModifyGraph lsize(Bi2212FS_AB_OriShadow_Y)=3,rgb(Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)

	////First-Order Anti-Bonding Shadow Band
             AppendToGraph SS1L_Bi2212FS_AB_OriShadow_Y vs SS1L_Bi2212FS_AB_OriShadow_X 
             AppendToGraph SS1R_Bi2212FS_AB_OriShadow_Y vs SS1R_Bi2212FS_AB_OriShadow_X                                                    
             ModifyGraph lsize(SS1L_Bi2212FS_AB_OriShadow_Y)=2,rgb(SS1L_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
             ModifyGraph lsize(SS1R_Bi2212FS_AB_OriShadow_Y)=2,rgb(SS1R_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
	////2ndOrder Anti-Bonding Shadow Band
             AppendToGraph SS2L_Bi2212FS_AB_OriShadow_Y vs SS2L_Bi2212FS_AB_OriShadow_X 
             AppendToGraph SS2R_Bi2212FS_AB_OriShadow_Y vs SS2R_Bi2212FS_AB_OriShadow_X                                                    
             ModifyGraph lsize(SS2L_Bi2212FS_AB_OriShadow_Y)=1,rgb(SS2L_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
             ModifyGraph lsize(SS2R_Bi2212FS_AB_OriShadow_Y)=1,rgb(SS2R_Bi2212FS_AB_OriShadow_Y)=(36864,14592,58880)
	
	SetDataFolder Curr
	End
	
	
	Function Remove_ALLShadowBand(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
 	SetDatafolder root:MomentumMap
	////Remove Original Bonding Shadow Band
            RemoveFromGraph/Z Bi2212FS_BB_OriShadow_Y
	
	////Remove First-Order Bonding Shadow Band
            RemoveFromGraph/Z SS1L_Bi2212FS_BB_OriShadow_Y
	        RemoveFromGraph/Z SS1R_Bi2212FS_BB_OriShadow_Y 
	
	////Remove 2ndOrder Bonding Shadow Band
            RemoveFromGraph/Z SS2L_Bi2212FS_BB_OriShadow_Y
	        RemoveFromGraph/Z SS2R_Bi2212FS_BB_OriShadow_Y 
	
	////Remove Original Anti-Bonding Shadow Band
            RemoveFromGraph/Z Bi2212FS_AB_OriShadow_Y
	
	////Remove First-Order Anti-Bonding Shadow Band
            RemoveFromGraph/Z SS1L_Bi2212FS_AB_OriShadow_Y
	        RemoveFromGraph/Z SS1R_Bi2212FS_AB_OriShadow_Y 
	
	////Remove 2ndOrder Anti-Bonding Shadow Band
            RemoveFromGraph/Z SS2L_Bi2212FS_AB_OriShadow_Y
	        RemoveFromGraph/Z SS2R_Bi2212FS_AB_OriShadow_Y 
	SetDataFolder Curr
    End
	
    
    

Function kMapDoneButton(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
        DoWindow/K Momentum_Map_Panel
	
	SetDataFolder Curr
	
End
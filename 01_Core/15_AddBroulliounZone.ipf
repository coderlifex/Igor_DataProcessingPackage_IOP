#pragma rtGlobals=1		// Use modern global access method.


Function XJZ1stBZ(ctrlName) : ButtonControl
	String ctrlName
	
	String Curr =GetDataFolder(1)
	
	SetDataFolder root:IMG
	Make/O/N=2 HLinex1, HLinex2, HLinex3, VLinex1, VLinex2, VLInex3, DLinex1, DLinex2,DLinex3, DLinex4, DLinex5, DLinex6
	Make/O/N=2 HLiney1, HLiney2, HLiney3, VLiney1, VLiney2, VLIney3, DLiney1, DLiney2,DLiney3, DLIney4, DLiney5, DLiney6
//	RemoveFromGraph VLiney1,VLiney2,VLIney3,HLiney1,HLiney2,HLiney3,DLiney1,DLiney2,DLiney3, DLiney4, DLiney5, DLiney6
	VLinex1= {-1,-1}, VLiney1={-1,1}
	VLinex2={0,0},    VLiney2={-1,1}
	VLinex3={1,1},    VLiney3={-1,1}
        AppendToGraph VLiney1 vs VLinex1
        AppendToGraph VLiney2 vs VLinex2
        AppendToGraph VLiney3 vs VLinex3
        ModifyGraph rgb(VLiney1)=(65280,16384,16384)
        ModifyGraph rgb(VLiney2)=(65280,16384,16384)
        ModifyGraph rgb(VLiney3)=(65280,16384,16384)
        ModifyGraph lsize(VLiney1)=2
        ModifyGraph lsize(VLiney2)=2
        ModifyGraph lsize(VLiney3)=2
        
               
        HLinex1= {-1,1},  HLiney1={1,1}
	    HLinex2={-1,1},   HLiney2={0,0}
	    HLinex3={-1,1},    HLiney3={-1,-1}
        AppendToGraph HLiney1 vs HLinex1
        AppendToGraph HLiney2 vs HLinex2
        AppendToGraph HLiney3 vs HLinex3
        ModifyGraph rgb(HLiney1)=(65280,16384,16384), lsize(HLiney1)=2
        ModifyGraph rgb(HLiney2)=(65280,16384,16384), lsize(HLiney2)=2
        ModifyGraph rgb(HLiney3)=(65280,16384,16384), lsize(HLiney3)=2
               
        
         DLinex1= {-1,1},  DLiney1={-1,1}
	     DLinex2={-1,1},   DLiney2={1,-1}
	     DLinex3={-1,0},   DLiney3={0,-1}
	     DLinex4={0,1},    DLiney4={-1,0}
	     DLinex5={1,0},    DLiney5={0,1}
	     DLinex6={0,-1},   DLiney6={1,0}
        AppendToGraph DLiney1 vs DLinex1
        AppendToGraph DLiney2 vs DLinex2
        AppendToGraph DLiney3 vs DLinex3
        AppendToGraph DLiney4 vs DLinex4       
        AppendToGraph DLiney5 vs DLinex5
        AppendToGraph DLiney6 vs DLinex6       
        
        
        ModifyGraph rgb(DLiney1)=(65280,16384,16384)
        ModifyGraph rgb(DLiney2)=(65280,16384,16384)	
        ModifyGraph rgb(DLiney3)=(65280,16384,16384)
        ModifyGraph rgb(DLiney4)=(65280,16384,16384)	
        ModifyGraph rgb(DLiney5)=(65280,16384,16384)
        ModifyGraph rgb(DLiney6)=(65280,16384,16384)
        
        SetDataFolder Curr
        
End
 
 
Function XJZSecondBZ(ctrlName) : ButtonControl
	String ctrlName
	
	String curr=GetDataFolder(1)
	
	SetDataFolder root:IMG
	Make/O/N=2 HLinex1, HLinex2, HLinex3, HLinex4, HLinex5
	Make/O/N=2 VLinex1, VLinex2, VLInex3, VLinex4,  VLinex5
	Make/O/N=2 DLinex1, DLinex2,DLinex3, DLinex4, DLinex5, DLinex6
    Make/O/N=2 HLiney1, HLiney2, HLiney3, HLiney4, HLiney5 
	Make/O/N=2 VLiney1, VLiney2, VLiney3, VLiney4,  VLiney5
	Make/O/N=2 DLiney1, DLiney2,DLiney3, DLiney4, DLiney5, DLiney6	
//	RemoveFromGraph/Z VLiney1,VLiney2,VLIney3,VLiney4,VLiney5

//	RemoveFromGraph/Z DLiney1,DLiney2,DLiney3, DLiney4, DLiney5, DLiney6
	VLinex1= {-2,-2}, VLiney1={-3,3}
	VLinex2={-1,-1},  VLiney2={-3,3}
	VLinex3={0,0},    VLiney3={-3,3}
	VLinex4={1,1},    VLiney4={-3,3}
	VLinex5={2,2},    VLiney5={-3,3}	
      AppendToGraph VLiney1 vs VLinex1
        AppendToGraph VLiney2 vs VLinex2
        AppendToGraph VLiney3 vs VLinex3
        AppendToGraph VLiney4 vs VLinex4
        AppendToGraph VLiney5 vs VLinex5      
      ModifyGraph rgb(VLiney1)=(65280,0,52224)
        ModifyGraph rgb(VLiney2)=(65280,0,52224)
        ModifyGraph rgb(VLiney3)=(65280,0,52224)
        ModifyGraph rgb(VLiney4)=(65280,0,52224)
        ModifyGraph rgb(VLiney5)=(65280,0,52224)
        
//	RemoveFromGraph HLiney1,HLiney2,HLiney3,HLiney4,HLiney5              
    HLinex1= {-3,3},  HLiney1={2,2}
	HLinex2={-3,3},   HLiney2={1,1}
	HLinex3={-3,3},   HLiney3={0,0}
	HLinex4={-3,3},   HLiney4={-1,-1}
	HLinex5={-3,3},   HLiney5={-2,-2}	
        AppendToGraph HLiney1 vs HLinex1
        AppendToGraph HLiney2 vs HLinex2
        AppendToGraph HLiney3 vs HLinex3
        AppendToGraph HLiney4 vs HLinex4
      AppendToGraph HLiney5 vs HLinex5       
        ModifyGraph rgb(HLiney1)=(65280,16384,16384)
        ModifyGraph rgb(HLiney2)=(65280,16384,16384)
        ModifyGraph rgb(HLiney3)=(65280,16384,16384)
        ModifyGraph rgb(HLiney4)=(65280,16384,16384)
      ModifyGraph rgb(HLiney5)=(65280,16384,16384)


//	RemoveFromGraph DLiney1,DLiney2,DLiney3
	DLinex1= {-1,2},  DLiney1={2,-1}
	DLinex2={-2,2},   DLiney2={-2,2}
	DLinex3={-2,1},   DLiney3={-1,2}
	DLinex4={-1,2},   DLiney4={-2,1}
	DLinex5={0,2},    DLiney5={-2,0}
	DLinex6={-2,0},   DLiney6={0,2}
        AppendToGraph DLiney1 vs DLinex1
        AppendToGraph DLiney2 vs DLinex2
        AppendToGraph DLiney3 vs DLinex3
        AppendToGraph DLiney4 vs DLinex4       
        AppendToGraph DLiney5 vs DLinex5
        AppendToGraph DLiney6 vs DLinex6       
        
        
        ModifyGraph rgb(DLiney1)=(0,0,0)
        ModifyGraph rgb(DLiney2)=(0,0,0)
        ModifyGraph rgb(DLiney3)=(0,0,0)
        ModifyGraph rgb(DLiney4)=(65280,16384,16384)	
        ModifyGraph rgb(DLiney5)=(65280,16384,16384)
        ModifyGraph rgb(DLiney6)=(65280,16384,16384)
        
        SetDataFolder curr
        
End


Proc XJZSecondBZN() 
	
	String curr=GetDataFolder(1)
	
	SetDataFolder root:IMG
	Make/O/N=2 HLinex1, HLinex2, HLinex3, HLinex4, HLinex5
	Make/O/N=2 VLinex1, VLinex2, VLInex3, VLinex4,  VLinex5
	Make/O/N=2 DLinex1, DLinex2,DLinex3, DLinex4, DLinex5, DLinex6
    Make/O/N=2 HLiney1, HLiney2, HLiney3, HLiney4, HLiney5 
	Make/O/N=2 VLiney1, VLiney2, VLiney3, VLiney4,  VLiney5
	Make/O/N=2 DLiney1, DLiney2,DLiney3, DLiney4, DLiney5, DLiney6	
//	RemoveFromGraph/Z VLiney1,VLiney2,VLIney3,VLiney4,VLiney5

//	RemoveFromGraph/Z DLiney1,DLiney2,DLiney3, DLiney4, DLiney5, DLiney6
//	VLinex1= {-2,-2}, VLiney1={-2,2}
	VLinex2={-1,-1},  VLiney2={-2,2}
	VLinex3={0,0},    VLiney3={-2,2}
	VLinex4={1,1},    VLiney4={-2,2}
	VLinex5={2,2},    VLiney5={-2,2}	
//      AppendToGraph VLiney1 vs VLinex1
        AppendToGraph VLiney2 vs VLinex2
        AppendToGraph VLiney3 vs VLinex3
        AppendToGraph VLiney4 vs VLinex4
        AppendToGraph VLiney5 vs VLinex5      
//      ModifyGraph rgb(VLiney1)=(65280,0,52224)
        ModifyGraph rgb(VLiney2)=(65280,0,52224)
        ModifyGraph rgb(VLiney3)=(65280,0,52224)
        ModifyGraph rgb(VLiney4)=(65280,0,52224)
        ModifyGraph rgb(VLiney5)=(65280,0,52224)
        
//	RemoveFromGraph HLiney1,HLiney2,HLiney3,HLiney4,HLiney5              
    HLinex1= {-2,2},  HLiney1={2,2}
	HLinex2={-2,2},   HLiney2={1,1}
	HLinex3={-2,2},   HLiney3={0,0}
	HLinex4={-2,2},   HLiney4={-1,-1}
//	HLinex5={-2,2},   HLiney5={-2,-2}	
        AppendToGraph HLiney1 vs HLinex1
        AppendToGraph HLiney2 vs HLinex2
        AppendToGraph HLiney3 vs HLinex3
        AppendToGraph HLiney4 vs HLinex4
//      AppendToGraph HLiney5 vs HLinex5       
        ModifyGraph rgb(HLiney1)=(65280,16384,16384)
        ModifyGraph rgb(HLiney2)=(65280,16384,16384)
        ModifyGraph rgb(HLiney3)=(65280,16384,16384)
        ModifyGraph rgb(HLiney4)=(65280,16384,16384)
//      ModifyGraph rgb(HLiney5)=(65280,16384,16384)


//	RemoveFromGraph DLiney1,DLiney2,DLiney3
	DLinex1= {-1,2},  DLiney1={2,-1}
	DLinex2={-2,2},   DLiney2={-2,2}
	DLinex3={-2,1},   DLiney3={-1,2}
	DLinex4={-1,2},   DLiney4={-2,1}
	DLinex5={0,2},    DLiney5={-2,0}
	DLinex6={-2,0},   DLiney6={0,2}
        AppendToGraph DLiney1 vs DLinex1
        AppendToGraph DLiney2 vs DLinex2
        AppendToGraph DLiney3 vs DLinex3
        AppendToGraph DLiney4 vs DLinex4       
        AppendToGraph DLiney5 vs DLinex5
        AppendToGraph DLiney6 vs DLinex6       
        
        
        ModifyGraph rgb(DLiney1)=(0,0,0)
        ModifyGraph rgb(DLiney2)=(0,0,0)
        ModifyGraph rgb(DLiney3)=(0,0,0)
        ModifyGraph rgb(DLiney4)=(65280,16384,16384)	
        ModifyGraph rgb(DLiney5)=(65280,16384,16384)
        ModifyGraph rgb(DLiney6)=(65280,16384,16384)
        
        SetDataFolder curr
        
End

Function XJZThirdBZ(ctrlName) : ButtonControl
	String ctrlName
	
	String curr=GetDataFolder(1)
	
	SetDataFolder root:IMG
	Make/O/N=7 Hexx
	Make/O/N=7 Hexy
    Hexx={0,1.1547,1.1547,0,-1.1547,-1.1547,0}
    Hexy={1.3333,0.6667,-0.6667,-1.3333,-0.6667,0.6667,1.3333}	
        AppendToGraph Hexy vs Hexx    
        ModifyGraph rgb(Hexy)=(0,65280,0)
        ModifyGraph lsize(Hexy)=1.5
        
       SetDataFolder curr
End

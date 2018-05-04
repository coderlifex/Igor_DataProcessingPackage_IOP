#pragma rtGlobals=1		// Use modern global access method.

proc FS_SYM(ctrlName) : ButtonControl
      String ctrlName
      String Curr=GetDataFolder(1)
      DoWindow/F FS_SYM_Panel
        if (V_flag==0)
   //       DoWindow/K ShowSYM_FS
          Setdatafolder root:IMG
//          print 1
          String/G file_ORG_FS
          String/G SYM_FS_name
          Variable/G Four_F_sym
          Variable/G Eight_F_sym
          file_ORG_FS=wavelist(root:PROCESS:SWImageName+"*",";","DIMS:2")
	      FS_SYM_Panel()
		endif
	SetDataFolder Curr
end
	
Window FS_SYM_Panel() : Panel
	PauseUpdate; Silent 1		// building window...
	 NewPanel /W=(200,150,440,400)
	SetDrawLayer UserBack
	GroupBox Step1,pos={10,2},size={210,80},title="Step 1: Show ORG_FS"
	PopupMenu ShowORG_FS,pos={10,40},size={205,20},proc=ORG_FS,title="FS"
	PopupMenu ShowORG_FS,mode=1,bodyWidth= 150,popvalue="-none-",value= #"root:IMG:file_ORG_FS"
	
	GroupBox Step2,pos={10,102},size={210,120},title="Step 2: Show SYM_FS"
	
	SetVariable P_4fold,pos={20,140},size={104,15},title="4-fold"
	SetVariable P_4fold,limits={1,4,1},value= root:IMG:Four_F_sym
	Button Plot4,pos={140,138},size={50,20},proc=Plot4FS,title="Plot4"
	
	SetVariable P_8fold,pos={20,180},size={104,15},title="8-fold"
	SetVariable P_8fold,limits={1,8,1},value= root:IMG:Eight_F_sym
	Button Plot8,pos={140,178},size={50,20},proc=Plot8FS,title="Plot8"
	
	Button Exitbutton,pos={90,225},size={50,25},title="EXIT",proc=Exitproc
//	DrawText 240,245,"N(E)=A*Re((E+iG)/sqrt((E+iG)^2-D^2))+B*E+C"
//	DrawText 350,305,"G=alfa*E"
EndMacro


Proc ORG_FS(ctrlName,popNum,popStr) : PopupMenuControl
    String ctrlName
	Variable popNum
	String popStr
	Setdatafolder root:IMG
	SYM_FS_name=popStr
    String windowname=popStr+"FS"
	Variable PTO_NKxStart=root:PROCESS:KxStart
	Variable PTO_NKxEnd=root:PROCESS:KxEnd
	Variable PTO_NKyStart=root:PROCESS:KyStart
	Variable PTO_NKyEnd=root:PROCESS:KyEnd
	Variable SWInteStart=root:PROCESS:IntegrationStart
	Variable SWInteEnd=root:PROCESS:IntegrationEnd
	
	DoWindow/F $windowname
	if (V_flag==0)
          Display;appendimage $popStr
	        ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
	        ModifyGraph width={Plan,1,bottom,left}
	        ModifyGraph standoff=0
	        ModifyGraph fStyle=1
	        ModifyGraph fSize=12
	        SetAxis left PTO_NKyStart,PTO_NKyEnd;DelayUpdate
                SetAxis bottom PTO_NKxStart,PTO_NKxEnd
             //   ModifyGraph width={Aspect,1}
             //   Textbox/C/N=text0/A=RT/F=0 ImageLabel 
                ModifyGraph margin(left)=58,margin(bottom)=58
                Label left "\\Z16\\f01k\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	            Label bottom "\\Z16\\f01k\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	            TextBox/C/N=text1/F=0/A=MC num2str(SWInteStart*1000)+" ~ "+num2str(SWInteEnd*1000)+" meV"
	        ShowInfo
	        DoWindow/C $windowname
	 else
	 DoWindow/F $windowname
    endif
End

Proc Plot4FS(ctrlName) : ButtonControl
	String ctrlName
	Setdatafolder root:IMG
	Newdatafolder/O SYM
	Variable Dsizex=DimSize($SYM_FS_name, 0)
    Variable Dsizey=DimSize($SYM_FS_name, 1)
    Variable minx=DimOffset($SYM_FS_name, 0)
    Variable miny=DimOffset($SYM_FS_name, 1)
    Variable Dx=DimDelta($SYM_FS_name, 0)
    Variable Dy=DimDelta($SYM_FS_name, 1)
   	Variable PTO_NKxStart=root:PROCESS:KxStart
	Variable PTO_NKxEnd=root:PROCESS:KxEnd
	Variable PTO_NKyStart=root:PROCESS:KyStart
	Variable PTO_NKyEnd=root:PROCESS:KyEnd
	Variable SWInteStart=root:PROCESS:IntegrationStart
	Variable SWInteEnd=root:PROCESS:IntegrationEnd

    Variable maxx=minx+(Dsizex-1)*Dx
    Variable maxy=miny+(Dsizey-1)*Dy
    String orgname=root:IMG:SYM_FS_name
    String SYMname="SYM4"+num2str(root:IMG:Four_F_sym)+root:IMG:SYM_FS_name
    Variable TempxP1,TempxP2,DPx,TempyP1,TempyP2,DPy,ix,iy
       Print minx,Dx,maxx,miny,Dy,maxy,Dsizex,Dsizey
       

    Setdatafolder root:IMG:SYM
    
    if (root:IMG:Four_F_sym==1)
 
     Duplicate/O root:IMG:$orgname, root:IMG:SYM:Temp1,root:IMG:SYM:Temp2
     ImageRotate /A=180 Temp1
     Duplicate/O M_RotatedImage,Temp3
     MatrixTranspose Temp2
     ImageRotate /A=90 Temp2
     Duplicate/O M_RotatedImage,Temp2
     ImageRotate /A=180 Temp2
     Duplicate/O M_RotatedImage,Temp4

    endif
    
     if (root:IMG:Four_F_sym==2)
      Duplicate/O root:IMG:$orgname, root:IMG:SYM:Temp2,root:IMG:SYM:Temp1
     ImageRotate /A=180 Temp2
     Duplicate/O M_RotatedImage,Temp4
     MatrixTranspose Temp1
     ImageRotate /A=90 Temp1
     Duplicate/O M_RotatedImage,Temp1
     ImageRotate /A=180 Temp1
     Duplicate/O M_RotatedImage,Temp3
    endif
    
     if (root:IMG:Four_F_sym==3)
     Duplicate/O root:IMG:$orgname, root:IMG:SYM:Temp3,root:IMG:SYM:Temp4
     ImageRotate /A=180 Temp3
     Duplicate/O M_RotatedImage,Temp1
     MatrixTranspose Temp4
     ImageRotate /A=90 Temp4
     Duplicate/O M_RotatedImage,Temp4
     ImageRotate /A=180 Temp4
     Duplicate/O M_RotatedImage,Temp2
    endif
    
     if (root:IMG:Four_F_sym==4)
     Duplicate/O root:IMG:$orgname, root:IMG:SYM:Temp4,root:IMG:SYM:Temp3
     ImageRotate /A=180 Temp4
     Duplicate/O M_RotatedImage,Temp2
     MatrixTranspose Temp3
     ImageRotate /A=90 Temp3
     Duplicate/O M_RotatedImage,Temp3
     ImageRotate /A=180 Temp3
     Duplicate/O M_RotatedImage,Temp1
    endif
    
    Setscale/P x,minx,Dx,Temp2,Temp3,Temp4
    Setscale/P y,miny,Dy,Temp2,Temp3,Temp4
    
     TempxP1=round(Dsizex/2)
     TempxP2=Dsizex
     DPx=2*(TempxP2-TempxP1)
         
     TempyP1=round(Dsizey/2)
    TempyP2=Dsizey
     DPy=2*(TempyP2-TempyP1)
     
    Temp1[0,TempxP1-1][]=0
    Temp1[][0,TempyP1-1)=0
 //   Temp1(minx,0)()=0
 //   Temp1()(miny,0)=0
      
     Temp2[TempxP1,][]=0
     Temp2[][0,TempyP1-1]=0
 //    Temp2(0,)()=0
 //  Temp2()(miny,0)=0
    Temp3[TempxP1,][]=0
    Temp3[][TempyP1,]=0
//    Temp3(0,)()=0
//    Temp3()(0,)=0
    Temp4[0,TempxP1-1][]=0
    Temp4[][TempyP1,]=0
//    Temp4(minx,0)()=0
//    Temp4()(0,)=0
    
    Duplicate/O root:IMG:$orgname, root:IMG:SYM:$SYMname
   $SYMname=Temp1+Temp2+Temp3+Temp4
   
   	DoWindow/F $SYMname+"4_Fold"
	if (V_flag==0)
          Display;appendimage $SYMname
	        ModifyImage $SYMname ctab= {*,*,PlanetEarth,1}
	        ModifyGraph width={Plan,1,bottom,left}
	        ModifyGraph standoff=0
	        ModifyGraph fStyle=1
	        ModifyGraph fSize=12
	        SetAxis left PTO_NKyStart,PTO_NKyEnd;DelayUpdate
                SetAxis bottom PTO_NKxStart,PTO_NKxEnd
             //   ModifyGraph width={Aspect,1}
             //   Textbox/C/N=text0/A=RT/F=0 ImageLabel 
                ModifyGraph margin(left)=58,margin(bottom)=58
                Label left "\\Z16\\f01k\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	            Label bottom "\\Z16\\f01k\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	        ShowInfo
	        DoWindow/C $SYMname+"4_Fold"
	 else
	 DoWindow/F $SYMname+"4_Fold"
    endif
    
End


Proc Plot8FS(ctrlName) : ButtonControl
	String ctrlName
	Setdatafolder root:IMG
	Newdatafolder/O SYM
	Variable Dsizex=DimSize($SYM_FS_name, 0)
    Variable Dsizey=DimSize($SYM_FS_name, 1)
    Variable minx=DimOffset($SYM_FS_name, 0)
    Variable miny=DimOffset($SYM_FS_name, 1)
    Variable Dx=DimDelta($SYM_FS_name, 0)
    Variable Dy=DimDelta($SYM_FS_name, 1)
   	Variable PTO_NKxStart=root:PROCESS:KxStart
	Variable PTO_NKxEnd=root:PROCESS:KxEnd
	Variable PTO_NKyStart=root:PROCESS:KyStart
	Variable PTO_NKyEnd=root:PROCESS:KyEnd
	Variable SWInteStart=root:PROCESS:IntegrationStart
	Variable SWInteEnd=root:PROCESS:IntegrationEnd

    Variable maxx=minx+(Dsizex-1)*Dx
    Variable maxy=miny+(Dsizey-1)*Dy
    String orgname=root:IMG:SYM_FS_name
    String SYMname="SYM8"+num2str(root:IMG:Four_F_sym)+root:IMG:SYM_FS_name
    Variable TempxP1,TempxP2,DPx,TempyP1,TempyP2,DPy,ix,iy
//       Print minx,Dx,maxx,miny,Dy,maxy,Dsizex,Dsizey    
     TempxP1=round(Dsizex/2)
     TempxP2=Dsizex
     DPx=2*(TempxP2-TempxP1)
         
     TempyP1=round(Dsizey/2)
    TempyP2=Dsizey
     DPy=2*(TempyP2-TempyP1)
     
    Setdatafolder root:IMG:SYM
//    Duplicate/O root:IMG:$orgname, root:IMG:SYM:Temp1M1,root:IMG:SYM:Temp1M2
    Duplicate/O root:IMG:$orgname, root:IMG:SYM:Temp1,root:IMG:SYM:Temp2
    if (root:IMG:Eight_F_sym==1)
    MatrixTranspose Temp2        
    endif
    
     if (root:IMG:Eight_F_sym==2)
    MatrixTranspose Temp1     
    endif
    
     if (root:IMG:Eight_F_sym==3)
    ImageRotate /A=-90 Temp1
    Duplicate/O M_RotatedImage,Temp1
    MatrixTranspose Temp2
    ImageRotate /A=90 Temp2
    Duplicate/O M_RotatedImage,Temp2
    endif
    
     if (root:IMG:Eight_F_sym==4)
    ImageRotate /A=-90 Temp2
    Duplicate/O M_RotatedImage,Temp2
    MatrixTranspose Temp1
    ImageRotate /A=90 Temp1
    Duplicate/O M_RotatedImage,Temp1   
    endif
    
    if (root:IMG:Eight_F_sym==5)
    ImageRotate /A=180 Temp1
    Duplicate/O M_RotatedImage,Temp1
    MatrixTranspose Temp2
    ImageRotate /A=180 Temp2
    Duplicate/O M_RotatedImage,Temp2 
    endif  

    if (root:IMG:Eight_F_sym==6)
    ImageRotate /A=180 Temp2
    Duplicate/O M_RotatedImage,Temp2
    MatrixTranspose Temp1
    ImageRotate /A=180 Temp1
    Duplicate/O M_RotatedImage,Temp1 
    endif 
    
        if (root:IMG:Eight_F_sym==7)
    ImageRotate /A=90 Temp1
    Duplicate/O M_RotatedImage,Temp1
    MatrixTranspose Temp2
    ImageRotate /A=-90 Temp2
    Duplicate/O M_RotatedImage,Temp2
    endif
    
            if (root:IMG:Eight_F_sym==8)
    ImageRotate /A=90 Temp2
    Duplicate/O M_RotatedImage,Temp2
    MatrixTranspose Temp1
    ImageRotate /A=-90 Temp1
    Duplicate/O M_RotatedImage,Temp1
    endif
    
    ix=0
     do
    Temp1[0,ix-1][ix,ix]=0
    ix+=1
    while(ix<Dsizex)
    
    ix=0
     do
    Temp2[ix,ix][0,ix]=0
    ix+=1
    while(ix<Dsizex)
    Temp1+=Temp2
     ImageRotate /A=90 Temp1
     Duplicate/O M_RotatedImage,Temp2
     ImageRotate /A=180 Temp1
     Duplicate/O M_RotatedImage,Temp3
     ImageRotate /A=270 Temp1
     Duplicate/O M_RotatedImage,Temp4
    Setscale/P x,minx,Dx,Temp1,Temp2,Temp3,Temp4
    Setscale/P y,miny,Dy,Temp1,Temp2,Temp3,Temp4
    Temp1[0,TempxP1-1][]=0
    Temp1[][0,TempyP1-1)=0

      
     Temp2[TempxP1,][]=0
     Temp2[][0,TempyP1-1]=0

    Temp3[TempxP1,][]=0
    Temp3[][TempyP1,]=0

    Temp4[0,TempxP1-1][]=0
    Temp4[][TempyP1,]=0
    
    Duplicate/O root:IMG:$orgname, root:IMG:SYM:$SYMname
   $SYMname=Temp1+Temp2+Temp3+Temp4
   	DoWindow/F $SYMname+"8_Fold"
	if (V_flag==0)
          Display;appendimage $SYMname
	        ModifyImage $SYMname ctab= {*,*,PlanetEarth,1}
	        ModifyGraph width={Plan,1,bottom,left}
	        ModifyGraph standoff=0
	        ModifyGraph fStyle=1
	        ModifyGraph fSize=12
	        SetAxis left PTO_NKyStart,PTO_NKyEnd;DelayUpdate
                SetAxis bottom PTO_NKxStart,PTO_NKxEnd
             //   ModifyGraph width={Aspect,1}
             //   Textbox/C/N=text0/A=RT/F=0 ImageLabel 
                ModifyGraph margin(left)=58,margin(bottom)=58
                Label left "\\Z16\\f01k\\By\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	            Label bottom "\\Z16\\f01k\\Bx\\M\\Z16 (\\F'Symbol'p\\F'Arial'/a)"
	        ShowInfo
	        DoWindow/C $SYMname+"8_Fold"
	 else
	 DoWindow/F $SYMname+"8_Fold"
    endif
    
End

Function Exitproc(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
        Dowindow/K FS_SYM_Panel
	
	SetDataFolder Curr
	
End
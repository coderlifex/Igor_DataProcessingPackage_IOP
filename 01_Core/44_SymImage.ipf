#pragma rtGlobals=1		// Use modern global access method.f

proc  symmetrize()
string curr=getdatafolder(1)
string wavenames=wavelist("*",";","DIMS:2")
DoWindow/F ImageSymPanel
  if(V_flag==0)
    newdatafolder/o root:Sym
    setdatafolder root:Sym
   variable/G Symstyle=NumVarOrDefault("root:sym:Symstyle",4)
   variable/G checked2=NumVarOrDefault("root:sym:checked2",0)
    variable/G checked3=NumVarOrDefault("root:sym:checked3",0)
     variable/G checked4=NumVarOrDefault("root:sym:checked4",1)
      variable/G checked6=NumVarOrDefault("root:sym:checked6",0)
       variable/G checked8=NumVarOrDefault("root:sym:checked8",0)
        variable/G checkedmirror=NumVarOrDefault("root:sym:checkedmirror",0)
       variable/G checkedany=NumVarOrDefault("root:sym:checkedany",0)
       variable/G Symanytimes=NumVarOrDefault("root:sym:Symanytimes",0)
       string/G Symcenter=StrVarOrDefault("root:sym:Symcenter","0,0")
       string/G Point2=StrVarOrDefault("root:sym:point2","1,0")
       variable/G QuadrantNum=NumVarOrDefault("root:sym:QuadrantNum",1)
       variable/G angle=NumVarOrDefault("root:sym:angle",pi/2)
       variable/G error=NumVarOrDefault("root:sym:error",0.2)
      String/G allofimage=wavenames
       ImageSymPanel()
  endif
  setdatafolder curr
end
Function PopImageName(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
        String Curr=GetDataFolder(1)
        print curr
	//setdatafolder root:sym
	Dowindow $popstr
	if(V_flag==0)
	display
	appendImage $popstr
	ModifyGraph width={Aspect,1}
	ModifyImage $popstr ctab= {*,*,PlanetEarth256,1}
	endif
	setdatafolder root:sym
	string/G TobesymImage=popstr
	if(stringmatch(Curr,"root:sym:"))
	else
	SetDataFolder Curr
	duplicate/O $popstr,root:Sym:$popstr
	endif
End


Window ImageSymPanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(546,125,971,456)
	ShowTools
	SetDrawLayer UserBack
	TitleBox title0,pos={9,4},size={102,21},title="Please select image",frame=5
	PopupMenu popImageName,pos={9,23},size={271,21},proc=PopImageName
	PopupMenu popImageName,mode=1,bodyWidth= 271,popvalue="Co000FS",value= #"root:sym:allofimage"
	TitleBox title2,pos={10,46},size={116,21},title="Please select sym style"
	TitleBox title2,frame=5
	GroupBox Symbox,pos={10,69},size={266,44},frame=0
	CheckBox Sym2,pos={15,74},size={47,14},proc=Sym2,title="2 Sym"
	CheckBox Sym2,variable= root:Sym:checked2,mode=1
	CheckBox Sym3,pos={65,74},size={47,14},proc=Sym3,title="3 Sym"
	CheckBox Sym3,variable= root:Sym:checked3,mode=1
	CheckBox Sym4,pos={116,74},size={47,14},proc=Sym4,title="4 Sym"
	CheckBox Sym4,variable= root:Sym:checked4,mode=1
	CheckBox Sym6,pos={167,75},size={47,14},proc=Sym6,title="6 Sym"
	CheckBox Sym6,variable= root:Sym:checked6,mode=1
	CheckBox Sym8,pos={218,75},size={47,14},proc=Sym8,title="8 Sym"
	CheckBox Sym8,variable= root:Sym:checked8,mode=1
	TitleBox title4,pos={15,122},size={191,21},title="Set start line (Please Input  Coordinate)"
	TitleBox title4,frame=5
	SetVariable CenterPoint,pos={15,147},size={118,16},value= root:Sym:Symcenter
	SetVariable Point2,pos={141,147},size={102,16},value= root:Sym:Point2
	Button B_RemoveSymLine,pos={86,269},size={95,23},proc=B_Removesymline,title="Remove SymLine"
	Button B_Sym,pos={86,239},size={95,23},proc=B_sym,title="Sym"
	PopupMenu popSelectQua,pos={17,189},size={122,21},proc=PopSelectQua,title="Select Quadrant"
	PopupMenu popSelectQua,mode=4,bodyWidth= 40,popvalue="",value= #"\"1;2\""
	PopupMenu popSymTimes,pos={18,211},size={93,21},proc=PopSymTimes,title="SymTimes"
	PopupMenu popSymTimes,mode=3,bodyWidth= 40,popvalue="",value= #"\"2\""
	Button Refresh,pos={178,3},size={50,20},proc=B_Refresh,title="Refresh"
	CheckBox Symany,pos={76,96},size={84,14},proc=Symany,title="AnyTimesSym"
	CheckBox Symany,variable= root:Sym:checkedany,mode=1
	SetVariable anytimesymtimes,pos={166,95},size={106,16},disable=2,proc=SetVarRAngle,title="RotateAngle"
	SetVariable anytimesymtimes,limits={0,inf,1},value= root:Sym:Symanytimes
	CheckBox SymMirror,pos={15,95},size={44,14},proc=Symmirror,title="Mirror"
	CheckBox SymMirror,variable= root:Sym:checkedmirror,mode=1
	SetVariable setvarError,pos={150,189},size={97,16},title="Error"
	SetVariable setvarError,limits={-inf,inf,0.01},value= root:Sym:error
	Button OKbutton,pos={18,167},size={50,20},proc=OKButton,title="OK"
EndMacro


proc Sym6(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	string curr=getdatafolder(1)
	setdatafolder root:sym
	checked3=0
	checked4=0
	checked2=0
	checked8=0
	checkedany=0
	checkedmirror=0
	symstyle=6
	PopupMenu popSymTimes,value= #"\"2;3;4;5;6\""
	PopupMenu popSelectQua,value= #"\"1;2;3;4\""
	SetVariable anytimesymtimes,disable=2
	variable/G angle
	angle=2*pi/symstyle
	setdatafolder  curr
	

End
proc Sym8(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	string curr=getdatafolder(1)
	setdatafolder root:sym
	checked3=0
	checked4=0
	checked6=0
	checked2=0
	checkedany=0
	checkedmirror=0
	symstyle=8
	PopupMenu popSymTimes,value= #"\"2;3;4;5;6;7;8\""
	PopupMenu popSelectQua,value= #"\"1;2;3;4\""
	SetVariable anytimesymtimes,disable=2
	variable/G angle
	angle=2*pi/symstyle
	setdatafolder  curr
End

proc Symany(ctrlName,Checkedany) : CheckBoxControl
String ctrlName
	Variable checkedany
	string curr=getdatafolder(1)
	setdatafolder root:sym
	checked3=0
	checked4=0
	checked6=0
	checked2=0
	checked8=0
	checkedmirror=0
	PopupMenu popSelectQua,value= #"\"1;2;3;4\""
	setvariable anytimesymtimes,disable=0
	setdatafolder  curr
end




proc B_Removesymline(ctrlName) : ButtonControl
	String ctrlName

End

proc B_sym(ctrlName) : ButtonControl
         String ctrlName
	silent 1; pauseupdate
	string curr=getdatafolder(1)
	setdatafolder root:sym
	
	string ToBeKilledList=Wavelist("sym*",";","DIMS:2")
	Variable NoofKilledList=ItemsinList(ToBeKilledList,";")
	string Symname
	variable iSymname=0
	variable n
	variable n1
	do 
	  Symname=stringfromlist(isymname,ToBeKilledList,";")
	  Killwaves/Z $Symname
	  isymname+=1
	while(iSymname<NoofKilledlist)  
	imagecut(a0,a1,a2,QuadrantNum,Tobecutimage)
	variable i=1,j
	variable/G Nmaxsym=0
	string rotimagename
	variable angleDegree=angle/pi*180
	string expandimagename
	variable Difangle
	variable nn
	//2 folding symmetry
	if(symstyle==2)
	  if(checked2==1)
	  rotimagename="symimage1"
	  Imagerotate/A=180/E=0 $Cutimagename
	  duplicate/o $cutimagename,totalsymimage
	  totalsymimage+=M_RotatedIMage
	  endif
       endif
	 //mirror symmetry
	  if(symstyle==2)
	   if(checkedmirror==1)
	     if (QuadrantNum==1)
	    difangle=0.25*pi-atan(a0)
	    imagerotate/A=(difangle*180/pi)/E=0 $cutimagename
	    duplicate/o M_RotatedImage,totalsymimage
	     n1=dimsize(M_rotatedImage,0)
	    
	     i=0
	      do
	      j=0
	      do
	      if(i==j)
	      M_rotatedImage[i][j]/=2
	      else
	      M_rotatedImage[i][j]=0
	      endif
	      j+=1
	      while (j<=i)
	      i+=1
	      while (i<n1)
	      endif
	     
	      if (QuadrantNum==3)
	      difangle=0.25*pi-atan(a0)
	    imagerotate/A=(difangle*180/pi)/E=0 $cutimagename
	    duplicate/o M_RotatedImage,totalsymimage
	     n1=dimsize(M_rotatedImage,0)
	     i=0
	      do
	      j=i
	      do
	      if(i==j)
	      M_rotatedImage[i][j]/=2
	      else
	      M_rotatedImage[i][j]=0
	      endif
	      j+=1
	      while (j<n1)
	      i+=1
	      while (i<n1)
	      endif
	      totalsymimage=M_rotatedImage
	     matrixtranspose M_rotatedImage
	     totalsymimage+=M_rotatedImage
	     M_rotatedImage=totalsymimage
	      i=0
	      do
	      M_rotatedImage[i][i]= totalsymimage[i][i+2]
	      M_rotatedImage[i+1][i]= totalsymimage[i][i+2]
	      M_rotatedImage[i][i+1]= totalsymimage[i][i+2]
	      i+=1
	      while (i<(n1-2))
	    
	     totalsymimage=M_rotatedImage
	    imagerotate/A=(-difangle*180/pi)/E=0 totalsymimage
	   duplicate/o M_rotatedImage,totalsymimage
	   
	   endif
	  endif 
	  
if(symstyle==2)
	else
	i=1
	 do 
	  rotimagename="symimage"+num2str(i)
	  imagerotate/A=(angleDegree*i)/E=0 $cutimagename
	  Nmax=dimsize(M_RotatedImage,1)
	  if (Nmax>Nmaxsym)
	  Nmaxsym=Nmax
	  endif
	  duplicate/o M_RotatedImage,$rotimagename
	   i+=1
       while(i<(symtimes))
	 expandimagename="exp"+cutimagename
	 Expandimage2(Nmaxsym,cutimagename)
	 duplicate/o $expandimagename,totalsymimage
	i=1
	 do
	  rotimagename="symimage"+num2str(i)
	  Expandimage2(Nmaxsym,rotimagename)
	  expandimagename="exp"+rotimagename
	  totalsymimage+=$expandimagename
	  i+=1
	 while(i<(symtimes))
	endif
	variable xstart,ystart
nn=dimsize(totalsymimage,1)
xstart=centerx-((nn-1)/2)*xinc 
ystart=centery-((nn-1)/2)*yinc 
setscale/P x,xstart,xinc,totalsymimage
setscale/P y,ystart,yinc,totalsymimage 
Dowindow totalsymimage
	if(V_flag==0)
	display
	appendImage totalsymimage
	ModifyGraph width={Aspect,1}
	ModifyImage totalsymimage ctab= {*,*,PlanetEarth256,1}
	endif

	
	
	setdatafolder curr
End


Function/T ZLImgInfo( image )
//================
// creates variables in current folder
// returns info string
	wave image
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
	nx=DimSize(image, 0); 	ny=DimSize(image, 1)
	xmin=DimOffset(image,0);  ymin=DimOffset(image,1);
	xinc=round(DimDelta(image,0) * 1E6) / 1E6	
	yinc=round(DimDelta(image,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1);
	WaveStats/Q image
	dmin0=V_min;  dmax0=V_max
	string info="x: "+num2istr(nx)+", "+num2str(xmin)+", "+num2str(xinc)+", "+num2str(xmax)
	info+=    "\r y: "+num2istr(ny)+", "+num2str(ymin)+", "+num2str(yinc)+", "+num2str(ymax)
	info+=    "\r z: "+num2str(dmin0)+", "+num2str(dmax0)
	return info
End

proc ExpandImage(n,ncx,ncy,imagename)
    variable n
    variable ncx
    variable ncy
    string imagename
    silent 1;pauseupdate
    string Expimagename="Exp"+imagename
    variable/G Nmax
    Nmax=n-ncx
    if (Nmax<(n-ncy))
    Nmax=n-ncy
    endif
    if (Nmax<ncx)
    Nmax=ncx
    endif
    if (Nmax<ncy)
    Nmax=ncy
    endif
    make/o/n=((2*Nmax),(2*Nmax)) $Expimagename
    $Expimagename=0
    variable i=0
    variable j=0
    do 
      j=0
      do
      $ExpimageName[Nmax-Ncx+i][Nmax-ncy+j]=$imagename[i][j]
      j+=1
      while (j<nx)
     i+=1 
   while (i<ny)

 end
 
 proc ExpandImage2(n,imagename)
    variable n
    string imagename
    variable n1,n2
    silent 1;pauseupdate
    n1=dimsize($imagename,1)
    string Expimagename="Exp"+imagename
    make/o/n=(n,n) $Expimagename
    $Expimagename=0
    n2=round((n-n1)/2)
    variable i=0
    variable j=0
    do 
      j=0
      do
      $ExpimageName[n2+i][n2+j]=$imagename[i][j]
      j+=1
      while (j<n1)
     i+=1 
   while (i<n1)

 end
 
 
 proc ImageCut(x0,x1,x2,QuadrantNum,imagename)
   variable x0
   variable x1
   variable x2
   variable QuadrantNum
   string imagename
   silent 1;pauseupdate
   variable a1
   variable i
   variable j
   variable b0,b1,b2
   variable n=dimsize($imagename,0)
   string/G cutimagename="cut"+imagename
   duplicate/O $imagename,$cutimagename
   $cutimagename=0
// if (abs(angle-pi)<0.001)
 b0=(n-1)*(1-x0)/2
 b1=(n-1)*(1-x1)/2
 b2=(n-1)*(1-x2)/2
     if(QuadrantNum==1)
      i=0
     do
     j=0
       do
        if(j>(x0*i+b0) && j>=(x1*i+b1))
        $cutimagename[i][j]=$imagename[i][j]
        endif
        j+=1
      while(j<n)
      i+=1
     while (i<n)
    endif
    if(QuadrantNum==2)
       i=0
     do
     j=0
       do
        if(j<(x0*i+b0) && j>=(x2*i+b2))
        $cutimagename[i][j]=$imagename[i][j]
        endif
        j+=1
      while(j<n)
      i+=1
     while (i<n)
   endif
   if(QuadrantNum==3)
     i=0
     do
     j=0
       do
        if(Symstyle==2)
           if(j<=(x0*i+b0) && j<(x1*i+b1))
           //else
           $cutimagename[i][j]=$imagename[i][j]
           endif
        else
        if(j<(x0*i+b0) && j>=(x1*i+b1))
        $cutimagename[i][j]=$imagename[i][j]
         endif
        endif
        j+=1
      while(j<n)
      i+=1
     while (i<n)
   endif
   if(QuadrantNum==4)
       i=0
     do
     j=0
       do
        if(j>(x0*i+b0) && j<=(x2*i+b2))
        $cutimagename[i][j]=$imagename[i][j]
        endif
        j+=1
      while(j<n)
      i+=1
     while (i<n)
   endif
//if (abs(angle-pi)>0.001)
  //if(QuadrantNum==1 || QuadrantNum==3)
  // angle=angle
   //else
   //angle=-1*angle
  //endif
   
   //a1=(a0+tan(angle))/(1-a0*tan(angle))
   
   //b0=(n-1)*(1-a0)/2
   //b1=(n-1)*(1-a1)/2
   
   
  //if(QuadrantNum==1)
    //i=0
     //do
     //j=0
       //do
        //if((j>=(a0*i+b0))&&(j<(a1*i+b1)))
        //else
        //$cutimagename[i][j]=0
        //endif
       // j+=1
      //while(j<n)
      //i+=1
     //while (i<n)
    // endif
    //if (QuadrantNum==2)
     
    //i=0
    // do
     //j=0
    //   do
    //    if((j>=(a0*i+b0))&&(j>(a1*i+b1)))
      //  else
    //    $cutimagename[i][j]=0
     //   endif
    //    j+=1
     // while(j<n)
   ////   i+=1
  ///   while (i<n) 
//   endif
//   if(QuadrantNum==3)
 //   i=0
    // do
    // j=0
    //   do
     //   if((j<=(a0*i+b0))&&(j>(a1*i+b1)))
     //   else
    //    $cutimagename[i][j]=0
   //     endif
   //     j+=1
  //    while(j<n)
  //    i+=1
   //  while (i<n) 
   // endif
    //if (QuadrantNum==4)
   // i=0
     //do
    //j=0
     //  do
   //     if((j<=(a0*i+b0))&&(j<(a1*i+b1)))
   //     else
     //   $cutimagename[i][j]=0
      //  endif
    //    j+=1
    //  while(j<n)
   //   i+=1
    // while (i<n) 
     //endif
   //endif
End  
   
proc PopSymTimes(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string curr=getdatafolder(1)
   variable/G symtimes=str2num(popstr)
   
   setdatafolder curr
End

Proc B_Refresh(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	string wavenames=wavelist("*",";","DIMS:2")
	setdatafolder root:sym
	allofimage=wavenames
	
	setdatafolder curr

End

Proc SetVarRAngle(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string curr=getdatafolder(1)
	setdatafolder root:sym
	angle=varnum*pi/180
	variable n
	variable i=3
	n=ceil(360/varnum)
	string popstr0="2"
	if (n>2)
	do
	 popstr0+=";"
	 popstr0+=num2str(i)
	 i+=1
	while (i<n)
	endif
	
	PopupMenu popsymtimes,value= #"\"1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18\""

End

//PopupMenu popSelectQua,value= #"\"1;2;3;4\""

proc OKButton(ctrlName) : ButtonControl
	String ctrlName
	string curr=getdatafolder(1)
	silent 1; pauseupdate 
	setdatafolder root:sym
	variable/G Centerx
	variable/G centery
	variable/G point2x
	variable/G point2y
	centerx=str2num(stringfromlist(0,symcenter,","))
	centery=str2num(stringfromlist(1,symcenter,","))
	point2x=str2num(stringfromlist(0,point2,","))
	point2y=str2num(stringfromlist(1,point2,","))
	variable/G a0=(point2y-centery)/(point2x-centerx)
	if(abs(point2x-centerx)<0.001)
	  if(a0>0)
	  a0=1000
	  else
	   a0=-1000
	   endif
	endif
	ZLImgInfo($TobesymImage)
	variable ncx,ncy
	ncx=round((centerx-xmin)/xinc)
	ncy=round((centery-ymin)/yinc)
	ExpandImage(nx,ncx,ncy,tobesymimage)
	string/G tobecutimage="Exp"+tobesymimage
	variable nn=dimsize($tobecutimage,1)
        variable xstart=centerx-((nn-1)/2)*xinc 
         variable ystart=centery-((nn-1)/2)*yinc 
        setscale/P x,xstart,xinc,$tobecutimage
        setscale/P y,ystart,yinc,$tobecutimage
        ZLImgInfo($TobecutImage)
	Make/o/n=2 QuadrantLine0y
	Make/o/n=2 QuadrantLinex
	Make/o/n=2 QuadrantLine1y
	Make/o/n=2 QuadrantLine2y
	variable b0=Centery-a0*Centerx
	QuadrantLinex={xmin,xmax}
	QuadrantLine0y=a0*QuadrantLinex+b0
	variable angle0=atan(a0)
	variable angle1=angle0+angle
	variable angle2=angle0-angle
	variable/G a1=tan(angle1)
	variable/G a2=tan(angle2)
	if (a1^2>1000000)
	  if(a1>0)
	  a1=1000
	  else
	  a1=-1000
          endif
	endif
	if(a2^2>1000000)
	  if(a2>0)
	  a2=1000
	  else
	  a2=-1000
	  endif
	endif
	
	variable/G b1=Centery-a1*Centerx
	QuadrantLine1y=a1*QuadrantLinex+b1
	variable/G b2=Centery-a2*Centerx
	QuadrantLine2y=a2*QuadrantLinex+b2
	
	Display;AppendImage $tobecutimage
	SetAxis/R left ymin,ymax
	SetAxis/R Bottom xmin,xmax
	ModifyImage $tobecutimage ctab= {*,*,PlanetEarth,1}
	ModifyGraph width={Aspect,1}
	ModifyGraph height=300
	SetAxis bottom ymin,ymax
        SetAxis  left xmin,xmax
	appendtograph QuadrantLine0y vs QuadrantLinex
	appendtograph QuadrantLine1y vs QuadrantLinex
	appendtograph QuadrantLine2y vs QuadrantLinex
	ModifyGraph rgb(QuadrantLine1y)=(0,0,0),rgb(QuadrantLine2y)=(0,0,0)
	variable nnn=2*Nmax
	variable a3=tan(angle0+angle/2)
	variable a4=tan(angle0-angle/2)
	variable b3=Centery-a3*Centerx
	variable b4=Centery-a4*Centerx
         variable Annpos0=xmin*a3+b3
         variable Annpos1=(900/(1+a3^2))^0.5
	  if(Annpos0>a0*xmin+b0 && Annpos0>a1*xmin+b1)
	TextBox/C/N=text0/D=2/A=MC/X=(-1*Annpos1)/Y=(a3*-1*Annpos1) "1"
	TextBox/C/N=text1/D=2/A=MC/X=(Annpos1)/Y=(a3*Annpos1) "3"
	else 
	TextBox/C/N=text0/D=2/A=MC/X=(-1*Annpos1)/Y=(a3*-1*Annpos1) "3"
	TextBox/C/N=text1/D=2/A=MC/X=(Annpos1)/Y=(a3*Annpos1) "1"
	endif
	
	    Annpos0=xmin*a4+b4
	   Annpos1=(900/(1+a4^2))^0.5
	   if(symstyle==2)
	      else
	    if(Annpos0<a0*xmin+b0 && Annpos0>a2*xmin+b2)
	    TextBox/C/N=text2/D=2/A=MC/X=(-1*Annpos1)/Y=(a4*-1*Annpos1) "2"
	   TextBox/C/N=text3/D=2/A=MC/X=(Annpos1)/Y=(a4*Annpos1) "4"
            else  
            TextBox/C/N=text2/D=2/A=MC/X=(-1*Annpos1)/Y=(a4*-1*Annpos1) "4"
	    TextBox/C/N=text3/D=2/A=MC/X=(Annpos1)/Y=(a4*Annpos1) "2"
             endif
         endif    
          setdatafolder curr
End




proc Sym4(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	string curr=getdatafolder(1)
	setdatafolder root:sym
	checked3=0
	checked2=0
	checked6=0
	checked8=0
	checkedany=0
	checkedmirror=0
	symstyle=4
	PopupMenu popSymTimes,value= #"\"2;3;4\""
	PopupMenu popSelectQua,value= #"\"1;2;3;4\""
	SetVariable anytimesymtimes,disable=2
	variable/G angle
	angle=2*pi/symstyle
	setdatafolder  curr
	

End

proc Sym3(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	string curr=getdatafolder(1)
	setdatafolder root:sym
	checked2=0
	checked4=0
	checked6=0
	checked8=0
	checkedany=0
	checkedmirror=0
	symstyle=3
	PopupMenu popSymTimes,value= #"\"2;3\""
	PopupMenu popSelectQua,value= #"\"1;2;3;4\""
	SetVariable anytimesymtimes,disable=2
	variable/G angle
	angle=2*pi/symstyle
	setdatafolder  curr
	

End


proc Sym2(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	string curr=getdatafolder(1)
	setdatafolder root:sym
	checked3=0
	checked4=0
	checked6=0
	checked8=0
	checkedany=0
	checkedmirror=0
	symstyle=2
	Popupmenu popSymTimes,value=#"\"2\""
	PopupMenu popSelectQua,value= #"\"1;3\""
	SetVariable anytimesymtimes,disable=2
	variable/G angle
	angle=2*pi/symstyle
	setdatafolder  curr
	

End

proc Symmirror(ctrlName,Checkedmirror) : CheckBoxControl
String ctrlName
	Variable checkedmirror
	string curr=getdatafolder(1)
	setdatafolder root:sym
	checked3=0
	checked4=0
	checked6=0
	checked2=0
	checked8=0
	checkedany=0
	symstyle=2
	PopupMenu popSelectQua,value= #"\"1;3\""
	SetVariable anytimesymtimes,disable=2
		angle=2*pi/symstyle
		setdatafolder  curr
end

proc PopSelectQua(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string curr=getdatafolder(1)
	setdatafolder root:sym
	QuadrantNum=str2num(popstr)
	setdatafolder curr

End

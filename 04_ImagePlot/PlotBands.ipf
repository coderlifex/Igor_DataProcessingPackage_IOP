#pragma rtGlobals=1		// Use modern global access method.

proc plotbands_panel(ctrStr):ButtonControl
	string ctrStr
	dowindow/F PlotBands
	string curr
	if(V_Flag==0)
		newdatafolder/O root:CalculatedBands
		newdatafolder/O root:CalculatedBands:HighSymmetryPoints
		newdatafolder/O root:CalculatedBands:FermiSurface
		setdatafolder root:CalculatedBands
		variable/G totalbandsnumber,bandstart,bandend
		variable/G root:CalculatedBands:FermiSurface:BandIndex
		variable/G root:CalculatedBands:FermiSurface:Emin
		variable/G root:CalculatedBands:FermiSurface:Emax
		string/G root:CalculatedBands:FermiSurface:Fslist
		make/O/N=5 root:CalculatedBands:FermiSurface:tmpwave
		
		PlotBands()
	endif
end

proc openfile(ctrlName) : ButtonControl
	String ctrlName
	variable filerefer,ii=0,jj=0,xaxislablenumber=0,indexnumber,bandsnumber=0,kpointnumber=0
	string tmpstr,outputx,outputy
	setdatafolder root:CalculatedBands
	make/O/T/N=20 xlablename
	make/O/N=20 xlablepos
	
	open/R filerefer
//To find how many lables and K point values in the data set
//here uses the text format to extract the right number. it may be not robust further improvement will be done if problerms come up
	do
	     freadline filerefer,tmpstr
		//if(strsearch(tmpstr,"@ xaxis  tick major",0)>=0)
			if(strsearch(tmpstr,"bandindex",0)>=0)
			break
			endif		
			//	indexnumber=strsearch(tmpstr,".",0)
		//	if(indexnumber!=-1)
			
			xlablepos[xaxislablenumber]=str2num(tmpstr)
		//	freadline filerefer,tmpstr
			
		//	indexnumber=strsearch(tmpstr,",",0)
		//		if(stringmatch(tmpstr[indexnumber+2],"\\")==1)
		freadline filerefer,tmpstr
		//		xlablename[xaxislablenumber]="G"
		//		else
			xlablename[xaxislablenumber]=tmpstr
		 	xaxislablenumber+=1
	while(1) 
		 redimension/N=(xaxislablenumber) xlablename,xlablepos
		 //	endif
		 //endif
	variable spacepos,strlength
	do	 
		 if(strlen(tmpstr)==0)
		 break
		 endif
		 if(strsearch(tmpstr,"bandindex",0)>=0)
		 	bandsnumber+=1
		 	outputx="band"+num2str(bandsnumber)+"K"
		 	outputy="band"+num2str(bandsnumber)+"Energy"
		 	make/O/N=1000 $outputx,$outputy
		 	kpointnumber=0
		 	do
		 		freadline filerefer,tmpstr
		 		
		 		if(strsearch(tmpstr,"bandindex",0)>=0)
		 		break
		 		endif
		 		
		 		if(strlen(tmpstr)==0)
		 		break
		 		endif
		 		
		 		spacepos=strsearch(tmpstr," ",0)
		 		strlength=strlen(tmpstr)
		 		$outputx[kpointnumber]=str2num(tmpstr[0,spacepos])
		 		$outputy[kpointnumber]=str2num(tmpstr[spacepos+1,strlength])
		 		kpointnumber=kpointnumber+1
		 	  while(1)
		 	  redimension/N=(kpointnumber) $outputx,$outputy
		 		
		 	endif
		 	//if(kpointnumber==0)
		 	//do
		 	//	freadline filerefer,tmpstr
		 	//	if(strsearch(tmpstr,"&",0)>=0)
		 	//		break
		 	//	else
		 	//		kpointnumber+=1
		 	//	endif
		 	//while(1)
		 	//endif
		 //endif
		 //if(strlen(tmpstr)==0)
		 //break
		 //endif
	while(1)

//set the total bands number
  
   totalbandsnumber=bandsnumber
//read the data into respective waves
	
	string/G bandslist=""
	ii=1
	do
	bandslist+="band"+num2str(ii)+";"
	ii+=1
	while(ii<=bandsnumber)
	popupmenu choseindex,popvalue=bandslist[0,4],value=#bandslist
//construct the K postion lines	
	string curr
	curr=getdatafolder(1)
	string xlablen="xlablename",xlablep="xlablepos"
	duplicate/O xlablename root:CalculatedBands:HighSymmetryPoints:$xlablen
	duplicate/O xlablepos root:CalculatedBands:HighSymmetryPoints:$xlablep
	
	setdatafolder HighSymmetryPoints
	variable ifind=1
	string kposintensity,kposx
	ii=1
	do
		if(xlablepos[ii]==0)
		break
		endif
		ii+=1
	while(ii<20)
	ifind=ii
	ii=0
	do
		kposintensity="kposintensity"+num2str(ii)
		kposx="kposx"+num2str(ii)
		make/O/N=2 $kposintensity,$kposx
		$kposintensity[0]=-100
		$kposintensity[1]=100
		$kposx[0]=xlablepos[ii]
		$kposx[1]=xlablepos[ii]
		ii+=1
	while(ii<ifind)
	setdatafolder curr	
						
End

proc choseindex(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	variable ii
	
	setdatafolder root:CalculatedBands
	
	string bandintensity,bandk
	bandk=popStr+"K"
	bandintensity=popStr+"Energy"
	display $bandintensity vs $ bandk
		
	variable maximum,minimum,kpoints
	kpoints=dimsize($bandintensity,0)
	ii=0
	maximum=$bandintensity[ii]
	minimum=$bandintensity[ii]
	do
		ii=ii+1
		if($bandintensity[ii]>=maximum)
		maximum=$bandintensity[ii]
		endif
		if($bandintensity[ii]<=minimum)
		minimum=$bandintensity[ii]
		endif
	while(ii<kpoints)
	plotkpos(maximum,minimum)
	
	ModifyGraph lsize=2
    ModifyGraph zero(left)=2
    ModifyGraph tick=2,mirror=2,noLabel(bottom)=1,standoff=0
	TextBox/C/N=text0/F=0/A=MB/E=2 "\\Z14\\f01\\F'Times New Roman'K position"
	TextBox/C/N=text1/O=90/F=0/A=LC/X=3.00/Y=5.00/E "\\Z14\\f01\\F'Times New Roman'Energy (eV)"
	ModifyGraph fStyle(left)=1,fSize(left)=14
	
	
End

proc plotband(ctrlName) : ButtonControl
	String ctrlName
    setdatafolder root:CalculatedBands
    variable ii,random1,random2,random3
    string bandk,bandenergy
    bandk="band"+num2str(bandstart)+"K"
    bandenergy="band"+num2str(bandstart)+"Energy"
    display $bandenergy vs $bandk
    random1=abs(enoise(65536))
    random2=abs(enoise(65536))
    random3=abs(enoise(65536))
    ModifyGraph rgb($bandenergy)=(random1,random2,random3)
    ii=bandstart+1
    do
    	bandk="band"+num2str(ii)+"K"
    	bandenergy="band"+num2str(ii)+"Energy"
    	appendtograph $bandenergy vs $bandk
    	random1=abs(enoise(65536))
    	random2=abs(enoise(65536))
    	random3=abs(enoise(65536))
    	ModifyGraph rgb($bandenergy)=(random1,random2,random3)
    	ii=ii+1
    while(ii<=bandend)
    
    variable maximum,minimum,kpoints,jj
	kpoints=dimsize($bandenergy,0)
	bandenergy="band"+num2str(bandstart)+"Energy"
	maximum=$bandEnergy[ii]
	minimum=$bandEnergy[ii]
	ii=bandstart
	jj=0
	do
		
		bandenergy="band"+num2str(ii)+"Energy"
		jj=0
		do
			if($bandenergy[jj]>=maximum)
			maximum=$bandenergy[jj]
			endif
			if($bandenergy[jj]<=minimum)
			minimum=$bandenergy[jj]
			endif
			jj+=1
		while(jj<=kpoints)
		ii+=1
	while(ii<=bandend)
	plotkpos(maximum,minimum)
    
    ModifyGraph lsize=2
    ModifyGraph zero(left)=2
    ModifyGraph tick=2,mirror=2,noLabel(bottom)=1,standoff=0
	TextBox/C/N=text0/F=0/A=MB/E=2 "\\Z14\\f01\\F'Times New Roman'K position"
	TextBox/C/N=text1/O=90/F=0/A=LC/X=3.00/Y=5.00/E "\\Z14\\f01\\F'Times New Roman'Energy (eV)"
	ModifyGraph fStyle(left)=1,fSize(left)=14
    
End


Function exit_panel(ctrlName) : ButtonControl
	String ctrlName
	dowindow/K PlotBands
End

proc plotkpos(a,b)
	variable a
	variable b
	variable ii
	string curr
	curr=getdatafolder(1)
	setdatafolder root:CalculatedBands:HighSymmetryPoints
	
	variable ifind=1
	string kposintensity,kposx
	ii=1
	do
		if(xlablepos[ii]==0)
		break
		endif
		ii+=1
	while(ii<20)
	ifind=ii
	ii=0
	do
		kposintensity="kposintensity"+num2str(ii)
		$kposintensity[0]=b-1
		$kposintensity[1]=a+1
		ii+=1
	while(ii<ifind)
	
	ii=0
	do
		kposintensity="kposintensity"+num2str(ii)
		kposx="kposx"+num2str(ii)
		appendtograph $kposintensity vs $kposx
		ModifyGraph rgb($kposintensity)=(0,0,0)
		ii+=1
	while(ii<ifind)
	setdatafolder curr
end

function openfs(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:CalculatedBands:FermiSurface
	variable fid,Nx,Ny,ii,jj,kk=0,var1,var2,var3,var4,var5
	variable/G xlen,ylen
	string outputwave,tmpstr
	NVAR BandIndex
	svar Fslist
	outputwave="FS"+num2str(BandIndex)
	make/O/N=5 tmpwave
	wave tmpwave
	open/R fid
	ii=0
	jj=0
	freadline fid,tmpstr
	sscanf tmpstr,"%d %d %f %f",Nx,Ny,xlen,ylen
	make/O/N=(Nx,Ny) $outputwave
	
	freadline fid,tmpstr
			sscanf tmpstr,"%f %f %f %f %f",var1,var2,var3,var4,var5
			tmpwave[0]=var1
			tmpwave[1]=var2
			tmpwave[2]=var3
			tmpwave[3]=var4
			tmpwave[4]=var5
	
	wave referwave=$outputwave
	do
		jj=0
		do
			if(kk==5)
			freadline fid,tmpstr
			sscanf tmpstr,"%f %f %f %f %f",var1,var2,var3,var4,var5
			tmpwave[0]=var1
			tmpwave[1]=var2
			tmpwave[2]=var3
			tmpwave[3]=var4
			tmpwave[4]=var5
	        kk=0
	       endif
	       referwave[ii][jj]=tmpwave[kk]
	        kk=kk+1
	        jj=jj+1
	     while(jj<Ny)
	     ii=ii+1
	 while(ii<Nx)
	 killwaves/Z tmpwave
	 Fslist=wavelist("*",";","DIMS:2")
	 
	 popupmenu popup0,value=#Fslist
	 
	 close(fid)
	  Fslist=wavelist("*",";","DIMS:2")
	  popupmenu popup0,value=#Fslist

End

proc plotallfs(ctrlName) : ButtonControl
	String ctrlName
	variable totalfsnumber,ii
	string tmpstr
	totalfsnumber=itemsinlist(Fslist,";")
	ii=0
	do
		tmpstr=stringfromlist(ii,Fslist,";")
		if(ii==0)
		
		SetScale/I x -1,1,"", $tmpstr
	    SetScale/I y -1,1,"", $tmpstr
		
		Display;AppendMatrixContour $tmpstr
		
		ModifyContour $tmpstr autoLevels={Emin,Emax,1}
		ModifyContour $tmpstr labels=0
		
		else
		
		SetScale/I x -1,1,"", $tmpstr
	    SetScale/I y -1,1,"", $tmpstr
		
		AppendMatrixContour $tmpstr
		
		ModifyContour $tmpstr autoLevels={Emin,Emax,1}
		ModifyContour $tmpstr labels=0
		
		endif
		ii=ii+1
		while(ii<totalfsnumber)
	
	ModifyGraph width={Aspect,1}
	SetAxis bottom -1,1 
	SetAxis left -1,1
	ModifyGraph zero=1,standoff=0
	Label bottom "\\Z15\\F'Times New Roman'Kx(\\F'symbol'p/\\F'Times New Roman'a)"
	Label left "\\Z15\\F'Times New Roman'Ky(\\F'symbol'p/\\F'Times New Roman'a)"
End

proc plotselfs(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	Display;AppendMatrixContour $popStr
	
	SetScale/I x -1,1,"", $popStr
	SetScale/I y -1,1,"", $popStr
	ModifyGraph width={Aspect,1}
	ModifyContour $popStr autoLevels={Emin,Emax,1}
	SetAxis bottom -1,1 
	SetAxis left -1,1
	ModifyContour $popStr labels=0
	ModifyGraph zero=1,standoff=0
	Label bottom "\\Z15\\F'Times New Roman'Kx(\\F'symbol'p/\\F'Times New Roman'a)"
	Label left "\\Z15\\F'Times New Roman'Ky(\\F'symbol'p/\\F'Times New Roman'a)"
	
	
	

End


Function refresh(ctrlName) : ButtonControl
	String ctrlName
	
	svar Fslist
	setdatafolder root:CalculatedBands:FermiSurface
	Fslist=wavelist("*",";","DIMS:2")
    popupmenu popup0,value=#Fslist

	
End



Window PlotBands() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(411,307,711,572) as "CalculationsPanel"
	SetDrawLayer UserBack
	SetDrawEnv fillpat= 0
	SetDrawEnv save
	Button openfile,pos={18,52},size={80,20},proc=openfile,title="OpenFile"
	Button openfile,font="@Arial Unicode MS"
	PopupMenu choseindex,pos={14,100},size={125,20},proc=choseindex,title="ChoseIndex"
	PopupMenu choseindex,mode=8,bodyWidth= 60,popvalue="band8",value= #"bandslist"
	Button plotband,pos={31,221},size={80,20},proc=plotband,title="PlotBands"
	Button plotband,font="@Arial Unicode MS"
	Button exit_panel,pos={229,234},size={62,18},proc=exit_panel,title="Exit"
	Button exit_panel,font="@Arial Unicode MS"
	SetVariable Start,pos={28,156},size={74,15},title="Start"
	SetVariable Start,value= root:CalculatedBands:bandstart,bodyWidth= 40
	SetVariable Start1,pos={34,188},size={62,15},title="End"
	SetVariable Start1,value= root:CalculatedBands:bandend,bodyWidth= 40
	GroupBox group0,pos={10,10},size={134,248},title="PlotBands"
	GroupBox group0,font="@Arial Unicode MS"
	GroupBox group2,pos={156,10},size={135,216},title="PlotFermiSur"
	GroupBox group2,font="@Arial Unicode MS"
	Button openfile1,pos={174,56},size={80,20},proc=openfs,title="OpenFile"
	Button openfile1,font="@Arial Unicode MS"
	PopupMenu popup0,pos={164,159},size={103,20},proc=plotselfs,title="FS#"
	PopupMenu popup0,mode=1,bodyWidth= 80,popvalue="FS28",value= #"Fslist"
	Button button0,pos={187,195},size={60,20},proc=plotallfs,title="PlotAllFS"
	Button button0,font="@Arial Unicode MS"
	SetVariable setvar0,pos={172,35},size={84,15},title="Band#"
	SetVariable setvar0,value= root:CalculatedBands:FermiSurface:BandIndex,bodyWidth= 50
	SetVariable Emin,pos={173,108},size={88,15},title="Emin"
	SetVariable Emin,value= root:CalculatedBands:FermiSurface:Emin,bodyWidth= 60
	SetVariable Emax,pos={173,130},size={88,15},title="Emax"
	SetVariable Emax,value= root:CalculatedBands:FermiSurface:Emax,bodyWidth= 60
	Button refresh,pos={148,233},size={70,20},proc=refresh,title="REFRESH"
	Button refresh,font="@Arial Unicode MS"
EndMacro

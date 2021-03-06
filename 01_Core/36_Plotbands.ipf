//-----------------------------------------------------------------------------
//Function:draw bands and FermiSurface from wien2k dataset
//-----------------------------------------------------------------------------
//v1.0 with the function to plot bands in igor from data generated by wien2k
//v2.0 with the fucntion to plot 2D FS contour
//v2.1 modified to make reading case.bands.agr  fasterer
//v2.2 modified to plotband along arbitrary cut 
//v2.3 modified to plot 2d FS at any kz plane
//v2.4 modified to load band data significantly faster. some modifications also made to 
//manage the dataset more conveniently.FS data can also be load one time. 24/04/09 
//v2.6 manage waves by setting different flags
#pragma rtGlobals=1		// Use modern global access method.

proc plotbands_panel()
	
	
	
	dowindow/F PlotBands
	silent 1
	string curr
	if(V_Flag==0)
		newdatafolder/O root:CalculatedBands
		newdatafolder/O root:CalculatedBands:HighSymmetryPoints
		newdatafolder/O root:CalculatedBands:FermiSurface
		setdatafolder root:CalculatedBands
		variable/G totalbandsnumber,bandstart,bandend,processedflag
		string/G bandslist
		string/G preband
		string/G root:CalculatedBands:FermiSurface:BandIndex
		variable/G root:CalculatedBands:FermiSurface:contournumber
		variable/G root:CalculatedBands:FermiSurface:Emin
		variable/G root:CalculatedBands:FermiSurface:Emax
		variable/G root:CalculatedBands:FermiSurface:flag_conorimag
		string/G root:CalculatedBands:FermiSurface:Fslist
		string/G root:CalculatedBands:FermiSurface:fsprestr
		string/G root:CalculatedBands:FermiSurface:folderlist
		string/G root:CalculatedBands:FermiSurface:filelist
		string/G root:CalculatedBands:FermiSurface:fsnamepre
		variable/G root:CalculatedBands:FermiSurface:numberfiles
		
		make/O/N=5 root:CalculatedBands:FermiSurface:tmpwave
		
		PlotBands()
	endif
end

proc loadbands(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:CalculatedBands
	string colummninfo
	colummninfo="C=1,F=-1,"
	colummninfo=colummninfo+"N="+preband+"KEnergy"+";"+"C=1,F=-1,"+"N="+preband+"band;"
	loadwave/A/B=colummninfo/G
	
	string renamedwave,renamedwavek,tobeE,tobeK
	renamedwave=preband+"band"
	renamedwavek=preband+"KEnergy"
	tobeE=renamedwave+"0"
	tobeK=renamedwavek+"0"
	rename $renamedwave $tobeE
	rename $renamedwavek $tobeK
	
	string tobekilllist,tobekillwave
	variable tobekillnumber,ii=1
	tobekilllist=wavelist(preband+"K"+"*",";","DIMS:1")
	tobekillnumber=itemsinlist(tobekilllist)
	do
		tobekillwave=stringfromlist(ii,tobekilllist)
		killwaves/Z $tobekillwave
		ii=ii+1
	while(ii<tobekillnumber)
		
End


proc generatekpos(ctrlName) : ButtonControl
	String ctrlName
	string tmpstr
	variable filerefer,ii=0,jj=0,xaxislablenumber
	setdatafolder root:CalculatedBands
	make/O/T/N=20 xlablename
	make/O/N=20 xlablepos
	
	open/R filerefer
	do
	     freadline filerefer,tmpstr
			if(strsearch(tmpstr,"bandindex",0)>=0)
			break
			endif		
			
			xlablepos[xaxislablenumber]=str2num(tmpstr)
		    freadline filerefer,tmpstr
			xlablename[xaxislablenumber]=tmpstr
		 	xaxislablenumber+=1
	while(1) 
		 redimension/N=(xaxislablenumber) xlablename,xlablepos
//construct the K postion lines	
	string curr
	curr=getdatafolder(1)
	string xlablen=preband+"xlablename",xlablep=preband+"xlablepos"
	duplicate/O xlablename root:CalculatedBands:HighSymmetryPoints:$xlablen
	duplicate/O xlablepos root:CalculatedBands:HighSymmetryPoints:$xlablep
	
	setdatafolder HighSymmetryPoints
	variable ifind=1
	string kposintensity,kposx
	ii=1
	do
		if($xlablep[ii]==0)
		break
		endif
		ii+=1
	while(ii<20)
	ifind=ii
	ii=0
	do
		kposintensity=root:Calculatedbands:preband+"kposintensity"+num2str(ii)
		kposx=root:Calculatedbands:preband+"kposx"+num2str(ii)
		make/O/N=2 $kposintensity,$kposx
		$kposintensity[0]=-100
		$kposintensity[1]=100
		$kposx[0]=$xlablep[ii]
		$kposx[1]=$xlablep[ii]
		ii+=1
	while(ii<ifind)
	setdatafolder curr	
						
End

proc refresh1(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:CalculatedBands
	variable ii,bandsnumber
	bandsnumber=totalbandsnumber
	bandslist=""
	ii=0
	do
	if(str2num(processflag[ii])==processedflag)
	bandslist+=nameofwave($Original1DFile[ii])+";"
	endif
	ii+=1
	while(ii<totalbandsnumber)
	popupmenu choseindex,popvalue=bandslist[0,4],value=#"bandslist"
	//popupmenu choseindex,value=#bandslist
	
End

proc choseindex(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	variable ii
	
	setdatafolder root:CalculatedBands
	variable pos_pre
	string bandintensity,bandk,str_pre
	pos_pre=strsearch(popStr,"band",0)
	str_pre=popStr[0,pos_pre-1]
	bandk=str_pre+"KEnergy0"
	bandintensity=popStr
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
	plotkpos(maximum,minimum,str_pre)
	
	ModifyGraph lsize=1
    ModifyGraph zero(left)=2
    ModifyGraph tick=2,mirror=2,noLabel(bottom)=1,standoff=0
	TextBox/C/N=text0/F=0/A=MB/E=2 "\\Z14\\f01\\F'Times New Roman'K position"
	TextBox/C/N=text1/O=90/F=0/A=LC/X=3.00/Y=5.00/E "\\Z14\\f01\\F'Times New Roman'Energy (eV)"
	ModifyGraph fStyle(left)=1,fSize(left)=14
	
	
End

proc plotband(ctrlName) : ButtonControl
	String ctrlName
    setdatafolder root:CalculatedBands
    variable ii,random1,random2,random3,test1=0
    string bandk,bandenergy,str_pre,tmp_str,startstr,endstr
   
   // bandk=prebandtoplot+"KEnergy0"
  
    display
    
    
    ii=0
    do
    	if(str2num(processflag[ii])==processedflag)
    	if(test1==0)
    	startstr=Original1DFile[ii]
    	test1=1
    	endif
    	endstr=Original1DFile[ii]
    	
    	tmp_str=Original1DFile[ii]
    	str_pre=tmp_str[0,strsearch(Original1DFile[ii],"band",0)-1]
    	bandk=str_pre+"KEnergy0"
    	bandenergy=tmp_str
    	appendtograph $bandenergy vs $bandk
    	random1=abs(enoise(65536))
    	random2=abs(enoise(65536))
    	random3=abs(enoise(65536))
    	ModifyGraph rgb($bandenergy)=(random1,random2,random3)
    	endif
    	ii=ii+1
    while(ii<totalbandsnumber)
    
   bandenergy=startstr
   variable maximum,minimum,kpoints
	kpoints=dimsize($bandenergy,0)
	ii=0
	minimum=$bandenergy[ii]
	do
		ii=ii+1
		if($bandenergy[ii]<=minimum)
		minimum=$bandenergy[ii]
		endif
	while(ii<kpoints)
	
	bandenergy=endstr
	ii=0
	maximum=$bandenergy[ii]
	do
		ii=ii+1
		if($bandenergy[ii]>=maximum)
		maximum=$bandenergy[ii]
		endif
	while(ii<kpoints)
	
	plotkpos(maximum,minimum,str_pre)
    
    ModifyGraph lsize=1
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

proc plotkpos(a,b,c)
	variable a
	variable b
	string c
	variable ii
	string curr,bandname,prestring
	variable gap
	gap=abs((b-a)/6)
	curr=getdatafolder(1)
	setdatafolder root:CalculatedBands:HighSymmetryPoints
	bandname=c+"xlablepos"
	variable ifind=1
	string kposintensity,kposx,lablename
	ii=1
	do
		if($bandname[ii]==0)
		break
		endif
		ii+=1
	while(ii<20)
	ifind=ii
	ii=0
	do
		kposintensity=c+"kposintensity"+num2str(ii)
		$kposintensity[0]=b-gap
		$kposintensity[1]=a+gap
		ii+=1
	while(ii<ifind)
	
	ii=0
	do
		kposintensity=c+"kposintensity"+num2str(ii)
		kposx=c+"kposx"+num2str(ii)
		appendtograph $kposintensity vs $kposx
		ModifyGraph rgb($kposintensity)=(0,0,0)
		ii+=1
	while(ii<ifind)
	
	//!!!!!!!!!!!!!!!!!!Modify here to add AxisLable name
	lablename=c+"xlablename"
	TextBox/C/N=text2_1/F=0/A=MC/X=-50/Y=-55.00 "\\f01\\Z16"+$lablename[0]
	TextBox/C/N=text2_2/F=0/A=MC/X=-31/Y=-55.00 "\\f01\\Z16"+$lablename[1]
	TextBox/C/N=text2_3/F=0/A=MC/X=-17/Y=-55.00 "\\f01\\Z16"+$lablename[2]
	TextBox/C/N=text2_4/F=0/A=MC/X=-4/Y=-55.00 "\\f01\\Z16"+$lablename[3]
	TextBox/C/N=text2_5/F=0/A=MC/X=4.4/Y=-55.00 "\\f01\\Z16"+$lablename[4]
	TextBox/C/N=text2_6/F=0/A=MC/X=23/Y=-55.00 "\\f01\\Z16"+$lablename[5]
	TextBox/C/N=text2_7/F=0/A=MC/X=37/Y=-55.00 "\\f01\\Z16"+$lablename[6]
	TextBox/C/N=text2_8/F=0/A=MC/X=50/Y=-55.00 "\\f01\\Z16"+$lablename[7]
	//!!!!!!!!!!!!!!!!!!Modify here to add AxisLable name
	setdatafolder curr
	
end

proc selectdatafolder(ctrlName) : ButtonControl
	String ctrlName

	SetDataFolder root:CalculatedBands:FermiSurface
	
			NewPath/O/Q/M="Select New Folder" fsdata				//dialog selection
			string/G filpath
			Pathinfo fsdata
			filpath=S_path
		fileList=IndexedFile( fsdata, -1, ".fs")	
		//filelist=ReduceList( fullfilelist, "*.pxt" )
		numberfiles=ItemsInList( fileList, ";")


End


function openfs(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:CalculatedBands:FermiSurface
	variable fid=-1,Nx,Ny,ii,jj,kk=0,ll=0,var1,var2,var3,var4,var5
	variable/G xlen,ylen
	string tobeopenfile
	string outputwave,tmpstr
	svar BandIndex
	svar Fslist
	svar filelist,filpath
	nvar numberfiles
	svar fsnamepre
	do
		tobeopenfile=stringfromlist(ll,filelist)
		
		//outputwave=tobeopenfile
		outputwave=fsnamepre+tobeopenfile[0,strlen(tobeopenfile)-4]
		make/O/N=5 tmpwave
		wave tmpwave
	
		open/R fid as filpath+tobeopenfile
		if(fid!=-1)
		kk=0
		ii=0
		jj=0
		freadline fid,tmpstr
		sscanf tmpstr,"%d %d %f %f",Nx,Ny,xlen,ylen
		make/O/N=(Nx,Ny) $outputwave
		setscale/I x,-1,1,$outputwave
		setscale/I y,-1,1,$outputwave
		
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
	 	ll=ll+1
	 killwaves/Z tmpwave
	 
	 close(fid)
	  Fslist=wavelist("*",";","DIMS:2")
	  popupmenu popup0,value=#Fslist
	endif
	while(ll<numberfiles)
End

proc plotallfs(ctrlName) : ButtonControl
	String ctrlName
	variable totalfsnumber,ii
	string tmpstr
	string tobedisplaylist
	tobedisplaylist=wavelist(fsprestr+"*",";","DIMS:2")
	totalfsnumber=itemsinlist(tobedisplaylist,";")
	ii=0
	do
		tmpstr=stringfromlist(ii,tobedisplaylist,";")
		if(ii==0)
		
		SetScale/I x -1,1,"", $tmpstr
	    SetScale/I y -1,1,"", $tmpstr
		
		Display;AppendMatrixContour $tmpstr
		
		ModifyContour $tmpstr autoLevels={Emin,Emax,contournumber}
		ModifyContour $tmpstr labels=0
		
		else
		
		SetScale/I x -1,1,"", $tmpstr
	    SetScale/I y -1,1,"", $tmpstr
		
		AppendMatrixContour $tmpstr
		
		ModifyContour $tmpstr autoLevels={Emin,Emax,contournumber}
		ModifyContour $tmpstr labels=0
		
		endif
		ii=ii+1
		while(ii<totalfsnumber)
	
	ModifyGraph width={Aspect,1}
	SetAxis bottom -1,1 
	SetAxis left -1,1
	ModifyGraph tick=3,noLabel=2
	ModifyGraph zero=1,standoff=0
	ModifyGraph lsize=1.5,rgb=(0,0,0)
	TextBox/C/N=text0/F=0/A=MC/X=0.00/Y=0.00 "\\f01\\Z15\\F'symbol'G"
	TextBox/C/N=text1/F=0/A=MC/X=50/Y=50 "\\f01\\Z15\\F'symbol'M"
	TextBox/C/N=text2/F=0/A=MC/X=50/Y=0.00 "\\f01\\Z15X"
	Label bottom "\\f01\\Z15\\F'Times New Roman'Kx(\\F'symbol'p/\\F'Times New Roman'a)"
	Label left "\\f01\\Z15\\F'Times New Roman'Ky(\\F'symbol'p/\\F'Times New Roman'a)"
End

proc plotselfs(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	if(flag_conorimag==1)
	Display;AppendMatrixContour $popStr
	
	SetScale/I x -1,1,"", $popStr
	SetScale/I y -1,1,"", $popStr
	ModifyGraph width={Aspect,1}
	ModifyContour $popStr autoLevels={Emin,Emax,contournumber}
	SetAxis bottom -1,1 
	SetAxis left -1,1
	ModifyContour $popStr labels=0
	ModifyGraph zero=1,standoff=0
	Label bottom "\\Z15\\F'Times New Roman'Kx(\\F'symbol'p/\\F'Times New Roman'a)"
	Label left "\\Z15\\F'Times New Roman'Ky(\\F'symbol'p/\\F'Times New Roman'a)"
	endif
	if(flag_conorimag==0)
	Display;Appendimage $popStr
	
	SetScale/I x -1,1,"", $popStr
	SetScale/I y -1,1,"", $popStr
	
	ModifyGraph width={Aspect,1}
	SetAxis bottom -1,1 
	SetAxis left -1,1
	ModifyGraph zero=1,standoff=0
	ModifyImage $popStr ctab= {*,*,Terrain256,1}
	Label bottom "\\Z15\\F'Times New Roman'Kx(\\F'symbol'p/\\F'Times New Roman'a)"
	Label left "\\Z15\\F'Times New Roman'Ky(\\F'symbol'p/\\F'Times New Roman'a)"
	endif
	
	

End


Function refresh(ctrlName) : ButtonControl
	String ctrlName
	
	
	//svar fsprestr
	setdatafolder root:CalculatedBands:FermiSurface
	svar Fslist
	Fslist=wavelist("*",";","DIMS:2")
    popupmenu popup0,value=#"Fslist"

	
End

function plotselband(ctrlName) : ButtonControl
string ctrlName

variable xstart,xend,ystart,yend,dpath,xdel,kx,ky
variable ii,jj,itemsnum
string fsnamelist,fsname,bandname

svar fsprestr=root:CalculatedBands:FermiSurface:fsprestr

fsnamelist=wavelist(fsprestr+"*",";","DIMS:2")
itemsnum=itemsinlist(fsnamelist)


xstart=xcsr(A)
ystart=vcsr(A)
xend=xcsr(B)
yend=vcsr(B)
dpath=sqrt((xstart-xend)^2+(ystart-yend)^2)
xdel=(xend-xstart)/199

ii=0
do
fsname=stringfromlist(ii,fsnamelist)
if(strlen(fsname)>0)


bandname="EK_"+fsname
make/O/N=200 $bandname
wave fswave=$fsname
wave bandwave=$bandname

setscale/I x,0,dpath,bandwave

jj=0
do
	if(xstart!=xend)
	kx=xstart+jj*xdel
	ky=ystart+(ystart-yend)/(xstart-xend)*jj*xdel
	else
	kx=xstart
	ky=ystart+(yend-ystart)/199*jj
	endif
	
	bandwave[jj]=interp2d(fswave,kx,ky)
	jj+=1
while(jj<200)

if(ii==0)
display/K=1
appendtograph bandwave
else
appendtograph bandwave
endif

endif
ii+=1
while(ii<itemsnum)

ModifyGraph tick=2,zero(left)=2,mirror=2,standoff=0

end
proc plotselband1(ctrlName) : ButtonControl
	String ctrlName
	
	variable xpA,ypA,xlen,ylen,xdelta=1,ydelta=1,xcursorA,xcursorB,ycursorA,ycursorB,lineslope,startk,endk,maxvalue,minvalue,gap
	string csrwavename
	variable ii,jj,imax,inverseslope
	
	xpA=pcsr(A)
	ypA=qcsr(A)
	xlen=abs(pcsr(B)-pcsr(A))+1
	ylen=abs(qcsr(B)-qcsr(A))+1
	lineslope=ylen/xlen
	inverseslope=xlen/ylen
	csrwavename=csrwave(A)
	
	//klen=round(sqrt(xlen^2+ylen^2))
	
	xcursorA=xcsr(A)
	xcursorB=xcsr(B)
	ycursorA=vcsr(A)
	ycursorB=vcsr(B)
	
	startk=sqrt(xcursorA^2+ycursorA^2)
	endk=sqrt(xcursorB^2+ycursorB^2)
	
	if(pcsr(A)>pcsr(B))
		xdelta=-1
	endif
	if(qcsr(A)>qcsr(B))
		ydelta=-1
	endif
	
	make/O/N=(max(xlen,ylen)) outputband
	if(xlen>=ylen)
		ii=0
		
		do
			jj=round(ii*lineslope)
			outputband(ii)=$csrwavename[xpA+ii*xdelta][ypA+jj*ydelta]
			ii=ii+1
		while(ii<xlen)
	else
		jj=0
		do
			ii=round(jj*inverseslope)
			outputband(jj)=$csrwavename[xpA+ii*xdelta][ypA+jj*ydelta]
			jj=jj+1
		while(jj<ylen)
	endif
	
	
	ii=0
	imax=max(xlen,ylen)
	maxvalue=outputband[0]
	minvalue=outputband[0]
	do
		if(outputband[ii]>=maxvalue)
			maxvalue=outputband[ii]
		endif
		if(outputband[ii]<=minvalue)
			minvalue=outputband[ii]
		endif
		ii=ii+1
	while(ii<imax)
	gap=(maxvalue-minvalue)/3	
	
	setscale x,startk,endk,outputband
	
	display outputband
	
	Label bottom "\\Z15\\F'Times New Roman'K//(\\F'symbol'p/\\F'Times New Roman'a)"
	Label left "\\Z15\\F'Times New Roman'Energy(eV)"
	ModifyGraph standoff=0
	ModifyGraph mirror(left)=2
	ModifyGraph mirror(bottom)=2
	ModifyGraph tick(left)=2
	ModifyGraph tick(bottom)=2
	ModifyGraph fStyle(left)=1
	ModifyGraph fStyle(bottom)=1
	SetAxis left minvalue-gap, maxvalue+gap
	ModifyGraph mode=4,marker=5
End

proc settable1(ctrlName) : ButtonControl
	 String ctrlName
	 String curr= GetDataFolder(1)
       SetDataFolder root:CalculatedBands
       String Imagefile1DList= WaveList("A*band*",";","DIMS:1")	                 //Loaded Images
       Variable limit1D=ItemsInList( Imagefile1DList, ";")
       totalbandsnumber=limit1D
       If (limit1D>0)
       Make/O/T/N=(limit1D) Original1DFile, processflag

		Variable i1D=0
		String Image1DFile
		Do
		Image1DFile=StringFromList(i1D,Imagefile1DList,";")
		Original1DFile[i1D]=Image1DFile
	    i1D=i1D+1
	    while (i1D<limit1D)	
	        DoWindow Info1D_Table
	        if(V_flag==0)
	        		Edit Original1DFile, processflag as "Bands InformationTable"
	        		DoWindow/C Info1D_Table
	        	else
	        		DoWindow/F Info1D_Table
	        	endif
	        	
	 Else
	 Endif	        	
        	
	        	SetDataFolder curr

End

Window PlotBands() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel/K=1/W=(828,151,1140,436) as "CalculationsPanel"
	ModifyPanel fixedSize=1, frameStyle=1
	SetDrawLayer UserBack
	SetDrawEnv fillpat= 0
	SetDrawEnv save
	Button openfile,pos={23,57},size={116,20},proc=loadbands,title="LOAD"
	Button openfile,font="@Arial Unicode MS"
	PopupMenu choseindex,pos={24,188},size={120,20},bodyWidth=120,proc=choseindex
	PopupMenu choseindex,mode=1,popvalue="Aitband40",value= #"bandslist"
	Button plotband,pos={24,229},size={117,20},proc=plotband,title="PlotBands"
	Button plotband,font="@Arial Unicode MS"
	Button exit_panel,pos={232,255},size={62,18},proc=exit_panel,title="Exit"
	Button exit_panel,font="@Arial Unicode MS"
	GroupBox group0,pos={10,11},size={142,268},title="PlotBands"
	GroupBox group0,font="@Arial Unicode MS"
	GroupBox group2,pos={156,10},size={143,239},title="PlotFermiSur"
	GroupBox group2,font="@Arial Unicode MS"
	Button openfile1,pos={228,56},size={66,22},proc=openfs,title="LoadData"
	Button openfile1,font="@Arial Unicode MS"
	PopupMenu popup0,pos={169,162},size={101,20},bodyWidth=80,proc=plotselfs,title="FS#"
	PopupMenu popup0,mode=1,popvalue="IT00band89",value= #"Fslist"
	Button button0,pos={240,195},size={50,21},proc=plotallfs,title="FSAll"
	Button button0,font="@Arial Unicode MS"
	SetVariable Emin,pos={184,104},size={88,16},bodyWidth=60,title="Emin"
	SetVariable Emin,value= root:CalculatedBands:FermiSurface:Emin
	SetVariable Emax,pos={184,121},size={88,16},bodyWidth=60,title="Emax"
	SetVariable Emax,value= root:CalculatedBands:FermiSurface:Emax
	Button refresh,pos={158,254},size={70,20},proc=refresh,title="REFRESH"
	Button refresh,font="@Arial Unicode MS"
	SetVariable coutournumber,pos={164,87},size={108,16},bodyWidth=50,title="Countour#"
	SetVariable coutournumber,value= root:CalculatedBands:FermiSurface:contournumber
	CheckBox contour_image,pos={164,145},size={120,14},title="ConOrImage(1,con)"
	CheckBox contour_image,variable= root:CalculatedBands:FermiSurface:flag_conorimag
	Button plotbands,pos={161,222},size={129,22},proc=plotselband,title="Getbands"
	Button plotbands,font="@Arial Unicode MS"
	SetVariable fsprestr,pos={162,197},size={74,16},title="Filter"
	SetVariable fsprestr,value= root:CalculatedBands:FermiSurface:fsprestr
	SetVariable pre_band,pos={24,33},size={114,16},bodyWidth=92,title="Pre"
	SetVariable pre_band,value= root:CalculatedBands:preband
	SetVariable pretoplot,pos={18,157},size={67,16},bodyWidth=39,title="flag"
	SetVariable pretoplot,value= root:CalculatedBands:processedflag
	Button refresh1,pos={92,154},size={50,20},proc=refresh1,title="Process"
	Button refresh1,font="@Arial Unicode MS"
	Button constructkpos,pos={23,80},size={117,20},proc=generatekpos,title="GenKPos"
	Button constructkpos,font="@Arial Unicode MS"
	Button selectpath,pos={159,34},size={136,21},proc=selectdatafolder,title="SelectPath"
	Button selectpath,font="@Arial Unicode MS"
	Button settable,pos={24,116},size={116,20},proc=settable1,title="SetTable"
	Button settable,font="@Arial Unicode MS"
	SetVariable Nameprestr,pos={161,57},size={65,20},title="\\F'@Arial Unicode MS'Pre"
	SetVariable Nameprestr,value= root:CalculatedBands:FermiSurface:fsnamepre
EndMacro

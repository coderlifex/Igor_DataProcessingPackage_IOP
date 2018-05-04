#pragma rtGlobals=1		// Use modern global access method.
proc acarpes()
	
	String curr1=GetDataFolder(1)
	
	if (!DataFolderExists("root:acarpes"))
		newdatafolder root:acarpes
	endif
	setdatafolder root:acarpes	
	
	
	variable/g acmode=1              //1bz=0 or period bz=1
	variable/g rmbgrate=0           //remove background rate
	variable/g cutp, cutq     //cut cursor position
	variable/g xnumpnt, ynumpnt    //image points
	variable/g bgcutrate //backgroud cut rate
	variable/g backgroudremoved   //image backgroud removed or not
	variable/g imgmaxvalue  //the maxvalue of a image
	variable/g cutval        //the value to remove the backgroud
	variable/g firstBZ=0
	string/g currfolder=curr1	
	string/g SYMimagelist        //image name list in root:IMG:SYM
	string/g ACimagelist=WaveList("ac*",";","")   //processed acimage list
	SetDataFolder curr1
	 root:acarpes:SYMimagelist=WaveList("*",";","")           
	setdatafolder root:acarpes
	string/g curimagename    //current wave name going to be calculated
	string/g curorgimagename  //oringinal image name of current wave going to be calculated
	string/g curacname   //current ac calculated wavename
	
	DoWindow/F acarpesPanel
	if (V_flag==0)
	acarpesPanel()
	else
		DoWindow/F acarpesPanel
	endif
	setdatafolder curr1
end

Window acarpesPanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(612,104,913,440)
	ModifyPanel frameStyle=2
	PopupMenu showSYMimage,pos={38,30},size={132,20},proc=showSYMimage,title="SYM image"
	PopupMenu showSYMimage,mode=6,popvalue="Bi2201",value= #"root:acarpes:SYMimagelist"
	PopupMenu showACimage,pos={49,261},size={186,20},proc=showACimage,title="Show ACimage"
	PopupMenu showACimage,mode=2,popvalue="acr40sco21BZ",value= #"root:acarpes:ACimagelist"
	PopupMenu getaccut,pos={109,294},size={156,20},proc=getaccut,title="get cut"
	PopupMenu getaccut,mode=2,popvalue="acr40sco21BZ",value= #"root:acarpes:ACimagelist"
	CheckBox acmode,pos={42,187},size={72,14},title="period_BZ"
	CheckBox acmode,variable= root:acarpes:acmode
	Slider slider0,pos={41,101},size={179,48},fSize=10
	Slider slider0,limits={0,1,0.1},variable= root:acarpes:bgcutrate,vert= 0
	Button button3,pos={46,74},size={119,18},proc=backgroud_remove,title="Background Remove"
	Button button0,pos={184,198},size={80,20},proc=get_acarpes_image,title="get acimage"
	Button button1,pos={39,296},size={62,17},proc=cutpositionfromcursor,title="cursor"
	Button button5,pos={227,31},size={50,20},proc=SYMimagelistupdate,title="update"
	GroupBox group0,pos={29,15},size={262,42},title="Show SYMimage",fStyle=0
	GroupBox group1,pos={29,15},size={262,42},title="Show SYMimage",fStyle=0
	GroupBox group2,pos={27,69},size={261,85}
	GroupBox group3,pos={28,166},size={259,71},title="Get ACimage"
	GroupBox group4,pos={29,243},size={257,79},title="Cut from ACimage"
	Button button4,pos={228,101},size={23,18},proc=backgroud_remove_ok,title="OK"
	Button button4,fStyle=1
	CheckBox acmode1,pos={42,209},size={90,14},title="only_firstBZ"
	CheckBox acmode1,variable= root:acarpes:firstBZ
EndMacro

proc SYMimagelistupdate(ctrlName) : ButtonControl
	String ctrlName
	 root:acarpes:SYMimagelist=WaveList("*",";","DIMS:2")
	 root:acarpes:currfolder=getdatafolder(1) 
end

proc showSYMimage(ctrlName,popNum,popStr) : PopupMenuControl
       String ctrlName
       Variable popNum
       String popStr
       
       setdatafolder root:acarpes
       curimagename=popStr
       curorgimagename=popStr
       
       if(backgroudremoved)
       		DoWindow/k bgrmimagetemps
			killwaves/z bgrmimagetemp
			killwaves/z bgrmimagetemp1
			backgroudremoved=0
       endif
       
       setdatafolder currfolder
       duplicate/o $popStr root:acarpes:$popStr
       setdatafolder root:acarpes
       DoWindow/F $(popStr+"s")
		if (V_flag==0)
         	Display;appendimage $popStr
	        ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
            ModifyGraph margin(left)=40,margin(bottom)=40
            ModifyGraph width=250
            ModifyGraph height=250
            Label left "\\Z13\\f01k\\By\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
	        Label bottom "\\Z13\\f01k\\Bx\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
	        DoWindow/C $(popStr+"s")
	 	else
			DoWindow/F $(popStr+"s")
    	endif
    		setdatafolder root:acarpes:currfolder
    
   
end

proc backgroud_remove (ctrlName) : ButtonControl
	String ctrlName
	
	
	setdatafolder root:acarpes
	DoWindow/K $(curimagename+"s")
	curimagename=curorgimagename
	
	if (!strlen(curimagename))
		print "choose an image to remove backgroud!"
	else	

		if(backgroudremoved)
			DoWindow/k bgrmimagetemps
			killwaves/z bgrmimagetemp
			killwaves/z bgrmimagetemp1
		endif
		
//		setdatafolder currfolder
		duplicate/o $curimagename  bgrmimagetemp  bgrmimagetemp1
//		setdatafolder root:acarpes
		wavestats/Q bgrmimagetemp
//		string maxvalue="maxval"+popStr
		variable/g imgmaxvalue=V_max
		variable/g cutval:=imgmaxvalue*bgcutrate
		bgrmimagetemp:=(bgrmimagetemp1(x)(y)>cutval)*bgrmimagetemp1(x)(y)

        Display;appendimage bgrmimagetemp
	    ModifyImage bgrmimagetemp ctab= {*,*,PlanetEarth,1}
        ModifyGraph margin(left)=40,margin(bottom)=40
        ModifyGraph height=250
        Label left "\\Z13\\f01k\\By\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
	    Label bottom "\\Z13\\f01k\\Bx\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
	    DoWindow/C bgrmimagetemps
		backgroudremoved=1
	endif
end

proc backgroud_remove_ok (ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:acarpes
	if(backgroudremoved)		
		curimagename="r"+num2str(bgcutrate*100)+curimagename
		DoWindow/K bgrmimagetemps
		duplicate/o bgrmimagetemp1 $curimagename		
		$curimagename=(bgrmimagetemp1(x)(y)>cutval)*bgrmimagetemp1(x)(y)
		
		killwaves/z   bgrmimagetemp
		killwaves/z   bgrmimagetemp1		
		
		DoWindow/F $(curimagename+"s")		
		if (V_flag==0)
			Display;appendimage $curimagename
			ModifyImage $curimagename ctab= {*,*,PlanetEarth,1}
			ModifyGraph margin(left)=40,margin(bottom)=40
     		ModifyGraph width=250
    		ModifyGraph height=250
    		Label left "\\Z13\\f01K\\By\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
			Label bottom "\\Z13\\f01K\\Bx\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
			DoWindow/C $(curimagename+"s")
		else
		 	DoWindow/F $(curimagename+"s")
		endif
	endif
	backgroudremoved=0
end


proc get_acarpes_image(ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:acarpes
	
	if (!strlen(curimagename))
		print "choose an image to process!"
	else	
	
		if(backgroudremoved)		
			backgroud_remove_ok("1")
		endif
		curacname="ac"+curimagename
		if(firstBZ)
			curacname+="1BZ"
		endif
		if(acmode)
			curacname+="P"
		endif		
		DoWindow/F $(curacname+"s")
		if (V_flag==0)
			if(!WaveExists($curacname))
						
				duplicate/o $(curimagename)  acimagetemp
		
				if(acmode)
					variable rightxv=dimoffset(acimagetemp,0)+DimDelta(acimagetemp,0)*dimsize(acimagetemp,0)
					variable leftxv=dimoffset(acimagetemp,0)
					variable rightyv=dimoffset(acimagetemp,1)+DimDelta(acimagetemp,1)*dimsize(acimagetemp,1)
					variable leftyv=dimoffset(acimagetemp,1)
					variable numptp=(ceil(rightxv)-floor(leftxv))/dimdelta(acimagetemp,0)
					variable numptq=(ceil(rightyv)-floor(leftyv))/dimdelta(acimagetemp,1)
					make/n=(numptp,numptq) acimagetemp1
					SetScale/I x floor(leftxv),ceil(rightxv), acimagetemp1
					SetScale/I y floor(leftyv),ceil(rightyv), acimagetemp1
					acimagetemp1=(((rightxv-x)*(x-leftxv)>0)&&((rightyv-y)*(y-leftyv)>0))?acimagetemp(x)(y):0
					if(firstBZ)
						duplicate/r=(-1,1)(-1,1)/o acimagetemp1 $curacname temptimag						
					else
						duplicate/o acimagetemp1 $curacname  temptimag
					endif
					if(mod(DimSize($curacname, 0 ),2))
						InsertPoints DimSize(temptimag, 0 ),1, temptimag
						duplicate/o temptimag $curacname
					endif
					FFT temptimag
					temptimag*=temptimag
					IFFT temptimag
					wavestats temptimag
					if(firstBZ)
						$curacname=temptimag(mod(x+V_maxRowLoc+2,2))(mod(y+V_maxColLoc+2,2))
					else
						$curacname=temptimag(mod(x+V_maxRowLoc+ceil(rightxv)-floor(leftxv),ceil(rightxv)-floor(leftxv)))(mod(y+V_maxColLoc+ceil(rightyv)-floor(leftyv),ceil(rightyv)-floor(leftyv)))
					endif
					killwaves/z temptimag
					killwaves acimagetemp
					killwaves acimagetemp1
				else
					if(firstBZ)
						duplicate/r=(-1,1)(-1,1)/o acimagetemp actempt1, actempt2, actempt3						
					else
						duplicate/o acimagetemp actempt1, actempt2, actempt3	
					endif
					
					
					variable/g numq nump
					nump=dimsize(acimagetemp,1)
					numq=dimsize(acimagetemp,0)
					
					make/o/n=(2*nump-1, 2*numq-1)  $curacname
					$curacname=0
					SetScale/I x -1*DimDelta(acimagetemp,0)*(nump-1), DimDelta(acimagetemp,0)*(nump-1), $curacname
					SetScale/I y -1*DimDelta(acimagetemp,1)*(nump-1), DimDelta(acimagetemp,1)*(numq-1), $curacname
					accaltulation2(actempt3,actempt1, actempt2)
					$curacname=(((q-numq)*(p-nump))>0)?(actempt1[abs(nump-p)][abs(numq-q)]):(actempt2[abs(nump-p)][abs(numq-q)])
					killwaves actempt1 
					killwaves actempt2
					killwaves actempt3
					killwaves acimagetemp
				endif
				killwaves/z acimagetemp 
				

			endif
			
			Display;appendimage $curacname
			ModifyImage $curacname ctab= {*,*,PlanetEarth,1}
			ModifyGraph margin(left)=40,margin(bottom)=40
     	   	ModifyGraph width=250
    	  	ModifyGraph height=250
    	    Label left "\\Z13\\f01P\\By\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
			Label bottom "\\Z13\\f01P\\Bx\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
			showinfo
			DoWindow/C $(curacname+"s")
		else
		 DoWindow/F $(curacname+"s")
		endif
		backgroudremoved=0
endif

ACimagelist=WaveList("ac*",";","") 
end

function accaltulation(initialwave,destwave1,destwave2)
	wave initialwave
	wave destwave1
	wave destwave2
	variable k, j, l, m
	destwave1=0
	destwave2=0
	nvar numq
	nvar nump
	for(k=0;k<nump;k+=1)
		for(j=0;j<numq;j+=1)
			for(l=0;l<(nump-k);l+=1)
				for(m=0;m<(numq-j);m+=1)
					destwave1[k][j]=destwave1[k][j]+initialwave[l][m]*initialwave[l+k][m+j]
					destwave2[k][j]=destwave2[k][j]+initialwave[l][m+j]*initialwave[l+k][m]
				endfor
			endfor
			destwave1[k][j]=destwave1[k][j]/(numq-j)/(nump-k)
			destwave2[k][j]=destwave2[k][j]/(numq-j)/(nump-k)
		endfor
	endfor	
end

function accaltulation2(initialwave, destwave1,destwave2)
	wave initialwave
	wave destwave1
	wave destwave2
	variable k, j, l, m
	destwave1=0
	destwave2=0
	nvar numq
	nvar nump
	for(k=0;k<nump;k+=1)
		for(j=0;j<numq;j+=1)
			duplicate/o/r=[0,nump-k-1][0,numq-j-1] initialwave  tempt1
			duplicate/o/r=[k,nump-1][j,numq-1] initialwave  tempt2, tempt3
			tempt3=tempt1*tempt2
			destwave1[k][j]=sum(tempt3)/(numq-j)/(nump-k)
			duplicate/o/r=[0,nump-k-1][j,numq-1] initialwave  tempt1
			duplicate/o/r=[k,nump-1][0,numq-j-1] initialwave  tempt2
			tempt3=tempt1*tempt2
			destwave2[k][j]=sum(tempt3)/(numq-j)/(nump-k)
		endfor
	endfor	
	killwaves/z tempt1,tempt2,tempt3
end


function acimgdraw()
	WAVE acimagetemp
	NVAR xnumpnt, ynumpnt
	duplicate acimagetemp acimagetemp2
	xnumpnt=DimSize(acimagetemp, 0 ) 
	ynumpnt=DimSize(acimagetemp, 1 )
	variable pk,qk,i,j,integ,m,n,p0,q0
	for(i=0;i<2*xnumpnt;i=i+1)
	 	for(j=ynumpnt-1;j<2*ynumpnt;j=j+1)
	 		pk=i-(xnumpnt-1)
	 		qk=j-(ynumpnt-1)
	 		if(pk>=0)
	 		
	 			for(integ=0,m=xnumpnt-pk-1,p0=0;p0<=m;p0+=1)
	 				for(q0=pk,n=ynumpnt-qk-1;q0<=n;q0+=1)
	 					if(acimagetemp2[p0][q0]&&acimagetemp2[p0+pk][q0+qk])
	 					integ+=acimagetemp2[p0][q0]*acimagetemp2[p0+pk][q0+qk]
	 					endif
	 				endfor
	 			endfor
	 			acimagetemp[i][j]=integ
	 			acimagetemp[xnumpnt-1-pk][ynumpnt-1-qk]=integ
	 			
	 		else
	 		
	 			for(integ=0,m=xnumpnt,p0=pk;p0<=m;p0+=1)
	 				for(q0=pk,n=ynumpnt-qk-1;q0<=n;q0+=1)
	 				if(acimagetemp2[p0][q0]&&acimagetemp2[p0+pk][q0+qk])
	 					integ+=acimagetemp2[p0][q0]*acimagetemp2[p0+pk][q0+qk]
	 				endif
	 				endfor
	 			endfor
	 			acimagetemp[i][j]=integ
	 			acimagetemp[xnumpnt-1-pk][ynumpnt-1-qk]=integ
	 		
	 		endif
	 	endfor
	 endfor
	 killwaves acimagetemp2
end

proc showACimage(ctrlName,popNum,popStr) : PopupMenuControl
       String ctrlName
       Variable popNum
       String popStr
       
       setdatafolder root:acarpes
       curacname=popStr
       curacname=popStr
       DoWindow/F $(popStr+"s")
	if (V_flag==0)
         	Display;appendimage $popStr
	        ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
                ModifyGraph margin(left)=40,margin(bottom)=40
                ModifyGraph width=250
                ModifyGraph height=250
                Label left "\\Z13\\f01k\\By\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
	        Label bottom "\\Z13\\f01k\\Bx\\M\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
	        showinfo
	        DoWindow/C $(popStr+"s")
	 else
	 DoWindow/F $(popStr+"s")
    endif   
end

proc cutpositionfromcursor(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:acarpes
	
	if (!strlen(ACimagelist))
		print "No processed ACimage!"
	else
		if(!strlen(CsrInfo(A)))
			print "Set a point to get cut!"
			showinfo
		else
			cutp=pcsr(A)
			cutq=qcsr(A)
		endif
	endif
end

proc getaccut(ctrlName,popNum,popStr) : PopupMenuControl
       String ctrlName
       Variable popNum
       String popStr
       setdatafolder root:acarpes
       
       	string/g cutname="p"+num2str(cutp)+popstr[2,4]+popstr[8,strlen(popstr )-1]
       	
       	if(!WaveExists($cutname))

       		xnumpnt=DimSize($popStr, 0 ) 
       		ynumpnt=DimSize($popStr, 1 )
		variable/g cutslope=(cutp-xnumpnt/2+1)/(cutq-ynumpnt/2+1)
		duplicate $popStr tempimg
		if(abs(cutslope)>(xnumpnt/ynumpnt))
			make/n=(xnumpnt)  $cutname tempcut
			cutcalculation()
			$cutname=tempcut
			variable cutPrang=sqrt(1/(cutslope*cutslope)+1)
			SetScale/I x -1*cutPrang,cutPrang,"", $cutname
		else
			make/n=(ynumpnt) $cutname tempcut
			cutcalculation()
			$cutname=tempcut
			variable cutPrang1=sqrt((cutslope*cutslope)+1)
			SetScale/I x -1*cutPrang1,cutPrang1,"", $cutname	
		endif

		killwaves/z tempimg tempcut
	endif
	
       		dowindow/F $(cutname[0,5])
		if(V_flag)
			AppendToGraph  $cutname
		else
			Display $cutname
			Legend/C/N=text0/F=0/S=1/A=MC
			 Label bottom "\\Z13\\f01P\\Z13 (\\F'Symbol'p\\F'Arial'/a)"
			  Label left "\\Z12\\f01Intensity"
			dowindow/c $(cutname[0,5])		
		endif
	
end

function cutcalculation()
	wave  tempimg
	wave tempcut 
	svar cutname
	nvar cutslope 
	nvar xnumpnt
	nvar ynumpnt
	if(abs(cutslope)>(xnumpnt/ynumpnt))
		variable j
		for(j=0;j<ynumpnt;j+=1)
			tempcut[j]= tempimg[j][ynumpnt/2-1+cutslope*(j-xnumpnt/2+1)]
		endfor
	else
		variable i
		for(i=0;i<ynumpnt;i+=1)
			tempcut[i]= tempimg[ynumpnt/2-1+cutslope*(i-xnumpnt/2+1)][i]	
		endfor
	endif	

end
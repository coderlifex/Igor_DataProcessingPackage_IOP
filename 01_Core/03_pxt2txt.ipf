#pragma rtGlobals=1		// Use modern global access method.//	written by HYLiuFunction pxt2txt()	variable k=0,n=0,j=0,refpxt,reftxt	string s,txtfilename,pxtfilename,name	NewPath/O datafolder	NewDataFolder/O/S root:pxt2txt	do		Killwaves/A		pxtfilename=IndexedFile(datafolder,k,".pxt")		if (!strlen(pxtfilename)|V_flag)		//NewPath sets the variable V_flag to zero if the operation succeeded or to non-zero if it failed.		//To determine if the user clicked Cancel			break		endif		txtfilename=pxtfilename[0,strsearch(pxtfilename,".",0)]+"txt"		LoadData/O/Q/P=datafolder pxtfilename		wave w=WaveRefIndexed("",0,4),xw=$"xscale"		Duplicate w,xw		xw=leftx(w)+p*deltax(w)		name=WaveName("", 0,4)	    variable xx=DimSize(w, 0), yy=DimSize(w, 1)//	    variable xx=DimSize(root:pxt2txt:$name, 0), yy=DimSize(root:pxt2txt:$name, 1)//		print name//		print xx,yy//		print DimDelta(w,0),DimDelta(w,1)		variable lefty=DimOffset(w,1),deltay=DimDelta(w,1)//  	print lefty,deltay//		Redimension/N=(xx,yy) w//		Open/P=datafolder ref as newfile//		FReadLine s, name       Open/P=datafolder reftxt as txtfilename			// writing notes -----		fprintf reftxt,"[Info]\r\nNumber of Regions=1\r\n\r\n[Region 1]\r\n"		fprintf reftxt,"Dimension 1 name=Kinetic Energy [eV]\r\nDimension 1 size=%d\r\nDimension 1 scale=",xx		do		 fprintf reftxt,"%.5f ",xw[n][0]		 n+=1		 while(n<xx)		n=0		fprintf reftxt,"\r\nDimension 2 name=Y-Scale [deg]\r\nDimension 2 size=%d\r\nDimension 2 scale=",yy//		fprintf reftxt,"%.6f ",lefty-deltay		do		 fprintf reftxt,"%.5f ",lefty+n*deltay		 n+=1		 while(n<yy)		fprintf reftxt,"\r\n\r\n"		s=note(w)			do				n=strsearch(s,"\r",0)				if ((n==-1)|(!cmpstr(s[0,n-1],"EndSES")))					break				endif				fprintf reftxt,s[0,n-1]+"\r\n"//				print StringByKey("Low Energy", s[0,n-1], "=")				s[0,n]=""			while (1)			n=0			fprintf reftxt,"\r\n[Data 1]\r\n"	  do	  fprintf reftxt,"    %.5f",xw[n][0]		do 		 fprintf reftxt,"    %.5f",w[n][j]		 j+=1		 while(j<yy)		 fprintf reftxt,"\r\n"      n+=1      j=0      while(n<xx)//      wfprintf reftxt,"%.5f",xw        close reftxt		k+=1		n=0		printf "%s==>>%s, OK!\r",pxtfilename,txtfilename	while(1)	Close/A	KillDataFolder root:pxt2txtend
#pragma rtGlobals=1		// Use modern global access method.

proc DispersionImagePlot()
	
	string curr=getdatafolder(1)
	
	setdatafolder root:DispersionIMAGE
	
	String ImagefileList= WaveList("ND*",";","DIMS:2")
	Variable Imagenum=ItemsInList( ImagefileList, ";")
	variable laxis
	variable baxis
	variable NumPerRow=6
	variable brange=0.97/NumPerRow
	variable lrange=0.95/ceil(Imagenum/NumPerRow)
	string laxisname
	string baxisname
	string img
	string labelname
	
	
    Variable i=0
    Do       
   	    img=StringFromList(i,Imagefilelist,";")
   	    laxis=ceil((i+1)/NumPerRow)
   	    baxis=i+1-NumPerRow*(laxis-1)  
   	    laxisname="L"+num2str(laxis)
   	    baxisname="B"+num2str(baxis)
   	    if(i==0)
   	    Display;AppendImage/L=$laxisname/B=$baxisname $img
   	    else
   	    AppendImage/L=$laxisname/B=$baxisname $img
   	    endif
   	    ModifyImage $img ctab= {*,*,PlanetEarth,1}
   		ModifyGraph axisEnab($laxisname)={1-laxis*lrange,1-(laxis-1)*lrange},axisEnab($baxisname)={0.03+(baxis-1)*brange,0.03+baxis*brange}
   		ModifyGraph tick($baxisname)=2,fSize($baxisname)=8,tickUnit($baxisname)=1,btLen($baxisname)=4,btThick($baxisname)=1.5;DelayUpdate
		ModifyGraph font($baxisname)="Arial";DelayUpdate
		ModifyGraph freePos($baxisname)={0.05,kwFraction}	
		ModifyGraph lblPosMode($baxisname)=1;DelayUpdate
		Label $baxisname "\\f01\\Z10K(a/\\F'Symbol'p)"	
		ModifyGraph tick($laxisname)=2,fSize($laxisname)=8,tickUnit($laxisname)=1,btLen($laxisname)=4,btThick($laxisname)=1.5;DelayUpdate
		ModifyGraph font($laxisname)="Arial";DelayUpdate
		ModifyGraph freePos($laxisname)={0.03,kwFraction}
		ModifyGraph lblPosMode($laxisname)=1;DelayUpdate
		Label $laxisname "\\f01\\Z10E(eV)"
		if(str2num(img[7])+1)
		labelname="T="+img[5,7]+"K"
		else
		labelname="T="+img[5,6]+"K"
		endif
		
		TextBox/N=$("T"+num2str(i))/F=0/A=LT/X=(4+(baxis-1)*brange*100) /Y=(4+(laxis-1)*lrange*100) labelname		

		 i=i+1
   	While (i<Imagenum)
   	
   	
	setdatafolder curr

end
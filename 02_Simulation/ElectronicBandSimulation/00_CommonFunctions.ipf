#pragma rtGlobals=1		// Use modern global access method.

Function String2FileNameWave(WaveNameList,DataFolderName)
//This function transform a string containing wave names seperated by "';" into a textwave 
	String WavenameList
	String DatafolderName
	variable ii,WaveNum
	WaveNum=ItemsInList(WaveNameList,";")
	make/T/O/N=(WaveNum) AllWaves,DataPathA
	make/O/N=(WaveNum) selWaves
	SelWaves=0
	DataPathA=DataFolderName
	for(ii=0;ii<WaveNum;ii=ii+1)
	AllWaves[ii]=StringFromList(ii,WaveNameList,";")	
	endfor
	//return AllWave
end

Function/S RefreshZWT(DIMS)
	//String CtrlName
	 variable DIMS//=root:TempVariable:DIMS
         String DIMSs="DIMS:"+num2str(DIMS)
         String CurrentDatafolder=GetDatafolder(1)
	Setdatafolder $CurrentDatafolder
         String WaveNameList=WaveList("*",";",DIMSs)
        Return WaveNameList
	//String2FileNameWave(WaveNameList)
	//ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
	//CreateBrowser
end


Function/s Filter_String(StrVar,DIMS)
	String StrVar
	Variable DIMS
	// variable DIMS=root:TempVariable:DIMS
         String DIMSs="DIMS:"+num2str(DIMS)
	String Filter="*"+StrVar+"*"
		//print Filter
	String WaveNameList=WaveList(Filter,";",DIMSs)
	Variable WaveNum=ItemsinList(WaveNameList,";")
	return WaveNameList	
	//String2FileNameWave(WaveNameList)
end

Function/s Filter_DIMS(DIMS)
	//String CtrlName
	 variable DIMS//=root:TempVariable:DIMS
         String DIMSs="DIMS:"+num2str(DIMS)
         String CurrentDatafolder=GetDatafolder(1)
	Setdatafolder $CurrentDatafolder
         String WaveNameList=WaveList("*",";",DIMSs)
         Return WaveNameList
	//String2FileNameWave(WaveNameList)
	//ListBox AllWaves_L listWave=AllWaves,mode=9,selWave=selWaves
end

Function ADDWave(AllWavest,SelWavest,SelectedWavest,sselWavest,DataPathA,DataPathS)
	Wave/T AllWavest,SelectedWavest,DataPathA,DataPathS
	wave SelWavest,sselWavest
	
	//String DataFolderName
	//print DataFolderName
	variable ii,jj,size
	jj=0
	size=0
	do
		if(selWavest[ii]==1||selWavest[ii]==8)
			size=size+1
		endif
		ii=ii+1
	while(ii<DimSize(selWavest,0))
	
	jj=0
	do
		if(sselWavest[jj]==1)
			Break
		endif
		jj=jj+1
	while(jj<DimSize(sselWavest,0))
	if(DimSize(sselWavest,0)==0)
		jj=jj-1
	endif
	InsertPoints jj,size,selectedWavest,sselWavest,DataPathS
	ii=0
	for(ii=0;ii<DimSize(SelWavest,0);ii=ii+1)
		if(selWavest[ii]==1||selWavest[ii]==8)
			String temp=AllWavest[ii]
			SelectedWavest[jj]=temp//AllWavest[ii]
			sselWavest[jj]=1
			temp=DataPathA[ii]
			DataPathS[jj]=temp
			DeletePoints ii,1,AllWavest,selWavest,DataPathA
			ii=ii-1
			jj=jj+1
		endif
	endfor
end


Function DeleteWave(ALLwaves,SelWaves,SelectedWaves,sselWaves,DataPathA,DataPathS)
	Wave/T AllWaves,SelectedWaves,DataPathA,DataPathS
	Wave selWaves,sselWaves
	variable ii,jj,size//,sizeold
	//ii=dimsize(selWaves,0)
	//ii=dimsize(AllWaves,0)
	//print ii
	//print(selWaves[0])
	
	//wave selWaves,selectedWaves,AllWaves,sselWaves
	//dimsize(selwaves,"0")
	//Wave selWaves,AllWaves
	//sizeold=dimsize(selectedWaves,0)
	jj=0
	size=0
	//duplicate/O selectedWaves,SelectedWaves_Temp
	//duplicate/O sselWaves,sselWaves_Temp
	do
	//for(ii=0;ii<DimSize(selWaves,0);ii=ii+1)
		if(sselWaves[ii]==1||sselWaves[ii]==8)
			size=size+1
		endif
		ii=ii+1
	while(ii<DimSize(sselWaves,0))
	
	jj=0
	do
		if(selWaves[jj]==1)
			Break
		endif
		jj=jj+1
	while(jj<DimSize(selWaves,0))
	if(DimSize(selWaves,0)==0)
		jj=jj-1
	endif
	//endfor
	//print AllWaves[2]
	InsertPoints jj,size,AllWaves,selWaves,DataPathA
	//Size=Size+Sizeold
	
	//make/T/O/N=(Size) selectedWaves
	//make/O/N=(Size) sselWaves
	ii=0
	for(ii=0;ii<DimSize(AllWaves,0);ii=ii+1)
	//jj

		if(sselWaves[ii]==1||sselWaves[ii]==8)
			String Temp=SelectedWaves[ii]
			AllWaves[jj]=Temp
			selWaves[jj]=1
			Temp=DataPathS[ii]
			DataPathA[jj]=Temp
			//t//emp=PathName[ii]
			DeletePoints ii,1,SelectedWaves,sselWaves,DataPathS//,PathName
			ii=ii-1
			jj=jj+1
		endif
		//ii=ii+1

	endfor
end

//Function UPWave(AllWaves,SelWaves,SelectedWaves,sselWaves)
Function UPWave(SelectedWaves,sselWaves,Pathname)
	//Wave/T AllWaves,SelectedWaves
	//Wave sselwaves,selwaves
	Wave/T SelectedWaves,PathName
	Wave sselwaves
	variable ii
	String TempWaveName1,TempWaveName2,TemPath1,TemPath2
	
	//String tempWaveName
	ii=0
	for(ii=0;ii<DimSize(sselWaves,0);ii=ii+1)
		if(sselWaves[ii]==1||sselWaves[ii]==8)
			if(ii!=0)
				TempWaveName1=SelectedWaves[ii]
				TempWaveName2=SelectedWaves[ii-1]
				SelectedWaves[ii]=TempWaveName2
				SelectedWaves[ii-1]=TempWaveName1
				TemPath1=PathName[ii]
				TemPath2=PathName[ii-1]
				PathName[ii]=TemPath2
				PathName[ii-1]=TemPath1
				sselWaves[ii-1]=1
				sselWaves[ii]=0
			//else
			//	break
			endif
		endif
	Endfor
	
end

//Function DownWave(AllWaves,SelWaves,SelectedWaves,sselWaves)
Function DownWave(SelectedWaves,sselWaves,PathName)
	//Wave/T AllWaves,SelectedWaves
	//Wave sselwaves,selwaves
	Wave/T SelectedWaves,PathName
	Wave sselwaves
	String tempath1,tempath2,TempWaveName1,TempWaveName2
	variable ii
	//String tempWaveName
	ii=DimSize(sselWaves,0)-1
	for(ii=DimSize(sselWaves,0)-1;ii>=0;ii=ii-1)
		if(sselWaves[ii]==1||sselWaves[ii]==8)
			if(ii!=DimSize(sselWaves,0)-1)
				TempWaveName1=SelectedWaves[ii]
				TempWaveName2=SelectedWaves[ii+1]
				SelectedWaves[ii]=TempWaveName2
				SelectedWaves[ii+1]=TempWaveName1
				
				TemPath1=PathName[ii]
				TemPath2=PathName[ii+1]
				PathName[ii]=TemPath2
				PathName[ii+1]=TemPath1
				
				sselWaves[ii+1]=1
				sselWaves[ii]=0
			//else
			//	break
			endif
		endif
	endfor
end

Function MinValueof1DWave(temWave)
	Wave temWave
	Variable ii
	variable MinValue=temWave[0]
	for(ii=0;ii<=Dimsize(temWave,0);ii=ii+1)
		if(MinValue>=TemWave[ii])
			Minvalue=TemWave[ii]
			
		endif
	endfor
	return MinValue
end

Function MaxValueof1DWave(temWave)
	Wave temWave
	Variable ii
	variable MaxValue=temWave[0]
	for(ii=0;ii<=Dimsize(temWave,0);ii=ii+1)
		if(MaxValue<=TemWave[ii])
			Maxvalue=TemWave[ii]
			//print MaxValue
		endif
	endfor
	return MaxValue
end

Function Leftx2D(D2Wave)
	Wave D2Wave
	variable Left,right
	Left=leftx(D2Wave)
	Right=Rightx(D2Wave)
	if(Left>Right)
		Left=Right
	endif
	Return Left
end

Function Rightx2D(D2Wave)
	Wave D2Wave
	variable Left,right
	Left=leftx(D2Wave)
	Right=Rightx(D2Wave)
	if(Left>Right)
		Right=Left
	endif
	Return right
end

Function Resolution_Gaussian(Resolutionx,ResolutionY,x,y,DIMS)
	variable Resolutionx,Resolutiony
	Variable x
	Variable y
	Variable DIMS
	//Resolutionx/=2
	//Resolutiony/=2
	if(DIMS==1)
		//Return exp(-x^2/2/Resolutionx^2)/2.506628274631000502415765284811/Resolutionx
		Return exp(-x^2/2/(resolutionx/2.3548)^2)/2.506628274631000502415765284811/(resolutionx/2.3548)
	endif
	if(DIMS==2)
		//Return exp(-x^2/2/Resolutionx^2)/2.506628274631000502415765284811/Resolutionx*exp(-y^2/2/Resolutiony^2)/2.506628274631000502415765284811/Resolutiony
		Return exp(-x^2/2/(resolutionx/2.3548)^2)/2.506628274631000502415765284811/(resolutionx/2.3548)*exp(-y^2/2/(resolutiony/2.3548)^2)/2.506628274631000502415765284811/(resolutiony/2.3548)
	endif
	
end

proc DeConvolution2D(Resolution,TempWaveName,DeConvolvedWave,tempTolerance)
	String Resolution
	String TempWaveName
	String DeConvolvedWave
	Variable tempTolerance
	Variable ii,TempValue,TempValue1,tolerValue
	//Wave TempWave=TempWaveName
	duplicate/O $tempwavename,tempwave,tempdeconvolvedwave
	//print DecImage2D[1][1]
	//tempValue=0
	//Wave TempDeconvolvedWave=TempWaveName
	//Wave OImage2D=Image2D
	//OImage2D+=0.001
	//print TempDeconvolvedWave[1][1]
	do
			TempValue1=TempValue
			TempWave=$DeConvolvedWave
			Convolve/A $Resolution, tempDeConvolvedWave
			tempDeConvolvedWave=$TempWaveName/tempDeConvolvedWave
			Convolve/A $Resolution,tempDeConvolvedWave
			$DeConvolvedWave=$DeConvolvedWave*tempDeConvolvedWave
			//$DeConvolvedWave/=1000000
			TempDeConvolvedWave=$DeConvolvedWave
			TempWave=(TempWave-TempDeConvolvedWave)^2
			//TempWave2=TempWave^2
			 tempvalue=sum(TempWave)//sum(TempWave2)
		 	TolerValue=abs(TempValue-TempValue1)/tempValue
			 if(TolerValue<=tempTolerance)
		 		break
			 endif
			 //print tolervalue
			ii=ii+1
		//print TempTolerance
		//print tolerValue
		//	$DeConvolvedConvolved=$DeConvolvedWave
		//	convolve/A Gaussian_Resolution, $DeConvolvedConvolved
		//	$DeConvolvedConvolved*=deltax($DeConvolvedConvolved)
		//	$difference=$DeConvolvedConvolved-$tempWaveName
	while(ii)
	killwaves tempwave,tempdeconvolvedwave	
end
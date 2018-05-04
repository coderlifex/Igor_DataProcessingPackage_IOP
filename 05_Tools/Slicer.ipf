Macro FullDemo()
	MakeData()
	MakeSlicer()
	MakeCrossSlices()
	ScanSlice(0)
	ModifySlicer Slicetype=0, SelectSlice=0
	ModifySlicer MoveSlice=0
	
	ScanSlice(1)
	ModifySlicer Slicetype=1, SelectSlice=0
	ModifySlicer MoveSlice=1
	
	ScanSlice(2)
	ModifySlicer Slicetype=2, SelectSlice=0
	ModifySlicer MoveSlice=0

	ModifySlicer update=3
	ScanSlice(0)
	ModifySlicer Slicetype=0, SelectSlice=0
	ModifySlicer MoveSlice=0

	ScanSlice(1)
	ModifySlicer Slicetype=1, SelectSlice=0
	ModifySlicer MoveSlice=1
	ScanSlice(2)
	MakeCube()
	ModifySlicer Clear
	ModifySlicer NewWidthSlice=0.5, NewLengthSlice=0.5, NewHeightSlice=0.5
	ModifySlicer Palette=YellowHot
	ModifySlicer Palette=BlueHot
	ModifySlicer Palette=BlueRedGreen
	ModifySlicer Palette=PlanetEarth
	ModifySlicer Palette=RedWhiteBlue
	ModifySlicer Palette=RainBow
	Variable i=-80
		do
			ModifySlicer Phi=i
			i+=10
		while(i<10)
	ModifySlicer Phi=-40
End

Macro MakeData()
	Make/o/n=(50,50,50) threeDWave=x*y*z

End

Macro MakeSlicer()
	CreateSlicer // If error, install the Graphical Slicer XOP
	ModifySlicer srcWave=threeDWave
End


Macro MakeCrossSlices()
	ModifySlicer update=0 // If error, install the Graphical Slicer XOP
	ModifySlicer NewWidthSlice=0.5, NewLengthSlice=0.5, NewHeightSlice=0.5
	ModifySlicer update=1
End


Macro ScanSlice(type)
	Variable type
	silent 1
	ModifySlicer Slicetype=type, SelectSlice=0 // If error, install the Graphical Slicer XOP
	Variable i=0
	do
		ModifySlicer MoveSlice=i/10
		i+=1
	while(i<10)
End

Macro MakeCube()
	ModifySlicer Clear // If error, install the Graphical Slicer XOP
	ModifySlicer NewWidthSlice=1, NewLengthSlice=0, NewHeightSlice=1
End
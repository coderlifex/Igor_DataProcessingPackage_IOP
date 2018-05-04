
Function FSShift(Wavex,Wavey,NName,Angle,KSize)
Wave Wavex, Wavey
Variable Angle, KSize
String NName

Variable NumofWave=Dimsize(Wavex,0)
String NNamex=NName+"x"
String NNamey=NName+"y"
Duplicate/O Wavex, $NNamex
Duplicate/O Wavey, $NNamey

Wave NewNamex=$NNamex
Wave NewNamey=$NNamey


Variable i=0

Do

NewNamex[i]=Wavex[i]+KSize*cos(Angle*3.1416/180)
NewNamey[i]=Wavey[i]+KSize*cos(Angle*3.1416/180)

i+=1
While (i<NumofWave)

END



Macro ShiftFermiSurface()

SetDataFolder root:SchematicFermiSurface
Variable ShiftKSize1=0.297
Variable ShiftAngle=45

RemoveFromGraph/Z  SFirstFS_Py, SSecondFS_Py, SThirdFS_Py, SFourthFS_Py
RemoveFromGraph/Z  SFirstFS_Ny, SSecondFS_Ny, SThirdFS_Ny, SFourthFS_Ny


FSShift(FirstFS_x,FirstFS_y,"SFirstFS_P",ShiftAngle,ShiftKSize1)
FSShift(SecondFS_x,SecondFS_y,"SSecondFS_P",ShiftAngle,ShiftKSize1)
FSShift(ThirdFS_x,ThirdFS_y,"SThirdFS_P",ShiftAngle,ShiftKSize1)
FSShift(FourthFS_x,FourthFS_y,"SFourthFS_P",ShiftAngle,ShiftKSize1)

FSShift(FirstFS_x,FirstFS_y,"SFirstFS_N",ShiftAngle,-ShiftKSize1)
FSShift(SecondFS_x,SecondFS_y,"SSecondFS_N",ShiftAngle,-ShiftKSize1)
FSShift(ThirdFS_x,ThirdFS_y,"SThirdFS_N",ShiftAngle,-ShiftKSize1)
FSShift(FourthFS_x,FourthFS_y,"SFourthFS_N",ShiftAngle,-ShiftKSize1)

AppendToGraph SFirstFS_Py vs SFirstFS_Px
AppendToGraph SSecondFS_Py vs SSecondFS_Px
AppendToGraph SThirdFS_Py vs SThirdFS_Px
AppendToGraph SFourthFS_Py vs SFourthFS_Px

AppendToGraph SFirstFS_Ny vs SFirstFS_Nx
AppendToGraph SSecondFS_Ny vs SSecondFS_Nx
AppendToGraph SThirdFS_Ny vs SThirdFS_Nx
AppendToGraph SFourthFS_Ny vs SFourthFS_Nx

ModifyGraph lsize(SFirstFS_Py)=2,rgb(SFirstFS_Py)=(65280,65280,0)
ModifyGraph lsize(SSecondFS_Py)=2,rgb(SSecondFS_Py)=(65280,65280,0)
ModifyGraph lsize(SThirdFS_Py)=2,rgb(SThirdFS_Py)=(65280,65280,0)
ModifyGraph lsize(SFourthFS_Py)=2,rgb(SFourthFS_Py)=(65280,65280,0)
ModifyGraph lsize(SFirstFS_Ny)=2,rgb(SFirstFS_Ny)=(65280,65280,0)
ModifyGraph lsize(SSecondFS_Ny)=2,rgb(SSecondFS_Ny)=(65280,65280,0)
ModifyGraph lsize(SThirdFS_Ny)=2,rgb(SThirdFS_Ny)=(65280,65280,0)
ModifyGraph lsize(SFourthFS_Ny)=2,rgb(SFourthFS_Ny)=(65280,65280,0)


End




Macro RemoveShiftFermiSurface()

RemoveFromGraph/Z  SFirstFS_Py, SSecondFS_Py, SThirdFS_Py, SFourthFS_Py
RemoveFromGraph/Z  SFirstFS_Ny, SSecondFS_Ny, SThirdFS_Ny, SFourthFS_Ny

End

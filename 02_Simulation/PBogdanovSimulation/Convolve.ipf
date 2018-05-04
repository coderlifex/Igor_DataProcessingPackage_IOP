#pragma rtGlobals=1		// Use modern global access method.

Macro ConvolveDimWithGaussian(wavename, endwavename, dim, hwhm)
String wavename= StrVarOrDefault( "root:conv:startname","image")
String endwavename= StrVarOrDefault( "root:conv:endname","Convolved")
Variable dim = NumVarOrDefault( "root:conv:dimension", 0)
Variable hwhm = NumVarOrDefault( "root:conv:hwhmval", 0.01)
prompt wavename, "Enter the name of the wave to convolve",popup, WaveList("*", ";", "")
prompt endwavename, "Enter the resulting wave name"
prompt dim, "Enter the dimension to convolve (x is 0)"
prompt hwhm, "Enter the Gaussian hwhm"
Silent 1; PauseUpdate
	String savedDF= GetDataFolder(1)
	NewDataFolder/O/S root:conv
		string/G startname=wavename, endname=endwavename
		variable/G dimension=dim, hwhmval=hwhm
	SetDataFolder savedDF
	
Duplicate/O $wavename $endwavename

Variable ind=0, imax = DimSize($wavename, dim)

Variable DimNumber = WaveDims($wavename)
Make/O/N=(DimSize($wavename, dim)) curve, convcurve
SetScale/P x  DimOffset($wavename, dim), DimDelta($wavename, dim),"", curve, convcurve
Variable k,i
curve=0
convcurve=0

Do
	If((DimNumber-1) <dim)
		print "Selected dimension is not available in this wave"
		break
	Endif
	If(DimNumber>2)
		print "can't handle that many dimensions"
		break
	Endif
	
	// Extract 1D info	
	
	If(DimNumber == 1)
		curve = $wavename
	Endif
	
	If((DimNumber == 2)*(dim == 0))
		curve =  $wavename[p][ind]
	Endif
	If((DimNumber == 2)*(dim == 1))
		curve =  $wavename[ind][p]
	Endif
	
	//Convolve
	convcurve=0
	FunctionCon(convcurve, curve, HWHM)
	//Store
	If(DimNumber == 1)
		$endwavename =  convcurve
	Endif
	
	If((DimNumber == 2)*(dim == 0))
		$endwavename[p][ind] =  convcurve
	Endif
	If((DimNumber == 2)*(dim == 1))
		$endwavename[ind][p] =  convcurve
	Endif
	ind+=1
	print ind
While(ind<imax)

End

Function FunctionCon(convcurve, curve, HWHM)
Wave convcurve, curve
Variable HWHM
Variable k, i
	k=0
	Do
		i=0
		Do
			convcurve[k] += 2/Sqrt(Pi)/HWHM * exp(-(pnt2x(curve,k)-pnt2x(curve,i))^2/HWHM^2) * curve[i] * DimDelta(curve,0)
			i+=1
		While(i<DimSize(curve,0))
		k+=1
	While(k<DimSize(curve,0))
End
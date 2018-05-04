#pragma rtGlobals=1		// Use modern global access method.

// Einstein phonon
// D-wave Gap case, coupling proportional to a DOS at certain K, given by e/sqrt(e^2 - gap^2)*dl, where l is length of contour
// Self energy for a particular gap is that of the NS shifted by delta and multiplied by the DOS

Function ImSigmaElPhSCZeroTEinstein( energy, lambda, Frequency, scgap)
Variable  energy, lambda, Frequency, scgap
Variable result
If (abs(energy) > Frequency)
	return Pi*Lambda*Frequency*IntI(abs(energy)-Frequency, scgap)
Else
	return 0
Endif
End


Function IntI(en, scgap)
Variable en, scgap
Variable x = scgap/en
Variable y=0, result=0, dy=Pi/4000
	Do
		If(abs(en) > abs(cos(y)*scgap) )
			result+=dy/sqrt(1-x^2*cos(y)^2)
		Endif
		y+=dy
	while (y<=Pi/2)
		result = result*2/Pi
If(x==1)
	result=1000*2/Pi
EndIf
return result
End

Function Theta (x)
Variable x
If (x>0)
	return 1
Else
	return 0
Endif
End

Function ReSigmaElPhSCZeroTEinstein( energy, lambda, Frequency, scgap)
Variable  energy, lambda, Frequency, scgap
Variable omega=Frequency, result=0
Variable limit=max(10*abs(energy), 3*scgap), domega = limit/1000
If (abs(energy) < Frequency)
	Do
		result+= Lambda*Frequency*2*energy*(IntI(abs(omega) - Frequency,scgap)) *domega/(omega^2 - energy^2)
		omega+=domega
	While (omega<(limit + Frequency))
Endif
If (abs(energy) > Frequency)
	omega =0
	domega = (abs(energy) - Frequency)/1000
	//calculate singular part
	omega=domega
	Do
		result+= domega*2*abs(energy)*( IntI(abs(abs(energy) + omega) - Frequency,scgap) - IntI(abs(abs(energy) - omega) - Frequency,scgap)) /(4*energy^2 * omega - omega^3)
		omega+=domega
	While (omega<(abs(energy) - Frequency-domega))
	//calculate two more parts
	//#1
	omega=0
	Do
		result+= domega*( IntI(abs(abs(energy) + omega) - Frequency,scgap) + IntI(abs(abs(energy) - omega) - Frequency,scgap)) /(-4*energy^2  + omega^2)
		omega+=domega
	While (omega<(abs(energy) - Frequency-domega))	
	//#2		
	omega = abs(energy) - Frequency
	limit = max(10*abs(energy), 3*scgap)
	domega = limit/1000
		Do
		result+= domega* IntI(abs(abs(energy) + omega) - Frequency,scgap) /(2*abs(energy)*omega  + omega^2)
		omega+=domega
	While (omega<(limit + Frequency))
	result=Lambda*Frequency*2*energy*result
Endif
If (abs(energy) == Frequency)
	result = 1
Endif
return result
End
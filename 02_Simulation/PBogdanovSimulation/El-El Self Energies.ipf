#pragma rtGlobals=1		// Use modern global access method.

//Above Tc

Function ImSigmaElEl( energy, beta)
Variable energy, beta
return beta*energy^2
End

//Below Tc
Function ImSigmaElElSC( energy, beta, gap)
Variable energy, beta, gap
If(abs(energy) < gap)
	return 0
Else
	return beta*energy^2*IntI(abs(energy), gap)
Endif
End


Function ReSigmaElElSC( energy, beta, gap)
//Difference with NS
Variable  energy, beta, gap
Variable omega=gap, result=0
Variable limit=5*gap, domega = limit/1000
If (abs(energy) < gap)
	Do
		result+= 2/Pi*beta*omega^2*energy*(IntI(abs(omega),gap)-1) *domega/(omega^2 - energy^2)
		omega+=domega
	While (omega<limit)
Endif
If (abs(energy) > gap)
	omega =0
	domega = (abs(energy) - gap)/1000
	//calculate singular part
	omega=domega
	Do
		result+= domega*2*abs(energy)*( (abs(energy) + omega)^2*IntI((abs(energy) + omega),gap) - (abs(energy) - omega)^2*IntI(abs((abs(energy) - omega)),gap)) /(4*energy^2 * omega - omega^3)
		omega+=domega
	While (omega<(abs(energy) - gap-domega))
	//calculate two more parts
	//#1
	omega=0
	Do
		result+= domega*(  (abs(energy) + omega)^2*IntI(abs(abs(energy) + omega) ,gap) + (abs(energy) - omega)^2*IntI(abs(abs(energy) - omega),gap)) /(-4*energy^2  + omega^2)
		omega+=domega
	While (omega<(abs(energy) - gap-domega))	
	//#2		
	omega = abs(energy) - gap
	limit = 5*gap
	domega = limit/1000
	If(omega < limit)
		Do
			result+= domega* (abs(energy) + omega)^2* (IntI(abs(abs(energy) + omega),gap) -1)/(2*abs(energy)*omega  + omega^2)
			omega+=domega
		While (omega<limit)
	Endif
	result=2/Pi*beta*energy*result
Endif
If (abs(energy) == gap)
	result = 1
Endif
return -result
End
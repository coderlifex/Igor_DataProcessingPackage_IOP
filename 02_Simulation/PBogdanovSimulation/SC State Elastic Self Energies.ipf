#pragma rtGlobals=1		// Use modern global access method.
//Small Angle Scattering
Function ImSigmaElasticSmallAngle(energy, gap)
variable energy, gap
If(abs(energy) < gap)
	return 0
Else
	return abs(energy)/sqrt(energy^2 - gap^2)
Endif
End

Function ReSigmaElasticSmallAngle(energy, gap)
variable energy, gap
variable omega, domega, result
omega = gap
If(abs(energy) < gap)
domega = gap/1000
omega = gap+domega
	Do
		result+= 2/Pi*energy*abs(omega)/sqrt(omega^2 - gap^2) *domega/(omega^2 - energy^2)
		omega+=domega
	While (omega<gap*10)
Endif
If(abs(energy) > gap)
	omega =0
	domega = (abs(energy) - gap)/1000
	//calculate singular part
	omega=domega
	Do
		result+= domega*2*abs(energy)*( (abs(energy) + omega)/sqrt((abs(energy) + omega)^2 - gap^2) - (abs(energy) - omega)/sqrt((abs(energy) - omega)^2 - gap^2)) /(4*energy^2 * omega - omega^3)
		omega+=domega
	While (omega<(abs(energy) - gap-domega))
	//calculate two more parts
	//#1
	omega=0
	Do
		result+= domega*( (abs(energy) + omega)/sqrt((abs(energy) + omega)^2 - gap^2)+ (abs(energy) - omega)/sqrt((abs(energy) - omega)^2 - gap^2)) /(-4*energy^2  + omega^2)
		omega+=domega
	While (omega<(abs(energy) - gap-domega))	
	//#2		
	omega = abs(energy) - gap
	variable	limit = 10*abs(energy)
	domega = limit/1000
		Do
		result+= domega* (abs(energy) + omega)/sqrt((abs(energy) + omega)^2 - gap^2) /(2*abs(energy)*omega  + omega^2)
		omega+=domega
	While (omega<(limit + gap))
	result = result*2/Pi*energy
Endif
return -result
End


//Large Angle Scattering. MultFactor of order 2.5
Function ImSigmaElasticLargeAngle(energy, gap, MultFactor)
variable energy, gap, MultFactor
gap = gap*MultFactor
If(abs(energy) < gap)
	return 0
Else
	return abs(energy)/sqrt(energy^2 - gap^2)
Endif
End

Function ReSigmaElasticLargeAngle(energy, gap, MultFactor)
variable energy, gap, MultFactor
gap = gap*MultFactor
variable omega, domega, result
omega = gap
If(abs(energy) < gap)
domega = gap/1000
omega = gap+domega
	Do
		result+= 2/Pi*energy*abs(omega)/sqrt(omega^2 - gap^2) *domega/(omega^2 - energy^2)
		omega+=domega
	While (omega<gap*10)
Endif
If(abs(energy) > gap)
	omega =0
	domega = (abs(energy) - gap)/1000
	//calculate singular part
	omega=domega
	Do
		result+= domega*2*abs(energy)*( (abs(energy) + omega)/sqrt((abs(energy) + omega)^2 - gap^2) - (abs(energy) - omega)/sqrt((abs(energy) - omega)^2 - gap^2)) /(4*energy^2 * omega - omega^3)
		omega+=domega
	While (omega<(abs(energy) - gap-domega))
	//calculate two more parts
	//#1
	omega=0
	Do
		result+= domega*( (abs(energy) + omega)/sqrt((abs(energy) + omega)^2 - gap^2)+ (abs(energy) - omega)/sqrt((abs(energy) - omega)^2 - gap^2)) /(-4*energy^2  + omega^2)
		omega+=domega
	While (omega<(abs(energy) - gap-domega))	
	//#2		
	omega = abs(energy) - gap
	variable	limit = 10*abs(energy)
	domega = limit/1000
		Do
		result+= domega* (abs(energy) + omega)/sqrt((abs(energy) + omega)^2 - gap^2) /(2*abs(energy)*omega  + omega^2)
		omega+=domega
	While (omega<(limit + gap))
	result = result*2/Pi*energy
Endif
return -result
End
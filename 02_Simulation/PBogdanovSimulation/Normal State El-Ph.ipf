#pragma rtGlobals=1		// Use modern global access method.


//Debye model


Function ReSigmaElPh( energy, Lambda, OmegaDebye, temperature)
Variable energy, Lambda, OmegaDebye, temperature
If (temperature ==0)
	If(energy == 0)
		return 0
	Else
		return -1/3*Lambda*OmegaDebye*( (energy/OmegaDebye)^3*ln(abs( (OmegaDebye/energy)^2 -1) ) + ln(abs( (OmegaDebye+energy)/(OmegaDebye - energy) )) + energy/OmegaDebye)
	Endif
Endif
If (temperature >0)
	If(energy == 0)
		return 0
	Else
	Variable xx, summ=0,increment, freq=0,dx, dfreq=0.001
	Do
		xx=0.001
		dx = 0.001
		Do
			increment=-2*Pi*freq^2*abs(freq)*Lambda*(FermiFunc(temperature,energy+freq+xx) - FermiFunc(temperature,energy+freq-xx)+ FermiFunc(temperature,-energy+freq-xx)-FermiFunc(temperature,-energy+freq+xx))/xx*dx*dfreq
			summ+=increment
			xx+=dx
		While(xx<1)
		freq+=dfreq
	While(freq<OmegaDebye)

	Return summ
	Endif
Endif
If (temperature <0)
	print "negative temperature is unphysical!"
	return 0
Endif
End

Function ImSigmaElPh( energy, Lambda, OmegaDebye, temperature)
Variable energy, Lambda, OmegaDebye, temperature
If (temperature==0)
	return  Pi/3*min(abs(energy/OmegaDebye)^3,1) * Lambda*OmegaDebye
Endif
If (temperature>0)
	Variable freq=0.0003, dfrequency = .0003, result=0
	Do
		result+= 2*Pi*freq^2*Pi*Lambda*abs(freq)*(2*BozeFunction(temperature,freq)+FermiFunc(temperature,energy+freq) +FermiFunc(temperature,-energy+freq))*dfrequency
		freq+=dfrequency
	While(freq<OmegaDebye)
	return result
	Endif
If (temperature <0)
	print "negative temperature is unphysical!"
	return 0
Endif
End	

//Einstein Model

Function ImSigmaElPhEinstein( energy, Lambda, Frequency, temperature)
Variable energy, Lambda, Frequency, temperature
If (temperature==0)
	If (abs(energy) > Frequency)
		return  Pi* Lambda*Frequency
	else
		return 0
	Endif
Endif
If (temperature>0)
		return Pi*Lambda*Frequency*(2*BozeFunction(temperature,Frequency)+FermiFunc(temperature,energy+Frequency) +FermiFunc(temperature,-energy+Frequency))
Endif
If (temperature <0)
	print "negative temperature is unphysical!"
	return 0
Endif
End	

Function ReSigmaElPhEinstein( energy, Lambda, Frequency, temperature)
Variable energy, Lambda, Frequency, temperature
If (temperature ==0)
	If(energy == 0)
		return 0
	Else
		return -Lambda*Frequency*ln(abs( (Frequency+energy)/(Frequency - energy) ))
	Endif
Endif
If (temperature >0)
	If(energy == 0)
		return 0
	Else
	Variable xx, dx, summ=0,increment
		xx=0.0005
		dx = 0.0005
		Do
			increment=-abs(Frequency)*Lambda*(FermiFunc(temperature,energy+Frequency+xx) - FermiFunc(temperature,energy+Frequency-xx)+ FermiFunc(temperature,-energy+Frequency-xx)-FermiFunc(temperature,-energy+Frequency+xx))/xx*dx
			summ+=increment
			xx+=dx
		While(xx<1)

	Return summ
	Endif
Endif
If (temperature <0)
	print "negative temperature is unphysical!"
	return 0
Endif
End
#pragma rtGlobals=1		// Use modern global access method.

Function FermiFunc(T,energy)
Variable T,energy
Variable kb = 8.617342*10^(-5)
return 1/(exp(energy/(kb*T)) + 1)
End

Function BozeFunction(T,energy)
variable T,energy
variable k= 8.617342*10^(-5) 
return 1/(-1+exp(energy/(k*T)))
End
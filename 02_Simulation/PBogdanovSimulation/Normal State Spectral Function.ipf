#pragma rtGlobals=1		// Use modern global access method.


// Compute ReSigGY and ImSigGY first in order not to recalculate them for each kx and ky

Function ABB(energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, T, ReSigGY, ImSigGY)
Variable energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, T
wave ReSigGY, ImSigGY
//Variable ImSigma = 0.054 + ImSigmaElPh( energy, Lambda, OmegaDebye,T) +  ImSigmaElEl( energy, beta)
//Variable Disp = energy - BareDispBB(t0, t1,t2, tc, FermiLevel, kx, ky) -  ReSigmaElPh(energy, Lambda, OmegaDebye,T)
Variable ImSigma = 0.054 + ImSigGY( energy)  +  ImSigmaElEl( energy, beta)
Variable Disp = energy - BareDispBB(t0, t1,t2, tc, FermiLevel, kx, ky)- ReSigGY( energy) 


return ImSigma/Pi/(Disp^2 + ImSigma^2)*FermiFunc(T,energy)
End

Function AAB(energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, T, ReSigGY, ImSigGY)
Variable energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, T
wave ReSigGY, ImSigGY
//Variable ImSigma = 0.054 + ImSigmaElPh( energy, Lambda, OmegaDebye, T) +  ImSigmaElEl( energy, beta)
//Variable Disp = energy - BareDispAB(t0, t1, t2, tc, FermiLevel, kx, ky) -  ReSigmaElPh( energy, Lambda, OmegaDebye,T)
Variable ImSigma = 0.054 + ImSigGY( energy) +  ImSigmaElEl( energy, beta)
Variable Disp = energy - BareDispAB(t0, t1, t2, tc, FermiLevel, kx, ky) - ReSigGY( energy)


return ImSigma/Pi/(Disp^2 + ImSigma^2)*FermiFunc(T,energy)
End

#pragma rtGlobals=1		// Use modern global access method.


Function ABBsc(energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, gap)
Variable energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, gap
Variable ImSigma = 0
Variable ReSigma =0
Variable gapnow = gap*(kx^2-ky^2)/Pi^2
Variable ek=BareDispBB(t0, t1, t2, tc, FermiLevel, kx, ky) 
If(energy==0)
	return 0
Else
	Variable A = ((energy + ReSigma)^2 - ImSigma^2) * ( 1 - gapnow^2/energy^2) - ek^2
	Variable B = 2*ImSigma*(energy + ReSigma)*( 1 - gapnow^2/energy^2)
	Variable Nominator = A*ImSigma - B*(energy + ReSigma +ek)
	Variable DeNominator = A^2 + B^2
	return abs(1/Pi*Nominator/Denominator*FermiFunc(20,energy))
Endif
End


Function AABsc(energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, gap)
Variable energy, beta, Lambda, OmegaDebye, t0, t1, t2, tc, FermiLevel, kx, ky, gap
Variable ImSigma = 0
Variable ReSigma =0
Variable gapnow = gap*(kx^2-ky^2)/Pi^2
Variable ek=BareDispAB(t0, t1, t2, tc, FermiLevel, kx, ky) 
If(energy==0)
	return 0
Else
	Variable A = ((energy + ReSigma)^2 - ImSigma^2) * ( 1 - gapnow^2/energy^2) - ek^2
	Variable B = 2*ImSigma*(energy + ReSigma)*( 1 - gapnow^2/energy^2)
	Variable Nominator = A*ImSigma - B*(energy + ReSigma +ek)
	Variable DeNominator = A^2 + B^2
	return abs(1/Pi*Nominator/Denominator*FermiFunc(20,energy))
Endif
End
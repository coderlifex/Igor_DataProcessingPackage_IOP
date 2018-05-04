#pragma rtGlobals=1		// Use modern global access method.


Macro MakeaCircle()

Variable x0=0
Variable y0=0
Variable R=0.922
Make/O/N=100  CirX, CirY
Setscale/I x, 0, 6.28, CirX
Setscale/I x, 0, 6.28, CirY

CirX=R*cos(x)+x0
CirY=R*sin(x)+y0

EndMacro




Macro MakeAStraightLine()

Variable x1=0.52371
Variable y1=-0.043
Variable x2=0.53457
Variable y2=-0.027

Variable StartX=0.49
Variable EndX=0.56



Make/O/N=100 LLine
Setscale/I x, StartX, EndX, LLine

LLine=y2+(y1-y2)/(x1-x2)*(x-x2)


EndMacro




Macro PlotMEM()
 General text load from "20070119081509_DAT.dat"
  LoadWave is unable to find column names on line 0
  Data length: 149, waves: wave0, wave1, wave2, wave3, wave4
  General text load from "20070119081509_DSP.dat"
  LoadWave is unable to find column names on line 0
  Data length: 300, waves: wave5, wave6, wave7, wave8, wave9
  
EndMacro

Function LorPLine(w,x)

	//w[0]   constant background;
	//w[1]   slope of Linear background; 
	//w[2]   position of Lorentzian;
	//w[3]   FWHM of the Lorentzian;
	//w[4]   A value related to height and Width;
	wave w; Variable x


	return w[0] + w[1]*x+ w[4]/((x-w[2])^2+(w[3]/2)^2)



End


Proc NCleanUpImage()


Duplicate/O   MDC500YDzZF8t20O0PP28T1P_1OA NMDC500YDzZF8t20O0PP28T1P_1OA
Variable i,j

j=0

Do

    
    
    i=0
    
    Do 
    
    NMDC500YDzZF8t20O0PP28T1P_1OA[i][j]=MDC500YDzZF8t20O0PP28T1P_1OA[i][j]
    
    i+=1
    While (i<539)
    
j+=1
While (j<651)

End    






Macro XJZCalSelfEnergy()

Make/O/N=400   AKW, Energy, ReSEnergy, ImSEnergy, BBand
Make/O/C/N=400 TSelfEnergy

Variable GapSize=0.0114         //When the gap is zero, the A(k,w) is a perfect Lorentian.
Variable Gamm0=0.0011          //For Overdoped it is zero, for underdoped but in superconducting state it is also zero.
Variable Gamma1=0.0117
Variable BKGD=3.7144
Variable Factor=3.8765


Setscale/I x, -0.3, 0.3, AKW
Setscale/I x, -0.3, 0.3, TSelfEnergy
Setscale/I x, -0.3, 0.3, ReSEnergy
Setscale/I x, -0.3, 0.3, ImSEnergy

TSelfEnergy=cmplx(Real((GapSize)^2/cmplx(x+0.000001,Gamm0)),-Gamma1+Imag((GapSize)^2/cmplx(x+0.000001,Gamm0)))
////ReSEnergy=Real(TSelfEnergy)
////ImSEnergy=Imag(TSelfEnergy)

AKW=factor*abs(Imag(TSelfEnergy))/((x-Real(TSelfEnergy))^2+Imag(TSelfEnergy)^2)+BKGD

////Display ReSEnergy
Display AKW

End


Function XJZSymmEDCFit(w,x)

	//w[0]   Constant background;
	//w[1]   Gap size;
	//w[2]   Gamma0: Inverse pair lifetime;
	//w[3]   Gamma1: Single particle scattering rate;
	//w[4]   PFactor:Prefector before A(k,w)
	
	Wave w; Variable x
	
	Variable/C TSelfEnergy
	TSelfEnergy=cmplx(Real((w[1])^2/cmplx(x+0.000001,w[2])),-w[3]+Imag((w[1])^2/cmplx(x+0.000001,w[2])))

    Variable AKW
	AKW=w[4]*abs(Imag(TSelfEnergy))/((x-Real(TSelfEnergy))^2+Imag(TSelfEnergy)^2)+w[0]
	
	Return AKW
	
END





//Get X wave and Y wave for a 2D image

//Function GetYWave(Wave0)
//Wave Wave0

Macro GetKxKy()
Variable Theta=36                         //,To be defined
Variable NofK=104                        //To be defined
Variable StartAngle=-18                     //To be defined
String ImagNamePrefix="L22F0t20P9T"
String KWavePrefix="KRef_DL22F0t20P9pT"

String TSign

If (Theta<0) 
TSign="n"
Else 
TSign="p"
Endif

String TAngle=Num2Str(abs(Theta))+Tsign

Make/O/N=(NofK)  Kx, Ky, Thetaa

Variable i
Variable j=Theta-StartAngle                                           

Do
Kx[i]=root:IMG:RRKx[i+j*NofK]                           
Ky[i]=Root:IMG:RRKy[i+j*NofK]                         
Thetaa[i]=Theta
i+=1
While(i<NofK)                                                       

String ImgName=ImagNamePrefix+TAngle


Edit root:PROCESS:$ImgName

Edit  Thetaa, Kx, ky
String KWave=KWavePrefix+TAngle
AppendToTable root:MDCSpectra:$KWave


Endmacro




/Macro CreatWave1()

//Variable i
//Variable j=0
//Do

//i=0
//Do 
//Wave1[i+104*j]=-21+j
//i+=1
//While (i<104)

//j+=1
//While (j<44)

//EndMacro



//Macro GetKxKy()
//Variable Theta=29


//Make/O/N=(104)  Kx, Ky, Thetaa

//Variable i
//Variable j=Theta+21


//Do
//Kx[i]=root:IMG:RRKx[i+j*104]
//Ky[i]=Root:IMG:RRKy[i+j*104]
//Thetaa[i]=Theta
//i+=1
//While(i<104)

//Edit Kx, ky,Thetaa

//Endmacro








//Function/T XJZImgInfo( image )
//================
// creates variables in current folder
// returns info string
	wave image
	variable/G nx, ny
	variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
	nx=DimSize(image, 0); 	ny=DimSize(image, 1)
	xmin=DimOffset(image,0);  ymin=DimOffset(image,1);
	xinc=round(DimDelta(image,0) * 1E6) / 1E6	
	yinc=round(DimDelta(image,1)* 1E6) / 1E6
	xmax=xmin+xinc*(nx-1);	ymax=ymin+yinc*(ny-1);
	WaveStats/Q image
	dmin0=V_min;  dmax0=V_max
	string info="x: "+num2istr(nx)+", "+num2str(xmin)+", "+num2str(xinc)+", "+num2str(xmax)
	info+=    "\r y: "+num2istr(ny)+", "+num2str(ymin)+", "+num2str(yinc)+", "+num2str(ymax)
	info+=    "\r z: "+num2str(dmin0)+", "+num2str(dmax0)
	return info
End








//Get maximum of an 1D wave
Function Maximum(Wave1D)
Wave Wave1D
Variable Dim1D=Dimsize(Wave1D,0)
Variable i=0
Variable maximumvalue=Wave1D[0]

Do
If (Wave1D[i]>maximumvalue)
Maximumvalue=Wave1D[i]
Endif
i+=1
While (i<Dim1D)

Return maximumvalue
END

//Reverse order of an 1D wave
Function Reverse1DOrder(Wave1D)
Wave Wave1D
Variable Dim1D=Dimsize(Wave1D,0)

Make/O/N=(Dim1D)  Rev_Wave


Variable i=0
Do
Rev_Wave[i]=Wave1D[Dim1D-i-1]
i+=1
While (i<Dim1D)

//Edit rev_Wave

//Return Rev_Wave

Wave1D=Rev_Wave

END



//Combine two data points into one

Function TwopointstoOne(Wave1D)
Wave Wave1D
Variable Dim1D=Dimsize(Wave1D,0)
Variable NDim=Round(Dim1D/2)

Make/O/N=(NDim)  NWave

Variable i=0

Do
NWave[i]=(Wave1D[2*i]+Wave1D[2*i+1])/2
i+=1
While (i<NDim)

Edit NWave
Return NWave
END

//Combine Three data points into one

Function ThreepointstoOne(Wave1D)
Wave Wave1D
Variable Dim1D=Dimsize(Wave1D,0)
Variable NDim=Round(Dim1D/3)

Make/O/N=(NDim)  NWave

Variable i=0

Do
NWave[i]=(Wave1D[3*i]+Wave1D[3*i+1]+Wave1D[3*i+2])/3
i+=1
While (i<NDim)

Edit NWave
Return NWave
END


//Combine N data points into one

Function N2One(Wave1D,NN)
Wave Wave1D
Variable NN
Variable Dim1D=Dimsize(Wave1D,0)
Variable NDim=Round(Dim1D/NN)

////String NWave="N"+Wave1D

Make/O/N=(NDim)  NWave

Variable i=0
Variable j
Do
    j=0
	Do
    NWave[i]+=Wave1D[NN*i+j]
    j+=1
    While (j<NN)
    NWave[i]/=NN
i+=1
While (i<NDim)


Edit NWave
Return NWave
END



//Get minimum of an 1D wave
Function Minimum(Wave1D)
Wave Wave1D
Variable Dim1D=Dimsize(Wave1D,0)
Variable i=0
Variable minimumvalue=Wave1D[0]

Do
If (Wave1D[i]<minimumvalue)
Minimumvalue=Wave1D[i]
Endif
i+=1
While (i<Dim1D)

Return minimumvalue
END


//Shift 1D Wave
Function Shift1D(Wave1D,ShiftValue)
Wave Wave1D
Variable ShiftValue
Variable Dim1D=Dimsize(Wave1D,0)
Setscale/P x, DimOffset(Wave1,0)-ShiftValue, Round(DimDelta(Wave1D,0)*1E6)/1E6, Wave1D
Return Wave1D
END



//Get X reference wave from a 2D image
Function XWavefrom2D(Image2D)
Wave Image2D
Variable nX, nY, Xmin, Xinc, Xmax, Ymin, Yinc, Ymax

nX=DimSize(Image2D,0) 
Xmin=DimOffset(Image2D,0)
Xinc=Round(DimDelta(Image2D,0)*1E6)/1E6
Xmax=Xmin+Xinc*(nX-1)

Make/O/N=(nX)  XAxis
Variable i=0
Do
XAxis[i]=Xmin+i*Xinc
i+=1
While (i<nX)

Return XAxis
End


//Get Y reference wave from a 2D image
Function YWavefrom2D(Image2D)
Wave Image2D
Variable nX, nY, Xmin, Xinc, Xmax, Ymin, Yinc, Ymax

nY=DimSize(Image2D,1) 
Ymin=DimOffset(Image2D,1)
Yinc=Round(DimDelta(Image2D,1)*1E6)/1E6
Ymax=Ymin+Yinc*(nY-1)

Make/O/N=(nY) YAxis
Variable i=0
Do
YAxis[i]=Ymin+i*Yinc
i+=1
While (i<nY)

Return YAxis
End


Function OrderSmalltoLarge(wavex,wavey)
Wave Wavex, Wavey
Variable WavePointx=DimSize(Wavex,0)
Variable WavePointy=DimSize(Wavey,0)

If (WavePointx==WavePointy)
Else
Print "The two waves do not have the same dimension"
Endif

             Make/O/N=(WavePointx)  NWavex, NWavey
             
             Variable iOrd=0
             Variable jOrd=0
             Variable iFind
             Variable MinOrdx, MinOrdy
             
             NWavex=Wavex
             NWavey=Wavey 

            Do
             MinOrdx= NWavex[iOrd] 
             MinOrdy= NWavey[iOrd]              
                     iFind=iOrd
                     jOrd=iOrd        
             		Do
            		IF (MinOrdx>NWavex[jOrd])
            		MinOrdx=NWavex[jOrd]
            		MinOrdy=NWavey[jOrd]            		
             		iFind=jOrd
             		Else
             		EndIF
             		jOrd+=1
             		While (jOrd<WavePointx)
             		
              NWavex[iFind]=NWavex[iOrd]
              NWavey[iFind]=NWavey[iOrd]             
              NWavex[iOrd]=MinOrdx
              NWavey[iOrd]=MinOrdy
             
               iOrd+=1
              While (iOrd<WavePointx)
             
//           Edit NWavex, NWavey
             Wavex=NWavex
             Wavey=NWavey
             
End





Function XJZIntegral(wavex, wavey)
wave wavex, wavey
variable i=0, integral=0
do
	integral += (wavey[i+1]+wavey[i])/2*(wavex[i+1] - wavex[i]) 
	i+=1
while (i<DimSize(wavey,0))
return integral
End



Function GetAverandSdev(wave0)

Wave wave0
Variable num=dimsize(wave0,0)


Variable Total=0
Variable i=0
Do
Total=Total+Wave0[i]
i+=1
While (i<num)
Variable AV=Total/num

Print "Average=", AV




Variable SDev=0
Variable Sqa
Variable j=0
Do
Sqa=Sqa+(Wave0[j]-AV)^2
j+=1
While (j<num)

Sdev=sqrt(Sqa/(num-1))
 
Print "Standard Deviation=", Sdev

End


Function ShowEDCfromImage(ImageWave,EDCNumber,Offset, Binding)
Wave  ImageWave
Variable EDCNumber, Offset, Binding
Variable  NX, NY, Xmin, Xinc, Xmax, Ymin, Yinc, Ymax, dmin0, dmax0
	NX=DimSize(imagewave, 0); 	NY=DimSize(imagewave, 1)
	Xmin=DimOffset(imagewave,0);  ymin=DimOffset(imagewave,1);
	Xinc=round(DimDelta(imagewave,0) * 1E6) / 1E6	
	Yinc=round(DimDelta(imagewave,1)* 1E6) / 1E6
	Xmax=Xmin+Xinc*(NX-1);	Ymax=Ymin+Yinc*(NY-1);
	
            String ReferenceEnergyWave="OriEnergy" 
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave  
                Variable i=0
      	         Do
        		ReferenceEnergy[i]=Xmin+i*Xinc
        		i+=1
       	 	While(i<NX)  	

////Variable i=0
////Do
////EDCEnergy[i]=Xmin+i*Xinc
////i+=1
////While(i<NX)

	NVar FermiCorrectionFlag=root:FermiLevelFromAu:CorrectionFlag
    NVar AverageFermi=root:PROCESS:zerofermi


              IF (FermiCorrectionFlag==1)
              Execute "InterpolateFermiLevel()"
              WAVE InterFermiLevel=root:FermiLevelFromAu:Fermi_Level_L
              ENDIF


String EDCName=NameofWave(ImageWave)+num2str(EDCNumber)+"C"
////String EDC_E=NameofWave(ImageWave)++num2str(EDCNumber)+"_E"
String EDC_E=NameofWave(ImageWave)+"_E"
Make/O/N=(NX) $EDCName, $EDC_E, TempInterFermiLevel
Wave EDCWave=$EDCName
Setscale/I x, Xmin, Xmax, EDCWave
Wave EDCEnergy=$EDC_E


//Variable j
//EDCWave=0 
//j=0
//Do
//EDCWave+=ImageWave[p] [EDCNumber-j]
//TempInterFermiLevel+=InterFermiLevel[EDCNumber-j]
//While (j<Binding)
                 	
//EDCWave/=Binding
//TempInterFermiLevel/=Binding

//                  IF (FermiCorrectionFlag==1)                
//                  EDCEnergy=ReferenceEnergy-TempInterFermiLevel+AverageFermi
//                  ELSE
//                  EDCEnergy=ReferenceEnergy
//                  ENDIF


If (Binding==1)
EDCWave=ImageWave[p][EDCNumber]

                  IF (FermiCorrectionFlag==1)                
                  EDCEnergy=ReferenceEnergy-InterFermiLevel[EDCNumber]+AverageFermi
                  ELSE
                  EDCEnergy=ReferenceEnergy
                  ENDIF
	
Endif




If (Binding==2)
EDCWave=(ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1])/2

                  IF (FermiCorrectionFlag==1)                
                  EDCEnergy=ReferenceEnergy-(InterFermiLevel[EDCNumber]+InterFermiLevel[EDCNumber+1])/2+AverageFermi
                  ELSE
                  EDCEnergy=ReferenceEnergy
		 ENDIF

Endif



If (Binding==3)
EDCWave=(ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1])/3
                  IF (FermiCorrectionFlag==1)                
                  EDCEnergy=ReferenceEnergy-(InterFermiLevel[EDCNumber-1]+InterFermiLevel[EDCNumber]+InterFermiLevel[EDCNumber+1])/3+AverageFermi
                  ELSE
                  EDCEnergy=ReferenceEnergy
		 ENDIF
Endif



If (Binding==4)
EDCWave=(ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1]+ImageWave[p][EDCNumber+2])/4

                  IF (FermiCorrectionFlag==1)                
                  EDCEnergy=ReferenceEnergy-(InterFermiLevel[EDCNumber-1]+InterFermiLevel[EDCNumber]+InterFermiLevel[EDCNumber+1]+InterFermiLevel[EDCNumber+2])/4+AverageFermi
                  ELSE
                  EDCEnergy=ReferenceEnergy
		 ENDIF

Endif





If (Binding==5)
EDCWave=(ImageWave[p][EDCNumber-2]+ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1]+ImageWave[p][EDCNumber+2])/5

                  IF (FermiCorrectionFlag==1)                
                  EDCEnergy=ReferenceEnergy-(InterFermiLevel[EDCNumber-2]+InterFermiLevel[EDCNumber-1]+InterFermiLevel[EDCNumber]+InterFermiLevel[EDCNumber+1]+InterFermiLevel[EDCNumber+2])/5+AverageFermi
                  ELSE
                  EDCEnergy=ReferenceEnergy
		 ENDIF
Endif


EDCWave+=Offset

NVar PlotEDCMode=root:SchematicFermiSurface:EDCPlotMode
////Print "PlotEDCMode=", PlotEDCMode
     IF (PlotEDCMode==1)  
     WaveSymmetrize(EDCWave,0)
     Duplicate/O EnWave EDCWave
     EndIF

AppendtoGraph EDCWave
////ModifyGraph rgb(EDCWave)=(0,15872,65280)


//Display EDCWave vs EDCEnergy
//AppendtoGraph EDCWave vs EDCEnergy
//Return EDCWave

End


Function ShowEDCfromImage_Original(ImageWave,EDCNumber,Offset, Binding)
Wave  ImageWave
Variable EDCNumber, Offset, Binding
Variable  NX, NY, Xmin, Xinc, Xmax, Ymin, Yinc, Ymax, dmin0, dmax0
	NX=DimSize(imagewave, 0); 	NY=DimSize(imagewave, 1)
	Xmin=DimOffset(imagewave,0);  ymin=DimOffset(imagewave,1);
	Xinc=round(DimDelta(imagewave,0) * 1E6) / 1E6	
	Yinc=round(DimDelta(imagewave,1)* 1E6) / 1E6
	Xmax=Xmin+Xinc*(NX-1);	Ymax=Ymin+Yinc*(NY-1);
	
	
	

String EDCName=NameofWave(ImageWave)+num2str(EDCNumber)+"C"
String EDC_E=NameofWave(ImageWave)+"_E"
Make/O/N=(NX) $EDCName, $EDC_E
Wave EDCWave=$EDCName
Setscale/I x, Xmin, Xmax, EDCWave
Wave EDCEnergy=$EDC_E



If (Binding==1)
EDCWave=ImageWave[p][EDCNumber]
Endif

If (Binding==2)
EDCWave=(ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1])/2
Endif

If (Binding==3)
EDCWave=(ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1])/3
Endif

If (Binding==4)
EDCWave=(ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1]+ImageWave[p][EDCNumber+2])/4
Endif

If (Binding==5)
EDCWave=(ImageWave[p][EDCNumber-2]+ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1]+ImageWave[p][EDCNumber+2])/5
Endif


EDCWave+=Offset
Variable i=0
Do
EDCEnergy[i]=Xmin+i*Xinc

i+=1
While(i<NX)



NVar PlotEDCMode=root:SchematicFermiSurface:EDCPlotMode
Print "PlotEDCMode=", PlotEDCMode
     IF (PlotEDCMode==1)  
     WaveSymmetrize(EDCWave,0)
     Duplicate/O EnWave EDCWave
     EndIF

AppendtoGraph EDCWave
//Display EDCWave vs EDCEnergy
//AppendtoGraph EDCWave vs EDCEnergy
//Return EDCWave

End



Function GetEDCfromImage(ImageWave,EDCNumber, Offset, Binding)
Wave  ImageWave
Variable EDCNumber, Offset, Binding
Variable  NX, NY, Xmin, Xinc, Xmax, Ymin, Yinc, Ymax, dmin0, dmax0
	NX=DimSize(imagewave, 0); 	NY=DimSize(imagewave, 1)
	Xmin=DimOffset(imagewave,0);  ymin=DimOffset(imagewave,1);
	Xinc=round(DimDelta(imagewave,0) * 1E6) / 1E6	
	Yinc=round(DimDelta(imagewave,1)* 1E6) / 1E6
	Xmax=Xmin+Xinc*(NX-1);	Ymax=Ymin+Yinc*(NY-1);
	

String EDCName=NameofWave(ImageWave)+num2str(EDCNumber)+"I"
String EDC_E=NameofWave(ImageWave)+"_E"
Make/O/N=(NX) $EDCName, $EDC_E
Wave EDCWave=$EDCName
Setscale/I x, Xmin, Xmax, EDCWave
Wave EDCEnergy=$EDC_E

If (Binding==1)
EDCWave=ImageWave[p][EDCNumber]
Endif

If (Binding==2)
EDCWave=(ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1])/2
Endif

If (Binding==3)
EDCWave=(ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1])/3
Endif

If (Binding==4)
EDCWave=(ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1]+ImageWave[p][EDCNumber+2])/4
Endif

If (Binding==5)
EDCWave=(ImageWave[p][EDCNumber-2]+ImageWave[p][EDCNumber-1]+ImageWave[p][EDCNumber]+ImageWave[p][EDCNumber+1]+ImageWave[p][EDCNumber+2])/5
Endif


NVar PlotEDCMode=root:SchematicFermiSurface:EDCPlotMode

Print "PlotEDCMode=", PlotEDCMode

IF (PlotEDCMode==1)

WaveSymmetrize(EDCWave,0)
Duplicate/O EnWave EDCWave

EndIF



EDCWave+=Offset
Variable i=0
Do
EDCEnergy[i]=Xmin+i*Xinc

i+=1
While(i<NX)
//Display EDCWave vs EDCEnergy
//AppendtoGraph EDCWave vs EDCEnergy
Return EDCWave

End






Function ShowMDCfromImage(ImageWave,MDCNumber,Offset, Binding)
Wave  ImageWave
Variable MDCNumber, Offset, Binding
Variable  NX, NY, Xmin, Xinc, Xmax, Ymin, Yinc, Ymax, dmin0, dmax0
	NX=DimSize(imagewave, 0); 	NY=DimSize(imagewave, 1)
	Xmin=DimOffset(imagewave,0);  ymin=DimOffset(imagewave,1);
	Xinc=round(DimDelta(imagewave,0) * 1E6) / 1E6	
	Yinc=round(DimDelta(imagewave,1)* 1E6) / 1E6
	Xmax=Xmin+Xinc*(NX-1);	Ymax=Ymin+Yinc*(NY-1);
	

String MDCName=NameofWave(ImageWave)+num2str(MDCNumber)
String MDC_k=NameofWave(ImageWave)+"_k"
Make/O/N=(NX) $MDCName, $MDC_k
Wave MDCWave=$MDCName
Wave MDCMomentum=$MDC_k

If (Binding==1)
MDCWave=ImageWave[p][MDCNumber]
Endif

If (Binding==2)
MDCWave=(ImageWave[p][MDCNumber]+ImageWave[p][MDCNumber+1])/2
Endif

If (Binding==3)
MDCWave=(ImageWave[p][MDCNumber-1]+ImageWave[p][MDCNumber]+ImageWave[p][MDCNumber+1])/3
Endif

If (Binding==4)
MDCWave=(ImageWave[p][MDCNumber-1]+ImageWave[p][MDCNumber]+ImageWave[p][MDCNumber+1]+ImageWave[p][MDCNumber+2])/4
Endif

If (Binding==5)
MDCWave=(ImageWave[p][MDCNumber-2]+ImageWave[p][MDCNumber-1]+ImageWave[p][MDCNumber]+ImageWave[p][MDCNumber+1]+ImageWave[p][MDCNumber+2])/5
Endif


MDCWave+=Offset
Variable i=0
Do
MDCMomentum[i]=Xmin+i*Xinc

i+=1
While(i<NX)

//smoothMDCWave-----JXW------------
smooth 2,MDCWave
//---------------------------------
AppendtoGraph MDCWave vs MDCMomentum

End




Function ReferenceWaveX(Imagewave)
Wave Imagewave
Variable  NX, NY, Xmin, Xinc,Ymin, Yinc
	NX=DimSize(imagewave, 0); 	NY=DimSize(imagewave, 1)
	Xmin=DimOffset(imagewave,0);  ymin=DimOffset(imagewave,1);
	Xinc=round(DimDelta(imagewave,0) * 1E6) / 1E6	
	Yinc=round(DimDelta(imagewave,1)* 1E6) / 1E6
//	Xmax=Xmin+Xinc*(NX-1);	Ymax=Ymin+Yinc*(NY-1);

Make/O/N=(NX) ReferenceX
Variable i=0
Do
ReferenceX[i]=Xmin+i*Xinc
i+=1
While (i<NX)

//Edit ReferenceX
Return ReferenceX
END

Function ReferenceWaveY(Imagewave)
Wave Imagewave
Variable  NX, NY, Xmin, Xinc,Ymin, Yinc
	NX=DimSize(imagewave, 0); 	NY=DimSize(imagewave, 1)
	Xmin=DimOffset(imagewave,0);  ymin=DimOffset(imagewave,1);
	Xinc=round(DimDelta(imagewave,0) * 1E6) / 1E6	
	Yinc=round(DimDelta(imagewave,1)* 1E6) / 1E6
//	Xmax=Xmin+Xinc*(NX-1);	Ymax=Ymin+Yinc*(NY-1);
	
Make/O/N=(NY) ReferenceY
Variable i=0
Do
ReferenceY[i]=Ymin+i*Yinc
i+=1
While (i<NY)

//Edit ReferenceY
Return ReferenceY
END





Function PositionofValue(Wave1D,Value)
Wave Wave1D
Variable Value
Variable NX, Xmin, Xinc, Xmax
	NX=DimSize(Wave1D, 0)
	Xmin=Wave1D[0]
	Xmax=Wave1D[NX]
	Xinc=abs(round((Xmax-Xmin)/(NX-1)* 1E6) / 1E6)	
	
//	Print NX, Xmin, Xinc, Xmax

Variable i_Find
Variable i=0
Variable Diff

Do
Diff=abs(Wave1D[i]-Value)

IF (Diff<(Xinc/2))
i_Find=i
Else
Endif

i+=1
While(i<NX)

If (i_Find==0)
Print "The value is not in the range... ..."
Endif
		
//Print i_Find	
Return i_Find
End


Function XJZIntegral1D(wave1D,x,y)
Wave Wave1D
Variable x, y

variable i=0, integral=0
//do
//	integral += (wavey[i+1]+wavey[i])/2*(wavex[i+1] - wavex[i]) 
//	i+=1
//while (i<DimSize(wavey,0))
return integral
End




Function/Wave WaveSymmetrize(Wave1D,SymmValue)

Wave Wave1D
Variable  SymmValue
NVar ErToler=root:PROCESS:ErToler


    Variable NXO, XminO, XincO, XmaxO
	NXO=DimSize(Wave1D, 0)
	XminO=DimOffset(Wave1D,0)
    XincO=round(DimDelta(Wave1D,0) * 1E6) / 1E6	
	XmaxO=XminO+(NXO-1)*XincO

////    Variable  NxInterWave1D=Round(XincO/ErToler*1000)*NXO
////    Variable  NNxInterWave1D=Round((XmaxO-XminO)/ErToler*1000+1)
    
    Variable  NxInterWave1D=Round((XmaxO-XminO)/ErToler*1000+1)  
    
    
////    Print "Nx=", NxInterWave1D
////    Print "NNx=", NNxInterWave1D

// Print "Xinc=", XincO, "ErToler=", ErToler, "NxInterWaveD=",  NxInterWave1D
//  	Print "XminO=", XminO, "XmaxO=", XmaxO, "XincO=", XincO	
	
	
    Interpolate2/T=1/N=(NxInterWave1D)/Y=Wave1D_L Wave1D
    
    
    Variable NX, Xmin, Xinc, Xmax
	NX=DimSize(Wave1D_L, 0)
	Xmin=DimOffset(Wave1D_L,0)
    Xinc=round(DimDelta(Wave1D_L,0) * 1E6) / 1E6	
	Xmax=Xmin+(NX-1)*Xinc  
	
    Duplicate/O Wave1D_L NWave1D  

    Variable NXL, NXR
    
    IF ((Xmax-SymmValue)<0)    
       NXL=NX
       NXR=0
    EndIF
     
    
    
    IF ((Xmin-SymmValue)>0)    
       NXR=NX
       NXL=0
    EndIF  
    
    
    
    IF ((Xmax-SymmValue)>=0)    
         
         IF ((Xmin-SymmValue)<=0)      
         NXL=Round((SymmValue-Xmin)/Xinc)
         NXR=Round(NX-NXL)
         EndIF       
        
    EndIF
    
//  Print "NXL=", NXL, "NXR=", NXR
    
//  Variable NWaveD=2*max(NXL,NXR)
    Variable NWaveD
    
    IF (NXL>=NXR)
        NWaveD=Round((2*SymmValue-2*Xmin)/Xinc)+1
    Else
        NWaveD=Round((2*Xmax-2*SymmValue)/Xinc)+1 
    EndIF 
    
    
    Variable NWavemin, NWavemax
    
    
    IF(NXL>=NXR)
        NWavemin=Xmin
        NWavemax=2*SymmValue-Xmin
    Else 
        NWavemax=Xmax
        NWavemin=2*SymmValue-Xmax
    EndIF
    
/// Print "Xmin=", Xmin,"Xmax=", Xmax, "NWaveD=",NWaveD, "NWavemin=", NWavemin, "NWavemax=", NWavemax    
    
    Make/O/N=(NWaveD)  EnWave, EnWaveL, EnWaveR
    Setscale/I x, (NWavemin),(NWavemax), EnWave
    Setscale/I x, (NWavemin), (NWavemax), EnWaveL  
    Setscale/I x, (NWavemin), (NWavemax), EnWaveR    
     
    EnWaveL=0
    EnWaveR=0
    
    Variable i
  
   
    i=0    
    DO   
        IF (NXL>=NXR)
            IF (i<NX)
            EnWaveL[i]=NWave1D[i]
            Else
            EnWaveL[i]=NWave1D[NX-1]
            EndIF
//      EnWaveR[NXL-NXR+i]=NWave1D[NX-i]
        Else
//      EnWaveR[NXR-NXL+i]=NWave1D[i]
        
            IF (i<NX)
            EnWaveL[i]=NWave1D[NX-1-i]
            Else
            EnWave[i]=NWave1D[0]
            EndIF 
        
        
        
//      Print NX, EnWaveL[i], Wave1D[NX-1-i]     
        EndIF
        
        EnWaveR[NWaveD-i-1]=EnWaveL[i]
        
             
    i+=1    
    While (i<NWaveD)
    
    EnWave=EnwaveL + EnWaveR
    

////Edit EnWave, EnWaveL, EnWaveR    
//Display EnWave

Return EnWave
    
End
   
    
    
    
//This is a function to extend local to unlocal, uneven to even waves, made on 2007/05/18  
  
Function ReMakeWave(WY,WX, x1, x2, dx)

Wave WY,WX
Variable x1, x2, dx
Variable NWaveY=DimSize(WY,0)

Variable NInterWaveY=Round(abs((WX[NWaveY]-WX[0])/dx))

Variable NEntirePoints=Round(abs((x2-x1)/dx))

Variable NNewWave=Round(abs((x2-x1)/dx))


Interpolate2/T=1/N=(NInterWaveY+1)/F=1/Y=WY_SS/X=WX_SS WX, WY

Wave InterWY=WY_SS

Variable NInterStart=Round(abs((x1-WX[0])/dx))
Variable NInterEnd=Round(abs((x1-WX[0])/dx))

Make/O/N=(NNewWave+1) NWY, NWX

Variable j=0
Do
NWX[j]=x1+j*dx
j+=1
While(j<NNewWave+1)



NWY=0

IF (WX[0]>=x1)

    if (WX[NWaveY]<=x2)

            Variable i=0

             Do

//             If (i>=NInterStart)
//                     If (i<=NInterEnd)
    
                     NWY[i+NInterStart]=InterWY[i]
             
//                     Endif
//              EndIf
 
 
//print "NInterStart=", NWY[i+NInterStart]
              i+=1
              While (i<NInterWaveY+1)



    endif

EndIF    


Return NWY

End   


Macro ForBansilCreatWave1()

Variable i
Variable j=0
Do

i=0
Do 
Wave1[i+104*j]=-21+j
i+=1
While (i<104)

j+=1
While (j<44)

EndMacro



Macro ForBansilGetKxKy()
Variable Theta=26

String TSign

If (Theta<0) 
TSign="N"
Else 
TSign="P"
Endif

String TAngle=Num2Str(abs(Theta))+Tsign

Variable NkPoint=76
Variable FTheta=-19

Make/O/N=(NkPoint)  Kx, Ky, Thetaa

Variable i
Variable j=Theta-FTheta


Do
Kx[i]=root:IMG:RRKx[i+j*NkPoint]
Ky[i]=Root:IMG:RRKy[i+j*NkPoint]
Thetaa[i]=Theta
i+=1
While(i<NkPoint)

String ImgName="L07F4t20O0PP9T"+TAngle


Edit root:PROCESS:$ImgName

Edit  Thetaa, Kx, ky
//String KWave="KRef_DL15F0t20P10pT"+TAngle
//AppendToTable root:MDCSpectra:$KWave


Endmacro



    
    
    
    

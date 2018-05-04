#pragma rtGlobals=1		// Use modern global access method.
menu "Simulation"
	"CDW fluctuation",  CDW_fluctuation_simulation()
end

proc CDW_fluctuation_simulation()
	if (!DataFolderExists("root:Simulation"))
		newdatafolder root:Simulation
	endif
	if (!DataFolderExists("root:Simulation:CDWFluctuation"))
		newdatafolder root:Simulation:CDWFluctuation
	endif
	
	setdatafolder root:Simulation:CDWFluctuation
	variable a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Vf",1)          //Fermi velocity
	variable/g Vf=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:corrlens",0.02)         //correlation length
	variable/g corrlens=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Phi",0.025)    //gap related
	variable/g Phi=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Kpixels",500)  //simulation img points
	variable/g	Kpixels=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Epixels",500)
	variable/g	Epixels=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Emax",0.2)
	variable/g	Emax=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Emin",-0.5)
	variable/g	Emin=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Kmax",1)	
	variable/g	Kmax=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Kmin",0)	
	variable/g	Kmin=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:EnergyResolution",5)
	Variable/G EnergyResolution=a	
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:MomentumResolution",0.004)
	Variable/G MomentumResolution=a	
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Temperature_2DImage",250)
	Variable/G Temperature_2DImage=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:lattice",7.59)     //lattice constant	
	Variable/g lattice=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:Kf",0.5)     //Fermi vector
	variable/g Kf=a
	string/g image2Dlist=wavelist("!Gau*",";","DIMS:2" )	
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:EDCEVery_2DImage",5)
	variable/g EDCEVery_2DImage=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:EDCOffset_2DImage",0)
	variable/g EDCOffset_2DImage=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:showselectEDC",0)
	variable/g showselectEDC=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:EDCStart",0)
	variable/g EDCStart=a
	a=NumVarOrDefault("root:Simulation:CDWFluctuation:EDCEnd",100)
	variable/g EDCEnd=a

	
	DoWindow/F CDWsimulationPanel
	if (V_flag==0)
	CDWsimulationPanel()
	else
		DoWindow/F CDWsimulationPanel
	endif
end



Window CDWsimulationPanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(430,252,1057,580)
	Button button0,pos={69,222},size={80,30},proc=CDWSpectraSimulation,title="Simulation"
	SetVariable setvar0,pos={27,41},size={100,16},title="Kf(Pi/a)"
	SetVariable setvar0,value= root:Simulation:CDWFluctuation:Kf
	SetVariable setvar1,pos={25,118},size={200,16},title="1/correlength(1/A)"
	SetVariable setvar1,value= root:Simulation:CDWFluctuation:corrlens
	SetVariable setvar2,pos={26,93},size={150,16},title="Phi(ev*ev)"
	SetVariable setvar2,value= root:Simulation:CDWFluctuation:Phi
	SetVariable setvar3,pos={150,40},size={120,16},title="Vf(eV/(Pi/A))"
	SetVariable setvar3,value= root:Simulation:CDWFluctuation:Vf
	SetVariable setvar6,pos={25,165},size={150,16},title="EResolution(meV)"
	SetVariable setvar6,value= root:Simulation:CDWFluctuation:EnergyResolution
	SetVariable setvar7,pos={26,192},size={170,16},title="MResolution(1/A)"
	SetVariable setvar7,value= root:Simulation:CDWFluctuation:MomentumResolution
	SetVariable setvar4,pos={27,66},size={120,16},title="lattice(A)"
	SetVariable setvar4,value= root:Simulation:CDWFluctuation:lattice
	SetVariable setvar5,pos={26,142},size={130,16},title="Temprature(K)"
	SetVariable setvar5,value= root:Simulation:CDWFluctuation:Temperature_2DImage
	PopupMenu popup0,pos={26,273},size={196,20},bodyWidth=119,proc=Imageshow,title="ShowImage"
	PopupMenu popup0,fSize=14,fStyle=17
	PopupMenu popup0,mode=1,popvalue="Akw",value= #"root:Simulation:CDWFluctuation:image2Dlist"
	PopupMenu popup1,pos={353,276},size={173,20},bodyWidth=112,proc=MDXShow2DImageEDC,title="ShowEDC"
	PopupMenu popup1,fSize=14,fStyle=17
	PopupMenu popup1,mode=2,popvalue="Original_Image",value= #"root:Simulation:CDWFluctuation:image2Dlist"
	SetVariable setvar8,pos={470,229},size={100,16},title="EDCOffset"
	SetVariable setvar8,value= root:Simulation:CDWFluctuation:EDCOffset_2DImage
	SetVariable setvar9,pos={351,230},size={100,16},title="showEvery"
	SetVariable setvar9,value= root:Simulation:CDWFluctuation:EDCEVery_2DImage
	GroupBox group0,pos={12,12},size={286,305},title="imgsimulation"
	GroupBox group0,fColor=(2048,29696,47360)
	SetVariable setvar10,pos={356,168},size={85,16},title="Start"
	SetVariable setvar10,value= root:Simulation:CDWFluctuation:EDCStart
	SetVariable setvar11,pos={465,169},size={80,16},title="End"
	SetVariable setvar11,value= root:Simulation:CDWFluctuation:EDCEnd
	CheckBox check0,pos={359,140},size={84,14},title="selectedEDC"
	CheckBox check0,variable= root:Simulation:CDWFluctuation:showselectEDC
	GroupBox group1,pos={332,112},size={267,201}
	GroupBox group2,pos={349,135},size={232,58}
EndMacro



proc CDWSpectraSimulation(ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:Simulation:CDWFluctuation
//	variable Kmin=0
//	variable Kmax=1
//	variable Emin=-0.5
//	variable Emax=0.2
	make/n=(Kpixels,Epixels)/o  Akw
	SetScale/I y Emin, Emax,"", Akw;DelayUpdate
	SetScale/I x Kmin, Kmax,"", Akw
	Akw=(Vf*lattice/3.141593)*corrlens*phi/((y*y-Vf*(x-Kf)*Vf*(x-Kf)-phi)*(y*y-Vf*(x-Kf)*Vf*(x-Kf)-phi)+Vf*Vf*corrlens*corrlens*(y-Vf*(x-Kf))*(y-Vf*(x-Kf))) //spectra formula from NShannon et al., J.Phys.:Condens. Matter 8(1995) 10493
	Make/O/N=(51,81)/D Gaussian
	SetScale/I x -0.05,0.05,"", Gaussian
	SetScale/I y -0.04,0.04,"", Gaussian
	Gaussian=exp(-y^2/2/(Energyresolution/2.3548/1000)^2)/2.506628274631000502415765284811/(Energyresolution/2.3548/1000)*exp(-x^2/2/(Momentumresolution*3.141593/lattice/2.3548)^2)/2.506628274631000502415765284811/(Momentumresolution*3.141593/lattice/2.3548)
	Duplicate/O Akw,Original_Image
	Original_Image=Original_Image/(exp(y*11594.2/Temperature_2DImage)+1)
	Duplicate/O Original_Image,Convolved_Image
	matrixconvolve gaussian,Convolved_Image
	Duplicate/O Convolved_Image,DCF_Image
	DCF_Image=DCF_Image*(exp(y*11594.2/Temperature_2DImage)+1)
	image2Dlist=wavelist("!Gau*",";","DIMS:2" )
	
end

Function Imageshow(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	setdatafolder root:Simulation:CDWFluctuation
	DoWindow/F $("CDW"+popStr)
	if (V_flag==0)
	Display;AppendImage $popStr
	ModifyImage $popStr ctab= {*,*,PlanetEarth,1}
	Label left "Energy(eV)";DelayUpdate
	Label bottom "K(\\F'Symbol'p\\F'Arial'/a)"
	ModifyGraph tick=2
	DoWindow/c $("CDW"+popStr)
	else
		DoWindow/F $("CDW"+popStr)
	endif

End


function MDXShow2DImageEDC(ctrlName,popNum,popStr):PopupMenuControl
		String CtrlName
		variable popnum
		String popStr
		String EDCGraphN="EDC"+popStr
		//string EDCPath="EDC_"+popStr
		
		DoWindow/K $EDCGraphN		
		newdatafolder/O/s root:Simulation:CDWFluctuation:AKW_EDC		
		killwaves/A/Z 
		newdatafolder/O/s root:simulation:CDWFluctuation:original_EDC
		killwaves/A/Z 
		newdatafolder/O/s root:simulation:CDWFluctuation:Convolved_EDC
		killwaves/A/Z 
		newdatafolder/O/s root:simulation:CDWFluctuation:DF_EDC
		killwaves/A/Z 
		
		setdatafolder root:Simulation:CDWFluctuation
		
 		nvar EDCEVery_2DImage
 		nvar EDCOffset_2DImage
		nvar showselectEDC
		nvar EDCStart
		nvar EDCEnd
		nvar Emin
		nvar Emax
		
		Display/N=$EDCGraphN
		variable ii
		variable jj
		string edcN
	//	setdatafolder root:Simulation:Image2DSimulation

		string E="EnergyScale"
		wave Energy=$E
		wave Image=$popstr
		//matrixtranspose Image
		Make/O/N=(Dimsize(Image,1)) EDC
		SetScale/I x Emin,Emax,"", EDC
		if (showselectEDC)
			ii=EDCStart 
			DO
			SetDatafolder root:Simulation:CDWFluctuation
			//display A[1][] vs x
				edcn="EDC"+num2str(ii)
	//			Make/O/N=(Dimsize(Image,1)) EDC
	//			setscale/i x,Emin,Emax,"", EDC
				//wave EDC=$EDCN
           //WAVE EDCC=$EDC0
           		EDC=Image[ii][p]
           		
           		strswitch (popstr)
					case "Original_Image":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:original_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:original_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "Akw":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:AKw_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:AKw_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "DCF_Image":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:DF_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:DF_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "Convolved_Image":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:Convolved_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:Convolved_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
				endswitch
           		
           		//appendtograph EDC
           		
			ii=ii+EDCEVery_2DImage-1
			while(ii<EDCEnd+1)
		
		else
			for(ii=0;ii<Dimsize(Image,0);ii=ii+1)
			SetDatafolder root:Simulation:CDWFluctuation
			//display A[1][] vs x
				edcn="EDC"+num2str(ii)

				//wave EDC=$EDCN
           //WAVE EDCC=$EDC0
           		EDC=Image[ii][p]
           		
           		strswitch (popstr)
					case "Original_Image":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:original_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:original_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "Akw":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:AKw_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:AKw_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "DCF_Image":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:DF_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:DF_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
					case "Convolved_Image":
							Duplicate/O EDC,root:Simulation:CDWFluctuation:Convolved_EDC:$EDCN
							SetDatafolder root:Simulation:CDWFluctuation:Convolved_EDC
							appendtograph $EDCN
							ModifyGraph offset($EDCN)={0,ii*5*EDCOffset_2DImage}
							break
				endswitch
           		
           		//appendtograph EDC
           		
			ii=ii+EDCEVery_2DImage-1
			endfor
			
			
		endif
end
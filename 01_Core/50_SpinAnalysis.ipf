#pragma rtGlobals=1		// Use modern global access method.
Proc SpinAna()
NewDataFolder/O/S root:Spin
dowindow/F SpinAnalysis
string curr=getdatafolder(1)
spinpara()
setdatafolder curr
if(V_Flag==0)
SpinAnalysis() 
endif
setdatafolder root:spin   
end

function spinpara()

NewDataFolder/O root:spin:InstrumentImage
NewDataFolder/O/S root:Spin:Vartable


string/G Ep,Slit,lensmode,Faperture,Tlaperture
string/G Epv,Slitv,lensmodev,Faperturev,Tlaperturev
variable/G EpI, TlaperI, lensmodeI, FaperI, SlitI
variable/G DE0, DE1, DE2
String/G DAng
variable/G hv, Dk
make/O/N=4 TlaperAng={0.5,1,2,4}

Ep="1;2;3;5;10;20;50;100;200"
Slit="0.1;0.2;0.3;0.5;4"
lensmode="Transmission;Ang30;Ang14;Ang7"
Faperture="Full;1.6;0.8"
Tlaperture="1x0.5;2x1;3x2;4x4"
   
NewDataFolder/O/S root:spin:Loadpara
string/G SfolderList="Select New Folder;Summarize Folder;-;"
string/G Sfilpath, Sfilname, SfileList
variable/G  Sfilnum, numSfiles, nregion, nslice
Make/O/N=(20) Estart, Eend, Estep, Epass
Make/O/N=(20) Astart, Aend
string/G skind, smode0
variable/G hv_, wfct, angoffset1, angoffset2, dscale, escale
variable/G autoload=0
make/o/n=(20) data1D
make/o/n=(20,20) data2D

NewDataFolder/O/S root:spin:OriginalSpinData

String/G   OriSpinFileList=WaveList("A*",";","DIMS:2")
Variable/G NumOriSpinFile=ItemsinList(OriSpinFileList,";")
String/G   OriSpin1DFileList=WaveList("A*",";","DIMS:1")
Variable/G NumOriSpin1DFile=ItemsinList(OriSpin1DFileList,";")

NewDataFolder/O/S root:Spin:Process1D
      
               variable/G SeffV=0.17, SeffH=0.17
               make/O/N=8 DCR
               make/O Ai={1,1,1,1}
		        Variable/G EnergyStart=NumVarOrDefault("root:spin:PROCESS1D:EsnergyStart",2), EnergyEnd=NumVarOrDefault("root:spin:PROCESS1D:SEnergyEnd",2.7)
		         Variable/G NorStart=NumVarOrDefault("root:spin:PROCESS1D:NorStart",2), NorEnd=NumVarOrDefault("root:spin:PROCESS1D:NorYEnd",2)
		         Variable/G NorBKStart=NumVarOrDefault("root:spin:PROCESS1D:NorBKStart",2.8), NorBKEnd=NumVarOrDefault("root:spin:PROCESS1D:NorYEnd",3)
		         Variable/G NorFlag=NumVarOrDefault("root:spin:PROCESS1D:NorFlag",1)
		         Variable/G EFermi=NumVarOrDefault("root:spin:PROCESS1D:EFermi",2.6)
		         Variable/G ThetaAngle=NumVarOrDefault("root:spin:PROCESS1D:ThetaAngle",0.0)
                Variable/G PhiAngle=NumVarOrDefault("root:spin:PROCESS1D:PhiAngle",0.0)
                 Variable/G OmegaAngle=NumVarOrDefault("root:spin:PROCESS1D:OmegaAngle",0.0)
                Variable/G TempTemperature1D=NumVarOrDefault("root:spin:PROCESS1D:TempTemperature1D",0.0)               
                String/G   NewcurvePrefix=StrVarOrDefault("root:spin:PROCESS1D:NewCurvePrefix","")
                variable/G SpinfileID=NumVarOrDefault("root:spin:PROCESS1D:SpinfileID",1)
                variable/G NoofSpinCh=NumVarOrDefault("root:spin:PROCESS1D:NoofSpinCh",8)
                Variable/G ProcessedCurveFlag=NumVarOrDefault("root:spin:PROCESS1D:ProcessedCurveFlag",0.0)
                //String/G   SpinDetectorname=StrVarOrDefault("root:spin:PROCESS1D:SpinDetectorname","")
                variable/G SpinChannel=NumVarOrDefault("root:spin:PROCESS1D:SpinChannel",1)
                Variable/G ProCurveDisplayMode=NumVarOrDefault("root:spin:PROCESS1D:ProCurveDisplayMode",0)                        
              
                Variable/G ProcessedCurveEnergyStart=NumVarOrDefault("root:spin:PROCESS1D:ProcessedCurveEnergyStart",-1) 
                Variable/G ProcessedCurveEnergyEnd=NumVarOrDefault("root:spin:PROCESS1D:ProcessedCurveEnergyEnd",0.1)
                Variable/G PhotonEnergy=NumVarOrDefault("root:spin:PROCESS1D:PhotonEnergy",21.2)
		         Variable/G WorkFunction=NumVarOrDefault("root:spin:PROCESS1D:WorkFunction",4.3)                     
                Variable/G ThetaOffset=NumVarOrDefault("root:spin:PROCESS1D:ThetaOffset",0.0)
                Variable/G PhiOffset=NumVarOrDefault("root:spin:PROCESS1D:PhiOffset",0.0)
                Variable/G RotationAngle=NumVarOrDefault("root:spin:PROCESS1D:RotationAngle",0.0)
                 
                String/G   Processed1DFileList=WaveList("*F*P*T*I*C*",";","DIMS:1")
                String/G   Processed1DFileList, ProcessedSpinfilelist,Processed1DFilNam,ProcessedNum
                variable/G Appendto=NumVarOrDefault("root:spin:PROCESS1D:Appendto",0) 
                variable/G AppendPro=NumVarOrDefault("root:spin:PROCESS1D:AppendPro",0) 
                variable/G NorCheck=NumVarOrDefault("root:spin:PROCESS1D:NorCheck",0)  
                Variable/G BackgroundCheck=NumVarOrDefault("root:spin:PROCESS1D:GroundCheck",0)  
                Variable/G Clearfolder
                Variable/G EngAligment
                Variable/G Transformcheck
    //SetVariable AiHLR0 value= root:spin:PROCESS1D:Ai[0]
	//SetVariable AiHUD1 value= root:spin:PROCESS1D:Ai[1]
	//SetVariable AiVSN2 value= root:spin:PROCESS1D:Ai[2]
	//SetVariable AiVEW3 value= root:spin:PROCESS1D:Ai[3]
	//SetVariable DCRCH1 value= root:spin:PROCESS1D:DCR[0]
	//SetVariable DCRCh2 value= root:spin:PROCESS1D:DCR[1]
	//SetVariable DCRCh3 value= root:spin:PROCESS1D:DCR[2]
	//SetVariable DCRCh4 value= root:spin:PROCESS1D:DCR[3]
	//SetVariable DCRCh5 value= root:spin:PROCESS1D:DCR[4]
	//SetVariable DCRCh6 value= root:spin:PROCESS1D:DCR[5]
	//SetVariable DCRCh7 value= root:spin:PROCESS1D:DCR[6]
	//SetVariable DCRCh8 value= root:spin:PROCESS1D:DCR[7]
	//setvariable SeffV value= root:spin:PROCESS1D:SeffV
	//setvariable SeffH  value= root:spin:PROCESS1D:SeffH

newdatafolder/O/S root:spin:Curvetmp
               
		String/G NName
		String/G curvenam, curvefldr, curveproc, curveproc_undo, exportn
		make/o/n=10 curve0, curve, curve_undo
		//variable/G nx, ny, center, width
		//variable/G xmin, xinc, xmax, dmin0, dmax0, dmin, dmax
		
newdatafolder/O/S root:spin:ProcessedSFile
	    string/G Polawavelist
	    string/G Polafilelist
	    string/G SPinEDClist,SpinResFile
	    Variable/G PAppend
	    Variable/G SEDCAppend
	    Variable/G RSequence=NumVarOrDefault("root:spin:ProcessedSFile:RSequence",0)  
        
//setdatafolder root:spin:vartable

end

Window SpinAnalysis() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(-63,74,839,631) as "Spin Analysis"
	ShowTools/A
	SetDrawLayer UserBack
	SetDrawEnv fillfgc= (48896,49152,65280),fillbgc= (34816,34816,34816)
	DrawRRect 9,4,450,196
	SetDrawEnv fillfgc= (51456,44032,58880)
	DrawRRect 9,210,450,547
	SetDrawEnv fillfgc= (56576,56576,56576),fillbgc= (60928,60928,60928)
	DrawRRect 740,4,889,196
	SetDrawEnv fillfgc= (48896,52992,65280)
	DrawRRect 745,115,885,189
	SetDrawEnv fillfgc= (56576,56576,56576),fillbgc= (60928,60928,60928)
	DrawRRect 466,4,736,196
	SetDrawEnv fname= "Times New Roman TUR",fsize= 14
	DrawText 137,30,"Resolution of SAPRES"
	SetDrawEnv fillfgc= (65280,48896,48896)
	DrawRRect 476,39,589,165
	SetDrawEnv fname= "Times New Roman",fsize= 14
	DrawText 488,60,"SpinDetector_V"
	SetDrawEnv fillfgc= (48896,52992,65280)
	DrawRRect 612,39,725,165
	SetDrawEnv fname= "Times New Roman",fsize= 14
	DrawText 623,60,"SpinDetector_H"
	SetDrawEnv fname= "Times New Roman",fsize= 14
	DrawText 752,25,"Asymmetry Parameter"
	SetDrawEnv fillfgc= (65280,48896,48896)
	DrawRRect 745,31,885,105
	SetDrawEnv fname= "Times New Roman",fsize= 14
	DrawText 772,50,"SpinDetector_V"
	SetDrawEnv fname= "Times New Roman",fsize= 14
	DrawText 772,134,"SpinDetector_H"
	SetDrawEnv fillfgc= (56576,56576,56576)
	DrawRRect 466,210,893,547
	SetVariable DAngDisplay1,pos={372,165},size={64,18},title=" ",fSize=14
	SetVariable DAngDisplay1,value= root:Spin:Vartable:Dk
	ValDisplay DeLtaE1,pos={167,136},size={50,17},title="  ",font="Times New Roman"
	ValDisplay DeLtaE1,fSize=14,fColor=(65280,32512,16384)
	ValDisplay DeLtaE1,limits={0,0,0},barmisc={0,1000}
	ValDisplay DeLtaE1,value= #"root:spin:vartable:DE1"
	ValDisplay DeLtaE2,pos={168,165},size={50,17},title="  ",font="Times New Roman"
	ValDisplay DeLtaE2,fSize=14,fColor=(65280,32512,16384)
	ValDisplay DeLtaE2,limits={0,0,0},barmisc={0,1000}
	ValDisplay DeLtaE2,value= #"root:spin:vartable:DE2"
	PopupMenu Set_lensmode,pos={21,38},size={166,20},proc=poplensmode,title="Lens Mode"
	PopupMenu Set_lensmode,font="Times New Roman",fSize=14
	PopupMenu Set_lensmode,mode=1,popvalue="Transmission",value= #"root:spin:vartable:lensmode"
	PopupMenu Set_Ep,pos={193,38},size={89,20},proc=popEp,title="Ep(eV)"
	PopupMenu Set_Ep,font="Times New Roman",fSize=14
	PopupMenu Set_Ep,mode=9,popvalue="200",value= #"root:Spin:vartable:Ep"
	PopupMenu Set_Slit,pos={172,67},size={99,20},proc=popslit,title="Slit(mm)"
	PopupMenu Set_Slit,font="Times New Roman",fSize=14
	PopupMenu Set_Slit,mode=3,popvalue="0.3",value= #"root:Spin:vartable:slit"
	PopupMenu Set_FrontAperture,pos={20,69},size={139,20},proc=popFAperture,title="Front Aperture"
	PopupMenu Set_FrontAperture,font="Times New Roman",fSize=14
	PopupMenu Set_FrontAperture,mode=1,popvalue="Full",value= #"root:Spin:vartable:Faperture"
	ValDisplay DeLtaE,pos={221,105},size={60,17},title="  ",font="Times New Roman"
	ValDisplay DeLtaE,fSize=14,fColor=(65280,32512,16384)
	ValDisplay DeLtaE,limits={0,0,0},barmisc={0,1000}
	ValDisplay DeLtaE,value= #"root:spin:vartable:DE0"
	PopupMenu TlAperture,pos={312,37},size={137,20},proc=popTLAperture,title="TL Aperature"
	PopupMenu TlAperture,font="Times New Roman",fSize=14
	PopupMenu TlAperture,mode=1,popvalue="1x0.5",value= #"root:Spin:vartable:Tlaperture"
	Button GetDeltaE,pos={16,101},size={200,25},proc=DeltaE,title="\\F'Symbol'DE0\\F'Times New Roman' (meV) = sqrt(\\F'Symbol'DE1\\S2\\M+\\F'Symbol'DE2\\S2\\M)"
	Button GetDeltaE,font="Times New Roman",fSize=14,fStyle=0
	Button GetDeltaAng,pos={299,130},size={70,25},proc=DeltaAng,title="\\F'Symbol'Dq\\F'Times New Roman' (deg)"
	Button GetDeltaAng,font="Times New Roman",fSize=14
	SetVariable SeffV,pos={482,171},size={100,20},title="  Seff_V"
	SetVariable SeffV,labelBack=(65280,48896,48896),font="Times New Roman",fSize=14
	SetVariable SeffV,value= root:Spin:Process1D:SeffV
	SetVariable AiHLR0,pos={757,140},size={120,20},title="AiLR(IR/IL) "
	SetVariable AiHLR0,font="Times New Roman",fSize=14
	SetVariable AiHLR0,value= root:Spin:Process1D:Ai[0]
	SetVariable AiHUD1,pos={757,165},size={120,20},title="AiUD(ID/IU) "
	SetVariable AiHUD1,font="Times New Roman",fSize=14
	SetVariable AiHUD1,value= root:Spin:Process1D:Ai[1]
	SetVariable AiVSN2,pos={757,56},size={120,20},title="AiSN(IN/IS) "
	SetVariable AiVSN2,font="Times New Roman",fSize=14
	SetVariable AiVSN2,value= root:Spin:Process1D:Ai[2]
	SetVariable AiVEW3,pos={757,80},size={120,20},title="AiEW(IW/IS) "
	SetVariable AiVEW3,font="Times New Roman",fSize=14
	SetVariable AiVEW3,value= root:Spin:Process1D:Ai[3]
	SetVariable DCRCH1,pos={489,67},size={90,20},title="CH1(E)"
	SetVariable DCRCH1,font="Times New Roman",fSize=14
	SetVariable DCRCH1,value= root:Spin:Process1D:DCR[0]
	SetVariable DCRCh2,pos={488,92},size={90,20},title="CH2(S)"
	SetVariable DCRCh2,font="Times New Roman",fSize=14
	SetVariable DCRCh2,value= root:Spin:Process1D:DCR[1]
	SetVariable DCRCh3,pos={488,117},size={90,20},title="CH3(W)"
	SetVariable DCRCh3,font="Times New Roman",fSize=14
	SetVariable DCRCh3,value= root:Spin:Process1D:DCR[2]
	SetVariable DCRCh4,pos={488,142},size={90,20},title="CH4(N)"
	SetVariable DCRCh4,font="Times New Roman",fSize=14
	SetVariable DCRCh4,value= root:Spin:Process1D:DCR[3]
	SetVariable DCRCh5,pos={625,67},size={90,20},title="CH5(L)"
	SetVariable DCRCh5,font="Times New Roman",fSize=14
	SetVariable DCRCh5,value= root:Spin:Process1D:DCR[4]
	SetVariable DCRCh6,pos={625,92},size={90,20},title="CH6(U)"
	SetVariable DCRCh6,font="Times New Roman",fSize=14
	SetVariable DCRCh6,value= root:Spin:Process1D:DCR[5]
	SetVariable DCRCh7,pos={625,114},size={90,20},title="CH7(R)"
	SetVariable DCRCh7,font="Times New Roman",fSize=14
	SetVariable DCRCh7,value= root:Spin:Process1D:DCR[6]
	SetVariable DCRCh8,pos={625,139},size={90,20},title="CH8(D)"
	SetVariable DCRCh8,font="Times New Roman",fSize=14
	SetVariable DCRCh8,value= root:Spin:Process1D:DCR[7]
	SetVariable SeffH,pos={621,171},size={100,20},title="  Seff_H"
	SetVariable SeffH,labelBack=(48896,52992,65280),font="Times New Roman",fSize=14
	SetVariable SeffH,value= root:Spin:Process1D:SeffH
	Button ProcessSpin,pos={20,332},size={120,25},proc=XJZ1DProcess,title="Process Spin Data"
	Button ProcessSpin,font="Times New Roman",fSize=14
	SetVariable EnergyStartSpin,pos={25,367},size={120,20},title="EnergyStart"
	SetVariable EnergyStartSpin,font="Times New Roman",fSize=14
	SetVariable EnergyStartSpin,limits={-inf,inf,0.1},value= root:Spin:Process1D:EnergyStart
	SetVariable EnergyEndSpin,pos={161,367},size={90,20},title="End"
	SetVariable EnergyEndSpin,font="Times New Roman",fSize=14
	SetVariable EnergyEndSpin,limits={-inf,inf,0.1},value= root:Spin:Process1D:EnergyEnd
	SetVariable set_EF,pos={296,367},size={80,20},title="E_F",font="Times New Roman"
	SetVariable set_EF,fSize=14
	SetVariable set_EF,limits={-inf,inf,0.001},value= root:Spin:Process1D:EFermi
	SetVariable curveprefix,pos={296,397},size={100,20},title="Curve Prefix"
	SetVariable curveprefix,font="Times New Roman",fSize=14
	SetVariable curveprefix,value= root:Spin:Process1D:NewcurvePrefix
	SetVariable set_ProcessSEDCFlag,pos={25,397},size={120,20},title="ProcessFlag"
	SetVariable set_ProcessSEDCFlag,font="Times New Roman",fSize=14
	SetVariable set_ProcessSEDCFlag,limits={0,10,1},value= root:Spin:Process1D:ProcessedCurveFlag
	Button Set1DParameterButton,pos={161,270},size={120,25},proc=SetParameterSpin,title="Set 1D File TABLE"
	Button Set1DParameterButton,font="Times New Roman",fSize=14
	ValDisplay val_TotalNumOriginal1DFiles,pos={25,305},size={103,17},title="Num of Files"
	ValDisplay val_TotalNumOriginal1DFiles,font="Times New Roman",fSize=14
	ValDisplay val_TotalNumOriginal1DFiles,limits={0,0,0},barmisc={0,1000}
	ValDisplay val_TotalNumOriginal1DFiles,value= #"root:Spin:OriginalSpinData:NumOriSpin1DFile"
	PopupMenu Original1DFile_file,pos={161,305},size={187,20},proc=SelectOriginalSpinFile,title="Show 1D"
	PopupMenu Original1DFile_file,font="Times New Roman",fSize=14
	PopupMenu Original1DFile_file,mode=1,popvalue="A20111029114031H6",value= #"root:Spin:OriginalSpinData:OriSpin1DFileList\t\t"
	SetVariable Set_SpinFileID,pos={161,397},size={90,20},title="FileID"
	SetVariable Set_SpinFileID,font="Times New Roman",fSize=14
	SetVariable Set_SpinFileID,limits={0,10,1},value= _NUM:2
	CheckBox Appendto1D,pos={383,307},size={58,15},title="Append"
	CheckBox Appendto1D,font="Times New Roman"
	CheckBox Appendto1D,variable= root:Spin:Process1D:Appendto
	SetVariable Set_NormStart,pos={25,427},size={110,20},title="Normstart"
	SetVariable Set_NormStart,font="Times New Roman",fSize=14
	SetVariable Set_NormStart,value= root:Spin:Process1D:NorStart
	SetVariable Set_Normend,pos={161,427},size={72,20},title="End"
	SetVariable Set_Normend,font="Times New Roman",fSize=14
	SetVariable Set_Normend,value= root:Spin:Process1D:NorEnd
	SetVariable NormBK_Start,pos={25,457},size={140,20},title="NormBK_start"
	SetVariable NormBK_Start,font="Times New Roman",fSize=14
	SetVariable NormBK_Start,value= root:Spin:Process1D:NorBKStart
	SetVariable NormBKend,pos={191,457},size={119,20},font="Times New Roman"
	SetVariable NormBKend,fSize=14,value= root:Spin:Process1D:NorBKEnd
	CheckBox Normcheck,pos={296,429},size={82,15},title="Normlization"
	CheckBox Normcheck,font="Times New Roman",variable= root:Spin:Process1D:NorCheck
	Button GetPolarization_D,pos={483,218},size={135,25},proc=GetPola_D,title="Get Polarization_D"
	Button GetPolarization_D,font="Times New Roman",fSize=14
	PopupMenu Polawavelist,pos={480,283},size={269,20},proc=SelectSpinFile,title="Polarization(Mode2) "
	PopupMenu Polawavelist,font="Times New Roman",fSize=14
	PopupMenu Polawavelist,mode=6,popvalue="F3t0O0PP600PT0PI5PDz",value= #"root:spin:ProcessedSfile:Polawavelist\t"
	PopupMenu SEDClist,pos={480,343},size={285,20},proc=SelectSpinFile,title="SpinEDC(mode2)    "
	PopupMenu SEDClist,font="Times New Roman",fSize=14
	PopupMenu SEDClist,mode=10,popvalue="F3t0O0PP600PT0PI5IyDown",value= #"root:spin:ProcessedSfile:SpinEDClist"
	CheckBox AppendtoPola,pos={790,285},size={58,15},title="Append"
	CheckBox AppendtoPola,font="Times New Roman"
	CheckBox AppendtoPola,variable= root:Spin:ProcessedSFile:PAppend
	CheckBox Appendto1D2,pos={790,345},size={58,15},title="Append"
	CheckBox Appendto1D2,font="Times New Roman"
	CheckBox Appendto1D2,variable= root:Spin:ProcessedSFile:SEDCAppend
	CheckBox BackGroundCheck,pos={475,13},size={119,16},title="Dark Counts Rate"
	CheckBox BackGroundCheck,font="Times New Roman",fSize=14
	CheckBox BackGroundCheck,variable= root:Spin:Process1D:BackgroundCheck
	PopupMenu Processed1DFile,pos={25,487},size={258,20},proc=SelectProcessedFile,title="Processed1DFile"
	PopupMenu Processed1DFile,font="Times New Roman",fSize=14
	PopupMenu Processed1DFile,mode=20,popvalue="F2t15O0PP20PT10PI4S8C4",value= #"root:spin:Process1D:Processed1DFileList\t"
	CheckBox Appendto1D1,pos={296,489},size={61,16},title="Append"
	CheckBox Appendto1D1,font="Times New Roman",fSize=14
	CheckBox Appendto1D1,variable= root:Spin:Process1D:AppendPro
	CheckBox clearPro,pos={161,337},size={87,16},title="Clear Folder"
	CheckBox clearPro,font="Times New Roman",fSize=14
	CheckBox clearPro,variable= root:Spin:Process1D:Clearfolder
	SetVariable EAligment,pos={296,334},size={132,20},title="Energy Aligment"
	SetVariable EAligment,font="Times New Roman",fSize=14
	SetVariable EAligment,limits={-inf,inf,0.1},value= root:Spin:Process1D:EngAligment
	Button LoadSpinFiles,pos={25,270},size={107,25},proc=LoadAllSpinFiles,title="Load Spin Files"
	Button LoadSpinFiles,font="Times New Roman",fSize=14
	PopupMenu popFolder,pos={25,218},size={115,20},bodyWidth=115,proc=SelectFolderSpin,title="SetDataFolder"
	PopupMenu popFolder,font="Times New Roman",fSize=14,fStyle=1
	PopupMenu popFolder,mode=0,value= #"root:Spin:Loadpara:SfolderList"
	SetVariable setlib,pos={161,218},size={190,20},title=" ",font="Times New Roman"
	SetVariable setlib,fSize=14,value= root:Spin:Loadpara:Sfilpath
	PopupMenu popup_file,pos={161,243},size={194,20},proc=DisplayAllSpinFile,title="Spin Files"
	PopupMenu popup_file,font="Times New Roman",fSize=14
	PopupMenu popup_file,mode=1,popvalue="20181109000003.pxt",value= #"root:Spin:Loadpara:SfileList\t\t"
	Button GetDeltaE1,pos={15,132},size={145,25},proc=DeltaE,title="\\F'Symbol'DE1\\F'Times New Roman' (Slit&Ep) (meV)"
	Button GetDeltaE1,font="Times New Roman",fSize=14
	Button GetDeltaE2,pos={15,161},size={145,25},proc=DeltaE,title="\\F'Symbol'DE2\\F'Times New Roman' (Ep&Aper)(meV)"
	Button GetDeltaE2,font="Times New Roman",fSize=14
	SetVariable DAngDisplay,pos={372,135},size={50,18},title=" ",fSize=14
	SetVariable DAngDisplay,value= root:Spin:Vartable:DAng
	SetVariable PhotonEnergy,pos={337,68},size={110,18},title="\\Z14hv(eV)",fSize=14
	SetVariable PhotonEnergy,value= root:Spin:Vartable:hv
	Button TLApertureImage,pos={286,35},size={104,23},proc=TLAperSketch,title="\\W660TLAperture"
	Button TLApertureImage,font="Times New Roman",fSize=14
	Button GetDeltaAng1,pos={297,159},size={70,27},proc=DeltaK,title="\\F'Symbol'D\\F'Times New Roman'k\\M ( 1/A\\M)"
	Button GetDeltaAng1,font="Times New Roman",fSize=14
	Button TLApertureImage1,pos={609,9},size={120,25},proc=SpinGeometry,title="\\W660 SpinGeometry"
	Button TLApertureImage1,font="Times New Roman",fSize=14
	PopupMenu ProcessedSpinFile,pos={25,517},size={240,20},proc=DisplayProcessedSpinFile,title="Processed SpinFile"
	PopupMenu ProcessedSpinFile,font="Times New Roman",fSize=14
	PopupMenu ProcessedSpinFile,mode=1,popvalue="F1t0O0PP0PT0PI1S8",value= #"root:spin:Process1D:ProcessedSpinFileList\t"
	CheckBox Transform,pos={634,223},size={165,16},title="Coordinate Tranformation"
	CheckBox Transform,font="Times New Roman",fSize=14,value= 0
	PopupMenu PolarizationFile,pos={480,253},size={235,20},proc=DisplayPolarizedFile,title="Polarization(Mode1)"
	PopupMenu PolarizationFile,font="Times New Roman",fSize=14
	PopupMenu PolarizationFile,mode=1,popvalue="F1t0O0PP0PT0PI1",value= #"root:spin:processedsfile:polafilelist"
	PopupMenu SpinResolvedEDC,pos={480,313},size={234,20},proc=DisplaySpinEDCFile,title="SpinEDC(Mode1)   "
	PopupMenu SpinResolvedEDC,font="Times New Roman",fSize=14
	PopupMenu SpinResolvedEDC,mode=1,popvalue="F1t0O0PP0PT0PI1",value= #"root:spin:ProcessedSFile:spinresFile"
EndMacro
```````````
Proc popEp(ctrlName,popNum,popStr) : PopupMenuControl
	string ctrlName,popstr
	variable popNum
	setdatafolder root:spin:vartable
    //string/G Epv
    //variable/G EpI
			Epv=popstr
			EpI=popNum
    setdatafolder root:spin
	
End

Proc popslit(ctrlName,popNum,popStr) : PopupMenuControl			 
	string ctrlName,popstr
	variable popNum
	setdatafolder root:spin:vartable
	slitv=popstr
	setdatafolder root:spin
End

Proc poplensmode(ctrlName,popNum,popStr) : PopupMenuControl
	string ctrlName, popStr
	variable popnum
	setdatafolder root:spin:vartable
    //string/G lensmodev, Tlaperture
    //Variable/G LensmodeI
	
			lensmodev=popstr
			LensmodeI=popNum
			
    setdatafolder root:spin
End

proc popFAperture(ctrlName,popNum,popStr) : PopupMenuControl
	string ctrlname, popstr
	variable popnum
	setdatafolder root:spin:vartable
    //String/G FAperturev
    //Variable/G FAperI
	
			
			Faperturev=popstr
			FaperI=popNum
	setdatafolder root:spin		
End

Proc popTLAperture(ctrlName,popNum,popStr) : PopupMenuControl
	string ctrlName,popstr
	variable popnum
    //String/G tlaperturev
    //variable/G TlaperI
    setdatafolder root:spin:vartable
			Tlaperturev=popstr
			TlaperI=popNum
	setdatafolder root:spin		
End

Proc TLAperSketch(ctrlName) : ButtonControl
	string ctrlName
	string DAvalue
	variable DeltaAng, Angmode
	setdatafolder root:spin:InstrumentImage
	ImageLoad/O/T=bmp "C:Program Files:WaveMetrics:Igor Pro Folder:User Procedures:Xingjiang_IOP:Photos:Arperture.bmp" 
    NewImage  root:spin:InstrumentImage:'Arperture.bmp'
End

Proc SpinGeometry(ctrlName) : ButtonControl
	string ctrlName
	string DAvalue
	variable DeltaAng, Angmode
	setdatafolder root:spin:InstrumentImage
	ImageLoad/O/T=bmp "C:Program Files:WaveMetrics:Igor Pro Folder:User Procedures:Xingjiang_IOP:Photos:SpinGeometry.bmp" 
    NewImage  root:spin:InstrumentImage:'SpinGeometry.bmp'
End


Proc DeltaE(ctrlName) : ButtonControl
	String ctrlName
	
	setdatafolder root:spin:vartable
    //string/G Epv, slitv, Tlaperturev 
    string DEvalue
    //variable/G EpI, TlaperI
    
    DE1=(str2num(slitV)*str2num(EpV))/(0.1*1)*0.25
    DE2=(str2num(EpV)*TlaperI)*2.5
    DE0=round(sqrt(DE1^2+DE2^2)*100)/100
    //Devalue=num2str(De)
	//ValDisplay DeltaE,value= #Devalue
   setdatafolder root:spin
   
End

Proc DeltaAng(ctrlName) : ButtonControl
	string ctrlName
	string DAvalue
	variable DeltaAng, Angmode
	setdatafolder root:spin:vartable
	   		if  (cmpstr(lensmodev,"Transmission")==0)
			   if(cmpstr(Faperturev,"Full")==0)
			      DAng="30"
			   Else
			      DAng="+ -" + num2str(str2num(Faperturev)/1.6)
			   Endif
			else 
		       Angmode=str2num(lensmodev[3,strlen(lensmodev)-1])
		       DeltaAng=round(Angmode/7)*TlaperAng[TlaperI-1]*0.375
			   DAng=num2str(DeltaAng)
			endif
			   
			//ValDisplay DeltaAng,value= #DAvalue
			
    setdatafolder root:spin
    
End

Proc DeltaK(ctrlName) : ButtonControl
	string ctrlName
	variable theta
	setdatafolder root:spin:vartable
	if (cmpstr(DAng[0],"+")==0) 
	    if(str2num(DAng[3,strlen(DAng)-1])==30)
	       theta=str2num(DAng[3,strlen(DAng)-1]) 
	    else
	       theta=2*str2num(DAng[3,strlen(DAng)-1]) 
	    Endif
	else
	    theta=str2num(DAng)
	endif
	Dk=round(10000*0.512*sqrt(hv-4.1)*theta/180*3.14159)/10000 		
	
    setdatafolder root:spin
    
End


Proc  XJZ1DProcess(ctrlName) : ButtonControl
//Modified by Shaolong 9Dec.2010
	 String ctrlName
	 pauseupdate;silent 1
     root:spin:OriginalspinData:Processed1Dfiles="N/A"
     pauseupdate;silent 1
 	 XJZNewCurve()
 	 string curr=getdatafolder(1)
 	 setdatafolder root:spin:process1D
 	 ProcessedSpinFilelist=Getspinfilelist("root:spin:process1D") 
 	 Processed1Dfilelist=wavelist("*O*P*T*I*S*C*",";","DIMS:1")       
 	 setdatafolder $curr 
End

Proc XJZNewCurve() 
//modified by shaolong 10Dec.2010
pauseupdate;silent 1
if(root:spin:Process1D:clearfolder==1)
   KillProcessedCurves()
else
endif

pauseupdate;silent 1
String Curr=GetDataFolder(1)

	string img
          SetDataFolder root:Spin:OriginalSpinData
          
	      Variable limitnum=Dimsize(Process1DFlag,0)//number of 1D files
          Variable i=0
    	      Do        
   	       
   	          img=OriSpin1DFile[i]//file name from the 1D filelist
    	          Duplicate/o $img  root:spin:curvetmp:curve
		
              root:spin:PROCESS1D:ThetaAngle= root:Spin:OriginalSpinData:Theta_Angle1D[i]
              root:spin:PROCESS1D:PhiAngle=root:Spin:OriginalSpinData:Phi_Angle1D[i]
              root:spin:PROCESS1D:OmegaAngle=root:Spin:OriginalSpinData:Omega_Angle1D[i]            
             
              If (root:spin:OriginalspinData:Process1DFlag[i]==root:spin:PROCESS1D:ProcessedCurveFlag)
             
              root:spin:PROCESS1D:TempTemperature1D=root:Spin:OriginalSpinData:Temperature1D[i]

              root:spin:PROCESS1D:SpinFileID=root:Spin:OriginalSpinData:SpinFile_ID[i]
              //root:spin:PROCESS1D:SpinDetectorname=root:OriginalData:SpinDector_Name[i]
              //root:spin:PROCESS1D:SpinChannel=root:Spin:OriginalSpinData:Spin_Channel[i]
              root:spin:PROCESS1D:SpinChannel=str2num(img[strlen(img)-1,strlen(img)])//get the channel number from the filename
              root:spin:PROCESS1D:NoofSpinCh=root:Spin:OriginalSpinData:SpinCh_total[i]
             
              NormSpin(root:spin:loadpara:sfilpath,img,root:spin:Process1D:NoofspinCh,root:spin:Process1D:SpinChannel)
              
              Processed1Dfiles[i]=root:spin:curvetmp:NName
              endif
              
    	      i=i+1
   	While (i<limitnum)
   	        
	SetDataFolder Curr
	End

Proc KillProcessedCurves()
//Modified by Shaolong 10Dec.2010
		String curr1=GetDataFolder(1)
		
         SetDataFolder root:spin:Process1D
         String ProcessedCurve, ProcessedSfile
         String ProcessCurveFileList= WaveList("*F*P*T*",";","DIMS:1")+";"+wavelist("P*",";","DIMS:1")+";"+Wavelist("I*",";","DIMS:1")
         variable ProcessedCurvelimit=ItemsInList( ProcessCurveFileList, ";")

	     Variable iProcessedCurve=0
	     Do
	     ProcessedCurve=StringFromList(iProcessedCurve,ProcessCurveFilelist,";")
	     KillWaves/Z  $ProcessedCurve
	     iProcessedCurve+=1
	     While(iProcessedCurve<ProcessedCurvelimit)
	     Processed1DFileList=WaveList("*F*P*T*C*",";","DIMS:1")
	     
	     setdatafolder root:spin:ProcessedSFile
	     
	     string ProcessedSFilelist=wavelist("*x*",";","DIMS:1")+";"+wavelist("*y*",";","DIMS:1")+";"+wavelist("*z*",";","DIMS:1")
         Variable iProcessedSFile=0
         variable ProcessedSFilelim=ItemsInlist(ProcessedSFilelist)
	     Do
	     ProcessedSFile=StringFromList(iProcessedSFile,ProcessedSFilelist,";")
	     KillWaves/Z  $ProcessedSFile
	     iProcessedSFile+=1
	     While(iProcessedSFile<ProcessedSFilelim)
         Polawavelist=wavelist("*F*T*P*I*PD*",";","DIMS:1")+";"+wavelist("*F*T*P*I*Px",";","DIMS:1")+";"+wavelist("*F*T*P*I*Py",";","DIMS:1")+";"+wavelist("*F*T*P*I*Pz",";","DIMS:1")
         SpinEDClist=wavelist("*F*T*P*I*I*",";","DIMS:1")  
         
         SetDataFolder curr1
End

Proc  killorigina1Dfiles()
		  String curr1=GetDataFolder(1)
		
         SetDataFolder root:Spin:OriginalSpinData
         String Orig1Dfile
         String OriSpin1DFileList= WaveList("A*",";","DIMS:1")
         variable OriSpin1Dfilelimit=ItemsInList(OriSpin1DFileList, ";")

	     Variable iOrig1Dfile=0
	     Do
	     Orig1Dfile=StringFromList(iOrig1Dfile,OriSpin1DFileList,";")
	     KillWaves/Z  $Orig1Dfile
	     iOrig1Dfile+=1
	     While(iOrig1Dfile<OriSpin1Dfilelimit)
	     OriSpin1DFileList=WaveList("A*",";","DIMS:1")
	     OriSpinfilelist=wavelist("A*",";","")
         SetDataFolder $curr1
End

Proc  KillAllwaves(curr)
         string curr
		  String curr1=GetDataFolder(1)
		
         SetDataFolder $curr
         String Filename
         String FileList= WaveList("A*",";","")
         variable Filenum=ItemsInList(Filelist, ";")

	     Variable ifile=0
	     Do
	     filename=StringFromList(ifile,FileList,";")
	     KillWaves/Z  $filename
	     ifile+=1
	     While(ifile<filenum)
	     OriSpin1DFileList=WaveList("A*",";","DIMS:1")
         SetDataFolder curr1
End


Proc SelectFolderSpin(ctrlName,popNum,popStr) : PopupMenuControl
//-------------------
	String ctrlName
	Variable popNum
	String popStr
	
	SetDataFolder root:Spin:Loadpara
	if (popNum==2)						//print "Summarize Folder"
		SummarizeSESfolder(Sfilpath)
	else
		if (popNum==1)						//print "Select Folder"
			NewPath/O/Q/M="Select Spin Data Library" Spindata				//dialog selection
			string/G Sfilpath
			Pathinfo Spindata
			Sfilpath=S_path
			SfolderList=SfolderList+Sfilpath+";"
		endif
		if (popNum>3)							//print "Select Existing Folder"
			Sfilpath=StringFromList(popNum-1,SfolderList)
			//print popNum, filpath
			NewPath/O/Q Spindata Sfilpath
		endif
		SfileList=IndexedFile( Spindata, -1, ".pxt")	
		//filelist=ReduceList( fullfilelist, "*.pxt" )
		numSfiles=ItemsInList(SfileList, ";")
	endif
	SetDataFolder root:
End

Proc LoadAllSpinFiles(ctrlName) : ButtonControl
	String ctrlName
	
pauseupdate;silent 1
UpdateFolderSpin()
pauseupdate;silent 1
String Curr=GetDataFolder(1)

KillAllwaves("root:spin:OriginalSpinData")

Variable i=0
Variable plotopt=-1							//negative means ReadHERSB skips open dialog and uses current filename
Variable Comma  
String NewName  
String ImageFileList 
String HersImageFile 
Variable limit
Variable jFind
Variable compare, check

    DO
	root:spin:Loadpara:sfilnum=i
	root:spin:Loadpara:sfilname=StringFromList( root:spin:Loadpara:sfilnum, root:spin:Loadpara:sfileList, ";")
	Comma=strsearch(root:spin:Loadpara:sfilname,".",0)
	if (Comma<0)					                   //no period found
		Comma=strlen(root:Spin:Loadpara:sfilname)
		NewName="A"+root:Spin:Loadpara:sfilname
	else
		NewName="A"+root:Spin:Loadpara:sfilname[0, Comma-1]
	endif
//	Print NewName
	
	    SetDataFolder root:Spin:OriginalSpinData
        ImagefileList= WaveList("A*",";","")	                 //Loaded files	
//      ImagefileList= WaveList("A*",";","DIMS:2")	                 //Loaded Images
        limit=ItemsInList( ImagefileList, ";")    		
//     Print ImagefileList
//     Print limit
 
//Check whether the file is loaded or not
        jFind=0
        Check=0 
        Do
        HersImageFile=StringFromList(jFind,ImagefileList,";")
//        Print HersImageFile, NewName
        Compare=cmpstr(HersImageFile,NewName)
        if   (Compare==0)
        Check=1
        Else
        Endif
        jFind+=1
        While (jFind<limit)   
          
      If (Check==1)
      root:Spin:OriginalSpinData:OriSpinFileList=WaveList("A*",";","DIMS:2")
      root:Spin:OriginalSpinData:NumOriSpinFile=ItemsinList(OriSpinFileList,";")
      root:Spin:OriginalSpinData:OriSpin1DFileList=WaveList("A*",";","DIMS:1")      
      root:Spin:OriginalSpinData:NumOriSpin1DFile=ItemsinList(OriSpin1DFileList,";")      
      Else
      root:Spin:OriginalSpinData:OriSpinFileList=WaveList("A*",";","DIMS:2")
      root:Spin:OriginalSpinData:NumOriSpinFile=ItemsinList(OriSpinFileList,";")
      root:Spin:OriginalSpinData:OriSpin1DFileList=WaveList("A*",";","DIMS:1")      
      root:Spin:OriginalSpinData:NumOriSpin1DFile=ItemsinList(OriSpin1DFileList,";")  

      PopupMenu popup_file mode=root:Spin:Loadpara:sfilnum
      ReadSESSpinhdr(root:Spin:Loadpara:sfilpath, root:Spin:Loadpara:sfilname)
      
 //     XJZ2LoadSESb(root:SES:dscale, root:SES:escale, root:SES:hv_, root:SES:wfct, root:SES:angoffset1, root:SES:angoffset2, 1, 1, plotopt) //load sesdata   
    
      LoadSESSpin(root:spin:loadpara:dscale, root:spin:loadpara:escale, root:spin:loadpara:hv_, root:spin:loadpara:wfct, root:spin:loadpara:angoffset1, root:spin:loadpara:angoffset2, 1, 1, plotopt)
          
      Endif
    
       i=i+1
       
       While (i<root:spin:loadpara:numsfiles)
       
      SetDataFolder root:Spin:OriginalSpinData      
      root:Spin:OriginalSpinData:OriSpinFileList=WaveList("A*",";","DIMS:2")
      root:Spin:OriginalSpinData:NumOriSpinFile=ItemsinList(OriSpinFileList,";")
      root:Spin:OriginalSpinData:OriSpin1DFileList=WaveList("A*",";","DIMS:1")      
      root:Spin:OriginalSpinData:NumOriSpin1DFile=ItemsinList(OriSpin1DFileList,";")           
   
      SetParameterSpin("" )
     
      SetDataFolder Curr
       
      End
 
Proc UpdateFolderSpin()
	pauseupdate;silent 1
//-----------------------
	String Curr=GetDataFolder(1)
	SetDataFolder root:Spin:Loadpara
	
	SfileList=IndexedFile( Spindata, -1, ".pxt")	
	//filelist=ReduceList( fullfilelist, "*.pxt" )
	numsfiles=ItemsInList( SfileList, ";")
	PopupMenu popup_file value=root:Spin:Loadpara:SfileList		//#"root:SES:fileList"
	
	//StepFileSES("StepPlus") 		// increment file selection to next (N+1)
	
	SetDataFolder Curr
End

Function/T ReadSpinfile(idialog)
//=================
// read SES binary file
// determines the number cycles (angle, space) and number of regions (per cycle)
// saves values in root:SES folder variables
	variable idialog
	variable debug=0			// programming flag
	//Variable file
	
	SVAR Sfilpath=root:Spin:Loadpara:sfilpath, sfilname=root:Spin:Loadpara:sfilname
	
	NewDataFolder/O/S root:Spin:Load
	KillWaves/A/Z						// purge before loading new
	//variable numLoadw=CountObjects("root:SES:Load", 1)
	//string wvlst=GetIndexedObjName("root:SES:Load",1 ,0 )
	
	NewDataFolder/O/S root:Spin:Load:Tmp
	KillWaves/A/Z
	
	NewDataFolder/O/S root:Spin:Load:Tmporder
	KillWaves/A/Z
	
	SetdataFolder root:spin:load
	
	string Sfile_path=Sfilpath
	if (idialog>0)
		variable file
		Open/D/R/T="????"  file			//open file dialog only
		Sfilname=S_filename
		//print S_filename
		
		// extract filpath from full file name
		// and return short filename for wave renaming
		string delim=":"                 //"\:"[cmpstr(IgorInfo(2), "Macintosh")==0]
		variable nch=strlen(Sfilname), jj
		jj=nch-1
		DO 
			if (cmpstr( Sfilname[jj], delim)==0)
				break
			endif
			jj-=1
		WHILE( jj>0)
		Sfile_path=Sfilname[0, jj]
		Sfilname=Sfilname[jj+1, nch-1]
		//print filpath, "// ", filnam
	endif
	
	LoadData/O/Q Sfile_path+Sfilname
	
	SetDataFolder root:
	return Sfilname
End

Proc LoadSESSpin( cts,  escal, hv, wf, angoff1, angoff2,  namtyp, namnum, plotopt)
//------------------------
//modified by shaolong 8Dec. 2010
	variable plotopt, cts=NumVarOrDefault("root:Spin:loadpara:dscale",1)
	variable angoff1=NumVarOrDefault("root:Spin:loadpara:angoffset1",NaN), angoff2=NumVarOrDefault("root:Spin:loadpara:angoffset2",NaN)
	variable hv=NumVarOrDefault("root:Spin:loadpara:hv_",NaN), wf=NumVarOrDefault("root:Spin:loadpara:wfct",0)
	variable namtyp=NumVarOrDefault("root:Spin:loadpara:nametyp",1), namnum=NumVarOrDefault("root:Spin:loadpara:namenum",1)
	variable escal=NumVarOrDefault("root:Spin:loadpara:escale",1)
		prompt cts, "Intensity option", popup "Counts;Cts/Sec;Cts/Flux;Flux only"
		prompt plotopt, "Spectrum plot option", popup "Display;Append"
		prompt angoff1, "Sample Angle(NaN for no offset):"
		prompt angoff2, "Detector Angle Offset (NaN for no offset):"
		prompt hv, "Photon Energy (eV) [NaN=leave as KE scale]"
		prompt wf, "Work Function (eV) [4.1, SES, 4/97]:"
		prompt namtyp, "Wave Naming (derived from filename):", popup "Prefix only;Remove . ;Convert . to _;Extension only"
		prompt namnum, "Number of prefix characters", popup "all;2;3;4;5;6;7;8"
		prompt escal, "Energy Scale interpretion", popup "KE;BE"

	variable dum=1
	
	silent 1; pauseupdate
	String curr= GetDataFolder(1)
//	NewDataFolder/O/S root:SES  //shaolong 20110215
	Variable/G angoffset1=angoff1, angoffset2=angoff2, hv_=hv, wfct=wf, nametyp=namtyp, namenum=namnum, dscale=cts, escale=escal
	SetDataFolder curr
	
//	string xlbl="Kinetic Energy (eV)", ylbl="Intensity (arb)"

//Load from binary files
    root:Spin:loadpara:skind[0]="A"
	string base=ReadSpinfile(1-(plotopt<0))
	if (strlen(base)==0)
	abort 
	endif
	base=ExtractNameSpin( base, namtyp, namnum )   // need to put in loop for multiple regions
	base=root:Spin:Loadpara:skind[0]+base
//	print "base=", base
	//Duplicate/O root:SES:infowav $(base+"_info")

//	variable doimage=(disp==1)+(disp==2), dospectra=(disp==2)
	string  dwn, xwn, ywn=base+"_y"
	//duplicate/o root:SES:ANGLE $ywn
	
	

	string titlestr, wlst, winnam, xlbl, ylbl
	variable nx, ny=root:Spin:Loadpara:nslice, nregion=root:Spin:Loadpara:nregion
	string eunit, yunit
	variable ireg=0, eoff, yoff
	variable nx0,ny0,nz,mode
	DO
		nx=root:Spin:Loadpara:enpts[ireg]
		if (nregion==1)
			dwn=base
		else
			dwn=base+num2str(ireg)
		endif
		

		//if (cts<4)
			variable nfiles
			curr=GetDataFolder(1)
			SetDataFolder root:Spin:Load
			string spinwavelist,spinimagelist,spinimagename
			variable flag=0
			spinwavelist=wavelist("*",";","DIMS:1")
			spinimagelist=wavelist("*",";","DIMS:2")
			nfiles=itemsinlist(spinwavelist)
			SetDataFolder $curr
			spinimagename=spinimagelist[0,strlen(spinimagelist)-2]
           if (cmpstr(spinimagelist,"")==1)
               Duplicate/o root:Spin:Load:$(spinimagename) root:Spin:OriginalSpinData:$dwn
               flag=1
           else
               flag=0
           endif 

		string spinwavename, SpinDatach,spinchname,loadwv, Orderedloadwv
		variable i=0
		Do
		spinwavename=stringfromlist(i,spinwavelist)
		SpinDatach=spinwavename[strlen(spinwavename)-2, strlen(spinwavename)]
		Spinchname=spinchannelname(SpinDatach)
		
		//		duplicate/o $("root:SES:Load:"+loadwv) $("root:"+dwn)
		loadwv=GetIndexedObjName("root:Spin:Load",1 ,i+flag )
		Duplicate/o root:Spin:Load:$loadwv $("root:Spin:load:tmp:"+dwn+spinchname)
		i+=1
		while(i<nfiles)
		
	    string arrangedfolder=ArrangeinOder("root:spin:load")  //arrange the spinfile in the channel's order 
		
		setdatafolder $arrangedfolder
		string Orderedwavelist=wavelist("*",";","DIMS:1")
	    variable Norderedfiles=itemsinlist(Orderedwavelist)
		string Orderedwavename
		variable ii=0
		Do
		Orderedwavename=stringfromlist(ii,Orderedwavelist)
		
		Orderedloadwv=GetIndexedObjName("root:Spin:Load:Tmporder",1 ,ii )
		Duplicate/o root:Spin:Load:tmporder:$(Orderedloadwv) root:Spin:OriginalSpinData:$(Orderedloadwv)
	
		Redimension/D 	 root:Spin:OriginalSpinData:$Orderedloadwv
		
 			//else
			//	dwn+="flux"
			//	duplicate/o $("root:SES:FLUX"+num2str(ireg)) $dwn
			//endif
		
		// (optional) rescale data to desired format
		//----------------------------
		ylbl="Counts"
		if (cts>=2)
			ylbl="Cts/Sec"
			root:Spin:OriginalSpinData:$Orderedloadwv/=(root:Spin:Loadpara:dwell[ireg]*root:Spin:Loadpara:nsweep[ireg])
		endif
		if (cts==3)				// flux has been integrated the same dwell & sweeps as data
			ylbl="cts/flux"
			root:Spin:OriginalSpinData:$Orderedloadwv/=$("root:Spin:Loadpara:FLUX"+num2str(ireg))
		endif
		
		
	
		// check accuracy of nx(enpts) and ny(nslice) variable read from 
             nx0=DimSize( root:Spin:OriginalSpinData:$Orderedloadwv, 0)
             ny0=DimSize( root:spin:OriginalSpinData:$Orderedloadwv, 1)
             nz=DimSize( root:spin:OriginalSpinData:$Orderedloadwv, 2)
             ny0=SelectNumber( ny0==0, ny0, 1)
             //print nx, nx0, ny, ny0
             if (nx!=nx0)
	             	print "nx discrepancy: hdr=", nx, ",  data=", nx0
	             	nx=nx0
             endif
             //if (ny0>0)
            	if (ny!=ny0)
             		print "ny discrepancy: hdr=", ny, ",  data=", ny0
             		ny=ny0
             	endif
            // endif
		
		// (optional) offset x-scale to BE using specified photon energy & work function
		//---------------------------------
		// File saved with KE values even if acquired in BE mode
		eoff=0;  	//eunit="KE"; 
		mode=1		//1=KE, 2=BE
		IF(mode==1)
			xlbl="Kinetic Energy (eV)"
			if ((escal==2)*(numtype(hv)==0))		//data stored as KE; only offset by  WorkFct
				root:Spin:Loadpara:estart+=-hv			// I prefer negative BEs
				root:Spin:Loadpara:eend+=-hv
				//root:SES:estep*=-1
				//eunit="BE"
				xlbl="Binding Energy (eV)"
				if (numtype(wf)==0)		// skip if NaN or INF
					eoff=wf
					root:Spin:Loadpara:estart+=wf			// I prefer negative BEs
					root:Spin:Loadpara:eend+=wf
				endif
			else
				eoff=0
			endif
			//SetScale/P x root:SES:estart[ireg], root:SES:estep[ireg], "", $dwn
			//hs20111027 SetScale/I x root:Spin:Loadpara:estart[ireg], root:Spin:Loadpara:eend[ireg], "", root:spin:OriginalSpinData:$Orderedloadwv
		ELSE
			xlbl="Kinetic Energy (eV)"
			if (escal==2)					//data stored as BE; only offset by  WorkFct
				//print "here"
				root:Spin:Loadpara:estart*=-1			// I prefer negative BEs
				root:Spin:Loadpara:estep*=-1
				//eunit="BE"
				xlbl="Binding Energy (eV)"
				if (numtype(wf)==0)		// skip if NaN or INF
					eoff=wf
				endif
			else
				if (numtype(hv)==0)		// skip if NaN or INF
					eoff=-(hv-wf)
					//eunit="BE"
				endif
			endif
			//hs20111027SetScale/P x root:Spin:Loadpara:estart[ireg]+eoff, root:Spin:Loadpara:estep[ireg], "BE", root:spin:OriginalSpinData:$Orderedloadwv
		ENDIF	
		ii+=1
		while(ii<Norderedfiles)
		
		killdatafolder root:spin:load:tmp
		killdatafolder root:spin:load:tmporder	
		ireg+=1
	WHILE( ireg<nregion)
	

end



Function/T ExtractNameSpin( filenam, option, numchar )
//==================
// return substring from DOS 8.3 filename acoording to option
// 1=prefix only; 2=remove . ; 3=convert . to _; 4=extension only
// 'numchar' specifies the # of prefix characters to use
	string filenam
	variable option, numchar
	string prefix="", suffix=""
	//variable nc=strlen(filenam)
	variable ipd=strsearch(filenam,".",0)

	if (ipd<0)					//no period found
		ipd=strlen(filenam)
		prefix=filenam
		option=1
	else
		prefix=filenam[0, ipd-1]
		suffix=filenam[ipd+1,strlen(filenam)-1]
	endif
	if (numchar<2)			// all
		numchar=ipd
	endif
	prefix=prefix[0, numchar-1]
	if (option==1)
		suffix=""
	endif
	if (option==3)
		prefix=prefix+"_"
	endif
	if (option==4)
		prefix=""
	endif
	//return prefix+suffix
	
	//string start=prefix+suffix, answer=""
	//variable ii=0,lim=strlen(start)
	// do    //new scienta software version: convert "-" in filename to "_"
	// 	answer+=SelectString( cmpstr(start[ii],"-")==0, start[ii], "_")
	//	ii+=1
	//while(ii<lim)
	
	//new Scienta software version: convert "-" in filename to "_"
	string answer=prefix+suffix
	variable ihyphen=strsearch(answer,"-", 0)		//works for only one occurence of "-"
	if (ihyphen>=0)
		answer[ihyphen,ihyphen]="_"
	endif
 
	return answer
End



Function/T ArrangeinOder(folder)
string folder
string Swavelist, Swavename
variable wavenumber

setdatafolder root:spin:load:tmp
make/O/N=8 chlist

Swavelist=WaveList("A*",";","DIMS:1")
wavenumber=ItemsinList(swavelist,";")
variable i=0
Do 
   swavename=stringfromlist(i,swavelist)
   chlist[i]=str2num(swavename[strlen(swavename)-1,strlen(swavename)])
   i+=1
while(i<wavenumber)

variable j=0, chmin=1 //find out the min channel value
Do 
  if(chlist[j]<chlist[j+1])
    chmin=chlist[j]
    chlist[j]=chlist[j+1]
    chlist[j+1]=chmin
  else
    chmin=chlist[j+1]
  endif
 j+=1
while(j<(wavenumber-1))

string swavepre=swavename[0,strlen(swavename)-3] 
string Ordername
variable k=chmin
Do
 if(k<5)
 Ordername=swavepre+"V"+num2str(k)
 else
 Ordername=swavepre+"H"+num2str(k)
 endif
 
 Duplicate/o $ordername root:Spin:load:Tmporder:$(ordername)
 k+=1
while(k<(wavenumber+chmin))

return "root:spin:load:tmporder"
end


Function/T Spinchannelname(Oriname)//Spinw1=>H5,SpinW4=>H8
string Oriname
String Chname
strswitch(Oriname)
	         case "W1":	
		      chname="H5"
		     break						
	         case "W2":		
		      chname="H6"
		     break
		     case "W3":
		      chname="H7"
		      break
		     case "W4":
		      chname="H8"
		      break
		     case "B1":
		      chname="V1"
		      break
		     case "B2":
		      chname="V2"
		      break
		     case "B3":
		      chname="V3"
		      break
		     case "B4":
		      chname="V4"
		      break
	        default:							// optional default expression executed
		      break						// when no case matches
            endswitch
return chname
End
			
		
  

Proc SetParameterSpin(ctrlName): ButtonControl
      string ctrlName
       String curr= GetDataFolder(1)
	

	  Set1DParameterSpin() 
	  
	  SetDataFolder root:Spin:OriginalSpinData
      root:Spin:OriginalSpinData:OriSpin1DFileList=WaveList("A*",";","DIMS:1")      
      root:Spin:OriginalSpinData:NumOriSpin1DFile=ItemsinList(OriSpin1DFileList,";") 
            	
      SetDataFolder curr

End

Proc Set1DParameterSpin() 
//modified by shaolong 10Dec.2010(add SpinDetectorNam, Processed1Dfiles, SpinChannel, Process1DFlag
       String curr= GetDataFolder(1)
       SetDataFolder root:Spin:OriginalSpinData  
       String Imagefile1DList= WaveList("A*",";","DIMS:1")	                 //Loaded Images
       Variable limit1D=ItemsInList( Imagefile1DList, ";")
       If (limit1D>0)
       Make/O/T/N=(limit1D) OriSpin1DFile, ExperimentNote, Processed1Dfiles
       Make/O/N=(limit1D) Theta_Angle1D, Phi_Angle1D, Omega_Angle1D,Temperature1D, BLI0_1D,Spinfile_ID,SpinCh_total,Spin_Channel,Process1DFlag
       
		Variable i1D=0
		String Image1DFile
		Variable/G PhiAngle
		Do
		Image1DFile=StringFromList(i1D,Imagefile1DList,";")
		OriSpin1DFile[i1D]=Image1DFile
	    i1D=i1D+1
	    while (i1D<limit1D)	
	        DoWindow Info1D_Table
	        if(V_flag==0)
	        		Edit OriSpin1DFile, Theta_Angle1D, Phi_Angle1D, Omega_Angle1D,Temperature1D, BLI0_1D, Spinfile_ID,Spinch_total,Spin_Channel,Process1DFlag, ExperimentNote, Processed1Dfiles as "1D InformationTable"
	        		DoWindow/C Info1D_Table
	        	else
	        		DoWindow/F Info1D_Table
	        	endif
	        	
	 Else
	 Endif	        	
        	
	        	SetDataFolder curr

End


Proc NormSpin(Norfpath,NorfName,TotalCh,ChNo)     
     string Norfpath,NorfName,Readfname
     variable TotalCh, ChNo
   	//PauseUpdate; Silent 1
        String Curr=GetDataFolder(1)
        
       
	  SetDataFolder root:spin:Curvetmp

	       Variable/G x1_set, x2_set
	       
	       Variable/G root:spin:Curvetmp:x1_set=root:spin:PROCESS1D:energystart, root:spin:Curvetmp:x2_set=root:spin:PROCESS1D:energyend
	       
      Duplicate/O/R=(x1_set,x2_set) Curve, NImage 
    

//Normalize the intensities of the curves.

		Variable/G x1_norm, x2_norm, Bk1_norm, Bk2_norm,Norarea=1
		x1_norm=root:spin:PROCESS1D:Norstart
		x2_norm=root:spin:PROCESS1D:Norend
		Bk1_norm=root:spin:PROCESS1D:NorBKstart
		Bk2_norm=root:spin:PROCESS1D:NorBKend
	
		Variable NormMode=root:spin:PROCESS1D:Norcheck
       variable  norsweep, nordwell 
		
		
		
		
    	//substrate the constant background 
    	   Readfname=Norfname[1,(strlen(Norfname)-3)]+".pxt"
    	   ReadSESSpinhdr(Norfpath, Readfname)
    	   //print root:ses:sheader
    	   norsweep=str2num( StringByKey("Number of Sweeps", root:spin:loadpara:sheader, "=") )//read sweep from file
		   nordwell=str2num( StringByKey("Step Time", root:spin:loadpara:sheader, "=") )//read dwelltime from file
    	   variable background,BkgCheck
    	   BkgCheck=root:spin:Process1D:backgroundcheck
    	   if(BkgCheck==1)//If Bkgcheck==1, Background is calculated from Darkcounts. Else, it is the minum of the wave intensities.
    	      background=(nordwell*(1e-3)*norsweep)*(root:spin:Process1D:DCR[ChNo-1])
    	   else
    	      //SpinfileInfo(NImage)
    	      background=mean(NImage,BK1_norm,BK2_norm)
    	   endif
    	   NImage=NImage-background   
    	  //remove point whose value is smaller than 1e-35 
    	   variable ipnt, ipntnum
    	   ipntnum=dimsize(NImage,0)
    	   ipnt=0
    	   Do
    	     if (abs(NImage[ipnt])<=1e-35) 
    	        NImage[ipnt]=0
    	     Else
    	     Endif
    	     ipnt+=1
    	   While(ipnt<ipntnum)
    	   //
    	     
    	
    IF (NormMode==1)//Normalize according to the area of selected range
    	variable selfarea=abs(area(root:spin:Curvetmp:Nimage,root:spin:curvetmp:x1_norm,root:spin:curvetmp:x2_norm))
       //print selfarea
    	root:spin:Curvetmp:Nimage=(root:spin:Curvetmp:Nimage)/selfarea*Norarea
     else
     
     endif	
        
    	     //Set the Fermi level to zero.
     SpinfileInfo(NImage)
      
     SetScale/P x xmin-root:Spin:Process1D:Efermi, xinc,"" NImage           
  
//     Put Processed Curves in root:spin:PROCESS1D and Display
		String/G root:spin:Process1D:NName 
		String SignName_Theta
		If (root:spin:PROCESS1D:ThetaAngle<0) 
			SignName_Theta="N"
			else
			SignName_Theta="P"
		endif
		
		Variable/G root:spin:PROCESS1D:PositiveThetaAngle=0 
		
	      String curr1= GetDataFolder(1)
          SetDataFolder root:
	      String CurvefileList= WaveList("!*_CT",";","DIMS:1")	                 //Loaded Images
	      variable limit=ItemsInList( CurvefileList, ";")
	      SetDataFolder curr1
		
		
		If (root:spin:PROCESS1D:ThetaAngle<0)
			root:spin:PROCESS1D:PositiveThetaAngle=-root:spin:PROCESS1D:ThetaAngle
			else
			root:spin:PROCESS1D:PositiveThetaAngle=root:spin:PROCESS1D:ThetaAngle
		Endif
		
		String SignName_Omega
		If (root:spin:PROCESS1D:OmegaAngle<0) 
			SignName_Omega="N"
			else
			SignName_Omega="P"
		endif		
		
		String SignName_Phi
		If (root:spin:PROCESS1D:PhiAngle<0) 
			SignName_Phi="N"
			else
			SignName_Phi="P"
		endif		
		curr1=getdatafolder(1)
		setdatafolder root:spin:curvetmp
				
		NName=root:spin:PROCESS1D:NewCurvePrefix+"F"+num2str(root:spin:PROCESS1D:ProcessedCurveFlag)+"t"+num2str(round(root:spin:PROCESS1D:TempTemperature1D))
		NName+="O"+num2str(round(10*abs(root:spin:PROCESS1D:OmegaAngle)))+SignName_Omega+"P"+num2str(round(10*abs(root:spin:PROCESS1D:PhiAngle)))+SignName_Phi+"T"+num2str(round(10*root:spin:PROCESS1D:PositiveThetaAngle))+SignName_Theta
		
		NName+="I"+num2str(root:spin:PROCESS1D:SpinfileID)+"S"+num2str(root:spin:PROCESS1D:NoofSpinCh)+"C"+num2str(root:spin:PROCESS1D:SpinChannel)//add by shaolong for spin type data
//	    NName=root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"t"+num2str(root:PROCESS:TempTemperature2D)+"P"+num2str(root:PROCESS:PhiAngle)+"T"+num2str(root:PROCESS:PositiveThetaAngle)+SignName

	
//// 	NName=root:PROCESS:NewNamePrefix+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"P"+num2str(root:PROCESS:PhiAngle)+"T"+num2str(root:PROCESS:PositiveThetaAngle)+SignName

		duplicate/O root:spin:curvetmp:NImage root:spin:PROCESS1D:$NName
                	 
        setdatafolder curr1
	    SetDataFolder root:spin:PROCESS1D
	    String/G Processed1DFileList=WaveList("*F*P*T*I*C*",";","DIMS:1")
	  		        
	    SetDataFolder curr

End

Proc  GetPola_D(ctrlName) : ButtonControl
string ctrlName
string curr1, curr2,curr3
String PDfilelist,PDfileName, ToFilename, NNamepre
variable PDfileNum
variable iPDfile, iChNum
variable SFileID, CHNum, CHNo,CHNoFlag
variable ipointlim, ipoint
variable dimSpin
variable RotatingFlag=root:spin:ProcessedSFile:RSequence
curr1=getdatafolder(1)

setdatafolder root:spin:Process1D

make/O I1,I2,I3,I4,I5,I6,I7,I8


Processed1Dfilelist=wavelist("*P*T*I*S*C*",";","DIMS:1")
PDfilelist=Processed1Dfilelist
PDfileNum=ItemsInList(PDfilelist,";")

iPdfile=0
do
PDfileName=StringFromList(iPDfile,PDfilelist,";")
SfileID=str2num(PDfileName[strsearch(PDfileName,"I",0)+1,strsearch(PDfileName,"S",0)-1])
ChNum=str2num(PDfileName[strsearch(PDfileName,"S",0)+1,strsearch(PDfileName,"C",0)-1])
CHNo=str2num(PDfileName[strsearch(PDfileName,"C",0)+1,strsearch(PDfileName,"C",0)+2])
dimspin=dimsize($PDfilename,0)
make/O/N=(dimspin) PDVx,PDVy,PDHz,PDHy,PSVx,PSVy,PSHz,PSHy
make/O/N=(dimspin) PDx, PDy, PDz
copyscale1D($PDfilename,PDvx)
copyscale1D($PDfilename,PDvy)
copyscale1D($PDfilename,PDHz)
copyscale1D($PDfilename,PDHy)
copyscale1D($PDfilename,PSvx)
copyscale1D($PDfilename,PSvy)
copyscale1D($PDfilename,PSHz)
copyscale1D($PDfilename,PsHy)
copyscale1D($PDfilename,PDx)
copyscale1D($PDfilename,PDy)
copyscale1D($PDfilename,PDz)

curr3=getdatafolder(1)
setdatafolder root:spin:ProcessedSFile
make/O/N=(dimspin) IxUp, IxDown, IHyUp, IHyDown, IVyUp, IVyDown, IyUp, IyDown, IzUp, IzDown
copyscale1D(root:spin:Process1D:$PDfilename,IxUP)
copyscale1D(root:spin:Process1D:$PDfilename,IxDown)
copyscale1D(root:spin:Process1D:$PDfilename,IHyUp)
copyscale1D(root:spin:Process1D:$PDfilename,IHyDown)
copyscale1D(root:spin:Process1D:$PDfilename,IVyUp)
copyscale1D(root:spin:Process1D:$PDfilename,IVyDown)
copyscale1D(root:spin:Process1D:$PDfilename,IyUp)
copyscale1D(root:spin:Process1D:$PDfilename,IyDown)
copyscale1D(root:spin:Process1D:$PDfilename,IzUp)
copyscale1D(root:spin:Process1D:$PDfilename,IzDown)
setdatafolder curr3  



if ((CHNo==1)||((CHNo==5)&(CHNum==4)))
      
    If(ChNum==8)
    
         iChNum=1
         do 
         Pdfilename=stringfromlist(ipdfile+iChNum-1,PDfilelist,";")
         ChNoFlag= str2num(PDfileName[strsearch(PDfileName,"C",0)+1,strsearch(PDfileName,"C",0)+2])
         Tofilename="I"+num2str(ChNoFlag)
         duplicate/O $Pdfilename $Tofilename
         iChNum+=1
         while(iChNum<=8)
         
         PDVx=round(1e4*((I2-I4*Ai[2])/(I2+I4*Ai[2]))/SeffV)/1e4
         PDVy=round(1e4*((I1-I3*Ai[3])/(I1+I3*Ai[3]))/SeffV)/1e4
         PDHy=round(1e4*((I6-I7*Ai[1])/(I6+I7*Ai[1]))/SeffH)/1e4
         PDHz=round(1e4*((I5-I8*Ai[0])/(I5+I8*Ai[0]))/SeffH)/1e4
       
                
         //replace the N/A point with zero in PDVX, PDVy, PDHz, PDHy
         removenan(PDvx)
         removenan(PDvy)
         removenan(PDhz)
         removenan(PDhy)
         
         //Get the avearaged P vector from the two Mott detector. The PDy is always measured twice.
         PDy=(PDVy+PDHy)/2
    //Scaling the PDx, PDz according to PDHy and PDVy  Deleted by shaolong 2011Nov09  
         //If ((mean(PDVy)!=0))
         //    PDx=PDVx*(mean(PDy)/mean(PDVy))
         //else
           //  if(mean(PDHy)==mean(PDVy)) //PDHy=PDVy=0
             //    PDx=PDVx
             
             //else    
               //  print "Error, PDVy is zero!"
               //  abort
           //  endif
        // endif
         
      //   if (mean(PDHy)!=0)
        //     PDz=PDHz*(mean(PDy)/mean(PDHy))
        // else
           //  if(mean(PDVy)==mean(PDHy))
             //   PDz=PDHz
               
             //else
               // Print "Error, PDHy is zero!"   
               // abort
             // endif
         //endif   
       
         PDz=PDHz
         PDx=PDVx
               
         NNamepre=Pdfilename[0,strsearch(Pdfilename,"S",0)-1]
         duplicate/O PDVx, $(NNamepre+"PDVx")
         duplicate/O PDVy, $(NNamepre+"PDVy")
         duplicate/O PDHz, $(NNamepre+"PDHz")
         duplicate/O PDHy, $(NNamepre+"PDHy")
         
         duplicate/O PDx, root:spin:ProcessedSfile:$(NNamepre+"PDx")
         duplicate/O PDy, root:spin:ProcessedSfile:$(NNamepre+"PDy")
         duplicate/O PDz, root:spin:ProcessedSfile:$(NNamepre+"PDz")
         
         if (root:spin:Process1D:transformcheck==1) 
              PolDToPolS(NNamepre,PDx,PDy,PDz,RotatingFlag)//Rotation transfermation from Detector coordinate to Sample coordinate system. 
         else
              duplicate/O PDx, root:spin:ProcessedSfile:$(NNamepre+"Px")
              duplicate/O PDy, root:spin:ProcessedSfile:$(NNamepre+"Py")
              duplicate/O PDz, root:spin:ProcessedSfile:$(NNamepre+"Pz")
              duplicate/O PDx, root:spin:ProcessedSfile:Px
              duplicate/O PDy, root:spin:ProcessedSfile:Py
              duplicate/O PDz, root:spin:ProcessedSfile:Pz
         Endif
         curr2=getdatafolder(1)
         setdatafolder root:spin:ProcessedSfile
        
         IxUp=(root:spin:Process1D:I2+root:spin:Process1D:I3)*(1+Px)/2
         IxDown=(root:spin:Process1D:I2+root:spin:Process1D:I3)*(1-Px)/2
         IHyUp=(root:spin:Process1D:I6+root:spin:Process1D:I7)*(1+Py)/2
         IHyDown=(root:spin:Process1D:I6+root:spin:Process1D:I7)*(1-Py)/2
         IVyUp=(root:spin:Process1D:I2+root:spin:Process1D:I3)*(1+Py)/2
         IVyDown=(root:spin:Process1D:I2+root:spin:Process1D:I3)*(1-Py)/2
         IyUp=(IHyUp+IVyUp)/2
         IyDown=(IHyDown+IVyDown)/2
         IzUp=(root:spin:Process1D:I8+root:spin:Process1D:I5)*(1+Pz)/2
         IzDown=(root:spin:Process1D:I8+root:spin:Process1D:I5)*(1-Pz)/2 
         
         duplicate/O IxUp, $(NNamepre+"IxUp")
         duplicate/O IxDown, $(NNamepre+"IxDown")  
         duplicate/O IHyUp, $(NNamepre+"IHyUp")
         duplicate/O IHyDown, $(NNamepre+"IHyDown")
         duplicate/O IVyUp, $(NNamepre+"IVyUp")
         duplicate/O IVyDown, $(NNamepre+"IVyDown")
         duplicate/O IyUp, $(NNamepre+"IyUp")
         duplicate/O IyDown, $(NNamepre+"IyDown")
         duplicate/O IzUp, $(NNamepre+"IzUp")
         duplicate/O IzDown, $(NNamepre+"IzDown")
         
         setdatafolder curr2     
         
    Else// IChNum=4, Four Channel
         
         iChNum=1
         do 
         Pdfilename=stringfromlist(ipdfile+iChNum-1,PDfilelist,";")
         ChNoFlag=str2num(Pdfilename[strsearch(PDfileName,"C",0)+1,strsearch(PDfileName,"C",0)+2])
         Tofilename="I"+num2str(ChNoFlag)
         duplicate/O $Pdfilename $Tofilename
         iChNum+=1
         while(iChNum<=4)
         if(ChNoFlag==4)  //Only data obtained by the Spindetector_V 
             PDVx=round(1e4*((I2-I4*Ai[2])/(I2+I4*Ai[2]))/SeffV)/1e4
             PDVy=round(1e4*((I1-I3*Ai[3])/(I1+I3*Ai[3]))/SeffV)/1e4
       
            PDx=PDVx
            PDy=PDVy
            duplicate/O PDx PDz //By default,PDz is set to be zero, but have same scale with PDx, or PDy
            PDz=0// when using SpinDetector_V,by default, PDz is set to be zero.
                 
            NNamepre=Pdfilename[0,strsearch(Pdfilename,"S",0)-1]
            duplicate/O PDVx, $(NNamepre+"PDVx")
            duplicate/O PDVy, $(NNamepre+"PDVy")
            
            duplicate/O PDx, root:spin:ProcessedSfile:$(NNamepre+"PDx")
            duplicate/O PDy, root:spin:ProcessedSfile:$(NNamepre+"PDy")
            duplicate/O PDz, root:spin:ProcessedSfile:$(NNamepre+"PDz")
            
              if (root:spin:Process1D:transformcheck==1) 
                  PolDToPolS(NNamepre,PDx,PDy,PDz,RotatingFlag)//Rotation transfermation from Detector coordinate to Sample coordinate system. 
              else
                  duplicate/O PDx, root:spin:ProcessedSfile:$(NNamepre+"Px")
                  duplicate/O PDy, root:spin:ProcessedSfile:$(NNamepre+"Py")
                  duplicate/O PDz, root:spin:ProcessedSfile:$(NNamepre+"Pz")
                  duplicate/O PDx, root:spin:ProcessedSfile:Px
                  duplicate/O PDy, root:spin:ProcessedSfile:Py
                  duplicate/O PDz, root:spin:ProcessedSfile:Pz
              Endif
          //  PolDToPolS(NNamepre,PDx,PDy,PDz,RotatingFlag) //deleted by shaolong 20111109
            
            curr2=getdatafolder(1)
            setdatafolder root:spin:ProcessedSfile
            
            
            IxUp=(root:spin:Process1D:I2+root:spin:Process1D:I4)*(1+Px)/2
            IxDown=(root:spin:Process1D:I2+root:spin:Process1D:I4)*(1-Px)/2
            IVyUp=(root:spin:Process1D:I1+root:spin:Process1D:I3)*(1+Py)/2
            IVyDown=(root:spin:Process1D:I1+root:spin:Process1D:I3)*(1-Py)/2
            IyUp=IVyUp
            IyDown=IVyDown
            
            duplicate/O IxUp, $(NNamepre+"IxUp")
            duplicate/O IxDown, $(NNamepre+"IxDown")  
            duplicate/O IVyUp, $(NNamepre+"IVyUp")
            duplicate/O IVyDown, $(NNamepre+"IVyDown")
            duplicate/O IyUp, $(NNamepre+"IyUp")
            duplicate/O IyDown, $(NNamepre+"IyDown")
           
            setdatafolder curr2     
            
            
            
         else           //Only data obtained by the Spindetector_H
            PDHz=round(1e4*((I5-I8*Ai[0])/(I5+I8*Ai[0]))/SeffH)/1e4
            PDHy=round(1e4*((I6-I7*Ai[1])/(I6+I7*Ai[1]))/SeffH)/1e4
                       
            duplicate/O PDHz PDx//make sure PDx has the same scale with PDz
            PDx=0 //By default, PDx is set to be zero for Spindetector_H.
            PDy=PDHy
            PDz=PDHz
            
            NNamepre=Pdfilename[0,strsearch(Pdfilename,"S",0)-1]
            duplicate/O PDHz, $(NNamepre+"PDHz")
            duplicate/O PDHy, $(NNamepre+"PDHy")
            
            duplicate/O PDx, root:spin:ProcessedSfile:$(NNamepre+"PDx")
            duplicate/O PDy, root:spin:ProcessedSfile:$(NNamepre+"PDy")
            duplicate/O PDz, root:spin:ProcessedSfile:$(NNamepre+"PDz")
            
           if (root:spin:Process1D:transformcheck==1) 
              PolDToPolS(NNamepre,PDx,PDy,PDz,RotatingFlag)//Rotation transfermation from Detector coordinate to Sample coordinate system. 
           else
              duplicate/O PDx, root:spin:ProcessedSfile:$(NNamepre+"Px")
              duplicate/O PDy, root:spin:ProcessedSfile:$(NNamepre+"Py")
              duplicate/O PDz, root:spin:ProcessedSfile:$(NNamepre+"Pz")
              duplicate/O PDx, root:spin:ProcessedSfile:Px
              duplicate/O PDy, root:spin:ProcessedSfile:Py
              duplicate/O PDz, root:spin:ProcessedSfile:Pz
           Endif
            //PolDToPolS(NNamepre,PDx,PDy,PDz,RotatingFlag)//Deleted by shaolong 20111109
            
            curr2=getdatafolder(1)
            setdatafolder root:spin:ProcessedSfile
            
            
            IHyUp=(root:spin:Process1D:I5+root:spin:Process1D:I7)*(1+Py)/2
            IHyDown=(root:spin:Process1D:I5+root:spin:Process1D:I7)*(1-Py)/2
            
            IyUp=IHyUp
            IyDown=IHyDown
            IzUp=(root:spin:Process1D:I8+root:spin:Process1D:I5)*(1+Pz)/2
            IzDown=(root:spin:Process1D:I8+root:spin:Process1D:I5)*(1-Pz)/2 
            
            
            duplicate/O IHyUp, $(NNamepre+"IHyUp")
            duplicate/O IHyDown, $(NNamepre+"IHyDown")
            duplicate/O IyUp, $(NNamepre+"IyUp")
            duplicate/O IyDown, $(NNamepre+"IyDown")
            duplicate/O IzUp, $(NNamepre+"IzUp")
            duplicate/O IzDown, $(NNamepre+"IzDown")  
            
            
            setdatafolder curr2     
            
         endif
    endif
else
    
endif
ipdfile+=1
while(ipdfile<PDfileNum)      

setdatafolder root:spin:ProcessedSFile
Polawavelist=wavelist("*F*T*P*I*PD*",";","DIMS:1")+";"+wavelist("*F*T*P*I*Px",";","DIMS:1")+";"+wavelist("*F*T*P*I*Py",";","DIMS:1")+";"+wavelist("*F*T*P*I*Pz",";","DIMS:1")
Polafilelist=getpolalist("root:spin:ProcessedSFile")
SpinEDClist=wavelist("*F*T*P*I*I*",";","DIMS:1")  
SpinResfile=getspinEDClist("root:spin:ProcessedSFile")   
setdatafolder curr1

end


Function PolDToPolS(PDfnamePre,PDx,PDy,PDz,RFlag)
//Transfer the Polarization vector in Detector coordinate to Sample coordinate. And return the tranfered wave name(P in sample coordinate).
string PDfnamePre
wave PDx,PDy,PDz
variable RFlag

String PolaFname
string curr1=getdatafolder(1)

newdatafolder/O/S root:spin:ProcessedSfile

Variable PosTh,PosThd,PosPhi,PosPhid,Stheta, Sphi
Variable ipoint,i,j
string SignofTh,SignofPhi


PosTh=strsearch(PDfNamePre,"T",0)
j=1
do
  signofTh=PDfnamePre[Posth+j]
  if(cmpstr(signofTh,"P")==0)
     Stheta=(str2num(PDfnamePre[Posth+1,Posth+j])/10)/180*Pi  
     break
  else
     if(cmpstr(signofTh,"N")==0)
        Stheta=((-1)*str2num(PDfnamePre[Posth+1,Posth+j])/10)/180*pi 
        break
     else      
        j+=1
     endif
  endif
  
while(j<(strlen(PDfnamePre)-PosTh))
 
  
PosPhi=strsearch(PDfnamePre,"P",0)
j=1
do
  signofPhi=PDfnamePre[PosPhi+j]
  if(cmpstr(signofPhi,"P")==0)
     Sphi=(str2num(PDfnamePre[Posphi+1,Posphi+j])/10)/180*Pi  
     break
  else
     if(cmpstr(signofphi,"N")==0)
        Sphi=((-1)*str2num(PDfnamePre[Posphi+1,Posphi+j])/10)/180*pi 
        break
     else      
        j+=1
     endif
  endif
  
while(j<(strlen(PDfnamePre)-Posphi))

make/O TransC={{1,0,0},{0,cos(stheta),-sin(stheta)},{0,sin(stheta),cos(stheta)}}//Rotation Transfer matrix for x
make/O TransD={{cos(sphi),-sin(sphi),0},{sin(sphi),cos(sphi),0},{0,0,1}}// RTM for z
make/O/N=(3,3) TransA
if(RFlag==0)
    Matrixop/O TransA=TransC x TransD
else
    Matrixop/O TransA=TransD x TransC
Endif

iPoint=Dimsize(PDx,0)
make/O/N=(ipoint) Px, Py, Pz
copyscale1D(PDx,Px)
copyscale1D(PDy,Py)
copyscale1D(PDz,Pz)
i=0
do
  Px[i]=TransA[0][0]*Pdx[i]+TransA[0][1]*Pdy[i]+TransA[0][2]*Pdz[i]
  Py[i]=TransA[1][0]*Pdx[i]+TransA[1][1]*Pdy[i]+TransA[1][2]*Pdz[i]
  Pz[i]=TransA[2][0]*Pdx[i]+TransA[2][1]*Pdy[i]+TransA[2][2]*Pdz[i]
  i+=1
while(i<ipoint)

duplicate/O Px, $(PDfnamePre+"Px")
duplicate/O Py, $(PDfnamePre+"Py")
duplicate/O Pz, $(PDfnamePre+"Pz")

setdatafolder curr1
end


Function DisplayAllSpinFile(ctrlName,popNum,popStr) : PopupMenuControl
//-----------------------------
//Modified by shaolong 11Dec.2010
	String ctrlName
	Variable popNum
	String popStr
    String GraphName, TopGraphname,Spinimagelist,Spin1Dfilelist,spinfilename,Displayfilename
    variable Displayflag,Display2Dflag,Display1Dflag,i,channelnum,offsetvalue,Estart1,Estart2,Eend1,Eend2,Estart,Eend   
    GraphName="SpinFile"+stringfromlist(0,popStr,".")
	//wavescale
	String Curr=GetDataFolder(1)

	//variable Appendto=root:spin:PROCESS1D:Appendto
	SetDataFolder root:Spin:OriginalSpinData
	 spinfilename="A"+popstr[0,strlen(popstr)-5]
     spinimagelist=wavelist(spinfilename,";","DIMS:2")
     Display2Dflag=ItemsInList(spinimagelist,";")
     spin1Dfilelist=wavelist(spinfilename+"*",";","DIMS:1")
     Display1Dflag=ItemsInList(spin1Dfilelist,";")
     Displayflag=Display2Dflag+Display1Dflag
          
     DoWindow $Graphname
	             if(V_flag==0)
           	           Display as Graphname
           	           Topgraphname=winname(0,1)
           	           DoWindow/F $Topgraphname
           	           
           	           DoWindow/C $Graphname
           	 
           	  switch(Displayflag)
	         case 4:	//four EDC no image
	              i=0
		          Do
		            Displayfilename=stringfromlist(i,spin1Dfilelist,";")
		            Appendtograph  $Displayfilename
		            
		            channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		          
		            
		            
		             switch(channelnum)
		             case 1:
		             offsetvalue=mean($Displayfilename)
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             case 5 :
		             offsetvalue=mean($Displayfilename)
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		            
		            i+=1
		          while(i<4)
		          
		           Label bottom "Kinetic Energy(eV)"
		           ModifyGraph tickUnit(bottom)=1, tick(left)=3, nolabel(left)=1
		           ModifyGraph mirror=2
		           Legend/C/N=text0/A=MC
		                   
		          break	
		          					
	         case 8://8 channels without image
	         		 i=0
		          Do
		            Displayfilename=stringfromlist(i,spin1Dfilelist,";")
		           
		            
		            Appendtograph/L=left/B=Bottom $Displayfilename
		            channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		            
		            
		             switch(channelnum)
		             case 1 :
		             offsetvalue=mean($Displayfilename)
		             Estart1=Dimoffset($Displayfilename,0)
		             Eend1=Estart1+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
		             
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             case 5 :
		             offsetvalue=mean($Displayfilename)
		             
		            
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		             
		            i+=1
		          while(i<4)  //display the 4 EDCs from Horizontal Mott
		         
		         
		          ModifyGraph axisEnab(Left)={0,0.45}
		          ModifyGraph mirror(left)=2
		          ModifyGraph tick(left)=3, nolabel(left)=1
		        
				  
		         //display the next 4 EDC from the vetical Mott
		        		          
				    Do
		            Displayfilename=stringfromlist(i,spin1Dfilelist,";")
		            
		            AppendToGraph/L=left1/B=Bottom1 $Displayfilename
		             channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		          
		            
		             switch(channelnum)
		             case 1:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		              case 5:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Estart2=Dimoffset($Displayfilename,0)
		             Eend2=Estart2+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
		             
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		            i+=1
		          while(i<8)  //display the 4 EDCs from Horizontal Mott
		          
		          ModifyGraph axisEnab(Left1)={0.55,1}
		          ModifyGraph freepos(Left1)=0
		          ModifyGraph freepos(Bottom1)={0.55,kwFraction}
		          ModifyGraph mirror(left1)=2,mirror(Bottom1)=2
				  //label left "Intensity"
				  label bottom "Kinetic Energy(eV)"
				  ModifyGraph tickUnit(bottom)=1
				  ModifyGraph tick(Bottom1)=3
		          ModifyGraph noLabel(Bottom1)=2
		          ModifyGraph nolabel(Left1)=2, tick(left1)=3
				  
				  
				   //determine the axi range of the plot graph
		          if(Estart1<Estart2)
		             Estart=Estart2
		          else
		             Estart=Estart1
		          Endif
		            
		          if(Eend1<Eend2)
		             Eend=Eend1
		          else
		             Eend=Eend2
		          Endif
		          
		          SetAxis bottom Estart, Eend
		          SetAxis bottom1 Estart, Eend
				  
				 
				  
		      
		     break
		     
		      case 5:
		     //4 channels with image
	         		 i=0
		          Do
		            Displayfilename=stringfromlist(i,spin1Dfilelist,";")
		             
		             Estart1=Dimoffset($Displayfilename,0)
		             Eend1=Estart1+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
		            
		            Appendtograph/L=left/B=Bottom $Displayfilename
		            channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		            
		            
		             switch(channelnum)
		             case 1 :
		             offsetvalue=mean($Displayfilename)
		           
		             
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             case 5 :
		             offsetvalue=mean($Displayfilename)
		             
		            
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		             
		            i+=1
		          while(i<4)  //display the 4 EDCs from Horizontal Mott
		         
		         
		          ModifyGraph axisEnab(Left)={0,0.45}
		          ModifyGraph mirror(left)=2
		          ModifyGraph tick(left)=3, nolabel(left)=1
		        
		         				 
				  label bottom "Kinetic Energy(eV)"
				  ModifyGraph tickUnit(bottom)=1
								  
				  //To display the image file
				   Displayfilename=stringfromlist(0,spinimagelist,";")
		          AppendImage/L=left2/B=Bottom2 $Displayfilename
		          
				  ModifyGraph axisEnab(Left2)={0.55,1}
				  Modifygraph freepos(Left2)=0, freepos(Bottom2)=0
				  ModifyGraph freepos(Bottom2)={0.55,kwFraction}
				   ModifyGraph mirror(left2)=2,mirror(Bottom2)=2
				  
				  ModifyGraph tick(Bottom2)=3
		         ModifyGraph noLabel(Bottom2)=2
		         Label left2 "Angle(deg)"
		         Modifygraph tickUnit(Left2)=1
		         Modifyimage $displayfilename ctab={*,*,PlanetEarth,0}
				  
				   Estart2=Dimoffset($Displayfilename,0)
		          Eend2=Estart2+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
				   
				   //determine the axi range of the plot graph
		          if(Estart1<Estart2)
		             Estart=Estart2
		          else
		             Estart=Estart1
		          Endif
		            
		          if(Eend1<Eend2)
		             Eend=Eend1
		          else
		             Eend=Eend2
		          Endif
		          
		          SetAxis bottom Estart, Eend
		          SetAxis bottom2 Estart, Eend
				  
				
		     break
		     
		     case 9:
		     //8 channels with image
	         		 i=0
		          Do
		            Displayfilename=stringfromlist(i,spin1Dfilelist,";")
		           
		            
		            Appendtograph/L=left/B=Bottom $Displayfilename
		            channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		            
		            
		             switch(channelnum)
		             case 1 :
		             offsetvalue=mean($Displayfilename)
		             Estart1=Dimoffset($Displayfilename,0)
		             Eend1=Estart1+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
		             
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             case 5 :
		             offsetvalue=mean($Displayfilename)
		             
		            
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		             
		            i+=1
		          while(i<4)  //display the 4 EDCs from Horizontal Mott
		         
		         
		          ModifyGraph axisEnab(Left)={0,0.3}
		          ModifyGraph mirror(left)=2
		          ModifyGraph tick(left)=3, nolabel(left)=1
		        
				  
		         //display the next 4 EDC from the vetical Mott
		        		          
				    Do
		            Displayfilename=stringfromlist(i,spin1Dfilelist,";")
		            
		            AppendToGraph/L=left1/B=Bottom1 $Displayfilename
		             channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		          
		            
		             switch(channelnum)
		             case 1:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		              case 5:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Estart2=Dimoffset($Displayfilename,0)
		             Eend2=Estart2+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
		             
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		            i+=1
		          while(i<8)  //display the 4 EDCs from Vertical Mott
		          
		          ModifyGraph axisEnab(Left1)={0.33,0.63}
		          ModifyGraph freepos(Left1)=0
		          ModifyGraph freepos(Bottom1)={0.33,kwFraction}
		          ModifyGraph mirror(left1)=2,mirror(Bottom1)=2
				 
				  label bottom "Kinetic Energy(eV)"
				  ModifyGraph tickUnit(bottom)=1
				  ModifyGraph tick(Bottom1)=3
		         ModifyGraph noLabel(Bottom1)=2
		         ModifyGraph nolabel(Left1)=2, tick(left1)=3
				  
				  //To display the image file
				   Displayfilename=stringfromlist(0,spinimagelist,";")
		          AppendImage/L=left2/B=Bottom2 $Displayfilename
				  ModifyGraph axisEnab(Left2)={0.66,1}
				  Modifygraph freepos(Left2)=0, freepos(Bottom2)=0
				  ModifyGraph freepos(Bottom2)={0.66,kwFraction}
				   ModifyGraph mirror(left2)=2,mirror(Bottom2)=2
				  
				  ModifyGraph tick(Bottom2)=3
		         ModifyGraph noLabel(Bottom2)=2
		         Label left2 "Angle(deg)"
		         Modifygraph tickUnit(Left2)=1
		        Modifyimage $displayfilename ctab={*,*,PlanetEarth,0}
				   //determine the axi range of the plot graph
		          if(Estart1<Estart2)
		             Estart=Estart2
		          else
		             Estart=Estart1
		          Endif
		            
		          if(Eend1<Eend2)
		             Eend=Eend1
		          else
		             Eend=Eend2
		          Endif
		          
		          SetAxis bottom Estart, Eend
		          SetAxis bottom1 Estart, Eend
				  
				
		     break
		     
		             
		     
		     //case "B1":
		     // chname="V1"
		     // break
		    
	       // default:							// optional default expression executed
		     // break						// when no case matches
           
            endswitch
         
 			      else
	                   DoWindow/F $Graphname
	        	  endif
	
		SetDataFolder Curr
End   

Proc SelectOriginalSpinFile(ctrlName,popNum,popStr) : PopupMenuControl
//-----------------------------
//Modified by shaolong 11Dec.2010
	String ctrlName
	Variable popNum
	String popStr
    String FileName, WinAppendto, wintitle
       
    FileName="Ori1D_"+popStr
	
	String Curr=GetDataFolder(1)

	variable Appendto=root:spin:PROCESS1D:Appendto
	SetDataFolder root:Spin:OriginalSpinData
    if (Appendto==1)
        winappendto=winname(0,1)
        if(cmpstr("Ori1D", winappendto[0,4])==0)
                Getwindow $winappendto wtitle
                
                wintitle=S_value+";"+popstr  
                AppendToGraph/W=$WinAppendto $popStr
                
                Dowindow/T $WinAppendto wintitle
        else
        endif
	 
	 else
	     DoWindow $FileName
	             if(V_flag==0)
           	           Display $popStr
           	           Dowindow/F $winname(0,1)
           	            	           
        		       DoWindow/C $FileName
 			      else
	                   DoWindow/F $FileName
	        	  endif
	     Getwindow $FileName wtitle
	     wintitle="Ori1D:"+popstr  
	     Dowindow/T $FileName wintitle
	 endif

		SetDataFolder Curr
End    

Proc SelectSpinFile(ctrlName,popNum,popStr) : PopupMenuControl
//-----------------------------
//Modified by shaolong 15Dec.2010
	String ctrlName
	Variable popNum
	String popStr
    String FileName, WinAppendto, wintitle
    variable Appendto
   
    String Curr=GetDataFolder(1)
    setdatafolder root:spin:PROCESSedSfile 
    
    
	if (cmpstr(ctrlName,"Polawavelist")==0)
	   Appendto=PAppend
	   FileName="Pola_"+popStr
	else
	   if(cmpstr(ctrlName,"SEDClist")==0)
	   Appendto=SEDCAppend
	   FileName="SEDC_"+popStr
	   else
	   endif
	 endif
    
//	SetDataFolder root:Spin:OriginalSpinData
    if (Appendto==1)
        winappendto=winname(0,1)
        if((cmpstr("Pola", winappendto[0,3])==0)||(cmpstr("SEDC",winappendto[0,3])==0))
                Getwindow $winappendto wtitle
                
                wintitle=S_value+";"+popstr  
                AppendToGraph/W=$WinAppendto $popStr
                
                Dowindow/T $WinAppendto wintitle
        else
        endif
	 
	 else
	     DoWindow $FileName
	             if(V_flag==0)
           	           Display $popStr
           	           Dowindow/F $winname(0,1)
        		       DoWindow/C $FileName
 			      else
	                   DoWindow/F $FileName
	        	  endif
	     Getwindow $FileName wtitle
	     wintitle="Graph0:"+popstr  
	     Dowindow/T $FileName "Graph0:"+popstr
	 endif

		SetDataFolder Curr
End      


Proc SelectProcessedFile(ctrlName,popNum,popStr) : PopupMenuControl
//-----------------------------
//Modified by shaolong 15Dec.2010
	String ctrlName
	Variable popNum
	String popStr
    String FileName, WinAppendto, wintitle,windowname
       
    FileName="Processed"+popStr
	
	String Curr=GetDataFolder(1)

	variable Appendto=root:spin:PROCESS1D:AppendPro
	SetDataFolder root:spin:Process1D
    if (Appendto==1)
        winappendto=winname(0,1)
        
        Getwindow $winappendto wtitle
                
        wintitle=S_value+";"+popstr  
        AppendToGraph/W=$WinAppendto $popStr
        Dowindow/T $WinAppendto wintitle
       
	 else
	     DoWindow $FileName
	             if(V_flag==0)
           	           Display $popStr
           	           windowname=winname(0,1)
           	           Dowindow/F $windowname
           	                    	             
        		       DoWindow/C $Filename
 			      else
	                   DoWindow/F $FileName
	        	  endif
	     Getwindow $FileName wtitle
	     wintitle="Processed:"+popstr  
	     Dowindow/T $FileName wintitle
	 endif
		SetDataFolder Curr
End  

Proc Updatefilelist(curr)
string curr
string curr1
curr1=getdatafolder(1)
setdatafolder $curr
ProcessedSpinfilelist=Getspinfilelist(curr)
setdatafolder $curr1
End

Function DisplayProcessedSpinFile(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string curr
   
//start here display spinfile
    String GraphName, TopGraphname,spinfilename,Displayfilename
    variable Displayflag,i,channelnum,offsetvalue,Estart1,Estart2,Eend1,Eend2,Estart,Eend   
    setdatafolder root:spin:process1D
    curr=getdatafolder(1)
    //updatefilelist(curr)
    //ProcessedSpinfilelist=Getspinfilelist(curr)
    
    GraphName="Processed"+popstr
  
	 spinfilename=popstr
	 Displayflag=str2num(stringfromlist(1,popstr,"S"))
     
     DoWindow $Graphname
	             if(V_flag==0)
           	           Display as Graphname
           	           Topgraphname=winname(0,1)
           	           DoWindow/F $Topgraphname
           	           
           	           DoWindow/C $Graphname
           	 
           	  switch(Displayflag)
	         case 4:	//four EDC no image
	               string checklist=wavelist("*O*P*T*I*S*C*",";","DIMS:1")
		            string chfile=stringbyKey(popstr,checklist,"C")
		            variable chnum=str2num(chfile)
		            if(chnum>4)
		            chnum=4
		            else
		            chnum=0
		            Endif
	             
	              i=0+chnum
		          Do
		            Displayfilename=popstr+"C"+num2str(i+1)	            
		            Appendtograph  $Displayfilename
		            
		            channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		              
		             switch(channelnum)
		             case 1:
		             offsetvalue=mean($Displayfilename)
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             case 5 :
		             offsetvalue=mean($Displayfilename)
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		            
		            i+=1
		          while(i<4+chnum)
		          
		           Label bottom "Kinetic Energy(eV)"
		           ModifyGraph tickUnit(bottom)=1, tick(left)=3, nolabel(left)=1
		           ModifyGraph mirror=2
		           Legend/C/N=text0/A=MC
		                   
		          break	
		          					
	         case 8://8 channels without image
	         		 i=0
		          Do
		            Displayfilename=popstr+"C"+num2str(i+1)
		           
		            
		            Appendtograph/L=left/B=Bottom $Displayfilename
		            channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		            
		            
		             switch(channelnum)
		             case 1 :
		             offsetvalue=mean($Displayfilename)
		             Estart1=Dimoffset($Displayfilename,0)
		             Eend1=Estart1+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
		             
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             case 5 :
		             offsetvalue=mean($Displayfilename)
		             
		            
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		             
		            i+=1
		          while(i<4)  //display the 4 EDCs from Horizontal Mott
		         
		         
		          ModifyGraph axisEnab(Left)={0,0.45}
		          ModifyGraph mirror(left)=2
		          ModifyGraph tick(left)=3, nolabel(left)=1
		        
				  
		         //display the next 4 EDC from the vetical Mott
		        		          
				    Do
		            Displayfilename=popstr+"C"+num2str(i+1)
		            
		            AppendToGraph/L=left1/B=Bottom1 $Displayfilename
		             channelnum=str2num(displayfilename[strlen(displayfilename)-1,strlen(displayfilename)])//get channel number from the file name
		          
		            
		             switch(channelnum)
		             case 1:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Break
		             
		             case 2:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 3:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 4:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		              case 5:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(65280,0,0)
		             
		             Estart2=Dimoffset($Displayfilename,0)
		             Eend2=Estart2+Dimdelta($Displayfilename,0)*(Dimsize($Displayfilename,0)-1)
		             
		             
		             Break
		             
		             case 6:
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,15872,65280)
		             
		             Break
		             
		             case 7:
		             
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(16384,65280,16384)
		             Break
		             
		             case 8:
		             ModifyGraph offset($Displayfilename)={0,offsetvalue}
		             ModifyGraph lsize($displayfilename)=2
		             ModifyGraph rgb($displayfilename)=(0,0,0)
		             break
		             
		             default:
		             break
		             
		             endswitch
		            i+=1
		          while(i<8)  //display the 4 EDCs from Horizontal Mott
		          
		          ModifyGraph axisEnab(Left1)={0.55,1}
		          ModifyGraph freepos(Left1)=0
		          ModifyGraph freepos(Bottom1)={0.55,kwFraction}
		          ModifyGraph mirror(left1)=2,mirror(Bottom1)=2
				  //label left "Intensity"
				  label bottom "Kinetic Energy(eV)"
				  ModifyGraph tickUnit(bottom)=1
				  ModifyGraph tick(Bottom1)=3
		          ModifyGraph noLabel(Bottom1)=2
		          ModifyGraph nolabel(Left1)=2, tick(left1)=3
				  
				  
				   //determine the axi range of the plot graph
		          if(Estart1<Estart2)
		             Estart=Estart2
		          else
		             Estart=Estart1
		          Endif
		            
		          if(Eend1<Eend2)
		             Eend=Eend1
		          else
		             Eend=Eend2
		          Endif
		          
		          SetAxis bottom Estart, Eend
		          SetAxis bottom1 Estart, Eend
				  
				 
				  
		      
		     break
		     
		     default:
		     break					// when no case matches
           
            endswitch
         
 			      else
	                   DoWindow/F $Graphname
	        	  endif
	
		SetDataFolder Curr
End  



Function/T GetSpinfilelist(curr)
string curr
string spin1Dlist,filelisttmp,filenametmp,spin1Dname,spinfilelist=""
variable i,filenum,j
setdatafolder $curr
Spin1Dlist=wavelist("*F*O*P*T*I*S*C*",";","DIMS:1")  
    filenum=Itemsinlist(Spin1Dlist,";")
   
    i=0
    Do
    filelisttmp=Stringfromlist(i,spin1Dlist,";") 
    Filenametmp=filelisttmp[0,strlen(filelisttmp)-3]
    j=Itemsinlist(Spinfilelist,";")
    Spin1Dname=stringfromlist(j-1,spinfilelist,";")
   
    if(cmpstr(filenametmp,spin1Dname)==0)
    
    Else
    Spinfilelist=Spinfilelist+Filenametmp+";"
    Endif
    i=i+1
    while(i<filenum)
    //print Spinfilelist
    //
return spinfilelist   
End

Function/T SpinfileInfo( Spinfile )
//================
// creates variables in current folder
// returns info string

	wave Spinfile
	string curr1=getdatafolder(1)
	variable/G nx
	variable/G xmin, xinc, xmax
	variable/G Imin0, Imax0
	nx=DimSize(Spinfile, 0)
	xmin=DimOffset(Spinfile,0)
	xinc=round(DimDelta(Spinfile,0) * 1E6) / 1E6	
	xmax=xmin+xinc*(nx-1)
	WaveStats/Q Spinfile
	Imin0=V_min;  Imax0=V_max
	string info="x: "+num2istr(nx)+", "+num2str(xmin)+", "+num2str(xinc)+", "+num2str(xmax)
	info+="\r z: "+num2str(Imin0)+", "+num2str(Imax0)
	setdatafolder curr1
	return info
End

Function removenan(destwave)
//To replace the N/A points with zero in destwave and return the number of replaced points.
wave destwave
string curr1=getdatafolder(1)
variable ipointlim,ipoint,nanpoint=0
   ipointlim=dimsize(destwave,0)
         ipoint=0
         do
           if(cmpstr(num2str(destwave[ipoint]),"NaN")==0)
              destwave[ipoint]=0
              nanpoint+=1
           else
           endif
           ipoint+=1
          while(ipoint<ipointlim)
          setdatafolder curr1
          return nanpoint
end

Function copyscale1D(tarwave,destwave)
//Copy the scale of tarwave to that of destwave
wave tarwave, destwave
variable xmin, xinc, nx,xmax
xmin=dimoffset(tarwave,0)
xinc=round(DimDelta(tarwave,0) * 1E6) / 1E6	
nx=dimsize(tarwave,0)
xmax=xmin+xinc*(nx-1)

setscale/p x, xmin, xinc, "", destwave

end


Function/T ReadSESSpinhdr(fpath, fname)
//=================
//This Function is modified by G.-H. Gweon
// read SES binary file header (actually ASCII text at the end)
// saves values in root:SES folder variables
	string fpath, fname
	variable debug=0			// programming flag
	Variable file
	pauseupdate;silent 1
	string curr=getdatafolder(1)
	SetDataFolder root:Spin:Loadpara
	
	String/G Sfilname=fname, Sfilpath=fpath
	
	variable/G nregion=1	
	//variable/G kind
	variable/G vstart=0, vinc=1, nslice=1
	string/G skind
	string/G sheader=""
	string sline		//, sheader
	Open/R file as Sfilpath+Sfilname
		FStatus file
			if (debug)
				print  S_Filename, ", numbytes=", V_logEOF
			endif
			
		// -- get number of regions
		FReadLine file, sline
		if (strsearch(sline, "[Info]",0)>=0)
			FReadLine file, sline
			//print StringByKey( "Number of Regions", sline[0,strlen(sline)-1], "=")
			nregion=str2num( StringByKey( "Number of Regions", sline, "=" ) )  //[0,strlen(sline)-2]
		else
			nregion=1
		endif
		
	
	// ----- Read region info from [REGION #] blocks  -------
	//, iEp, Epass, mode
	//variable/G estart, eend, estep, dwell, nsweep
	variable/G hv_
	make/o/T/n=10 smode
	make/o/n=10 iEp, Epass, mode, estart, eend, estep, dwell, nsweep, enpts
	WAVE/T smode=smode
	WAVE iEp=iEp, mode=mode, estart=estart, eend=eend, estep=estep, dwell=dwell, nsweep=nsweep, enpts=enpts
	WAVE Astart=Astart, Aend=Aend	
	
	
	// Jump to near the end & then search for text
		// GHG edit, Oct 7, 2002, starts
		// FSetPos file, V_logEOF-500
		FSetPos file, 0
		// GHG edit, Oct 7, 2002, ends
		
		variable ii=0, val
		DO
			//-- find Region ii+1 start
		 	variable jj=0
			 DO
				FReadLine file, sline
				//if (strsearch(sline, "[Region "+num2str(ii+1)+"]",0)>=0)
				if (strsearch(sline, "[SES]",0)>=0) //Change "Location=" to "[SES]" by shaolong 12Dec. 2010
					//print "r", jj, sline
					break
				endif
				//print "r", jj, sline
				jj+=1
			// GHG edit, Oct 7, 2002, starts
			// WHILE(jj<1000)
			WHILE(jj<50000)
			// Error handling needed here?
			// GHG edit, Oct 7, 2002, ends
			//FStatus file
			//print V_logEOF, V_FilePos, V_logEOF-V_FilePos
			
			//-- load header lines into string
			 jj=0
			 // GHG edit, Oct 7, 2002, starts
			 sheader = ""
			 // GHG edit, Oct 7, 2002, ends
			 DO
				FReadLine file, sline
				// GHG edit, Oct 7, 2002, starts
				if (strlen (sline) == 0)
					break
				else
				//----------------------add by shaolong 12Dec.2010,start
				    if(jj>30)
				       break
				    endif
				//------------------------Add by shaolong, ends
				endif
				// GHG edit, Oct 7, 2002, ends
				//print jj, sline[0,strlen(sline)-2]
				sheader+=sline[0,strlen(sline)-2]+";"
				jj+=1
			// GHG edit, Oct 7, 2002, starts
			// WHILE(jj<24)
			while (1)
			// GHG edit, Oct 7, 2002, ends
			//print sheader
			
			//-- extract variables from header keyword list
			smode[ii]=StringByKey("Aquisition Mode", sheader, "=")
			skind=StringByKey("Lens Mode", sheader, "=")
			skind=SelectString( stringmatch( skind[0], "T"), skind, "Trans")
			estart[ii]=str2num( StringByKey("Low Energy", sheader, "=") )
			eend[ii]=str2num( StringByKey("High Energy", sheader, "=") )
			estep[ii]=str2num( StringByKey("Energy Step", sheader, "=") )*sign(eend[ii]-estart[ii])
			nsweep[ii]=str2num( StringByKey("Number of Sweeps", sheader, "=") )
			dwell[ii]=str2num( StringByKey("Step Time", sheader, "=") )	//*nsweep[ii]
			Astart[ii]=str2num( StringByKey("Detector First Y-Channel", sheader, "=") )
			Aend[ii]=str2num( StringByKey("Detector Last Y-Channel", sheader, "=") )
			Epass[ii]=str2num( StringByKey("Pass Energy", sheader, "=") )
			nslice=str2num( StringByKey("Number of Slices", sheader, "=") )
			hv_=str2num( StringByKey("Excitation Energy", sheader, "=") )
			
			enpts[ii]=round((eend[ii]-estart[ii])/estep[ii]+1)
			//smode[ii]=StrFromList("Fixed;Swept;Stepped", mode[ii], ";")
				if (debug)
					print ii,": E: start, stop, step, Np, dwell, nsweep, mode, Ep=", estart[ii], eend[ii], estep[ii], enpts[ii], dwell[ii], nsweep[ii], smode[ii], Epass[ii]
				endif
			ii+=1
		WHILE(ii<nregion)
	Close file
	string/G smode0=smode[0]
	//abort
	
	variable/G  iflux=0
	
	//--- write info wave
	if (nregion>1)
		make/T/o/n=(18,nregion) infowav
	else
		make/T/o/n=(18) infowav
	endif
	//infowav={filnam, skind, smode,"hv","slits","Polar",num2str(Ep),"Slit#",num2tr(Estart)
	//string/G smode0=smode[0]
	ii=0
	DO
		infowav[0][ii]=Sfilname[0,strlen(Sfilname)-5]
		infowav[1][ii]=skind; infowav[2][ii]=smode[ii]
		infowav[3][ii]=num2str(hv_); infowav[4][ii]="R.P."; infowav[5][ii]="Polar"
		infowav[6][ii]=num2str(Epass[ii]); infowav[7][ii]="Slit#"
		infowav[8][ii]=num2str(Estart[ii]); infowav[9][ii]=num2str(Eend[ii]); infowav[10][ii]=num2str(Estep[ii])
		infowav[11][ii]=num2str(1E-3*round(1E3*dwell[ii])); infowav[12][ii]=num2str(nsweep[ii])
		infowav[13][ii]="Temp"
		infowav[14][ii]=num2str(Astart[ii]); infowav[15][ii]=num2str(Aend[ii]); infowav[16][ii]=num2str(nslice)
		infowav[17][ii]=StringFromList(iflux,"no;yes",";")		//num2str(iflux)
		ii+=1
	WHILE(ii<nregion)
	
	SetDataFolder curr
	return Sfilname
End

Function/T GetPolalist(curr)
string curr
string Polalist,Polalisttmp,filenametmp,filenametmp1,filenametmp2,fileiD,Polaname,Polafilelist=""
variable i,filenum,j
setdatafolder $curr
Polalist=wavelist("*F*O*P*T*I*P*",";","DIMS:1")
    filenum=Itemsinlist(Polalist,";")
   
    i=0
    Do
    Polalisttmp=Stringfromlist(i,Polalist,";") //Stop here20111109
    if(stringmatch(Polalisttmp,"*Up")==1)
    Else
       filenametmp1=stringfromlist(0,Polalisttmp,"I")
       Filenametmp2=stringbykey(filenametmp1,Polalisttmp,"I")
       fileID=stringfromlist(0,filenametmp2,"P")
       filenametmp=filenametmp1+"I"+fileID
       j=Itemsinlist(Polafilelist,";")
       Polaname=stringfromlist(j-1,Polafilelist,";")
   
       if(cmpstr(filenametmp,Polaname)==0)
    
       Else
         Polafilelist=Polafilelist+Filenametmp+";"
       Endif
    
    Endif
    i=i+1
    while(i<filenum)
    //print Spinfilelist
    //
return Polafilelist   
End



Proc DisplayPolarizedFile(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string curr
   
//start here display Polarizedfile
    String GraphName, TopGraphname,spinfilename,Px,PDx,Py,PDy,Pz,PDz
    Variable Leftmin,Leftmax,Left1min,Left1max
    setdatafolder root:spin:ProcessedSFile
    curr=getdatafolder(1)
        
    
    GraphName="Polarization"+popstr
  
	 //spinfilename=popstr
	 
     
     DoWindow $Graphname
	             if(V_flag==0)
           	           Display as Graphname
           	           Topgraphname=winname(0,1)
           	           DoWindow/F $Topgraphname
           	           
           	           DoWindow/C $Graphname
           	 
           	 
           	       // string checklist=wavelist("*O*P*T*I*S*C*",";","DIMS:1")
		           // string chfile=stringbyKey(popstr,checklist,"C")
		            //variable chnum=str2num(chfile)
		           // if(chnum>4)
		           // chnum=4
		           // else
		           // chnum=0
		           // Endif
	              
	              Px=Popstr+"Px"
	              if (strsearch(Polawavelist,Px,0)==-1)
	              Else
	                  Appendtograph $Px
	                  
	                  if(wavemin($Px)<leftmin)
	                     leftmin=wavemin($Px)
	                  Else
	                  Endif
	                  
	                  if(wavemax($Px)>leftmax)
	                     leftmax=wavemax($Px)
	                  Else
	                  Endif
	                  
	              Endif
	              
	              Py=Popstr+"Py"
	              if (strsearch(Polawavelist,Py,0)==-1)
	              Else
	                  Appendtograph $Py
	                  ModifyGraph rgb($Py)=(0,15872,65280)//change colour to blue
	                   if(wavemin($Py)<leftmin)
	                     leftmin=wavemin($Py)
	                  Else
	                  Endif
	                  
	                  if(wavemax($Py)>leftmax)
	                     leftmax=wavemax($Py)
	                  Else
	                  Endif
	              Endif
	              
	              Pz=Popstr+"Pz"
	              if (strsearch(Polawavelist,pz,0)==-1)
	              Else
	                  Appendtograph $Pz
	                  ModifyGraph rgb($Pz)=(0,0,0)
	                   if(wavemin($Pz)<leftmin)
	                     leftmin=wavemin($Pz)
	                  Else
	                  Endif
	                  
	                  if(wavemax($Pz)>leftmax)
	                     leftmax=wavemax($Pz)
	                  Else
	                  Endif
	                  
	              Endif
	              
	              ModifyGraph axisEnab(Left)={0,0.5}
		          ModifyGraph mirror(left)=2
		          
		          if(abs(leftmax)>1)
		             leftmax=1
		          else
		          Endif
		          
		          If(abs(leftmin)>1)
		             leftmin=-1
		          Else
		          Endif
		          setAxis left 1.2*leftmin, 1.2*leftmax
		          ModifyGraph zero(left)=1,zeroThick(left)=1.5
		          //TextBox/C/N=text1 "P"
	              
	               PDx=Popstr+"PDx"
	              if (strsearch(Polawavelist,PDx,0)==-1)
	              Else
	                  AppendToGraph/L=left1/B=Bottom1 $PDx
	                   if(wavemin($PDx)<left1min)
	                     left1min=wavemin($PDx)
	                  Else
	                  Endif
	                  
	                  if(wavemax($PDx)>left1max)
	                     left1max=wavemax($PDx)
	                  Else
	                  Endif
	              Endif
	              
	              PDy=Popstr+"PDy"
	              if (strsearch(Polawavelist,PDy,0)==-1)
	              Else
	                  AppendToGraph/L=left1/B=Bottom1 $PDy
	                   ModifyGraph rgb($PDy)=(0,15872,65280)
	                   if(wavemin($Py)<left1min)
	                     left1min=wavemin($Py)
	                  Else
	                  Endif
	                  
	                  if(wavemax($PDy)>left1max)
	                     left1max=wavemax($PDy)
	                     
	                  Else
	                  Endif
	              Endif
	              
	              PDz=Popstr+"PDz"
	              if (strsearch(Polawavelist,pz,0)==-1)
	              Else
	                   AppendToGraph/L=left1/B=Bottom1 $PDz
	                    ModifyGraph rgb($PDz)=(0,0,0)
	                    if(wavemin($Pz)<left1min)
	                     left1min=wavemin($Pz)
	                  Else
	                  Endif
	                  
	                  if(wavemax($Pz)>left1max)
	                     left1max=wavemax($Pz)
	                  Else
	                  Endif
	              Endif
	              
		        	
		          
		          ModifyGraph axisEnab(Left1)={0.5,1}
		          ModifyGraph freepos(Left1)=0
		          ModifyGraph freepos(Bottom1)={0.5,kwFraction}
		          ModifyGraph mirror(left1)=2,mirror(Bottom1)=2
				  label left "Polarization"
				  label bottom "Kinetic Energy(eV)"
				  ModifyGraph tickUnit(bottom)=1
				  ModifyGraph tick(Bottom1)=3
		          ModifyGraph noLabel(Bottom1)=2
		          	          
		          if(abs(left1max)>1)
		             left1max=1
		          else
		          Endif
		          
		          If(abs(left1min)>1)
		             left1min=-1
		          Else
		          Endif
		       
		          ModifyGraph zero(left1)=1,zeroThick(left1)=1.5
		          
		          SetAxis left1 1.2*Left1min,1.2*left1max
		         // ModifyGraph nolabel(Left1)=2, tick(left1)=3
				  TextBox/C/N=text0 "PD"
				  legend //put lengend
				  modifygraph lsize=2
				 
         
 			      else
	                   DoWindow/F $Graphname
	        	  endif
	
		SetDataFolder Curr
End  



Function/T GetSpinEDClist(curr)
string curr
string SpinEDClist,SEDClisttmp,filenametmp,filenametmp1,filenametmp2,fileiD,SEDCname,SpinResFile=""
variable i,filenum,j
setdatafolder $curr
SpinEDClist=wavelist("*F*O*P*T*I*I*",";","DIMS:1")
    filenum=Itemsinlist(SpinEDClist,";")
   
    i=0
    Do
    SEDClisttmp=Stringfromlist(i,SpinEDClist,";")
   
   // if(stringmatch(Polalisttmp,"*Up")==1)
   // Else
       filenametmp=stringfromlist(0,SEDClisttmp,"I")+"I"+stringfromlist(1,SEDClisttmp,"I")
       //Filenametmp2=stringbykey(filenametmp1,Polalisttmp,"I")
       //fileID=stringfromlist(0,filenametmp2,"P")
       //filenametmp=filenametmp1+"I"+fileID
       j=Itemsinlist(SpinResfile,";")
       SEDCname=stringfromlist(j-1,SpinResfile,";")
   
       if(cmpstr(filenametmp,SEDCname)==0)
    
       Else
         SpinResFile=SpinResfile+Filenametmp+";"
       Endif
    
    //Endif
    i=i+1
    while(i<filenum)
    //print Spinfilelist
    //
return SpinResfile  
End



Proc DisplaySpinEDCFile(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string curr
   

    String GraphName, TopGraphname,spinfilename,IxUp,IxDown,Ixtotal,IyUp,IyDown,Iytotal,IzUp,IzDown,Iztotal
    Variable Leftmin,Leftmax,Left1min,Left1max,Left2min,Left2max
    setdatafolder root:spin:ProcessedSFile
    curr=getdatafolder(1)
        
    
    GraphName="SpinResolved"+popstr

	 
     
     DoWindow $Graphname
	             if(V_flag==0)
           	           Display as Graphname
           	           Topgraphname=winname(0,1)
           	           DoWindow/F $Topgraphname
           	           
           	           DoWindow/C $Graphname
           	 
           	              
	              IxUp=Popstr+"IxUp"
	              Ixtotal=Popstr+"Ixt"
	              if (strsearch(SpinEDClist,IxUp,0)==-1)
	                  Appendtograph Px
	              Else
	                  Appendtograph $IxUP
	                    ModifyGraph rgb($IxUp)=(0,15872,65280)
	                  
	                  
	                  if(wavemin($IxUp)<leftmin)
	                     leftmin=wavemin($IxUP)
	                  Else
	                  Endif
	                  
	                  if(wavemax($IxUp)>leftmax)
	                     leftmax=wavemax($IxUp)
	                  Else
	                  Endif
	                  
	                  duplicate/O $IxUp $Ixtotal//Gernerate Ixtotal
	                  
	              Endif

                      IxDown=Popstr+"IxDown"
	              if (strsearch(SpinEDClist,IxDown,0)==-1)
	              Else
	                  AppendToGraph $IxDown
	                   if(wavemin($IxDown)<leftmin)
	                     leftmin=wavemin($IxDown)
	                  Else
	                  Endif
	                  
	                  if(wavemax($IxDown)>leftmax)
	                     leftmax=wavemax($IxDown)
	                  Else
	                  Endif
	                  
	                  
	                  $(Ixtotal)=($(Ixtotal))+($(IxDown))
	                  AppendToGraph $Ixtotal
	                  Modifygraph rgb($Ixtotal)=(0,0,0)
	                   if(wavemin($Ixtotal)<leftmin)
	                     leftmin=wavemin($Ixtotal)
	                  Else
	                  Endif
	                  
	                  if(wavemax($Ixtotal)>leftmax)
	                     leftmax=wavemax($Ixtotal)
	                  Else
	                  Endif
	                  
	              Endif
//Modify the Ix graph No.1
              ModifyGraph axisEnab(Left)={0,0.32}
		      ModifyGraph mirror(left)=2
		      ModifyGraph tick(left)=3
		      label left "Intensities(arb.unit)"
	          label bottom "Kinetic Energy(eV)"
	          ModifyGraph noLabel(left)=1
		       ModifyGraph tickUnit(bottom)=1
		      setAxis left 1.2*leftmin, 1.2*leftmax
		       

	              
	              IyUp=Popstr+"IyUp"
	              Iytotal=Popstr+"Iyt"
	              if (strsearch(SpinEDClist,IyUp,0)==-1)
	                
	              Else
	                  Appendtograph/L=left1/B=Bottom1 $IyUp
	                  ModifyGraph rgb($IyUp)=(0,15872,65280)//change colour to blue
	                   if(wavemin($IyUp)<left1min)
	                     left1min=wavemin($IyUp)
	                  Else
	                  Endif
	                  
	                  if(wavemax($IyUp)>left1max)
	                     left1max=wavemax($IyUp)
	                  Else
	                  Endif
	                  duplicate/O $IyUp $Iytotal
	              Endif
	              
                      IyDown=Popstr+"IyDown"
	              if (strsearch(SpinEDClist,IyDown,0)==-1)
	              Else
	                  AppendToGraph/L=left1/B=Bottom1 $IyDown
	                   
	                   if(wavemin($IyDown)<left1min)
	                     left1min=wavemin($IyDown)
	                  Else
	                  Endif
	                  
	                  if(wavemax($IyDown)>left1max)
	                     left1max=wavemax($IyDown)
	                     
	                  Else
	                  Endif
	                  
	                   
	                  $(Iytotal)=($(Iytotal))+($(IyDown))
	                  AppendToGraph/L=Left1/B=Bottom1 $Iytotal
	                  Modifygraph rgb($Iytotal)=(0,0,0)
	                   if(wavemin($Iytotal)<left1min)
	                     left1min=wavemin($Iytotal)
	                  Else
	                  Endif
	                  
	                  if(wavemax($Iytotal)>left1max)
	                     left1max=wavemax($Iytotal)
	                  Else
	                  Endif
	              Endif

             
                        
		       ModifyGraph axisEnab(Left1)={0.33,0.65}
		       ModifyGraph freepos(Left1)=0
		       ModifyGraph freepos(Bottom1)={0.33,kwFraction}
		       ModifyGraph mirror(left1)=2,mirror(Bottom1)=2
	            
	               ModifyGraph tick(Bottom1)=3
		       ModifyGraph noLabel(Bottom1)=2
		       ModifyGraph tick(left1)=3,noLabel(left1)=2
                       setAxis left1 1.2*left1min, 1.2*left1max

	              IzUp=Popstr+"IzUp"
	              Iztotal=popstr+"Izt"
	              if (strsearch(SpinEDClist,IzUp,0)==-1)
	                   Appendtograph/L=left2/B=Bottom2 Pz
	              Else
	                  Appendtograph/L=left2/B=Bottom2 $IzUp
	                   ModifyGraph rgb($IzUp)=(0,15872,65280)
	                   if(wavemin($IzUp)<left2min)
	                     left2min=wavemin($IzUp)
	                  Else
	                  Endif
	                  
	                  if(wavemax($IzUp)>left2max)
	                     left2max=wavemax($IzUp)
	                  Else
	                  Endif
	                  
	                  duplicate/O $Izup $Iztotal
	                  
	              Endif
	              
                      IzDown=Popstr+"IzDown"
	              if (strsearch(SpinEDClist,IzUp,0)==-1)
	              Else
	                   AppendToGraph/L=left2/B=Bottom2 $IzDown
	                   
	                    if(wavemin($IzDown)<left2min)
	                     left2min=wavemin($IzDown)
	                  Else
	                  Endif
	                  
	                  if(wavemax($IzDown)>left2max)
	                     left2max=wavemax($IzDown)
	                  Else
	                  Endif
	                  
	                   
	                  $(Iztotal)=($(Iztotal))+($(IzDown))
	                  AppendToGraph/L=Left2/B=Bottom2 $Iztotal
	                  Modifygraph rgb($Iztotal)=(0,0,0)
	                   if(wavemin($Iztotal)<left2min)
	                     left2min=wavemin($Iztotal)
	                  Else
	                  Endif
	                  
	                  if(wavemax($Iztotal)>left2max)
	                     left2max=wavemax($Iztotal)
	                  Else
	                  Endif
	              Endif

	//Modify Iz graph(No.3)
		          
		          ModifyGraph axisEnab(Left2)={0.66,1}
		          ModifyGraph freepos(Left2)=0
		          ModifyGraph freepos(Bottom2)={0.66,kwFraction}
		          ModifyGraph mirror(left2)=2,mirror(Bottom2)=2
				  label left2 "Intensities(arb.unit)"
				  label bottom2 "Kinetic Energy(eV)"
				  ModifyGraph tickUnit(bottom2)=1
				  ModifyGraph tick(Bottom2)=3
		          ModifyGraph noLabel(Bottom2)=2
		         ModifyGraph tick(left2)=3,noLabel(left2)=2
		          
		          
		          SetAxis left2 1.2*Left2min,1.2*left2max
		        
				 ModifyGraph lsize=2//Set all  the linesize to 2
				 Legend //put lengend
         
 			      else
	                   DoWindow/F $Graphname
	        	  endif
	
		SetDataFolder Curr
End  
#pragma rtGlobals=1		// Use modern global access method.
proc SYMT()
        String Curr=GetDataFolder(1)
        DoWindow/F SymmFor1dimension
        if (V_flag==0)
	newdatafolder/S/O root:Process1D
	Variable/G A,G,D,B,alfa,Gflag,Es,En,Efull,C
	variable/G root:Process1D:Org:proc_flag
	String/G symf_name
	newdatafolder/S/O root:Process1D:Org
         String/G filenamelists_Org
	newdatafolder/S/O root:Process1D:Processed
         Variable/G Ef
	Variable/G Norstart
	Variable/G Norend
	String/G filenamelists_Pro
	Variable/G nor
	newdatafolder/S/O root:Process1D:Symmetrized
	Variable/G Estep
//	newdatafolder/S/O root:Process1D:Symmetrized:SymAfterNor
	String/G filenamelists_SAN
//        newdatafolder/S/O root:Process1D:Symmetrized:NorAfterSym
    String/G filenamelists_NAS
    newdatafolder/S/O root:Process1D:SubsDivid
    Variable/G Estrt
    Variable/G Eend
    String/G bis
    Variable/G num_smth
//	setdatafolder root:procc 
//	Dowindow/F SymmFor1dimension
//	if(V_flag==0)
	SymmFor1dimension()
	endif
	SetDataFolder Curr
end
	
Window SymmFor1dimension() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(930,305,1410,825) as "SymmFor1dimension"
	SetDrawLayer UserBack
	DrawText 240,245,"N(E)=A*Re((E+iG)/sqrt((E+iG)^2-D^2))+B*E+C"
	SetVariable Ah,pos={255,250},size={80,15},title="A"
	SetVariable Ah,limits={-inf,inf,0.01},value= root:Process1D:A
	SetVariable Gam,pos={355,250},size={100,15},title="G_eV"
	SetVariable Gam,limits={-inf,inf,0.0001},value= root:Process1D:G
	SetVariable Delt,pos={355,270},size={100,15},title="D_eV"
	SetVariable Delt,limits={-inf,inf,0.0001},value= root:Process1D:D
	SetVariable Bac,pos={255,270},size={80,15},title="B"
	SetVariable Bac,limits={-inf,inf,0.0001},value= root:Process1D:B
	SetVariable alf,pos={245,290},size={85,15},title="alfa"
	SetVariable alf,limits={-inf,inf,0.0001},value= root:Process1D:alfa
	SetVariable Gflag,pos={335,290},size={128,15},title="G:0_con,1_alfa*E"
	SetVariable Gflag,limits={0,1,1},value= root:Process1D:Gflag
	Button fitsymb,pos={255,328},size={50,20},proc=fitsymf,title="fit"
	Button calsymb,pos={310,328},size={50,20},proc=calsymf,title="calc"
	SetVariable Esf,pos={370,310},size={90,15},title="Es_eV"
	SetVariable Esf,limits={-inf,inf,0.001},value= root:Process1D:Es
	SetVariable Enf,pos={370,330},size={90,15},title="En_eV"
	SetVariable Enf,limits={-inf,inf,0.001},value= root:Process1D:En
	SetVariable Efb,pos={250,310},size={115,15},title="E:0_full,1_man"
	SetVariable Efb,limits={0,1,1},value= root:Process1D:Efull
	SetVariable Cf,pos={190,250},size={60,15},title="C"
	SetVariable Cf,limits={-inf,inf,0.01},value= root:Process1D:C
	GroupBox LoadPanel,pos={10,2},size={210,100},title="LoadData"
	Button LoadData,pos={129,26},size={80,20},proc=LoadData1,title="SetTable"
	GroupBox ProcessPanel,pos={10,104},size={210,114},title="Process"
	SetVariable Ef1,pos={123,124},size={80,15},title="Ef"
	SetVariable Ef1,limits={-inf,inf,0.001},value= root:Process1D:Processed:Ef
	SetVariable Er,pos={105,250},size={80,15},title="ErmeV"
	SetVariable Er,limits={0,inf,0.1},value= root:Process1D:Symmetrized:Estep
	SetVariable Norstart,pos={99,147},size={104,15},title="Norstart"
	SetVariable Norstart,limits={-inf,inf,0.1},value= root:Process1D:Processed:Norstart
	SetVariable Norend,pos={102,169},size={101,15},title="Norend"
	SetVariable Norend,limits={-inf,inf,0.1},value= root:Process1D:Processed:Norend
	Button Process,pos={15,123},size={80,20},proc=Process1,title="Process"
	Button Symm,pos={15,240},size={80,20},proc=Symmetrize1,title="Symmetrize"
	GroupBox SymPanel,pos={10,217},size={460,135},title="Symmetrize"
	PopupMenu Orgfiles,pos={12,63},size={203,20},proc=Org_display,title="Orgfiles"
	PopupMenu Orgfiles,mode=7,bodyWidth= 150,popvalue="T55",value= #"root:Process1D:Org:filenamelists_Org"
	PopupMenu Profiles,pos={12,190},size={203,20},proc=Pro_display,title="ProFiles"
	PopupMenu Profiles,mode=12,bodyWidth= 150,popvalue="NT100",value= #"root:Process1D:Processed:filenamelists_Pro"
	PopupMenu SymAfterNor,pos={14,280},size={201,20},proc=N_display,title="SymAfterNor"
	PopupMenu SymAfterNor,mode=1,bodyWidth= 130,popvalue="-none-",value= #"root:Process1D:Symmetrized:filenamelists_SAN"
	PopupMenu NorAfterSym,pos={14,310},size={201,20},proc=N_display,title="NorAfterSym"
	PopupMenu NorAfterSym,mode=1,bodyWidth= 130,popvalue="-none-",value= #"root:Process1D:Symmetrized:filenamelists_NAS"
	CheckBox normode,pos={15,170},size={78,14},proc=norc,title="Normalize?",value= 0
	GroupBox SDPanel,pos={10,350},size={210,150},title="Substitract&Divide"
	PopupMenu SDbis,pos={26,410},size={189,20},proc=SelectSDbis,title="1. SD_Bis"
	PopupMenu SDbis,mode=12,bodyWidth= 130,popvalue="NT100",value= #"root:Process1D:SubsDivid:expand_list"
	PopupMenu Substitute,pos={8,435},size={207,20},proc=Substitute,title="2. Substract"
	PopupMenu Substitute,mode=12,bodyWidth= 130,popvalue="NT100GX",value= #"root:Process1D:SubsDivid:filenamelist"
	PopupMenu Dividing,pos={14,463},size={201,20},proc=Dividing,title="3. Dividing"
	PopupMenu Dividing,mode=12,bodyWidth= 130,popvalue="NT100",value= #"root:Process1D:SubsDivid:filenamelist"
	Button copydata,pos={28,373},size={60,20},proc=copydata,title="copydata"
	SetVariable num_smooth,pos={92,377},size={120,15},title="num_smooth"
	SetVariable num_smooth,value= root:Process1D:SubsDivid:num_smth
	SetVariable proc_flat,pos={22,149},size={60,15},title="flag"
	SetVariable proc_flat,value= root:Process1D:Org:proc_flag
	Button divide,pos={225,468},size={50,20},proc=ButtonProc,title="devide"
	Button subtract,pos={225,443},size={50,20},proc=subtract,title="subtract"
	Button loaddata1,pos={23,24},size={81,21},proc=loaddata2,title="loaddata"
EndMacro

Proc SelectSDbis(ctrlName,popNum,popStr) : PopupMenuControl
    String ctrlName
	Variable popNum
	String popStr
	Setdatafolder root:Process1D:SubsDivid
	bis="B"+popStr+"_smth"
	Duplicate/O $popStr, $bis
	if(num_smth>0)
	Smooth num_smth, $bis 
	endif  
//	print num_smth 
	Display/K=1 $bis
	 Legend/C/N=text0/A=MC
	 AppendText "smooth num="+num2str(num_smth)
End

Proc Substitute(ctrlName,popNum,popStr) : PopupMenuControl
    String ctrlName
	Variable popNum
	String popStr
//	Display root:Process1D:Symmetrized:$popStr
    Setdatafolder root:Process1D:SubsDivid
    String newSu
    newSu="S"+popStr
    Duplicate/O $popStr, $newSu
    $newSu-=$bis
    Display/K=1 $newSu
    Legend/C/N=text0/A=MC
//    print SDbis   
End

proc subtract(ctrlName) : ButtonControl
	String ctrlName
	 Setdatafolder root:Process1D:SubsDivid
    String newDv,orgfile
    variable tot,ii=0
    display/K=1
    tot=itemsinlist(filenamelist)
    ii=0
    do
    orgfile=stringfromlist(ii,filenamelist)
    newDv="S"+orgfile
    Duplicate/O $orgfile, $newDv
    $newDv-=$bis
    appendtograph $newDv
    Legend/C/N=text0/A=MC
    ii+=1
    while(ii<tot)
End


Proc Dividing(ctrlName,popNum,popStr) : PopupMenuControl
    String ctrlName
	Variable popNum
	String popStr
//	Display root:Process1D:Symmetrized:$popStr
    Setdatafolder root:Process1D:SubsDivid
    String newDv
    newDv="D"+popStr
    Duplicate/O $popStr, $newDv
    $newDv/=$bis
    Display/K=1 $newDv
    Legend/C/N=text0/A=MC
//    print SDbis   
End

proc ButtonProc(ctrlName) : ButtonControl
	String ctrlName

//	Display root:Process1D:Symmetrized:$popStr
    Setdatafolder root:Process1D:SubsDivid
    String newDv,orgfile
    variable tot,ii=0
    display/K=1
    tot=itemsinlist(filenamelist)
    ii=0
    do
    orgfile=stringfromlist(ii,filenamelist)
    newDv="D"+orgfile
    Duplicate/O $orgfile, $newDv
    $newDv/=$bis
    appendtograph $newDv
    Legend/C/N=text0/A=MC
    ii+=1
    while(ii<tot)
//    print SDbis   
End

Function norc (ctrlName,checked) : CheckBoxControl
	String ctrlName
    Variable checked			// 1 if selelcted, 0 if not
	setdatafolder root:Process1D:Processed
	NVAR nor
	if(checked==1)
	nor=1
	else 
	nor=0
	endif
End

Proc LoadData1(ctrlName) : ButtonControl
	String ctrlName
	variable numberoffiles,ii
	root:Process1D:Org:filenamelists_Org=wavelist("*",";","DIMS:1")
   Refreshpop()
   setdatafolder root:Process1D:Org
   numberoffiles=itemsinlist(filenamelists_Org)
   
   make/O/N=(numberoffiles) proc_flags 
   make/O/T/N=(numberoffiles)  OriginalFile
   ii=0
   do
   		OriginalFile[ii]=stringfromlist(ii,filenamelists_Org)
   		ii+=1
   	while(ii<numberoffiles)
   	edit OriginalFile,proc_flags
End

proc loaddata2(ctrlName) : ButtonControl
	String ctrlName
	string curr
	string filenamelist,tmp,tobecopy
	variable ii,tot,rowsnum,collumnum,jj,lentgh,xmin,xinc
	curr=getdatafolder(1)
	setdatafolder root:PROCESS
	filenamelist=wavelist("F*",";","DIMS:2")
	tot=itemsinlist(filenamelist)
	ii=0
	tmp=stringfromlist(ii,filenamelist)
	rowsnum=dimsize($tmp,0)
	collumnum=dimsize($tmp,1)
	xmin=dimoffset($tmp,0)
	xinc=dimdelta($tmp,0)
	make/O/N=(rowsnum) tmpwave
	do
		tmpwave=0
		tmp=stringfromlist(ii,filenamelist)
		iterate( collumnum )
			tmpwave+=$tmp[p][i]
		loop
		//tmp=stringfromlist(ii,filenamelist)
		//jj=0
		//do
			//tmpwave[jj]=tmpwave[jj]+$tmp[jj][p]
		//jj=jj+1
		//while(jj<rowsnum)
		tmpwave/=collumnum
		lentgh=strlen(tmp)
		tobecopy="T"+tmp[3,lentgh]
		setscale/P x xmin,xinc,tmpwave
		duplicate/O tmpwave root:Process1D:Org:$tobecopy
		ii+=1
	while(ii<tot)
	setdatafolder(curr)		
End


Proc Org_display(ctrlName,popNum,popStr) : PopupMenuControl
         String ctrlName
	Variable popNum
	String popStr
	
	Setdatafolder root:Process1D:Org
	display $popStr
         Legend/C/N=text0/A=MC
         Label bottom "eV"
         Label left "Counts"
End

Proc Process1(ctrlName) : ButtonControl
	String ctrlName
	Variable ifinder2, list2,pmin,pinc,flag
	String Org_name, Pro_name
	Setdatafolder root:Process1D:Org
	root:Process1D:Org:filenamelists_Org=wavelist("T*",";","DIMS:1")
	list2=ItemsInList( root:Process1D:Org:filenamelists_Org, ";")
	ifinder2=0
	Setdatafolder root:Process1D:Processed
	filenamelists_Pro=""
Do
     if(root:Process1D:Org:proc_flags[ifinder2]==root:Process1D:Org:proc_flag)
        Org_name=StringFromList(ifinder2, root:Process1D:Org:filenamelists_Org)
        Pro_name="N"+Org_name
		Duplicate/O root:Process1D:Org:$Org_name, root:Process1D:Processed:$Pro_name
        	pmin=DimOffset($Pro_name,0)-Ef
    	pinc=round(DimDelta($Pro_name,0) * 1E6) / 1E6	
    	Setscale/P x,pmin,pinc,root:Process1D:Processed:$Pro_name    	
    	If(root:Process1D:Processed:nor==1)
    	$Pro_name /=mean(root:Process1D:Org:$Org_name,  Norstart, Norend )
    	endif
     	if(strlen(filenamelists_Pro)!=0)
     		filenamelists_Pro=filenamelists_Pro+";"+Pro_name
     	else
     		filenamelists_Pro=Pro_name
     	endif
     endif
    
    	ifinder2+=1
While(ifinder2<list2) 
//      filenamelists_Pro=wavelist("N*",";","DIMS:1")
//	PopupMenu Profiles, popvalue="-none",value=#"filenamelists_Pro"
        Refreshpop()
End

Proc Pro_display(ctrlName,popNum,popStr) : PopupMenuControl
         String ctrlName
	Variable popNum
	String popStr
	Setdatafolder root:Process1D:Processed
	display $popStr
         Legend/C/N=text0/A=MC
         Label bottom "eV"
         Label left "Arb ,units"
End


Proc N_display(ctrlName,popNum,popStr) : PopupMenuControl
         String ctrlName
	Variable popNum
	String popStr
//	Setdatafolder root:Process1D
    String win_name="S"+popStr
	root:Process1D:symf_name=popStr
//	Variable w0,w1,w2,w3
//	w0=root:Process1D:A
//	w1=root:Process1D:G
//	W2=root:Process1D:D
//	w3=root:Proca=$popStr
	Setdatafolder root:Process1D:Symmetrized
//	Make/O co_gamma={w0,w1,w2,w3}
        Dowindow $win_name
        if(V_flag==0)
		display $popStr// as popStr
	      Legend/C/N=text0/A=MC 
         Label bottom "eV"
         Label left "Arb ,units"
        Dowindow/C $win_name
        else 
        Dowindow/F $win_name
        Endif 
//    FuncFit Symfit1 co_gamma $popStr /D 
//        AppendText/N=text0 "gamma="+num2str(co_gamma[1]*1000)+" +/- " + num2str(W_sigma[1]*1000)
//        AppendText/N=text0 "Delta="+num2str(co_gamma[2]*1000)+" +/- " + num2str(W_sigma[2]*1000)+"meV"
         
         
End

//Function SetEf_proc(ctrlName,varNum,varStr,varName) : SetVariableControl
//	String ctrlName
//	Variable varNum
//	String varStr
//	String varName

//End

Proc Symmetrize1(ctrlName) : ButtonControl
	String ctrlName
	Variable ifinder3, list3,snmin,sninc,nmean
	String Org_name1, SAN_name, NAS_name
	Setdatafolder root:Process1D:Org
	root:Process1D:Org:filenamelists_Org=wavelist("T*",";","DIMS:1")
	list3=ItemsInList( root:Process1D:Org:filenamelists_Org, ";")
	ifinder3=0
	Setdatafolder root:Process1D:Symmetrized
//	KillWaves/A/Z
	//san
Do
        Org_name1=StringFromList(ifinder3, root:Process1D:Org:filenamelists_Org)
        SAN_name="SAN"+Org_name1
	Duplicate/O root:Process1D:Org:$Org_name1, $SAN_name
	nmean=mean($SAN_name,  root:Process1D:Processed:Norstart, root:Process1D:Processed:Norend)
        	$SAN_name /=nmean
        	snmin=DimOffset($SAN_name,0)-root:Process1D:Processed:Ef
    	sninc=round(DimDelta($SAN_name,0) * 1E6) / 1E6	
    	Setscale/P x,snmin,sninc,$SAN_name    	
    	SMTZ($SAN_name, 0)
//    	KillWaves/Z $SAN_name
    	Duplicate/O   EnWave,$SAN_name
    	ifinder3+=1
While(ifinder3<list3) 
//nas      
//     Setdatafolder root:Process1D:Symmetrized:NorAfterSym
     ifinder3=0
      Do
        Org_name1=StringFromList(ifinder3, root:Process1D:Org:filenamelists_Org)
        SAN_name="NAS"+Org_name1
	Duplicate/O root:Process1D:Org:$Org_name1, $SAN_name
//	$SAN_name /=mean(root:Process1D:Org:$Org_name1,  root:Process1D:Processed:Norstart, root:Process1D:Processed:Norend)
        	snmin=DimOffset($SAN_name,0)-root:Process1D:Processed:Ef
    	sninc=round(DimDelta($SAN_name,0) * 1E6) / 1E6	
    	Setscale/P x,snmin,sninc,$SAN_name    	
    	SMTZ($SAN_name, 0)
//    	KillWaves $SAN_name
    	Duplicate/O   EnWave,$SAN_name
    //	Rename   EnWave,$SAN_name
    	nmean=mean($SAN_name,  root:Process1D:Processed:Norstart-root:Process1D:Processed:Ef, root:Process1D:Processed:Norend-root:Process1D:Processed:Ef)
    	$SAN_name/=nmean
    	ifinder3+=1
While(ifinder3<list3) 
              KillWaves/Z EnWave, EnWaveR,EnWaveL,NWave1D,Wave1D_L
 //     filenamelists_NAS=wavelist("NAS*",";","DIMS:1")
 //     PopupMenu NorAfterSym, popvalue="-none",value=#"filenamelists_NAS"
//      setdatafolder root:Process1D:Symmetrized:SymAfterNor
//      filenamelists_SAN=wavelist("SAN*",";","DIMS:1")
//      PopupMenu SymAfterNor, popvalue="-none",value=#"filenamelists_SAN"
       Refreshpop()
End

Function SMTZ(Wave1D, SymmValue,)
Wave Wave1D
Variable  SymmValue
    NVar ErToler=root:Process1D:Symmetrized:Estep
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

Proc Refreshpop()
    Setdatafolder root:Process1D:Org
	filenamelists_Org=wavelist("T*",";","DIMS:1")
	Setdatafolder root:Process1D:Processed
	filenamelists_Pro=wavelist("N*",";","DIMS:1")
	Setdatafolder root:Process1D:Symmetrized
	filenamelists_NAS=wavelist("NAS*",";","DIMS:1")
    filenamelists_SAN=wavelist("SAN*",";","DIMS:1")
End	

Function Symfit1(w,x)

	//w[0]   normalized height
	//w[1]   gamma, constant ~delta
	//w[2]   delta
	//w[3]   background slop
	wave w; Variable x
//	variable w4
	NVAR C=root:Process1D:C
	if(C==0)
    return w[0]*abs(Real((x+w[1]*sqrt(-1))/sqrt((x+w[1]*sqrt(-1))^2-w[2]^2)))+w[3]*abs(x)
    else
	return w[0]*abs(Real((x+w[1]*sqrt(-1))/sqrt((x+w[1]*sqrt(-1))^2-w[2]^2)))+w[3]*abs(x)+W[4]
	endif
END

Function Symfit2(w,x)

	//w[0]   normalized height
	//w[1]   gamma=alfa*E
	//w[2]   delta
	//w[3]   background slop
	wave w; Variable x

	return w[0]*abs(Real((x*(1+w[1]*sqrt(-1)))/sqrt((x*(1+w[1]*sqrt(-1)))^2-w[2]^2)))+w[3]*abs(x)+w[4]
END

Proc fitsymf(ctrlName) : ButtonControl
	String ctrlName
//	Setdatafolder root:Process1D
    String win_name,wave_name//,wave_name1
	Variable w0,w1,w2,w3,w11,Es,En,Gf,Efull,w4
	w0=root:Process1D:A
	w1=root:Process1D:G
	w11=root:Process1D:alfa
	W2=root:Process1D:D
	w3=root:Process1D:B
	w4=root:Process1D:C
	Es=root:Process1D:Es
	En=root:Process1D:En
	Gf=root:Process1D:Gflag
	Efull=root:Process1D:Efull
	wave_name=root:Process1D:symf_name
	Setdatafolder root:Process1D:Symmetrized
	win_name="S"+wave_name
//	wave_name1="fit_"+wave_name
    
    Variable NX,Xmin,Xinc,Xmax
    NX=DimSize($wave_name, 0)
	Xmin=DimOffset($wave_name,0)
    Xinc=round(DimDelta($wave_name,0) * 1E6) / 1E6	
	Xmax=Xmin+(NX-1)*Xinc 
	
        Dowindow $win_name
        if(V_flag==0)
		  display $wave_name// as popStr
	      Legend/C/N=text0/A=MC 
          Label bottom "eV"
          Label left "Arb ,units"
          Dowindow/C $win_name
        else 
          Dowindow/F $win_name
        Endif 
        
        If(Gf==0)
          if(w4==0)
          Make/O co_gamma={w0,w1,w2,w3}
          else
    	  Make/O co_gamma={w0,w1,w2,w3,w4}
    	   endif
    	   if(Efull==0)
 //   	   Make/O/N=(NX) $wave_name1
    	   FuncFit /L=(NX) Symfit1 co_gamma $wave_name(Xmin,Xmax ) /D
    	   else
          FuncFit Symfit1 co_gamma $wave_name(Es,En ) /D
           Endif
//         AppendtoGraph "fit_"=$wave_name
          ModifyGraph rgb($"fit_"+wave_name)=(0,12800,52224)
         Textbox/K/N=text0
         Legend/C/N=text0/A=MC 
         AppendText/N=text0 "gamma="+num2str(co_gamma[1]*1000)+" +/- " + num2str(W_sigma[1]*1000)
         AppendText/N=text0 "Delta="+num2str(co_gamma[2]*1000)+" +/- " + num2str(W_sigma[2]*1000)+"meV"
      Endif
      If(Gf==1)  
       Make/O co_gamma={w0,w11,w2,w3,w4}
          if(Efull==0)
 //   	   Make/O/N=(NX) $wave_name1
    	   FuncFit /L=(NX) Symfit2 co_gamma $wave_name(Xmin, Xmax) /D
    	   else
          FuncFit Symfit2 co_gamma $wave_name(Es,En) /D
           Endif
       
//       AppendtoGraph "fit_"=$wave_name
         ModifyGraph rgb($"fit_"+wave_name)=(0,12800,52224)
         Textbox/K/N=text0
         Legend/C/N=text0/A=MC 
         AppendText/N=text0 "alfa="+num2str(co_gamma[1])+" +/- " + num2str(W_sigma[1])
         AppendText/N=text0 "Delta="+num2str(co_gamma[2]*1000)+" +/- " + num2str(W_sigma[2]*1000)+"meV"
    Endif
         Duplicate/O $"fit_"+wave_name, $wave_name+"_fit"
   Refreshpop()
End

Proc calsymf(ctrlName) : ButtonControl
	String ctrlName
//	Setdatafolder root:Process1D
    String win_name,wave_name,wave_name1
	Variable w0,w1,w2,w3,w11,Es,En,Gf,Efull,w4
	w0=root:Process1D:A
	w1=root:Process1D:G
	w11=root:Process1D:alfa
	W2=root:Process1D:D
	w3=root:Process1D:B
	w4=root:Process1D:C
	Es=root:Process1D:Es
	En=root:Process1D:En
	Gf=root:Process1D:Gflag
	Efull=root:Process1D:Efull
	wave_name=root:Process1D:symf_name
	Setdatafolder root:Process1D:Symmetrized
	win_name="S"+wave_name
	wave_name1="Calc_"+wave_name
    
    Variable NX,Xmin,Xinc,Xmax
    NX=DimSize($wave_name, 0)
	Xmin=DimOffset($wave_name,0)
    Xinc=round(DimDelta($wave_name,0) * 1E6) / 1E6	
	Xmax=Xmin+(NX-1)*Xinc 
	
        Dowindow $win_name
        if(V_flag==0)
		  display $wave_name// as popStr
	      Legend/C/N=text0/A=MC 
          Label bottom "eV"
          Label left "Arb ,units"
          Dowindow/C $win_name
        else 
          Dowindow/F $win_name
        Endif 
  
          if(Efull==0)
 //   	   Make/O/N=(NX) $wave_name1
           Duplicate/O $wave_name,$wave_name1
//    	   FuncFit /L=(NX) Symfit1 co_gamma $wave_name(Xmin,Xmax ) /D
    	   else
    	   Duplicate/O/R=(Es,En) $wave_name,$wave_name1
//          FuncFit Symfit1 co_gamma $wave_name(Es,En ) /D=$wave_name1
           Endif
        If(Gf==0)
 //   	Make/O co_gamma={w0,w1,w2,w3}
   //         AppendtoGraph "fit_"=$wave_name
           $wave_name1=w0*abs(Real((x+w1*sqrt(-1))/sqrt((x+w1*sqrt(-1))^2-w2^2)))+w3*abs(x)+w4
     //      $wave_name1=-w0*Real((x+w1*sqrt(-1))/sqrt((x+w1*sqrt(-1))^2-w2^2))++w3*x
           RemoveFromGraph/Z $wave_name1
         AppendToGraph $wave_name1
         ModifyGraph rgb($wave_name1)=(52224,0,41728)
         Textbox/K/N=text0
         Legend/C/N=text0/A=MC 
         AppendText/N=text0 "gamma="+num2str(w1*1000)//+" +/- " + num2str(W_sigma[1]*1000)
         AppendText/N=text0 "Delta="+num2str(w2*1000)//+" +/- " + num2str(W_sigma[2]*1000)+"meV"
         else(Gf==1)
//       Make/O co_gamma={w0,w11,w2,w3}
 //      FuncFit Symfit2 co_gamma $wave_name /D=$wave_name1
//       AppendtoGraph "fit_"=$wave_name
        $wave_name1=w0*abs(Real((x+w11*x*sqrt(-1))/sqrt((x+w11*x*sqrt(-1))^2-w2^2)))+w3*abs(x)+w4
  //      $wave_name1=w0*Real((x+w11*x*sqrt(-1))/sqrt((x+w11*x*sqrt(-1))^2-w2^2))
         RemoveFromGraph/Z $wave_name1
         AppendToGraph $wave_name1
         ModifyGraph rgb($wave_name1)=(52224,0,41728)
         Textbox/K/N=text0
         Legend/C/N=text0/A=MC 
         AppendText/N=text0 "alfa="+num2str(w11)//+" +/- " + num2str(W_sigma[1]*1000)
         AppendText/N=text0 "Delta="+num2str(w2*1000)+"meV"
           Endif
     //    Duplicate/O $"fit_"+wave_name, $wave_name+"_fit"
   Refreshpop()
End

proc copydata(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:Process1D:SubsDivid
	variable numberoffiles,ii=0
	string/G filenamelist,filename,expand_list
	filenamelist=root:Process1D:Processed:filenamelists_Pro
	numberoffiles=itemsinlist(root:Process1D:Processed:filenamelists_Pro)
	do
		filename=stringfromlist(ii,filenamelist)
		duplicate/O root:Process1D:Processed:$filename $filename
		ii+=1
	while(ii<numberoffiles)
	expand_list=filenamelist+wavelist("sim*",";","DIMS:1")
	PopupMenu SDbis,value= #"root:Process1D:SubsDivid:expand_list"
	PopupMenu Substitute,value= #"root:Process1D:SubsDivid:filenamelist"
	PopupMenu Dividing,value= #"root:Process1D:SubsDivid:filenamelist"
End


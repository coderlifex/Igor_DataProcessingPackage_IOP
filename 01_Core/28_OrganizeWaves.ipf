#pragma rtGlobals=1		// Use modern global access method.


Proc OrganizeWaves()

  String Curr=GetDataFolder(1)
  
	DoWindow/F Wave_Organize_Panel
	If (V_flag==0)
		NewDataFolder/O/S root:OrganizeWaves
		Variable/G iTrace=0
		Variable/G iOffset=0
	        Variable/G NoofAllTraces
	        String/G TempTrace

     Wave_Organize_Panel( )
    Endif
       
  SetDataFolder Curr	

End



Window  Wave_Organize_panel():Panel

	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(0,101,250,270)
	ModifyPanel cbRGB=(64512,62423,1327)
	SetDrawLayer UserBack

//   SetDrawEnv fillfgc= (16384,65280,65280)
//	DrawRRect 171,29,360,224                               //Fit initialization

    Button ListAllTraces,pos={20,10},size={200,40},title="List Traces",proc=ListTraces
	Button ReorganizeTraces,pos={20,60},size={200,40},title="Reorganize Traces",proc=ReorganizeTraces
	Button CleanTraces,pos={20,130},size={80,30},title="CLEAN",proc=CleanTraces
	Button Exit,pos={140,130},size={80,30},title="EXIT",proc=ExitTraces

//EndMacro

Proc ListTraces(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	SetDataFolder root:OrganizeWaves
	
	String  AllTracesList=TraceNameList("",";",1)
	
	NoofAllTraces=ItemsinList(AllTracesList,";")
	
	
//	Print AllTracesList
//  Print NoofAllTraces
	
	
	Make/T/O/N=(NoofAllTraces) TraceName
	Make/O/N=(NoofAllTraces)    YOffset
	Make/O/N=(NoofAllTraces)    YTimes
	YTimes=1

	        DoWindow OrganizeTracesTable
	        if(V_flag==0)
	        		Edit TraceName, YOffset, YTimes  as "Organize Traces"
	        		DoWindow/C OrganizeTracesTable
	        	else
	        		DoWindow/F OrganizeTracesTable
	        	endif

          String TempTrace, OriTempTrace
	      Variable iTrace=0
	      Do
	      TraceName[iTrace]=StringFromList(iTrace,AllTracesList,";")
	      TempTrace=TraceName[iTrace]
	      OriTempTrace="Ori_"+TraceName[iTrace]
////	      Print "TempTrace=", TempTrace
////	      Print "TraceName=", TraceName[iTrace]
	 
	      SetDataFolder Curr
	      Duplicate/O $TempTrace  $OriTempTrace
	    	  SetDataFolder root:OrganizeWaves
	    	      
	      iTrace+=1
	      While(iTrace<NoofAllTraces)    	
	        	

	SetDataFolder Curr
	
End


Proc ReorganizeTraces(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)

	
	String TempTrace, OriTempTrace
	OriTempTrace=TempTrace+"Ori_"
	
	
////	Display as "ReorganizedEDC"
		

	Variable iOffset=0

	Do
	TempTrace=root:OrganizeWaves:TraceName[iOffset]
	OriTempTrace="Ori_"+TempTrace
////	Duplicate/O  $TempTrace  $OriTempTrace
	
////	AppendtoGraph root:OrganizeWaves:$TempTrace	
	
	$TempTrace=$OriTempTrace*root:OrganizeWaves:YTimes[iOffset]+root:OrganizeWaves:YOffset[iOffset]
	iOffset+=1
	While (iOffset<root:OrganizeWaves:NoofAllTraces)
	      	

	SetDataFolder Curr
	
End


Proc CleanTraces(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	String ToBeKilledList=WaveList("Ori_*",";","DIMS:1")
    Variable NoofKilledList=ItemsinList(ToBeKilledList,";")
         String ToBeKilled
	     Variable iKill=0
	     Do
	     ToBeKilled=StringFromList(iKill,ToBeKilledList,";")
	     KillWaves/Z  $ToBeKilled
	     iKill+=1
	     While(iKill<NoofKilledList)   	

	SetDataFolder Curr
	
End




Proc ExitTraces(ctrlName) : ButtonControl
	String ctrlName
	String Curr=GetDataFolder(1)
	
	CleanTraces(ctrlName)
	DoWindow/K Wave_Organize_Panel  
	
	SetDataFolder Curr
	
End



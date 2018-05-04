#pragma rtGlobals=1		// Use modern global access method.

Function MDC2dFS(popStr)
	
	String popStr
	    	            		
        NVAR   SmoothTimes=root:PROCESS:MDCSmoothingTimes
//      String SecDImageName="SecD_"+"ST"+num2str(SmoothTimes)+popStr	
//        String SecDImageName="SecD_"+"MDC"+num2str(SmoothTimes)+popStr	        
//        String SecondDImage="MDC"+num2str(SmoothTimes)+popStr	
        String Curr=GetDataFolder(1) 
        String Notation=popStr  	
	
       //Duplicate/O  root:DispersionIMAGE:$popStr, root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage
//     MatrixTranspose  root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage


       //SetDataFolder root:DispersionFrom2ndDerivative:MDC2ndD
       WAVE SecDImage= $popStr
       Duplicate/O SecDImage, TempSecDImage
        
       Variable/G nx, ny
	   Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
       XJZImginfo(SecDImage)


            String ReferenceEnergyWave="TokillEngy"+popStr
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 

                 String   EDC0="Tokill"+popStr+"0"
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=TempSecDImage[p] [0]
                 Differentiate EDCC;         Differentiate EDCC
                 Smooth/E=2 SmoothTimes, EDCC
                                  Variable k=0
                                  Do
                                  SecDImage[k] [0]=EDCC[k]
                                  k=k+1
                                  While(k<nx)
	         
                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=1         

	         
	         Variable ll
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p][i]
                 Differentiate EDCSpectra;   Differentiate EDCSpectra                 
                 Smooth/E=2 SmoothTimes, EDCSpectra
//               variable n=numpnts(EDCSpectra)
//               EDCSpectra[0,1]=0;	EDCSpectra[n-2,n-1]=0
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)
	        i=i+1
	        While(i<ny) 
       
//这段可能多余	            		
	      	        			       
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p] [i]
                 Differentiate EDCSpectra;      Differentiate EDCSpectra
                 Smooth/E=2 SmoothTimes, EDCSpectra
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)        
	         i=i+1
	        While(i<ny) 
         SecDImage=-SecDImage



                
//                DoWindow $SecDImageName
//	            if(V_flag==0)
//	            MatrixTranspose   SecDImage          
//                Display; AppendImage SecDImage
//                Textbox/N=text0/F=0/A=MT Notation  
//              ModifyImage $SecondDImage ctab= {*,0,Rainbow,1}
//                ModifyImage $SecondDImage ctab= {-0.01,0,PlanetEarth,1}
//                ModifyGraph standoff=0
//                ModifyGraph zero(left)=3
//                Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
//                ModifyGraph width={Aspect,0.5}
//                ModifyGraph margin(left)=26
//                ModifyGraph margin(right)=5
//                ModifyGraph margin(top)=5
                
//                DoWindow/C $SecDImageName
                
//               Else
//             MatrixTranspose   SecDImage   
//               DoWindow/F $SecDImageName 
//               Endif 
//             Print "Till here"
//				ShowInfo
//Kill EDC Curves in Root:DispersionFrom2ndDerivative
	    String ToBeKilledEDCList=WaveList("Tokill*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	    Variable iEDC=0
	    Do
	    EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	    KillWaves/Z  $EDCCurve
	    iEDC+=1
	    While(iEDC<NoofKilledEDCList)
                
                
	
	SetDataFolder curr
END


Function EDC2dFS(popStr)
	
	String popStr
	    	            		
        NVAR   SmoothTimes=root:PROCESS:MDCSmoothingTimes
//      String SecDImageName="SecD_"+"ST"+num2str(SmoothTimes)+popStr	
//        String SecDImageName="SecD_"+"MDC"+num2str(SmoothTimes)+popStr	        
//        String SecondDImage="MDC"+num2str(SmoothTimes)+popStr	
        String Curr=GetDataFolder(1) 
        String Notation=popStr  	
	
       //Duplicate/O  root:DispersionIMAGE:$popStr, root:DispersionFrom2ndDerivative:MDC2ndD:$SecondDImage
      MatrixTranspose  $popStr


       //SetDataFolder root:DispersionFrom2ndDerivative:MDC2ndD
       WAVE SecDImage= $popStr
       Duplicate/O SecDImage, TempSecDImage
        
       Variable/G nx, ny
	   Variable/G xmin, xinc, xmax, ymin, yinc, ymax, dmin0, dmax0
       XJZImginfo(SecDImage)


            String ReferenceEnergyWave="TokillEgy"+popStr
	        Make/O/N=(nx) $ReferenceEnergyWave
	        Wave ReferenceEnergy=$ReferenceEnergyWave
                Variable ii=0
      	        Do
        		ReferenceEnergy[ii]=xmin+xinc*ii
        		ii=ii+1
       	 	While(ii<nx)
 

                 String   EDC0="Tokill"+popStr+"0"
                 Make/O/N=(nx) $EDC0
                 WAVE EDCC=$EDC0
                 EDCC=TempSecDImage[p] [0]
                 Differentiate EDCC;         Differentiate EDCC
                 Smooth/E=2 SmoothTimes, EDCC
                                  Variable k=0
                                  Do
                                  SecDImage[k] [0]=EDCC[k]
                                  k=k+1
                                  While(k<nx)
	         
                 String PlotName
                 String EDC
                 String EDCName
                 Variable i=1         

	         
	         Variable ll
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p][i]
                 Differentiate EDCSpectra;   Differentiate EDCSpectra                 
                 Smooth/E=2 SmoothTimes, EDCSpectra
//               variable n=numpnts(EDCSpectra)
//               EDCSpectra[0,1]=0;	EDCSpectra[n-2,n-1]=0
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)
	        i=i+1
	        While(i<ny) 
       
//这段可能多余	            		
	      	        			       
	         Do
                 PlotName="Tokill"+popStr+num2str(i)
                 EDCName=PlotName
                 Make/O/N=(nx) $EDCName
                 WAVE EDCSpectra=$EDCName
                 EDCSpectra=TempSecDImage[p] [i]
                 Differentiate EDCSpectra;      Differentiate EDCSpectra
                 Smooth/E=2 SmoothTimes, EDCSpectra
                               ll=0
                               Do
                               SecDImage[ll][i]=EDCSpectra[ll]
                               ll+=1
                               While(ll<nx)        
	         i=i+1
	        While(i<ny) 
	SecDImage=-SecDImage
	 MatrixTranspose  $popStr


                
//                DoWindow $SecDImageName
//	            if(V_flag==0)
//	            MatrixTranspose   SecDImage          
//                Display; AppendImage SecDImage
//                Textbox/N=text0/F=0/A=MT Notation  
//              ModifyImage $SecondDImage ctab= {*,0,Rainbow,1}
//                ModifyImage $SecondDImage ctab= {-0.01,0,PlanetEarth,1}
//                ModifyGraph standoff=0
//                ModifyGraph zero(left)=3
//                Label bottom "\\Z14\\f01\\u#2K// (\\F'Symbol'p\\F'Arial'/a)"
//                ModifyGraph width={Aspect,0.5}
//                ModifyGraph margin(left)=26
//                ModifyGraph margin(right)=5
//                ModifyGraph margin(top)=5
                
//                DoWindow/C $SecDImageName
                
//               Else
//             MatrixTranspose   SecDImage   
//               DoWindow/F $SecDImageName 
//               Endif 
//             Print "Till here"
//				ShowInfo
//Kill EDC Curves in Root:DispersionFrom2ndDerivative
	    String ToBeKilledEDCList=WaveList("Tokill*",";","DIMS:1")
       	Variable NoofKilledEDCList=ItemsinList(ToBeKilledEDCList,";")
       	String EDCCurve
	    Variable iEDC=0
	    Do
	    EDCCurve=StringFromList(iEDC,ToBeKilledEDCList,";")
	    KillWaves/Z  $EDCCurve
	    iEDC+=1
	    While(iEDC<NoofKilledEDCList)
                
                
	
	SetDataFolder curr
END

Function Checkedc2d(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	nvar edc2d=root:PROCESS:edc2d
	nvar mdc2d=root:PROCESS:mdc2d
	if(edc2d==1)
		mdc2d=0
	endif

End


Function Checkmdc2d(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	nvar edc2d=root:PROCESS:edc2d
	nvar mdc2d=root:PROCESS:mdc2d
	if(mdc2d==1)
		edc2d=0
	endif

End


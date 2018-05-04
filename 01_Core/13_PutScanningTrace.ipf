#pragma rtGlobals=1		// Use modern global access method.


Proc     XJZTracePlot(ctrlName) : ButtonControl
	     String ctrlName
	     
		String Curr=GetDataFolder(1)
		
		SetDataFolder root:IMG
	       String TraceNamex=root:PROCESS:SWImageName+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"RRKx"
              String TraceNamey=root:PROCESS:SWImageName+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"RRKy"

	        Duplicate/O RRKx  $TraceNamex
               Duplicate/O RRKy  $TraceNamey
               
RemoveFromGraph/Z $TraceNamey
SetDataFolder root:IMG
AppendToGraph $TraceNamey vs $TraceNamex
ModifyGraph mode($TraceNamey)=3,marker($TraceNamey)=1,msize($TraceNamey)=0.3,rgb($TraceNamey)=(0,0,0)

SetDataFolder Curr
End


Proc     HYLiuTracePlot(ctrlName) : ButtonControl
	     String ctrlName
	     
		String Curr=GetDataFolder(1)
		
		SetDataFolder root:IMG
	       String TraceNamex=root:PROCESS:SWImageName+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"RRKx"
              String TraceNamey=root:PROCESS:SWImageName+"F"+num2str(root:PROCESS:ProcessedImageFlag)+"RRKy"

	        Duplicate/O PTO_RRKx  $TraceNamex
               Duplicate/O PTO_RRKy  $TraceNamey
               
RemoveFromGraph/Z $TraceNamey
SetDataFolder root:IMG
AppendToGraph $TraceNamey vs $TraceNamex
ModifyGraph mode($TraceNamey)=3,marker($TraceNamey)=1,msize($TraceNamey)=0.3,rgb($TraceNamey)=(0,0,0)

SetDataFolder Curr
End
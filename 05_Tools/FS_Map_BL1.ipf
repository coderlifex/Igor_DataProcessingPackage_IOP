 #pragma rtGlobals=1		// Use modern global access method.

Menu "Macros", dynamic
	Submenu "Fermi Surface Mapping"
		fs_menu(1), fs_starter()
		fs_menu(2), fs_restarter()
	End
End

Function/S fs_menu(itemNum)
	Variable itemNum
	String menustr = ""
	switch(itemNum)
		case 1:
			menustr = "Start Make FS"
		break
		case 2:
			If(DataFolderExists("root:FS")+WaveExists(root:FS:cim)+WaveExists(root:FS:FS_Info) != 3)
				menustr = "("
			Endif
			menustr += "Call Panel"
		break
	endswitch
	return menustr
End

Function fs_starter()
	String cdf = GetDataFolder(1), wvlist = WaveList("*", ";", "DIMS:2")
	If(strlen(wvlist) == 0)
		DoAlert 0, "Check Position of Current Data Folder"
		If(V_flag)
			Abort
		Endif
	Endif
	Variable i, wvnum = ItemsInList(wvlist)
	// Assume all the scale of waves is same
	Wave/D firstwv = $StringFromList(0, wvlist)
	NewDataFolder/O/S root:FS
		Variable/G ir = DimOffset(firstwv, 0), rs = DimDelta(firstwv, 0), ro = DimSize(firstwv, 0), lr = ir + rs * (ro-1)
		Variable/G ic = DimOffset(firstwv, 1), cs = DimDelta(firstwv, 1), co = DimSize(firstwv, 1), lc = ic + cs * (co-1)
		Variable/G lay = wvnum
		Make/O/D/N=(ro, co, wvnum) cim; Wave/D cwv = cim
		for(i=0; i<wvnum; i+=1)
  			SetDataFolder cdf
	  			Wave/D rwv = $StringFromList(i, wvlist)
  			cwv[][][i] = rwv[p][q]
  			CopyScales rwv, cwv
		endfor
		fs_panel()
		fs_amap()
		fs_amapwin(1)
	SetDataFolder cdf
End

Function fs_restarter()
	fs_panel()
	Wave/D/Z fiwv = root:FS:FS_Info
	If(fiwv[1] == 1)
		fs_amap()
		fs_amapwin(1)
	Endif
End

Function fs_panel()
	If(WinType("fs_gui") == 0)
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Nvar/Z ir, rs, ro, lr, ic, cs, co, lc
		Wave/D/Z fiwv = FS_Info
		If(!WaveExists(fiwv))
			Make/O/D/N=(32) FS_Info; Wave/D fiwv = FS_info
		// Variables
			fiwv[0] = ir + rs * (ro/2)	// Center energy of making FS
			fiwv[1] = 0.01				// Integration window (+/-)
			fiwv[2] = min(ic,lc)			// Region start (DPRF direction)
			fiwv[3] = max(ic,lc)		// Region end (DPRF direction)
			fiwv[4] = 0				// Mapping start (Azimuth direction)
			fiwv[5] = 1				// Mapping step (Azimuth direction)
			fiwv[6] = 0				// Offset (DPRF)
			fiwv[7] = 0				// Offset (Azimuth)
			fiwv[8] = 0				// Offset (Tilt)
			fiwv[9] = 0.01				// k step
			fiwv[10] = 3.9				// lattice constant
		// Switches
			fiwv[11] = 1				// Display ang-map
			fiwv[12] = 1				// Live update ang-map
			fiwv[13] = 0				// Show Mapping area
			fiwv[14] = 0				// Tilt clb.
			fiwv[15] = 0				// Normalize
			fiwv[16] = 0				// Subtract b.g.
			fiwv[17] = 0				// Append Peak
			fiwv[18] = 1				// Display k-map
			fiwv[19] = 0				// Linked live update k-map
			fiwv[20] = 0				// k unit (0: A-1, 1:pi/a)
			fiwv[21] = 0				// Append Peak
			fiwv[22] = 1				// Display symmetrize
		// Optional Variables
			fiwv[23] = 0				// Tilt clb. way
			fiwv[24] = 0				//	Amp
			fiwv[25] = 0				//	phase
			fiwv[26] = 1				// Normalize way
			fiwv[27] = min(ic,lc)		//	Start
			fiwv[28] = max(ic,lc)		//	End
			fiwv[29] = 1				// Subtract b.g. way
			fiwv[30] = min(ic,lc)		//	Start
			fiwv[31] = max(ic,lc)		//	End
		Endif			
		NewPanel/K=1/W=(723,65,995,347)/N=fs_gui as "FS mapping @ BL-1"
		// Appearance
			GroupBox fs_gbox1 pos={4,3},size={125,50},title="Energy",frame=0
			GroupBox fs_gbox2 pos={3,55},size={125,50},title="DPRF",frame=0
			GroupBox fs_gbox3 pos={3,107},size={125,50},title="Azimuth",frame=0
			GroupBox fs_gbox4 pos={4,159},size={125,70},title="Offset",frame=0
			GroupBox fs_gbox5 pos={4,240},size={125,40},title="k step",frame=0
			GroupBox fs_gbox6 pos={132,3},size={137,154},title="A-map",frame=0
			GroupBox fs_gbox7 pos={132,159},size={137,121},title="k-map",frame=0
		// 	Variables
			SetVariable fs_svar1 pos={20,19},size={104,16},bodyWidth=60,title="Center :",limits={ir+fiwv[1],lr-fiwv[1],rs},value= fiwv[0],proc=fs_svarproc
			SetVariable fs_svar2 pos={36,34},size={88,16},bodyWidth=60,title="+/- :",limits={rs,abs(lr-ir),rs},value= fiwv[1],proc=fs_svarproc
			SetVariable fs_svar3 pos={25,71},size={99,16},bodyWidth=60,title="Start :",limits={min(ic,lc),max(ic,lc),cs},value= fiwv[2],proc=fs_svarproc
			SetVariable fs_svar4 pos={31,86},size={93,16},bodyWidth=60,title="End : ",limits={min(ic,lc),max(ic,lc),cs},value= fiwv[3],proc=fs_svarproc
			SetVariable fs_svar5 pos={25,123},size={99,16},bodyWidth=60,title="Start : ",value= fiwv[4],proc=fs_svarproc
			SetVariable fs_svar6 pos={27,138},size={97,16},bodyWidth=60,title="Step : ",value= fiwv[5],proc=fs_svarproc
			SetVariable fs_svar7 pos={20,177},size={104,16},bodyWidth=60,title="DPRF : ",limits={-inf,inf,0.1},value= fiwv[6],proc=fs_svarproc
			SetVariable fs_svar8 pos={9,192},size={115,16},bodyWidth=60,title="Azimuth : ",limits={-inf,inf,0.1},value= fiwv[7],proc=fs_svarproc
			SetVariable fs_svar9 pos={33,207},size={91,16},bodyWidth=60,title="Tilt : ",limits={-inf,inf,0.1},value= fiwv[8],proc=fs_svarproc
			SetVariable fs_svar10 pos={41,257},size={83,18},bodyWidth=60,title="deltak :",limits={1e-10,inf,0.001},value= fiwv[9],proc=fs_svarproc
			SetVariable fs_svar11 pos={228,227},size={35,14},bodyWidth=35,title=" ",fSize=10,limits={0,inf,0.1},value= fiwv[10],proc=fs_svarproc,disable=(fiwv[20]==1) ? 0 : 2 
		// Check box Ctrls				
			CheckBox fs_cbox1 pos={137,39},size={56,14},title="Display",value= fiwv[11],proc=fs_cboxproc
			CheckBox fs_cbox2 pos={137,55},size={77,14},title="Live update",value= fiwv[12],proc=fs_cboxproc
			CheckBox fs_cbox3 pos={137,71},size={124,14},title="Show measured area",value= fiwv[13],proc=fs_cboxproc
			CheckBox fs_cbox4 pos={137,88},size={56,14},title="Tilt clb.",value= fiwv[14],proc=fs_cboxproc
			CheckBox fs_cbox5 pos={137,105},size={68,14},title="Normalize",value= fiwv[15],proc=fs_cboxproc
			CheckBox fs_cbox6 pos={137,122},size={81,14},title="Subtract b.g.",value= fiwv[16],proc=fs_cboxproc
			CheckBox fs_cbox7 pos={137,139},size={84,14},title="Append peak",value= fiwv[17],proc=fs_cboxproc
			CheckBox fs_cbox8 pos={137,195},size={56,14},title="Display",value=fiwv[18],proc=fs_cboxproc
			CheckBox fs_cbox9 pos={137,211},size={89,14},title="Linked update",value= fiwv[19],proc=fs_cboxproc
			CheckBox fs_cbox10 pos={137,227},size={84,15}, title="Scale by \F'Symbol'p\F]0/a", value = fiwv[20], proc=fs_cboxproc
			CheckBox fs_cbox11 pos={137,245},size={84,14},title="Append peak",value= fiwv[21],proc=fs_cboxproc
			CheckBox fs_cbox12 pos={137,262},size={77,14},title="Symmetrize",value= fiwv[22],proc=fs_cboxproc
		// Button Ctrls	
			Button fs_but1 pos={137,19},size={60,18},title="Make",proc=fs_butproc
			Button fs_but2 pos={203,19},size={60,18},title="Fitting",proc=fs_butproc
			Button fs_but3 pos={137,175},size={60,18},title="Make",proc=fs_butproc
			Button fs_but4 pos={225,87},size={40,16},title="Setting",fSize=10,proc=fs_butproc
			Button fs_but5 pos={225,104},size={40,16},title="Setting",fSize=10,proc=fs_butproc
			Button fs_but6 pos={225,121},size={40,16},title="Setting",fSize=10,proc=fs_butproc
			Button fs_but7 pos={225,138},size={40,16},title="Setting",fSize=10,proc=fs_butproc
			Button fs_but8 pos={225,244},size={40,16},title="Setting",fSize=10,proc=fs_butproc
			Button fs_but9 pos={225,261},size={40,16},title="Setting",fSize=10,proc=fs_butproc
			
	Endif		
End

Function fs_svarproc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName, varStr, varName; Variable varNum
	Variable index = str2num(ReplaceString("fs_svar", ctrlName, ""))
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Svar/Z curamap
		Nvar/Z ir, rs, lr, ic, cs, lay
		Wave/D/Z fiwv = FS_Info, afs = $curamap
		If(index == 2)
			SetVariable fs_svar1 limits={ir+fiwv[1],lr-fiwv[1],rs}, win = fs_gui
		Endif
		If(WaveExists(afs))
			SetScale/P x, ic+fiwv[6], cs, afs
			SetScale/P y, fiwv[4]+fiwv[7], fiwv[5], afs
		Endif
		If(fiwv[12] == 1 || fiwv[19] ==1)
			fs_amap()
			If(fiwv[19] == 1)
				fs_kmap()
			Endif
		Endif
		If(WinType("amap_win") != 0)
			Make/O/D/N=(2, 2) dprf_guide, xdprf_guide
			Wave dgwv = $"dprf_guide", xdgwv = $"xdprf_guide"
			dgwv[0,][0] = fiwv[2]+fiwv[6]; xdgwv[0,][0] = {fiwv[4]+fiwv[7], fiwv[4]+fiwv[7]+fiwv[5]*(lay-1)}
			dgwv[0,][1] = fiwv[3]+fiwv[6]; xdgwv[0,][1] = {fiwv[4]+fiwv[7], fiwv[4]+fiwv[7]+fiwv[5]*(lay-1)}
			CheckDisplayed/W=amap_win dprf_guide
			If(V_flag == 0)
				AppendToGraph/VERT/W=amap_win dprf_guide[][0] vs xdprf_guide[][0]
				AppendToGraph/VERT/W=amap_win dprf_guide[][1] vs xdprf_guide[][1]
				ModifyGraph/W=amap_win lstyle=11,rgb=(65280,65280,16384)
			Endif
		Endif
		If(WinType("karea_win") != 0)
			fs_kareawin(1)
		Endif
	SetDataFolder cdf
End

Function fs_cboxproc(ctrlName,checked) : CheckBoxControl
	String ctrlName; Variable checked
	Variable index = str2num(ReplaceString("fs_cbox", ctrlName, ""))
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Svar/Z curamap
		Wave/D/Z fiwv = FS_info, afs = $curamap, kfs = kmap
	switch(index)
		case 1:
			If(WaveExists(afs))
				fs_amapwin(checked)
			else
				checked = 0
				CheckBox $ctrlName value = checked, win = fs_gui
			Endif
			break
		case 2:
			If(fiwv[12] == 0 && checked == 1)
				fs_amap()
			Endif
			break
		case 3:
			fs_kareawin(checked)
			break
		case 8:
			If(WaveExists(kfs))
				fs_kmapwin(checked)
			else
				checked = 0
				CheckBox $ctrlName value = checked, win = fs_gui
			Endif
			break
		case 10:
			fiwv[20] = checked
			SetVariable fs_svar11 disable=(fiwv[20]==1) ? 0 : 2, win = fs_gui
			break
	endswitch
	fiwv[10+index] = checked
	SetDataFolder cdf
End
	
Function fs_butproc(ctrlName) : ButtonControl
	String ctrlName
	Variable index = str2num(ReplaceString("fs_but", ctrlName, ""))
	switch(index)
		case 1:
			fs_amap()
		break
		case 2:
			
			
		break
		case 3:
			fs_kmap()
			Wave/D fiwv = root:FS:FS_info
			If(fiwv[18] == 1)
				fs_kmapwin(1)
			Endif
		break
		case 5:
		case 6:
			fs_nspanel(index-4)
			PauseForUser $StringFromList(index-5, "fs_nrwin;fs_sbwin")
		break
		case 9:
			fs_sympanel()
			PauseForUser symfs_gui
		break
	endswitch
End

Function fs_amap()
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		String/G curamap = "Amap"		
		Variable/G kxmin = inf, kxmax = -inf, kymin = inf, kymax = -inf
		Wave/D cwv = cim, fiwv = FS_info
		Nvar/Z ir, rs, ro, lr, ic, cs, co, lc, lay
	NewDataFolder/O/S root:FS:Amap_prep
		Make/O/D/N=(co, lay) $"Amap_ori" = 0
			Wave/D afsori = $"Amap_ori"
			SetScale/P x, ic, cs, afsori
			SetScale/P y, fiwv[4], fiwv[5], afsori	
		Variable i, j, epsta = (fiwv[0]-fiwv[1]-ir)/rs, epend = (fiwv[0]+fiwv[1]-ir)/rs
		for(i=epsta; i<=epend; i+=0.1)
			afsori[][] += cwv[i][p][q]
		endfor
	// Limit the range
		Duplicate/O/R=[(fiwv[2]-ic)/cs, (fiwv[3]-ic)/cs][0,lay] afsori, $"Amap_limited"
		Wave afslim = $"Amap_limited"
	// Make clbed afs and make k-area
		Variable/D doff = fiwv[6], aoff = fiwv[7], toff = fiwv[8], dpmax = -inf, dpmin = inf, dpsize = DimSize(afslim, 0), lat = fiwv[10], kc = 0.51231 * sqrt(fiwv[0])
		Make/O/D/N=(dpsize) seta = fiwv[2] + p*abs(cs) + doff
		Make/O/D/N=(lay) setaclb
		Wave/D swv = seta, scwv = setaclb
		for(i=0; i<lay; i+=1)
			scwv[i] = toff * sin(-(fiwv[4]+i * fiwv[5] + aoff)*pi/180)	
		endfor
	NewDataFolder/O/S root:FS:kcut
		for(i=0; i<lay; i+=1)
			Make/O/D/N=(dpsize) $"kx"+num2str(i), $"ky"+num2str(i)
			Wave/D kx = $"kx"+num2str(i), ky = $"ky"+num2str(i)	
			Variable azi = fiwv[4]+i * fiwv[5] + aoff
			kx = kc*sin((swv + scwv[i]+doff)*pi/180)*cos(-azi*pi/180)
			ky = (azi < 180) ? -kc*sin((swv + scwv[i]+doff)*pi/180)*sin(-azi*pi/180) : kc*sin((swv + scwv[i]+doff)*pi/180)*sin(-azi*pi/180)
			If(fiwv[20] == 1)
				kx /= (pi/lat); ky /= (pi/lat)
			Endif	
			kxmin = min(kxmin, WaveMin(kx)); kxmax = max(kxmax, WaveMax(kx))
			kymin = min(kymin, WaveMin(ky)); kymax = max(kymax, WaveMax(ky))
			dpmax = Max(fiwv[2],fiwv[3])+WaveMax(scwv) + doff
			dpmin = Min(fiwv[2],fiwv[3])+WaveMin(scwv) + doff
		endfor	
	SetDataFolder root:FS
		Variable roclb = abs(round((dpmax-dpmin)/cs))+1
		Make/O/D/N=(roclb, lay) Amap=0
               Wave afsclb = $"Amap"
			SetScale/P x, dpmin, abs(cs), afsclb
			SetScale/P y, fiwv[4]+aoff, fiwv[5], afsclb 	
		for(i=0; i<lay; i+=1)
			for(j=0; j<roclb; j+=1)
				Variable/D cazi = fiwv[4] + i * fiwv[5]
				Variable/D cdprf = (dpmin + j * abs(cs)) - toff*sin(-cazi*pi/180) - doff
				afsclb[j][i] = (NumType(interp2D(afsori, cdprf, cazi)) != 2) ? interp2D(afsori, cdprf, cazi) : 0
			endfor
		endfor
		
	If(fiwv[16] == 1) // Subtract b.g.
		SetDataFolder root:FS:Amap_prep
		for(i=0; i<lay; i+=1)
			MatrixOP/O tempadc = col(afsclb, i)
			SetScale/P x, dpmin, abs(cs), tempadc
			If(fiwv[29] == 1 || fiwv[29] == 3) // mean b.g.
				Make/O/D/N=(lay) cbgr
				Wave/D cbwv = cbgr
				cbwv[i] = mean(tempadc, fiwv[30],fiwv[31])
			elseif(fiwv[29] == 2 || fiwv[29] == 4) // linear b.g.
				Variable x1 = min(fiwv[30],fiwv[31]), x2 = max(fiwv[30],fiwv[31])
				Variable y1 = tempadc(x1), y2 = tempadc(x2)
				Variable a = (y2-y1)/(x2-x1), b = y1-a*x1
				Make/O/D/N=(lay) lbgr_a, lbgr_b
				Wave/D lbawv = lbgr_a, lbbwv = lbgr_b
				lbawv[i] = a; lbbwv[i] = b
			Endif
		endfor
		If(fiwv[29] == 3)
			Interpolate2/T=3/N=(lay)/F=2/Y=cbgr_SS cbwv
			Wave cbiwv = cbgr_SS
		elseif(fiwv[29] == 4)
			Interpolate2/T=3/N=(lay)/F=10/Y=lbgra_SS lbawv
			Interpolate2/T=3/N=(lay)/F=10/Y=lbgrb_SS lbbwv
			Wave lbaiwv = lbgra_SS, lbbiwv = lbgrb_SS
		Endif
		for(i=0; i<lay; i+=1)
			MatrixOP/O tempadc = col(afsclb, i)
			SetScale/P x, dpmin, abs(cs), tempadc
			If(fiwv[29] == 1 || fiwv[29] == 3)
				afsclb[][i] = (fiwv[29] == 1) ? tempadc[p]-cbwv[i] : tempadc[p]-cbiwv[i]
			else
				Make/O/D/N=(roclb) lbgr_temp
				SetScale/P x, dpmin, abs(cs), lbgr_temp
				lbgr_temp = (fiwv[29] == 2) ? lbawv[i]*(dpmin + p*cs) + lbbwv[i] : lbaiwv[i]*(dpmin + p*cs) + lbbiwv[i]
				afsclb[][i] = tempadc[p]-lbgr_temp[p]
			Endif
		endfor
	Endif

	If(fiwv[15] == 1) // Normalize
		SetDataFolder root:FS:Amap_prep
		Make/O/D/N=(lay) normclb
		Wave/D ncwv = normclb
		for(i=0; i<lay; i+=1)
			MatrixOP/O tempadc = col(afsclb, i)
			SetScale/P x, dpmin, abs(cs), tempadc
			Variable normvalue
			If(fiwv[26] == 1 || fiwv[26] == 3) // normalize by area
				normvalue = area(tempadc, fiwv[27], fiwv[28])
			elseif(fiwv[26] == 2 || fiwv[26] == 4) // normalize by height 
				Duplicate/O/R=(fiwv[27],fiwv[28]) tempadc, tempadc_limited
				normvalue = WaveMax(tempadc_limited)
				KillWaves/Z tempadc_limited
			Endif
			normclb[i] = normvalue
		endfor
		Interpolate2/T=3/N=(lay)/F=((fiwv[26] == 3) ? 1 : 1)/Y=normclb_SS normclb
		Wave/D niwv = normclb_SS
		for(i=0; i<lay; i+=1)
			MatrixOP/O tempadc = col(afsclb, i)
			SetScale/P x, dpmin, abs(cs), tempadc
			Variable tempmax = WaveMax(tempadc)
			afsclb[][i] = (fiwv[26] < 3) ? tempadc[p]/ncwv[i] : tempadc[p]/niwv[i]
		endfor
	Endif
	
	SetDataFolder cdf
End

Function fs_amapwin(opnum)
	Variable opnum
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Wave/D afs = Amap
	If(opnum > 0)
		If(WinType("amap_win") == 0)
			Display/W=(43.5,72.5,331.5,353.75)/K=1/N=amap_win as "DPRF-Azimuth Map"
			AppendImage afs; ModifyImage Amap ctab= {*,*,YellowHot,0}
			ModifyGraph margin(left)=45,margin(bottom)=40,margin(right)=17,width=226.772,height=226.772
			ModifyGraph gFont="Times New Roman", gfSize=14, tick=2, mirror=1, standoff=0
			Label left "Azimuthal angle (deg)"; Label bottom "Detector angle (deg)"
		Endif
	else
		If(WinType("amap_win") != 0)
			KillWindow amap_win
		Endif
	Endif
	SetDataFolder cdf
End

Function fs_kmap()
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Svar/Z curamap
		Wave/D/Z fiwv = FS_Info, afs = $curamap
		If(!WaveExists(afs))
			DoAlert 0, "Please select correct ang-map."
			If(V_flag)
				Abort
			Endif
		Endif
		Variable/D i, j, kstep = fiwv[9], lat = fiwv[10], kc = 0.51231 * sqrt(fiwv[0])
		Variable/D ir = DimOffset(afs, 0), rs = DimDelta(afs, 0), ro = DimSize(afs, 0), lr = ir + rs * (ro -1)
		Variable/D ic = DimOffset(afs, 1), cs = DimDelta(afs, 1), co = DimSize(afs, 1), lc = ic + cs * (co-1)
		Variable/D doff = fiwv[6], aoff = fiwv[7], toff = fiwv[8]
		Nvar/Z kxmin, kxmax, kymin, kymax
		Variable kxpnts = (kxmax-kxmin)/kstep + 1
		Variable kypnts = (kymax-kymin)/kstep + 1
		Make/O/D/N=(kxpnts, kypnts) $"kmap" = 0
		Wave/D kfs = $"kmap"
			SetScale/P x, kxmin, kstep, kfs
			SetScale/P y, kymin, kstep, kfs
		for(i=0; i<kxpnts; i+=1)
			for(j=0; j<kypnts; j+=1)
				Variable ckx = kxmin + i * kstep
				Variable cky = kymin + j * kstep
				Variable azi = 180/pi*atan(cky/ckx)
				Variable dprf = 180/pi*asin(ckx/kc/cos(-azi*pi/180))
				Variable azipnt = (azi-ic)/cs, dprfpnt = (dprf-ir)/rs
				If(azipnt >= 0 && azipnt < co && dprfpnt >= 0 && dprfpnt < ro)
					kfs[i][j] = afs[dprfpnt][azipnt]
				else
					kfs[i][j] = 0
				Endif			
			endfor
		endfor
		If(fiwv[20] == 1)
			SetScale/P x, kxmin/(pi/lat), kstep/(pi/lat), kfs
			SetScale/P y, kymin/(pi/lat), kstep/(pi/lat), kfs
		Endif
		If(fiwv[22] == 1)
			Wave/Z siwv = Sym_Info
			If(!WaveExists(siwv))
				Make/O/D/N=(4) Sym_Info = {0, 1, 1, 1}
				Wave/D siwv = Sym_Info
			Endif
			fs_sym(kfs, siwv[1], siwv[2], siwv[3], siwv[0])
		Endif
	SetDataFolder cdf
End

Function fs_kmapwin(opnum)
	Variable opnum
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Wave fiwv = FS_Info, kfs = kmap
	If(opnum > 0)
		If(WinType("kmap_win") == 0)
			Display/W=(43.5,72.5,331.5,353.75)/K=1/N=kmap_win as "k-map"
			AppendImage kfs; ModifyImage kmap ctab= {*,*,YellowHot,0}
			ModifyGraph margin(left)=51,margin(bottom)=40,margin(right)=17,width=226.772,height=226.772
			ModifyGraph gFont="Times New Roman", gfSize=14, tick=2, mirror=1, standoff=0, axRGB=(65535,65535,65535)
		Endif
		If(fiwv[12] == 1)
			Label/W=kmap_win left "\f02k\By\f00\M (Å\\S-1\\M)"
			Label/W=kmap_win bottom "\f02k\Bx\f00\M (Å\\S-1\\M)"
		else
			Label/W=kmap_win left "\f02k\By\f00\M (\F'Symbol'p\F]0/a)"
			Label/W=kmap_win bottom "\f02k\Bx\f00\M (\F'Symbol'p\F]0/a)"
		Endif
	else
		If(WinType("kmap_win") != 0)
			KillWindow kmap_win
		Endif
	Endif
	SetDataFolder cdf
End
		
Function fs_kareawin(opnum)
	Variable opnum
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Svar/Z curamap; Wave/D/Z fiwv = FS_Info, afs = $curamap
		If(!WaveExists(afs))
			fs_amap(); Svar/Z curamap; Wave/D afs = $curamap 
		Endif
		Variable i, co = DimSize(afs, 1)
	If(opnum > 0)
		If(WinType("karea_win") == 0)
			Display/W=(43.5,72.5,331.5,353.75)/K=1/N=karea_win as "k-area"
			SetDataFolder root:FS:kcut	
			for(i=0; i<co; i+=1)	
				Wave kx = $"kx"+num2str(i), ky = $"ky"+num2str(i)
				CheckDisplayed/W=karea_win ywv
				If(V_flag <= 0)
					AppendToGraph/W=karea_win ky vs kx
				Endif
			endfor
			ModifyGraph margin(left)=51,margin(bottom)=40,margin(right)=17,width=226.772,height=226.772
			ModifyGraph gFont="Times New Roman", gfSize=14, tick=2, mirror=1, standoff=0
		Endif
		If(fiwv[20] == 0)
			Label/W=karea_win left "\f02k\By\f00\M (Å\\S-1\\M)"
			Label/W=karea_win bottom "\f02k\Bx\f00\M (Å\\S-1\\M)"
		else
			Label/W=karea_win left "\f02k\By\f00\M (\F'Symbol'p\F]0/a)"
			Label/W=karea_win bottom "\f02k\Bx\f00\M (\F'Symbol'p\F]0/a)"
		Endif		
	else
		If(WinType("karea_win") != 0)
			KillWindow karea_win
			Abort
		Endif
	Endif	
	SetDataFolder cdf
End

// Normalize & Subtract b.g. Setting Panel 
Function fs_nspanel(sw) 
	Variable sw
	String cdf = GetDataFolder(1) 
	SetDataFolder root:FS
		Wave/D fiwv = FS_Info; Nvar/Z ic, lc, cs
		Variable/G tempway = fiwv[26+3*(sw-1)], tempsta = fiwv[27+3*(sw-1)], tempend = fiwv[28+3*(sw-1)]
		String wintitle = StringFromList(sw-1, "fs_nrwin;fs_sbwin")
	If(WinType(wintitle) == 0)
		NewPanel/W=(834,587,1040,680)/N=$wintitle/FLT=2 as StringFromList(sw-1, "Normalize;Subtract b.g.")+" setting"
		GroupBox fsns_gbox1 pos={0,19},size={196,23},frame=0
		SetVariable fsns_svar1 pos={7,22},size={95,16},bodyWidth=60,title="Start :",value= fiwv[27+3*(sw-1)], limits={min(ic,lc), max(ic,lc), cs}
		SetVariable fsns_svar2 pos={106,22},size={89,16},bodyWidth=60,title="End :",value= fiwv[28+3*(sw-1)], limits={min(ic,lc), max(ic,lc), cs}
		CheckBox fsns_cbox1 pos={9,3},size={42,14},title=StringFromList(sw-1, "Area;Const."),value= (fiwv[26+3*(sw-1)] == 1 || fiwv[26+3*(sw-1)] == 3) ? 1: 0,mode=1, proc = fsns_checkproc
		CheckBox fsns_cbox2 pos={66,3},size={51,14},title=StringFromList(sw-1, "Height;Linear"),value= (fiwv[26+3*(sw-1)] == 2 || fiwv[26+3*(sw-1)] == 4) ? 1: 0,mode=1, proc = fsns_checkproc
		CheckBox fsns_cbox3 pos={129,3},size={51,14},title="Smoothly", value= (fiwv[26+3*(sw-1)] > 2) ? 1: 0, proc = fsns_checkproc
		Button fsns_but1 pos={3,45},size={60,18},title="Set",proc=fsns_butproc
		Button fsns_but2 pos={66,45},size={60,18},title="Cancel",proc=fsns_butproc
		Button fsns_but3 pos={129,45},size={60,18},title="Revert",proc=fsns_butproc
	Endif
	SetDataFolder cdf
End
	
Function fsns_butproc(ctrlName) : ButtonControl
	String ctrlName
	Variable index = str2num(ReplaceString("fsns_but", ctrlName, ""))
	Variable sw = (WinType("fs_nrwin") != 0) ? 1 : 2
	String cdf = GetDataFolder(1) 
	SetDataFolder root:FS
		Wave/D fiwv = FS_Info
		Nvar/Z tempway, tempsta, tempend, ic, lc
		If(index < 3)
			If(index == 2)
				fiwv[26+3*(sw-1), 28+3*(sw-1)] = {tempway, tempsta, tempend}
			Endif
			KillVariables/Z tempway, tempsta, tempend
			KillWindow $StringFromList(sw-1, "fs_nrwin;fs_sbwin")
		else
			fiwv[27+3*(sw-1), 28+3*(sw-1)] = {ic, lc}
		Endif
	SetDataFolder cdf
End

Function fsns_checkproc(ctrlName, checked) : CheckBoxControl
	String ctrlName; Variable checked
	String cdf = GetDataFolder(1) 
	SetDataFolder root:FS
		Wave/D fiwv = FS_Info
		Variable sw = (WinType("fs_nrwin") != 0) ? 1 : 2
		Variable index = str2num(ReplaceString("fsns_cbox", ctrlName, "")), cboxbit
		If(index < 3)
			CheckBox fsns_cbox1 value= (index == 1) ? 1: 0, win = $StringFromList(sw-1, "fs_nrwin;fs_sbwin")
			CheckBox fsns_cbox2 value= (index == 2) ? 1: 0, win = $StringFromList(sw-1, "fs_nrwin;fs_sbwin")		 
		Endif
		ControlInfo/W=$StringFromList(sw-1, "fs_nrwin;fs_sbwin") fsns_cbox1; cboxbit += V_Value
		ControlInfo/W=$StringFromList(sw-1, "fs_nrwin;fs_sbwin") fsns_cbox2; cboxbit += 2*V_Value
		ControlInfo/W=$StringFromList(sw-1, "fs_nrwin;fs_sbwin") fsns_cbox3; cboxbit += 2*V_Value
		fiwv[26+3*(sw-1)] = cboxbit
	SetDataFolder cdf
End

// Symmetrize Setting Panel
Function fs_sympanel()
	String cdf = GetDataFolder(1), pnlist = "\"+;-\"", clist = "\"CW;CCW\""
	SetDataFolder root:FS
		Wave/Z siwv = Sym_Info
		If(!WaveExists(siwv))
			Make/O/D/N=(4) Sym_Info = {0, 1, 1, 1}
			Wave/D siwv = Sym_Info
		Endif
		Variable/G tempang = siwv[0], tempxd = siwv[1], tempyd = siwv[2], tempad = siwv[3]
	If(WinType("symfs_gui") == 0)
		NewPanel /K=1 /W=(609,453,781,602)/N=symfs_gui/K=1/FLT=2 as "Symmetrization setting"
		GroupBox symfs_gbox1,pos={0,22},size={165,76},frame=0
		SetVariable symfs_svar1,pos={12,3},size={142,16},bodyWidth=40,title="Symmetrize Angle :",limits={0,360,1},value= root:FS:Sym_Info[0]
		PopupMenu symfs_pop2,pos={30,27},size={125,20},bodyWidth=60,title="x direction :",mode=1,popvalue=StringFromList(siwv[1]+1, "-;;+"),value= #"\"+;-\"",proc=fssym_poproc
		PopupMenu symfs_pop3,pos={30,51},size={125,20},bodyWidth=60,title="y direction :",mode=1,popvalue=StringFromList(siwv[2]+1, "-;;+"),value= #"\"+;-\"",proc=fssym_poproc
		PopupMenu symfs_pop4,pos={9,75},size={146,20},bodyWidth=60,title="angle direction :",mode=2,popvalue=StringFromList(siwv[3]+1, "CCW;;CW"),value= #"\"CW;CCW\"",proc=fssym_poproc
		Button symfs_but1,pos={2,100},size={50,20},title="Set",proc=fssym_butproc
		Button symfs_but2,pos={56,100},size={50,20},title="Cancel",proc=fssym_butproc
		Button symfs_but3,pos={111,100},size={50,20},title="Revert",proc=fssym_butproc
	Endif
	SetDataFolder cdf
End

Function fssym_poproc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName, popStr; Variable popNum
	Variable index = str2num(ReplaceString("symfs_pop", ctrlName, ""))
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Wave/Z siwv = Sym_Info
		If(popNum == 1)
			siwv[index-1] = 1
		else
			siwv[index-1] = -1
		Endif
	SetDataFolder cdf
End

Function fssym_butproc(ctrlName) : ButtonControl
	String ctrlName
	Variable index = str2num(ReplaceString("symfs_but", ctrlName, ""))
	String cdf = GetDataFolder(1)
	SetDataFolder root:FS
		Wave/Z siwv = Sym_Info
		Nvar/Z tempang, tempxd, tempyd, tempad
	switch(index)
		case 1:
			KillWindow symfs_gui
			break
		case 2:
			siwv[0,3] = {tempang, tempxd, tempyd, tempad}
			KillVariables/Z tempang, tempxd, tempyd, tempad
			KillWindow symfs_gui
			break
		case 3:
			siwv[0,3] = {tempang, tempxd, tempyd, tempad}
			PopupMenu symfs_pop2 mode = (siwv[1] == 1) ? 1 : 2, win = symfs_gui 
			PopupMenu symfs_pop3 mode = (siwv[2] == 1) ? 1 : 2, win = symfs_gui
			PopupMenu symfs_pop4 mode = (siwv[3] == 1) ? 1 : 2, win = symfs_gui
			break
	endswitch
	SetDataFolder cdf
End

// Symmetrize
Function fs_sym(fs, xdir, ydir, azidir, baseang)
	Wave/D fs
	Variable xdir, ydir, azidir, baseang
	baseang = abs(baseang)
		Variable/D ir = DimOffset(fs, 0), rs = DimDelta(fs, 0), ro = DimSize(fs, 0), lr = ir + rs * (ro -1)
		Variable/D ic = DimOffset(fs, 1), cs = DimDelta(fs, 1), co = DimSize(fs, 1), lc = ic + cs * (co-1)
	Variable cxsta = 0, cxend = (xdir == 1) ? lr : ir
	Variable cysta = 0, cyend = (ydir == 1) ? lc : ic
	
	String fsname = NameOfWave(fs)
	Variable cropro = round((cxend-cxsta)/rs+1), cropco = round((cyend-cysta)/cs+1)
	Make/O/D/N=(cropro, cropco) $fsname+"_crop"
	// Duplicate/O/R=(cxsta, cxend)(cysta, cyend) fs, $fsname+"_crop"
	Wave/D cfs = $fsname+"_crop"
		SetScale/P x, cxsta, rs, cfs; SetScale/P y, cysta, cs, cfs
	Variable i, j
		Variable/D cir = DimOffset(cfs, 0), crs = DimDelta(cfs, 0), cro = DimSize(cfs, 0), clr = cir + crs * (cro -1) 
		Variable/D cic = DimOffset(cfs, 1), ccs = DimDelta(cfs, 1), cco = DimSize(cfs, 1), clc = cic + ccs * (cco -1)
	for(i=0; i<cro; i+=1)
		for(j=0; j<cco; j+=1)
		 	Variable cx = abs(cir + i * crs), cy = abs(cic + j * ccs)
			If(baseang == 90)
				cfs[i][j] = cfs[i][j]
			else
				If(xdir > 0 && ydir > 0)
					If(azidir < 0) // ccw
						cfs[i][j] = (cy <= cx *tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 // cfs[i][j] : 0
					else // cw
						cfs[i][j] = (cy >= cx /tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 //
					Endif
				elseif(xdir < 0 && ydir > 0)
					If(azidir < 0) // ccw
						cfs[i][j] = (cy > cx / tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 //
					else // cw
						cfs[i][j] = (cy < cx * tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 //
					Endif
				elseif(xdir < 0 && ydir < 0)
					If(azidir < 0) // ccw
						cfs[i][j] = (cy < cx * tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 //
					else // cw
						cfs[i][j] = (cy > cx / tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 //
					Endif
				elseif(xdir > 0 && ydir < 0)
					If(azidir < 0) // ccw
						cfs[i][j] = (cy > cx / tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 //
					else // cw
						cfs[i][j] = (cy < cx * tan(baseang*pi/180)) ? interp2D(fs, cx, cy) : 0 //
					Endif
				Endif
			Endif
		endfor
	endfor
	
	// Rescale to x+ & y+
		SetScale/P x, cir*xdir, crs*xdir, cfs
		SetScale/P y, cic*ydir, ccs*ydir, cfs
	// Rotate 
		Variable rotnum = 360/baseang
		Make/O/D/N=(2*cro-1, 2*cco-1)  $fsname+"_sym" = 0
		Wave symfs = $fsname+"_sym"
		SetScale/P x, -abs(max(abs(cir), abs(clr))), abs(crs), symfs
		SetScale/P y, -abs(max(abs(cic), abs(clc))), abs(ccs), symfs
	//
		Variable/D sir = DimOffset(symfs, 0), srs = DimDelta(symfs, 0), sro = DimSize(symfs, 0)
		Variable/D sic = DimOffset(symfs, 1), scs = DimDelta(symfs, 1), sco = DimSize(symfs, 1)
	Variable azi
	for(i=0; i<sro; i+=1)
		for(j=0; j<sco; j+=1)
			cx = sir + i * srs; cy = sic + j * scs
			If(cx >= 0 && cy >= 0)
				azi = 180/pi*atan(cy/cx)
			elseif(cx <= 0 && cy >= 0)
				azi = 180 + 180/pi*atan(cy/cx)
			elseif(cx < 0 && cy < 0)
				azi = 180 + 180/pi*atan(cy/cx)
			elseif(cx >= 0 && cy <= 0)
				azi = 360 + 180/pi*atan(cy/cx)
			Endif
			If(cx == 0 && cy == 0)
				azi = 0
			Endif
			Variable factor = trunc(azi/baseang)
			Variable backang = (mod(factor, 2) == 0) ? factor*baseang : 2*(azi-factor*baseang) + (factor-1)*baseang
			Variable ox = cx * cos(backang*pi/180) + cy * sin(backang*pi/180)
			Variable oy = -cx * sin(backang*pi/180) + cy * cos(backang*pi/180)
			Variable oxpnt = (ox-cir)/crs, oypnt = (oy-cic)/ccs
			//If(oxpnt >= 0 && oxpnt < cro && oypnt >= 0 && oypnt < cco)
			symfs[i][j] = (NumType(Interp2D(fs, ox, oy)) != 2) ? Interp2D(fs, ox, oy) : 0
			
//			
//			If(oxpnt >= 0 && oxpnt < cro && oypnt >= 0 && oypnt < cco)
//				symfs[i][j] = cfs[oxpnt][oypnt]
//			else
//				symfs[i][j] = 0
//			Endif			
		endfor
	endfor
End
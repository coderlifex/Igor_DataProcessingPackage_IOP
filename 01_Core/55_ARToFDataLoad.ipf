#pragma rtGlobals=1		// Use modern global access method.
#include <All Gizmo Procedures>
// Code test by Patrik Karlsson, VG Scienta AB

macro ReadARToFStreamed()

string CollectInfoString

string workingDirectory = ""
string acquisitionDirectory = ""
///string AnalysisName = "test"

///-------------------------------------
controlinfo/W=ARToFDataLoad artofdataname
string AnalysisName=S_Value
///----------By JXW---------------------

string parsedParameterList
string parsedBinMatrix

// analysis.cfg
// [general]
variable lensIterations
variable spectrumBeginEnergy
variable spectrumEndEnergy
variable spectrumChannelWidthEnergy
variable lensLowEdgeEnergyStep
variable lensSteps
variable userSpectrumEndEnergy
variable userLensLowEdgeEnergyStep
string acquisitionMode = ""
variable centerEnergy

//[lensmode]
variable lensK
variable maxTheta

// Sweep CRR calculated (recalculated) variables
variable lensLowEdgeBeginE
variable lensLowEdgeEnergyStep2
variable lensStepChannelMultiple
variable spectrumLowEdgeBeginE
variable spectrumEndEnergy2
variable spectrumChannels
variable lensSteps2
variable spectrum1stIndexOffset
variable sliceEkinBegin
variable sliceEkinEnd
variable sliceEkinBeginIndex
variable sliceEkinEndIndex
variable sliceSpectrumChannels

// Constant offset in parameterWave structure
variable allocatedBlockSize = 40

// Local help variables
variable tmp_delta
string textLine
string subString = ""
variable refNum
variable ii, jj

variable timerRefNumber
variable microSeconds

// read parameterList to allocate and scale the BinMatrix
// 0		manipulator rot (beta)
// 1		manipulator tilt (alpha)
// 2		work function
// 3 		k1 begin
// 4 		k1 end
// 5 		number of channels in k1
// 6 		k2 begin
// 7 		k2 end
// 8 		number of channels in k2
// 9 		Eb begin energy
// 10 	Eb end energy
// 11	number of channels in Eb
// 12	photon energy
// 13	k1 channelWidth (calculated)
// 14	k2 channelWidth (calculated)
// 15	Eb channelWidth (calculated)
// 16	centerEnergy (read)
// 17	lensK (read)
// 18	maxTheta (read)
// 19	detector correction rotation (gamma)
// 20	post Euler k-space rotation (kappa)
// 21	use Euler angels in calculation (>0 if activated)

// Open dialog to select an analysis.cfg file.
// The file is not opened at this stage. Dialog only /D
// The loop removes the file name to get the path to the folder. 
Open/D/R/T=".cfg"  refNum
silent 1
textLine = S_fileName
jj = strlen(textLine)-strlen(":analysis.cfg")
ii = 0
do
	workingDirectory[ii] = textLine[ii]
	ii = ii+1
while(ii<jj)


parsedParameterList = AnalysisName + "_ParameterList"
parsedBinMatrix = AnalysisName + "_BinMatrix"

// Set the symbolic path to the analyzed_# folder.
// N.B, this is a global setting in igor that will be used by the under laying functions!
NewPath/O ArtofWD workingDirectory;
// Read information from the analysis.cfg
open /R /Z=1 /P=ArtofWD refNum as "analysis.cfg"
FStatus refNum
if (!V_Flag)
	abort "File error. Could not open analysis.cfg"
endif
lensIterations = ReadConfigParameter(refNum, "[general]", "lensIterations")
close refNum

// Read information from the acquisition.cfg, which has automatically been copied into the analysis folder
open /R /Z=1 /P=ArtofWD refNum as "acquisition.cfg"
FStatus refNum
if (!V_Flag)
	abort "File error. Could not open acquisition.cfg"
endif
spectrumBeginEnergy = ReadConfigParameter(refNum, "[general]", "spectrumBeginEnergy")
spectrumEndEnergy = ReadConfigParameter(refNum, "[general]", "spectrumEndEnergy")
spectrumChannelWidthEnergy = ReadConfigParameter(refNum, "[general]", "spectrumChannelWidthEnergy")
lensLowEdgeEnergyStep = ReadConfigParameter(refNum, "[general]", "lensLowEdgeEnergyStep")
lensSteps = ReadConfigParameter(refNum, "[general]", "lensSteps")
userSpectrumEndEnergy = ReadConfigParameter(refNum, "[general]", "userSpectrumEndEnergy")
userLensLowEdgeEnergyStep = ReadConfigParameter(refNum, "[general]", "userLensLowEdgeEnergyStep")
centerEnergy  = ReadConfigParameter(refNum, "[general]", "centerEnergy")
lensK  = ReadConfigParameter(refNum, "[lensmode]", "lensK")
maxTheta  = ReadConfigParameter(refNum, "[lensmode]", "maxTheta")
acquisitionMode = ReadConfigString(refNum, "[general]", "acquisitionMode")
close refNum
$parsedParameterList[16] = centerEnergy
$parsedParameterList[17] = lensK
$parsedParameterList[18] = maxTheta

print acquisitionMode

timerRefNumber = startMStimer

if ( strsearch(acquisitionMode,"fix",0) > -1)
	print "Fix mode"
	// Set up the BinMatrix, allocate memory, Set scales
	make /O /N=($parsedParameterList[5],$parsedParameterList[8],$parsedParameterList[11]) $parsedBinMatrix
	$parsedBinMatrix = $parsedBinMatrix*0

	tmp_delta = ($parsedParameterList[4]-$parsedParameterList[3])/$parsedParameterList[5]
	SetScale/P x ($parsedParameterList[3]+(tmp_delta/2)  ),tmp_delta, $parsedBinMatrix
	$parsedParameterList[13] = tmp_delta

	tmp_delta = ($parsedParameterList[7]-$parsedParameterList[6])/$parsedParameterList[8]
	SetScale/P y ($parsedParameterList[6]+(tmp_delta/2)  ),tmp_delta, $parsedBinMatrix
	$parsedParameterList[14] = tmp_delta

	// Internally the z scale is in Ek
	//Because Eb is signed minus, Ek should be Ek=hv+Eb-W ----by JXW
	
	sliceEkinBegin = $parsedParameterList[12]-$parsedParameterList[10]-$parsedParameterList[2] // Ek = hv-Eb(end)-W
	sliceEkinEnd = $parsedParameterList[12]-$parsedParameterList[9]-$parsedParameterList[2] // Ek = hv-Eb(begin)-W
	//sliceEkinBegin = $parsedParameterList[12]+$parsedParameterList[9]-$parsedParameterList[2] // Ek = hv-Eb(end)-W
	//sliceEkinEnd = $parsedParameterList[12]+$parsedParameterList[10]-$parsedParameterList[2] // Ek = hv-Eb(begin)-W

	tmp_delta = (sliceEkinEnd-sliceEkinBegin)/$parsedParameterList[11]
	SetScale/P z (sliceEkinBegin+(tmp_delta/2)  ),tmp_delta, $parsedBinMatrix
	$parsedParameterList[15] = tmp_delta 
	
	
	// Read the files for fix mode. The ReadARToFLoopFiles function will call the 
	// ReadARToFStraeamedOperateBin function
	print ReadARToFLoopFiles($parsedParameterList, $parsedBinMatrix, lensIterations)
	// If "Ok", then the data matrix is now complete!
	// Set scale to binding
	SetScale/P z ($parsedParameterList[10]-(tmp_delta/2)  ),(-tmp_delta),"Eb [eV]", $parsedBinMatrix	
	//SetScale/P z ($parsedParameterList[9]-(tmp_delta/2)  ),(tmp_delta), $parsedBinMatrix	
endif

if (  strsearch(acquisitionMode,"sweep",0) > -1)
	print "Sweep mode"
	// This version uses the spectrumChannelWidthEnergy from the acquisition.cfg
	// The algorithm keeps the kinetic energy way of thinking as far as possible
	
	// Create waves of information about the energy windows.
	// The following section mirrors some code in the asc program.
	// ******************* MIRROR  START **************************************
	lensLowEdgeBeginE = calculateLensLowEdgeBeginE(spectrumBeginEnergy,spectrumChannelWidthEnergy, lensK)
	
	lensLowEdgeEnergyStep2 = adaptLensLowEdgeEnergyStep(userLensLowEdgeEnergyStep,spectrumChannelWidthEnergy)
	if (lensLowEdgeEnergyStep2 != lensLowEdgeEnergyStep)
		print "Warning (lensLowEdgeEnergyStep), this should never happen! Round off problems?"
	endif
	
	lensStepChannelMultiple = floor (lensLowEdgeEnergyStep / spectrumChannelWidthEnergy)
	spectrumLowEdgeBeginE = spectrumBeginEnergy - 0.5 * spectrumChannelWidthEnergy
	
	spectrumChannels = calculateSpectrumChannels(spectrumChannelWidthEnergy,spectrumLowEdgeBeginE,userSpectrumEndEnergy)
	spectrumEndEnergy2 = spectrumBeginEnergy+(spectrumChannels-1)*spectrumChannelWidthEnergy
	if (spectrumEndEnergy2 != spectrumEndEnergy)
		print "Warning (spectrumEndEnergy), this should never happen! Round off problems?"
	endif

	lensSteps2 = calculateLensSteps(spectrumChannelWidthEnergy,spectrumLowEdgeBeginE,spectrumChannels, lensLowEdgeBeginE,lensLowEdgeEnergyStep)
	if (lensSteps2 != lensSteps)
		print "Warning (lensSteps), this should never happen! Round off problems?"
	endif
	
	spectrum1stIndexOffset = floor ((lensLowEdgeBeginE * lensK / (1 - 0.5 * lensK)) / spectrumChannelWidthEnergy) -1;
		
	make /O /N=(lensSteps) spectrumWindowLowEdgeE
	make /O /N=(lensSteps) lensWindowEkin
	make /O /N=(lensSteps) spectrumWindowIndexOffset
	make /O /N=(lensSteps) spectrumWindowNoOfChannels
	make /O /N=(spectrumChannels) represented
	make /O /N=(8) parameterWave
	
	parameterWave[0] = lensLowEdgeBeginE
	parameterWave[1]=  lensLowEdgeEnergyStep
	parameterWave[2] = lensK  
 	parameterWave[3] = lensStepChannelMultiple
	parameterWave[4] = spectrum1stIndexOffset 
	parameterWave[5] = spectrumChannelWidthEnergy
	parameterWave[6] = lensSteps
	parameterWave[7] = spectrumChannels
	
	
	
	kenergyWindow(spectrumWindowLowEdgeE,lensWindowEkin, spectrumWindowIndexOffset,spectrumWindowNoOfChannels,represented, parameterWave )
	// ******************* MIRROR  END **************************************
	// End of the section which mirrors some code in the asc program
	
	// Prepare to set up the bin matrix and indeces needed for the SweepCRR
	sliceEkinBegin = $parsedParameterList[12]-$parsedParameterList[10]-$parsedParameterList[2] // Ek = hv-Eb(end)-W
	sliceEkinEnd = $parsedParameterList[12]-$parsedParameterList[9]-$parsedParameterList[2] // Ek = hv-Eb(begin)-W
	//sliceEkinBegin = $parsedParameterList[12]+$parsedParameterList[9]-$parsedParameterList[2] // Ek = hv-Eb(end)-W
	//sliceEkinEnd = $parsedParameterList[12]+$parsedParameterList[10]-$parsedParameterList[2] // Ek = hv-Eb(begin)-W
	
	// First tweeking, correcting for boundaries
	if (sliceEkinBegin<spectrumBeginEnergy)
		sliceEkinBegin=spectrumBeginEnergy
	endif
	if (sliceEkinEnd>spectrumEndEnergy)
		sliceEkinEnd=spectrumEndEnergy
	endif
	// Second tweeking, fitting into the pre-determined system of energy channels
	ii = floor( (sliceEkinBegin-spectrumBeginEnergy)/spectrumChannelWidthEnergy )
	if (ii>0)
		sliceEkinBeginIndex = ii
	else
		sliceEkinBeginIndex = 0
	endif
	//print "sliceEkinBeginIndex " + num2str(sliceEkinBeginIndex)
	sliceEkinBegin = spectrumBeginEnergy+sliceEkinBeginIndex*spectrumChannelWidthEnergy
	//print "sliceEkinBegin (fully adapted) " + num2str(sliceEkinBegin)
	ii = ceil( (sliceEkinEnd-spectrumBeginEnergy)/spectrumChannelWidthEnergy )
	if (ii<spectrumChannels)
		sliceEkinEndIndex = ii
	else
		sliceEkinEndIndex = spectrumChannels-1
	endif
	//print "sliceEkinEndIndex " + num2str(sliceEkinEndIndex)
	sliceEkinEnd = spectrumBeginEnergy+sliceEkinEndIndex*spectrumChannelWidthEnergy
	//print "sliceEkinEnd (fully adapted) " + num2str(sliceEkinEnd)
	
	sliceSpectrumChannels = sliceEkinEndIndex-sliceEkinBeginIndex+1
	
	// Set up the BinMatrix, allocate memory, Set scales (kinetic energy)
	make /O /N=($parsedParameterList[5],$parsedParameterList[8],sliceSpectrumChannels) $parsedBinMatrix
	$parsedBinMatrix = $parsedBinMatrix*0

	tmp_delta = ($parsedParameterList[4]-$parsedParameterList[3])/$parsedParameterList[5]
	SetScale/P x ($parsedParameterList[3]+(tmp_delta/2)  ),tmp_delta,"k1 [1/Å]", $parsedBinMatrix
	$parsedParameterList[13] = tmp_delta

	tmp_delta = ($parsedParameterList[7]-$parsedParameterList[6])/$parsedParameterList[8]
	SetScale/P y ($parsedParameterList[6]+(tmp_delta/2)  ),tmp_delta,"k2 [1/Å]", $parsedBinMatrix
	$parsedParameterList[14] = tmp_delta

	// Internally the z scale is in Ek
	SetScale/P z sliceEkinBegin,spectrumChannelWidthEnergy,"Ek [eV]", $parsedBinMatrix
	$parsedParameterList[15] = spectrumChannelWidthEnergy
	
	// Produce a new parameterWave to be used by the ReadARToFStreamedSweepCRR function (and subfunctions)
	make /O /N=(120) parameterWave
	// First section, copy the parameter list
	ii=0
	do
		parameterWave[ii] = $parsedParameterList[ii]
		ii+=1
	while (ii<23)
	// Second section, add more useful information
	parameterWave[allocatedBlockSize+0] = lensLowEdgeBeginE
	parameterWave[allocatedBlockSize+1] =  lensLowEdgeEnergyStep
	parameterWave[allocatedBlockSize+2] = lensK  
 	parameterWave[allocatedBlockSize+3] = lensStepChannelMultiple
	parameterWave[allocatedBlockSize+4] = spectrum1stIndexOffset 
	parameterWave[allocatedBlockSize+5] = spectrumBeginEnergy
	parameterWave[allocatedBlockSize+6]  = spectrumEndEnergy
	parameterWave[allocatedBlockSize+7] = spectrumChannelWidthEnergy
	parameterWave[allocatedBlockSize+8] = lensSteps
	parameterWave[allocatedBlockSize+9] = spectrumChannels
	parameterWave[allocatedBlockSize+10] = lensIterations
	parameterWave[allocatedBlockSize+11] = sliceEkinBegin
	parameterWave[allocatedBlockSize+12] = sliceEkinEnd
	parameterWave[allocatedBlockSize+13] = sliceEkinBeginIndex
	parameterWave[allocatedBlockSize+14] = sliceEkinEndIndex
	parameterWave[allocatedBlockSize+15] = sliceSpectrumChannels
	
	print ReadARToFStreamedSweepCRR(spectrumWindowLowEdgeE, lensWindowEkin, spectrumWindowIndexOffset, spectrumWindowNoOfChannels, represented,parameterWave, $parsedBinMatrix  )
	// Set scale to binding
	SetScale/P z ($parsedParameterList[12]-sliceEkinBegin-$parsedParameterList[2]),(-spectrumChannelWidthEnergy),"Eb [eV]", $parsedBinMatrix
	
	silent 0
	killwaves spectrumWindowLowEdgeE,lensWindowEkin, spectrumWindowIndexOffset,spectrumWindowNoOfChannels,represented, parameterWave
	
endif

microSeconds = stopMStimer(timerRefNumber)
print "time elapsed = ",microSeconds, "micro s"

end

// *******************************************************************************************************************************************
// **************** SWEEP CRR BUILD UP FUNCTIONS ******************************************************************************
// *******************************************************************************************************************************************

// *******************************************************************************************************************************************

function calculateLensLowEdgeBeginE(spectrumBeginE,spectrumChannelWidthE, lensK)
// input
variable spectrumBeginE
variable spectrumChannelWidthE
variable lensK

// Temporary help variables
variable lowEdgeE1
variable lowEdgeE2
variable highEdgeE2
variable noOfChannels
variable restE

lowEdgeE1 = (1 - lensK) * spectrumBeginE
noOfChannels = floor ((spectrumBeginE - lowEdgeE1) / spectrumChannelWidthE)
restE = (spectrumBeginE-lowEdgeE1) - noOfChannels*spectrumChannelWidthE
lowEdgeE2 = lowEdgeE1+restE - 1.5 * spectrumChannelWidthE

variable ii = 0
do
	highEdgeE2 = (lowEdgeE2 / (1 - 0.5 * lensK)) * (1 + 0.5 * lensK)
	noOfChannels = floor ((highEdgeE2 - lowEdgeE2) / spectrumChannelWidthE)
	highEdgeE2 = lowEdgeE2 + noOfChannels*spectrumChannelWidthE
	ii += 1
	if (highEdgeE2 > spectrumBeginE)
		break
	else
		lowEdgeE2 += spectrumChannelWidthE
	endif
while (1)

return lowEdgeE2

end

// *******************************************************************************************************************************************

function calculateLensSteps(spectrumChannelWidthE,spectrumLowEdgeBeginE,spectrumChannelsE, lensLowEdgeBeginE,lensLowEdgeEnergyStep)

// input
variable spectrumChannelWidthE
variable spectrumLowEdgeBeginE
variable spectrumChannelsE
variable lensLowEdgeBeginE
variable lensLowEdgeEnergyStep

// output
variable lensSteps

// Temporary help variables
variable lensLowEdgeEnergyWindow
variable spectrumHighEdgeEndE

spectrumHighEdgeEndE = spectrumLowEdgeBeginE + spectrumChannelsE * spectrumChannelWidthE
lensSteps = 0

do
	lensSteps+=1
	lensLowEdgeEnergyWindow = lensLowEdgeBeginE + lensLowEdgeEnergyStep * lensSteps
while(lensLowEdgeEnergyWindow < spectrumHighEdgeEndE)

return lensSteps

end

// *******************************************************************************************************************************************

function adaptLensLowEdgeEnergyStep(lensLowEdgeEnergyStep,spectrumChannelWidthE)

variable lensLowEdgeEnergyStep
variable spectrumChannelWidthE

// temporary help variables
variable tmp
variable noOfChannels

noOfChannels = floor (lensLowEdgeEnergyStep / spectrumChannelWidthE)
tmp = noOfChannels * spectrumChannelWidthE

if ((lensLowEdgeEnergyStep - tmp) > (tmp+spectrumChannelWidthE - lensLowEdgeEnergyStep))
	lensLowEdgeEnergyStep = tmp + spectrumChannelWidthE
else
	lensLowEdgeEnergyStep = tmp
endif

return lensLowEdgeEnergyStep

end

// *******************************************************************************************************************************************

function calculateSpectrumChannels(spectrumChannelWidthE,spectrumLowEdgeBeginE,spectrumEndE)
// input
variable spectrumChannelWidthE
variable spectrumLowEdgeBeginE
variable spectrumEndE

// output
variable spectrumChannelsE

// temporary variables 
variable spectrumWidth
variable spectrumEndE_lowSide
variable spectrumEndE_highSide

spectrumWidth = spectrumEndE - (spectrumLowEdgeBeginE + 0.5 * spectrumChannelWidthE)
spectrumChannelsE = floor(spectrumWidth / spectrumChannelWidthE) + 1
spectrumEndE_lowSide = spectrumLowEdgeBeginE + (spectrumChannelsE - 1) * spectrumChannelWidthE + 0.5 * spectrumChannelWidthE
spectrumEndE_highSide = spectrumEndE_lowSide+spectrumChannelWidthE
    
if ((spectrumEndE - spectrumEndE_lowSide) > (spectrumEndE_highSide - spectrumEndE) )
	spectrumChannelsE += 1
endif

return spectrumChannelsE

end

// *******************************************************************************************************************************************

function kenergyWindow(spectrumWindowLowEdgeE,lensWindowEkin, spectrumWindowIndexOffset,spectrumWindowNoOfChannels,represented, parameterWave )

wave spectrumWindowLowEdgeE
wave lensWindowEkin
wave spectrumWindowIndexOffset
wave spectrumWindowNoOfChannels
wave represented
wave parameterWave

variable lensLowEdgeBeginE = parameterWave[0]
variable lensLowEdgeEnergyStep  = parameterWave[1]
variable lensK  = parameterWave[2]
variable lensStepChannelMultiple  = parameterWave[3]
variable spectrum1stIndexOffset  = parameterWave[4]
variable spectrumChannelWidthEnergy  = parameterWave[5]
variable lensSteps  = parameterWave[6]
variable spectrumChannels  = parameterWave[7]
// Local temporary variables
variable ii,jj
variable jmin = 0;
variable jmax = 0;
represented = represented*0
ii = 0
jj = 0
do
	spectrumWindowLowEdgeE[ii] = lensLowEdgeBeginE+ii*lensLowEdgeEnergyStep
	lensWindowEkin[ii] = spectrumWindowLowEdgeE[ii] / (1 - 0.5*lensK)
	spectrumWindowIndexOffset[ii] = lensStepChannelMultiple * ii - spectrum1stIndexOffset
	spectrumWindowNoOfChannels[ii] = floor ( (lensWindowEkin[ii] * lensK) / spectrumChannelWidthEnergy )
	
	
	jmin = spectrumWindowIndexOffset[ii]
	if (jmin < 0)
		jmin = 0
	endif
	jmax = spectrumWindowIndexOffset[ii]+spectrumWindowNoOfChannels[ii]-1
	if ( (jmax + 1) > spectrumChannels )
		jmax = spectrumChannels - 1
	endif
    	jj = jmin
    	if (jj<(jmax+1))
    		do
    			represented[jj] += 1
    			jj = jj+1
    		while (jj<(jmax+1))
    	endif
   	
	ii = ii+1
while (ii<lensSteps)


end

//////---------------------------------------ReadConfigParameter--------------
// Returns the variable value. Returns NaN if the variable is not found.
// RefNum is a reference to an already opened file.
// Patrik Karlsson, VG Scienta AB, 2010
function ReadConfigParameter(refNum, block, parameter)
variable refNum
string block
string parameter

variable parameterValue = NaN
string subString = ""
variable ii
variable linesRead
variable maxNumberOfLines = 1000
string textLine
variable marker = 0

FSetPos refNum, 0 // Always start from the begining of the file.

//Go to block
do
	FReadLine refNum, textLine
	linesRead = linesRead + 1
	if (stringmatch(textLine,(block+"*"))) // Example block "[general]"
		marker = 1
		// Find keyword parameter
		do
			FReadLine refNum, textLine
			linesRead = linesRead + 1
			//print textLine
			if (stringmatch(textLine,(parameter+"=*"))) // Example parameter "spectrumBeginEnergy"
				marker = marker + 1
				ii = 0
				// Read lensIterations parameter value
				do
					subString[ii] = textLine[strlen(parameter+"=")+ii]
					ii = ii + 1
				while (strlen(parameter+"=")+ii<strlen(textLine)) 
				parameterValue = str2num(subString)
			endif	
		while (marker<2 && linesRead<maxNumberOfLines) 
	endif
while (marker<1 && linesRead<maxNumberOfLines)

return parameterValue

end

//////---------------------------------------ReadConfigParameter--------------

/////---------------------------------------ReadARToFXYT----------------------
macro ReadARToFXYT(imageType)
variable imageType

// imageType
// 1 => 1D intensity vs. time
// 2 => 2D xy detector image
// 3 => 3D xyt matrix
// 4 => 2D tx
// 5 => 2D ty

string CollectInfoString

string workingDirectory = ""
string acquisitionDirectory = ""
string AnalysisName = "xyt"
string parsedParameterList
string parsedBinMatrix

// analysis.cfg
// [general]
variable lensIterations

// Constant offset in parameterWave structure
variable allocatedBlockSize = 40

// Local help variables
variable tmp_delta
string textLine
string subString = ""
variable refNum
variable ii, jj

if (imageType< 1 || imageType>5 )
	abort "no such imagetype"
endif

// Open dialog to select an analysis.cfg file.
// The file is not opened at this stage. Dialog only /D
// The loop removes the file name to get the path to the folder. 
Open/D/R/T=".cfg"  refNum
silent 1
textLine = S_fileName
jj = strlen(textLine)-strlen(":acquisition.cfg")
ii = 0
do
	workingDirectory[ii] = textLine[ii]
	ii = ii+1
while(ii<jj)

print workingDirectory

parsedParameterList = AnalysisName + "_ParameterList"
parsedBinMatrix = AnalysisName + "_BinMatrix"

$parsedParameterList[12] = imageType
// Set the symbolic path to the acquisition folder.
// N.B, this is a global setting in igor that will be used by the under laying functions!
NewPath/O ArtofWD workingDirectory;
// Read information from the acquisition.cfg
open /R /Z=1 /P=ArtofWD refNum as "acquisition.cfg"
FStatus refNum
if (!V_Flag)
	abort "File error. Could not open analysis.cfg"
endif
	
lensIterations = ReadConfigParameter(refNum, "[general]", "lensIterations")

close refNum

// 0 begin_x
// 1 end_x
// 2 channels_x
// 3 begin_y
// 4 end_y
// 5 channels_y
// 6 begin_t
// 7 end_t
// 8 channels_t
// 9 calculated x delta
// 10 calculated y delta
// 11 calculated t delta

// Set up the BinMatrix, allocate memory, Set scales

if (imageType == 3) // 3D xyt
	
	make /O /N=($parsedParameterList[2],$parsedParameterList[5],$parsedParameterList[8]) $parsedBinMatrix
	$parsedBinMatrix = $parsedBinMatrix*0

	tmp_delta = ($parsedParameterList[1]-$parsedParameterList[0])/$parsedParameterList[2]
	SetScale/P x ($parsedParameterList[0]+(tmp_delta/2)  ),tmp_delta,"x [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[9] = tmp_delta

	tmp_delta = ($parsedParameterList[4]-$parsedParameterList[3])/$parsedParameterList[5]
	SetScale/P y ($parsedParameterList[3]+(tmp_delta/2)  ),tmp_delta,"y [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[10] = tmp_delta

	tmp_delta = ($parsedParameterList[7]-$parsedParameterList[6])/$parsedParameterList[8]
	SetScale/P z ($parsedParameterList[6]+(tmp_delta/2)  ),tmp_delta,"t [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[11] = tmp_delta
endif

if (imageType == 2) // 2D detector image
	make /O /N=($parsedParameterList[2],$parsedParameterList[5]) $parsedBinMatrix
	$parsedBinMatrix = $parsedBinMatrix*0

	tmp_delta = ($parsedParameterList[1]-$parsedParameterList[0])/$parsedParameterList[2]
	SetScale/P x ($parsedParameterList[0]+(tmp_delta/2)  ),tmp_delta,"x [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[9] = tmp_delta

	tmp_delta = ($parsedParameterList[4]-$parsedParameterList[3])/$parsedParameterList[5]
	SetScale/P y ($parsedParameterList[3]+(tmp_delta/2)  ),tmp_delta,"y [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[10] = tmp_delta
endif

if (imageType == 1) // 1D intensity vs. t
	make /O /N=($parsedParameterList[8]) $parsedBinMatrix
	$parsedBinMatrix = $parsedBinMatrix*0
	tmp_delta = ($parsedParameterList[7]-$parsedParameterList[6])/$parsedParameterList[8]
	SetScale/P x ($parsedParameterList[6]+(tmp_delta/2)  ),tmp_delta,"t [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[11] = tmp_delta
endif

if (imageType == 4) // 2D tx
	
	make /O /N=($parsedParameterList[8],$parsedParameterList[2]) $parsedBinMatrix
	$parsedBinMatrix = $parsedBinMatrix*0

	tmp_delta = ($parsedParameterList[1]-$parsedParameterList[0])/$parsedParameterList[2]
	SetScale/P y ($parsedParameterList[0]+(tmp_delta/2)  ),tmp_delta,"x [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[9] = tmp_delta

	tmp_delta = ($parsedParameterList[7]-$parsedParameterList[6])/$parsedParameterList[8]
	SetScale/P x ($parsedParameterList[6]+(tmp_delta/2)  ),tmp_delta,"t [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[11] = tmp_delta

endif


if (imageType == 5) // 2D ty
	
	make /O /N=($parsedParameterList[8],$parsedParameterList[5]) $parsedBinMatrix
	$parsedBinMatrix = $parsedBinMatrix*0

	tmp_delta = ($parsedParameterList[4]-$parsedParameterList[3])/$parsedParameterList[5]
	SetScale/P y ($parsedParameterList[3]+(tmp_delta/2)  ),tmp_delta,"y [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[10] = tmp_delta

	tmp_delta = ($parsedParameterList[7]-$parsedParameterList[6])/$parsedParameterList[8]
	SetScale/P x ($parsedParameterList[6]+(tmp_delta/2)  ),tmp_delta,"t [25 ps channels]", $parsedBinMatrix
	$parsedParameterList[11] = tmp_delta
endif

variable timerRefNumber
variable microSeconds
timerRefNumber = startMStimer

print ReadARToFxytFiles($parsedParameterList, $parsedBinMatrix, lensIterations)
// If "Ok", then the data matrix is now complete!

microSeconds = stopMStimer(timerRefNumber)
print "time elapsed = ",microSeconds, "micro s"

end


// Function returns string to communicate "Ok" or "Fail"
// a global symbolic path named ArtofWD has been set by an overlaying macro (or function?).
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFxytFiles(ParameterList, BinMatrix, lensIterations)
wave ParameterList
wave BinMatrix
variable lensiterations

variable iteration
variable step = 0

string CollectInfoString

variable marker = 0

make /O /I /N=(1) intDumpFileToRam // array of 32 bit signed integer

iteration = 0
do
	if (ParameterList[12]==3)
		CollectInfoString = ReadARToFxytBin3D(ParameterList,BinMatrix,iteration,step,intDumpFileToRam);
	elseif (ParameterList[12]==2)
		CollectInfoString = ReadARToFxytBin2D(ParameterList,BinMatrix,iteration,step,intDumpFileToRam);
	elseif (ParameterList[12]==4)
		CollectInfoString = ReadARToFxytBin2Dtx(ParameterList,BinMatrix,iteration,step,intDumpFileToRam);
	elseif (ParameterList[12]==5)
		CollectInfoString = ReadARToFxytBin2Dty(ParameterList,BinMatrix,iteration,step,intDumpFileToRam);
	else
		CollectInfoString = ReadARToFxytBin1D(ParameterList,BinMatrix,iteration,step,intDumpFileToRam);
	endif
	
	if ( !stringmatch(CollectInfoString,"OkFile"))
		print "Currupt or non-existing file" + num2str(iteration) + "_" +  num2str(step)
		print CollectInfoString
		marker = 1
		return "Fail"
	endif
	iteration = iteration + 1
while (iteration<lensIterations && marker<1)

return "Ok"

end

// Function returns strings to communicate file status
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFxytBin3D(ParameterList,BinMatrix,iteration,step,intDumpFileToRam)
wave ParameterList
wave BinMatrix
variable iteration,step
wave intDumpFileToRam

string fileName

// 0 begin_x
// 1 end_x
// 2 channels_x
// 3 begin_y
// 4 end_y
// 5 channels_y
// 6 begin_t
// 7 end_t
// 8 channels_t
// 9 calculated x delta
// 10 calculated y delta
// 11 calculated t delta

variable refNum
variable FileSizeInBytes
variable NoOfHitsInFile
variable Hit
variable xx,yy, tt
variable xxBinIndex, yyBinIndex, ttBinIndex 

// The ArtofWD is a symbolic path to the working directory
// which must have been set by an overlaying macro (or function?)

// Parse file name
fileName = num2str(iteration) + "_" + num2str(step)

// Open and check the status
open /R /Z=1 /P=ArtofWD refNum as fileName
FStatus refNum

if (V_Flag)
	// calculate number of hits in file
	FileSizeInBytes = V_logEOF
	NoOfHitsInFile = FileSizeInBytes/4/3 // 32 bit signed integer

	if (NoOfHitsInFile<1)
		close refNum
		return "OkFile"
	endif
		
	if (ParameterList[13] > 0)		
		redimension /N=(NoOfHitsInFile*3) intDumpFileToRam
		FBinRead refNum, intDumpFileToRam
	endif	
	//Read hit-by-hit, perform operations, bin
	Hit = 0
	do
		if (ParameterList[13] > 0)
			// Read on hit from the structure dumped to RAM
			xx = intDumpFileToRam[3*Hit]
			yy = intDumpFileToRam[3*Hit+1]
			tt = intDumpFileToRam[3*Hit+2]
		else
			// Read one hit from file
			FBinRead /F=3 refNum, xx
			FBinRead /F=3 refNum, yy
			FBinRead /F=3 refNum, tt
	 	endif
		
		
		
		// Check boundaries
		if (   xx>=ParameterList[0] && xx<ParameterList[1] && yy>=ParameterList[3] && yy<ParameterList[4] && tt>=ParameterList[6] && tt<ParameterList[7]  )	
			// Find index to increment
			xxBinIndex = floor ((xx-ParameterList[0])/ParameterList[9])   // (xx-xxBegin)/xxChannelWidth
			yyBinIndex = floor ((yy-ParameterList[3])/ParameterList[10])   // (yy-yyBegin)/yyChannelWidth
			ttBinIndex = floor ((tt-ParameterList[6])/ParameterList[11])   // (tt-ttBegin)/ttChannelWidth
			BinMatrix[xxBinIndex][yyBinIndex][ttBinIndex] = BinMatrix[xxBinIndex][yyBinIndex][ttBinIndex] + 1
		endif
		Hit=Hit+1
	while (Hit<NoOfHitsInFile)
	
	close refNum
else	
	return "NoFile"
endif

return "OkFile"

end


// Function returns strings to communicate file status
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFxytBin2D(ParameterList,BinMatrix,iteration,step,intDumpFileToRam)
wave ParameterList
wave BinMatrix
variable iteration,step
wave intDumpFileToRam

string fileName

// 0 begin_x
// 1 end_x
// 2 channels_x
// 3 begin_y
// 4 end_y
// 5 channels_y
// 6 begin_t
// 7 end_t
// 8 channels_t
// 9 calculated x delta
// 10 calculated y delta
// 11 calculated t delta

variable refNum
variable FileSizeInBytes
variable NoOfHitsInFile
variable Hit
variable xx,yy, tt
variable xxBinIndex, yyBinIndex, ttBinIndex 

// The ArtofWD is a symbolic path to the working directory
// which must have been set by an overlaying macro (or function?)

// Parse file name
fileName = num2str(iteration) + "_" + num2str(step)

// Open and check the status
open /R /Z=1 /P=ArtofWD refNum as fileName
FStatus refNum

if (V_Flag)
	// calculate number of hits in file
	FileSizeInBytes = V_logEOF
	NoOfHitsInFile = FileSizeInBytes/4/3 // 32 bit signed integer

	if (NoOfHitsInFile<1)
		close refNum
		return "OkFile"
	endif
		
	if (ParameterList[13] > 0)		
		redimension /N=(NoOfHitsInFile*3) intDumpFileToRam
		FBinRead refNum, intDumpFileToRam
	endif	
	//Read hit-by-hit, perform operations, bin
	Hit = 0
	do
		if (ParameterList[13] > 0)
			// Read on hit from the structure dumped to RAM
			xx = intDumpFileToRam[3*Hit]
			yy = intDumpFileToRam[3*Hit+1]
			tt = intDumpFileToRam[3*Hit+2]
		else
			// Read one hit from file
			FBinRead /F=3 refNum, xx
			FBinRead /F=3 refNum, yy
			FBinRead /F=3 refNum, tt
	 	endif
		
		// Check boundaries
		if (   xx>=ParameterList[0] && xx<ParameterList[1] && yy>=ParameterList[3] && yy<ParameterList[4] && tt>=ParameterList[6] && tt<ParameterList[7]  )	
			// Find index to increment
			xxBinIndex = floor ((xx-ParameterList[0])/ParameterList[9])   // (xx-xxBegin)/xxChannelWidth
			yyBinIndex = floor ((yy-ParameterList[3])/ParameterList[10])   // (yy-yyBegin)/yyChannelWidth
			BinMatrix[xxBinIndex][yyBinIndex]= BinMatrix[xxBinIndex][yyBinIndex]+ 1
		endif
		Hit=Hit+1
	while (Hit<NoOfHitsInFile)
	
	close refNum
else	
	return "NoFile"
endif

return "OkFile"

end

// Function returns strings to communicate file status
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFxytBin1D(ParameterList,BinMatrix,iteration,step,intDumpFileToRam)
wave ParameterList
wave BinMatrix
variable iteration,step
wave intDumpFileToRam

string fileName

// 0 begin_x
// 1 end_x
// 2 channels_x
// 3 begin_y
// 4 end_y
// 5 channels_y
// 6 begin_t
// 7 end_t
// 8 channels_t
// 9 calculated x delta
// 10 calculated y delta
// 11 calculated t delta

variable refNum
variable FileSizeInBytes
variable NoOfHitsInFile
variable Hit
variable xx,yy, tt
variable xxBinIndex, yyBinIndex, ttBinIndex 

// The ArtofWD is a symbolic path to the working directory
// which must have been set by an overlaying macro (or function?)

// Parse file name
fileName = num2str(iteration) + "_" + num2str(step)

// Open and check the status
open /R /Z=1 /P=ArtofWD refNum as fileName
FStatus refNum

if (V_Flag)
	// calculate number of hits in file
	FileSizeInBytes = V_logEOF
	NoOfHitsInFile = FileSizeInBytes/4/3 // 32 bit signed integer

	if (NoOfHitsInFile<1)
		close refNum
		return "OkFile"
	endif
		
	if (ParameterList[13] > 0)		
		redimension /N=(NoOfHitsInFile*3) intDumpFileToRam
		FBinRead refNum, intDumpFileToRam
	endif	
	//Read hit-by-hit, perform operations, bin
	Hit = 0
	do
		if (ParameterList[13] > 0)
			// Read on hit from the structure dumped to RAM
			xx = intDumpFileToRam[3*Hit]
			yy = intDumpFileToRam[3*Hit+1]
			tt = intDumpFileToRam[3*Hit+2]
		else
			// Read one hit from file
			FBinRead /F=3 refNum, xx
			FBinRead /F=3 refNum, yy
			FBinRead /F=3 refNum, tt
	 	endif
		
		// Check boundaries
		if (   xx>=ParameterList[0] && xx<ParameterList[1] && yy>=ParameterList[3] && yy<ParameterList[4] && tt>=ParameterList[6] && tt<ParameterList[7]  )	
			// Find index to increment
			ttBinIndex = floor ((tt-ParameterList[6])/ParameterList[11])   // (tt-ttBegin)/ttChannelWidth
			BinMatrix[ttBinIndex] = BinMatrix[ttBinIndex] + 1
		endif
		Hit=Hit+1
	while (Hit<NoOfHitsInFile)
	
	close refNum
else	
	return "NoFile"
endif

return "OkFile"

end


// Function returns strings to communicate file status
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFxytBin2Dtx(ParameterList,BinMatrix,iteration,step,intDumpFileToRam)
wave ParameterList
wave BinMatrix
variable iteration,step
wave intDumpFileToRam

string fileName

// 0 begin_x
// 1 end_x
// 2 channels_x
// 3 begin_y
// 4 end_y
// 5 channels_y
// 6 begin_t
// 7 end_t
// 8 channels_t
// 9 calculated x delta
// 10 calculated y delta
// 11 calculated t delta

variable refNum
variable FileSizeInBytes
variable NoOfHitsInFile
variable Hit
variable xx,yy, tt
variable xxBinIndex, yyBinIndex, ttBinIndex 

// The ArtofWD is a symbolic path to the working directory
// which must have been set by an overlaying macro (or function?)

// Parse file name
fileName = num2str(iteration) + "_" + num2str(step)

// Open and check the status
open /R /Z=1 /P=ArtofWD refNum as fileName
FStatus refNum

if (V_Flag)
	// calculate number of hits in file
	FileSizeInBytes = V_logEOF
	NoOfHitsInFile = FileSizeInBytes/4/3 // 32 bit signed integer

	if (NoOfHitsInFile<1)
		close refNum
		return "OkFile"
	endif
		
	if (ParameterList[13] > 0)		
		redimension /N=(NoOfHitsInFile*3) intDumpFileToRam
		FBinRead refNum, intDumpFileToRam
	endif	
	//Read hit-by-hit, perform operations, bin
	Hit = 0
	do
		if (ParameterList[13] > 0)
			// Read on hit from the structure dumped to RAM
			xx = intDumpFileToRam[3*Hit]
			yy = intDumpFileToRam[3*Hit+1]
			tt = intDumpFileToRam[3*Hit+2]
		else
			// Read one hit from file
			FBinRead /F=3 refNum, xx
			FBinRead /F=3 refNum, yy
			FBinRead /F=3 refNum, tt
	 	endif
		
		// Check boundaries
		if (   xx>=ParameterList[0] && xx<ParameterList[1] && yy>=ParameterList[3] && yy<ParameterList[4] && tt>=ParameterList[6] && tt<ParameterList[7]  )	
			// Find index to increment
			xxBinIndex = floor ((xx-ParameterList[0])/ParameterList[9])   // (xx-xxBegin)/xxChannelWidth
			ttBinIndex = floor ((tt-ParameterList[6])/ParameterList[11])   // (tt-ttBegin)/ttChannelWidth
			BinMatrix[ttBinIndex][xxBinIndex] = BinMatrix[ttBinIndex][xxBinIndex] + 1
		endif
		Hit=Hit+1
	while (Hit<NoOfHitsInFile)
	
	close refNum
else	
	return "NoFile"
endif

return "OkFile"

end

// Function returns strings to communicate file status
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFxytBin2Dty(ParameterList,BinMatrix,iteration,step,intDumpFileToRam)
wave ParameterList
wave BinMatrix
variable iteration,step
wave intDumpFileToRam

string fileName

// 0 begin_x
// 1 end_x
// 2 channels_x
// 3 begin_y
// 4 end_y
// 5 channels_y
// 6 begin_t
// 7 end_t
// 8 channels_t
// 9 calculated x delta
// 10 calculated y delta
// 11 calculated t delta

variable refNum
variable FileSizeInBytes
variable NoOfHitsInFile
variable Hit
variable xx,yy, tt
variable xxBinIndex, yyBinIndex, ttBinIndex 

// The ArtofWD is a symbolic path to the working directory
// which must have been set by an overlaying macro (or function?)

// Parse file name
fileName = num2str(iteration) + "_" + num2str(step)

// Open and check the status
open /R /Z=1 /P=ArtofWD refNum as fileName
FStatus refNum

if (V_Flag)
	// calculate number of hits in file
	FileSizeInBytes = V_logEOF
	NoOfHitsInFile = FileSizeInBytes/4/3 // 32 bit signed integer

	if (NoOfHitsInFile<1)
		close refNum
		return "OkFile"
	endif
		
	if (ParameterList[13] > 0)		
		redimension /N=(NoOfHitsInFile*3) intDumpFileToRam
		FBinRead refNum, intDumpFileToRam
	endif	
	//Read hit-by-hit, perform operations, bin
	Hit = 0
	do
		if (ParameterList[13] > 0)
			// Read on hit from the structure dumped to RAM
			xx = intDumpFileToRam[3*Hit]
			yy = intDumpFileToRam[3*Hit+1]
			tt = intDumpFileToRam[3*Hit+2]
		else
			// Read one hit from file
			FBinRead /F=3 refNum, xx
			FBinRead /F=3 refNum, yy
			FBinRead /F=3 refNum, tt
	 	endif
		
		// Check boundaries
		if (   xx>=ParameterList[0] && xx<ParameterList[1] && yy>=ParameterList[3] && yy<ParameterList[4] && tt>=ParameterList[6] && tt<ParameterList[7]  )	
			// Find index to increment
			yyBinIndex = floor ((yy-ParameterList[3])/ParameterList[10])   // (yy-yyBegin)/yyChannelWidth
			ttBinIndex = floor ((tt-ParameterList[6])/ParameterList[11])   // (tt-ttBegin)/ttChannelWidth
			BinMatrix[ttBinIndex][yyBinIndex] = BinMatrix[ttBinIndex][yyBinIndex] + 1
		endif
		Hit=Hit+1
	while (Hit<NoOfHitsInFile)
	
	close refNum
else	
	return "NoFile"
endif

return "OkFile"

end

/////------------------ReadARToFStreamedSweepCRR----------------------------
function /S ReadARToFStreamedSweepCRR(spectrumWindowLowEdgeE, lensWindowEkin, spectrumWindowIndexOffset, spectrumWindowNoOfChannels,represented , parameterWave, BinMatrix  )

// Input waves
wave spectrumWindowLowEdgeE
wave lensWindowEkin
wave spectrumWindowIndexOffset
wave spectrumWindowNoOfChannels
wave represented
wave parameterWave
wave BinMatrix  

// Global offset
variable allocatedBlockSize = 40

// Variables used for looping over the files
variable lensSteps = parameterWave[allocatedBlockSize+8]
variable lensIterations = parameterWave[allocatedBlockSize+10] 
string CollectInfoString = "OkFile"
variable iteration = 0 
variable step

// Variables used for the normalization
variable spectrumChannels = parameterWave[allocatedBlockSize+9] 
variable noOfk1Channels =  parameterWave[5]
variable noOfk2Channels =  parameterWave[6]
variable sliceEkinBeginIndex =	parameterWave[allocatedBlockSize+13]
variable sliceEkinEndIndex = parameterWave[allocatedBlockSize+14] 
variable sliceSpectrumChannels = parameterWave[allocatedBlockSize+15]
variable medianRepresented
variable ii

make /O /D /N=(1) dpDumpFileToRam // array of 64 bit floating point numbers, i.e. double point

// Looping over the files
do
	step = 0
	do
		CollectInfoString = SweepCRROperateBin(spectrumWindowLowEdgeE, lensWindowEkin, spectrumWindowIndexOffset, spectrumWindowNoOfChannels, parameterWave, BinMatrix, iteration, step, dpDumpFileToRam)
		if ( !stringmatch(CollectInfoString,"OkFile"))
			print "Currupt or non-existing file " + num2str(iteration) + "_" +  num2str(step)
			print CollectInfoString
			killwaves /Z dpDumpFileToRam
			return "Fail"	
		endif
		step = step + 1
	while (step<lensSteps)
	print "iteration =" num2str(iteration)
	iteration = iteration + 1
while (iteration<lensIterations)

// Normalize
medianRepresented = represented[floor(spectrumChannels/2)]
print "medianRepresented " num2str(medianRepresented)
ii = 0
do
	BinMatrix[][][ii] = BinMatrix[p][q][ii]*medianRepresented/represented[ii+sliceEkinBeginIndex]
	ii = ii+1
while (ii<sliceSpectrumChannels)

killwaves /Z dpDumpFileToRam

return "Ok"
end

// This is where the action is
function /S SweepCRROperateBin(spectrumWindowLowEdgeE, lensWindowEkin, spectrumWindowIndexOffset, spectrumWindowNoOfChannels, parameterWave, BinMatrix, iteration, step, dpDumpFileToRam)

// Input waves and variables
wave spectrumWindowLowEdgeE
wave lensWindowEkin
wave spectrumWindowIndexOffset
wave spectrumWindowNoOfChannels
wave parameterWave
wave BinMatrix  
variable iteration
variable step
wave dpDumpFileToRam

// Global offset
variable allocatedBlockSize = 40

// Local
string fileName
variable refNum
variable FileSizeInBytes
variable NoOfHitsInFile
variable Hit
variable phi, theta, Ek
variable maxTheta =  parameterWave[18]
variable k1, k2, Eb
variable k1BinIndex, k2BinIndex
variable EkFullBinIndex, EkSliceBinIndex

variable beta =  parameterWave[0]
variable alpha = parameterWave[1]
variable gammaAng = parameterWave[19]
variable kappaAng = parameterWave[20]
variable Tx
variable Ty
variable Tz
variable tmp
variable k_p


// SweepCRR parameters
variable lensLowEdgeBeginE = parameterWave[allocatedBlockSize+0]
variable lensLowEdgeEnergyStep = parameterWave[allocatedBlockSize+1] 
variable lensK  = parameterWave[allocatedBlockSize+2]
variable lensStepChannelMultiple = parameterWave[allocatedBlockSize+3]
variable spectrum1stIndexOffset  = parameterWave[allocatedBlockSize+4]
variable spectrumBeginEnergy = parameterWave[allocatedBlockSize+5]
variable spectrumEndEnergy =	parameterWave[allocatedBlockSize+6]
variable spectrumChannelWidthEnergy = parameterWave[allocatedBlockSize+7]
variable lensSteps = parameterWave[allocatedBlockSize+8] 
variable spectrumChannels = parameterWave[allocatedBlockSize+9] 
variable lensIterations = parameterWave[allocatedBlockSize+10] 
variable sliceEkinBegin = parameterWave[allocatedBlockSize+11] 
variable sliceEkinEnd = parameterWave[allocatedBlockSize+12]
variable sliceEkinBeginIndex =	parameterWave[allocatedBlockSize+13]
variable sliceEkinEndIndex = parameterWave[allocatedBlockSize+14] 
variable sliceSpectrumChannels = parameterWave[allocatedBlockSize+15]

// Parse file name
fileName = num2str(iteration) + "_" + num2str(step)

// Open and check the status
open /R /Z=1 /P=ArtofWD refNum as fileName
FStatus refNum

if (V_Flag)
	// calculate number of hits in file
	FileSizeInBytes = V_logEOF
	NoOfHitsInFile = FileSizeInBytes/8/3

	if (NoOfHitsInFile<1)
		close refNum
		return "OkFile"
	endif
			
	// If parameter 22 is set, dump the complete binary file iteration_step to RAM memory
	// there is no check for too big structures in this first version
	// want to allocate memory in overlaying function, but uses the fact that waves are global objects
	if (parameterWave[22] > 0)	
		redimension /N=(NoOfHitsInFile*3) dpDumpFileToRam
		FBinRead refNum, dpDumpFileToRam
	endif
		
	//Read hit-by-hit, perform operations, bin
	Hit = 0
	do
		if (parameterWave[22] > 0)
			// Read on hit from the structure dumped to RAM
			theta = dpDumpFileToRam[3*Hit]
			phi = dpDumpFileToRam[3*Hit+1]
			Ek = dpDumpFileToRam[3*Hit+2]
		else
			// Read one hit from file
			FBinRead refNum, theta
			FBinRead refNum, phi
			FBinRead refNum, Ek
	 	endif

		if (theta<=maxTheta)


			

			EkFullBinIndex = floor ((Ek-spectrumBeginEnergy+0.5*spectrumChannelWidthEnergy)/spectrumChannelWidthEnergy)
			// Is the index inside the current window, and inside the default energy spectrum?
			if (EkFullBinIndex>=0 && EkFullBinIndex>=spectrumWindowIndexOffset[step] &&  EkFullBinIndex<spectrumChannels && EkFullBinIndex<(spectrumWindowIndexOffset[step]+spectrumWindowNoOfChannels[step] ) )
				// Is the index inside of the sliced energy spectrum?
				if (EkFullBinIndex>=sliceEkinBeginIndex && EkFullBinIndex<=sliceEkinEndIndex)
					EkSliceBinIndex = EkFullBinIndex-sliceEkinBeginIndex
					
					// Correct theta from manipulator settings (see documentation)
	 				// This section strongly depends on definitions.
	 				// In this example the detector is oriented as in the exampel in the documentation.
	 				// The manipulator is rotated from the normal emission position.
	 				// First by rotating the rod by betaAng (around y),
	 				// followed by a tilt of alphaAng (around x')
	 				// For further optimization of the code, sin(betaAng), etc. could be calculated outside the loop
	 				// This time consuming section can be omitted by setting parameter 21 = 0
					if (parameterWave[21] > 0)
						// Detector correction rotation, assiciated with gammaAng
	 					phi = phi+gammaAng
	 					if (phi>PI)
	 						phi = phi-2*PI
	 					endif
						// Use of Euler angles, manipulator settings 
						Tx = cos(beta)*sin(theta)*cos(phi)+sin(alpha)*sin(beta)*sin(theta)*sin(phi)-cos(alpha)*sin(beta)*cos(theta)
						Ty = cos(alpha)*sin(theta)*sin(phi)+sin(alpha)*cos(theta)
						Tz = sin(beta)*sin(theta)*cos(phi)-sin(alpha)*cos(beta)*sin(theta)*sin(phi)+cos(alpha)*cos(beta)*cos(theta)
		 				
		 				theta = acos(Tz)
						phi = atan2(Ty,Tx)
					endif
					
		 			// Perform operations
		 			k_p = 0.512*sqrt(Ek)*sin(theta) // used as temp variable
					k1 = k_p*cos(phi) 
					k2 = k_p*sin(phi)
						
					// Check k space boundaries
					if (   k1>=parameterWave[3] && k1<parameterWave[4] && k2>=parameterWave[6] && k2<parameterWave[7]  )	
						// Find index to increment
						k1BinIndex = floor ((k1-parameterWave[3])/parameterWave[13])   // (k1-k1Begin)/k1ChannelWidth
						k2BinIndex = floor ((k2-parameterWave[6])/parameterWave[14])   // (k1-k1Begin)/k1ChannelWidth
						BinMatrix[k1BinIndex][k2BinIndex][EkSliceBinIndex] = BinMatrix[k1BinIndex][k2BinIndex][EkSliceBinIndex] + 1
					endif
				endif // Slized energy spectrum?
			endif // current window?
		endif // maxTheta?
		Hit=Hit+1
	while (Hit<NoOfHitsInFile)
	close refNum
else	
	return "NoFile"
endif

return "OkFile"
end

//////---------ReadArtofStreamedLoopFiles---------------------
// Function returns string to communicate "Ok" or "Fail"
// The function calls the ReadARToFStraeamedOperateBin function
// N.B. the ReadARToFStraeamedOperateBin function expects that
// a global symbolic path named ArtofWD has been set by an overlaying macro (or function?).
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFLoopFiles(ParameterList, BinMatrix, lensIterations)
wave ParameterList
wave BinMatrix
variable lensiterations

variable iteration
variable step = 0

string CollectInfoString

variable marker = 0

make /O /D /N=(1) dpDumpFileToRam // array of 64 bit floating point numbers, i.e. double point

iteration = 0
do
	CollectInfoString = ReadARToFStreamedOperateBin(ParameterList,BinMatrix,iteration,step,dpDumpFileToRam);
	
	if ( !stringmatch(CollectInfoString,"OkFile"))
		print "Currupt or non-existing file" + num2str(iteration) + "_" +  num2str(step)
		print CollectInfoString
		marker = 1
		killwaves /Z dpDumpFileToRam
		return "Fail"
	endif
	iteration = iteration + 1
while (iteration<lensIterations && marker<1)
killwaves /Z dpDumpFileToRam
return "Ok"

end

////////----------ReadARToFStreamedOperateBin-----------------

// Function returns strings to communicate file status
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadARToFStreamedOperateBin(ParameterList,BinMatrix,iteration,step,dpDumpFileToRam)
wave ParameterList
wave BinMatrix
variable iteration,step
wave dpDumpFileToRam
string fileName

// parameterList
// 0		manipulator rot (beta)
// 1		manipulator tilt (alpha)
// 2		work function
// 3 		k1 begin
// 4 		k1 end
// 5 		number of channels in k1
// 6 		k2 begin
// 7 		k2 end
// 8 		number of channels in k2
// 9 		Eb begin energy
// 10 	Eb end energy
// 11	number of channels in Eb
// 12	photon energy
// 13	k1 channelWidth (calculated)
// 14	k2 channelWidth (calculated)
// 15	Eb channelWidth (calculated)
// 16	centerEnergy (read)
// 17	lensK (read)
// 18	maxTheta (read)
// 19	detector correction rotation (gamma)
// 20	post Euler k-space rotation (kappa)

variable refNum
variable FileSizeInBytes
variable NoOfHitsInFile
variable Hit
variable phi, theta, Ek
variable maxTheta =  ParameterList[18]
variable k1, k2
variable k1BinIndex, k2BinIndex, EkBinIndex 

variable betaAng =  ParameterList[0]
variable alphaAng = ParameterList[1]
variable gammaAng = ParameterList[19]
variable kappaAng = ParameterList[20]
variable Tx
variable Ty
variable Tz
variable tmp
variable k_p,k0

variable sliceEkinBegin = ParameterList[12]-ParameterList[10]-ParameterList[2] // Ek = hv-Eb(end)-W
variable sliceEkinEnd = ParameterList[12]-ParameterList[9]-ParameterList[2] // Ek = hv-Eb(begin)-W

// The ArtofWD is a symbolic path to the working directory
// which must have been set by an overlaying macro (or function?)

// Parse file name
fileName = num2str(iteration) + "_" + num2str(step)

// Open and check the status
open /R /Z=1 /P=ArtofWD refNum as fileName
FStatus refNum

if (V_Flag)
	// calculate number of hits in file
	FileSizeInBytes = V_logEOF
	NoOfHitsInFile = FileSizeInBytes/8/3

	if (NoOfHitsInFile<1)
		close refNum
		return "OkFile"
	endif
		
	// If parameter 22 is set, dump the complete binary file iteration_step to RAM memory
	// there is no check for too big structures in this first version
	// want to allocate memory in overlaying function, but uses the fact that waves are global objects
	if (ParameterList[22] > 0)	
		redimension /N=(NoOfHitsInFile*3) dpDumpFileToRam
		FBinRead refNum, dpDumpFileToRam
	endif
	
	//Read hit-by-hit, perform operations, bin
	Hit = 0
	do
		if (ParameterList[22] > 0)
			// Read on hit from the structure dumped to RAM
			theta = dpDumpFileToRam[3*Hit]
			phi = dpDumpFileToRam[3*Hit+1]
			Ek = dpDumpFileToRam[3*Hit+2]
		else
			// Read one hit from file
			FBinRead refNum, theta
			FBinRead refNum, phi
			FBinRead refNum, Ek
	 	endif
	 
	 	if (theta<=maxTheta)
	 
	 		// Correct theta from manipulator settings (see documentation)
	 		// This section strongly depends on definitions.
	 		// In this example the detector is oriented as in the exampel in the documentation.
	 		// The manipulator is rotated from the normal emission position.
	 		// First by rotating the rod by betaAng (around y),
	 		// followed by a tilt of alphaAng (around x')
	 		// Optimize code, sin(betaAng), etc. could be calculated outside the loop
	 		// This time consuming section can be omitted by setting parameter 21 = 0
	 		if (ParameterList[21] > 0)
	 			// Detector correction rotation, assiciated with gammaAng
	 			phi = phi+gammaAng
	 			if (phi>PI)
	 				phi = phi-2*PI
	 			endif
	 	
	 			Tx = cos(betaAng)*sin(theta)*cos(phi)+sin(alphaAng)*sin(betaAng)*sin(theta)*sin(phi)-cos(alphaAng)*sin(betaAng)*cos(theta)
				Ty = cos(alphaAng)*sin(theta)*sin(phi)+sin(alphaAng)*cos(theta)
				Tz = sin(betaAng)*sin(theta)*cos(phi)-sin(alphaAng)*cos(betaAng)*sin(theta)*sin(phi)+cos(alphaAng)*cos(betaAng)*cos(theta)

	 			theta = acos(Tz)
				phi = atan2(Ty,Tx)
			endif
			
	 		// Perform operations
	 		k_p = 0.512*sqrt(Ek)*sin(theta) // used as temp variable
	 	
			k1 = k_p*cos(phi) 
			k2 = k_p*sin(phi)
			//Eb = photonEnergy - Ek - workFunction
		
			// Check boundaries
			if (   k1>=ParameterList[3] && k1<ParameterList[4] && k2>=ParameterList[6] && k2<ParameterList[7] && Ek>=sliceEkinBegin && Ek<sliceEkinEnd  )	
				// Find index to increment
				
				////////Change to (theta,phi) JXW
					k0=0.512*sqrt(Ek)
					phi=asin(k1/k0)						
					theta=asin(k2/k0/cos(phi))*180/pi
					phi=phi*180/pi
					k1=theta
					k2=phi
				////////Change to (theta,phi) JXW
				
				k1BinIndex = floor ((k1-ParameterList[3])/ParameterList[13])   // (k1-k1Begin)/k1ChannelWidth
				k2BinIndex = floor ((k2-ParameterList[6])/ParameterList[14])   // (k1-k1Begin)/k1ChannelWidth
				EkBinIndex = floor ((Ek-sliceEkinBegin)/ParameterList[15])   // (k1-k1Begin)/k1ChannelWidth
			
				BinMatrix[k1BinIndex][k2BinIndex][EkBinIndex] = BinMatrix[k1BinIndex][k2BinIndex][EkBinIndex] + 1
					
			endif
			
		endif // maxTheta
		Hit=Hit+1
	while (Hit<NoOfHitsInFile)
	
	close refNum
else	
	return "NoFile"
endif

return "OkFile"

end

//////---------------ReadConfigString-----------------------
// Returns the variable value. Returns empty string if the variable is not found.
// RefNum is a reference to an already opened file.
// Patrik Karlsson, VG Scienta AB, 2010
function /S ReadConfigString(refNum, block, parameter)
variable refNum
string block
string parameter

string parameterString = ""
string subString = ""
variable ii
variable linesRead
variable maxNumberOfLines = 1000
string textLine
variable marker = 0

FSetPos refNum, 0 // Always start from the begining of the file.

//Go to block
do
	FReadLine refNum, textLine
	linesRead = linesRead + 1
	if (stringmatch(textLine,(block+"*"))) // Example block "[general]"
		marker = 1
		// Find keyword parameter
		do
			FReadLine refNum, textLine
			linesRead = linesRead + 1
			//print textLine
			if (stringmatch(textLine,(parameter+"=*"))) // Example parameter "spectrumBeginEnergy"
				marker = marker + 1
				ii = 0
				// Read lensIterations parameter value
				do
					subString[ii] = textLine[strlen(parameter+"=")+ii]
					ii = ii + 1
				while (strlen(parameter+"=")+ii<strlen(textLine)) 
				parameterString = subString
			endif	
		while (marker<2 && linesRead<maxNumberOfLines) 
	endif
while (marker<1 && linesRead<maxNumberOfLines)

return parameterString

end

proc loadartofdatapanel()

string curr=getdatafolder(1)
string samplename
dowindow/F ARToFDataLoad

if(!V_Flag)
setdatafolder root:OriginalData
ARToFDataLoad()
endif

end

Function artofsetname(ctrlName) : ButtonControl
	String ctrlName
string curr=getdatafolder(1)
string parameter1,parameter2,parameterinfo1,parameterinfo2
setdatafolder root:OriginalData
dowindow/F ARToFDataLoad

if(!V_flag)
return 0
endif

controlinfo/W=ARToFDataLoad artofdataname
parameter1=S_Value + "_ParameterList"
parameter2="xyz_ParameterList"
parameterinfo1="ParameterDefinitions"
parameterinfo2="xytParameterDefinitions"

make/O/N=127 $parameter1
make/O/T/N=127 $parameterinfo1
make/O/N=13 $parameter2
make/O/T/N=13 $parameterinfo2

wave wp1=$parameter1
wave/T wpi1=$parameterinfo1
wave wp2=$parameter2
wave/T wpi2=$parameterinfo2

wp1[0]=0
wpi1[0]="manipulator rot (beta)"
wp1[1]=0
wpi1[1]="manipulator tilt (alpha)"
wp1[2]=4.3
wpi1[2]="work function"
wp1[3]=-15
wpi1[3]="k1 begin"
wp1[4]=15
wpi1[4]="k1 end"
wp1[5]=100
wpi1[5]="number of channels in k1"
wp1[6]=-15
wpi1[6]="k2 begin"
wp1[7]=15
wpi1[7]="k2 end"
wp1[8]=100
wpi1[8]="number of channels in k2"
wp1[9]=-0.05
wpi1[9]="Eb begin energy"
wp1[10]=1.05
wpi1[10]="Eb end energy"
wp1[11]=100
wpi1[11]="number of channels in Eb (Fix mode only)"
wp1[12]=7
wpi1[12]="photon energy"
wp1[13]=0.3
wpi1[13]="k1 channelWidth (calculated)"
wp1[14]=0.3
wpi1[14]="k2 channelWidth (calculated)"
wp1[15]=0.011
wpi1[15]="Eb channelWidth (calculated in fix mode)"
wp1[16]=2.2
wpi1[16]="centerEnergy (read)"
wp1[17]=0.5
wpi1[17]="lensK (read)"
wp1[18]=0.261799
wpi1[18]="maxTheta (read)"
wp1[19]=0
wpi1[19]="detector correction rotation (gamma)"
wp1[20]=0
wpi1[20]="post Euler k-space rotation (kappa)"
wp1[21]=0
wpi1[21]="use Euler angels in calculation"
wp1[22]=1
wpi1[22]="dump files to RAM"

wp2[0]=-1300;	wpi2[0]="begin_x"
wp2[1]=1300	; wpi2[1]="end_x"
wp2[2]=50;	wpi2[2]="channels_x"
wp2[3]=-1300;	 wpi2[3]="begin_y"
wp2[4]=1300	; wpi2[4]="end_y"
wp2[5]=50;	wpi2[5]="channels_y"
wp2[6]=31457; wpi2[6]="begin_t"
wp2[7]=32078; wpi2[7]="end_t"
wp2[8]=50;	wpi2[8]="channels_t"
wp2[9]=52;	wpi2[9]="calculated x delta"
wp2[10]=52;	 wpi2[10]="calculated y delta"
wp2[11]=12.42; wpi2[11]="calculated t delta"
wp2[12]=5;	wpi2[12]="calculated imageType"
wp2[13]=1;	wpi2[13]="dump files to RAM"

//wp1[0]=
setdatafolder curr

End

Function artofloadparameter(ctrlName) : ButtonControl
	String ctrlName
string curr=getdatafolder(1)

setdatafolder root:OriginalData

string parameter1,parameter2,parameterinfo1,parameterinfo2

controlinfo/W=ARToFDataLoad artofdataname
parameter1=S_Value + "_ParameterList"
//parameter2="xyz_ParameterList"
//parameterinfo1="ParameterDefinitions"
//parameterinfo2="xytParameterDefinitions"
wave wp1=$parameter1
//wave wp2=$parameter2

if(!waveexists(wp1))
artofsetname(ctrlName)
endif

setvariable artofPhotonEnergy,Win=ARToFDataLoad,value=_num:wp1[12]

setvariable artofWorkFunc,Win=ARToFDataLoad,value=_num:wp1[2]

setvariable  artofStartEb,Win=ARToFDataLoad,value=_num:-wp1[10]

setvariable  artofEndEB,Win=ARToFDataLoad,value=_num:-wp1[9]

setvariable  artofenergypntnumber,Win=ARToFDataLoad,value=_num:wp1[11]

setvariable artofCenterEnergy,Win=ARToFDataLoad,value=_num:wp1[16]

setvariable artofLensK,Win=ARToFDataLoad,value=_num:wp1[17]

setvariable  artofThetaStart,Win=ARToFDataLoad,value=_num:wp1[3]

setvariable  artofThetaend,Win=ARToFDataLoad,value=_num:wp1[4]

setvariable  artofthetapointnum,Win=ARToFDataLoad,value=_num:wp1[5]

setvariable artofphistart,Win=ARToFDataLoad,value=_num:wp1[6]

setvariable  artofphiend,Win=ARToFDataLoad,value=_num:wp1[7]

setvariable artofphipointnum,Win=ARToFDataLoad,value=_num:wp1[8]

setdatafolder curr

End


Function artofsaveparameter(ctrlName) : ButtonControl
	String ctrlName
string curr=getdatafolder(1)

setdatafolder root:OriginalData

string parameter1,parameter2,parameterinfo1,parameterinfo2

controlinfo/W=ARToFDataLoad artofdataname
parameter1=S_Value + "_ParameterList"
//parameter2="xyz_ParameterList"
//parameterinfo1="ParameterDefinitions"
//parameterinfo2="xytParameterDefinitions"
wave wp1=$parameter1
//wave wp2=$parameter2

if(!waveexists(wp1))
artofsetname(ctrlName)
endif

controlinfo/W=ARToFDataLoad artofPhotonEnergy

controlinfo/W=ARToFDataLoad artofWorkFunc
wp1[2]=V_Value

controlinfo/W=ARToFDataLoad  artofStartEb
wp1[10]=-V_Value

controlinfo/W=ARToFDataLoad  artofEndEB  
wp1[9]=-V_Value

controlinfo/W=ARToFDataLoad  artofenergypntnumber   
wp1[11]=V_Value

controlinfo/W=ARToFDataLoad artofCenterEnergy
wp1[16]=V_Value

controlinfo/W=ARToFDataLoad artofLensK
wp1[17]=V_Value

controlinfo/W=ARToFDataLoad  artofThetaStart
wp1[3]=V_Value

controlinfo/W=ARToFDataLoad  artofThetaend
wp1[4]=V_Value

controlinfo/W=ARToFDataLoad artofthetapointnum
wp1[5]=V_Value

controlinfo/W=ARToFDataLoad artofphistart
wp1[6]=V_Value

controlinfo/W=ARToFDataLoad  artofphiend
wp1[7]=V_Value

controlinfo/W=ARToFDataLoad artofphipointnum
wp1[8]=V_Value

setdatafolder curr


End

Function artofloaddata(ctrlName) : ButtonControl
	String ctrlName
 string curr=getdatafolder(1)
 setdatafolder root:OriginalData
 artofsaveparameter(ctrlName)
 execute "ReadARToFStreamed()"
 controlinfo/W=ARToFDataLoad artofdataname
 string tmpstr
 tmpstr=S_Value+"_BinMatrix"
 wave w=$tmpstr
 
string pathstr="root:ARToFData:"+tmpstr
 duplicate/O w,$pathstr

variable vs,ve
controlinfo/W=ARToFDataLoad  artofStartEb
vs=V_Value
controlinfo/W=ARToFDataLoad  artofEndEB  
ve=V_Value
setscale/I z,vs,ve,$pathstr
 setdatafolder curr
 
End

Window ARToFDataLoad() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel/K=1/W=(422,79,742,277) as "ARToFDataLoad"
	ModifyPanel fixedSize=1, frameStyle=1
	SetVariable artofdataname,pos={7,9},size={171,20},bodyWidth=80,title="\\f01\\F'@Arial Unicode MS'SampleName"
	SetVariable artofdataname,value= _STR:"Bi2Se3"
	SetVariable artofPhotonEnergy,pos={9,36},size={105,20},bodyWidth=60,title="\\f01\\F'@Arial Unicode MS'\\f02\\f01h\\M\\F'symbol'u\\M\\F'Times' \\f01(eV)"
	SetVariable artofPhotonEnergy,value= _NUM:7
	SetVariable artofWorkFunc,pos={123,35},size={117,20},bodyWidth=60,title="\\F'@Arial Unicode MS'\\f03W\\f01(eV)"
	SetVariable artofWorkFunc,value= _NUM:4.30000019073486
	SetVariable artofStartEb,pos={8,65},size={109,22},bodyWidth=60,title="\\f01\\F'@Arial Unicode MS'StartE\\BB"
	SetVariable artofStartEb,value= _NUM:-1.05
	SetVariable artofEndEB,pos={119,65},size={104,22},bodyWidth=60,title="\\f01\\F'@Arial Unicode MS'EndE\\BB"
	SetVariable artofEndEB,value= _NUM:0.05
	SetVariable artofThetaStart,pos={12,122},size={92,18},bodyWidth=50,title="\\f01\\F'arial'Start \\F'symbol'q\\F'arial'"
	SetVariable artofThetaStart,value= _NUM:-15
	SetVariable artofThetaend,pos={110,122},size={85,18},bodyWidth=50,title="\\f01\\F'arial'End \\F'symbol'q\\F'arial'"
	SetVariable artofThetaend,value= _NUM:15
	SetVariable artofthetapointnum,pos={202,121},size={109,18},bodyWidth=50,title="\\f01\\F'arial'PointNum"
	SetVariable artofthetapointnum,value= _NUM:100
	SetVariable artofphistart,pos={11,141},size={91,18},bodyWidth=50,title="\\f01\\F'arial'Start \\F'symbol'f\\F'arial'"
	SetVariable artofphistart,value= _NUM:-15
	SetVariable artofphiend,pos={111,142},size={84,18},bodyWidth=50,title="\\f01\\F'arial'End \\F'symbol'f\\F'arial'"
	SetVariable artofphiend,value= _NUM:15
	SetVariable artofphipointnum,pos={202,141},size={109,18},bodyWidth=50,title="\\f01\\F'arial'PointNum"
	SetVariable artofphipointnum,value= _NUM:100
	SetVariable artofCenterEnergy,pos={10,89},size={193,20},bodyWidth=60,title="\\f01\\F'@Arial Unicode MS'CenterEnergy(eV)"
	SetVariable artofCenterEnergy,value= _NUM:2.20000004768372
	SetVariable artofLensK,pos={209,89},size={104,20},bodyWidth=60,title="\\f01\\F'@Arial Unicode MS'LensK"
	SetVariable artofLensK,value= _NUM:0.5
	Button artofloadparameter,pos={7,171},size={100,20},proc=artofloadparameter,title="\\F'arial'LoadParameter"
	Button artofsaveparameter,pos={110,171},size={100,20},proc=artofsaveparameter,title="\\F'arial'saveParameter"
	Button artofloaddata,pos={215,171},size={100,20},proc=artofloaddata,title="\\F'arial'LoadData"
	Button artofsetsamplename,pos={180,10},size={100,20},proc=artofsetname,title="\\F'arial'SetDefault"
	SetVariable artofenergypntnumber,pos={231,67},size={81,20},bodyWidth=50,title="\\f01\\F'@Arial Unicode MS'Pnt\\F'Times'#"
	SetVariable artofenergypntnumber,value= _NUM:100
EndMacro





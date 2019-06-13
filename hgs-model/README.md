# 3D model of the Handheld Ground Station.

Models were originally created with Solidworks. .SLDPRT files, and exported .STL files will live here.
When modifying .sldprt files, make sure to save a copy as .stl as well for printing.

## For Printing:
All components are designed to be printed in a particular orientation, without the need for supports.
There are example pictures in the appropriately named sub-folder.

### For full assembly, print:
	1 : Antenna_Base_Clamp
	1 : Antenna_Cap
	1 : Handle_Clamp
	4 : Helical_Antenna_Segment
	1 : Phone&Battery_Holder_Base
	1 : Phone&Battery_Holder_Top
	1 : Phone&Battery_Holder_Bottom
	Either:
		1 : Handle (If printer large enough)
	Or:
		1 : Handle_Top
		1 : Handle_Bottom
	
### Assembly:
Parts are designed to fit together with a combination of epoxy and M4 (or #8 imperial) bolts and nuts.
The antenna segments and it's cap and clamp use the epoxy, this may be replaced or supplemented by a threaded rod.

## Individual Component Notes:

### Helical Antenna Segment:
This antenna is designed to be 100mm on it's longest axis (height).
It is designed to be printed standing up, with the peg at the top.
Four of these segments make up a single antenna.
Works fine with 20% infill, but increasing the wall thickness is recommended,
especially to strengthen the peg. (In stress testing the peg broke before anything else.)

Dimensions:

	Diameter 39.5mm
	Body Length 93mm
	Peg Length 7mm
	Peg Width 20mm
	Alignment Peg Width 4mm
	Peg Hole Extra Clearance 0.5mm

### Phone and Battery Holder:
Three part device that hangs off the backplane and handle to hold the phone.
Consists of one sliding base, a fixed bottom section that is attached to the handle and also holds the battery,
and a sliding top section that can be adjusted for different phone sizes.
Designed to hold the phone in a landscape orientation.

### Handle:
Single handle under the device for holding, attaches to bottom of backplane.
Comes in two halves, a top and bottom, for printing on smaller printers.
Can be printed whole on larger printers.
(When modifying, all edits applied to full model, and modifications should be applied before the split.
After saving main handle file, open split parts, File/Reload and rebuild them to update them to reflect the changes in the main model.)

## Fasteners:
Using M4 as standard bolt. (#8 is Imperial alternative)
Model dimensions for insets and holes: (added clearances to account for printing inaccuracies)

	Hole diameter: 4mm ideal, 4.4mm modeled.
	Nut/head height: 4.2mm ideal, 4.2mm modeled.
	Flat to flat width: 7mm ideal, 8.4mm modeled.
	Corner to corner width: 7.66mm ideal, 8.43mm modeled.

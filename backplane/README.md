# Backplane for Handheld Ground Station
Schematic files for the backplane, including impedence matching circuit for connecting the antenna to the rest of the components.

Schematic files created using KiCad 5.1.2.
- **.pro** to open up Kicad project
- **.kicad_pcb** for the PCB layout
- **.kicad_mod** for the individual footprints


## Microstrip Dimensions
Backplane material: FR-4 PCB material, 0.5 oz copper, 1.58 mm thick, Er 4.34 @ 1 GHz
Note: Do not remove any of the copper ground plane on the other side of the board beneath the traces.  

Microstrip widths for various impedances:
```
50 ohm
	Width:  3.05184 mm
	Length: Arbitrary

83 ohm?
	Width: 1.20938 mm
	Length: Arbitrary

140 ohm
	Width:  0.238155 mm
	Length: Arbitrary
```

## 1/4 Wave Matching Transformer Design:
	Start at connector
	Arbitrary length of 50 ohm
	Lambda/4 length (17.7623 mm) of 83.66 ohm
	Arbitrary length of 140 ohm
	End at the helix element


## Other notes
[Source for Raspberry Pi Zero footprint dimensions](http://www.electronics-lab.com/raspberry-pi-zero-footprint-and-dimensions/)\
[Source for wf-np9202 footprint dimensions](https://www.aliexpress.com/item/wireless-net-card-LAN-NIC-module-AR9271-150M-wireless-LAN-net-card-industrial-module/32746090657.html?tt=sns_none&aff_platform=default&cpt=1557507604073&sk=cC0ydLx2&aff_trace_key=5d988d9ac55b4f4d80da408161a19463-1557507604073-02869-cC0ydLx2&terminal_id=523d634d52754e72ad5634ec5f8829c2)
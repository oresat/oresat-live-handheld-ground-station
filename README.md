# Introduction
The OreSat Live Handheld Ground Station (HGS) project provides everything you need to build your own ground station capable of receiving images transmitted from OreSat in Low Earth Orbit.  HGS is designed to be inexpensive, easy to assemble, and simple to use so that it can be built by Middle and High School students.  The entire design is open source to encourage reuse and experimentation.

HGS is a portable unit built around a high gain directional antenna. Using a mobile phone application to locate OreSat, you aim the antenna to get the best possible signal. The live images are then received by the groundstation, error corrections are applied and the image is made available to any WiFi capable device through a built-in web page.

OreSat HGS act as a wifi access point providing an unsecured wireless network named "OreSatLive".  Devices identify the network as a hotspot requiring the user to sign-in for Internet access.  To view the image stream simply:
1. Connect your wifi to the "OreSatLive" network
2. Choose to sign-in when prompted
3. The OreSat Live web interface will open automatically

HGS was created for use with the OreSat mission, but it is designed to be used by any group interested in long range image transmission.  The handheld ground stations can be reused for other cubesat or balloon launches.

Once the final design is completed, users will be able to purchase all of the required parts as a kit from https://www.crowdsupply.com/

# HGS Parts List
All of the required parts to build HGS can be found in the Bill of Materials [(BOM)](BOM.md)

# Hardware Setup
Build your Handheld Ground Station kit according to the [Assembly Instructions](hgs-model/assembly-instructions/OreSat_Live_HGS_Assembly.pdf)

# Software Setup
1. [Download the SD card image oresat_hgs_14_jun_2019.img](https://drive.google.com/a/pdx.edu/uc?id=1BvP8ltkEwoBRSbCfQXceEiuxpVhkSf37&export=download)
2. Write the SD card image to a 2GB or larger card.  The [Raspberry Pi documentation](https://www.raspberrypi.org/documentation/installation/installing-images/) explains the procedure.

# Startup Procedure
1. Install the SD card in Raspberry Pi
2. Insert phone into the holder
3. Connect Raspberry Pi power cable to the USB power bank
4. Load Satellite AR app on phone and select OreSat
5. Point the ground station in the direction of OreSat
3. Connect your viewing devices to the "OreSatLive" wifi network

# Design Details
## Software Design
If you would like to build the software system from source follow the [Build Instructions](software/BUILD.md)

## Mechanical Design
You can 3D print all of the [mechanical parts](hgs-model/README.md)  

## Circuit Board Design
The integrated antenna backplane and matching network [circuit board design files](backplane/README.md)

# Related Projects
[OreSat Live](https://github.com/oresat/oresat-dxwifi-software) for software and firmware used on OreSat satellite

[Mini OreSat](https://github.com/oresat/oresat-live-mini-oresat) combines the OreSat Live software with a Raspberry Pi Zero W + Pi Camera to create platform for hobbyist and classroom experiments with high-altitude ballooning.

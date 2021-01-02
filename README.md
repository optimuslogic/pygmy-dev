# pygmy-dev
Pygmy Code and Tools for the Open Source FPGA+ARM+ML 
# This will get the repo to local
git clone --recursive https://github.com/optimuslogic/pygmy-dev
# Follow the readme in tools to setup the tools for Pygmy board to setup the tools (one time)

## Few FPGA examples are available in this folder for 7 segment and LED blink which can be compiled to bin.

#Example 1:
cd pygmy-dev/S7seg-apps/static-number
ql_symbiflow -compile -src . -d ql-eos-s3 -t top -v blinky.v -p pygmy.pcf -P PU64 -dump binary
#top.bin will be available in directory

Reset Pygmy board and press ‘user button’ while blue LED is flashing.
Should switch to mode where green LED is breathing.
If green LED not breathing, press reset again and ‘user button’ within 5 seconds of releasing reset (while blue LED is still flashing)
With green LED breathing, program fpga into Pygmy:


python3 <base-dir>/pygmy-sdk/TinyFPGA-Programmer-Application/tinyfpga-programmer-gui.py --port /dev/ttyACM0  --appfpga  top.bin --mode fpga

After programming has completed, reset the QuickFeather board and do not press the user button.
Blue LED should flash for 5 sec and then load the m4app and run it.

#Example 2:
cd pygmy-dev/S7seg-apps/blinky
ql_symbiflow -compile -src . -d ql-eos-s3 -t helloworldfpga -v blinky.v -p pygmy.pcf -P PU64 -dump binary
#helloworldfpga.bin will be available in directory

Reset Pygmy board and press ‘user button’ while blue LED is flashing.
Should switch to mode where green LED is breathing.
If green LED not breathing, press reset again and ‘user button’ within 5 seconds of releasing reset (while blue LED is still flashing)
With green LED breathing, program fpga into Pygmy:

python3 <base-dir>/pygmy-sdk/TinyFPGA-Programmer-Application/tinyfpga-programmer-gui.py --port /dev/ttyACM0  --appfpga  helloworldfpga.bin --mode fpga

After programming has completed, reset the QuickFeather board and do not press the user button.
Blue LED should flash for 5 sec and then load the m4app and run it.


##Please refer to https://github.com/QuickLogic-Corp/TinyFPGA-Programmer-Application document, to install serial driver and fpga programmer application

#The source code is within pygmy-sdk clone from qorc-sdk

#The SDK will mention about setup instructions of the Toolchain and utilties, which you need to IGNORE, as they are applicable to Linux x86-64 machines only.
# You can follow the instructions from  the "Baremetal Example" section of Readme.



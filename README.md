# Pygmy Code and Tools for the Open Source FPGA+ARM+ML

```sh
# This will get the repo to local
git clone --recursive https://github.com/optimuslogic/pygmy-dev
cd pygmy-dev
```

Follow the readme in tools to setup the tools for Pygmy board to setup the tools (one time).

Please refer to [QuickLogic-Corp/TinyFPGA-Programmer-Application](https://github.com/QuickLogic-Corp/TinyFPGA-Programmer-Application) document, for installing serial drivers and the FPGA programmer application.

The source code is within submodule `pygmy-sdk` (a fork of [QuickLogic-Corp/qorc-sdk](https://github.com/QuickLogic-Corp/qorc-sdk)).

The SDK will mention about setup instructions of the Toolchain and utilties, which you need to IGNORE, as they are applicable to Linux x86-64 machines only. You can follow the instructions from  the "Baremetal Example" section of Readme.

## Examples

Few FPGA examples are available in [pygmy-sdk/S7seg-apps/](pygmy-sdk/S7seg-apps) for 7 segment and LED blink. Those can be synthesized/compiled to bitstreams (bin files).

```sh
# Example 1
cd static-number
ql_symbiflow -compile -src . -d ql-eos-s3 \
  -t top \
  -v blinky.v \
  -p pygmy.pcf -P PU64 -dump binary
# Bitsream 'top.bin' will be available in directory
```

```sh
# Example 2
cd blinky
ql_symbiflow -compile -src . -d ql-eos-s3 \
  -t helloworldfpga \
  -v blinky.v \
  -p pygmy.pcf -P PU64 -dump binary
# Bitsream 'helloworldfpga.bin' will be available in directory
```

Reset Pygmy board and press ‘user button’ while blue LED is flashing. Should switch to mode where green LED is breathing. If green LED not breathing, press reset again and ‘user button’ within 5 seconds of releasing reset (while blue LED is still flashing).

With green LED breathing, program FPGA into Pygmy:

```sh
python3 <base-dir>/pygmy-sdk/TinyFPGA-Programmer-Application/tinyfpga-programmer-gui.py \
  --port /dev/ttyACM0 \
  --appfpga <bitstream>.bin \
  --mode fpga
```

After programming has completed, reset the QuickFeather board and do not press the user button.
Blue LED should flash for 5 sec and then load the m4app and run it.

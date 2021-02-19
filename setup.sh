# Be Root (sudo su on rpi32/arm7l, on Android, its always root)
# Setup Tools (one Time on PC/RPI/Android Termux) and test built in examples before moving to qorc-sdk or pygmy-apps or your own design

set -e

cd $(dirname "$0")

# Install dependencies
command -v pkg && APT_CMD='pkg' || APT_CMD='apt'

$APT_CMD install -y \
  autoconf \
  automake \
  bison \
  build-essential \
  cmake \
  flex \
  git \
  libffi \
  libtool \
  libxslt \
  make \
  pkg-config \
  tcl \
  texinfo

if [ "x$APT_CMD" = "xapt" ]; then
  apt install -y \
    apt-utils \
    libffi-dev \
    libreadline-dev \
    libssl-dev \
    libusb-1.0-0 \
    libusb-1.0-0-dev \
    libxslt-dev \
    python-dev \
    python3 \
    python3-lxml \
    python3-simplejson \
    tcl-dev \
    tcl-tclreadline \
    telnet
fi

# optional: iverilog gtkwave

#Install apt/python dependencies:
#Python version should be 3.7 or 3.8.5 (esp on Android)
#if 3.9 is there, then install and use 3.8.5

#Install Python libraries
#pip3 install wheel python-constraint serial tinyfpgab

mkdir -p ~/symbiflow
export INSTALL_DIR=~/symbiflow

curl -fsSL $(curl -fsSL https://storage.googleapis.com/symbiflow-arch-defs-install/latest) | tar -xzvf - -C $INSTALL_DIR

export PATH="$INSTALL_DIR/bin:$INSTALL_DIR/quicklogic-arch-defs/bin:$INSTALL_DIR/quicklogic-arch-defs/bin/python:$PATH"

(
cd quicklogic-yosys
make config-gcc
make -j4 install PREFIX="$INSTALL_DIR"
)

( cd yosys-symbiflow-plugins && make -j4 install )
( cd vtr-verilog-to-routing && make -j4 )

cp \
  vtr-verilog-to-routing/build/vpr/vpr \
  /root/tools/bin \
  vtr-verilog-to-routing/build/utils/fasm/genfasm \
  $INSTALL_DIR/bin

vpr -h
yosys -h
qlfasm -h
qlsymbiflow -h

cd $INSTALL_DIR/quicklogic-arch-defs/tests/counter_16bit
ql_symbiflow -compile -d ql-eos-s3 -P pd64 -v counter_16bit.v -t top -p chandalar.pcf
# top.bin must be generated successfully

# Get GCC toolchain for C SRC (ARM)

cd $INSTALL_DIR
mkdir -p arm-gcc
cd arm-gcc
export PATH=$INSTALL_DIR/arm-gcc/bin:$PATH

case "$(uname -m)" in
  aarch64)
    #- For RPI4 in 64 -bit mode (Ubuntu 20.04) OR for Termux on Android (ubuntu 20.04 proot)
    ARM_GCC_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-aarch64-linux.tar.bz2
  ;;
  *)
    #- For RPI3/4 in 32 -bit mode (Raspbian generally)
    ARM_GCC_URL=https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v9.3.1-1.1/xpack-arm-none-eabi-gcc-9.3.1-1.1-linux-arm.tar.gz
  ;;
esac

if [ -n "$ARM_GCC_URL" ]; then
  curl -fsSL "$ARM_GCC_URL" | tar --strip-components=1 -xvjf
  # Test the GNU RM GCC Embedded toolchain
  arm-none-eabi-gcc --version
fi

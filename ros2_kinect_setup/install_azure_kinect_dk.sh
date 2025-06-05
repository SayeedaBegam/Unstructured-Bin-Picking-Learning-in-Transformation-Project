#!/bin/bash

# install_azure_kinect.sh
# Sets up Azure Kinect SDK and rules on Ubuntu 22.04

set -e
LOG="$HOME/kinect_setup.log"
exec > >(tee -i $LOG)
exec 2>&1

echo "🔧 Starting Azure Kinect DK setup..."

# Install dependencies
sudo apt update && sudo apt install -y \
    git build-essential cmake libusb-1.0-0-dev libglfw3-dev libjpeg-dev

# Clone and build Azure Kinect SDK
cd ~
git clone https://github.com/microsoft/Azure-Kinect-Sensor-SDK.git
cd Azure-Kinect-Sensor-SDK
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install

# Prompt for Depth Engine
echo "Please manually download the Depth Engine:"
echo "https://learn.microsoft.com/en-us/previous-versions/azure/kinect-dk/sensor-sdk-download"
read -p "Press enter after placing libdepthengine.so.2.0 in the current directory..."

# Copy depth engine library
sudo cp libdepthengine.so.2.0 /usr/lib/
sudo ldconfig

# Set up udev rules
echo "Setting up udev rules..."
cat <<EOF | sudo tee /etc/udev/rules.d/99-k4a.rules
BUS!="usb", ACTION!="add", SUBSYSTEM!="usb_device", GOTO="k4a_logic_rules_end"
ATTRS{idVendor}=="045e", ATTRS{idProduct}=="097a", MODE="0666", GROUP="plugdev"
ATTRS{idVendor}=="045e", ATTRS{idProduct}=="097b", MODE="0666", GROUP="plugdev"
ATTRS{idVendor}=="045e", ATTRS{idProduct}=="097c", MODE="0666", GROUP="plugdev"
ATTRS{idVendor}=="045e", ATTRS{idProduct}=="097d", MODE="0666", GROUP="plugdev"
ATTRS{idVendor}=="045e", ATTRS{idProduct}=="097e", MODE="0666", GROUP="plugdev"
LABEL="k4a_logic_rules_end"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger

# Add user to plugdev
sudo usermod -aG plugdev $USER

echo "Azure Kinect SDK setup completed. Reboot your machine and run:"
echo "lsusb | grep -i kinect"
echo "To launch viewer: k4aviewer"

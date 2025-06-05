#!/bin/bash

# install_ros2_humble.sh
# Comprehensive installation script for ROS 2 Humble on Ubuntu 22.04 LTS

set -e

LOG_FILE="$HOME/ros2_humble_install.log"
exec > >(tee -i "$LOG_FILE")
exec 2>&1

echo "Starting ROS 2 Humble installation on Ubuntu 22.04 LTS..."

##############################
# 1. Set Locale to UTF-8
##############################
echo "Setting locale to UTF-8..."
sudo apt update && sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

##############################
# 2. Enable Universe Repository
##############################
echo "Enabling 'universe' repository..."
sudo apt install -y software-properties-common
sudo add-apt-repository universe

##############################
# 3. Add ROS 2 GPG Key
##############################
echo "Adding ROS 2 GPG key..."
sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc \
    | sudo gpg --dearmor -o /usr/share/keyrings/ros-archive-keyring.gpg

##############################
# 4. Add ROS 2 Repository
##############################
echo "Adding ROS 2 repository to sources list..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" \
| sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

##############################
# 5. Update Package Index
##############################
echo "Updating package index..."
sudo apt update

##############################
# 6. Install ROS 2 Packages
##############################
echo "Installing ROS 2 Humble desktop packages..."
sudo apt install -y ros-humble-desktop

##############################
# 7. Environment Setup
##############################
echo "Setting up ROS 2 environment..."
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

##############################
# 8. Install Development Tools
##############################
echo "Installing development tools..."
sudo apt install -y python3-colcon-common-extensions python3-rosdep

##############################
# 9. Initialize rosdep
##############################
echo "Initializing rosdep..."
sudo rosdep init
rosdep update

##############################
# 10. Verify Installation
##############################
echo "Verifying ROS 2 installation..."
source /opt/ros/humble/setup.bash
ros2 --version
echo "ROS 2 Humble installation completed successfully!"

echo "To test the installation, open two terminals and run the following commands:"
echo "Terminal 1:"
echo "  source /opt/ros/humble/setup.bash"
echo "  ros2 run demo_nodes_cpp talker"
echo "Terminal 2:"
echo "  source /opt/ros/humble/setup.bash"
echo "  ros2 run demo_nodes_py listener"

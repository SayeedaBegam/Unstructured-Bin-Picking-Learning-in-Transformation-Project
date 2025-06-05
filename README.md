# Unstructured Bin Picking – Setup & Progress Log

This repository is part of my learning journey under the **Transformation Project**, focused on building an **Unstructured Bin Picking** system using **ROS 2**, **Azure Kinect DK**, and a modern Ubuntu-based robotics stack.

I will document all progress and share relevant scripts, configurations, and experiments here.

---

## System Setup Overview

The setup process begins with installing a compatible operating system (**Ubuntu 22.04 LTS – Jammy Jellyfish**) followed by the core robotics stack and sensors:

1. **Install Ubuntu 22.04 LTS**
   - Official ISO: [Ubuntu Jammy Jellyfish](https://releases.ubuntu.com/jammy/)
   - Recommended for compatibility with ROS 2 and Azure Kinect SDK.

2. **Install ROS 2 Humble Hawksbill**
   - Use the provided Bash script to automate the complete installation.
   - Includes locale setup, dependency management, ROS tools, and verification steps.

3. **Install Azure Kinect DK SDK**
   - Configure and compile the Azure Kinect SDK for Ubuntu.
   - Set up device access via udev rules and required libraries.

---

## Contents

###  `ros2_kinect_setup/`

Contains Bash scripts for system setup:

#### `install_ros2_humble.sh`
Installs **ROS 2 Humble Hawksbill** on Ubuntu 22.04:
- Adds ROS sources and keys
- Installs full desktop ROS 2 suite
- Sets up `rosdep`, `colcon`, and other development tools
- Verifies the installation

#### `install_azure_kinect.sh`
Installs the **Azure Kinect SDK**:
- Clones and builds the SDK from source
- Adds udev rules for device recognition
- Assists in installing the proprietary Depth Engine library
- Adds the user to the appropriate permission group
- Verifies connection with `k4aviewer` and `lsusb`

---

##  About Azure Kinect DK

The **Azure Kinect Developer Kit (DK)** is a powerful depth-sensing device developed by Microsoft. It features:

- A 1MP depth camera (based on Time-of-Flight technology)
- A 4K RGB camera
- A 7-microphone spatial audio array
- Gyroscope and accelerometer (IMU)

This device is widely used in robotics for 3D perception, object tracking, gesture recognition, and more — making it an excellent choice for the **Unstructured Bin Picking** application, where precise depth sensing and scene understanding are essential.

---

## How to Use

```bash
# Clone the repo and go to the setup directory
cd ros2_kinect_setup

# Install ROS 2
bash install_ros2_humble.sh

# Install Azure Kinect SDK
bash install_azure_kinect.sh

#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# --- 1. Clone the repository recursively ---
# The --recursive flag is crucial for getting all submodules and assets.
echo "1. Deleting old repository and cloning a fresh copy..."
rm -rf rcs
git clone --recursive git@github.com:RobotControlStack/rcs.git
cd rcs

# --- 2. Install system dependencies ---
# This step requires your sudo password.
echo "2. Installing system dependencies from debian_deps.txt..."
sudo apt update
sudo apt install -y $(cat debian_deps.txt)

# --- 3. Set up and activate a Python virtual environment ---
echo "3. Creating and activating a Python virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

# --- 4. Install Python dependencies ---
echo "4. Installing Python dependencies..."
pip install -r requirements_dev.txt
pip config --site set global.no-build-isolation false

# --- 5. Build and install the rcs core package ---
echo "5. Building and installing the RCS core package..."
pip install -ve .

# --- 6. Install the rcs_fr3 hardware extension ---
# This extension is required by the example scripts.
echo "6. Installing the RCS FR3 hardware extension..."
pip install -ve extensions/rcs_fr3

echo "✅ RCS installation is complete!"
echo "To activate the environment in a new terminal, run: "
echo "cd rcs"
echo "source .venv/bin/activate"
echo ""
echo "You can now run the example scripts. For instance:"
echo "python python/examples/fr3_env_cartesian_control.py"

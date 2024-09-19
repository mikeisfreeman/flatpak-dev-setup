#!/bin/bash

# Define color codes
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Step 1: Create necessary directories
mkdir -p ~/.flatpak_dev/bin ~/flatpak_dev
echo -e "${YELLOW}Created directories:${NC} ~/.flatpak_dev/bin and ~/flatpak_dev"

# Step 2: Download flatpak_project_init script into ~/.flatpak_dev/bin
wget -q -O ~/.flatpak_dev/bin/flatpak_project_init https://raw.githubusercontent.com/mikeisfreeman/flatpak-dev-setup/refs/heads/main/flatpak_project_init.sh
echo -e "${GREEN}Downloaded flatpak_project_init script${NC}"

# Step 3: Make the script executable
chmod +x ~/.flatpak_dev/bin/flatpak_project_init
echo -e "${YELLOW}Made flatpak_project_init script executable${NC}"

# Step 4: Add ~/.flatpak_dev/bin to PATH
if ! grep -q 'export PATH=$HOME/.flatpak_dev/bin:$PATH' ~/.bashrc; then
    echo 'export PATH=$HOME/.flatpak_dev/bin:$PATH' >> ~/.bashrc
    echo -e "${GREEN}Added ~/.flatpak_dev/bin to PATH in ~/.bashrc${NC}"
else
    echo -e "${YELLOW}~/.flatpak_dev/bin already in PATH${NC}"
fi
export PATH=$HOME/.flatpak_dev/bin:$PATH

# Step 5: Optionally, check for and install Flatpak, Flatpak Builder, and the freedesktop.SDK
if ! command -v flatpak &> /dev/null; then
    sudo apt install -y flatpak
    echo -e "${GREEN}Installed Flatpak${NC}"
else
    echo -e "${YELLOW}Flatpak already installed${NC}"
fi
if ! command -v flatpak-builder &> /dev/null; then
    sudo apt install -y flatpak-builder
    echo -e "${GREEN}Installed Flatpak Builder${NC}"
else
    echo -e "${YELLOW}Flatpak Builder already installed${NC}"
fi

if flatpak list --runtime | grep -q "org.freedesktop.Sdk//23.08" &> /dev/null; then
    flatpak install flathub org.freedesktop.Sdk//23.08 -y
    echo -e "${GREEN}Installed freedesktop.Sdk//23.08${NC}"
else
    echo -e "${YELLOW}freedesktop.Sdk//23.08 already installed${NC}"
fi


echo -e "${GREEN}Flatpak development environment setup complete.${NC}"

# Summary of created directories
echo -e "${YELLOW}Summary of created directories:${NC}"
echo -e "  - ${GREEN}~/.flatpak_dev/bin${NC}: Contains the flatpak_project_init script"
echo -e "  - ${GREEN}~/flatpak_dev${NC}: Directory for your Flatpak development projects"
echo -e ""
echo -e " Note: add the new init script to your path:"
echo -e "    export PATH=$HOME/.flatpak_dev/bin:$PATH"
echo -e ""
echo -e "${YELLOW}You can now use 'flatpak_project_init' to start new Flatpak projects in ~/flatpak_dev/your_project_dir/${NC}"


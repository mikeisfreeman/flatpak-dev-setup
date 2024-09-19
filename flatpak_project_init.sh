#!/bin/bash

# Define color codes
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check for project name input
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: flatpak_project_init <project_name> [directory]${NC}"
    exit 1
fi

# Validate project name
if ! [[ $1 =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo -e "${YELLOW}Error: Project name must contain only alphanumeric characters, underscores, or hyphens.${NC}"
    exit 1
fi

project_name=$1

# Validate project directory
if [ "$2" = "." ] || [ -z "$2" ]; then
    project_dir=$(pwd)
elif ! [[ $2 =~ ^[a-zA-Z0-9_/-]+$ ]]; then
    echo -e "${YELLOW}Error: Directory name must contain only alphanumeric characters, underscores, forward slashes, or hyphens.${NC}"
    exit 1
else
    project_dir=$2
fi

# Ensure script is running from the same location as the new app initialization
if [ "$project_dir" != "$(pwd)" ]; then
    echo -e "${YELLOW}Error: Script must be run from the same directory where the new app is being initialized.${NC}"
    exit 1
fi

echo -e "${YELLOW}Initializing Flatpak project: $project_name in $project_dir${NC}"

# Create project directories
mkdir -p "$project_dir/src"
echo -e "${GREEN}Created project directory:${NC} $project_dir/src"

touch "$project_dir/com.example.$project_name.json"
echo -e "${GREEN}Created Flatpak manifest:${NC} com.example.$project_name.json"

touch "$project_dir/src/$project_name.py"
echo -e "${GREEN}Created main Python file:${NC} $project_name.py"

# Basic Flatpak manifest
echo -e "${YELLOW}Generating Flatpak manifest...${NC}"
cat <<EOL > "$project_dir/com.example.$project_name.json"
{
  "id": "com.example.$project_name",
  "runtime": "org.freedesktop.Platform",
  "runtime-version": "23.08",
  "sdk": "org.freedesktop.Sdk",
  "command": "$project_name",
  "modules": [
    {
      "name": "$project_name",
      "buildsystem": "simple",
      "build-commands": [
        "python -m pip install --no-deps --prefix=/app .",
        "install -Dm644 icons/16x16/${project_name}.png /app/share/icons/hicolor/16x16/apps/${project_name}.png",
        "install -Dm644 icons/32x32/${project_name}.png /app/share/icons/hicolor/32x32/apps/${project_name}.png",
        "install -Dm644 icons/64x64/${project_name}.png /app/share/icons/hicolor/64x64/apps/${project_name}.png",
        "install -Dm644 icons/128x128/${project_name}.png /app/share/icons/hicolor/128x128/apps/${project_name}.png",
        "install -Dm644 icons/256x256/${project_name}.png /app/share/icons/hicolor/256x256/apps/${project_name}.png",
        "install -Dm644 icons/512x512/${project_name}.png /app/share/icons/hicolor/512x512/apps/${project_name}.png",
        "install -Dm644 icons/scalable/${project_name}.svg /app/share/icons/hicolor/scalable/apps/${project_name}.svg",

        "install -Dm644 icons/16x16/${project_name}-dark.png /app/share/icons/hicolor/16x16/apps/${project_name}-dark.png",
        "install -Dm644 icons/32x32/${project_name}-dark.png /app/share/icons/hicolor/32x32/apps/${project_name}-dark.png",
        "install -Dm644 icons/64x64/${project_name}-dark.png /app/share/icons/hicolor/64x64/apps/${project_name}-dark.png",
        "install -Dm644 icons/128x128/${project_name}-dark.png /app/share/icons/hicolor/128x128/apps/${project_name}-dark.png",
        "install -Dm644 icons/256x256/${project_name}-dark.png /app/share/icons/hicolor/256x256/apps/${project_name}-dark.png",
        "install -Dm644 icons/512x512/${project_name}-dark.png /app/share/icons/hicolor/512x512/apps/${project_name}-dark.png",
        "install -Dm644 icons/scalable/${project_name}-dark.svg /app/share/icons/hicolor/scalable/apps/${project_name}-dark.svg",
        "cp -r assets /app/share/${project_name}"
      ],
      "sources": [
        {
          "type": "dir",
          "path": "src"
        }
      ]
    }
  ]
}
EOL
echo -e "${GREEN}Flatpak manifest generated successfully${NC}"

# Notify user
echo -e "${GREEN}Flatpak project '$project_name' initialized in $project_dir${NC}"
echo -e "${YELLOW}Project structure:${NC}"
echo -e "  $project_dir/"
echo -e "  ├── com.example.$project_name.json"
echo -e "  └── src/"
echo -e "      └── $project_name.py"

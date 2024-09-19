# Flatpak Dev Setup


This project provides a quick setup script for initializing a Flatpak development environment. It creates necessary directories, installs required tools, and sets up a convenient project initialization script.

## Quickstart
#### Download and execute the setup script:
```bash
wget -q -O - https://raw.githubusercontent.com/mikeisfreeman/flatpak-dev-setup/refs/heads/main/setup.sh | bash
```

This command will:
- Create required directories
- Download and install the ```flatpak_project_init``` script
- Add flatpak_project_init to your PATH
- Install Flatpak and Flatpak Builder if not already present
_**After running the setup**_, you can use the ```flatpak_project_init``` command to quickly start new Flatpak projects.

#### Create a new Flatpak project:
```bash
mkdir -p ~/flatpak_dev/<project_name>
cd ~/flatpak_dev/<project_name>
flatpak_project_init .
```

This will create a new project directory with the specified name, initialize a Flatpak manifest, and create **main&period;py** with a simple hello flatpak script in it.

For more information on using this tool and developing Flatpak applications, please refer to the documentation.

-------------------------------
<table style="width: auto; border: none;">
<tr><td><b>Author:</b>  Mike</td></tr>
<tr><td><b>Version:</b> 0.1.0</td></tr>
<tr><td><b>Repository:</b> <a href="https://github.com/mikeisfreeman/flatpak-dev-setup">flatpak-dev-setup</a></td></tr>
</table>

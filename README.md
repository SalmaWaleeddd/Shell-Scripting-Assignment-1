# Shell-Scripting-Assignment-1

# Shell Scripting Assignment 1 - JDK Installation

Automated script to install Oracle JDK for the `pet-clinic` user on Ubuntu systems.

## Script: `install-jdk.sh`

### Features:
- Creates dedicated `pet-clinic` user
- Downloads and installs Oracle JDK 25
- Configures environment variables automatically
- Idempotent - safe to run multiple times

### Usage:
```bash
chmod +x install-jdk.sh
sudo ./install-jdk.sh

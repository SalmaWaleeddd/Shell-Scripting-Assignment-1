#! /bin/bash

USER="pet-clinic"
JAVA_DIR="/home/$USER/java"


JDK_VERSION="25"
JDK_URL="https://download.oracle.com/java/25/latest/jdk-25_linux-x64_bin.tar.gz"
ARCHIVE_NAME="jdk-${JDK_VERSION}_linux-x64_bin.tar.gz"

#1. Create user if not exists
if ! id "$USER" &>/dev/null; then
	sudo useradd -m -s  /bin/bash "$USER"
	echo "User created"
else
	echo "User already exists"
fi

# 2. Create java dir if not exists
if [ ! -d "$JAVA_DIR" ];then
	sudo mkdir -p "$JAVA_DIR"
	sudo chown "$USER:$USER" "$JAVA_DIR"
	echo "java dir is created"
else
	echo "java dir exists"
fi

#3. Check if Java JDK is installed
if sudo -u "$USER" bash -i -c ' command -v javac' &>/dev/null; then
	echo "Java JDK is installed"
else
	echo "Java JDK is NOT installed"
	echo "Installing Java JDK now..."
	# Switch to user context and install JDK
	sudo -u "$USER" bash << EOF
cd "$JAVA_DIR"
wget -q "$JDK_URL" -O "$ARCHIVE_NAME"
tar -xzf "$ARCHIVE_NAME"
rm "$ARCHIVE_NAME"

# Extract the JDK folder name (e.g., jdk-25.0.1)
JDK_FOLDER=\$(ls -d jdk*| head -n 1)

# Permanent setup - add to .bashrc for future sessions
echo "" >> ~/.bashrc
echo "# Java JDK setup" >> ~/.bashrc
echo "export JAVA_HOME=\$HOME/java/\$JDK_FOLDER" >> ~/.bashrc
echo 'export PATH=\$JAVA_HOME/bin:\$PATH' >> ~/.bashrc


# Load the new environment for current session
source ~/.bashrc

# Set environment variables for immediate use
export JAVA_HOME="\$HOME/java/\$JDK_FOLDER"
export PATH="\$JAVA_HOME/bin:\$PATH"

# Verify installation
echo "Java JDK installed for user '$USER':"
javac -version
java -version
EOF
fi

	

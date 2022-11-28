#!/bin/bash
# Bash Script for install cageframework tools
# Must run to install tool

clear
echo "

██████╗ █████╗  ██████╗ ███████╗
██╔════╝██╔══██╗██╔════╝ ██╔════╝
██║     ███████║██║  ███╗█████╗  
██║     ██╔══██║██║   ██║██╔══╝  
╚██████╗██║  ██║╚██████╔╝███████╗
╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
";

sudo chmod +x uninstall

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/cageframework"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "cage" ]; then
    INSTALL_DIR="/usr/local/cageframework"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.cageframework"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory cageframework was found! Do you want to replace it? [Y/n]:" ;
    read -r mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/cageframework*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/cageframework*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/cage" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/cage"
    else
        sudo rm -rf "$ETC_DIR/cage"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/xzendercage/cageframework "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/cageframework.py" "${1+"$@"}" > "$INSTALL_DIR/cageframework";
chmod +x "$INSTALL_DIR/cageframework";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/cageframework" "$BIN_DIR"
    cp "$INSTALL_DIR/cageframework.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/cageframework" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/cageframework.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/cageframework";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing cageframework !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi

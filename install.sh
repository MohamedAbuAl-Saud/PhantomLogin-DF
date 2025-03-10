#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Detect the operating system
OS="$(uname -s)"
case "$OS" in
    Linux*)     OS="Linux";;
    Darwin*)    OS="macOS";;
    CYGWIN*)    OS="Windows";;
    MINGW*)     OS="Windows";;
    *)          OS="UNKNOWN"
esac

# Detect if running on Android (Termux)
if [[ "$(uname -o)" == "Android" ]]; then
    OS="Android"
fi

# Function to install ngrok
install_ngrok() {
    echo -e "${GREEN}Installing ngrok...${NC}"
    if [[ "$OS" == "Linux" ]]; then
        wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
        unzip ngrok-stable-linux-amd64.zip
        sudo mv ngrok /usr/local/bin/
        rm ngrok-stable-linux-amd64.zip
    elif [[ "$OS" == "macOS" ]]; then
        brew install ngrok/ngrok/ngrok
    elif [[ "$OS" == "Windows" ]]; then
        echo -e "${YELLOW}Please download ngrok manually from https://ngrok.com/download and add it to your PATH.${NC}"
        return 1
    elif [[ "$OS" == "Android" ]]; then
        pkg update
        pkg install wget unzip -y
        wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
        unzip ngrok-stable-linux-arm.zip
        mv ngrok /data/data/com.termux/files/usr/bin/
        rm ngrok-stable-linux-arm.zip
    else
        echo -e "${RED}Unsupported OS for ngrok installation.${NC}"
        return 1
    fi
    echo -e "${GREEN}ngrok installed successfully!${NC}"
}

# Function to install pyngrok
install_pyngrok() {
    echo -e "${GREEN}Installing pyngrok...${NC}"
    if [[ "$OS" == "Android" ]]; then
        pip install pyngrok
    else
        pip install pyngrok
    fi
    echo -e "${GREEN}pyngrok installed successfully!${NC}"
}

# Function to install SSH
install_ssh() {
    echo -e "${GREEN}Installing SSH...${NC}"
    if [[ "$OS" == "Linux" ]]; then
        sudo apt update
        sudo apt install openssh-client -y
    elif [[ "$OS" == "macOS" ]]; then
        brew install openssh
    elif [[ "$OS" == "Windows" ]]; then
        echo -e "${YELLOW}SSH is included in Git Bash or WSL. No additional installation is required.${NC}"
    elif [[ "$OS" == "Android" ]]; then
        pkg update
        pkg install openssh -y
    else
        echo -e "${RED}Unsupported OS for SSH installation.${NC}"
        return 1
    fi
    echo -e "${GREEN}SSH installed successfully!${NC}"
}

# Function to install Serveo.net (no installation needed, just SSH)
install_serveo() {
    echo -e "${GREEN}Serveo.net does not require installation. It uses SSH.${NC}"
}

# Function to install localhost.run (no installation needed, just SSH)
install_localhost_run() {
    echo -e "${GREEN}localhost.run does not require installation. It uses SSH.${NC}"
}

# Function to display the menu
show_menu() {
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${BLUE}1. Install ngrok and pyngrok${NC}"
    echo -e "${BLUE}2. Install Serveo.net (requires SSH)${NC}"
    echo -e "${BLUE}3. Install localhost.run (requires SSH)${NC}"
    echo -e "${BLUE}4. Install All${NC}"
    echo -e "${YELLOW}=================================${NC}"
}

# Main function
main() {
    echo -e "${GREEN}Welcome to the installation script!${NC}"
    echo -e "${YELLOW}This script will help you install ngrok, pyngrok, Serveo.net, and localhost.run.${NC}"

    show_menu

    echo -e "${GREEN}Choose an option:${NC}"
    read choice

    case $choice in
        1)
            echo -e "${GREEN}Do you want to install ngrok and pyngrok? (y/n):${NC}"
            read install_ngrok_choice
            if [[ "$install_ngrok_choice" == "y" ]]; then
                install_ngrok
                install_pyngrok
            else
                echo -e "${YELLOW}Skipping ngrok and pyngrok installation.${NC}"
            fi
            ;;
        2)
            echo -e "${GREEN}Do you want to install Serveo.net? (y/n):${NC}"
            read install_serveo_choice
            if [[ "$install_serveo_choice" == "y" ]]; then
                install_ssh
                install_serveo
            else
                echo -e "${YELLOW}Skipping Serveo.net installation.${NC}"
            fi
            ;;
        3)
            echo -e "${GREEN}Do you want to install localhost.run? (y/n):${NC}"
            read install_localhost_run_choice
            if [[ "$install_localhost_run_choice" == "y" ]]; then
                install_ssh
                install_localhost_run
            else
                echo -e "${YELLOW}Skipping localhost.run installation.${NC}"
            fi
            ;;
        4)
            echo -e "${GREEN}Do you want to install all tools? (y/n):${NC}"
            read install_all_choice
            if [[ "$install_all_choice" == "y" ]]; then
                install_ngrok
                install_pyngrok
                install_ssh
                install_serveo
                install_localhost_run
            else
                echo -e "${YELLOW}Skipping all installations.${NC}"
            fi
            ;;
        *)
            echo -e "${RED}Invalid choice. Exiting...${NC}"
            exit 1
            ;;
    esac

    echo -e "${GREEN}Installation process completed!${NC}"
}

# Run the main function
main

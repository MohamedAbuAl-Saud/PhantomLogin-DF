#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

install_ngrok() {
    echo -e "${GREEN}Installing ngrok...${NC}"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
        unzip ngrok-stable-linux-amd64.zip
        sudo mv ngrok /usr/local/bin/
        rm ngrok-stable-linux-amd64.zip
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ngrok/ngrok/ngrok
    else
        echo -e "${RED}Unsupported OS for ngrok installation.${NC}"
        exit 1
    fi
    echo -e "${GREEN}ngrok installed successfully!${NC}"
}

install_ssh() {
    echo -e "${GREEN}Installing SSH...${NC}"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update
        sudo apt install openssh-client -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install openssh
    else
        echo -e "${RED}Unsupported OS for SSH installation.${NC}"
        exit 1
    fi
    echo -e "${GREEN}SSH installed successfully!${NC}"
}

install_serveo() {
    echo -e "${GREEN}Serveo.net does not require installation. It uses SSH.${NC}"
}

install_localhost_run() {
    echo -e "${GREEN}localhost.run does not require installation. It uses SSH.${NC}"
}

show_menu() {
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${BLUE}1. Install ngrok${NC}"
    echo -e "${BLUE}2. Install Serveo.net (requires SSH)${NC}"
    echo -e "${BLUE}3. Install localhost.run (requires SSH)${NC}"
    echo -e "${BLUE}4. Install All${NC}"
    echo -e "${YELLOW}=================================${NC}"
}

main() {
    echo -e "${GREEN}Welcome to the installation script!${NC}"
    echo -e "${YELLOW}This script will help you install ngrok, Serveo.net, and localhost.run.${NC}"

    show_menu

    echo -e "${GREEN}Choose an option:${NC}"
    read choice

    case $choice in
        1)
            echo -e "${GREEN}Do you want to install ngrok? (y/n):${NC}"
            read install_ngrok_choice
            if [[ "$install_ngrok_choice" == "y" ]]; then
                install_ngrok
            else
                echo -e "${YELLOW}Skipping ngrok installation.${NC}"
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

main

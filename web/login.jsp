<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2024/11/18
  Time: 上午9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! int a=0;%>
<% for(int i=0;i<10;i++) a=a+i;%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>客户管理信息系统登录页面</title>
    <style>
        body{
            background-color:#CCC;
            background-image:url(2.jpg);
            background-repeat:no-repeat;
            background-position:center;
            width: 100%;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-input {
            width: 95%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .login-btn {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .login-btn:hover {
            background-color: #45a049;
        }
        .error-msg {
            color: red;
            font-size: 14px;
            text-align: center;
        }
        .captcha-container {
            display: flex; /* 使用 flexbox 布局 */
            align-items: center; /* 垂直居中对齐 */
            margin: 10px 0;
        }
        .captcha-container input {
            width: 70%; /* 输入框占 70% 宽度 */
            margin-right: 10px; /* 输入框和按钮之间有 10px 的间隙 */
        }
        .captcha-container button {
            width: 25%; /* 按钮占 25% 宽度 */
            padding: 5px; /* 按钮内边距 */
            font-size: 12px; /* 按钮文字小一点 */
        }
        .captcha-image {
            border: 1px solid #ccc;
            padding: 5px;
            margin-right: 10px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>登录</h2>
    <form name="myform" id="loginForm">
        <input type="text" id="username" class="form-input" placeholder="请输入用户名" required><br>
        <input type="password" id="password" class="form-input" placeholder="请输入密码" required><br>

        <!-- 验证码输入框和验证码图片 -->
        <div class="captcha-container">
            <div class="captcha-image" id="captcha-image">1234</div> <!-- 显示验证码数字 -->
            <input type="text" id="verify" class="form-input" placeholder="请输入验证码" required><br>
            <button type="button" onclick="refreshCaptcha()">换一张</button>
        </div>

        <button type="submit" class="login-btn">登录</button>
    </form>
    <div id="error-message" class="error-msg"></div>
</div>

<script>
    // 生成随机验证码
    function generateCaptcha() {
        var captcha = '';
        for (var i = 0; i < 4; i++) {
            captcha += Math.floor(Math.random() * 10);  // 生成 0-9 的随机数字
        }
        return captcha;
    }

    // 刷新验证码
    function refreshCaptcha() {
        var captchaImage = document.getElementById("captcha-image");
        var newCaptcha = generateCaptcha();  // 生成新的验证码
        captchaImage.textContent = newCaptcha;  // 显示新的验证码
    }

    // 初始化验证码
    window.onload = function() {
        refreshCaptcha();  // 页面加载时生成验证码
    };

    // 验证表单输入
    document.getElementById('loginForm').addEventListener('submit', function(event) {
        event.preventDefault();  // 防止表单提交

        var username = document.getElementById('username').value;
        var password = document.getElementById('password').value;
        var verify = document.getElementById('verify').value;
        var errorMessage = document.getElementById('error-message');
        var captchaImage = document.getElementById('captcha-image').textContent;  // 获取当前验证码

        if (username === "" || password === "") {
            errorMessage.textContent = "用户名和密码不能为空！";
        } else if (verify !== captchaImage) {
            errorMessage.textContent = "验证码错误！";
        } else {
            window.location.href = "demoServlet?username="+username+"&password="+password;
            // var url="demoServlet?username="+username+"&password="+password;
            // document.myform.action=encodeURI(url);
            // document.myform.submit();
        }
    });
</script>

</body>
</html>


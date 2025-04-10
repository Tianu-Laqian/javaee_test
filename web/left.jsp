<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        /* 页面基本设置 */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #2c2f36; /* 深色背景 */
            color: #e0e0e0; /* 浅色字体 */
        }

        h1 {
            text-align: center;
            color: #4CAF50;
        }

        /* 设置ul的样式 */
        ul {
            margin: 30px auto;
            padding: 0;
            max-width: 600px;
            list-style-type: none;
        }

        /* 设置ul中的li样式 */
        ul li {
            background-color: #3e434a; /* 偏深色 */
            color: #e0e0e0; /* 浅色字体 */
            padding: 12px;
            margin: 10px 0;
            border-radius: 8px;
            text-align: center;
            font-size: 18px;
            transition: background-color 0.3s ease;
            box-shadow: 0 4px 8px rgba(17, 18, 18, 0.2); /* 更强的阴影效果 */
        }

        /* 设置链接样式 */
        ul li a {
            color: #e0e0e0;
            text-decoration: none;
            font-weight: bold;
            display: block;
        }

        /* 鼠标悬停时改变背景色 */
        ul li:hover {
            background-color: #4a4f56;
        }

    </style>
</head>
<body>

<ul>
    <li><a href="m01user/UserMain.jsp" target="main">用户管理</a></li>
    <li><a href="m02customer/CustomerMain.jsp" target="main">客户信息管理</a></li>
    <li><a href="m03contactperson/ContactPersonMain.jsp" target="main">客户联系人管理</a></li>
    <li><a href="m04contactrecord/ContactRecordMain.jsp" target="main">客户联系记录管理</a></li>
</ul>

</body>
</html>

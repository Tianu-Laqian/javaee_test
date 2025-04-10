<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/17
  Time: 下午1:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String contactContent = request.getParameter("contactContent");
%>
<html>
<head>
    <title>Contact Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 24px;
            color: #333;
            text-align: center;
        }
        .content {
            font-size: 16px;
            line-height: 1.6;
            color: #555;
            white-space: pre-wrap; /* 保持换行格式 */
            word-wrap: break-word; /* 自动换行 */
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .back-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>联系内容</h1>
    <div class="content">
        <%= contactContent != null ? contactContent : "No contact content available." %>
    </div>
    <div class="button-container">
        <button class="back-button" onclick="window.history.back();">返回</button>
    </div>
</div>
</body>
</html>

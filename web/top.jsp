<%@ page import="com.dao.UserDao" %>
<%@ page import="com.dao.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>欢迎页面</title>
    <style>
        /* 设置页面背景和字体 */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #2c2f36; /* 深色背景 */
            color: #e0e0e0; /* 浅色字体 */
        }

        /* 首部容器 */
        .header {
            display: flex;
            justify-content: space-between; /* 空间分配 */
            align-items: center; /* 垂直居中 */
            padding: 20px 40px;
            background-color: #1f2328; /* 深色背景 */
        }
        a {
            color: #9ba4e1;
            font-size: 17px;
            text-decoration: none;
            font-weight: bold;
            display: block;
        }
        a:hover {
            background-color: #4a4f56;
        }

        /* 学校Logo样式 */
        .logo {
            width: 30%; /* logo宽度 */
            height: auto;
        }

        /* 用户名和欢迎信息样式 */
        .user-info {
            font-size: 20px;
            color: #f5f5f5; /* 浅灰色文字 */
            font-weight: normal;
            display: flex;
            align-items: center;
        }

        .username {
            color: #90caf9; /* 柔和的蓝色 */
            font-weight: bold;
            margin-left: 10px;
        }

        /* 响应式设计：小屏幕时调整文字和Logo大小 */
        @media (max-width: 600px) {
            .logo {
                width: 40%; /* 小屏幕时logo更大 */
            }

            .user-info {
                font-size: 16px;
            }

            .username {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <!-- 学校Logo -->
    <img src="3.png" class="logo" alt="学校Logo">

    <div class="user-info">
        <%
            String uname = (String) session.getAttribute("auname");
            UserDao dao = new UserDao();
            List<User> people=dao.selectDataFromDB(uname,null);
            String rolename = people.get(0).getRoleName();
            if (uname != null) {
                out.println("<div>欢迎来到客户管理信息系统</div>");
                out.println("<div class=\"username\">" + uname + "</div>");
                out.println("<div class=\"rolename\">【" + rolename + "】</div>");
                out.println("<a href=\"login.jsp\" target=_top>&nbsp&nbsp&nbsp<退出>&nbsp&nbsp</a>");
            } else {
                out.println("<div>用户异常</div>");
            }
        %>
    </div>
</div>

</body>
</html>

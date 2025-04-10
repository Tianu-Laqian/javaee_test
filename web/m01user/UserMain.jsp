<%@ page import="java.util.Objects" %>
<%@ page import="com.dao.UserDao" %>
<%@ page import="com.dao.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2024/12/2
  Time: 上午10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html lang="zh-CN">
<head>
    <title>用户管理</title>
    <style>
        /* 设置页面背景和字体 */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5; /* 淡灰色背景 */
            color: #333;
        }

        /* 头部样式 */
        .header {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between; /* 左右分布 */
            align-items: center;
            margin-bottom: 20px;
        }

        /* 查询框样式 */
        .search-container {
            display: flex;
            justify-content: space-between;
            width: 80%;
            align-items: center;
        }

        .search-container input[type="text"] {
            width: 200px;
            padding: 5px;
            margin-right: 10px;
            border: 1px solid #999797;
            border-radius: 4px;
        }

        .search-container input[type="button"] {
            padding: 8px 15px;
            background-color: #49ad58;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .search-container input[type="button"]:hover {
            background-color: #70b675;
        }

        /* iframe容器样式 */
        iframe {
            width: 100%; /* 适应页面高度 */
            border: none;
        }

    </style>
    <script type="text/javascript">
        function selectData(){
            var uname = document.myform.uname.value;
            var realName = document.myform.realName.value;
            document.getElementById("myiframe").src = "UserList.jsp?uname=" + uname + "&realName=" + realName;
        }

        function addData(){
            var uname = document.myform.uname.value;
            var realName = document.myform.realName.value;
            document.myform.action = "UserAdd.jsp?uname=" + uname + "&realName=" + realName;
            document.myform.submit();
        }
    </script>
</head>
<body>
<form name="myform" action="" method="post">
    <!-- 头部：查询框和按钮 -->
    <div class="header">
        <div class="search-container">
            <div>
                <label>用户名：</label>
                <input name="uname" type="text">
            </div>
            <div>
                <label>真实姓名：</label>
                <input name="realName" type="text">
            </div>
            <div>
                <input type="button" value="查询" onclick="selectData()">
                <%
                    String auname = (String) session.getAttribute("auname");
                    UserDao dao2 = new UserDao();
                    List<User> people=dao2.selectDataFromDB(auname,null);
                    String role = people.get(0).getRoleID();
                    if ((Objects.equals(role, "1") || Objects.equals(role, "2"))){
                        response.getWriter().write("<script>alert('权限不足，无法访问用户管理页面，请联系超级管理员！');window.location.href='../center.jsp';</script>");
                    }
                    if (Objects.equals(role, "4")) {
                %>
                <input type="button" value="添加" onclick="addData()">
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <!-- 显示数据的iframe -->
    <iframe id="myiframe" src="" frameborder="0" height="80%" scrolling="auto"></iframe>
</form>
</body>
</html>

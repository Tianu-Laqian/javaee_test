<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2024/11/20
  Time: 上午10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="javax.swing.*" %>
<%
    String uname = (String) session.getAttribute("auname");
    if (uname == null || uname.isEmpty()) {
        response.sendRedirect("login.jsp"); // 重定向到登录页面
        return; // 确保后续代码不执行
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页</title>
    <script>
        function setHeight(){
            var allheight=document.documentElement.clientHeight;
            document.getElementById("myiframe").height=allheight-135;
        }
        function setHeight2(){
            var allheight=document.documentElement.clientHeight;
            document.getElementById("myiframe2").height=allheight-135;
        }
    </script>
</head>
<body>
<table width="100%" border="0">
    <tr height="100">
        <td colspan="3" style="background: #aabbaa">
            <iframe width="100%" height="100" src="top.jsp" style="border: none"></iframe>
        </td>
    </tr>
    <tr>
        <td width="200" style="background: beige">
            <iframe id="myiframe" width="200" src="left.jsp" style="border: none" onload="setHeight()"></iframe>
        </td>
        <td width="3" style="background: #aabbaa"></td>
        <td valign="top">
            <iframe id="myiframe2" name="main" width="100%" src="center.jsp" style="border: none" onload="setHeight2()"></iframe>
        </td>
    </tr>

</table>
</body>
</html>

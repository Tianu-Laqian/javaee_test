<%@ page import="com.dao.ContactPersonDao" %>
<%@ page import="com.dao.ContactPerson" %><%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/17
  Time: 上午8:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String vcustomerName = request.getParameter("vcustomerName");
    String vcustomerId = request.getParameter("vcustomerId");
    String customerName = request.getParameter("customerName");
    String CurrentPage = request.getParameter("CurrentPage");
%>
<html>
<head>
    <style>
        input[type="button"] {
            padding: 8px 15px;
            background-color: #49ad58;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        input[type="button"]:hover {
            background-color: #70b675;
        }
    </style>
    <title>Title</title>
    <script>
        function goback() {
            var CurrentPage = document.myform.CurrentPage.value;
            var vcustomerId = document.myform.vcustomerId.value;
            var vcustomerName = document.myform.vcustomerName.value;
            document.myform.action = "CustomerList.jsp?CurrentPage=" + CurrentPage + "&customerId="+vcustomerId+"&customerName="+vcustomerName;
            document.myform.submit();
        }
    </script>
</head>
<body>
<form name="myform" action="" method="post">
    <input name="vcustomerId" type="hidden" value="<%= vcustomerId %>">
    <input name="vcustomerName" type="hidden" value="<%= vcustomerName %>">
    <input name="CurrentPage" type="hidden" value="<%= CurrentPage %>">
    <input name="customerName" type="hidden" value="<%= customerName %>">
    <iframe id="myiframe" src="../m03contactperson/ContactPersonList.jsp?customerName=<%=customerName%>" frameborder="0" height="90%" width="100%" scrolling="auto"></iframe>
    <br>
    <div style="display: flex; justify-content: center; align-items: center;">
        <input type="button" value="返回客户信息管理" onclick="goback()">
    </div>
</form>

</body>
</html>

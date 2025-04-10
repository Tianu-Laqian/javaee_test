<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/17
  Time: 下午3:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String vcustomerName = request.getParameter("vcustomerName");
    String vname = request.getParameter("vname");
    String name = request.getParameter("name");
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
            var vname = document.myform.vname.value;
            var vcustomerName = document.myform.vcustomerName.value;
            document.myform.action = "ContactPersonList.jsp?CurrentPage=" + CurrentPage + "&name="+vname+"&customerName="+vcustomerName;
            document.myform.submit();
        }
    </script>
</head>
<body>
<form name="myform" action="" method="post">
    <input name="vname" type="hidden" value="<%= vname %>">
    <input name="vcustomerName" type="hidden" value="<%= vcustomerName %>">
    <input name="CurrentPage" type="hidden" value="<%= CurrentPage %>">
    <input name="name" type="hidden" value="<%= name %>">
    <iframe id="myiframe" src="../m04contactrecord/ContactRecordList.jsp?contactPersonName=<%=name%>" frameborder="0" height="90%" width="100%" scrolling="auto"></iframe>
    <br>
    <div style="display: flex; justify-content: center; align-items: center;">
        <input type="button" value="返回客户联系人管理" onclick="goback()">
    </div>
</form>

</body>
</html>

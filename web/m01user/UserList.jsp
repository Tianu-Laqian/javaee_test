<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2024/12/2
  Time: 上午10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="com.dao.User" %>
<%@ page import="com.dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%
    String uname = request.getParameter("uname");
    String realName = request.getParameter("realName");
    if(uname==null || uname.equalsIgnoreCase("null"))   uname="";
    if(realName==null || realName.equalsIgnoreCase("null"))   realName="";
    UserDao dao = new UserDao();
    List<User> myList = dao.selectDataFromDB(uname, realName); // 泛型指定为 User
    int recordCount = myList.size();
    int pageCount = (recordCount + 9) / 10; // 计算总页数

    // 获取当前页
    String currentPageStr = request.getParameter("CurrentPage");
    int currentPage = 1;
    if (currentPageStr != null && !currentPageStr.isEmpty()) {
        currentPage = Integer.parseInt(currentPageStr);
    }

    // 进行边界检查
    if (currentPage < 1) currentPage = 1;
    if (currentPage > pageCount) currentPage = pageCount;

    // 计算当前页显示的记录
    int beginRecord = (currentPage - 1) * 10;
    int endRecord = Math.min(beginRecord + 9, recordCount - 1);
%>

<html>
<head>
    <title>Title</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 2px 3px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #6ca871;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        a {
            color: #469949;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function firstPage() {
            document.myform.CurrentPage.value = 1;
            document.myform.submit();
        }
        function prePage() {
            var page = parseInt(document.myform.CurrentPage.value);
            if (page > 1) {
                document.myform.CurrentPage.value = page - 1;
                document.myform.submit();
            }
        }
        function nextPage() {
            var page = parseInt(document.myform.CurrentPage.value);
            if (page < document.myform.PageCount.value) {
                document.myform.CurrentPage.value = page + 1;
                document.myform.submit();
            }
        }
        function lastPage() {
            document.myform.CurrentPage.value = document.myform.PageCount.value;
            document.myform.submit();
        }
        function deleteData(aname){
            if(confirm("确定要删除吗？")){
                var CurrentPage=document.myform.CurrentPage.value;
                var url="../UserAddServlet?aname="+aname+"&flag=dele"+"&CurrentPage="+CurrentPage;
                document.myform.action=encodeURI(url);
                document.myform.submit();
            }else{
                alert("放弃!");
            }
        }
        function updateData(aname){
            var CurrentPage=document.myform.CurrentPage.value;
            var uname=document.myform.uname.value;
            var realName=document.myform.realName.value;
            var url="UserUpdate.jsp?aname="+aname+"&CurrentPage="+CurrentPage+"&vuanme="+uname+"&vrealName="+realName;
            document.myform.action=encodeURI(url);
            document.myform.submit();
        }
    </script>
</head>
<body>
<form action="UserList.jsp" name="myform" method="post">
    <input name="uname" type="hidden" value="<%=uname%>">
    <input name="realName" type="hidden" value="<%=realName%>">
    <input name="CurrentPage" type="hidden" value="<%=currentPage%>">
    <input name="PageCount" type="hidden" value="<%=pageCount%>">
    <input name="BeginRecord" type="hidden" value="<%=beginRecord%>">
    <input name="EndRecord" type="hidden" value="<%=endRecord%>">
</form>

<table>
    <thead>
    <tr>
        <th>序号</th>
        <th>用户名</th>
        <th>角色</th>
        <th>姓名</th>
        <th>是否有效</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (int i = beginRecord; i <= endRecord; i++) {
            if (myList == null || i >= myList.size() || i < 0) break;
            User obj = myList.get(i);
    %>
    <tr>
        <td><%= (i + 1) %></td>
        <td><%= obj.getAname() %></td>
        <td><%= obj.getRoleName() %></td>
        <td><%= obj.getRealname() %></td>
        <td><%= obj.getAvalid() %></td>


        <td>
            <%
                String auname = (String) session.getAttribute("auname");
                UserDao dao2 = new UserDao();
                List<User> people=dao2.selectDataFromDB(auname,null);
                String role = people.get(0).getRoleID();
                if ((Objects.equals(role, "1") || Objects.equals(role, "2"))){
                    response.getWriter().write("<script>alert('权限不足，无法访问用户管理页面，请联系超级管理员！');;window.location.href='../center.jsp';</script>");
                }
                if (Objects.equals(role, "4")) {
            %>
            <a href="#" onclick="deleteData('<%= obj.getAname() %>')">删除</a> |
            <a href="#" onclick="updateData('<%= obj.getAname() %>')">修改</a>
            <%
                }
            %>
        </td>
    </tr>
    <% } %>

    <tr>
        <td colspan="6">
            <table width="100%">
                <tr>
                    <td align="left"><div align="left"><span>&nbsp;&nbsp;&nbsp;&nbsp;共有<strong><%= recordCount %></strong>条记录，当前第<strong><%= currentPage %></strong>页，共<strong><%=pageCount%></strong>页</span></div></td>
                    <td align="right">
                        <span onclick="lastPage()" style="cursor: pointer; float: right">&nbsp;&nbsp;&nbsp;尾页</span>
                        <span onclick="nextPage()" style="cursor: pointer; float: right">&nbsp;&nbsp;&nbsp;下一页</span>
                        <span onclick="prePage()" style="cursor: pointer; float: right">&nbsp;&nbsp;&nbsp;上一页</span>
                        <span onclick="firstPage()" style="cursor: pointer; float: right">&nbsp;&nbsp;&nbsp;首页</span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </tbody>
</table>
</body>
</html>


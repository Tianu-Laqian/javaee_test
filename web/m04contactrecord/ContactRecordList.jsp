<%@ page import="com.dao.ContactRecordDao" %>
<%@ page import="com.dao.ContactRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.dao.User" %>
<%@ page import="com.dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/9
  Time: 下午11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String contactPersonName = request.getParameter("contactPersonName");
    String contactContent = request.getParameter("contactContent");

    if (contactPersonName == null || contactPersonName.equalsIgnoreCase("null")) contactPersonName = "";
    if (contactContent == null || contactContent.equalsIgnoreCase("null")) contactContent = "";

    String auname = (String) session.getAttribute("auname");
    ContactRecordDao dao = new ContactRecordDao();
    UserDao dao2 = new UserDao();
    List<User> people=dao2.selectDataFromDB(auname,null);
    String role = people.get(0).getRoleID();
    List<ContactRecord> myList = null;
    if ((Objects.equals(role, "3") || Objects.equals(role, "4"))){
        myList = dao.selectDataFromDB(contactPersonName, contactContent, null);
    }else {
        myList = dao.selectDataFromDB(contactPersonName, contactContent, auname);
    }

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
    <title>联系记录列表</title>
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
        .contact-content {
            width: 200px; /* 设置合适的宽度 */
            white-space: nowrap; /* 防止换行 */
            overflow: hidden; /* 隐藏超出的内容 */
            text-overflow: ellipsis; /* 超出部分显示省略号 */
            display: inline-block; /* 必须设置为块级元素或行内块级元素 */
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
        function deleteData(contactRecordId) {
            if(confirm("确定要删除该联系记录吗？")) {
                var CurrentPage = document.myform.CurrentPage.value;
                var url="../ContactRecordAddServlet?recordId=" + contactRecordId + "&CurrentPage=" + CurrentPage + "&flag=dele";
                document.myform.action = encodeURI(url);
                document.myform.submit();
            } else {
                alert("放弃删除!");
            }
        }
        function updateData(contactRecordId) {
            var CurrentPage = document.myform.CurrentPage.value;
            var contactPersonName = document.myform.contactPersonName.value;
            var contactContent = document.myform.contactContent.value;
            var url="ContactRecordUpdate.jsp?contactRecordId=" + contactRecordId + "&CurrentPage=" + CurrentPage + "&vcontactPersonName=" + contactPersonName + "&vcontactContent=" + contactContent;
            document.myform.action = encodeURI(url);
            document.myform.submit();
        }
    </script>
</head>
<body>
<form action="ContactRecordList.jsp" name="myform" method="post">
    <input name="contactPersonName" type="hidden" value="<%=contactPersonName%>">
    <input name="contactContent" type="hidden" value="<%=contactContent%>">
    <input name="CurrentPage" type="hidden" value="<%=currentPage%>">
    <input name="PageCount" type="hidden" value="<%=pageCount%>">
    <input name="BeginRecord" type="hidden" value="<%=beginRecord%>">
    <input name="EndRecord" type="hidden" value="<%=endRecord%>">
</form>

<table>
    <thead>
    <tr>
        <th>记录ID</th>
        <th>联系人姓名</th>
        <th>创建人</th>
        <th>联系记录</th>
        <th>联系时间</th>
        <th>备注</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (int i = beginRecord; i <= endRecord; i++) {
            if (myList == null || i >= myList.size() || i < 0) break;
            ContactRecord obj = myList.get(i);
    %>
    <tr>
        <td><%= obj.getRecordId() %></td>
        <td><%= obj.getContactPersonName() %></td>
        <td><%= obj.getDepartmentContact() %></td>
        <td>
            <a href="DetailedContent.jsp?contactContent=<%= obj.getContactContent() %>">
                <span class="contact-content"><%= obj.getContactContent() %></span>
            </a>
        </td>
        <td><%= obj.getContactTime() %></td>
        <td><%= obj.getRemarks() %></td>
        <td>
            <a href="#" onclick="deleteData('<%= obj.getRecordId() %>')">删除</a> |
            <a href="#" onclick="updateData('<%= obj.getRecordId() %>')">修改</a>
        </td>
    </tr>
    <% } %>

    <tr>
        <td colspan="7">
            <table width="100%">
                <tr>
                    <td align="left">
                        <div align="left">
                            <span>&nbsp;&nbsp;&nbsp;&nbsp;共有<strong><%= recordCount %></strong>条记录，当前第<strong><%= currentPage %></strong>页，共<strong><%= pageCount %></strong>页</span>
                        </div>
                    </td>
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


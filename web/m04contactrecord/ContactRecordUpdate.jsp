<%@ page import="com.dao.ContactPerson" %>
<%@ page import="com.dao.ContactPersonDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.ContactRecordDao" %>
<%@ page import="com.dao.ContactRecord" %><%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/9
  Time: 下午11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String auname = (String) session.getAttribute("auname");
    ContactPersonDao conpdao = new ContactPersonDao();
    List<ContactPerson> myList = conpdao.selectDataFromDB(null, null);
    String contactRecordId = request.getParameter("contactRecordId");
    System.out.println(contactRecordId);
    ContactRecordDao dao = new ContactRecordDao();
    ContactRecord contactRecord = dao.selectContactRecordById(Integer.parseInt(contactRecordId));
    String vcontactPersonName = request.getParameter("vcontactPersonName");
    String vcontactContent = request.getParameter("vcontactContent");
    String CurrentPage = request.getParameter("CurrentPage");
%>
<html>
<head>
    <title>添加联系记录</title>
    <style>
        /* 全局样式 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
        }

        /* 表单容器 */
        form {
            width: 60%;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 字体和标题样式 */
        fieldset {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }

        legend {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        /* 输入框和选择框样式 */
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        input[type="text"]:focus, select:focus {
            border-color: #66afe9;
            outline: none;
        }

        /* 表格布局 */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        td {
            padding: 10px;
        }

        /* 必填标记 */
        span {
            color: red;
        }

        /* 按钮样式 */
        input[type="button"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            margin: 10px 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        input[type="button"]:hover {
            background-color: #45a049;
        }

        /* 按钮取消样式 */
        input[type="button"]:nth-child(2) {
            background-color: #f44336;
        }

        input[type="button"]:nth-child(2):hover {
            background-color: #e53935;
        }

    </style>
    <script>
        // 保存联系记录
        function saveData() {
            var contactPersonId = document.myform.contactPersonId.value;
            if (contactPersonId == "") {
                alert("联系人姓名不能为空！");
                document.myform.contactPersonId.focus();
                return false;
            }

            var contactContent = document.myform.contactContent.value;
            if (contactContent == "") {
                alert("联系内容不能为空！");
                document.myform.contactContent.focus();
                return false;
            }

            var remarks = document.myform.remarks.value;
            var contactRecordId = document.myform.contactRecordId.value;

            var url = "../ContactRecordAddServlet?contactPersonId=" + contactPersonId +
                "&departmentContact=" + "<%= auname %>" +
                "&contactContent=" + contactContent +
                "&remarks=" + remarks +
                "&recordId=" + contactRecordId +
                "&CurrentPage=" + document.myform.CurrentPage.value +
                "&flag=update";
            document.myform.action = encodeURI(url);
            document.myform.submit();
        }

        // 返回操作
        function goback() {
            var CurrentPage = document.myform.CurrentPage.value;
            var vcontactPersonName = document.myform.vcontactPersonName.value;
            var vcontactContent = document.myform.vcontactContent.value;
            document.myform.action = "ContactRecordList.jsp?CurrentPage=" + CurrentPage + "&contactPersonName=" + vcontactPersonName + "&contactContent=" + vcontactContent;
            document.myform.submit();
        }
    </script>
</head>
<body>
<form name="myform" action="" method="post">
    <!-- 隐藏字段：创建人 -->
    <input name="vcontactPersonName" type="hidden" value="<%= vcontactPersonName %>">
    <input name="vcontactContent" type="hidden" value="<%= vcontactContent %>">
    <input name="contactRecordId" type="hidden" value="<%= contactRecordId %>">
    <input name="CurrentPage" type="hidden" value="<%= CurrentPage %>">

    <fieldset>
        <legend>联系记录信息</legend>
        <table width="100%">
            <tr>
                <td width="20%" align="center">联系人姓名<span style="color: red;">*</span></td>
                <td width="30%">
                    <select name="contactPersonId" style="width: 100%">
                        <option value="<%= contactRecord.getContactPersonId() %>" selected><%= contactRecord.getContactPersonName() %></option>
                        <% for (int i = 0; i < myList.size(); i++) {
                            ContactPerson obj = myList.get(i);
                        %>
                        <option value="<%= obj.getContactId() %>"><%= obj.getName() %></option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="20%" align="center">联系内容<span style="color: red;">*</span></td>
                <td width="30%"><textarea name="contactContent" rows="4" placeholder="请输入联系内容" style="width: 100%"><%= contactRecord.getContactContent() %></textarea></td>
            </tr>
            <tr>
                <td width="20%" align="center">备注</td>
                <td width="30%"><input type="text" name="remarks" value="<%= contactRecord.getRemarks() %>" style="width: 100%" placeholder="选填"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="button" value="保存" onclick="saveData()">
                    <input type="button" value="返回" onclick="goback()">
                </td>
            </tr>
        </table>
    </fieldset>
</form>
</body>
</html>


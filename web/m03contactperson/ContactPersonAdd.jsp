<%@ page import="com.dao.CustomerDao" %>
<%@ page import="com.dao.Customer" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/9
  Time: 下午8:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String auname = (String) session.getAttribute("auname");
    CustomerDao cusdao = new CustomerDao();
    List<Customer> myList = cusdao.selectDataFromDB(null,null);
%>
<html>
<head>
    <title>添加联系人</title>
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
        // 保存联系人信息
        function saveData() {
            var customerId = document.myform.customerId.value;
            if (customerId == "") {
                alert("联系人所属客户名称不能为空！");
                document.myform.customerId.focus();
                return false;
            }

            var name = document.myform.name.value;
            if (name == "") {
                alert("联系人姓名不能为空！");
                document.myform.name.focus();
                return false;
            }

            var gender = document.myform.gender.value;
            if (gender == "") {
                alert("性别不能为空！");
                document.myform.gender.focus();
                return false;
            }

            var department = document.myform.department.value;
            if (department == "") {
                alert("部门不能为空！");
                document.myform.department.focus();
                return false;
            }

            var contactInfo = document.myform.contactInfo.value;
            if (contactInfo == "") {
                alert("联系方式不能为空！");
                document.myform.contactInfo.focus();
                return false;
            }

            var remarks = document.myform.remarks.value;

            var url = "../ContactPersonAddServlet?customerId=" + customerId +
                "&name=" + name +
                "&gender=" + gender +
                "&department=" + department +
                "&contactInfo=" + contactInfo +
                "&remarks=" + remarks +
                "&auname=" + "<%= auname %>" + "&flag=insert";
            document.myform.action = encodeURI(url);
            document.myform.submit();
        }

        // 返回操作
        function goback() {
            document.myform.action = "ContactPersonMain.jsp";
            document.myform.submit();
        }
    </script>
</head>
<body>
<form name="myform" action="" method="post">
    <!-- 隐藏字段：创建人 -->
    <input name="auname" type="hidden" value="<%= auname %>">

    <fieldset>
        <legend>联系人信息</legend>
        <table width="100%">
            <tr>
                <td width="20%" align="center">联系人姓名<span style="color: red;">*</span></td>
                <td width="30%"><input type="text" name="name" value="" style="width: 100%" placeholder="请输入联系人姓名"></td>
                <td width="20%" align="center">性别<span style="color: red;">*</span></td>
                <td width="30%">
                    <select name="gender" style="width: 100%">
                        <option value="">请选择性别</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="20%" align="center">联系人所属<br>客户名称<span style="color: red;">*</span></td>
                <td colspan="3" width="30%">
                    <select name="customerId" style="width: 100%">
                        <%for (int i=0;i<myList.size();i++){
                            Customer obj= myList.get(i);
                        %>
                        <option value="<%=obj.getCustomerId()%>"><%=obj.getCustomerName()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="20%" align="center">部门<span style="color: red;">*</span></td>
                <td colspan="3" width="30%"><input type="text" name="department" value="" style="width: 100%" placeholder="请输入部门"></td>
            </tr>
            <tr>
                <td width="20%" align="center">联系方式<br>(电话或邮箱)<span style="color: red;">*</span></td>
                <td width="30%"><input type="text" name="contactInfo" value="" style="width: 100%" placeholder="请输入联系方式"></td>
                <td width="20%" align="center">备注</td>
                <td width="30%"><input type="text" name="remarks" value="" style="width: 100%" placeholder="选填"></td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <input type="button" value="保存" onclick="saveData()">
                    <input type="button" value="返回" onclick="goback()">
                </td>
            </tr>
        </table>
    </fieldset>
</form>
</body>
</html>

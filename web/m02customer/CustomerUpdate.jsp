<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/6
  Time: 下午4:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.CustomerDao" %>
<%@ page import="com.dao.Customer" %>
<%
    String customerId = request.getParameter("customerId");
    String vcustomerName = request.getParameter("vcustomerName");
    String vcustomerId = request.getParameter("vcustomerId");
    String CurrentPage = request.getParameter("CurrentPage");
    CustomerDao dao = new CustomerDao();
    Customer obj = dao.selectCustomerById(Integer.parseInt(customerId));
    String auname = (String) session.getAttribute("auname");
%>
<html>
<head>
    <meta charset="utf-8">
    <title>修改客户信息</title>
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
    <script language="JavaScript">
        function saveData() {
            var customerName = document.myform.customerName.value;
            if (customerName == "") {
                alert("客户名称不能为空！");
                document.myform.customerName.focus();
                return false;
            }

            var customerType = document.myform.customerType.value;
            if (customerType == "") {
                alert("客户类型不能为空！");
                document.myform.customerType.focus();
                return false;
            }

            var address = document.myform.address.value;
            if (address == "") {
                alert("地址不能为空！");
                document.myform.address.focus();
                return false;
            }

            var city = document.myform.city.value;
            if (city == "") {
                alert("城市不能为空！");
                document.myform.city.focus();
                return false;
            }

            var remarks = document.myform.remarks.value;
            var customerId = document.myform.customerId.value;
            var url = "../CustomerAddServlet?customerId=" + customerId +
                "&customerName=" + customerName +
                "&customerType=" + customerType +
                "&address=" + address +
                "&city=" + city +
                "&remarks=" + remarks +
                "&createdBy=" + "<%= auname %>" + "&flag=update" +
                "&CurrentPage=" + document.myform.CurrentPage.value;
            document.myform.action = encodeURI(url);
            document.myform.submit();
        }

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
    <!-- 隐藏字段：客户ID和当前页 -->
    <input name="vcustomerId" type="hidden" value="<%= vcustomerId %>">
    <input name="vcustomerName" type="hidden" value="<%= vcustomerName %>">
    <input name="CurrentPage" type="hidden" value="<%= CurrentPage %>">
    <input name="customerId" type="hidden" value="<%= customerId %>">

    <fieldset>
        <legend>客户信息</legend>
        <table width="100%">
            <tr>
                <td width="20%" align="center">客户名称<span style="color: red;">*</span></td>
                <td colspan="3" width="30%"><input type="text" name="customerName" value="<%= obj.getCustomerName() %>" style="width: 100%" placeholder="请输入客户名称"></td>
            </tr>
            <tr>
                <td width="20%" align="center">客户类型<span style="color: red;">*</span></td>
                <td colspan="3" width="30%">
                    <select name="customerType" style="width: 100%">
                        <option value="<%= obj.getCustomerType() %>" selected><%= obj.getCustomerType() %></option>
                        <option value="国有企业">国有企业</option>
                        <option value="民营企业">民营企业</option>
                        <option value="外资企业">外资企业</option>
                        <option value="公益事业">公益事业</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="20%" align="center">地址<span style="color: red;">*</span></td>
                <td colspan="3" width="30%"><input type="text" name="address" value="<%= obj.getCustomerAddress() %>" style="width: 100%" placeholder="请输入地址"></td>
            </tr>
            <tr>
                <td width="20%" align="center">城市<span style="color: red;">*</span></td>
                <td width="30%"><input type="text" name="city" value="<%= obj.getCity() %>" style="width: 100%" placeholder="请输入城市"></td>
                <td width="20%" align="center">备注</td>
                <td width="30%"><input type="text" name="remarks" value="<%= obj.getRemarks() %>" style="width: 100%" placeholder="选填"></td>
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


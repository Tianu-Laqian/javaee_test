<%@ page import="com.dao.CustomerDao" %>
<%@ page import="com.dao.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.dao.UserDao" %>
<%@ page import="com.dao.User" %>
<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2025/1/6
  Time: 下午3:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String customerName = request.getParameter("customerName");
    String customerId = request.getParameter("customerId");
    System.out.println(customerName);
    System.out.println(customerId);
    if(customerName==null || customerName.equalsIgnoreCase("null"))   customerName="";
    if(customerId != null && (customerId.equalsIgnoreCase("") || customerId.equalsIgnoreCase("null")))   customerId=null;
    CustomerDao dao = new CustomerDao();
    List<Customer> myList = null; // 泛型指定为 Customer
    if (customerId != null) {
        myList = dao.selectDataFromDB(customerName, Integer.valueOf(customerId));
    }else {
        myList = dao.selectDataFromDB(customerName, null);
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
    <title>客户列表</title>
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
        function deleteData(customerId) {
            if(confirm("确定要删除吗？")) {
                var CurrentPage = document.myform.CurrentPage.value;
                var url="../CustomerAddServlet?customerId=" + customerId + "&CurrentPage=" + CurrentPage + "&flag=dele";
                document.myform.action = encodeURI(url);
                document.myform.submit();
            } else {
                alert("放弃!");
            }
        }
        function updateData(customerId) {
            var CurrentPage = document.myform.CurrentPage.value;
            var customerName = document.myform.customerName.value;
            var customerIdParam = document.myform.customerId.value;
            var url="CustomerUpdate.jsp?customerId=" + customerId + "&CurrentPage=" + CurrentPage + "&vcustomerName=" + customerName + "&vcustomerId=" + customerIdParam;
            document.myform.action = encodeURI(url);
            document.myform.submit();
        }
    </script>
</head>
<body>
<form action="CustomerList.jsp" name="myform" method="post">
    <input name="customerName" type="hidden" value="<%=customerName%>">
    <input name="customerId" type="hidden" value="<%=customerId%>">
    <input name="CurrentPage" type="hidden" value="<%=currentPage%>">
    <input name="PageCount" type="hidden" value="<%=pageCount%>">
    <input name="BeginRecord" type="hidden" value="<%=beginRecord%>">
    <input name="EndRecord" type="hidden" value="<%=endRecord%>">
</form>

<table>
    <thead>
    <tr>
        <th>客户ID</th>
        <th>客户名称</th>
        <th>客户类型</th>
        <th>联系人数量</th>
<%--        <th>记录数量</th>--%>
        <th>地址</th>
        <th>城市</th>
        <th>备注</th>
        <th>创建人</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (int i = beginRecord; i <= endRecord; i++) {
            if (myList == null || i >= myList.size() || i < 0) break;
            Customer obj = myList.get(i);
    %>
    <tr>
        <td><%= obj.getCustomerId() %></td>
        <td><%= obj.getCustomerName() %></td>
        <td><%= obj.getCustomerType() %></td>
        <td>
            <a href="ContactPersonCountList.jsp?customerName=<%= obj.getCustomerName() %>&CurrentPage=<%=currentPage%>&vcustomerName=<%=customerName%>&vcustomerId=<%=customerId%>">
            <%= obj.getContactCount() %>
            </a>
        </td>
<%--        <td><%= obj.getRecordCount() %></td>--%>
        <td><%= obj.getCustomerAddress() %></td>
        <td><%= obj.getCity() %></td>
        <td><%= obj.getRemarks() %></td>
        <td><%= obj.getCreatedBy() %></td>

        <td>
            <%
                String auname = (String) session.getAttribute("auname");
                UserDao dao2 = new UserDao();
                List<User> people=dao2.selectDataFromDB(auname,null);
                String role = people.get(0).getRoleID();
                if ((Objects.equals(role, "3") || Objects.equals(role, "4") || Objects.equals(obj.getCreatedBy(),auname))){
            %>
            <a href="#" onclick="deleteData('<%= obj.getCustomerId() %>')">删除</a> |
            <a href="#" onclick="updateData('<%= obj.getCustomerId() %>')">修改</a>
            <%
                }
            %>
        </td>
    </tr>
    <% } %>

    <tr>
        <td colspan="10">
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

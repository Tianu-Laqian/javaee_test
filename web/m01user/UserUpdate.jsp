<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2024/12/17
  Time: 下午4:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="com.dao.UserDao" %>
<%@ page import="com.dao.User" %>
<%@ page import="com.dao.TRoleDao" %>
<%@ page import="com.dao.TRole" %>
<%@ page import="java.util.List" %>
<%
  String aname=request.getParameter("aname");
  String CurrentPage=request.getParameter("CurrentPage");
  String vuname=request.getParameter("vuname");
  String vrealName=request.getParameter("vrealName");
  UserDao dao=new UserDao();
  User obj= dao.selectUserByName(aname);
  TRoleDao rdao = new TRoleDao();
  List myList=rdao.selectDataFromDB();
%>
<html>
<head>
  <meta charset="utf-8">
    <title>Title</title>
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
      var aname = document.myform.aname.value;
      if (aname == "") {
        alert("用户名不能为空！");
        document.myform.aname.focus();
        return false;
      }
      var aword = document.myform.aword.value;
      if (aword == "") {
        alert("密码不能为空！");
        document.myform.aword.focus();
        return false;
      }
      var realname=document.myform.realname.value;
      var avalid=document.myform.avalid.value;
      var roleid=document.myform.RoleID.value;
      var CurrentPage=document.myform.CurrentPage.value;
      var url="../UserAddServlet?aname="+aname+"&aword="+aword+"&realname="+realname+"&avalid="+avalid+"&flag=update"+"&roleid="+roleid+"&CurrentPage="+CurrentPage;
      alert(url);
      document.myform.action=encodeURI(url);
      document.myform.submit();
    }
    function goback(){
      var CurrentPage=document.myform.CurrentPage.value;
      var vrealName=document.myform.vrealName.value;
      var vuname=document.myform.vuame.value;
      document.myform.action="UserList.jsp?uname="+vuname+"&realName="+vrealName+"&CurrentPage="+CurrentPage;
      document.myform.submit();
    }


  </script>
</head>
<body>
<form name="myform" action="" method="post">
  <input name="CurrentPage" type="hidden" value="<%=CurrentPage%>">
  <input name="vuame" type="hidden" value="<%=vuname%>">
  <input name="vrealName" type="hidden" value="<%=vrealName%>">
  <fieldset>
    <legend>基本信息</legend>
    <table width="100%">
      <tr>
        <td width="20%" align="center">用户名<span style="color: red;">*</span> </td>
        <td width="30%"><input type="text" name="aname" value="<%=obj.getAname()%>" style="width: 100%"></td>
        <td width="20%" align="center">密码<span style="color: red;">*</span> </td>
        <td width="30%"><input type="text" name="aword" value="" style="width: 100%"></td>
      </tr>
      <tr>
        <td width="20%" align="center">姓名</td>
        <td width="30%"><input type="text" name="realname" value="<%=obj.getRealname()%>" style="width: 100%" placeholder="请输入真实姓名"></td>
        <td width="20%" align="center">是否有效</td>
        <td width="30%">
          <select name="avalid" style="width: 100%">
            <option value="<%=obj.getAvalid()%>" selected><%=obj.getAvalid()%></option>
            <option value="是">是</option>
            <option value="否">否</option>
          </select>
        </td>
      </tr>
      <td width="20%" align="center">角色</td>
      <td width="30%">
        <select name="RoleID" style="width: 100%">
          <%for (int i=0;i<myList.size();i++){
            TRole obj1=(TRole)myList.get(i);
          %>
          <option value="<%=obj1.getRoleID()%>"><%=obj1.getRoleName()%></option>
          <%}%>
        </select>
      </td>
      <td width="20%" align="center"></td>
      <td width="30%"></td>
      </tr>
      <tr>
        <td colspan="4" align="center">
          <input type="button" value="保存" onclick="saveData()">
          <input type="button" value="返回" onclick="goback()">
        </td>
      </tr>
      <tr>
    </table>
  </fieldset>
</form>

</body>
</html>

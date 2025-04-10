<%@ page import="com.dao.TRole" %>
<%@ page import="com.dao.TRoleDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.UserDao" %>
<%--
  Created by IntelliJ IDEA.
  User: 解奂笔
  Date: 2024/12/11
  Time: 上午10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String uname = request.getParameter("uname");
    String realName = request.getParameter("realName");
    TRoleDao dao = new TRoleDao();
    List myList=dao.selectDataFromDB();
%>
<html>
<head>
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
    <script>
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
            var url="../UserAddServlet?aname="+aname+"&aword="+aword+"&realname="+realname+"&avalid="+avalid+"&flag=insert"+"&roleid="+roleid;
            alert(url);
            document.myform.action=encodeURI(url);
            document.myform.submit();
        }
        function goback(){
            document.myform.action="UserMain.jsp";
            document.myform.submit();
        }
        function doSubmit(){
            if (window.event.keyCode==13){
                sendRequest();
            }
        }
        var XMLHttpReq;
        function createXMLHttpRequest(){
            if (window.XMLHttpRequest){
                XMLHttpReq=new XMLHttpRequest();
            }else if (window.ActiveXObject){
                try {
                    XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");
                }catch (e){
                    try {
                        XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
                    }catch (e){}
                }
            }
        }
        function processResponse(){
            if (XMLHttpReq.readyState==4){
                if (XMLHttpReq.status==200){
                    var tip=XMLHttpReq.responseText;
                    alert(tip);
                }else alert("您请求的页面有异常！");
            }
        }

        function sendRequest(){
            var aname = document.myform.aname.value;
            var url="../UserAddServlet?aname="+aname+"&flag=textajax";
            createXMLHttpRequest();
            XMLHttpReq.open("GET",url,true);
            XMLHttpReq.onreadystatechange=processResponse;
            XMLHttpReq.send(null);
        }


    </script>
</head>
<body>
<form name="myform" action="" method="post">
    <input name="abcuname" type="hidden" value="<%=uname%>">
    <input name="abcrealName" type="hidden" value="<%=realName%>">
    <fieldset>
        <legend>基本信息</legend>
        <table width="100%">
            <tr>
                <td width="20%" align="center">用户名<span style="color: red;">*</span> </td>
                <td width="30%"><input type="text" name="aname" value="<%=uname%>" style="width: 100%"></td>
                <td width="20%" align="center">密码<span style="color: red;">*</span> </td>
                <td width="30%"><input type="text" name="aword" value="" style="width: 100%"></td>
            </tr>
            <tr>
                <td width="20%" align="center">姓名</td>
                <td width="30%"><input type="text" name="realname" value="<%=realName%>" style="width: 100%" placeholder="请输入真实姓名"></td>
                <td width="20%" align="center">是否有效</td>
                <td width="30%">
                    <select name="avalid" style="width: 100%">
                        <option value="是" selected>是</option>
                        <option value="否">否</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="20%" align="center">角色</td>
                <td width="30%">
                    <select name="RoleID" style="width: 100%">
                        <%for (int i=0;i<myList.size();i++){
                            TRole obj=(TRole)myList.get(i);
                            %>
                        <option value="<%=obj.getRoleID()%>"><%=obj.getRoleName()%></option>
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
        </table>
    </fieldset>
</form>
</body>
</html>

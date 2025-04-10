package com.servlet;

import com.dao.UserDao;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UserAddServlet", value = "/UserAddServlet")
public class UserAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flag=request.getParameter("flag");
        System.out.println(flag);
        if (flag.equals("insert")) {
            String aname=request.getParameter("aname");
            String aword=request.getParameter("aword");
            String realname=request.getParameter("realname");
            String avalid=request.getParameter("avalid");
            String roleid=request.getParameter("roleid");
            String auname = request.getParameter("auname");
            System.out.println(avalid);
            response.setCharacterEncoding("GBK");
            UserDao dao=new UserDao();
            int result=dao.insertUser(aname,aword,realname,avalid,roleid);
            if(result>=1){
                response.getWriter().write("<script>alert('Add user successfully!');window.location.href='m01user/UserMain.jsp';</script>");
            }
            else{
                response.getWriter().write("<script>alert('Add user failed!');window.location.href='m01user/UserAdd.jsp';</script>");
            }
        }else if (flag.equals("dele")) {
            String aname=request.getParameter("aname");
            String CurrentPage=request.getParameter("CurrentPage");
            response.setCharacterEncoding("GBK");
            UserDao dao=new UserDao();
            int result=dao.deleteUser(aname);
            if(result>=1){
                response.getWriter().write("<script>alert('Delete user successfully!');window.location.href='m01user/UserList.jsp?CurrentPage="+CurrentPage+"';</script>");
            }else {
                response.getWriter().write("<script>alert('Delete user failed!');window.location.href='m01user/UserList.jsp?CurrentPage="+CurrentPage+"';</script>");
            }
        }else if (flag.equals("update")) {
            String aname=request.getParameter("aname");
            String aword=request.getParameter("aword");
            String realname=request.getParameter("realname");
            String avalid=request.getParameter("avalid");
            String roleid=request.getParameter("roleid");
            String CurrentPage=request.getParameter("CurrentPage");
            response.setCharacterEncoding("GBK");
            UserDao dao=new UserDao();
            int result=dao.updateUser(aname,aword,realname,avalid,roleid);
            if(result>=1){
                response.getWriter().write("<script>alert('Update user successfully!');window.location.href='m01user/UserList.jsp?CurrentPage="+CurrentPage+"';</script>");
            }else{
                response.getWriter().write("<script>alert('Update user failed!');window.location.href='m01user/UserList.jsp?CurrentPage="+CurrentPage+"';</script>");

            }
        }else if (flag.equals("textajax")){
            String aname=request.getParameter("aname");
            response.setCharacterEncoding("utf-8");
            UserDao dao=new UserDao();
            String result="";
            result=dao.checkUserByName(aname);
            response.getWriter().write(result);

        }

    }
}

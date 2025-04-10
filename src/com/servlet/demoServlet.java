package com.servlet;

import com.pub.PubDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "demoServlet", value = "/demoServlet")
public class demoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        System.out.println(username+"---"+password);
        PubDao tt=new PubDao();
        String successurl = "index.jsp";
        if (tt.checkLogin(username,password)){
            HttpSession session = request.getSession();  // 获取当前会话
            session.setAttribute("auname", username);  // 设置session属性
            response.sendRedirect(successurl);
        }
        else{
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>alert('用户名或密码错误');window.location.href='login.jsp';</script>");
        }
    }
}

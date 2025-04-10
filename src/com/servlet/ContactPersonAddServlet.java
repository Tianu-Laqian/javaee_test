package com.servlet;

import com.dao.ContactPersonDao;
import com.sun.xml.internal.ws.api.ha.StickyFeature;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ContactPersonAddServlet", value = "/ContactPersonAddServlet")
public class ContactPersonAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flag = request.getParameter("flag");
        System.out.println(flag);

        if (flag.equals("insert")) {
            // 获取联系人信息
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String department = request.getParameter("department");
            String contactInfo = request.getParameter("contactInfo");
            String remarks = request.getParameter("remarks");
            String auname = request.getParameter("auname");

            // 调用ContactPersonDao插入数据
            response.setCharacterEncoding("UTF-8");
            ContactPersonDao dao = new ContactPersonDao();
            int result = dao.insertContactPerson(customerId, name, gender, department, contactInfo, remarks, auname);

            // 根据结果反馈
            if (result >= 1) {
                response.getWriter().write("<script>alert('Add contact person successfully!');window.location.href='m03contactperson/ContactPersonMain.jsp';</script>");
            } else {
                response.getWriter().write("<script>alert('Add contact person failed!');window.location.href='m03contactperson/ContactPersonAdd.jsp';</script>");
            }
        } else if (flag.equals("dele")) {
            String contactId = request.getParameter("contactId");
            String currentPage = request.getParameter("CurrentPage");
            response.setCharacterEncoding("UTF-8");
            ContactPersonDao dao = new ContactPersonDao();
            int result = dao.deleteContactPerson(Integer.parseInt(contactId));

            if (result >= 1) {
                response.getWriter().write("<script>alert('Delete contact person successfully!');window.location.href='m03contactperson/ContactPersonList.jsp?CurrentPage=" + currentPage + "';</script>");
            } else {
                response.getWriter().write("<script>alert('Delete contact person failed!');window.location.href='m03contactperson/ContactPersonList.jsp?CurrentPage=" + currentPage + "';</script>");
            }
        } else if (flag.equals("update")) {
            String contactId = request.getParameter("contactId");
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String department = request.getParameter("department");
            String contactInfo = request.getParameter("contactInfo");
            String remarks = request.getParameter("remarks");
            String currentPage = request.getParameter("CurrentPage");
            String createdBy = request.getParameter("createdBy");

            response.setCharacterEncoding("UTF-8");
            ContactPersonDao dao = new ContactPersonDao();
            int result = dao.updateContactPerson(Integer.parseInt(contactId), customerId, name, gender, department, contactInfo, remarks, createdBy);

            if (result >= 1) {
                response.getWriter().write("<script>alert('Update contact person successfully!');window.location.href='m03contactperson/ContactPersonList.jsp?CurrentPage=" + currentPage + "';</script>");
            } else {
                response.getWriter().write("<script>alert('Update contact person failed!');window.location.href='m03contactperson/ContactPersonList.jsp?CurrentPage=" + currentPage + "';</script>");
            }
        }

    }
}

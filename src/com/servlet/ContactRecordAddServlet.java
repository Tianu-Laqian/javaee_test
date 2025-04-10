package com.servlet;

import com.dao.ContactRecordDao;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ContactRecordAddServlet", value = "/ContactRecordAddServlet")
public class ContactRecordAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flag = request.getParameter("flag");
        System.out.println(flag);

        if (flag.equals("insert")) {
            // 获取联系记录信息
            int contactPersonId = Integer.parseInt(request.getParameter("contactPersonId"));
            String departmentContact = request.getParameter("departmentContact");
            String contactContent = request.getParameter("contactContent");
            String remarks = request.getParameter("remarks");

            // 调用ContactRecordDao插入数据
            response.setCharacterEncoding("UTF-8");
            ContactRecordDao dao = new ContactRecordDao();
            int result = dao.insertContactRecord(contactPersonId, departmentContact, contactContent, remarks);

            // 根据结果反馈
            if (result >= 1) {
                response.getWriter().write("<script>alert('Add contact record successfully!');window.location.href='m04contactrecord/ContactRecordMain.jsp';</script>");
            } else {
                response.getWriter().write("<script>alert('Add contact record failed!');window.location.href='m04contactrecord/ContactRecordAdd.jsp';</script>");
            }
        } else if (flag.equals("dele")) {
            String recordId = request.getParameter("recordId");
            String currentPage = request.getParameter("CurrentPage");
            response.setCharacterEncoding("UTF-8");
            ContactRecordDao dao = new ContactRecordDao();
            int result = dao.deleteContactRecord(Integer.parseInt(recordId));

            if (result >= 1) {
                response.getWriter().write("<script>alert('Delete contact record successfully!');window.location.href='m04contactrecord/ContactRecordList.jsp?CurrentPage=" + currentPage + "';</script>");
            } else {
                response.getWriter().write("<script>alert('Delete contact record failed!');window.location.href='m04contactrecord/ContactRecordList.jsp?CurrentPage=" + currentPage + "';</script>");
            }
        } else if (flag.equals("update")) {
            String recordId = request.getParameter("recordId");
            int contactPersonId = Integer.parseInt(request.getParameter("contactPersonId"));
            String departmentContact = request.getParameter("departmentContact");
            String contactContent = request.getParameter("contactContent");
            String remarks = request.getParameter("remarks");
            String currentPage = request.getParameter("CurrentPage");

            response.setCharacterEncoding("UTF-8");
            ContactRecordDao dao = new ContactRecordDao();
            int result = dao.updateContactRecord(Integer.parseInt(recordId), contactPersonId, departmentContact, contactContent, remarks);

            if (result >= 1) {
                response.getWriter().write("<script>alert('Update contact record successfully!');window.location.href='m04contactrecord/ContactRecordList.jsp?CurrentPage=" + currentPage + "';</script>");
            } else {
                response.getWriter().write("<script>alert('Update contact record failed!');window.location.href='m04contactrecord/ContactRecordList.jsp?CurrentPage=" + currentPage + "';</script>");
            }
        }

    }
}

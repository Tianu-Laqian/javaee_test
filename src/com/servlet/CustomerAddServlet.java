package com.servlet;

import com.dao.CustomerDao;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CustomerAddServlet", value = "/CustomerAddServlet")
public class CustomerAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flag = request.getParameter("flag");
        System.out.println(flag);

        if (flag.equals("insert")) {
            // 获取客户信息
            String customerName = request.getParameter("customerName");
            String customerType = request.getParameter("customerType");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String remarks = request.getParameter("remarks");
            String auname = request.getParameter("auname"); // 获取创建人

            // 调用CustomerDao插入数据
            response.setCharacterEncoding("UTF-8");
            CustomerDao dao = new CustomerDao();
            int result = dao.insertCustomer(customerName, customerType, address, city, remarks, auname);

            // 根据结果反馈
            if (result >= 1) {
                response.getWriter().write("<script>alert('Add customer successfully!');window.location.href='m02customer/CustomerMain.jsp';</script>");
            } else {
                response.getWriter().write("<script>alert('Add customer failed!');window.location.href='m02customer/CustomerAdd.jsp';</script>");
            }
        } else if (flag.equals("dele")) {
            String customerId = request.getParameter("customerId");
            String currentPage = request.getParameter("CurrentPage");
            response.setCharacterEncoding("UTF-8");
            CustomerDao dao = new CustomerDao();
            int result = dao.deleteCustomer(Integer.parseInt(customerId));

            if (result >= 1) {
                response.getWriter().write("<script>alert('Delete customer successfully!');window.location.href='m02customer/CustomerList.jsp?CurrentPage=" + currentPage + "';</script>");
            } else {
                response.getWriter().write("<script>alert('Delete customer failed!');window.location.href='m02customer/CustomerList.jsp?CurrentPage=" + currentPage + "';</script>");
            }
        } else if (flag.equals("update")) {
            String customerId = request.getParameter("customerId");
            String customerName = request.getParameter("customerName");
            String customerType = request.getParameter("customerType");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String remarks = request.getParameter("remarks");
            String createdBy = request.getParameter("createdBy");
            String currentPage = request.getParameter("CurrentPage");

            response.setCharacterEncoding("UTF-8");
            CustomerDao dao = new CustomerDao();
            int result = dao.updateCustomer(Integer.parseInt(customerId), customerName, customerType, address, city, remarks,createdBy);

            if (result >= 1) {
                response.getWriter().write("<script>alert('Update customer successfully!');window.location.href='" +
                        "m02customer/CustomerList.jsp?CurrentPage=" + currentPage + "';</script>");
            } else {
                response.getWriter().write("<script>alert('Update customer failed!');window.location.href='m02customer/CustomerList.jsp?CurrentPage=" + currentPage + "';</script>");
            }
        }
    }
}

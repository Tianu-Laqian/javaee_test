package com.dao;

import com.pub.ConnDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDao {

    public List selectDataFromDB(String customerName, Integer customerId) {
        String ztj = "", tj = "";
        if (customerId != null) {
            tj = " customer_id = " + customerId;
            ztj = tj;
        }
        if (customerName != null && !customerName.equals("")) {
            tj = " customer_name LIKE '%" + customerName + "%'";
            if (ztj.equals("")) {
                ztj = tj;
            } else {
                ztj = ztj + " AND " + tj;
            }
        }

        ArrayList list = new ArrayList();
        try {
            Connection conn = ConnDB.getConnection();
            String strsql = "SELECT * FROM Customer";
            if (!ztj.equals("")) {
                strsql = "SELECT * FROM Customer WHERE " + ztj;
            }
            System.out.println(strsql);
            PreparedStatement pstmt = conn.prepareStatement(strsql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Customer obj = new Customer();
                obj.setCustomerId(rs.getInt("customer_id"));
                obj.setCustomerName(rs.getString("customer_name"));
                obj.setCustomerType(rs.getString("customer_type"));
                obj.setContactCount(rs.getInt("contact_count"));
                obj.setRecordCount(rs.getInt("record_count"));
                obj.setCustomerAddress(rs.getString("customer_address"));
                obj.setCity(rs.getString("city"));
                obj.setRemarks(rs.getString("remarks"));
                obj.setCreatedBy(rs.getString("created_by"));
                list.add(obj);
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 插入Customer数据
    public int insertCustomer(String customerName, String customerType,
                              String customerAddress, String city, String remarks, String createdBy) {
        String sqlstr = "INSERT INTO Customer (customer_name, customer_type, " +
                "customer_address, city, remarks, created_by) VALUES ('" + customerName + "', '" +
                customerType + "', '" + customerAddress + "', '" +
                city + "', '" + remarks + "', '" + createdBy + "')";
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 更新Customer数据
    public int updateCustomer(int customerId, String customerName, String customerType,
                              String customerAddress, String city, String remarks, String createdBy) {
        String sqlstr = "UPDATE Customer SET customer_name='" + customerName + "', customer_type='" + customerType+ "', customer_address='" +
                customerAddress + "', city='" + city + "', remarks='" + remarks + "', created_by='" + createdBy +
                "' WHERE customer_id='" + customerId + "'";
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 删除Customer数据
    public int deleteCustomer(int customerId) {
        String sqlstr = "DELETE FROM Customer WHERE customer_id='" + customerId + "'";
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }
    public Customer selectCustomerById(int customerId) {
        Customer obj = new Customer();
        try {
            Connection conn = ConnDB.getConnection();
            String sqlstr = "SELECT * FROM Customer WHERE customer_id='" + customerId + "'";
            System.out.println(sqlstr);
            PreparedStatement pstmt = conn.prepareStatement(sqlstr);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                obj.setCustomerId(rs.getInt("customer_id"));
                obj.setCustomerName(rs.getString("customer_name"));
                obj.setCustomerType(rs.getString("customer_type"));
                obj.setContactCount(rs.getInt("contact_count"));
                obj.setRecordCount(rs.getInt("record_count"));
                obj.setCustomerAddress(rs.getString("customer_address"));
                obj.setCity(rs.getString("city"));
                obj.setRemarks(rs.getString("remarks"));
                obj.setCreatedBy(rs.getString("created_by"));
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return obj;
    }
}
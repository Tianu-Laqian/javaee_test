package com.dao;

import com.pub.ConnDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactPersonDao {

    // 根据客户编号或联系人姓名查询联系人信息
    public List<ContactPerson> selectDataFromDB(String name, String customerName) {
        String ztj = "", tj = "";
        if (customerName != null && !customerName.equals("")) {
            tj = " customer_name LIKE '%" + customerName + "%'";
            ztj = tj;
        }
        if (name != null && !name.equals("")) {
            tj = " name LIKE '%" + name + "%'";
            if (ztj.equals("")) {
                ztj = tj;
            } else {
                ztj = ztj + " AND " + tj;
            }
        }

        ArrayList<ContactPerson> list = new ArrayList<>();
        try {
            Connection conn = ConnDB.getConnection();
            String strsql = "SELECT a.*,b.* FROM contactPerson a,customer b WHERE a.customer_id=b.customer_id";
            if (!ztj.equals("")) {
                strsql = "SELECT a.*,b.* FROM contactPerson a,customer b WHERE a.customer_id=b.customer_id and " + ztj;
            }
            System.out.println(strsql);
            PreparedStatement pstmt = conn.prepareStatement(strsql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ContactPerson obj = new ContactPerson();
                obj.setContactId(rs.getInt("contact_id"));
                obj.setCustomerId(rs.getInt("customer_id"));
                obj.setName(rs.getString("name"));
                obj.setGender(rs.getString("gender"));
                obj.setDepartment(rs.getString("department"));
                obj.setContactInfo(rs.getString("contact_info"));
                obj.setRemarks(rs.getString("remarks"));
                obj.setCustomerName(rs.getString("customer_name"));
                obj.setCreatedBy(rs.getString("created_by"));
                obj.setRecordCount(rs.getString("record_count"));
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

    // 插入ContactPerson数据
    public int insertContactPerson(int customerId, String name, String gender, String department,
                                   String contactInfo, String remarks, String createdBy) {
        String sqlstr = "INSERT INTO ContactPerson (customer_id, name, gender, department, contact_info, remarks, created_by) " +
                "VALUES (" + customerId + ",'" + name + "', '" + gender + "', '" + department + "', '" +
                contactInfo + "', '" + remarks + "', '" + createdBy + "')";
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 更新ContactPerson数据
    public int updateContactPerson(int contactId, int customerId, String name, String gender, String department,
                                   String contactInfo, String remarks, String createdBy) {
        String sqlstr = "UPDATE ContactPerson SET customer_id=" + customerId + ", name='" + name + "', gender='" + gender +
                "', department='" + department + "', contact_info='" + contactInfo + "', remarks='" + remarks +
                "', created_by='" + createdBy +"' WHERE contact_id=" + contactId;
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 删除ContactPerson数据
    public int deleteContactPerson(int contactId) {
        String sqlstr = "DELETE FROM ContactPerson WHERE contact_id=" + contactId;
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 根据contactId查询单个联系人信息
    public ContactPerson selectContactPersonById(int contactId) {
        ContactPerson obj = new ContactPerson();
        try {
            Connection conn = ConnDB.getConnection();
            String sqlstr = "SELECT a.*,b.* FROM contactPerson a,customer b WHERE a.customer_id=b.customer_id AND contact_id=" + contactId;
            System.out.println(sqlstr);
            PreparedStatement pstmt = conn.prepareStatement(sqlstr);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                obj.setContactId(rs.getInt("contact_id"));
                obj.setCustomerId(rs.getInt("customer_id"));
                obj.setName(rs.getString("name"));
                obj.setGender(rs.getString("gender"));
                obj.setDepartment(rs.getString("department"));
                obj.setContactInfo(rs.getString("contact_info"));
                obj.setRemarks(rs.getString("remarks"));
                obj.setCreatedBy(rs.getString("created_by"));
                obj.setCustomerName(rs.getString("customer_name"));
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

package com.dao;

import com.pub.ConnDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactRecordDao {

    // 根据联系对象姓名或部门联系人查询联系记录
    public List<ContactRecord> selectDataFromDB(String contactPersonName, String contactContent, String auname) {
        String ztj = "", tj = "";
        if (contactPersonName != null && !contactPersonName.equals("")) {
            tj = " name LIKE '%" + contactPersonName + "%'";
            ztj = tj;
        }
        if (contactContent != null && !contactContent.equals("")) {
            tj = " contact_content LIKE '%" + contactContent + "%'";
            if (ztj.equals("")) {
                ztj = tj;
            } else {
                ztj = ztj + " AND " + tj;
            }
        }
        if (auname != null && !auname.equals("")) {
            tj = " department_contact='" + auname + "'";
            if (ztj.equals("")) {
                ztj = tj;
            } else {
                ztj = ztj + " AND " + tj;
            }

        }


        ArrayList<ContactRecord> list = new ArrayList<>();
        try {
            Connection conn = ConnDB.getConnection();
            String strsql = "SELECT a.*,b.* FROM contactrecord a,contactperson b WHERE a.contact_person_id=b.contact_id";
            if (!ztj.equals("")) {
                strsql = "SELECT a.*,b.* FROM contactrecord a,contactperson b WHERE a.contact_person_id=b.contact_id AND " + ztj;
            }
            System.out.println(strsql);
            PreparedStatement pstmt = conn.prepareStatement(strsql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ContactRecord obj = new ContactRecord();
                obj.setRecordId(rs.getInt("record_id"));
                obj.setContactPersonId(rs.getInt("contact_person_id"));
                obj.setDepartmentContact(rs.getString("department_contact"));
                obj.setContactTime(rs.getTimestamp("contact_time"));
                obj.setContactContent(rs.getString("contact_content"));
                obj.setRemarks(rs.getString("remarks"));
                obj.setContactPersonName(rs.getString("name"));
                list.add(obj);
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 插入联系记录数据
    public int insertContactRecord(int contactPersonId, String departmentContact, String contactContent, String remarks) {
        String sqlstr = "INSERT INTO contactRecord (contact_person_id, department_contact, contact_content, remarks) " +
                "VALUES (" + contactPersonId + ", '" + departmentContact + "', '" + contactContent + "', '" + remarks + "')";
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 更新联系记录数据
    public int updateContactRecord(int recordId, int contactPersonId, String departmentContact, String contactContent, String remarks) {
        String sqlstr = "UPDATE contactRecord SET contact_person_id=" + contactPersonId + ", department_contact='" + departmentContact +
                "', contact_content='" + contactContent + "', remarks='" + remarks + "' WHERE record_id=" + recordId;
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 删除联系记录数据
    public int deleteContactRecord(int recordId) {
        String sqlstr = "DELETE FROM contactRecord WHERE record_id=" + recordId;
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }

    // 根据recordId查询单个联系记录信息
    public ContactRecord selectContactRecordById(int recordId) {
        ContactRecord obj = new ContactRecord();
        try {
            Connection conn = ConnDB.getConnection();
            String sqlstr = "SELECT a.*,b.* FROM contactrecord a,contactperson b WHERE a.contact_person_id=b.contact_id AND record_id=" + recordId;
            System.out.println(sqlstr);
            PreparedStatement pstmt = conn.prepareStatement(sqlstr);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                obj.setRecordId(rs.getInt("record_id"));
                obj.setContactPersonId(rs.getInt("contact_person_id"));
                obj.setDepartmentContact(rs.getString("department_contact"));
                obj.setContactTime(rs.getTimestamp("contact_time"));
                obj.setContactContent(rs.getString("contact_content"));
                obj.setRemarks(rs.getString("remarks"));
                obj.setContactPersonName(rs.getString("name"));
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

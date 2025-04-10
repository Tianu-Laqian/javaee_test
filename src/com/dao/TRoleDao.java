package com.dao;

import com.pub.ConnDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TRoleDao {
    public ArrayList selectDataFromDB(){
        ArrayList list = new ArrayList();
        try {
            Connection conn= ConnDB.getConnection();
            String strsql="select * from TRole";
            PreparedStatement pstmt=conn.prepareStatement(strsql);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next()){
                TRole role=new TRole();
                role.setRoleID(rs.getString("RoleID"));
                role.setRoleName(rs.getString("RoleName"));
                list.add(role);
            }
            rs.close();
            pstmt.close();
            conn.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
}

package com.dao;

import com.pub.ConnDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
//    public List selectData(){
//        ArrayList list = new ArrayList();
//
//        int numRecords = 7;
//        for (int i = 0; i < numRecords; i++) {
//            User user = new User();
//            user.setAname("user" + (i + 1)); // 用户名设置为 user1, user2, 等
//            user.setAword("password" + (i + 1)); // 随机设置密码
//            user.setRealname("RealName" + (i + 1)); // 真实姓名
//            user.setAvalid("有效");
//            list.add(user);
//        }
//        return list;
//    }

    public List selectDataFromDB(String uname,String realName){
        String ztj="",tj="";
        if (uname==null||uname.equals("")){tj="";}
        else {
            tj=" aname='"+uname+"' ";
            ztj = tj;
        }
        if (realName==null||realName.equals("")){tj="";}
        else {
            tj=" realname like '%"+realName+"%' ";
            if(ztj.equals("")){ztj=tj;}
            else ztj = ztj+" and "+tj;
        }
        ArrayList list = new ArrayList();
        try {
            Connection conn= ConnDB.getConnection();
            String strsql="select a.*,b.* from TUser a,TRole b where a.RoleID=b.RoleID";
            if (!ztj.equals("")){strsql="select a.*,b.* from TUser a,TRole b where a.RoleID=b.RoleID and "+ztj;}
            System.out.println(strsql);
            PreparedStatement pstmt=conn.prepareStatement(strsql);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next()){
                User obj = new User();
                obj.setAname(rs.getString("aname"));
                obj.setAword(rs.getString("aword"));
                obj.setRealname(rs.getString("realname"));
                obj.setAvalid(rs.getString("avalid"));
                obj.setRoleID(rs.getString("RoleID"));
                obj.setRoleName(rs.getString("RoleName"));
                list.add(obj);
            }
            rs.close();
            pstmt.close();
            conn.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;

    }

    public int insertUser(String aname,String aword,String realname,String avalid,String RoleID){
        String sqlstr="insert tuser(aname,aword,realname,avalid,RoleID) values('"+aname+"','"+aword+"','"+realname+"','"+avalid+"','"+RoleID+"')";
        System.out.println(sqlstr);
        int result = 0;
        result=ConnDB.execSQL(sqlstr);
        return result;
    }
    public int updateUser(String aname,String aword,String realname,String avalid,String RoleID){
        String sqlstr="update tuser set aword='"+aword+"',realname='"+realname+"',avalid='"+avalid+"',RoleID='"+RoleID+"' where aname='"+aname+"'";
        System.out.println(sqlstr);
        int result = 0;
        result=ConnDB.execSQL(sqlstr);
        return result;
    }
    public int deleteUser(String aname){
        String sqlstr="delete from tuser where aname='"+aname+"'";
        System.out.println(sqlstr);
        int result = 0;
        result = ConnDB.execSQL(sqlstr);
        return result;
    }
    public User selectUserByName(String uname){
        User obj=new User();
        try{
            Connection conn=ConnDB.getConnection();
            String sqlstr="select * from TUser where aname='"+uname+"'";
            System.out.println(sqlstr);
            PreparedStatement pstmt= conn.prepareStatement(sqlstr);
            ResultSet rs=pstmt.executeQuery();
            if (rs.next()){
                obj.setAname(rs.getString("aname"));
                obj.setRealname(rs.getString("realname"));
                obj.setAvalid(rs.getString("avalid"));
                obj.setRoleID(rs.getString("RoleID"));
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return obj;
    }
    public String checkUserByName(String uname){
        String result="不存在！";
        try {
            Connection conn=ConnDB.getConnection();
            String sqlstr="select * from TUser where aname='"+uname+"'";
            System.out.println(sqlstr);
            PreparedStatement pstmt= conn.prepareStatement(sqlstr);
            ResultSet rs=pstmt.executeQuery();
            if (rs.next()){
                result="已存在！";
            }
            rs.close();
            pstmt.close();
            conn.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}

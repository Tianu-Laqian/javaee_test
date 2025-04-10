package com.pub;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PubDao {
    public boolean checkLogin(String uname, String aword) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isValidUser = false;

        try {
            // 获取数据库连接
            conn = ConnDB.getConnection();
            // 使用预编译语句
            String sql = "SELECT * FROM tuser WHERE aname = ? AND aword = ?";
            pstmt = conn.prepareStatement(sql);
            // 设置占位符参数
            pstmt.setString(1, uname);
            pstmt.setString(2, aword);
            // 执行查询
            rs = pstmt.executeQuery();
            // 判断结果集是否有记录
            if (rs.next()) {
                isValidUser = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 关闭资源
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return isValidUser;
    }
}

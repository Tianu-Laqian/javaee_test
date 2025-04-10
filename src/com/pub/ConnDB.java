package com.pub;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnDB {
    private static final String URL = "jdbc:mysql://localhost:3306/demo_test?characterEncoding=utf8&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver"); // 新版驱动类名
            // 建立数据库连接
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            if (conn != null) {
                System.out.println("连接数据库成功");
            } else {
                System.err.println("连接数据库失败，返回的 Connection 为 null");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("数据库驱动加载失败: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("数据库连接失败: " + e.getMessage());
        }
        return conn;
    }
    public static int execSQL(String sql) {
        int result = 0;
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            result = stmt.executeUpdate(sql);  // 执行SQL语句并返回受影响的行数
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        // 测试连接
        Connection testConnection = getConnection();
        if (testConnection != null) {
            System.out.println("数据库连接测试通过！");
            try {
                testConnection.close(); // 关闭连接
                System.out.println("数据库连接已关闭");
            } catch (SQLException e) {
                System.err.println("关闭数据库连接失败: " + e.getMessage());
            }
        } else {
            System.err.println("数据库连接测试失败，请检查配置！");
        }
    }
}
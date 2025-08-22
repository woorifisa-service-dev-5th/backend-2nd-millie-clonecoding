package dev.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dev.model.User;
import dev.db.DBConnection;

public class UserDAO {
    
    public User authenticateUser(String nickname, String pw) throws SQLException, ClassNotFoundException {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT id, nickname, pw FROM user WHERE nickname = ? AND pw = ?";

        try {
            conn = DBConnection.getConnection(); // Now throws ClassNotFoundException
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nickname);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setNickname(rs.getString("nickname"));
                user.setPw(rs.getString("pw"));
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }
}
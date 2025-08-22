package com.reading.dao;

import java.sql.*;
import com.reading.model.User;
import com.reading.util.DBConnection;

public class UserDAO {
    
    // 로그인 인증
    public User authenticateUser(String nickname, String password) 
            throws SQLException, ClassNotFoundException {
        
        User user = null;
        String sql = "SELECT * FROM user WHERE nickname = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, nickname);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setNickname(rs.getString("nickname"));
                user.setPassword(rs.getString("password"));
            }
            rs.close();
        }
        
        return user;
    }
}
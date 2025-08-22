package com.reading.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.reading.util.DBConnection;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if ("/stats".equals(pathInfo)) {
            getUserStats(request, response);
        }
    }
    
    private void getUserStats(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Map<String, Object> stats = new HashMap<>();
        
        try (Connection conn = DBConnection.getConnection()) {
            // 완독 도서 수
            String sql1 = "SELECT COUNT(*) as cnt FROM UserBook WHERE user_id = 1 AND reading_status = 'COMPLETED'";
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            ResultSet rs1 = pstmt1.executeQuery();
            if (rs1.next()) {
                stats.put("completedBooks", rs1.getInt("cnt"));
            }
            
            // 읽는 중 도서 수
            String sql2 = "SELECT COUNT(*) as cnt FROM UserBook WHERE user_id = 1 AND reading_status = 'READING'";
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            ResultSet rs2 = pstmt2.executeQuery();
            if (rs2.next()) {
                stats.put("readingBooks", rs2.getInt("cnt"));
            }
            
            // 기본값 설정
            stats.put("challengeCount", 1);
            stats.put("reviewCount", 0);
            stats.put("monthlyAverage", 2.3);
            stats.put("progressPercentage", 46);
            stats.put("target", 5);
            stats.put("rank", 57);
            
        } catch (SQLException e) {
            e.printStackTrace();
            // 에러 시 기본값 반환
            stats.put("completedBooks", 0);
            stats.put("readingBooks", 0);
        }
        
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(stats));
    }
}
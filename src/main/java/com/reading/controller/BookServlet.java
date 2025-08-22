package com.reading.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.reading.model.User;
import com.reading.util.DBConnection;

@WebServlet("/book/*")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            // 로그인하지 않은 경우 빈 배열 반환
            response.getWriter().write("[]");
            return;
        }
        
        int userId = loggedInUser.getId();
        
        List<Map<String, Object>> books = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT b.*, ub.reading_status " +
                        "FROM book b " +
                        "LEFT JOIN userbook ub ON b.id = ub.book_id AND ub.user_id = ? " +
                        "ORDER BY b.id";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> book = new HashMap<>();
                book.put("id", rs.getInt("id"));
                book.put("title", rs.getString("title"));
                book.put("author", rs.getString("author"));
                book.put("book_cover", rs.getString("book_cover"));
                book.put("category", rs.getString("category"));
                book.put("reading_status", rs.getString("reading_status"));
                
                // 색상 클래스
                String[] colors = {"", "dark", "orange", "green", "purple"};
                book.put("colorClass", colors[rs.getInt("id") % colors.length]);
                
                books.add(book);
            }
            
            rs.close();
            pstmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(books));
    }
}
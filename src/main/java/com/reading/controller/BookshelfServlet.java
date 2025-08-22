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
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.reading.util.DBConnection;

//BookshelfServlet.java 새로 생성
@WebServlet("/bookshelf/preview")
public class BookshelfServlet extends HttpServlet {
 
 @Override
 protected void doGet(HttpServletRequest request, HttpServletResponse response) 
         throws ServletException, IOException {
     
     response.setContentType("application/json");
     response.setCharacterEncoding("UTF-8");
     
     List<Map<String, Object>> shelves = new ArrayList<>();
     
     try (Connection conn = DBConnection.getConnection()) {
         String sql = "SELECT bs.*, COUNT(bib.book_id) as book_count " +
                     "FROM bookshelf bs " +
                     "LEFT JOIN book_in_bookshelf bib ON bs.id = bib.bookshelf_id " +
                     "WHERE bs.user_id = 1 " +
                     "GROUP BY bs.id";
         
         PreparedStatement pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery();
         
         while (rs.next()) {
             Map<String, Object> shelf = new HashMap<>();
             shelf.put("id", rs.getInt("id"));
             shelf.put("name", rs.getString("name"));
             shelf.put("bookCount", rs.getInt("book_count"));
             
             String[] colors = {"orange", "purple", "green", "dark"};
             shelf.put("colorClass", colors[new Random().nextInt(colors.length)]);
             
             shelves.add(shelf);
         }
         
     } catch (SQLException e) {
         e.printStackTrace();
     }
     
     // 데이터 없으면 기본 책장 표시
     if (shelves.isEmpty()) {
         Map<String, Object> defaultShelf = new HashMap<>();
         defaultShelf.put("id", 1);
         defaultShelf.put("name", "내 책장");
         defaultShelf.put("bookCount", 0);
         defaultShelf.put("colorClass", "orange");
         shelves.add(defaultShelf);
     }
     
     Gson gson = new Gson();
     response.getWriter().write(gson.toJson(shelves));
 }
}
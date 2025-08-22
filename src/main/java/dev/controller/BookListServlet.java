package dev.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dev.model.Book;


@WebServlet("/bookList")
public class BookListServlet extends HttpServlet {

    // JDBC 연결 정보


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	response.setContentType("text/html;charset=UTF-8");
    	
    	Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
        List<Book> bookList = new ArrayList<>();

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL + DATABASE_SCHEMA, USER_NAME, PASSWORD);
            statement = conn.createStatement();
            
            String sql = "SELECT * FROM BOOK";
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setBookCover(rs.getString("book_cover"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                bookList.add(book);
                System.out.println("도서 꺼내오기 완료");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (statement != null) statement.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // JSP로 데이터를 전달
        request.setAttribute("books", bookList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/bookList.jsp");
        dispatcher.forward(request, response);
    }
}
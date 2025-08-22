package dev.syntax.model;

import dev.syntax.utils.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookModel {

    public List<Book> getAll() {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT id, book_cover, author, title, category FROM book";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                list.add(new Book(
                        rs.getInt("id"),
                        rs.getString("book_cover"),
                        rs.getString("author"),
                        rs.getString("title"),
                        rs.getString("category")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}

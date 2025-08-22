package dev.syntax.model;

import dev.syntax.utils.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserBookModel {

    public List<UserBook> getAll() {
        List<UserBook> list = new ArrayList<>();
        String sql = "SELECT book_id, user_id, reading_status FROM userbook WHERE user_id=3";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                list.add(new UserBook(
                        rs.getInt("book_id"),
                        rs.getInt("user_id"),
                        rs.getString("reading_status")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}

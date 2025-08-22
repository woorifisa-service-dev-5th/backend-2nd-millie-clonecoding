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
    
 // userBook에 책 추가
    public boolean addUserBook(int userId, int bookId) throws SQLException {
        // 이미 존재하는지 확인
        String checkSql = "SELECT COUNT(*) FROM userbook WHERE user_id=? AND book_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, bookId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // 이미 존재
            }
        }

        // 존재하지 않으면 삽입
        String insertSql = "INSERT INTO userbook(user_id, book_id, reading_status) VALUES (?, ?, 'to_read')";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, bookId);
            insertStmt.executeUpdate();
        }

        return true;
    }
}

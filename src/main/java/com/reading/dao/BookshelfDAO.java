package com.reading.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.reading.model.Book;
import com.reading.model.Bookshelf;
import com.reading.util.DBConnection;

public class BookshelfDAO {
    
    // 사용자별 책장 목록 조회
    public List<Bookshelf> findByUserId(int userId) {
        String sql = "SELECT * FROM bookshelf WHERE user_id = ? ORDER BY created_date DESC";
        List<Bookshelf> bookshelves = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Bookshelf bookshelf = mapResultSetToBookshelf(rs);
                // 각 책장의 도서 수 계산
                bookshelf.setBookCount(getBookCountInShelf(bookshelf.getId()));
                bookshelves.add(bookshelf);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookshelves;
    }
    
    // 책장 ID로 조회
    public Bookshelf findById(int id) {
        String sql = "SELECT * FROM bookshelf WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Bookshelf bookshelf = mapResultSetToBookshelf(rs);
                // 책장에 포함된 도서들 가져오기
                bookshelf.setBooks(getBooksInShelf(id));
                return bookshelf;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 책장 생성
    public boolean insert(Bookshelf bookshelf) {
        String sql = "INSERT INTO bookshelf (userId, name, user_id, is_public) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bookshelf.getUserId());
            pstmt.setString(2, bookshelf.getName());
            pstmt.setInt(3, bookshelf.getUserIdInt());
            pstmt.setBoolean(4, bookshelf.isPublic());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 책장에 도서 추가
    public boolean addBookToShelf(int bookshelfId, int bookId) {
        String sql = "INSERT IGNORE INTO book_in_bookshelf (book_id, bookshelf_id) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            pstmt.setInt(2, bookshelfId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 책장에서 도서 제거
    public boolean removeBookFromShelf(int bookshelfId, int bookId) {
        String sql = "DELETE FROM book_in_bookshelf WHERE book_id = ? AND bookshelf_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            pstmt.setInt(2, bookshelfId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 책장 삭제
    public boolean delete(int id) {
        String sql = "DELETE FROM bookshelf WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 책장에 포함된 도서들 조회
    private List<Book> getBooksInShelf(int bookshelfId) {
        String sql = """
            SELECT b.* FROM book b
            INNER JOIN book_in_bookshelf bib ON b.id = bib.book_id
            WHERE bib.bookshelf_id = ?
            ORDER BY bib.added_date DESC
            """;
        
        List<Book> books = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookshelfId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setBookCover(rs.getString("book_cover"));
                book.setCategory(rs.getString("category"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 책장의 도서 수 계산
    private int getBookCountInShelf(int bookshelfId) {
        String sql = "SELECT COUNT(*) as count FROM book_in_bookshelf WHERE bookshelf_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookshelfId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // ResultSet을 Bookshelf 객체로 매핑하는 헬퍼 메서드
    private Bookshelf mapResultSetToBookshelf(ResultSet rs) throws SQLException {
        Bookshelf bookshelf = new Bookshelf();
        bookshelf.setId(rs.getInt("id"));
        bookshelf.setUserId(rs.getString("userId"));
        bookshelf.setName(rs.getString("name"));
        bookshelf.setUserIdInt(rs.getInt("user_id"));
        bookshelf.setPublic(rs.getBoolean("is_public"));
        bookshelf.setCreatedDate(rs.getTimestamp("created_date"));
        return bookshelf;
    }
}
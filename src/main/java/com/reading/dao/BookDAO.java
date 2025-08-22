package com.reading.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.reading.model.Book;
import com.reading.model.UserBook;
import com.reading.util.DBConnection;

public class BookDAO {
    
    // 도서 ID로 조회
    public Book findById(int id) {
        String sql = "SELECT * FROM book WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBook(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 사용자별 도서 목록 조회 (독서 상태 포함)
    public List<UserBook> findUserBooks(int userId) {
        String sql = """
            SELECT b.*, ub.reading_status, ub.start_date, ub.end_date, 
                   ub.current_page, ub.rating
            FROM book b
            INNER JOIN UserBook ub ON b.id = ub.book_id
            WHERE ub.user_id = ?
            ORDER BY ub.created_date DESC
            """;
        
        List<UserBook> userBooks = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                UserBook userBook = new UserBook();
                userBook.setUserId(userId);
                userBook.setBookId(rs.getInt("id"));
                userBook.setReadingStatus(UserBook.ReadingStatus.valueOf(rs.getString("reading_status")));
                userBook.setStartDate(rs.getDate("start_date"));
                userBook.setEndDate(rs.getDate("end_date"));
                userBook.setCurrentPage(rs.getInt("current_page"));
                userBook.setRating(rs.getInt("rating"));
                
                // Book 정보 설정
                Book book = mapResultSetToBook(rs);
                userBook.setBook(book);
                
                userBooks.add(userBook);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userBooks;
    }
    
    // 도서 생성
    public boolean insert(Book book) {
        String sql = "INSERT INTO book (title, author, book_cover, category, publisher, isbn, page_count, publish_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getBookCover());
            pstmt.setString(4, book.getCategory());
            pstmt.setString(5, book.getPublisher());
            pstmt.setString(6, book.getIsbn());
            pstmt.setInt(7, book.getPageCount() != null ? book.getPageCount() : 0);
            pstmt.setDate(8, book.getPublishDate());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 사용자 도서 관계 추가
    public boolean addUserBook(UserBook userBook) {
        String sql = "INSERT INTO UserBook (user_id, book_id, reading_status, start_date) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE reading_status = VALUES(reading_status), start_date = VALUES(start_date)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userBook.getUserId());
            pstmt.setInt(2, userBook.getBookId());
            pstmt.setString(3, userBook.getReadingStatus().name());
            pstmt.setDate(4, userBook.getStartDate());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 독서 상태 업데이트
    public boolean updateReadingStatus(int userId, int bookId, UserBook.ReadingStatus status) {
        String sql = "UPDATE UserBook SET reading_status = ? WHERE user_id = ? AND book_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status.name());
            pstmt.setInt(2, userId);
            pstmt.setInt(3, bookId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 제목으로 도서 검색
    public List<Book> searchByTitle(String title) {
        String sql = "SELECT * FROM book WHERE title LIKE ? ORDER BY title";
        List<Book> books = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + title + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 카테고리별 도서 조회
    public List<Book> findByCategory(String category) {
        String sql = "SELECT * FROM book WHERE category = ? ORDER BY title";
        List<Book> books = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // ResultSet을 Book 객체로 매핑하는 헬퍼 메서드
    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        book.setBookCover(rs.getString("book_cover"));
        book.setCategory(rs.getString("category"));
        book.setPublisher(rs.getString("publisher"));
        book.setIsbn(rs.getString("isbn"));
        book.setPageCount(rs.getInt("page_count"));
        book.setPublishDate(rs.getDate("publish_date"));
        book.setCreatedDate(rs.getTimestamp("created_date"));
        return book;
    }
 // BookDAO.java
    public List<Book> getAllBooks() {
        String sql = "SELECT * FROM book ORDER BY created_date DESC";
        List<Book> books = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

}
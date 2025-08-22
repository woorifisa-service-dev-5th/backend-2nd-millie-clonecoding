package com.reading.model;

import java.sql.Date;
import java.sql.Timestamp;

public class UserBook {
    private int userId;
    private int bookId;
    private ReadingStatus readingStatus;
    private Date startDate;
    private Date endDate;
    private Integer currentPage;
    private Integer rating;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    
    // Book 정보도 함께 담기 위한 필드
    private Book book;
    
    // 독서 상태 ENUM
    public enum ReadingStatus {
        READING, COMPLETED, WANT_TO_READ
    }
    
    // 생성자
    public UserBook() {}
    
    public UserBook(int userId, int bookId, ReadingStatus readingStatus) {
        this.userId = userId;
        this.bookId = bookId;
        this.readingStatus = readingStatus;
    }
    
    // Getter, Setter
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public ReadingStatus getReadingStatus() { return readingStatus; }
    public void setReadingStatus(ReadingStatus readingStatus) { this.readingStatus = readingStatus; }
    
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    
    public Integer getCurrentPage() { return currentPage; }
    public void setCurrentPage(Integer currentPage) { this.currentPage = currentPage; }
    
    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }
    
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    
    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
    
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
}
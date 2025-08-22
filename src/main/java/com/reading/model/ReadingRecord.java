package com.reading.model;

import java.sql.Date;
import java.sql.Timestamp;

public class ReadingRecord {
    private int id;
    private int userId;
    private int bookId;
    private Date readingDate;
    private Integer pagesRead;
    private Integer readingTime;
    private String notes;
    private Timestamp createdDate;
    
    // Book 정보도 함께 담기 위한 필드
    private Book book;
    
    // 생성자
    public ReadingRecord() {}
    
    public ReadingRecord(int userId, int bookId, Date readingDate) {
        this.userId = userId;
        this.bookId = bookId;
        this.readingDate = readingDate;
    }
    
    // Getter, Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public Date getReadingDate() { return readingDate; }
    public void setReadingDate(Date readingDate) { this.readingDate = readingDate; }
    
    public Integer getPagesRead() { return pagesRead; }
    public void setPagesRead(Integer pagesRead) { this.pagesRead = pagesRead; }
    
    public Integer getReadingTime() { return readingTime; }
    public void setReadingTime(Integer readingTime) { this.readingTime = readingTime; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
}
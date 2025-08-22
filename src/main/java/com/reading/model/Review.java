package com.reading.model;

import java.sql.Timestamp;

public class Review {
    private int id;
    private int userId;
    private int bookId;
    private String title;
    private String content;
    private Integer rating;
    private boolean isPublic;
    private int likeCount;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    
    // Book과 User 정보를 함께 담기 위한 필드
    private Book book;
    private User user;
    
    // 생성자
    public Review() {}
    
    public Review(int userId, int bookId, String content) {
        this.userId = userId;
        this.bookId = bookId;
        this.content = content;
        this.isPublic = true;
        this.likeCount = 0;
    }
    
    // Getter, Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }
    
    public boolean isPublic() { return isPublic; }
    public void setPublic(boolean isPublic) { this.isPublic = isPublic; }
    
    public int getLikeCount() { return likeCount; }
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }
    
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    
    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
    
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}
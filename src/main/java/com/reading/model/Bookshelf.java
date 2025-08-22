package com.reading.model;

import java.sql.Timestamp;
import java.util.List;

public class Bookshelf {
    private int id;
    private String userId;  // ERD에 표시된 userId 필드
    private String name;
    private int userIdInt;  // user_id 외래키
    private boolean isPublic;
    private Timestamp createdDate;
    
    // 책장에 포함된 도서들
    private List<Book> books;
    private int bookCount;
    
    // 생성자
    public Bookshelf() {}
    
    public Bookshelf(String userId, String name, int userIdInt) {
        this.userId = userId;
        this.name = name;
        this.userIdInt = userIdInt;
        this.isPublic = true;
    }
    
    // Getter, Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public int getUserIdInt() { return userIdInt; }
    public void setUserIdInt(int userIdInt) { this.userIdInt = userIdInt; }
    
    public boolean isPublic() { return isPublic; }
    public void setPublic(boolean isPublic) { this.isPublic = isPublic; }
    
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    
    public List<Book> getBooks() { return books; }
    public void setBooks(List<Book> books) { 
        this.books = books;
        this.bookCount = books != null ? books.size() : 0;
    }
    
    public int getBookCount() { return bookCount; }
    public void setBookCount(int bookCount) { this.bookCount = bookCount; }
}
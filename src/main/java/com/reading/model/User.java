package com.reading.model;

public class User {
    private int id;
    private String nickname;
    private String password;
    private int bookshelfId;
    
    // 기본 생성자
    public User() {}
    
    // 전체 생성자
    public User(int id, String nickname, String password) {
        this.id = id;
        this.nickname = nickname;
        this.password = password;
    }
    
    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public int getBookshelfId() { return bookshelfId; }
    public void setBookshelfId(int bookshelfId) { this.bookshelfId = bookshelfId; }
}
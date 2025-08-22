package dev.model;

public class User {
    private int id;
    private String nickname;
    private String pw; 

    public User() {
    }

    // Constructor with all fields
    public User(int id, String nickname, String pw) {
        this.id = id;
        this.nickname = nickname;
        this.pw = pw;
    }

    // Getters and setters for all fields
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    // Optional: toString() method for easy debugging
    @Override
    public String toString() {
        return "User{" +
               "id=" + id +
               ", nickname='" + nickname + '\'' +
               ", pw='" + pw + '\'' +
               '}';
    }
}
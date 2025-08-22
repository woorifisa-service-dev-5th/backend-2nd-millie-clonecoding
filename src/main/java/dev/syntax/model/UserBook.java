package dev.syntax.model;

public class UserBook {
    private int bookId;
    private int userId;
    private String readingStatus;

    public UserBook(int bookId, int userId, String readingStatus) {
        this.bookId = bookId;
        this.userId = userId;
        this.readingStatus = readingStatus;
    }

    public int getBookId() {
        return bookId;
    }

    public int getUserId() {
        return userId;
    }

    public String getReadingStatus() {
        return readingStatus;
    }
}

package dev.model;

public class Book {
    private int id;
    private String bookCover;
    private String author;
    private String title;
    private String category;

    // 기본 생성자 (필수)
    public Book() {
    }

    // 모든 필드를 포함하는 생성자 (편의를 위해 추가)
    public Book(int id, String bookCover, String author, String title, String category) {
        this.id = id;
        this.bookCover = bookCover;
        this.author = author;
        this.title = title;
        this.category = category;
    }

    // Getter와 Setter 메소드
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBookCover() {
        return bookCover;
    }

    public void setBookCover(String bookCover) {
        this.bookCover = bookCover;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    // 객체 내용을 쉽게 출력하기 위한 toString() 메소드 (선택 사항)
    @Override
    public String toString() {
        return "Book [id=" + id + ", bookCover=" + bookCover + ", author=" + author + ", title=" + title
                + ", category=" + category + "]";
    }
}
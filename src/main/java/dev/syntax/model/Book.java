package dev.syntax.model;

import lombok.Getter;

@Getter
public class Book {
    private int id;
    private String bookCover;
    private String author;
    private String title;
    private String category;
    
	public Book(int id, String bookCover, String author, String title, String category) {
		super();
		this.id = id;
		this.bookCover = bookCover;
		this.author = author;
		this.title = title;
		this.category = category;
	}
    
    
    

}

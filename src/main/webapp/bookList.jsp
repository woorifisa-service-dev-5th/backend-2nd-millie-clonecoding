<%@page import="com.reading.dao.BookDAO"%>
<%@page import="com.reading.model.Book"%>
<%@page import="java.util.List"%>

<%
    BookDAO bookController = new BookDAO();
    List<Book> books = bookController.getAllBooks();
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Book List</title>
</head>
<body>
    <h1>책 목록</h1>
    <form action="AddUserBookServlet" method="post">
        <table border="1">
            <tr>
                <th>선택</th>
                <th>ID</th>
                <th>제목</th>
                <th>저자</th>
                <th>카테고리</th>
            </tr>
            	<% for(Book book : books) { %>
            <tr>
                <td><%= book.getId() %></td>
                <td><%= book.getTitle() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getCategory() %></td>
                <td>
		            <form action="AddUserBookServlet" method="post">
		                <input type="hidden" name="bookId" value="<%= book.getId() %>">
		                <input type="submit" value="추가">
		            </form>
		        </td>
            </tr>
            <% } %>
        </table>
        
    </form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" buffer="32kb" autoFlush="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전체 도서 목록</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans KR", sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .header {
            background: white;
            padding: 12px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .nav {
            display: flex;
            gap: 30px;
        }

        .nav a {
            text-decoration: none;
            color: #666;
            font-size: 14px;
            padding: 8px 0;
        }

        .nav a.active {
            color: #333;
            font-weight: 500;
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .notification {
            width: 20px;
            height: 20px;
            background: #ffc107;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            color: white;
            cursor: pointer;
        }

        .login-btn {
            background: #333;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
        }

        .user-info {
            display: none;
            align-items: center;
            gap: 10px;
        }

        .user-info.logged-in {
            display: flex;
        }

        .logged-in + .login-btn {
            display: none;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .main-content {
            display: flex;
            gap: 30px;
        }

        .sidebar {
            width: 280px;
        }

        .content {
            flex: 1;
        }

        .profile-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .profile-avatar {
            width: 50px;
            height: 50px;
            background: #e9ecef;
            border-radius: 50%;
            margin-right: 12px;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50"><circle cx="25" cy="25" r="25" fill="%23ddd"/><circle cx="25" cy="20" r="8" fill="%23999"/><path d="M10 40c0-8 6-15 15-15s15 7 15 15" fill="%23999"/></svg>');
            background-size: cover;
        }

        .profile-info h3 {
            font-size: 16px;
            margin-bottom: 4px;
        }

        .profile-info p {
            font-size: 12px;
            color: #666;
        }

        .stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .stat {
            text-align: center;
            cursor: pointer;
        }

        .stat-number {
            font-size: 18px;
            font-weight: bold;
            display: block;
        }

        .stat-label {
            font-size: 12px;
            color: #666;
        }

        .profile-actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            border: 1px solid #ddd;
            background: white;
            flex: 1;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        .btn-dark {
            background: #333;
            color: white;
            border-color: #333;
        }

        .btn:hover {
            opacity: 0.8;
        }

        .alert {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 4px;
            padding: 12px;
            font-size: 12px;
            margin-bottom: 20px;
        }

        .section {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .section-title {
            font-size: 16px;
            font-weight: 500;
        }

        .section-link {
            font-size: 12px;
            color: #666;
            text-decoration: none;
            cursor: pointer;
        }

        .section-link:hover {
            color: #333;
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 15px;
        }

        .book-item {
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .book-item:hover {
            transform: translateY(-2px);
        }

        .book-cover {
            width: 100%;
            height: 160px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 4px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            text-align: center;
            padding: 10px;
            position: relative;
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 4px;
        }

        .book-cover.dark {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        }

        .book-cover.orange {
            background: linear-gradient(135deg, #f39c12 0%, #e74c3c 100%);
        }

        .book-cover.green {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
        }

        .book-cover.purple {
            background: linear-gradient(135deg, #8e44ad 0%, #9b59b6 100%);
        }

        .book-title {
            font-size: 12px;
            margin-bottom: 4px;
            font-weight: 500;
            line-height: 1.3;
        }

        .book-author {
            font-size: 11px;
            color: #666;
        }

        .book-status {
            position: absolute;
            top: 5px;
            right: 5px;
            padding: 2px 6px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: bold;
        }

        .status-reading {
            background: #28a745;
            color: white;
        }

        .status-completed {
            background: #007bff;
            color: white;
        }

        .status-want_to_read {
            background: #ffc107;
            color: #333;
        }

        .calendar {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 1px;
            background: #e9ecef;
            border-radius: 4px;
            overflow: hidden;
        }

        .calendar-day {
            background: white;
            padding: 10px 5px;
            text-align: center;
            font-size: 12px;
            min-height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            cursor: pointer;
        }

        .calendar-day:hover {
            background: #f8f9fa;
        }

        .calendar-day.today {
            background: #007bff;
            color: white;
            border-radius: 50%;
        }

        .calendar-day.has-reading {
            background: #28a745;
            color: white;
        }

        .reading-dot {
            position: absolute;
            bottom: 2px;
            width: 4px;
            height: 4px;
            background: #28a745;
            border-radius: 50%;
        }

        .progress-bar {
            width: 100%;
            height: 20px;
            background: #e9ecef;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }

        .progress {
            height: 100%;
            background: linear-gradient(90deg, #6c757d 0%, #495057 100%);
            transition: width 0.3s ease;
        }

        .activity-icons {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .activity-item {
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .activity-item:hover {
            transform: scale(1.05);
        }

        .activity-icon {
            width: 60px;
            height: 60px;
            background: #f8f9fa;
            border-radius: 50%;
            margin: 0 auto 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            transition: background 0.2s;
        }

        .activity-icon:hover {
            background: #e9ecef;
        }

        .bookshelf-books {
            display: flex;
            gap: 15px;
            overflow-x: auto;
            padding-bottom: 10px;
        }

        .bookshelf-book {
            flex-shrink: 0;
            width: 120px;
            text-align: center;
            cursor: pointer;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 16px;
        }

        .loading {
            display: none;
            text-align: center;
            padding: 20px;
            color: #666;
        }

        .loading.show {
            display: block;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
            }
            
            .nav {
                gap: 15px;
            }
            
            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">📚 OO의서재</div>
        <nav class="nav">
            <a href="#" data-page="search">검색</a>
            <a href="#" data-page="library">내서재</a>
        </nav>
        <div class="user-actions">
            <div class="notification" onclick="showNotifications()">
                <span id="notification-count">1</span>
            </div>
            <button class="login-btn" onclick="showLogin()">로그인</button>
            <div class="user-info" id="user-info">
                <span id="user-nickname">사용자</span>
                <button onclick="logout()" style="background: none; border: none; color: #666; cursor: pointer;">로그아웃</button>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">전체 도서 목록</h2>
            </div>
            <div class="books-grid" id="books-grid">
                <c:forEach var="book" items="${books}">
                    <div class="book-item" onclick="showBookDetail(${book.id})">
                        <div class="book-cover ${book.colorClass}" data-book-id="${book.id}">
                            <c:if test="${not empty book.bookCover}">
                                <img src="${book.bookCover}" alt="${book.title}">
                            </c:if>
                            <c:if test="${empty book.bookCover}">
                                ${book.title}
                            </c:if>
                        </div>
                        <div class="book-title">${book.title}</div>
                        <div class="book-author">${book.author}</div>
                        <div class="book-category" style="font-size: 10px; color: #999;">${book.category}</div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty books}">
                    <div class="empty-state" style="display: block;">
                        <div class="empty-state-icon">📚</div>
                        <p>등록된 도서가 없습니다.</p>
                        <button class="btn btn-dark" onclick="addFirstBook()" style="margin-top: 10px;">첫 번째 책 추가하기</button>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script>
        function showBookDetail(bookId) {
            window.location.href = 'book-detail.jsp?id=' + bookId;
        }
        function addFirstBook() {
             window.location.href = 'book-add.jsp';
        }
    </script>
</body>
</html>
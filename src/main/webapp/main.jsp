<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" buffer="32kb" autoFlush="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>우리의서재</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate">

<script>                                                                  
// 뒤로가기(bfcache) 복귀 시 강제 리로드                                            
  window.onpageshow = function(e) { if (e.persisted) location.reload(); };	
  </script>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
		"Noto Sans KR", sans-serif;
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

.logged-in+.login-btn {
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
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
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
	background-image:
		url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50"><circle cx="25" cy="25" r="25" fill="%23ddd"/><circle cx="25" cy="20" r="8" fill="%23999"/><path d="M10 40c0-8 6-15 15-15s15 7 15 15" fill="%23999"/></svg>');
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
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
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
@media ( max-width : 768px) {
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
		<div class="logo">📚 ${sessionScope.loggedInUser.nickname}의서재</div>
		<div class="user-actions">
			<div class="notification" onclick="showNotifications()">
				<span id="notification-count">1</span>
			</div>

			<c:choose>
				<c:when test="${not empty sessionScope.loggedInUser}">
					<div class="user-info logged-in" id="user-info">
						<button onclick="logout()"
							style="background: none; border: none; color: #666; cursor: pointer;">로그아웃</button>
						<script>
                    	const contextPath = '<%=request.getContextPath()%>';
                    	function logout() {
                    	    window.location.href = contextPath + '/logout';
                    	}R
                    	</script>
					</div>
				</c:when>
				<c:otherwise>
					<button class="login-btn" onclick="login()">로그인</button>
					<script>
                    	const contextPath = '<%=request.getContextPath()%>';
                    	function login() {
                    	    window.location.href = contextPath + '/login.jsp';
                    	}
                    	</script>
				</c:otherwise>
			</c:choose>



		</div>
	</div>

	<div class="container">
		<div class="main-content">
			<div class="sidebar">
				<div class="profile-card">
					<div class="profile-header">
						<div class="profile-avatar" id="profile-avatar"></div>
						<div class="profile-info">
							<h3 id="user-nickname-display">${sessionScope.loggedInUser.nickname}</h3>
							<p>
								팔로잉 <span id="following-count">0</span> · 팔로워 <span
									id="follower-count">0</span>
							</p>
						</div>
					</div>
					<div class="stats">
						<div class="stat" onclick="showCompletedBooks()">
							<span class="stat-number" id="completed-books-count">0</span> <span
								class="stat-label">읽은책</span>
						</div>
						<div class="stat" onclick="showReadingBooks()">
							<span class="stat-number" id="reading-books-count">0</span> <span
								class="stat-label">독서중</span>
						</div>
						<div class="stat" onclick="showReviews()">
							<span class="stat-number" id="review-count">1</span> <span
								class="stat-label">리뷰</span>
						</div>
					</div>
					<div class="profile-actions">
						<a href="#" class="btn btn-dark" onclick="showWriteForm()">+
							글쓰기</a> <a href="#" class="btn" onclick="showBookSearch()">내 도서검색</a>
					</div>
				</div>

				<div class="alert" id="user-alert">💡 독서 기록을 시작해보세요! 첫 번째 책을
					추가해보세요.</div>
			</div>

			<div class="content">
				<!-- 도서 섹션 -->
				<div class="section">
					<div class="section-header">
						<h2 class="section-title">도서</h2>
						<a href="#" class="section-link" onclick="showAllBooks()">전체보기</a>
					</div>
					<div class="loading" id="books-loading">📚 도서를 불러오는 중...</div>
					<div class="books-grid" id="books-grid">
						<!-- 서버에서 도서 데이터를 받아와서 동적으로 생성 -->
					</div>
					<div class="empty-state" id="books-empty" style="display: none;">
						<div class="empty-state-icon">📚</div>
						<p>아직 등록된 도서가 없습니다.</p>
						<button class="btn btn-dark" onclick="addFirstBook()"
							style="margin-top: 10px;">첫 번째 책 추가하기</button>
					</div>
				</div>

				<!-- 책장 섹션 -->
				<div class="section">
					<div class="section-header">
						<h2 class="section-title">책장</h2>
						<a href="#" class="section-link" onclick="showBookshelf()">전체보기
							></a>
					</div>
					<div class="bookshelf-books" id="bookshelf-preview">
						<!-- 서버에서 책장 데이터를 받아와서 동적으로 생성 -->
					</div>
				</div>


				<!-- 독서 리포트 섹션 -->
				<div class="section">
					<div class="section-header">
						<h2 class="section-title">독서 리포트</h2>
						<a href="#" class="section-link" onclick="showDetailedReport()">전체보기
							></a>
					</div>
					<p style="font-size: 12px; color: #666; margin-bottom: 20px;">독서
						리포트로 당신의 독서 기록을 확인하세요</p>

					<div style="margin-bottom: 20px;">
						<div
							style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
							<span style="font-size: 14px;">내 월 평균 독서량</span> <span
								style="font-size: 12px; color: #666;" id="user-monthly-average">0권/월</span>
						</div>
						<div class="progress-bar">
							<div class="progress" id="user-progress" style="width: 0%;"></div>
						</div>
						<div
							style="font-size: 11px; color: #999; text-align: right; margin-top: 4px;">
							목표: <span id="user-target">5</span>권/월
						</div>
					</div>

					<div style="margin-bottom: 10px;">
						<div
							style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
							<span style="font-size: 14px;">전체 이용자 평균</span> <span
								style="font-size: 12px; color: #666;" id="global-average">1.8권/월</span>
						</div>
						<div class="progress-bar">
							<div class="progress" id="global-progress"
								style="width: 70%; background: linear-gradient(90deg, #28a745 0%, #20c997 100%);"></div>
						</div>
						<div
							style="font-size: 11px; color: #999; text-align: right; margin-top: 4px;">
							상위 <span id="user-rank">57</span>%
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<script>
        // 전역 변수
        const contextPath = '<%=request.getContextPath()%>';
        let currentUser = null;
        let userBooks = [];
        let readingRecords = [];
        let currentMonth = 7; // 8월 (0-based)
        let currentYear = 2025;

        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            initializePage();
        });

        // 페이지 초기화
        function initializePage() {
            // 사용자 로그인 상태 확인
            checkLoginStatus();
            
            // 초기 데이터 로드
            loadInitialData();
            
            // 이벤트 리스너 설정
            setupEventListeners();
        }

        // 로그인 상태 확인 (서버와 통신)
        function checkLoginStatus() {
            // TODO: 서버에 세션 확인 요청
            // fetch('/api/auth/status')
            //     .then(response => response.json())
            //     .then(data => {
            //         if (data.isLoggedIn) {
            //             setUserData(data.user);
            //         }
            //     });
        
        }

        // 초기 데이터 로드
        function loadInitialData() {
            loadUserBooks();
            loadBookshelfPreview();
            loadReadingRecords();
            loadUserStats();
            generateCalendar(currentMonth, currentYear);
        }

        // 사용자 도서 목록 로드
        function loadUserBooks() {
            document.getElementById('books-loading').classList.add('show');
            
            // 서버에서 사용자 도서 목록 가져오기
            fetch(contextPath + '/book/list', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                userBooks = data;
                renderBooksGrid(data);
                document.getElementById('books-loading').classList.remove('show');
            })
            .catch(error => {
                console.error('도서 로드 실패:', error);
                // 서버 연결 실패 시 임시 데이터로 폴백
                loadMockBooks();
            });
        }

        // 임시 데이터 로드 (개발용) - ERD 구조에 맞게 수정
        function loadMockBooks() {
            const mockBooks = [
                {
                    // book 테이블 구조
                    id: 1,
                    title: '내 안에 잠든 거인을 깨워라',
                    author: '앤서니 로빈스',
                    book_cover: null,
                    category: '자기계발',
                    // UserBook 테이블의 reading_status
                    reading_status: 'READING',
                    colorClass: 'dark'
                },
                {
                    id: 2,
                    title: '가족의 노래를 불러요',
                    author: '정세랑 외',
                    book_cover: null,
                    category: '소설',
                    reading_status: 'COMPLETED',
                    colorClass: ''
                },
                {
                    id: 3,
                    title: '창업하는 음식점 성공하는 창업전략',
                    author: '박정빈',
                    book_cover: null,
                    category: '경영',
                    reading_status: 'WANT_TO_READ',
                    colorClass: 'orange'
                },
                {
                    id: 4,
                    title: '내가 하고 있는 일이 맞나요?',
                    author: '김재정',
                    book_cover: null,
                    category: '자기계발',
                    reading_status: 'READING',
                    colorClass: 'green'
                },
                {
                    id: 5,
                    title: '출판주기적 가정',
                    author: '권애정',
                    book_cover: null,
                    category: '인문',
                    reading_status: 'COMPLETED',
                    colorClass: 'purple'
                }
            ];
            userBooks = mockBooks;
            renderBooksGrid(mockBooks);
            document.getElementById('books-loading').classList.remove('show');
        }

        // 도서 그리드 렌더링 - ERD 구조에 맞게 수정
function renderBooksGrid(books) {
    const grid = document.getElementById('books-grid');
    
    if (books.length === 0) {
        showEmptyBooksState();
        return;
    }

    // 방법 1: $ 기호를 분리
    grid.innerHTML = books.map(book => 
        '<div class="book-item" onclick="showBookDetail(' + book.id + ')">' +
            '<div class="book-cover ' + (book.colorClass || '') + '" data-book-id="' + book.id + '">' +
                (book.book_cover ? 
                    '<img src="' + book.book_cover + '" alt="' + book.title + '">' : 
                    book.title
                ) +
                '<div class="book-status status-' + book.reading_status.toLowerCase() + '">' +
                    getStatusText(book.reading_status) +
                '</div>' +
            '</div>' +
            '<div class="book-title">' + book.title + '</div>' +
            '<div class="book-author">' + book.author + '</div>' +
            '<div class="book-category" style="font-size: 10px; color: #999;">' + book.category + '</div>' +
        '</div>'
    ).join('');
}

        // 상태 텍스트 변환 - ERD의 ENUM 값에 맞게 수정
        function getStatusText(status) {
            const statusMap = {
                'READING': '읽는중',
                'COMPLETED': '완독',
                'WANT_TO_READ': '읽고싶음'
            };
            return statusMap[status] || '';
        }

        // 빈 도서 상태 표시
        function showEmptyBooksState() {
            document.getElementById('books-grid').style.display = 'none';
            document.getElementById('books-empty').style.display = 'block';
        }

        // 책장 미리보기 로드 - ERD 구조에 맞게 수정
        function loadBookshelfPreview() {
            fetch(contextPath + '/bookshelf/preview', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => response.json())
            .then(data => {
                renderBookshelfPreview(data);
            })
            .catch(error => {
                console.error('책장 로드 실패:', error);
                // 실패 시 임시 데이터 - ERD bookshelf 테이블 구조
                const mockShelves = [
                    {
                        id: 1,
                        name: 'My Favorites',
                        user_id: 1,
                        userId: 'user001', // userId 필드도 있음
                        bookCount: 5,
                        coverImage: null,
                        colorClass: 'orange'
                    },
                    {
                        id: 2,
                        name: '소설 모음',
                        user_id: 1,
                        userId: 'user001',
                        bookCount: 3,
                        coverImage: null,
                        colorClass: 'purple'
                    }
                ];
                renderBookshelfPreview(mockShelves);
            });
        }

        // 책장 미리보기 렌더링
		function renderBookshelfPreview(shelves) {
    		const container = document.getElementById('bookshelf-preview');
    
    		container.innerHTML = shelves.map(shelf => 
        		'<div class="bookshelf-book" onclick="showShelfDetail(' + shelf.id + ')">' +
            	'<div class="book-cover ' + (shelf.colorClass || '') + '" style="height: 120px;">' +
                	(shelf.coverImage ? 
                    	'<img src="' + shelf.coverImage + '" alt="' + shelf.name + '">' : 
                   	 shelf.name
               	 	) +
            	'</div>' +
            	'<div class="book-title" style="margin-top: 8px;">' + shelf.name + '</div>' +
            	'<div class="book-author">' + shelf.bookCount + '권</div>' +
        		'</div>'
    		).join('');
		}

        // 독서 기록 로드
        function loadReadingRecords() {
            fetch(contextPath + '/user/reading-records', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => response.json())
            .then(data => {
                readingRecords = data;
                updateCalendarWithRecords();
            })
            .catch(error => {
                console.error('독서 기록 로드 실패:', error);
                // 실패 시 빈 배열로 초기화
                readingRecords = [];
            });
        }

        // 사용자 통계 로드
        function loadUserStats() {
            fetch(contextPath + '/user/stats', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => response.json())
            .then(data => {
                updateUserStats(data);
            })
            .catch(error => {
                console.error('통계 로드 실패:', error);
                // 실패 시 기본값 유지
            });
        }

        // 사용자 통계 업데이트
        function updateUserStats(stats) {
            document.getElementById('challenge-count').textContent = stats.challengeCount || 0;
            document.getElementById('completed-books-count').textContent = stats.completedBooks || 0;
            document.getElementById('reading-books-count').textContent = stats.readingBooks || 0;
            document.getElementById('review-count').textContent = stats.reviewCount || 0;
            
            document.getElementById('user-monthly-average').textContent = {stats.monthlyAverage || 0}권/월;
            document.getElementById('user-progress').style.width = {stats.progressPercentage || 0}%;
            document.getElementById('user-target').textContent = stats.target || 5;
            document.getElementById('user-rank').textContent = stats.rank || 0;
        }

        // 페이지 네비게이션
        function navigateToPage(page) {
            const pageMap = {
                'search': contextPath + '/search.jsp', 
                'library': contextPath + '/bookshelf.jsp',
                'manage': contextPath + '/manage.jsp'
            };
            
            if (pageMap[page]) {
                window.location.href = pageMap[page];
            }
        }

        // 이벤트 핸들러 함수들
        function showNotifications() {
            window.location.href = contextPath + '/notification.jsp';
        }

        function showBookDetail(bookId) {
            window.location.href = contextPath + '/book-detail.jsp?id=' + bookId;
        }

        function showShelfDetail(shelfId) {
            window.location.href = contextPath + '/bookshelf.jsp?shelfId=' + shelfId;
        }

        function showDayDetail(year, month, day) {
            window.location.href = contextPath + '/reading-record.jsp?date=' + year + '-' + (month+1) + '-' + day;
        }

        function addFirstBook() {
            window.location.href = contextPath + '/book-add.jsp';
        }

        function showWriteForm() {
            window.location.href = contextPath + '/write.jsp';
        }

        // 기타 이벤트 핸들러들
        function showAllBooks() { 
            window.location.href = contextPath + '/bookList.jsp';
        }
        function showBookshelf() { 
            window.location.href = contextPath + '/bookshelf.jsp';
        }
        function showDetailedReport() { 
            window.location.href = contextPath + '/report.jsp';
        }
        function showCompletedBooks() { 
            window.location.href = contextPath + '/bookList.jsp?status=completed';
        }
        function showReadingBooks() { 
            window.location.href = contextPath + '/bookList.jsp?status=reading';
        }
        function showReviews() { 
            window.location.href = contextPath + '/review-list.jsp';
        }
        function showCollections() { 
            window.location.href = contextPath + '/collection.jsp';
        }
    </script>
</body>
</html>
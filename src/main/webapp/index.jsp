<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" buffer="32kb" autoFlush="true"%>
<%@page import="dev.syntax.model.UserBookModel"%>
<%@page import="dev.syntax.model.UserBook"%>
<%@ page import="java.util.List" %>


<%
    UserBookModel userBookModel = new UserBookModel();
    List<UserBook> usersBooks = userBookModel.getAll();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일일의서재</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
    <div class="header">
    
        <div class="logo">📚 일일의서재</div>
        <nav class="nav">
            <a href="#" data-page="tutor">튜터</a>
            <a href="#" class="active" data-page="challenge">챌린지</a>
            <a href="#" data-page="search">검색</a>
            <a href="#" data-page="feed">피드</a>
            <a href="#" data-page="library">내서재</a>
            <a href="#" data-page="manage">관리</a>
        </nav>
        <div class="user-actions">
            <div class="notification" onclick="showNotifications()">
                <span id="notification-count">1</span>
            </div>
            <!-- 로그인 전 -->
            <button class="login-btn" onclick="showLogin()">로그인</button>
            <!-- 로그인 후 (숨김 상태) -->
            <div class="user-info" id="user-info">
                <span id="user-nickname">사용자</span>
                <button onclick="logout()" style="background: none; border: none; color: #666; cursor: pointer;">로그아웃</button>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="main-content">
            <div class="sidebar">
                <div class="profile-card">
                    <div class="profile-header">
                        <div class="profile-avatar" id="profile-avatar"></div>
                        <div class="profile-info">
                            <h3 id="user-nickname-display">책읽는효능</h3>
                            <p>
                                팔로잉 <span id="following-count">0</span> · 
                                팔로워 <span id="follower-count">0</span>
                            </p>
                        </div>
                    </div>
                    <div class="stats">
                        <div class="stat" onclick="showChallenges()">
                            <span class="stat-number" id="challenge-count">1</span>
                            <span class="stat-label">챌린지참여</span>
                        </div>
                        <div class="stat" onclick="showCompletedBooks()">
                            <span class="stat-number" id="completed-books-count">0</span>
                            <span class="stat-label">읽은책</span>
                        </div>
                        <div class="stat" onclick="showReadingBooks()">
                            <span class="stat-number" id="reading-books-count">0</span>
                            <span class="stat-label">독서중</span>
                        </div>
                        <div class="stat" onclick="showReviews()">
                            <span class="stat-number" id="review-count">1</span>
                            <span class="stat-label">리뷰</span>
                        </div>
                    </div>
                    <div class="profile-actions">
                        <a href="#" class="btn btn-dark" onclick="showWriteForm()">+ 글쓰기</a>
                        <a href="#" class="btn" onclick="showBookSearch()">내 도서검색</a>
                    </div>
                </div>

                <div class="alert" id="user-alert">
                    💡 독서 기록을 시작해보세요! 첫 번째 책을 추가해보세요.
                </div>
            </div>

            <div class="content">
                <!-- 도서 섹션 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">도서</h2>
                        <a href="#" class="section-link" onclick="showAllBooks()">전체보기 ></a>
                    </div>
                    <div class="loading" id="books-loading">📚 도서를 불러오는 중...</div>
                    <div class="books-grid" id="books-grid">
                        <div>
						        <%
						            for(UserBook user : usersBooks) {
						        %>
									<div><%= user.getBookId() %></div>
						        <%
						            }
						        %>
						 </div>
                    </div>
                    <div class="empty-state" id="books-empty" style="display: none;">
                        <div class="empty-state-icon">📚</div>
                        <p>아직 등록된 도서가 없습니다.</p>
                        <button class="btn btn-dark" onclick="addFirstBook()" style="margin-top: 10px;">첫 번째 책 추가하기</button>
                    </div>
                </div>

                <!-- 책장 섹션 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">책장</h2>
                        <a href="#" class="section-link" onclick="showBookshelf()">전체보기 ></a>
                    </div>
                    <div class="bookshelf-books" id="bookshelf-preview">
                        <!-- 서버에서 책장 데이터를 받아와서 동적으로 생성 -->
                    </div>
                </div>

                <!-- 독서 캘린더 섹션 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">
                            <select id="month-selector" style="font-size: 16px; border: none; background: none; cursor: pointer;">
                                <option value="0">1월</option>
                                <option value="1">2월</option>
                                <option value="2">3월</option>
                                <option value="3">4월</option>
                                <option value="4">5월</option>
                                <option value="5">6월</option>
                                <option value="6">7월</option>
                                <option value="7" selected>8월</option>
                                <option value="8">9월</option>
                                <option value="9">10월</option>
                                <option value="10">11월</option>
                                <option value="11">12월</option>
                            </select>
                            독서 캘린더
                        </h2>
                        <a href="#" class="section-link" onclick="showFullCalendar()">전체보기 ></a>
                    </div>
                    <div class="calendar" id="calendar">
                        <!-- JavaScript로 동적 생성, 서버에서 독서 기록 데이터 반영 -->
                    </div>
                </div>

                <!-- 독서 리포트 섹션 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">독서 리포트</h2>
                        <a href="#" class="section-link" onclick="showDetailedReport()">전체보기 ></a>
                    </div>
                    <p style="font-size: 12px; color: #666; margin-bottom: 20px;">독서 리포트로 당신의 독서 기록을 확인하세요</p>
                    
                    <div style="margin-bottom: 20px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                            <span style="font-size: 14px;">내 월 평균 독서량</span>
                            <span style="font-size: 12px; color: #666;" id="user-monthly-average">0권/월</span>
                        </div>
                        <div class="progress-bar">
                            <div class="progress" id="user-progress" style="width: 0%;"></div>
                        </div>
                        <div style="font-size: 11px; color: #999; text-align: right; margin-top: 4px;">
                            목표: <span id="user-target">5</span>권/월
                        </div>
                    </div>

                    <div style="margin-bottom: 10px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                            <span style="font-size: 14px;">전체 이용자 평균</span>
                            <span style="font-size: 12px; color: #666;" id="global-average">1.8권/월</span>
                        </div>
                        <div class="progress-bar">
                            <div class="progress" id="global-progress" style="width: 70%; background: linear-gradient(90deg, #28a745 0%, #20c997 100%);"></div>
                        </div>
                        <div style="font-size: 11px; color: #999; text-align: right; margin-top: 4px;">
                            상위 <span id="user-rank">57</span>%
                        </div>
                    </div>
                </div>

                <!-- 독서 활동 섹션 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">독서 활동</h2>
                    </div>
                    <div class="activity-icons">
                        <div class="activity-item" onclick="showCollections()">
                            <div class="activity-icon">❤️</div>
                            <div style="font-size: 12px;">북라뜬</div>
                            <div style="font-size: 12px;">컬렉션읽기</div>
                        </div>
                        <div class="activity-item" onclick="showReadingClubs()">
                            <div class="activity-icon">☕</div>
                            <div style="font-size: 12px;">Latte 독서모임</div>
                            <div style="font-size: 12px;">참가하기</div>
                        </div>
                        <div class="activity-item" onclick="showWriteDiary()">
                            <div class="activity-icon">📝</div>
                            <div style="font-size: 12px;">독서 일지 쓰기</div>
                            <div style="font-size: 12px;">책리 리뷰쓰기</div>
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

        // 사용자 데이터 설정
        function setUserData(user) {
            currentUser = user;
            document.getElementById('user-nickname').textContent = user.nickname;
            document.getElementById('user-nickname-display').textContent = user.nickname;
            document.getElementById('following-count').textContent = user.followingCount || 0;
            document.getElementById('follower-count').textContent = user.followerCount || 0;
            
            // 로그인 상태 UI 변경
            document.getElementById('user-info').classList.add('logged-in');
            
            // 프로필 이미지 설정
            if (user.profileImage) {
                document.getElementById('profile-avatar').style.backgroundImage = url({user.profileImage});
            }
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

        // 달력 생성
        function generateCalendar(month, year) {
            const calendar = document.getElementById('calendar');
            calendar.innerHTML = '';
            
            // 요일 헤더 추가
            const dayHeaders = ['일', '월', '화', '수', '목', '금', '토'];
            dayHeaders.forEach(day => {
                const dayElement = document.createElement('div');
                dayElement.className = 'calendar-day';
                dayElement.style.fontWeight = 'bold';
                dayElement.style.background = '#f8f9fa';
                dayElement.textContent = day;
                calendar.appendChild(dayElement);
            });

            // 해당 월의 첫 번째 날과 마지막 날 구하기
            const firstDay = new Date(year, month, 1);
            const lastDay = new Date(year, month + 1, 0);
            const startDate = firstDay.getDay();
            const daysInMonth = lastDay.getDate();

            // 빈 셀 추가
            for (let i = 0; i < startDate; i++) {
                const emptyDay = document.createElement('div');
                emptyDay.className = 'calendar-day';
                calendar.appendChild(emptyDay);
            }

            // 날짜 추가
            for (let day = 1; day <= daysInMonth; day++) {
                const dayElement = document.createElement('div');
                dayElement.className = 'calendar-day';
                dayElement.textContent = day;
                
                // 오늘 날짜 표시
                const today = new Date();
                if (year === today.getFullYear() && month === today.getMonth() && day === today.getDate()) {
                    dayElement.classList.add('today');
                }
                
                // 독서 기록이 있는 날 표시
                if (hasReadingRecord(year, month, day)) {
                    dayElement.classList.add('has-reading');
                    const dot = document.createElement('div');
                    dot.className = 'reading-dot';
                    dayElement.appendChild(dot);
                }
                
                // 클릭 이벤트 추가
                dayElement.addEventListener('click', () => showDayDetail(year, month, day));
                
                calendar.appendChild(dayElement);
            }
        }

        // 특정 날짜에 독서 기록이 있는지 확인
        function hasReadingRecord(year, month, day) {
            return readingRecords.some(record => {
                const recordDate = new Date(record.readingDate);
                return recordDate.getFullYear() === year && 
                       recordDate.getMonth() === month && 
                       recordDate.getDate() === day;
            });
        }

        // 독서 기록으로 달력 업데이트
        function updateCalendarWithRecords() {
            // 현재 표시된 달력 다시 생성
            generateCalendar(currentMonth, currentYear);
        }

        // 이벤트 리스너 설정
        function setupEventListeners() {
            // 월 선택 이벤트
            document.getElementById('month-selector').addEventListener('change', function() {
                currentMonth = parseInt(this.value);
                generateCalendar(currentMonth, currentYear);
            });

            // 네비게이션 메뉴 클릭
            document.querySelectorAll('.nav a').forEach(item => {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    document.querySelectorAll('.nav a').forEach(nav => nav.classList.remove('active'));
                    this.classList.add('active');
                    
                    const page = this.getAttribute('data-page');
                    navigateToPage(page);
                });
            });
        }

        // 페이지 네비게이션
        function navigateToPage(page) {
            const pageMap = {
                'tutor': contextPath + '/tutor.jsp',
                'challenge': contextPath + '/index.jsp',
                'search': contextPath + '/search.jsp', 
                'feed': contextPath + '/feed.jsp',
                'library': contextPath + '/bookshelf.jsp',
                'manage': contextPath + '/manage.jsp'
            };
            
            if (pageMap[page]) {
                window.location.href = pageMap[page];
            }
        }

        // 이벤트 핸들러 함수들
        function showLogin() {
            // 실제 로그인 페이지로 이동
            window.location.href = contextPath + '/login.jsp';
        }

        function logout() {
            // 서버에 로그아웃 요청
            fetch(contextPath + '/user/logout', {
                method: 'POST'
            })
            .then(response => {
                if (response.ok) {
                    // 로컬 스토리지 정리
                    localStorage.removeItem('currentUser');
                    // 페이지 새로고침
                    location.reload();
                } else {
                    alert('로그아웃 처리 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('로그아웃 오류:', error);
                // 에러 발생 시에도 로컬에서 정리
                localStorage.removeItem('currentUser');
                location.reload();
            });
        }

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

        function showBookSearch() {
            window.location.href = contextPath + '/book-search.jsp';
        }

        // 기타 이벤트 핸들러들
        function showAllBooks() { 
            window.location.href = contextPath + '/book-list.jsp';
        }
        function showBookshelf() { 
            window.location.href = contextPath + '/bookshelf.jsp';
        }
        function showFullCalendar() { 
            window.location.href = contextPath + '/calendar.jsp';
        }
        function showDetailedReport() { 
            window.location.href = contextPath + '/report.jsp';
        }
        function showChallenges() { 
            window.location.href = contextPath + '/challenge-list.jsp';
        }
        function showCompletedBooks() { 
            window.location.href = contextPath + '/book-list.jsp?status=completed';
        }
        function showReadingBooks() { 
            window.location.href = contextPath + '/book-list.jsp?status=reading';
        }
        function showReviews() { 
            window.location.href = contextPath + '/review-list.jsp';
        }
        function showCollections() { 
            window.location.href = contextPath + '/collection.jsp';
        }
        function showReadingClubs() { 
            window.location.href = contextPath + '/reading-club.jsp';
        }
        function showWriteDiary() { 
            window.location.href = contextPath + '/diary.jsp';
        }
    </script>
</body>
</html>
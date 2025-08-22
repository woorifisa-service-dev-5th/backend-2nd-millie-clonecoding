<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서 상세 - 일일의서재</title>
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
            text-decoration: none;
        }

        .header-actions a {
            color: #666;
            text-decoration: none;
            margin-left: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .book-detail {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }

        .book-header {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
        }

        .book-cover-large {
            width: 200px;
            height: 280px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
            text-align: center;
            padding: 20px;
            flex-shrink: 0;
        }

        .book-info {
            flex: 1;
        }

        .book-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
            line-height: 1.3;
        }

        .book-author {
            font-size: 18px;
            color: #666;
            margin-bottom: 15px;
        }

        .book-meta {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-bottom: 20px;
        }

        .meta-item {
            display: flex;
        }

        .meta-label {
            font-weight: 500;
            color: #666;
            width: 80px;
            flex-shrink: 0;
        }

        .meta-value {
            color: #333;
        }

        .book-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5a6fd8;
        }

        .btn-outline {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-outline:hover {
            background: #667eea;
            color: white;
        }

        .btn-success {
            background: #28a745;
            color: white;
        }

        .btn-warning {
            background: #ffc107;
            color: #333;
        }

        .reading-status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 15px;
        }

        .status-reading {
            background: #d4edda;
            color: #155724;
        }

        .status-completed {
            background: #cce7ff;
            color: #004085;
        }

        .status-want {
            background: #fff3cd;
            color: #856404;
        }

        .book-description {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e9ecef;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .description-text {
            line-height: 1.6;
            color: #666;
        }

        .reading-progress {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e9ecef;
        }

        .progress-bar {
            width: 100%;
            height: 12px;
            background: #e9ecef;
            border-radius: 6px;
            overflow: hidden;
            margin: 10px 0;
        }

        .progress {
            height: 100%;
            background: linear-gradient(90deg, #28a745 0%, #20c997 100%);
            transition: width 0.3s;
        }

        .progress-info {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #666;
        }

        .loading {
            text-align: center;
            padding: 60px;
            color: #666;
        }

        .error {
            text-align: center;
            padding: 60px;
            color: #dc3545;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            color: #666;
            text-decoration: none;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .back-btn:hover {
            color: #333;
        }

        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 8px;
            padding: 30px;
            width: 90%;
            max-width: 500px;
        }

        .modal-header {
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 2px solid #e9ecef;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-group textarea {
            resize: vertical;
            height: 100px;
        }

        .modal-footer {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="<%= request.getContextPath() %>/" class="logo">📚 일일의서재</a>
        <div class="header-actions">
            <a href="<%= request.getContextPath() %>/">메인</a>
            <a href="<%= request.getContextPath() %>/bookshelf.jsp">내 책장</a>
        </div>
    </div>

    <div class="container">
        <a href="javascript:history.back()" class="back-btn">← 뒤로 가기</a>

        <div class="loading" id="loading">도서 정보를 불러오는 중...</div>
        <div class="error" id="error" style="display: none;">도서 정보를 불러올 수 없습니다.</div>

        <div class="book-detail" id="bookDetail" style="display: none;">
            <!-- 도서 정보가 동적으로 생성됩니다 -->
        </div>
    </div>

    <!-- 독서 기록 추가 모달 -->
    <div class="modal" id="recordModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">독서 기록 추가</h3>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="readingDate">독서 날짜</label>
                    <input type="date" id="readingDate" required>
                </div>
                <div class="form-group">
                    <label for="pagesRead">읽은 페이지 수</label>
                    <input type="number" id="pagesRead" min="0" placeholder="예: 50">
                </div>
                <div class="form-group">
                    <label for="readingTime">독서 시간 (분)</label>
                    <input type="number" id="readingTime" min="0" placeholder="예: 60">
                </div>
                <div class="form-group">
                    <label for="notes">메모</label>
                    <textarea id="notes" placeholder="오늘의 독서 소감을 기록해보세요..."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="hideRecordModal()">취소</button>
                <button class="btn btn-primary" onclick="saveReadingRecord()">저장</button>
            </div>
        </div>
    </div>

    <!-- 상태 변경 모달 -->
    <div class="modal" id="statusModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">독서 상태 변경</h3>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="readingStatus">상태 선택</label>
                    <select id="readingStatus">
                        <option value="WANT_TO_READ">읽고 싶음</option>
                        <option value="READING">읽는 중</option>
                        <option value="COMPLETED">완독</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="hideStatusModal()">취소</button>
                <button class="btn btn-primary" onclick="updateReadingStatus()">변경</button>
            </div>
        </div>
    </div>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        let currentBook = null;
        let bookId = null;

        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            // URL에서 책 ID 가져오기
            const urlParams = new URLSearchParams(window.location.search);
            bookId = urlParams.get('id');
            
            if (bookId) {
                loadBookDetail(bookId);
            } else {
                showError('잘못된 접근입니다.');
            }

            // 오늘 날짜 기본값 설정
            document.getElementById('readingDate').value = new Date().toISOString().split('T')[0];
        });

        // 도서 상세 정보 로드
        function loadBookDetail(id) {
            fetch(contextPath + '/book/detail?id=' + id)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        currentBook = data.book;
                        renderBookDetail(data.book);
                    } else {
                        showError(data.message || '도서 정보를 불러올 수 없습니다.');
                    }
                })
                .catch(error => {
                    console.error('도서 로드 실패:', error);
                    showError('도서 정보를 불러오는 중 오류가 발생했습니다.');
                })
                .finally(() => {
                    document.getElementById('loading').style.display = 'none';
                });
        }

        // 도서 상세 정보 렌더링
        function renderBookDetail(book) {
            const detailElement = document.getElementById('bookDetail');
            
            detailElement.innerHTML = `
                <div class="book-header">
                    <div class="book-cover-large">
                        ${book.bookCover ? 
                            `<img src="${book.bookCover}" alt="${book.title}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;">` : 
                            book.title
                        }
                    </div>
                    <div class="book-info">
                        <h1 class="book-title">${book.title}</h1>
                        <p class="book-author">${book.author}</p>
                        
                        ${book.readingStatus ? `
                            <div class="reading-status status-${book.readingStatus.toLowerCase()}">
                                ${getStatusText(book.readingStatus)}
                            </div>
                        ` : ''}
                        
                        <div class="book-meta">
                            <div class="meta-item">
                                <span class="meta-label">카테고리</span>
                                <span class="meta-value">${book.category || '-'}</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-label">출판사</span>
                                <span class="meta-value">${book.publisher || '-'}</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-label">페이지</span>
                                <span class="meta-value">${book.pageCount || '-'}쪽</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-label">ISBN</span>
                                <span class="meta-value">${book.isbn || '-'}</span>
                            </div>
                        </div>
                        
                        <div class="book-actions">
                            ${book.readingStatus ? 
                                `<button class="btn btn-primary" onclick="showStatusModal()">상태 변경</button>` :
                                `<button class="btn btn-primary" onclick="addToMyBooks()">내 서재에 추가</button>`
                            }
                            <button class="btn btn-outline" onclick="showRecordModal()">독서 기록 추가</button>
                            <button class="btn btn-outline" onclick="addToBookshelf()">책장에 추가</button>
                        </div>
                    </div>
                </div>
                
                ${book.readingStatus === 'READING' ? renderReadingProgress(book) : ''}
                
                <div class="book-description">
                    <h3 class="section-title">도서 소개</h3>
                    <p class="description-text">
                        ${book.description || '이 도서에 대한 소개가 아직 등록되지 않았습니다.'}
                    </p>
                </div>
            `;
            
            detailElement.style.display = 'block';
        }

        // 독서 진행률 렌더링
        function renderReadingProgress(book) {
            const currentPage = book.currentPage || 0;
            const totalPages = book.pageCount || 1;
            const progress = Math.min((currentPage / totalPages) * 100, 100);
            
            return `
                <div class="reading-progress">
                    <h3 class="section-title">독서 진행률</h3>
                    <div class="progress-info">
                        <span>${currentPage}페이지</span>
                        <span>${Math.round(progress)}%</span>
                        <span>${totalPages}페이지</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress" style="width: ${progress}%"></div>
                    </div>
                </div>
            `;
        }

        // 상태 텍스트 변환
        function getStatusText(status) {
            const statusMap = {
                'READING': '읽는중',
                'COMPLETED': '완독',
                'WANT_TO_READ': '읽고싶음'
            };
            return statusMap[status] || '';
        }

        // 내 서재에 추가
        function addToMyBooks() {
            const formData = new FormData();
            formData.append('bookId', bookId);
            formData.append('status', 'WANT_TO_READ');

            fetch(contextPath + '/book/add-to-my-books', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('내 서재에 추가되었습니다.');
                    loadBookDetail(bookId); // 새로고침
                } else {
                    alert(data.message || '추가에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('추가 실패:', error);
                alert('추가 중 오류가 발생했습니다.');
            });
        }

        // 독서 기록 모달 표시
        function showRecordModal() {
            document.getElementById('recordModal').style.display = 'block';
        }

        // 독서 기록 모달 숨기기
        function hideRecordModal() {
            document.getElementById('recordModal').style.display = 'none';
        }

        // 상태 변경 모달 표시
        function showStatusModal() {
            document.getElementById('readingStatus').value = currentBook.readingStatus || 'WANT_TO_READ';
            document.getElementById('statusModal').style.display = 'block';
        }

        // 상태 변경 모달 숨기기
        function hideStatusModal() {
            document.getElementById('statusModal').style.display = 'none';
        }

        // 독서 기록 저장
        function saveReadingRecord() {
            const formData = new FormData();
            formData.append('bookId', bookId);
            formData.append('readingDate', document.getElementById('readingDate').value);
            formData.append('pagesRead', document.getElementById('pagesRead').value || 0);
            formData.append('readingTime', document.getElementById('readingTime').value || 0);
            formData.append('notes', document.getElementById('notes').value || '');

            fetch(contextPath + '/reading-record/add', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    hideRecordModal();
                    alert('독서 기록이 저장되었습니다.');
                    // 폼 초기화
                    document.getElementById('pagesRead').value = '';
                    document.getElementById('readingTime').value = '';
                    document.getElementById('notes').value = '';
                } else {
                    alert(data.message || '저장에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('저장 실패:', error);
                alert('저장 중 오류가 발생했습니다.');
            });
        }

        // 독서 상태 업데이트
        function updateReadingStatus() {
            const status = document.getElementById('readingStatus').value;
            const formData = new FormData();
            formData.append('bookId', bookId);
            formData.append('status', status);

            fetch(contextPath + '/book/update-status', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    hideStatusModal();
                    alert('상태가 변경되었습니다.');
                    loadBookDetail(bookId); // 새로고침
                } else {
                    alert(data.message || '변경에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('변경 실패:', error);
                alert('변경 중 오류가 발생했습니다.');
            });
        }

        // 책장에 추가
        function addToBookshelf() {
            // TODO: 책장 선택 모달 구현
            alert('책장 추가 기능은 준비 중입니다.');
        }

        // 에러 표시
        function showError(message) {
            document.getElementById('error').textContent = message;
            document.getElementById('error').style.display = 'block';
        }
    </script>
</body>
</html>
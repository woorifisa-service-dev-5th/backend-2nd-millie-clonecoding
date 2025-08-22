<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 책장 - 일일의서재</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .page-subtitle {
            color: #666;
            font-size: 14px;
        }

        .bookshelf-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .shelf-tabs {
            display: flex;
            gap: 30px;
        }

        .shelf-tab {
            padding: 10px 0;
            cursor: pointer;
            color: #666;
            border-bottom: 2px solid transparent;
            font-weight: 500;
        }

        .shelf-tab.active {
            color: #333;
            border-bottom-color: #667eea;
        }

        .create-shelf-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        .create-shelf-btn:hover {
            background: #5a6fd8;
        }

        .bookshelves-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .bookshelf-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .bookshelf-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }

        .bookshelf-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .bookshelf-name {
            font-size: 18px;
            font-weight: 600;
        }

        .bookshelf-menu {
            color: #666;
            cursor: pointer;
            padding: 5px;
        }

        .bookshelf-stats {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .bookshelf-preview {
            display: flex;
            gap: 8px;
            overflow-x: auto;
        }

        .book-preview {
            flex-shrink: 0;
            width: 60px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 10px;
            text-align: center;
            padding: 4px;
        }

        .book-preview.empty {
            background: #e9ecef;
            color: #666;
            border: 2px dashed #ccc;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 16px;
        }

        .loading {
            text-align: center;
            padding: 40px;
            color: #666;
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
            max-width: 400px;
        }

        .modal-header {
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 600;
        }

        .modal-body input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 6px;
            font-size: 14px;
        }

        .modal-footer {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-primary {
            background: #667eea;
            color: white;
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
            <a href="<%= request.getContextPath() %>/user/logout">로그아웃</a>
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">내 책장</h1>
            <p class="page-subtitle">나만의 도서 컬렉션을 관리하세요</p>
        </div>

        <div class="bookshelf-controls">
            <div class="shelf-tabs">
                <div class="shelf-tab active" data-type="my">내 책장</div>
                <div class="shelf-tab" data-type="category">카테고리별</div>
                <div class="shelf-tab" data-type="public">공개 책장</div>
            </div>
            <button class="create-shelf-btn" onclick="showCreateModal()">+ 새 책장 만들기</button>
        </div>

        <div class="loading" id="loading">책장을 불러오는 중...</div>
        
        <div class="bookshelves-grid" id="bookshelvesGrid" style="display: none;">
            <!-- 책장들이 동적으로 생성됩니다 -->
        </div>

        <div class="empty-state" id="emptyState" style="display: none;">
            <div class="empty-state-icon">📚</div>
            <h3>아직 책장이 없습니다</h3>
            <p>첫 번째 책장을 만들어보세요!</p>
            <button class="create-shelf-btn" onclick="showCreateModal()" style="margin-top: 15px;">+ 책장 만들기</button>
        </div>
    </div>

    <!-- 책장 생성 모달 -->
    <div class="modal" id="createModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">새 책장 만들기</h3>
            </div>
            <div class="modal-body">
                <input type="text" id="shelfNameInput" placeholder="책장 이름을 입력하세요" maxlength="45">
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="hideCreateModal()">취소</button>
                <button class="btn btn-primary" onclick="createBookshelf()">만들기</button>
            </div>
        </div>
    </div>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        let currentType = 'my';
        let bookshelves = [];

        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            loadBookshelves();
            setupEventListeners();
        });

        // 이벤트 리스너 설정
        function setupEventListeners() {
            // 탭 클릭
            document.querySelectorAll('.shelf-tab').forEach(tab => {
                tab.addEventListener('click', function() {
                    document.querySelectorAll('.shelf-tab').forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    currentType = this.getAttribute('data-type');
                    loadBookshelves();
                });
            });

            // 모달 외부 클릭시 닫기
            document.getElementById('createModal').addEventListener('click', function(e) {
                if (e.target === this) {
                    hideCreateModal();
                }
            });
        }

        // 책장 목록 로드
        function loadBookshelves() {
            document.getElementById('loading').style.display = 'block';
            document.getElementById('bookshelvesGrid').style.display = 'none';
            document.getElementById('emptyState').style.display = 'none';

            fetch(contextPath + '/bookshelf/list?type=' + currentType)
                .then(response => response.json())
                .then(data => {
                    bookshelves = data;
                    renderBookshelves(data);
                })
                .catch(error => {
                    console.error('책장 로드 실패:', error);
                    showEmptyState();
                })
                .finally(() => {
                    document.getElementById('loading').style.display = 'none';
                });
        }

        // 책장 목록 렌더링
        function renderBookshelves(shelves) {
            const grid = document.getElementById('bookshelvesGrid');
            
            if (shelves.length === 0) {
                showEmptyState();
                return;
            }

            grid.innerHTML = shelves.map(shelf => `
                <div class="bookshelf-card" onclick="openBookshelf(${shelf.id})">
                    <div class="bookshelf-header">
                        <h3 class="bookshelf-name">${shelf.name}</h3>
                        <span class="bookshelf-menu" onclick="event.stopPropagation(); showShelfMenu(${shelf.id})">⋮</span>
                    </div>
                    <div class="bookshelf-stats">
                        ${shelf.bookCount}권의 도서
                    </div>
                    <div class="bookshelf-preview">
                        ${generateBookPreviews(shelf)}
                    </div>
                </div>
            `).join('');

            grid.style.display = 'grid';
        }

        // 책 미리보기 생성
        function generateBookPreviews(shelf) {
            let previews = '';
            const maxPreviews = 4;
            
            if (shelf.books && shelf.books.length > 0) {
                for (let i = 0; i < Math.min(shelf.books.length, maxPreviews); i++) {
                    const book = shelf.books[i];
                    previews += `<div class="book-preview">${book.title}</div>`;
                }
            }
            
            // 빈 슬롯 추가
            for (let i = shelf.bookCount; i < maxPreviews; i++) {
                previews += `<div class="book-preview empty">+</div>`;
            }
            
            return previews;
        }

        // 빈 상태 표시
        function showEmptyState() {
            document.getElementById('emptyState').style.display = 'block';
            document.getElementById('bookshelvesGrid').style.display = 'none';
        }

        // 책장 생성 모달 표시
        function showCreateModal() {
            document.getElementById('createModal').style.display = 'block';
            document.getElementById('shelfNameInput').focus();
        }

        // 책장 생성 모달 숨기기
        function hideCreateModal() {
            document.getElementById('createModal').style.display = 'none';
            document.getElementById('shelfNameInput').value = '';
        }

        // 책장 생성
        function createBookshelf() {
            const name = document.getElementById('shelfNameInput').value.trim();
            
            if (!name) {
                alert('책장 이름을 입력해주세요.');
                return;
            }

            const formData = new FormData();
            formData.append('name', name);

            fetch(contextPath + '/bookshelf/create', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    hideCreateModal();
                    loadBookshelves(); // 목록 새로고침
                    alert('책장이 생성되었습니다.');
                } else {
                    alert(data.message || '책장 생성에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('책장 생성 실패:', error);
                alert('책장 생성 중 오류가 발생했습니다.');
            });
        }

        // 책장 열기
        function openBookshelf(shelfId) {
            window.location.href = contextPath + '/bookshelf-detail.jsp?id=' + shelfId;
        }

        // 책장 메뉴 표시
        function showShelfMenu(shelfId) {
            // TODO: 책장 편집/삭제 메뉴 구현
            console.log('책장 메뉴:', shelfId);
        }

        // Enter 키로 책장 생성
        document.getElementById('shelfNameInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                createBookshelf();
            }
        });
    </script>
</body>
</html>
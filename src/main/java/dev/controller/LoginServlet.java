package dev.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dev.dao.UserDAO; // DB 접근을 위한 DAO 클래스를 import
import dev.model.User; // User 모델 클래스를 import

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		// 1. 폼에서 전송된 데이터 받기
		String loginId = request.getParameter("nickname"); // name="nickname"과 일치
		String loginPw = request.getParameter("password"); // name="password"와 일치
		
//		System.out.println("닉네임은 "+loginId);
//		System.out.println("비번은 "+loginPw);

		// 2. DAO를 통해 DB와 통신
		UserDAO userDAO = new UserDAO();
		User user = null; // user 변수 초기화

		try {
			user = userDAO.authenticateUser(loginId, loginPw);
//			System.out.println(user);
		} catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "데이터베이스 오류가 발생했습니다.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

		// 3. 로그인 결과에 따라 페이지 이동
		if (user != null) {
			// 1. 기존 세션 무효화: 이전에 만들어졌을 수 있는 세션 ID를 파기
		    HttpSession oldSession = request.getSession(false);
		    if (oldSession != null) {
		        oldSession.invalidate();
		    }

		    // 2. 새로운 세션 생성: 새로운 세션 ID를 발급받음
		    HttpSession newSession = request.getSession(true);
		    
		    // 3. 새 세션에 사용자 정보 저장
		    newSession.setAttribute("loggedInUser", user);
			
			// 캐시를 비활성화하는 HTTP 헤더 설정
	        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	        response.setHeader("Pragma", "no-cache");
	        response.setDateHeader("Expires", 0);
	        
	        // 로그인 된 상태로, 메인 페이지로 이동하기
			response.sendRedirect(request.getContextPath() + "/main.jsp");
		} else {
			// 로그인 실패 시: 오류 메시지를 request에 담아 다시 로그인 페이지로 포워드
			request.setAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}
}
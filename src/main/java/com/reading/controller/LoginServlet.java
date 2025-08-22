package com.reading.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.reading.dao.UserDAO;
import com.reading.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String loginId = request.getParameter("nickname");
        String loginPw = request.getParameter("password");
        
        System.out.println("로그인 시도 - 닉네임: " + loginId);  // 디버깅용
        
        UserDAO userDAO = new UserDAO();
        User user = null;
        
        try {
            user = userDAO.authenticateUser(loginId, loginPw);
            System.out.println("로그인 결과: " + (user != null ? "성공" : "실패"));  // 디버깅용
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "데이터베이스 오류가 발생했습니다.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        if (user != null) {
            // 로그인 성공
            request.getSession().setAttribute("loggedInUser", user);
            System.out.println("세션 저장 완료, index.jsp로 이동");  // 디버깅용
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // 로그인 실패
            System.out.println("로그인 실패 - 에러 메시지 전달");  // 디버깅용
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
package com.reading.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 세션 무효화
        HttpSession session = request.getSession();
        session.invalidate();
        
        // 로그인 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
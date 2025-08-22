package dev.syntax.controller;

import dev.syntax.model.UserBookModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddUserBookServlet")
public class AddUserBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        // 예시: 로그인 사용자 ID
        int userId = 3;

        UserBookModel model = new UserBookModel();
        try {
            boolean success = model.addUserBook(userId, bookId);
            if (success) {
                request.setAttribute("msg", "책이 성공적으로 추가되었습니다!");
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                request.setAttribute("msg", "이미 추가된 책입니다!");
                request.getRequestDispatcher("/bookList.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "DB 오류 발생!");
        }

    }
}

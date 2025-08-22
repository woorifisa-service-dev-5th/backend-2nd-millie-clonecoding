// src/main/java/dev/web/AuthFilter.java
package dev.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/main.jsp") // ← main.jsp 한정 보호
public class AuthFilter implements Filter {

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
      throws IOException, ServletException {

    HttpServletRequest req  = (HttpServletRequest) request;
    HttpServletResponse resp = (HttpServletResponse) response;

    // 뒤로가기로 과거 화면이 보이지 않도록 캐시 금지
    resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    resp.setHeader("Pragma", "no-cache");
    resp.setDateHeader("Expires", 0);

    // 세션에서 로그인 사용자 확인
    HttpSession session = req.getSession(false);
    Object user = (session == null) ? null : session.getAttribute("loggedInUser");

    if (user == null) {
      // 비로그인 → 로그인 페이지로
      resp.sendRedirect(req.getContextPath() + "/login.jsp");
      return;
    }

    // 통과 (로그인 상태)
    chain.doFilter(request, response);
  }
}

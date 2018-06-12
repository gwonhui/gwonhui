<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String keepLogin = request.getParameter("keepLogin");
System.out.println("id=" + id + ", keepLogin=" + keepLogin);

if (id != null && keepLogin != null) {
	// 쿠키처리
	if (keepLogin.equals("yes")) {
	    // 쿠키생성
	    Cookie idCookie = new Cookie("id", id);
	    idCookie.setMaxAge(60*60*24*14); // 2주일간 로그인 상태 유지
	    response.addCookie(idCookie);
	    System.out.println("id쿠키생성");
	    
	} else if (keepLogin.equals("no")) {
	    // 쿠키 id값 확인
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie c : cookies) {
	             if (c.getName().equals("id")) {
	                System.out.println("쿠키 삭제 " + c.getValue());
	                c.setMaxAge(0);
	                response.addCookie(c);
	             }
	        }
	    }
	}
} 
	//

	response.sendRedirect("main/main.jsp");
%>
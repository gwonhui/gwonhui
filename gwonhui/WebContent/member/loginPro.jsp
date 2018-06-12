<%@page import="dao.VisitDao"%>
<%@page import="dao.My_MemberDao"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 폼 id passwd 가져오기
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String keepLogin = request.getParameter("keepLogin");
	
	// DB객체 생성
	My_MemberDao dao = My_MemberDao.getInstance();
	int check = dao.userCheck(id, passwd);
	
	// check == 1 로그인인증  main.jsp이동
	// check == 0 패스워드틀림 뒤로이동
	// check == -1 아이디없음  뒤로이동
	if (check == 1) {
		session.setAttribute("id", id);
		session.setAttribute("bindListener", new VisitDao());
		response.sendRedirect("../index.jsp?id=" + id + "&keepLogin=" + keepLogin);
	} else if (check == 0) {
		%>
		<script>
			alert('패스워드 틀림');
			history.back();
		</script>
		<%
	} else {
		%>
		<script>
			alert('해당 아이디 없음');
			//location.href = 'loginForm.jsp';
			history.back(); // 브라우저 뒤로가기버튼
		</script>
		<%
	}
%>







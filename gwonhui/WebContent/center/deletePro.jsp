<%@page import="dao.MyBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// int num  String pageNum  String passwd 파라미터값 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String passwd  = request.getParameter("passwd");
	
	// DB객체생성 boarddao
	MyBoardDao  dao = MyBoardDao.getInstance();
	// int check = 메소드호출  deleteBoard(num, passwd)
	int check = dao.deleteBoard(num, passwd);
	// check == 1  이동 list.jsp?pageNum=
	// check == 0 "패스워드틀림"  뒤로이동
	if (check == 1) {
		response.sendRedirect("notice.jsp?pageNum=" + pageNum);
		%>
		<script>
		alert('글삭제 성공');
		location.href = 'notice.jsp?pageNum=<%=pageNum%>';
		</script>
		<%
	} else {
		%>
		<script>
			alert('패스워드틀림');
			history.back();
		</script>
		<%
	}
%>









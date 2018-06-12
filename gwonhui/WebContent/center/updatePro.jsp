<%@page import="dao.MyBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// post 전송값 한글처리
	request.setCharacterEncoding("utf-8");

	// pageNum 파라미터 가져오기
	String pageNum = request.getParameter("pageNum");
	
	// 액션태그 자바빈객체생성 boardbean
	// 폼 => 자바빈 저장
%>
<jsp:useBean id="boardbean" class="domain.MyBoard"/>
<jsp:setProperty property="*" name="boardbean"/>
<%
	// DB객체 생성
	MyBoardDao  dao = MyBoardDao.getInstance();
	// 메소드호출  updateBoard(boardbean)
	int check = dao.updateBoard(boardbean);
	// check == 1  수정성공  list.jsp?pageNum=
	// check == 0 "패스워드틀림" 뒤로이동
	if (check == 1) {
		response.sendRedirect("notice.jsp?pageNum=" + pageNum);
	} else {
		%>
		<script>
			alert('패스워드틀림');
			history.back();
		</script>
		<%
	}
%>









<%@page import="dao.My_MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 loginForm.jsp이동
	if (id == null) {
		response.sendRedirect("loginForm.jsp");
		return;
	}
	
	// post 한글처리
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="memberBean" class="domain.My_Member"/>
<jsp:setProperty property="*" name="memberBean"/>
<%
	// Dao 객체생성
	My_MemberDao dao = My_MemberDao.getInstance();
	int check = dao.updateMember(memberBean);
	// check == 1  수정성공  main.jsp이동
	// check == 0 패스워드틀림  뒤로이동
	if (check == 1) {
		%>
		<script>
			alert('수정성공');
			location.href='../main/main.jsp';
		</script>
		<%
	} else {
		%>
		<script>
			alert('패스워드 틀림');
			history.back(); // 뒤로가기    forward() 앞으로가기
		</script>
		<%
	}
%>














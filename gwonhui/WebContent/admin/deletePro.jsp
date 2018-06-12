<%@page import="dao.My_MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
// 세션값 가져오기
String id = (String) session.getAttribute("id");
// 세션값 없으면 login.jsp이동
if (!id.equals("admin")) {
	%>
	<script>
	alert('권한이없습니다.');
	</script>
	<%
	response.sendRedirect("../main/main.jsp");
	return;
}


String[] deleteIds = request.getParameterValues("deleteId");

//Dao객체 생성
	My_MemberDao dao = My_MemberDao.getInstance();
	
	dao.deleteMembers(deleteIds);
		%>
		<script>
			alert('삭제 성공');
			history.back();
		</script>

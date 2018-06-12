<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	// 세션 초기화
	 String id = (String) session.getAttribute("id");
	
	session.invalidate();
	
	// "로그아웃"  index.jsp이동
%>
<script>
	alert('로그아웃 되었습니다.');
	location.href = '../index.jsp?id=<%=id %>&keepLogin=no';
</script>
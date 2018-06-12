<%@page import="dao.CommentDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); // 한글처리 %>
<%-- 액션태그이용 자바빈 객체생성. setProperty이용 저장 --%>
<jsp:useBean id="boardBean" class="domain.Comment" />
<jsp:setProperty property="*" name="boardBean"/>
<%
	String id = (String )session.getAttribute("id");
	// reg_date id set메소드  값저장
	
	boardBean.setComment_date(new Timestamp(System.currentTimeMillis()));
	boardBean.setComment_id(id);
	// 댓글 Dao 객체생성
	CommentDao dao = CommentDao.getInstance();
	// 메소드호출   insertCommend(boardBean)
	dao.insertCommend(boardBean);
	// 이전으로 이동.
	response.sendRedirect("profile.jsp");
%>
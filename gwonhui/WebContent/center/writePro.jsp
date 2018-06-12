<%@page import="dao.MyBoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); // 한글처리 %>
<%-- 액션태그이용 자바빈 객체생성. setProperty이용 저장 --%>
<jsp:useBean id="boardBean" class="domain.MyBoard" />
<jsp:setProperty property="*" name="boardBean"/>
<%
	// reg_date ip id set메소드  값저장
	boardBean.setReg_date(new Timestamp(System.currentTimeMillis()));
	boardBean.setIp(request.getRemoteAddr());
	boardBean.setReadcount(0); // 조회수 0으로 초기화
	
	// 게시판 Dao 객체생성
	MyBoardDao dao = MyBoardDao.getInstance();
	// 메소드호출   insertBoard(boardBean)
	dao.insertBoard(boardBean);
	// 이동   글목록 notice.jsp
	response.sendRedirect("notice.jsp");
%>
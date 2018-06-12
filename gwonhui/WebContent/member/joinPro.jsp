<%@page import="dao.My_MemberDao"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// post 한글처리
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="memberBean" class="domain.My_Member"/>
<jsp:setProperty property="*" name="memberBean"/>
<%
	// 날짜 생성
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	memberBean.setReg_date(reg_date);
	
	// DB접속용 Dao객체 생성
	My_MemberDao dao = My_MemberDao.getInstance();
	dao.insertMember(memberBean);
	
	// 이동 login.jsp
// 	response.sendRedirect("login.jsp");
	
	String result = "joinSuccess";
	response.sendRedirect("login.jsp?result=" + result);
%>










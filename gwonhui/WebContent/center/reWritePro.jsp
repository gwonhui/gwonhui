<%@page import="dao.MyBoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글처리
	request.setCharacterEncoding("utf-8");
	// pageNum 파라미터값 가져오기
	String pageNum = request.getParameter("pageNum");
	// 액션태그 자바빈 객체생성 boardbean
	// 액션태그 setProperty  폼=> 자바빈 저장
%>
<jsp:useBean id="boardBean" class="domain.MyBoard"/>
<jsp:setProperty property="*" name="boardBean"/>
<%
	//reg_date  ip  set메소드  값저장
	boardBean.setReg_date(new Timestamp(System.currentTimeMillis()));
	boardBean.setIp(request.getRemoteAddr());
	boardBean.setReadcount(0); // 조회수 0으로 초기화
	
	// DB객체생성
	MyBoardDao dao = MyBoardDao.getInstance();
	// 메소드호출    reInsertBoard(boardBean)
	dao.reInsertBoard(boardBean);
	// 이동 list.jsp
	response.sendRedirect("notice.jsp?pageNum=" + pageNum);
%>











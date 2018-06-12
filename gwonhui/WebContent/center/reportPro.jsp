<%@page import="domain.ReportBoard"%>
<%@page import="org.apache.commons.mail.EmailException"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="dao.ReportBoardDao"%>
<%@page import="domain.MyBoard"%>
<%@page import="dao.MyBoardDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 login.jsp이동
	if (id == null) {
		response.sendRedirect("../member/login.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글처리 
%>
<%
	// 업로드
	// 외부 라이브러리 설치  http://www.servlets.com
	// com.oreilly.servlet  =>  cos-...zip 파일 다운
	// WebContent -> WEB-INF -> lib -> cos.jar
	
	// 업로드 기능 객체생성 - MultipartRequest
	// 1. request
	// 2. 업로드할 폴더의 물리적 경로
	// WebContent => upload 폴더 만들기
	String realPath = application.getRealPath("/reportUpload");
	System.out.println(realPath);
	
	// 3. 최대파일크기.  바이트단위.
	int maxSize = 1024 * 1024 * 5;     // 5MB
	// 4. 파일명 한글처리   utf-8
	// 5. 파일명이 동일할 경우 이름변경  DefaultFileRenamePolicy()
	
	
	// 멀티파트리퀘스트 객체를 생성하면 그즉시 업로드가 수행됨.
	MultipartRequest multi 
		= new MultipartRequest(request, 
							   realPath, 
							   maxSize, 
							   "utf-8", 
							   new DefaultFileRenamePolicy());
	
	// DB객체생성
	ReportBoardDao dao = ReportBoardDao.getInstance();
	ReportBoard bean = new ReportBoard();
	// 폼 파라미터값 => 자바빈 저장
	bean.setName(multi.getParameter("name"));
	bean.setReason(multi.getParameter("reason"));
	bean.setSubject(multi.getParameter("subject"));
	bean.setContent(multi.getParameter("content"));
	
	// 파일이름 => 자바빈 저장
	// 원래 파일이름
	System.out.println("원래파일이름: " + multi.getOriginalFileName("filename"));
	// 시스템에 올린 파일이름
	System.out.println("시스템에 올린 파일이름: " + multi.getFilesystemName("filename"));
	bean.setFilename(multi.getFilesystemName("filename"));
	
	// reg_date  ip  set메소드  값저장
	bean.setReg_date(new Timestamp(System.currentTimeMillis()));
	bean.setIp(request.getRemoteAddr());
	bean.setReadcount(0); // 조회수 0으로 초기화
	
	
	// 메소드호출  insertReport();
	dao.insertReport(bean);
	//이메일로 보내기
	dao.sendEmail(bean);
	// 이동 글목록 fnotice.jsp
	response.sendRedirect("../center/fnotice.jsp");
	
%>




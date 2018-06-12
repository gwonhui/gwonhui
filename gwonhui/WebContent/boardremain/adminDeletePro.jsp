<%@page import="domain.MyBoard"%>
<%@page import="dao.My_MemberDao"%>
<%@page import="dao.MyBoardDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// int num  String pageNum  파라미터값 가져오기
	Integer num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// DB객체생성 boarddao
	MyBoardDao dao = MyBoardDao.getInstance();
	//DB에서 글삭제 정보 가져오기
	MyBoard board = dao.getBoard(num);
	//글삭제
	dao.deleteBoard(num); 
	
	
	if (board.getFilename() != null) {
		String realPath = application.getRealPath("/upload");
		System.out.println("realPath : " + realPath);
		String filename = board.getFilename();
		
		File file =new File(realPath, filename);
		if(file.exists()){
			file.delete();
		}
	}
	
	response.sendRedirect("../admin/board.jsp?pageNum=" + pageNum);
%>








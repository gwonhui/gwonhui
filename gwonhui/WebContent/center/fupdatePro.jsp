<%@page import="dao.My_MemberDao"%>
<%@page import="dao.MyBoardDao"%>
<%@page import="domain.MyBoard"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realPath= application.getRealPath("/upload");
	int maxSize = 1024 *1024 * 5; // 5MB
	//업로드 수행
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8" , new DefaultFileRenamePolicy());
	//자바빈 객체 생성
	MyBoard board = new MyBoard();
	//폼 정보를 자바빈에 저장
	board.setNum(Integer.parseInt(multi.getParameter("num")));
	board .setName(multi.getParameter("name"));
	board .setPasswd(multi.getParameter("passwd"));
	board .setContent(multi.getParameter("content"));
	board .setSubject(multi.getParameter("subject"));
	//파일
	if(multi.getFilesystemName("filename") != null){
		//새롭게 수정할 파일 있음.
		board.setFilename(multi.getFilesystemName("filename"));
		//이전파일 삭제.
			String targetFile = multi.getParameter("oldfilename");
			
			File file = new File(realPath, targetFile);
			if(file.exists()){
				file.delete();
		}
	}else{
		// 새롭게 수정할 파일 없음. so 기본파일 이름으로 업데이트에 반영.
		board.setFilename(multi.getParameter("oldfilename"));
		
	}
	String pageNum = multi.getParameter("pageNum");
%>
<%
	// DB객체 생성
	MyBoardDao dao = MyBoardDao.getInstance();
	// 메소드호출  updateBoard(boardbean)
	int check = dao.updateBoard(board);
	// check == 1  수정성공  list.jsp?pageNum=
	// check == 0 "패스워드틀림" 뒤로이동
	if (check == 1) {
		response.sendRedirect("fnotice.jsp?pageNum=" + pageNum);
	} else {
		%>
		<script>
			alert('패스워드틀림');
			history.back();
		</script>
		<%
	}
%>









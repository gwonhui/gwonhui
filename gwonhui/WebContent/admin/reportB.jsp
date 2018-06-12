<%@page import="domain.ReportBoard"%>
<%@page import="dao.ReportBoardDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gwon's Homepage</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../admin/admin.jsp">관리자 메뉴</a></li>
<li><a href="../admin/list.jsp">회원목록</a></li>
<li><a href="../admin/board.jsp">게시판관리</a></li>
<li><a href="../admin/reportB.jsp">신고게시판관리</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
// DB객체 생성
ReportBoardDao dao =ReportBoardDao.getInstance();
// 전체글개수 가져오기 메소드 호출
int totalRowCount = dao.getBoardCount();

// 우리가 원하는 페이지 글 가져오기
// 한페이지 당 보여줄 글 개수!!
int pageSize = 50;
// 클라이언트가 전송하는 페이지번호를 기준으로
// 가져올 글의 시작행번호와 종료행번호를 계산하면 됨.
String strPageNum = request.getParameter("pageNum");
if (strPageNum == null || strPageNum.equals("")) {
	strPageNum = "1";
}
int pageNum = Integer.parseInt(strPageNum); // 페이지번호

// 시작행번호 구하기 공식
int startRow = (pageNum-1)*pageSize + 1;
// 종료행번호 구하기 공식
int endRow = pageNum * pageSize;
// 원하는 페이지의 글을 가져오는 메소드
List<ReportBoard> list = null;
if (totalRowCount > 0) {
	list = dao.getBoards(startRow, endRow);
}
// 날짜포맷
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd"); // yyyy-MM-dd   yyyy/MM/dd
%>
<article>
<h1>신고 게시판 [전체글개수: <%=totalRowCount %>]</h1>
<table id="notice">
<tr><th class="tno">번호</th>
    <th class="ttitle">내용</th>
    <th class="twrite">신고이유</th>
    <th class="tdate">신고자</th>
<%
if (totalRowCount > 0) {
	for (ReportBoard board : list) {
		%>
		<tr onclick="location.href='../admin/reportCont.jsp?num=<%=board.getNum() %>&pageNum=<%=pageNum%>'">
			<td><%=board.getNum() %></td>
			<td><%=board.getContent() %></td>
			<td><%=board.getReason()%></td>
			<td><%=board.getName() %></td>
			
		</tr>
		<%
	}
} else {
	%>
	<tr><td colspan="5">게시판 글 없음</td></tr>
	<%
}
%>
</table>

<%
// 세션 가져오기
String id = (String) session.getAttribute("id");
// 세션값이 있으면 글쓰기 버튼이 보이게 설정
if (id == null || !id.equals("admin")) {
		%>
		<script>alert('권한이없습니다.');</script>
		<%
		response.sendRedirect("../main/main.jsp");
	}

	%>
	<div id="table_search">
		<input type="button" value="관리자 메뉴" class="btn" onclick ="location.href='../admin/admin.jsp'">
	</div>

<div id="table_search">
<form action="noticeSearch.jsp">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
if (totalRowCount > 0) {
	// 전체 페이지블록 갯수 구하기
	// 글갯수50개, 한화면보여줄글10개 => 50/10 = 몫5 + 나머지0 = 페이지블록5개
	// 글갯수52개, 한화면보여줄글10개 => 52/10 = 몫5 + 나머지2 = (+1)페이지블록6개
	int pageCount = totalRowCount/pageSize + (totalRowCount%pageSize==0 ? 0 : 1);
	
	// 한 화면에 보여줄 페이지블록 갯수 설정
	int pageBlock = 3;
	
	// 화면에 보여줄 "페이지블록 범위내의 시작번호" 구하기
	// 1~10  11~20  21~30
	// 1~10 => 1     11~20 => 11
	int startPage = (pageNum/pageBlock - (pageNum%pageBlock==0 ? 1 : 0)) * pageBlock + 1;
	
	// 화면에 보여줄 "페이지블록 범위내의 끝번호" 구하기
	int endPage = startPage + pageBlock - 1;
	if (endPage > pageCount) {
		endPage = pageCount;
	}
	
	// [이전]
	if (startPage > pageBlock) {
		%>
		<a href="../admin/reportB.jsp?pageNum=<%=startPage-pageBlock %>">Prev</a>
		<%
	}
	
	// 1~10 페이지블록 범위 출력
	for (int i=startPage; i<=endPage; i++) {
		%><a href="../admin/reportB.jsp?pageNum=<%=i %>"><%
		if (i == pageNum) {
			%> <b><%=i %></b> <%
		} else {
			%> <%=i %> <%
		}
		%></a><%
	}
	
	// [다음]
	if (endPage < pageCount) {
		%>
		<a href="../admin/reportB.jsp?pageNum=<%=startPage+pageBlock %>">Next</a>
		<%
	}
}
%>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<%@include file="../inc/bottom.html" %>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommentDao"%>
<%@page import="domain.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gwon's Homepage</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.2.1.min.js"></script>
<script>
		
</script>
<%
	// DB객체 생성
	CommentDao dao = CommentDao.getInstance();
	// 전체글개수 가져오기 메소드 호출
	int totalRowCount = dao.getCommendCount();

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
	int startRow = (pageNum - 1) * pageSize + 1;
	// 종료행번호 구하기 공식
	int endRow = pageNum * pageSize;

	// 원하는 페이지의 글을 가져오는 메소드
	List<Comment> list = null;
	if (totalRowCount > 0) {
		list = dao.getCommend(startRow, endRow);
	}
	// 날짜포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd"); // yyyy-MM-dd   yyyy/MM/dd
%>
</head>
<body>
	<div id="wrap">
		<!-- 헤더가 들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더가 들어가는 곳 -->

		<!-- 본문 들어가는 곳 -->
		<!-- 서브페이지 메인이미지 -->
		<div id="sub_img"></div>
		<!-- 서브페이지 메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="../profile/profile.jsp">연적</a></li>
				<li><a href="#">프로필</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 내용 -->
		<article>

			<h1>이권희란 사람은?</h1>
			<p>1990년 8월 14일 출생(음력)</p>
			<img src=".." width="196" height="226" class="photo"> <br>
			<pre>
-2006년 3월 공군기술고등학교 진학실패후 거제옥포고등학교 진학
-2009년 3월 거제옥포고등학교 졸업
-2009년 3월 거제대학교 입학
-2009년 7월 휴학후 입대
-2011년 5월 전역
-2013년 스펙을 위해 부산으로 독립
-2015년 7월 거제대학교 졸업 후 삼성중공업 입사
-2016년 6월 삼성중공업 퇴사 후 부산으로 거주지 이동
-2017년 11월 부산IT전문학교 입학
-
</pre>
			----------------------------------------------------------------------------------------------------------------------
		</article>
		<article id="reply">

			<!-- 댓글 부분 -->
			<!-- 댓글 부분 -->
			<h2 id="header">방명록</h2>
			<table id="notice">
				<tr>
					<th class="tno">이름</th>
					<th class="tcontent">내용</th>
					<th class="tdate">날짜</th>
				<tr>
					<%%>
					<%
						if (totalRowCount > 0) {
							for (Comment board : list) {
								Timestamp timestamp = board.getComment_date();
								Date date = new Date(timestamp.getTime());
					%>
					<td><%=board.getComment_id()%></td>

					<td><%=board.getComment_content()%></td>
					<td><%=sdf.format(date)%></td>
				</tr>
				<%
					}
					} else {
				%>
				<tr>
					<td colspan="4">댓글없음</td>
				</tr>
				<%
					}
				%>

			</table>
			<nav>
				<form action="../profile/commentPro.jsp" method="post" name ="comment" >
					<table border="1">
						<tr>

						</tr>
						<tr>
							<th><textarea rows="4" cols="72" name="comment_content"></textarea></th>
							<th><input type="submit" value="등록"></th>
						</tr>
					</table>
				</form>
				<!-- 댓글 끝 -->
				<!-- 내용 -->
				<!-- 본문 들어가는 곳 -->
			</nav>
		</article>
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<%@include file="../inc/bottom.html"%>
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>
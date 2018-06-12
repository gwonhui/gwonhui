<%@page import="dao.VisitDao"%>
<%@page import="dao.MyBoardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.MyBoard"%>
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
 <%
// 세션값 가져오기
String id = (String) session.getAttribute("id");
// 세션값 없으면 login.jsp이동
	if (id == null || !id.equals("admin")  ) {
		%>
		<script>alert('권한이없습니다.');</script>
		<%
		response.sendRedirect("../main/main.jsp");
	}

	
%>

</head>
<script>

</script>

<body>
<div id="wrap1">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->
<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
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
<!-- 본문내용 -->
<article>
<h1>관리자 메뉴</h1>
<form>
	<a href="../admin/list.jsp" class="admin">회원관리</a><br> 
	<a href="../admin/board.jsp" class="admin">게시판관리</a><br>
	<a href="../admin/reportB.jsp" class="admin">신고게시판관리</a><br>
<!-- 신고게시판. -->

<!-- 신고게시판. -->
	회원성비<br>
	<jsp:include page="../admin/genderGraph.jsp" />
	총방문자수 : 	<%= new VisitDao().getAccessCount().get("totalCount") %><br>
	현재 방문자 수 : <%=new VisitDao().getAccessCount().get("accessCount") %><br>
	
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<%@include file="../inc/bottom.html" %>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
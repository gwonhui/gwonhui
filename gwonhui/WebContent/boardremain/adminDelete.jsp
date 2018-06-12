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
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 login.jsp이동
	if (id == null|| !id.equals("admin")) {
		response.sendRedirect("../member/login.jsp");
		return;
	}
	// num pageNum 파라미터 가져오기
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	
%>
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
<article>
<h1>제보 게시판</h1>


<form action="../boardremain/adminDeletePro.jsp?num=<%=num %>&pageNum=<%=pageNum %>" method="post" name="frm" enctype="multipart/form-data">
<input type="hidden" name = "num" value="<%=num %>">
<table id="notice">
<tr><th>정말로 삭제하시겠습니까?</th>
</table>
<div id="table_search">
<input type="submit" value="글삭제" class="btn">
<input type="button" value="목록보기" class="btn" onclick="location.href='fnotice.jsp?pageNum<%=pageNum %>'">
</div>
</form>


<div class="clear"></div>
<div id="page_control">
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
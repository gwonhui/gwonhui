<%@page import="domain.My_Member"%>
<%@page import="dao.My_MemberDao"%>
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
	// 세션값 없으면 loginForm.jsp이동
	if (id == null) {
		%><script>
		alert('권한이 없습니다.');
		</script><%
		response.sendRedirect("../member/login.jsp");
		return;
	}
	
	// Dao 객체 생성
	My_MemberDao dao = My_MemberDao.getInstance();
	My_Member bean = dao.getMember(id);
	
	// gender 기본값 "남"
	String gender = bean.getGender();
	if (gender == null) {
		gender = "남";
	}
%>
</head>
<body>
<div id="wrap">
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
<li><a href="../member/info.jsp">회원정보</a></li>
<li><a href="../member/update.jsp">회원정보수정</a></li></ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<div>
<!-- 본문내용 -->

<h1>회원수정</h1>
<form action="updatePro.jsp" method="post" class="info">
	아이디: <input type="text" name="id" value="<%=bean.getId() %>" readonly><br>
	패스워드: <input type="password" name="passwd"><br>
	이름: <input type="text" name="name" value="<%=bean.getName()%>"><br>
	성별: <input type="radio" name="gender" value="남" 
	     <% if (gender.equals("남")) { %>checked<% } %>>남자
	     <input type="radio" name="gender" value="여"
	     <% if (gender.equals("여")) { %>checked<% } %>>여자<br>
	이메일: <input type="email" name="email" value="<%=bean.getEmail()%>"><br>
	<input type="submit" value="회원수정" class="btn">
	<input type="button" value="돌아가기" class="btn" onclick="location.href='../main/main.jsp'">
</form>
</div>
</article>
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<%@include file="../inc/bottom.html" %>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
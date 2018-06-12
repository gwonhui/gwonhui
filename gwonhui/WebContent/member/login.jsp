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
<h1>로그인</h1>
<%
	String result = request.getParameter("result");
	if (!(result == null || result.equals(""))) {
		%><p>회원가입이 성공했습니다.</p><%
	}
%>
<form action="loginPro.jsp" method="post" id="join">
<fieldset>
<legend>로그인 정보</legend>
<label>아이디</label>
<input type="text" name="id"><br>
<label>비밀번호</label>
<input type="password" name="passwd"><br>
<input type="checkbox" name="keepLogin" value="yes" id="keepLogin">
<label for="keepLogin">로그인 상태 유지</label>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="로그인하기" class="submit">
<input type="reset" value="취소하기" class="cancel"> 
</div>
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
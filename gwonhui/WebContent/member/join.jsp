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
 <script>
 function winopen(){
	 //id란이 공백이면 '아이디 입력하세요' 포커스 깜박거리기
	 if(document.frm.id.value.length == 0){
		 alert('아이디를 입력하세요.');
		 document.frm.id.focus();
		 return;
	 }
	// 청열기 join_idcheck.jsp width=400 height=200
	var userid = document.frm.id.value;
	window.open('join_IDCheck.jsp?userid=' + userid, '', 'width=400,height=200');
 }
 </script>
 
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
<li><a href="../member/update.jsp">회원정보수정</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원가입</h1>
<form action="joinPro.jsp" method="post" id="join"  name="frm">
<fieldset>
<legend>기본 사항</legend>
<label>아이디</label>
<input type="text" name="id" class="id" required>
<input type="button" value="dup. check" class="dup" onclick="winopen()"><br>
<label>비밀번호</label>
<input type="password" name="passwd"><br>
<label>비밀번호 재요청</label>
<input type="password" name="passwd2"><br>
<label>이름</label>
<input type="text" name="name"><br>
<label>E-Mail</label>
<input type="email" name="email" required><br>
<label>다시한번 E-Mail</label>
<input type="email" name="email2" required><br>
<label>성별</label>
<input type="radio" name="gender" value="남">남자
<input type="radio" name="gender" value="여">여자<br>
</fieldset>

<fieldset>
<legend>세부 사항</legend>
<label>주소</label>
<input type="text" name="address"><br>
<label>집번호</label>
<input type="text" name="tel"><br>
<label>휴대폰 번호</label>
<input type="text" name="mtel"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
<input type="reset" value="취소" class="cancel" onclick="location.href='../index.jsp'">
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
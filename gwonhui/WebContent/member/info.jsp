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
 <%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 loginForm.jsp이동
	if (id == null) {
		response.sendRedirect("../member/login.jsp");
		return;
	}
	
	// DB객체 생성
	My_MemberDao dao = My_MemberDao.getInstance();
	
	My_Member bean = dao.getMember(id);
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
<li><a href="../member/update.jsp">회원정보수정</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article class="info">
<h1>회원정보 조회</h1>
아이디: <%=bean.getId() %><br>
패스워드: <%=bean.getPasswd() %><br>
이름: <%=bean.getName() %><br>
가입날짜: <%=bean.getReg_date() %><br>
성별: <%=bean.getGender() %><br>
이메일: <%=bean.getEmail() %><br>
<a href="../main/main.jsp" class="btn1">메인화면</a>
</article>

<!-- 본문내용 -->

<!-- 본문들어가는 곳 -->
</div>
</body>
</html>








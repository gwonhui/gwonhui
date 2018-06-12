<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<div id="login">
<%
	// 쿠키 id값 확인
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
	    for (Cookie c : cookies) {
	        if (c.getName().equals("id")) {
	            System.out.println("id쿠키 가져옴 " + c.getValue());
	            session.setAttribute("id", c.getValue());
	        }
	    }
	}

	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 있으면  ..님 logout
	// 세션값 없으면 login
	if (id != null) {
		%>
		<%=id %>님 
		<a href="../member/logout.jsp">로그아웃</a>
		| <a href="../member/info.jsp">정보보기</a>
		<%if(id.equals("admin")){
			%>
			| <a href="../admin/admin.jsp">관리자 메뉴</a>
			<%
			
		}
	} else {
		%>| <a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a> | <%
	}
%>
	
</div>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../index.jsp"><img src="../images/gwon.jpg" width="200" height="56" alt="Gwon's"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../index.jsp">홈</a></li>
	<li><a href="../profile/profile.jsp">프로필</a></li>
	<li><a href="#">가계도</a></li>
	<li><a href="../center/notice.jsp">board</a></li>
	<li><a href="../warning/warning.jsp">필독!</a></li>
</ul>
</nav>
</header>
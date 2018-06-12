<%@page import="domain.My_Member"%>
<%@page import="java.util.List"%>
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
<script src="../js/jquery-3.2.1.min.js"></script>
<script>
function check(ele) {
	if (ele.checked == true && ele.value == 'admin') {
		alert('관리자는 삭제할 수 없습니다!');
		ele.checked = false;
	}
}
function totalChk(ele) {
	if (ele.checked == true) {
		$('.chkbox').attr('checked', true);
	} else {
		$('.chkbox').attr('checked', false);
	}
	
	$('.chkbox').each(function () {
// 		alert('aa');
		var id = $(this).val();
		if (id == 'admin') {
			alert('관리자는 삭제할 수 없다니까요!')
			$(this).attr('checked', false);
		}
	});
}
function fun() {
	var input = document.frm.search.value;
	if (input.length == 0) {
		document.frm.action = 'list.jsp';
	}
	document.frm.submit();
}
</script>
</head>
<%
// 세션값 가져오기
String id = (String) session.getAttribute("id");
// 세션값 없으면 login.jsp이동
if (id == null || !id.equals("admin")) {
	%>
	<script>
	   alert('권한이없습니다.');
	</script>
	<%
	response.sendRedirect("../main/main.jsp");
	return;
}
//Dao 객체생성
	My_MemberDao dao = My_MemberDao.getInstance();
	
	List<My_Member> list = dao.getMembers();
%>
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
<li><a href="../admin/admin.jsp">관리자 메뉴</a></li>
<li><a href="../admin/list.jsp">회원목록</a></li>
<li><a href="../admin/board.jsp">게시판관리</a></li>
<li><a href="../admin/reportB.jsp">신고게시판관리</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1></h1>
<form action= "deletePro.jsp" method="post" id="frm">
	<table border ="1">
		<tr><th>아이디</th><th>이름</th><th>성별</th><th>가입날짜</th><th>
		<input type="checkbox" id="chk" onchange="totalChk(this)"></th>
		
		</tr>
	<%
	for (My_Member bean : list) {
		%>
		<tr>
			<td><%=bean.getId() %></td>
			<td><%=bean.getName() %></td>
			<td><%=bean.getGender() %></td>
			<td><%=bean.getReg_date() %></td>
			<td><input type="checkbox" name="deleteId" value="<%=bean.getId()%>" class="chkbox" onchange="check(this)"></td>
			
		</tr>
		<%
	}
%>
	</table>
	<input type="submit" value="회원탈퇴" onclick="return check();">
	<input type="button" value="관리자메뉴" onclick="location.href='../admin/admin.jsp'">
<div>
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
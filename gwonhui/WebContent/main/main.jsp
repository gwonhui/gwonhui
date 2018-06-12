<%@page import="dao.MyBoardDao"%>
<%@page import="domain.MyBoard"%>
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
<link href="../css/front.css" rel="stylesheet" type="text/css">
<%
String id = (String) session.getAttribute("id");




%>
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
	
<!--[if IE 6]>
 <script src="script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   
	
 </script>
 <![endif]--> 


</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">Security</span> News</h3>
<dl>
<dt>직계가계도</dt>
<dd>
현재 개발중
</dd>
</dl>
<dl>
<dt>지인도</dt>
<dd>
현재 개발중
</dd>
</dl>
</div>
<article>
<div id="news_notice">
<h3 class="brown">제보·보고합니다</h3>
<table>
<%
// DB객체 생성
MyBoardDao dao =MyBoardDao.getInstance();
// 전체 글개수 가져오는 메소드 호출
int count = dao.getBoardCount();
// count 0 아니면 
// List = getBoards(시작행번호, 종료행번호) 호출
// for문 출력
// count 0 이면 "게시글 없음"

if( count > 0 ){
	List<MyBoard> list=dao.getBoards(1, 5);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	for (MyBoard board: list){
	%>	<tr>
			<td class="contxt">
			<%
			if (board.getRe_lev() >0){
				int wid= board.getRe_lev() * 10;
				%>
				<img src="../images/center/level.gif" width="<%=wid %>" height="8">
				<img src="../images/center/re.gif" >
				<%
			}
			%>
				<a href="../center/fcontent.jsp?num=<%=board.getNum()%>"><%=board.getSubject() %></a>
		</td>
	    <td><%=sdf.format(board.getReg_date())%></td></tr>
	<%}
}else{
	%>
	<tr><td class="contxt">게시물 없음</td>
    <td>2012.11.02</td></tr>
<%}
%>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<%@include file="../inc/bottom.html" %>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>
<%@page import="dao.My_MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Id 중복확인</title>
<script>
	function result(){
		//중복확인한 Id값 => 부모창 id텍스트 상자에 넣기
		opener.document.frm.id.value = document.fr.userid.value;
		//현재창 닫기
		close();
	}
</script>

</head>
<%
	// String id = 'userid' 파라미터값 가져오기
	String id = request.getParameter("userid");
	// DB객체(Dao) 생성 memberdao
	My_MemberDao memberdao= My_MemberDao.getInstance();
	//int check = memberdao.idcheck(id);
	int rowCount = memberdao.idCheck(id);
	//check == 0 아이디없음 '사용가능한 아이디입니다.'
	
	//check == 1 아이디있음 '아이디중복, 사용중인id입니다.'
	if(rowCount == 0 ){
		out.print("사용가능한 아이디입니다<br>");
		%>
		<input type ="button" value = "사용" onclick="result()">
		<%
	}else{
		out.print("아이디 중복, 사용중인 id입니다<br>");
	}
	
%>
<body>
<form action="join_IDCheck.jsp" method="post" name="fr">
	<input type= "text" name ="userid" value="<%=id%>">
	<input type="submit" value="id중복체크">
</form>
</body>
</html>
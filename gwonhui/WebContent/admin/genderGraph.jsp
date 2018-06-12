<%@page import="dao.My_MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구글 차트</title>
<style>
	div {
		float: left;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	// 구글 시각화 API를 로딩하는 메소드
	google.charts.load('current', {packages: ['corechart']});
	
	// 구글 시각화 API가 로딩이 완료되면,
	// 인자로 전달된 콜백함수를 내부적으로 호출하여 차트를 그리는 메소드
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
		pieChart1();
	}
	// Dao 객체 생성
	<%
	My_MemberDao dao = My_MemberDao.getInstance();
	int male = dao.countMale();
	int female = dao.countFemale();
	%>
	// 원형 차트 1
	function pieChart1() {
		var arr = [
			['성별', '회원수'],
			['남성', <%=male%>],
			['여성', <%=female%>],
		];
		
		var dataTable = google.visualization.arrayToDataTable(arr);
		
		var options = { title: '성별에 따른 회원수' };
		
		var objDiv = document.getElementById('pie_chart_div1');
		var chart = new google.visualization.PieChart(objDiv);
		chart.draw(dataTable, options);
		
// 		function selectHandler() {
// 			var selectedItem = chart.getSelection()[0];
// 	        var value = dataTable.getValue(selectedItem.row, 0);
// 	        alert('선택한 항목은 ' + value + ' 입니다.');
// 		}
		
		// 적용할 차트, 적용할 이벤트명, 이벤트 핸들러 함수를 인자로 이벤트 리스너에 등록
	}
	
	$(document).ready(function () {
		$('#btn').click(function () {
			drawChart();
		});
	});
</script>
</head>
<body>
	<div id="pie_chart_div1" style="width: 300px; height: 200px; "></div>
</body>
</html>
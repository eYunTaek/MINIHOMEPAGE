<!-- 공지사항 글 목록 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, project03.dao.*, project03.vo.*" %>
<% 
	String path = request.getContextPath();
	int mem_no = 0;
%>
<%
	NoticeDAO dao = new NoticeDAO();
	ArrayList<Notice> noticeList = dao.noticeList();
	Members mem = null;
	boolean isLog = false;
	if(session.getAttribute("mem") != null){
		isLog= true;
		mem = (Members)session.getAttribute("mem");
		mem_no = mem.getMem_no();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="default.css" rel="stylesheet" type="text/css" media="all" />
<style type="text/css">
	#notice {
		width: 1000px;
		margin: 30px 30px;
		margin-left: auto;
		margin-right: auto;
	}
	table {
		width: 100%;
		border-collapse: collapse;
		border-top: 2px solid #444444;
		border-bottom: 2px solid #444444;
		margin-left: auto;
		margin-right: auto;
	}
	th, td {
		border-bottom: 1px solid #BDBDBD;
    	padding: 10px;
		text-align: center;
	}
	th {
		border-bottom: 1px solid #8C8C8C;
		background-color: #EAEAEA;
	}
	td {
		background-color: #FFFFFF;
	}
	#ntitle {text-align: left;}
	a {
		color: black;
		text-decoration: none;
	}
	#link {font-size: 13px;}
	.btn {
		float: right;
		weight: 70px;
		height: 30px;
		background-color: white;
	}
</style>

</head>
<body>

	<div id="header-wrapper2">
		<div id="header" class="container">
			<div id="logo">
				<h1><a href="Main01.html" class="icon icon-group"><span>KGITBANK</span></a></h1>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Main01.html" title="">회사소개</a></li>
					<li class="current_page_item"><a href="Main02_notice.jsp" title="">공지사항</a></li>
					<li><a href="Main03_itemes.jsp" title="">아이템샵</a></li>
					<li><a href="Main04_charge.jsp" title="">콩알충전소</a></li>
					<li><a href="Myhome.jsp" title="">내홈피가기</a></li>
					<li id="login"><a href="mylogin.jsp" title="">로그인</a></li>
					<li id="logout"><a href="logout.jsp" title="">로그아웃</a></li>
				</ul>
			</div>
		</div>
	</div>
	<br><br><br>
	<div id="notice">
		<h2>공지사항</h2>
		<p><a href="Main01.html" id="link">home</a> >> <a href="Main02_notice.jsp" id="link">공지사항</a></p>
		<table>
			<col width="15%"><col width="50%"><col width="20%"><col width="15%">
			<tr>
				<th>번호</th><th>제목</th><th>작성일</th><th>조회수</th>
			</tr>
			<% for(Notice n:noticeList){ %>
			<tr>
				<td><%=n.getNotice_rn() %></td>
				<td id="ntitle"><a href="Main02_noticeView.jsp?notice_no=<%=n.getNotice_no() %>"><%=n.getNotice_title() %></a></td>
				<td><%=n.getNotice_regdate() %></td>
				<td><%=n.getNotice_view() %></td>
			</tr>
			<% } %>
		</table>
		<br>
		<% if(mem_no==1){ %>
		<input type="button" class="btn" id="regBtn" value="글쓰기" />
		<% } %>
	</div>
	<br><br><br>
	<script type="text/javascript">
	var isLog = <%=isLog%>;
	if(isLog){
		document.getElementById("login").style.display = "none"; 
		document.getElementById("logout").style.display = "block"; 
	}else{
		document.getElementById("logout").style.display = "none"; 
		document.getElementById("login").style.display = "block"; 
	}
	window.onload = function(){
		var regBtn = document.querySelector("#regBtn");
		regBtn.onclick = function(){
			 location.href = "Main02_noticeForm.jsp";
		};
	};
</script>
</body>
</html>
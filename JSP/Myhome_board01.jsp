<!-- 홈페이지 게시판 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
	String name = "비회원";
	int mem_no = 0;
	String ran_no = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="default02.css" rel="stylesheet" type="text/css" media="all" />
<style type="text/css">
	#board01 {
		width: 800px;
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
<%
	MembersDAO mdao = new MembersDAO();
	if(session.getAttribute("mem") != null){
	Members mem = (Members)session.getAttribute("mem");
		if(mem != null){
			mem_no = mem.getMem_no();
			name = mem.getMem_name();
			ran_no = String.valueOf(mdao.wave());
		}
	}else{
		response.sendRedirect("mylogin.jsp?valid=N");
	}
%>
<%
	Board01DAO dao = new Board01DAO();
	ArrayList<Board> board01List = dao.board01List(mem_no);
%>
</head>

<body>
	<div id="page" class="container">
		<div id="header">
			<div id="logo">
				<a href="Main01.html" rel="nofollow"><img
					src="images/MainLogo.png" alt="" /></a> <br> <br> <img
					src="images/pic02.jpg" alt="" />
				<h1>
					<a href="Myhome.jsp"><%=name %></a>
				</h1>
				<span>1992 04.10</span>
				<br><br>
				<span><a href="Myhome_info.jsp">정보수정</a> | <a href="logout.jsp">로그아웃</a></span><br>
				<span><a href="Yourhome.jsp?mem_no=<%=ran_no %>">파도타기</a></span>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Myhome.jsp" accesskey="1" title="">Home</a></li>
					<li class="current_page_item"><a href="Myhome_board01.jsp" accesskey="2" title="">게시판</a></li>
					<li><a href="Myhome_board02.jsp" accesskey="3" title="">방명록</a></li>
					<li><a href="Myhome_cong.jsp" accesskey="4" title="">내역보기</a></li>
					
				</ul>
			</div>
		</div>
		<div id="main">
			<div id="banner" class="title">
				<h2><%=name %>님의 미니홈페이지 입니다.</h2>
				<br>
				<hr>
			</div>
			<div id="board01">
				<h2>게시판</h2>
				<p><a href="Myhome.jsp" id="link">home</a> >> <a href="Myhome_board01.jsp" id="link">게시판</a></p>
				<table>
					<col width="15%"><col width="50%"><col width="20%"><col width="15%">
					<tr>
						<th>번호</th><th>제목</th><th>작성일</th><th>조회수</th>
					</tr>
					<% for(Board b:board01List){ %>
					<tr>
						<td><%=b.getBoard_rn() %></td>
						<td id="ntitle">
							<a href="Myhome_board01View.jsp?board_no=<%=b.getBoard_no() %>"><%=b.getBoard_title() %></a>&nbsp;
							<% Board cnt = dao.countCmt(b.getBoard_no());%>
							[<%=cnt.getCnt() %>]
						</td>
						<td><%=b.getBoard_regdate() %></td>
						<td><%=b.getBoard_view() %></td>
					</tr>
					<% } %>
				</table>
				<br>
				<input type="button" class="btn" id="regBtn" value="글쓰기" />
				<br><br><br>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		window.onload = function(){
			var regBtn = document.querySelector("#regBtn");
			regBtn.onclick = function(){
				 location.href = "Myhome_board01Form.jsp";
			};
		};
	</script>
</body>
</html>
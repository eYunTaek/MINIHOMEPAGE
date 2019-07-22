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
	#cong {
		width: 800px;
		height: 500px;
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
	a {
		color: black;
		text-decoration: none;
	}
	#link {font-size: 13px;}
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
	CongDAO dao = new CongDAO();
	ArrayList<Cong> usecongList = dao.usecongList(mem_no);
	ArrayList<Cong> buycongList = dao.buycongList(mem_no);
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
					<li><a href="Myhome_board01.jsp" accesskey="2" title="">게시판</a></li>
					<li><a href="Myhome_board02.jsp" accesskey="3" title="">방명록</a></li>
					<li class="current_page_item"><a href="Myhome_cong.jsp" accesskey="4" title="">내역보기</a></li>
				</ul>
			</div>
		</div>
		<div id="main">
			<div id="banner" class="title">
				<h2><%=name %>님의 미니홈페이지 입니다.</h2>
				<hr>
			</div>
				<h2>내역보기</h2>
				<p><a href="Myhome.jsp" id="link">home</a> >> <a href="Myhome_cong.jsp" id="link">내역보기</a></p>
				<br>
			<div id="cong" style="overflow-y:scroll;overflow-x:scroll">
				<h3>콩 구매내역</h3>
				<table>
					<col width="33%"><col width="33%"><col width="33%">
					<tr>
						<th>구매갯수</th><th>구매방식</th><th>구매날짜</th>
					</tr>
					<% for(Cong c:buycongList){
					if(buycongList == null) { %>
					<tr>
						<td colspan="3">콩을 구매한 내역이 없습니다.</td>
					</tr>
					<% } else { %>
					<tr>
						<td><%=c.getCnt() %></td>
						<td><%=c.getBuy_way() %></td>
						<td><%=c.getDate() %></td>
					</tr>
					<% } %>
					<% } %>
				</table>
			</div>
			<div id="cong" style="overflow-y:scroll;overflow-x:scroll">
				<br><br><br>
				<h3>콩 사용내역</h3>
				<table>
					<col width="33%"><col width="33%"><col width="33%">
					<tr>
						<th>사용갯수</th><th>구매상품</th><th>사용날짜</th>
					</tr>
					<% for(Cong c:usecongList){
					if(usecongList == null) { %>
					<tr>
						<td colspan="3">콩을 사용한 내역이 없습니다.</td>
					</tr>
					<% } else { %>
					<tr>
						<td><%=c.getCnt() %></td>
						<td><%=c.getUse_content() %></td>
						<td><%=c.getDate() %></td>
					</tr>
					<% } %>
					<% } %>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		window.onload = function(){
			
		};
	</script>
</body>
</html>
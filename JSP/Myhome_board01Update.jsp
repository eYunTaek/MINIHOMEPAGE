<!-- 홈페이지 게시판 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
	String name = "비회원";
	int mem_no = 0;
	String ran_no = "";
%>
<%!
	// 넘겨오는 값이 null인 경우에는 공백 넘기기
	String NLStr(String param){
		return param == null?"":param;
	}
	// 넘겨오는 값을 숫자형으로 전환이 필요한 경우, null 경우는 0, 그 외는 정수형 전환처리
	int NLInt(String param){
		int num = 0;
		if(param != null){
			// Integer.parseInt(param) : 숫자형 문자열을 숫자로 변환처리
			num = Integer.parseInt(param);
		}
		return num;
	}
	double NLDbl(String param){
		double num=0;
		if(param!=null){
			num = Double.parseDouble(param);
		}
		return num;
	}	
	String[] NAStr(String[] param){
		String []ret = {""};
		if(param!=null&&param.length>0){
			ret = param;		
		}
		return ret;
	}
	int[] NAInt(String[] params){
		int []ret = {0};
		if(params!=null&&params.length>0){
			ret = new int[params.length];
			for(int idx=0;idx<params.length;idx++){
				ret[idx] = Integer.parseInt(params[idx]);
			}
		}
		return ret;
	}	
	double[] NADbl(String[] params){
		double []ret = {0};
		if(params!=null&&params.length>0){
			ret = new double[params.length];
			for(int idx=0;idx<params.length;idx++){
				ret[idx] = Double.parseDouble(params[idx]);
			}
		}
		return ret;
	}		
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
	}
	th {background-color: #EAEAEA;}
	td {background-color: #FFFFFF;}
	a {
		color: black;
		text-decoration: none;
	}
	#link {font-size: 13px;}
	.btn {
		weight: 70px;
		height: 30px;
		background-color: white;
	}
	input[type=text], textarea {width: 100%;}
	input[type=file] {float: left;}
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
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	String title = NLStr(request.getParameter("title"));
	String content = NLStr(request.getParameter("content"));
	String pubyn = NLStr(request.getParameter("pubyn"));
	String proc = NLStr(request.getParameter("proc"));
	
	Board01DAO dao = new Board01DAO();
	Board bd = dao.getBoard01(board_no);
	boolean isEnd = false;
	if(proc.equals("upt")){
		Board upt = new Board(board_no, title, content, pubyn);
		isEnd = dao.updateBoard01(upt);
	}
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
				<form>
				<input type="hidden" name="proc" />
				<input type="hidden" name="board_no" value="<%=bd.getBoard_no() %>" />
				<table>
					<col width="30%"><col width="70%">
					<tr>
						<th>제목</th><td><input type="text" name="title" value="<%=bd.getBoard_title() %>" /></td>
					</tr>
					<tr>
						<th>내용</th><td><textarea name="content" rows="10"><%=bd.getBoard_content() %></textarea></td>
					</tr>
					<tr>
						<th>첨부파일</th><td><input type="file" name="file" /></td>
					</tr>
					<tr>
						<th>공개여부</th>
						<td>
							<% if(bd.getBoard_pubyn().equals("Y")) { %>
							<input type="radio" name="pubyn" value="Y" checked />공개&nbsp;
							<input type="radio" name="pubyn" value="N" />비공개
							<% } else { %>
							<input type="radio" name="pubyn" value="Y" />공개&nbsp;
							<input type="radio" name="pubyn" value="N" checked />비공개
							<% } %>
						</td>
					</tr>
				</table>
				<br>
				<div align="center">
					<input type="button" class="btn" id="uptBtn" value="수정" />&nbsp;
					<input type="reset" class="btn" value="초기화" />&nbsp;
					<input type="button" class="btn" value="취소" onclick="location.href='Myhome_board01View.jsp?board_no=<%=bd.getBoard_no() %>'" />
				</div>
				</form>
				<br><br><br>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		// 글 수정
		var isEnd = <%=isEnd %>;
		var no = <%=board_no %>
		if(isEnd){
			alert("수정 완료했습니다.");
			location.href = "Myhome_board01View.jsp?board_no="+no;
		}
		// 폼 검사
		var title = document.querySelector("input[name=title]");
		var content = document.querySelector("textarea[name=content]");
		var result = false;
		function formCheck(){
			if(title.value == ""){
				alert("제목을 입력하세요.");
				title.focus();
			} else if(content.value == "") {
				alert("내용을 입력하세요.");
				content.focus();
			} else {
				return true;
			}
		}
		
		window.onload = function(){
			// 글 수정
			var proc = document.querySelector("input[name=proc]");
			var uptBtn = document.querySelector("#uptBtn");
			uptBtn.onclick = function(){
				result = formCheck();
				if(result){
					if(confirm("글을 수정하시겠습니까?")){
						proc.value = "upt";
						document.querySelector("form").submit();
					}
				}
			};
		};
</script>
</body>
</html>
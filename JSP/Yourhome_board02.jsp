<!-- 홈페이지 방명록 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
	request.setCharacterEncoding("utf-8");
	String name = "비회원";
	int mem_no = 0;
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
	#board02 {
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
		border-bottom: 1px solid #8C8C8C;
		background-color: #FFFFFF;
	}
	a {
		color: black;
		text-decoration: none;
	}
	#link {font-size: 13px;}
	#ct {
		text-align: left;
		vertical-align: top;
		height: 50px;
	}
	.btn {
		weight: 70px;
		height: 30px;
		background-color: white;
	}
	textarea {width: 100%;}
</style>
<%
	MembersDAO mdao = new MembersDAO();
	Members mem = null;
	int login_no = 0;	// 로그인한 회원 번호
	if(request.getParameter("mem_no") != null){
		mem_no = NLInt(request.getParameter("mem_no"));
		name =  mdao.getMemNo(mem_no).getMem_name();
	}
	if(session.getAttribute("mem") != null){
		mem = (Members)session.getAttribute("mem");
		login_no = mem.getMem_no();		// 로그인한 회원 번호
	}
%>
<%
	Board02DAO dao = new Board02DAO();
	// 전체 조회
	ArrayList<Board> board02List = dao.board02List(mem_no);
	// 등록
	String content = NLStr(request.getParameter("content"));
	String pubyn = NLStr(request.getParameter("pubyn"));
	String proc = NLStr(request.getParameter("proc"));
	boolean endInsert = false;
	int board_memno = mem.getMem_no();
	if(proc.equals("ins")){
		Board ins = new Board(mem_no, board_memno, content, pubyn);
		endInsert = dao.insertBoard02(ins);
	}
	// 삭제
	int board_no = 0;
	String proc2 = NLStr(request.getParameter("proc2"));
	boolean endDelete = false;
	if(proc2.equals("del")){
		board_no = Integer.parseInt(request.getParameter("board_no"));
		endDelete = dao.deleteBoard02(board_no);
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
					<a href="Yourhome.jsp?mem_no=<%=mem_no%>"><%=name %></a>
				</h1>
				<span>1992 04.10</span>
				<br><br>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Yourhome.jsp?mem_no=<%=mem_no %>" accesskey="1" title="">Home</a></li>
					<li><a href="Yourhome_board01.jsp?mem_no=<%=mem_no %>" accesskey="2" title="">게시판</a></li>
					<li class="current_page_item"><a href="Yourhome_board02.jsp?mem_no=<%=mem_no %>" accesskey="3" title="">방명록</a></li>
					
				</ul>
			</div>
		</div>
		<div id="main">
			<div id="banner" class="title">
				<h2><%=name %>님의 미니홈페이지 입니다.</h2>
				<br>
				<hr>
			</div>
			<div id="board02">
				<h2>방명록</h2>
				<p><a href="Myhome.jsp" id="link">home</a> >> <a href="Myhome_board02.jsp" id="link">방명록</a></p>
				<form id="addCmt">
					<input type="hidden" name="proc" />
					<input type="hidden" name="mem_no" value="<%=mem_no %>" />
					<textarea rows="5" name="content"></textarea>
					<br>
					<div align="right">
						<input type="radio" name="pubyn" value="Y" checked />공개&nbsp;
						<input type="radio" name="pubyn" value="N" />비공개&nbsp;
						<input type="button" class="btn" id="regBtn" value="등록" />
					</div>
				</form>
				<br><br><br>
				<form id="cmts">
					<input type="hidden" name="proc2" />
					<input type="hidden" name="board_no" />
					<% for(Board b:board02List){ %>
					<table>
						<col width="15%"><col width="15%"><col width="70%">
						<tr>
							<th>글번호</th><td><%=b.getBoard_rn() %></td><th><%=b.getMem_name() %>(<%=b.getMem_id() %>)</th>
						</tr>
						<tr><td colspan="3" id="ct"><%=b.getBoard_content() %><br><br><small><%=b.getBoard_regdate() %></small></td></tr>
						<tr>
							<td colspan="3">
								<% if(b.getBoard_memno()==login_no) { %>
								<input type="button" class="btn" value="삭제" onclick="delBD(<%=b.getBoard_no() %>);" />
								<% } %>
							</td>
						</tr>
					</table>
					<% } %>
				</form>
				<br>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		// 글 등록
		var endInsert = <%=endInsert %>;
		if(endInsert){
			alert("등록 완료했습니다.");
			location.href = "Yourhome_board02.jsp?mem_no=<%=mem_no%>";
		}
		// 글 삭제
		var endDelete = <%=endDelete %>;
		if(endDelete){
			alert("삭제 완료했습니다.");
			location.href = "Yourhome_board02.jsp?mem_no=<%=mem_no%>";
		}
		// 폼 검사
		var content = document.querySelector("textarea[name=content]");
		var result = false;
		function formCheck(){
			if(content.value == "") {
				alert("내용을 입력하세요.");
				content.focus();
			} else {
				return true;
			}
		}
		// 글 삭제
		function delBD(board_no){
			var proc2 = document.querySelector("input[name=proc2]");
			var bdno = document.querySelector("input[name=board_no]");
			if(confirm("글을 삭제하시겠습니까?")){
				proc2.value = "del";
				bdno.value = board_no;
				document.querySelector("#cmts").submit();
			}
		}
		
		window.onload = function(){
			var proc = document.querySelector("input[name=proc]");
			// 글 등록
			var regBtn = document.querySelector("#regBtn");
			regBtn.onclick = function(){
				result = formCheck();
				if(result){
					if(confirm("글을 등록하시겠습니까?")){
						proc.value = "ins";
						document.querySelector("#addCmt").submit();
					}
				}
			};
		};
	</script>
</body>
</html>
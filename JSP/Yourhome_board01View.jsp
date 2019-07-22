<!-- 홈페이지 게시판 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
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
	#board01 {
		width: 800px;
		margin: 30px 30px;
		margin-left: auto;
		margin-right: auto;
	}
	#comments {
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
	td {
		background-color: #FFFFFF;
		text-align: center;
	}
	a {
		color: black;
		text-decoration: none;
	}
	#link {font-size: 13px;}
	#ct, #fl, #tt, #cmtct {
		text-align: left;
		vertical-align: top;
	}
	#ct {height: 100px;}
	#cmtct {height: 70px;}
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
	// 게시글
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	String proc = NLStr(request.getParameter("proc"));
	Board01DAO dao = new Board01DAO();
	Board bd = dao.getBoard01(board_no);
	boolean isEnd = false;
	if(proc.equals("del")){
		isEnd = dao.deleteBoard01(board_no);
	}
	// 댓글수, 댓글목록
	Board cnt = dao.countCmt(board_no);
	int count = cnt.getCnt();
	CommentsDAO dao2 = new CommentsDAO();
	ArrayList<Comments> cmtList = dao2.cmtList(board_no);
	// 댓긓 삭제
	int cmt_no = 0;
	String proc3 = NLStr(request.getParameter("proc3"));
	boolean endDelete = false;
	if(proc3.equals("del")){
		cmt_no = Integer.parseInt(request.getParameter("cmt_no"));
		endDelete = dao2.deleteComments(cmt_no);
	}
%>
<%
	// 댓글 등록
	String content = NLStr(request.getParameter("content"));
	String pubyn = NLStr(request.getParameter("pubyn"));
	String proc2 = NLStr(request.getParameter("proc2"));
	boolean isInsert = false;
	if(proc2.equals("ins")){
		Comments ins = new Comments(content, pubyn);
		isInsert = dao2.insertComments(ins, board_no, mem.getMem_no());
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
					<li class="current_page_item"><a href="Yourhome_board01.jsp?mem_no=<%=mem_no %>" accesskey="2" title="">게시판</a></li>
					<li><a href="Yourhome_board02.jsp?mem_no=<%=mem_no %>" accesskey="3" title="">방명록</a></li>
					
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
				<p><a href="Myhome.jsp" id="link">home</a> >> <a href="Yourhome_board01.jsp?mem_no=<%=mem_no %>" id="link">게시판</a></p>
				<form id="board">
					<input type="hidden" name="proc" />
					<input type="hidden" name="board_no" value="<%=bd.getBoard_no() %>" />
					<table>
						<col width="25%"><col width="25%"><col width="25%"><col width="25%">
						<tr>
							<th>제목</th><td colspan="3" id="tt"><%=bd.getBoard_title() %></td>
						</tr>
						<tr>
							<th>작성일</th><td><%=bd.getBoard_regdate() %></td>
							<th>조회수</th><td><%=bd.getBoard_view() %></td>
						</tr>
						<tr>
							<th>내용</th><td colspan="3" id="ct"><%=bd.getBoard_content() %></td>
						</tr>
						<tr>
							<th>첨부파일</th><td colspan="3" id="fl">첨부파일이 없습니다.</td>
						</tr>
					</table>
					<br>
					<div align="center">
						<% if(login_no==mem_no) { %>
						<input type="button" class="btn" value="수정" onclick="location.href='Yourhome_board01Update.jsp?mem_no=<%=mem_no %>&board_no=<%=bd.getBoard_no() %>'" />&nbsp;
						<input type="button" class="btn" id="delBtn" value="삭제" />&nbsp;
						<% } %>
						<input type="button" class="btn" value="목록" onclick="location.href='Yourhome_board01.jsp?mem_no=<%=mem_no %>'" />
					</div>
				</form>
				<br>
				<div id="comments">
					<h3>댓글 <%=count %>개</h3>
					<form id="cmts">
						<input type="hidden" name="proc3" />
						<input type="hidden" name="cmt_no" />
						<input type="hidden" name="board_no" value="<%=bd.getBoard_no() %>" />
					<table>
						<col width="20%"><col width="70%"><col width="10%">
					<% if(count==0){ %>
						<tr><th>등록된 댓글이 없습니다.</th></tr>
					<% } else {
						for(Comments c:cmtList){ %>
						<tr>
							<th><%=c.getMem_name() %><br>(<%=c.getMem_id() %>)<br></th>
							<td id="cmtct"><%=c.getCmt_content() %><br><br><small><%=c.getCmt_regdate() %></small></td>
							<td>
								<% if(c.getCmt_memno()==login_no) { %>
								<input type="button" class="btn" value="삭제" onclick="delBD(<%=c.getCmt_no() %>);" />
								<% } %>
							</td>
						</tr>
					<% }} %>
					</table>
					</form>
					<br><br>
					<form id="addCmt">
						<input type="hidden" name="mem_no" value="<%=mem_no%>"/>
						<input type="hidden" name="proc2" />
						<input type="hidden" name="board_no" value="<%=bd.getBoard_no() %>" />
						<textarea rows="5" name="content"></textarea>
						<br>
						<div align="right">
							<input type="radio" name="pubyn" value="Y" checked />공개&nbsp;
							<input type="radio" name="pubyn" value="N" />비공개&nbsp;
							<input type="button" class="btn" id="regBtn" value="등록" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		// 게시글 삭제
		var isEnd = <%=isEnd %>;
		if(isEnd){
			alert("삭제 완료했습니다.");
			location.href = "Yourhome_board01.jsp?mem_no=<%=mem_no%>";
		}
		// 댓글 등록
		var isInsert = <%=isInsert %>;
		var no = <%=board_no %>;
		if(isInsert){
			alert("등록 완료했습니다.");
			location.href = "Yourhome_board01View.jsp?mem_no=<%=mem_no%>&board_no="+no;
		}
		// 댓글 삭제
		var endDelete = <%=endDelete %>;
		var bno = <%=board_no %>
		if(endDelete){
			alert("삭제 완료했습니다.");
			location.href = "Yourhome_board01View.jsp?mem_no=<%=mem_no%>&board_no="+bno;
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
		// 댓글 삭제
		function delBD(cmt_no){
			var proc3 = document.querySelector("input[name=proc3]");
			var cmtno = document.querySelector("input[name=cmt_no]");
			if(confirm("댓글을 삭제하시겠습니까?")){
				proc3.value = "del";
				cmtno.value = cmt_no;
				document.querySelector("#cmts").submit();
			}
		}
		
		window.onload = function(){
			// 게시글 삭제
			var proc = document.querySelector("input[name=proc]");
			var delBtn = document.querySelector("#delBtn");
			delBtn.onclick = function(){
				if(confirm("글을 삭제하시겠습니까?")){
					proc.value = "del";
					document.querySelector("#board").submit();
				}
			};
			// 댓글 등록
			var proc = document.querySelector("input[name=proc2]");
			var regBtn = document.querySelector("#regBtn");
			regBtn.onclick = function(){
				result = formCheck();
				if(result){
					if(confirm("댓글을 등록하시겠습니까?")){
						proc.value = "ins";
						document.querySelector("#addCmt").submit();
					}
				}
			};
		};
</script>
</body>
</html>
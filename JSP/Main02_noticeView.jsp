<!-- 공지사항 글 상세조회, 삭제 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="java.util.*, project03.dao.*, project03.vo.*" %>
<% 
	String path = request.getContextPath();
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
<%
	int notice_no = Integer.parseInt(request.getParameter("notice_no"));
	String proc = NLStr(request.getParameter("proc"));

	NoticeDAO dao = new NoticeDAO();
	Notice nt = dao.getNotice(notice_no);
	boolean isEnd = false;
	if(proc.equals("del")){
		isEnd = dao.deleteNotice(notice_no);
	}
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
	#ct, #fl, #tt {
		text-align: left;
		vertical-align: top;
	}
	#ct {height: 100px;}
	.btn {
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
		<form>
		<input type="hidden" name="proc" />
		<input type="hidden" name="notice_no" value="<%=nt.getNotice_no() %>" />
		<table>
			<col width="25%"><col width="25%"><col width="25%"><col width="25%">
			<tr>
				<th>제목</th><td colspan="3" id="tt"><%=nt.getNotice_title() %></td>
			</tr>
			<tr>
				<th>작성일</th><td><%=nt.getNotice_regdate() %></td>
				<th>조회수</th><td><%=nt.getNotice_view() %></td>
			</tr>
			<tr>
				<th>내용</th><td colspan="3" id="ct"><%=nt.getNotice_content() %></td>
			</tr>
			<tr>
				<th>첨부파일</th><td colspan="3" id="fl">첨부파일이 없습니다.</td>
			</tr>
		</table>
		<br>
		<div align="center">
			<% if(mem_no==1) { %>
			<input type="button" class="btn" value="수정" onclick="location.href='Main02_noticeUpdate.jsp?notice_no=<%=nt.getNotice_no() %>'" />&nbsp;
			<input type="button" class="btn" id="delBtn" value="삭제" />&nbsp;
			<% } %>
			<input type="button" class="btn" value="목록" onclick="location.href='Main02_notice.jsp'" />
		</div>
		</form>
	</div>
	<br><br><br>
	<script type="text/javascript">
		var isEnd = <%=isEnd %>;
		if(isEnd){
			alert("삭제 완료했습니다.");
			location.href = "Main02_notice.jsp";
		}
		var isLog = <%=isLog%>;
		if(isLog){
			document.getElementById("login").style.display = "none"; 
			document.getElementById("logout").style.display = "block"; 
		}else{
			document.getElementById("logout").style.display = "none"; 
			document.getElementById("login").style.display = "block"; 
		}
		window.onload = function(){
			var proc = document.querySelector("input[name=proc]");
			var delBtn = document.querySelector("#delBtn");
			delBtn.onclick = function(){
				if(confirm("글을 삭제하시겠습니까?")){
					proc.value = "del";
					document.querySelector("form").submit();
				}
			};
		};
	</script>
</body>
</html>
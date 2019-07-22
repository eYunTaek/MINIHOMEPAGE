<!-- 홈페이지 게시판 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
	String name = "비회원";
	int mem_no = 0;
	String mem_id ="";
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
	#info {
		width: 500px;
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
			mem_id = mem.getMem_id();
			ran_no = String.valueOf(mdao.wave());
		}
	}else{
		response.sendRedirect("mylogin.jsp?valid=N");
	}
%>
<%
	String pwd = NLStr(request.getParameter("pwd"));
	String mname = NLStr(request.getParameter("mname"));
	String secunum = NLStr(request.getParameter("secunum"));
	String phone = NLStr(request.getParameter("phone"));
	String email = NLStr(request.getParameter("email"));
	String addr = NLStr(request.getParameter("addr"));
	String proc = NLStr(request.getParameter("proc"));
	
	MembersDAO dao = new MembersDAO();
	Members mb = dao.getMem(mem_id);
	boolean isEnd = false;
	if(proc.equals("upt")){
		Members upt = new Members(mem_no, pwd, mname, secunum, phone, email, addr);
		isEnd = dao.updateMembers(upt);
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
			<div id="info">
				<h2>정보수정</h2>
				<p><a href="Myhome.jsp" id="link">home</a> >> <a href="Myhome_info.jsp" id="link">정보수정</a></p>
				<form>
				<input type="hidden" name="proc" />
				<table align="center" style="text-align:left">
					<col width="40%"><col width="60%">
					<tr><th>아이디</th><td><%=mb.getMem_id() %></td></tr>
					<tr><th>새 비밀번호</th><td><input type="password" name="pwd"/></td></tr>
					<tr><th>새 비밀번호 확인</th><td><input type="password" name="pwdchk"/></td></tr>
					<tr><th>이름</th><td><input type="text" name="mname" value="<%=mb.getMem_name() %>" /></td></tr>
					<tr><th>주민등록번호</th><td><input type="text" name="secunum" value="<%=mb.getMem_secunum() %>" /></td></tr>
					<tr><th>핸드폰번호</th><td><input type="text" name="phone" value="<%=mb.getMem_phone() %>" /></td></tr>
					<tr><th>이메일</th><td><input type="text" name="email" value="<%=mb.getMem_email() %>" /></td></tr>
					<tr><th>주소</th><td><input type="text" name="addr" value="<%=mb.getMem_addr() %>" /></td></tr>
					<tr><th>보유 콩알</th><td><%=mb.getMem_cong() %></td></tr>
				</table>
				<br>
				<input type="button" class="btn" id="uptBtn" value="수정" />
				</form>
				<br><br><br>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		// 정보 수정
		var isEnd = <%=isEnd %>;
		if(isEnd){
			alert("수정 완료했습니다.");
			location.href = "Myhome_info.jsp";
		}
		// 폼 검사
		var pwd = document.querySelector("input[name=pwd]");
		var pwdchk = document.querySelector("input[name=pwdchk]");
		var mname = document.querySelector("input[name=mname]");
		var secunum = document.querySelector("input[name=secunum]");
		var phone = document.querySelector("input[name=phone]");
		var email = document.querySelector("input[name=email]");
		var addr = document.querySelector("input[name=addr]");
		var result = false;
		function formCheck(){
			if(pwd.value == ""){
				alert("비밀번호를 입력하세요.");
				pwd.focus();
			} else if(mname.value == "") {
				alert("이름을 입력하세요.");
				mname.focus();
			} else if(secunum.value == "") {
				alert("주민등록번호를 입력하세요.");
				secunum.focus();
			} else if(phone.value == "") {
				alert("핸드폰번호를 입력하세요.");
				pwd.focus();
			} else if(email.value == "") {
				alert("이메일을 입력하세요.");
				email.focus();
			} else if(addr.value == "") {
				alert("주소를 입력하세요.");
				addr.focus();
			} else {
				return true;
			}
		}
		
		window.onload = function(){
			// 비밀번호 확인
			var int01 = setInterval(function(){
				if(pwd.value == pwdchk.value){
					pwd.style.backgroundColor="skyblue";
					pwdchk.style.backgroundColor="skyblue";
				}else{
					pwd.style.backgroundColor="red";
					pwdchk.style.backgroundColor="red";
				}
			},100);
			// 정보 수정
			var proc = document.querySelector("input[name=proc]");
			var uptBtn = document.querySelector("#uptBtn");
			uptBtn.onclick = function(){
				result = formCheck();
				if(result){
					if(confirm("정보를 수정하시겠습니까?")){
						proc.value = "upt";
						document.querySelector("form").submit();
					}
				}
			};
		};
	</script>
</body>
</html>
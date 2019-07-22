<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*" %>
<% String path = request.getContextPath(); 
	request.setCharacterEncoding("utf-8");
%>
<%!
	//넘겨오는 값이 null인경우에는 공백넘기기
	String NLStr(String param){
		return param==null?"":param;
	}
	// 넘겨오는 값을 숫자형으로 전환 필요한 경우, null 경우는 0, 그외는 정수형 전환처리
	int NLInt(String param){
		int num=0;
		if(param!=null){
			// Integer.parseInt(param):숫자형 문자열을 숫자로 변환처리.
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
	String valid = NLStr(request.getParameter("valid"));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="default.css" rel="stylesheet" type="text/css" media="all" />
<style type="text/css">
#join {
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
	th {background-color: #EAEAEA;}
	td {background-color: #FFFFFF;}
	.btn {
		weight: 70px;
		height: 30px;
		background-color: white;
	}
	input[type=text], input[type=password] {width: 50%;}
	input[type=number] {width: 20%;}
/*

*/
</style>
<script type="text/javascript">
/*

 */
	window.onload = function(){
		var name = document.querySelector("input[name=name]");
		var id = document.querySelector("input[name=id]");
		var phone1 = document.querySelector("input[name=phone1]");
		var phone2 = document.querySelector("input[name=phone2]");
		var phone3 = document.querySelector("input[name=phone3]");
		var phone4 = document.querySelector("input[name=phone4]");
		var phone5 = document.querySelector("input[name=phone5]");
		var phone6 = document.querySelector("input[name=phone6]");
		var idSrhBtn = document.querySelector("#idSrhBtn");
		var passSrhBtn = document.querySelector("#passSrhBtn");
		
		idSrhBtn.onclick = function(){
			if(name.value == "" || phone1.value == "" || phone2.value == "" || phone3.value == ""){
				alert("이름 및 휴대폰번호를 적어주세요");
			}else{
				document.querySelector("form[name=idform]").submit();
			}
		}
		passSrhBtn.onclick = function(){
			if(id.value == "" || phone4.value == "" || phone5.value == "" || phone6.value == ""){
				alert("아이디 및 휴대폰번호를 적어주세요");
			}else{
				document.querySelector("form[name=passform]").submit();
			}
		}
		var valid = "<%=valid%>";
		if(valid == "NI"){
			alert("회원 정보가 다릅니다");
		}
		
	};
</script>
</head>
<body>
<%

%>
	<div id="header-wrapper2">
		<div id="header" class="container">
			<div id="logo">
				<h1><a href="Main01.html" class="icon icon-group"><span>KGITBANK</span></a></h1>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Main01.html" title="">회사소개</a></li>
					<li><a href="Main02_notice.jsp" title="">공지사항</a></li>
					<li><a href="Main03_itemes.jsp" title="">아이템샵</a></li>
					<li><a href="Main04_charge.jsp" title="">콩알충전소</a></li>
					<li><a href="Myhome.jsp" title="">내홈피가기</a></li>
					<li class="current_page_item"><a href="mylogin.jsp" title="">로그인</a></li>
				</ul>
			</div>
		</div>
	</div>
	<br><br><br>
	<div id="join">
		<h2 align="center">아이디 찾기</h2>
		<br><br>
		<form action="idSearch.jsp" method="post" name="idform">
			<table align="center" style="text-align:center">
				<col width="50%"><col width="50%">
				<tr><th>이름</th><td><input type="text" name="name"/></td></tr>
				<tr><th>휴대폰번호</th><td><input type="number" name="phone1"/> - <input type="number" name="phone2"/> - <input type="number" name="phone3"/></td></tr>
			</table>
			<br>
			<div align="center">
				<input type="button" class="btn" value="찾기" id="idSrhBtn"/>
			</div>
		</form>
	</div>
	<div id="join">
		<h2 align="center">비밀번호 찾기</h2>
		<br><br>
		<form action="passSearch.jsp" method="post" name="passform">
			<table align="center" style="text-align:center">
				<col width="50%"><col width="50%">
				<tr><th>아이디</th><td><input type="text" name="id"/></td></tr>
				<tr><th>휴대폰번호</th><td><input type="number" name="phone4"/> - <input type="number" name="phone5"/> - <input type="number" name="phone6"/></td></tr>
			</table>
			<br>
			<div align="center">
				<input type="button" class="btn" value="찾기" id="passSrhBtn"/>
			</div>
		</form>
	</div>

</body>
</html>
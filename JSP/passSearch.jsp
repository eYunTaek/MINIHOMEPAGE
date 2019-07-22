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
	String id = NLStr(request.getParameter("id"));
	String phone = NLStr(request.getParameter("phone4"))+"-"+NLStr(request.getParameter("phone5"))+"-"+NLStr(request.getParameter("phone6"));
	MembersDAO dao = new MembersDAO();
	Members mem = null;
	if(!id.equals("")){
		mem = dao.getPass(id, phone);
		if(mem == null){
			response.sendRedirect("memSearch.jsp?valid=NI");
		}
	}
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
		var backBtn = document.querySelector("#backBtn");
		backBtn.onclick = function(){
			location.href="mylogin.jsp";
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
		<h2 align="center">비밀번호 정보</h2>
		<br><br>
			<table align="center" style="text-align:center">
				<col width="50%"><col width="50%">
				<%if(mem != null){ %>
				<tr><th>비밀번호</th><td><%=mem.getMem_pwd() %></tr>
				<%} %>
			</table>
			<br>
			<div align="center">
				<input type="button" class="btn" value="돌아가기" id="backBtn"/>
			</div>
	</div>
	

</body>
</html>
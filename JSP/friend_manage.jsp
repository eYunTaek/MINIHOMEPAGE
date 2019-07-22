<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
	int mem_no = 0;
	String name = "비회원";
%>
<%!%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="default02.css" rel="stylesheet" type="text/css" media="all" />
<%!
	// 넘겨오는 값이 null인경우에는 공백넘기기
	String NLStr(String param){
		return param==null?"":param;
	}
	// 넘겨오는 값을 숫자형으로 전환 필요한 경우, null 경우는 0, 그외는 정수형 전환처리
	int NLInt(String param){
		int num=0;
		if(param!=null){			// Integer.parseInt(param):숫자형 문자열을 숫자로 변환처리.
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
	
	if(session.getAttribute("mem") != null){
		Members mem = (Members)session.getAttribute("mem");
		if(mem != null){
			mem_no = mem.getMem_no();
			name = mem.getMem_name();
		}
	}else{
		response.sendRedirect("mylogin.jsp?valid=N");
	}
	Members mem = (Members)session.getAttribute("mem");
	ItemDAO dao = new ItemDAO();
	

	Item back = new Item();
	back = dao.putBack(mem_no);

%>
<%
	FriendDAO fdao = new FriendDAO();
	ArrayList<Friend> flist = null;
	ArrayList<Friend> reqlist = null;
	ArrayList<Friend> applist = null;
	if(session.getAttribute("mem") != null){
		flist = fdao.friendList(mem_no);
		reqlist = fdao.reqList(mem_no);
		applist = fdao.appList(mem_no);
	}
	
%>
<%

	boolean isSess = false;
	boolean cutting = false;
	boolean isEnd = false;
	String fid = NLStr(request.getParameter("fid"));
	String fname = NLStr(request.getParameter("fname"));
	int fno = NLInt(request.getParameter("fno"));
	String canfrd = NLStr(request.getParameter("canfrd"));
	String reqcan = NLStr(request.getParameter("reqcan"));
	int reqfno = NLInt(request.getParameter("reqfno"));
	String reqc = NLStr(request.getParameter("reqc"));
	if(session.getAttribute("mem") != null){
		if(!fid.equals("")){
			fdao.delreq(mem_no,fname);
			isSess = fdao.addfriend(mem_no, fid, fname);
			fdao.addfriend(fno, mem.getMem_id(), fname);
		}
		String f_id = NLStr(request.getParameter("f_id"));
		if(!f_id.equals("")){
			int mno = fdao.getno(f_id);
			response.sendRedirect("Yourhome.jsp?mem_no="+mno);
		}
		if(!canfrd.equals("")){
			int mno = fdao.getno(canfrd);
			cutting = fdao.cuttingOff(canfrd,mem.getMem_no());
			fdao.cuttingOff(mem.getMem_id(),mno);
		}
		if(!reqcan.equals("")){
			isEnd = fdao.delreq(reqfno, reqcan);
		}
		if(!reqc.equals("")){
			isEnd = fdao.delreq(mem_no, reqc);
		}
	}
%>
<style type="text/css">
	<%if(session.getAttribute("mem") != null){%>
	#mini{background-image:url("images/<%=back.getItem_file()%>");background-size:800px 400px;width:800px;height:400px;border: 2px solid;}
	<%}%>
	.btn {
		margin-left: auto;
		margin-right: auto;
		weight: 70px;
		height: 30px;
		background-color: white;
	}
	#friend {
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
<script type="text/javascript">
	var isSess = <%=isSess%>;
	if(isSess){
		alert("일촌 수락하였습니다");
	}
	var cutting = <%=cutting%>;
	if(cutting){
		alert("의절 하였습니다");
	}
	var isEnd = <%=isEnd%>;
	if(isEnd){
		alert("취소 하였습니다");
	}
	window.onload=function(){
		<%if(session.getAttribute("mem") != null) {%>
		<%for(Friend f : flist){ %>
		var <%=f.getFriends_name()%> = document.querySelector("#<%=f.getFriends_name()%>");
		var can<%=f.getFriends_name()%> = document.querySelector("#can<%=f.getFriends_name()%>");
		
		<%=f.getFriends_name()%>.onclick = function(){
			document.querySelector("form[name=<%=f.getFriends_name()%>]").submit();
		}
		can<%=f.getFriends_name()%>.onclick = function(){
			document.querySelector("form[name=can<%=f.getFriends_name()%>]").submit();
		}
		<%}%>
		<%for(Friend f : applist){ %>
		var <%=f.getFriends_id() %> = document.querySelector("#<%=f.getFriends_id() %>");
		<%=f.getFriends_id() %>.onclick = function(){
			document.querySelector("form[name=<%=f.getFriends_id() %>]").submit();
		}
		var rcan<%=f.getFriends_id() %> = document.querySelector("#rcan<%=f.getFriends_id() %>");
		rcan<%=f.getFriends_id() %>.onclick = function(){
			document.querySelector("form[name=rc<%=f.getFriends_id() %>]").submit();
		}
		<%}%>
		
		<%for(Friend f : reqlist){ %>
		var rcan<%=f.getFriends_name()%> = document.querySelector("#rcan<%=f.getFriends_name()%>");
		rcan<%=f.getFriends_name()%>.onclick = function(){
			document.querySelector("form[name=rc<%=f.getFriends_name()%>]").submit();
		}
		<%}%>
		<%}%>
	};
	

</script>

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
				<span><a href="logout.jsp">로그아웃</a></span>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Myhome.jsp" accesskey="1" title="">Home</a></li>
					<li><a href="Myitem_change.jsp" accesskey="2" title="">내 아이템</a></li>
					<li class="current_page_item"><a href="friend_manage.jsp" accesskey="4" title="">일촌 관리</a></li>
					
				</ul>
			</div>
		</div>
		<div id="main">
			<div id="banner" class="title">
				<h2><%=name %>님의 일촌 관리 페이지입니다.</h2>
				<br>
				<hr>
				<br>
				<div id="friend">
					<h3>일촌 목록</h3>
					<%if(session.getAttribute("mem") != null) {%>
					<table border>
					<tr><th>일촌 아이디</th><th>일촌 명</th><th>맺은 날짜</th><th>방문</th><th>끊기</th></tr>
					<%for(Friend f : flist){ %>
					<form name="<%=f.getFriends_name()%>">
					<tr><td><%=f.getFriends_id() %></td><td><%=f.getFriends_name() %></td><td><%=f.getFriends_regdate() %></td><td><input type="button" value="방문" id="<%=f.getFriends_name()%>"/></td><td><input type="button" value="끊기" id="can<%=f.getFriends_name()%>"/></td></tr>
					<input type="hidden" value="<%=f.getFriends_id() %>" name="f_id"/>
					</form>
					<form name="can<%=f.getFriends_name()%>">
					<input type="hidden" value="<%=f.getFriends_id() %>" name="canfrd" />
					</form>
					<%} %>
					</table>
					<%}%>
					<hr>
					<h3>일촌 수락 하기</h3>
					<table border>
					<tr><th>아이디</th><th>일촌명</th><th>수락</th><th>취소</th></tr>
					<%if(session.getAttribute("mem") != null) {%>
					<%for(Friend f : applist){ %>
					<form name="<%=f.getFriends_id() %>">
					<input type="hidden" value="<%=f.getFriends_id() %>" name="fid"/>
					<input type="hidden" value="<%=f.getFriends_name() %>" name="fname"/>
					<input type="hidden" value="<%=f.getMem_no() %>" name="fno"/>
					</form>
					<tr><td><%=f.getFriends_id() %></td><td><%=f.getFriends_name() %></td><td><input type="button" value="수락" id="<%=f.getFriends_id() %>"/></td><td><input type="button" value="취소" id="rcan<%=f.getFriends_id() %>"/></td></tr>
					<form name="rc<%=f.getFriends_id() %>">
					<input type="hidden" value="<%=f.getFriends_name() %>" name="reqc"/>
					</form>
					<%} %>
					<%}%>
					</table>
					<hr>
					<h3>일촌 대기 리스트</h3>
					<table border>
					<tr><th>신청 아이디</th><th>일촌명</th><th>취소</th></tr>
					<%if(session.getAttribute("mem") != null) {%>
					<%for(Friend f : reqlist){ %>
					<tr><td><%=f.getFriends_id() %></td><td><%=f.getFriends_name() %></td><td><input type="button" value="취소" id="rcan<%=f.getFriends_name()%>"/></td></tr>
					<form name="rc<%=f.getFriends_name()%>">
					<input type="hidden" value="<%=f.getFriends_name() %>" name="reqcan"/>
					<input type="hidden" value="<%=f.getFriends_no() %>" name="reqfno" />
					</form>
					<%} %>
					<%} %>
					</table>
				</div>
				<br>
			</div>
		</div>
	</div>
</body>
</html>
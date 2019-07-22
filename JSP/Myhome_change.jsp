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
	
	String [] tlist={"캐릭터","가구","모자","상의","하의","신발","손","펫"}; 
	String proc = NLStr(request.getParameter("proc"));
	boolean isEnd = false;
	Item p2;
	if(!proc.equals("")){
		System.out.println("proc:"+proc);
		if(proc.equals("upt")){ // 수정할 DB 모듈 처리
			for(int i=0;i<tlist.length;i++){ 
				for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){
					int x= NLInt(request.getParameter("x"+i));
					int y = NLInt(request.getParameter("y"+i));
					p2 = new Item(mem_no,p.getItem_no(),x,y);
					isEnd = dao.uptcoor(p2);
				}
			}
		}

	}
	Item back = new Item();
	back = dao.putBack(mem_no);

%>

<style type="text/css">
	<%if(session.getAttribute("mem") != null){%>
	#mini{background-image:url("images/<%=back.getItem_file()%>");background-size:800px 400px;width:800px;height:400px;border: 2px solid;}
	<%}%>
	.drag{ position: relative; cursor:move }
	.btn {
		float: right;
		weight: 70px;
		height: 30px;
		background-color: white;
	}
</style>
<script type="text/javascript">
	var bdown = false;
	var x, y;
	var sElem;
	

	var xlist = [];
	var ylist = [];

	function mdown() {
		<%for(int i=0;i<tlist.length;i++){%>
		<%for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){ %>
		if (event.srcElement.name == "<%=tlist[i]%>") {
			bdown = true;
			sElem = event.srcElement;
			x = event.clientX;
			y = event.clientY;
		}
		<%}%>
		<%}%>
	}
	function mup() {
		bdown = false;
	}
	function moveimg() {
		if (bdown && (x <= 740 || x >= 1500 || y >= 552 || y <= 190 )) {
			sElem.style.pixelLeft = 330;
			sElem.style.pixelTop = 150;
		}else if(bdown){
			var distX = event.clientX - x;
			var distY = event.clientY - y;
			sElem.style.pixelLeft += distX;
			sElem.style.pixelTop += distY;
			x = event.clientX;
			y = event.clientY;
			<%for(int i=0;i<tlist.length;i++){%>
			<%for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){ %>
			if (event.srcElement.name == "<%=tlist[i]%>") {
				xlist[<%=i%>] = sElem.style.pixelLeft;
				ylist[<%=i%>] = sElem.style.pixelTop;
			}
			<%}%>
			<%}%>
			return false;
		}
	}
	document.onmousedown = mdown;
	document.onmouseup = mup;
    document.onmousemove = moveimg;
	var isEnd = <%=isEnd%>;
	if( isEnd ){
		var proc = "<%=proc%>";
		// 메인화면에 있는 창, 다시 조회..
		if(proc=="upt"){
			alert("수정 되었습니다");
			location.href = "Myhome.jsp";
		}
	}

	window.onload=function(){
		var chButton = document.querySelector("#change");
		var proc = document.querySelector("input[name=proc]");
		var mem_no = document.querySelector("input[name=mem_no]");
		<%for(int i=0;i<tlist.length;i++){%>
		<%for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){ %>
		var x<%=i%> = document.querySelector("input[name=x<%=i%>]");
		var y<%=i%> = document.querySelector("input[name=y<%=i%>]");
		<%}%>
		<%}%>
	
		chButton.onclick = function(){
			if(confirm("수정 하시겠습니까?")){
				proc.value="upt";
				mem_no.value=<%=mem_no%>;
				<%for(int i=0;i<tlist.length;i++){%>
				<%for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){ %>
				x<%=i%>.value = xlist[<%=i%>];
				y<%=i%>.value = ylist[<%=i%>];
				<%}%>
				<%}%>
				document.querySelector("form").submit();
			}
		}
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
					<li class="current_page_item"><a href="Myhome.jsp" accesskey="1" title="">Home</a></li>
					<li><a href="Myitem_change.jsp" accesskey="2" title="">내 아이템</a></li>
					<li><a href="friend_manage.jsp" accesskey="4" title="">일촌 관리</a></li>
					
				</ul>
			</div>
		</div>
		<div id="main">
			<div id="banner" class="title">
				<h2><%=name %>님의 미니홈페이지 수정 페이지입니다.</h2>
				<br>
				<hr>
				<br>
				<form>
				<input type="hidden" name="proc" />
				<input type="hidden" name="mem_no" />
				<div id ="mini">
					<%for(int i=0;i<tlist.length;i++){ %>
					<%for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){ %>
					<img src ="images/<%=p.getItem_file()%>" class="drag" name="<%=tlist[i]%>" style="position:relative;left:<%=p.getX()%>px;top:<%=p.getY()%>px;"/>
					<input type="hidden" name="x<%=i%>"/>
					<input type="hidden" name="y<%=i%>"/>
					<%} %>
					<%} %>
				</div>
				<br>
				<div align="right">
					<input type="button" class="btn" value="수정완료" id="change"/>
				</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
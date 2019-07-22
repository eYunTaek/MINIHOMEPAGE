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
	String [] tlist={"캐릭터","가구","펫","배경화면"};
	String ptype = NLStr(request.getParameter("ptype"));
	boolean isSess = false;
	
	String ino = NLStr(request.getParameter("ino"));
	String itype = NLStr(request.getParameter("itype"));
	boolean isWear = false;
	boolean isfail = true;
	ArrayList<Item> ilist = null;
	ArrayList<Item> ptlist = null;
	String fullType="";
	if(session.getAttribute("mem") != null){
		ilist = dao.memItem(mem.getMem_no());
		ptlist = dao.getptype(mem.getMem_no());
		if(!ptype.equals("")){
			if(ptype.equals("캐릭터") || ptype.equals("가구") || ptype.equals("펫") || ptype.equals("배경화면")){
				isSess = dao.clearItem(mem, ptype);
			}
		}
		if(!ino.equals("")){
			for(int i = 0; i<ptlist.size();i++){
				fullType += ptlist.get(i).getItem_type();
			}
			if(fullType.contains(itype)){
				isfail= false;
			}else{
				int ino2 = NLInt(ino);
				isWear = dao.wearItem(mem, ino2);
			}
		}
	}
%>

<style type="text/css">
	.btn {
		float: right;
		weight: 70px;
		height: 30px;
		background-color: white;
	}
	.pcls{
		width:30%;
		padding-left:20px;
		float:left;
	}
	#item{
		width:100px;
		height:100px;
		border:2px solid;
	}
</style>
<script type="text/javascript">
	
	var isSess = <%=isSess%>;
	if(isSess){
		alert("착용이 해제 되었습니다");
	}
	var isWear = <%=isWear%>;
	if(isWear){
		alert("착용 하였습니다");
	}
	var isfail = <%=isfail%>;
	if(!isfail){
		alert("같은 부위는 착용이 안됩니다");
	}
	window.onload=function(){
		<%if(session.getAttribute("mem") != null) {%>
		<%for(int i=0;i<tlist.length;i++){ 
			Item pitem = dao.putItem(new Item(tlist[i],mem_no));
		%>
			<%if(tlist[i] == "캐릭터" && pitem != null){ %>
		var proc<%=i+1%> = document.querySelector("#proc1");
		proc1.onclick = function(){
			document.querySelector("form[name=chrform]").submit();
		}
		<%}%>
		<%if(tlist[i] == "가구" && pitem != null){ %>
		var proc<%=i+1%> = document.querySelector("#proc2");
		proc2.onclick = function(){
			document.querySelector("form[name=funiform]").submit();
		}
		<%}%>
		<%if(tlist[i] == "펫" && pitem != null){ %>
		var proc<%=i+1%> = document.querySelector("#proc3");
		proc3.onclick = function(){
			document.querySelector("form[name=petform]").submit();
		}
		<%}%>
		<%if(tlist[i] == "배경화면" && pitem != null){ %>
		var proc<%=i+1%> = document.querySelector("#proc4");
		proc4.onclick = function(){
			document.querySelector("form[name=backform]").submit();
		}
		<%}%>
		<%}%>
		<%for(Item i:ilist){ %>
		var <%=i.getItem_name()%> = document.querySelector("#<%=i.getItem_name()%>");
		<%=i.getItem_name()%>.onclick = function(){
			document.querySelector("form[name=<%=i.getItem_name()%>]").submit();
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
					<li><a href="Myhome_change.jsp" accesskey="1" title="">Home</a></li>
					<li class="current_page_item"><a href="Myitem_change.jsp" accesskey="2" title="">내 아이템</a></li>
					<li><a href="friend_manage.jsp" accesskey="4" title="">일촌 관리</a></li>
					
				</ul>
			</div>
		</div>
		<div id="main">
			<div id="banner" class="title">
				<h2><%=name %>님의 아이템 수정 페이지입니다.</h2>
				<hr>
				<%if(session.getAttribute("mem") != null) {%>
				<%for(int i=0;i<tlist.length;i++){ 
					Item pitem = dao.putItem(new Item(tlist[i],mem_no));
				%>
					<%if(tlist[i] == "캐릭터" && pitem != null){ %>
				<h3>장착한 아이템</h3>
				<div class="pcls" align="center">
					<form name="chrform">
					<input type="hidden" value="캐릭터" name="ptype"/>
					<table style="text-align:center">
					<tr><td>캐릭터</td></tr>
					<tr><td><img src="images/<%=pitem.getItem_file() %>" id="item"/></td></tr>
					<tr><td>아이템 명 : <%=pitem.getItem_name() %></tr>
					<tr><td><input type="button" value="장착 해제" id="proc1"/></td></tr>
					</table>
					</form>
				</div>
				<%} %>
				<%if(tlist[i] == "가구" && pitem != null){ %>
				<div class="pcls" align="center">
					<form name="funiform">
					<input type="hidden" value="가구" name="ptype"/>
					<table style="text-align:center">
					<tr><td>가구</td></tr>
					<tr><td><img src="images/<%=pitem.getItem_file() %>" id="item"/></td></tr>
					<tr><td>아이템 명 : <%=pitem.getItem_name() %></tr>
					<tr><td><input type="button" value="장착 해제" id="proc2"/></td></tr>
					</table>
					</form>
				</div>
				<%} %>
				<%if(tlist[i] == "펫" && pitem != null){ %>
				<div class="pcls" align="center">
					<form name="petform">
					<input type="hidden" value="펫" name="ptype"/>
					<table style="text-align:center">
					<tr><td>펫</td></tr>
					<tr><td><img src="images/<%=pitem.getItem_file() %>" id="item"/></td></tr>
					<tr><td>아이템 명 : <%=pitem.getItem_name() %></tr>
					<tr><td><input type="button" value="장착 해제" id="proc3"/></td></tr>
					</table>
					</form>
				</div>
				<%} %>
				<%if(tlist[i] == "배경화면" && pitem != null){ %>
				<div class="pcls" align="center">
					<form name="backform">
					<input type="hidden" value="배경화면" name="ptype"/>
					<table style="text-align:center">
					<tr><td>배경화면</td></tr>
					<tr><td><img src="images/<%=pitem.getItem_file() %>" id="item"/></td></tr>
					<tr><td>아이템 명 : <%=pitem.getItem_name() %></tr>
					<tr><td><input type="button" value="장착 해제" id="proc4"/></td></tr>
					</table>
					</form>
				</div>
				<%} %>
				<%} %>
				<hr style="clear:both">
				<h3>보유한 아이템</h3>
				<%if(session.getAttribute("mem") != null) {%>
				<%for(Item i:ilist){ %>
				<div class="pcls" align="center" style="float:left">
					<form name="<%=i.getItem_name()%>">
					<input type="hidden" value="<%=i.getItem_no() %>" name="ino"/>
					<input type="hidden" value="<%=i.getItem_type() %>" name="itype"/>
					<table style="text-align:center" >
					<tr><td><%=i.getItem_type() %></td></tr>
					<tr><td><img src="images/<%=i.getItem_file() %>" alt="이미지가 없습니다" id="item"/></td></tr>
					<tr><td>아이템 명 : <%=i.getItem_name() %></tr>
					<tr><td><input type="button" value="장착 " id="<%=i.getItem_name()%>"/></td></tr>
					</table>
					</form>
				</div>
				<%} %>
				<%} %>
				<%} %>
			</div>
			
		</div>
	</div>
	
</body>
</html>
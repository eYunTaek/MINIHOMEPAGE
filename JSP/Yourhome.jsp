<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
	String name = "비회원";
	int mem_no = 0;
%>
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
	ItemDAO dao = new ItemDAO();
	MembersDAO mdao = new MembersDAO();
	boolean isLog = false;
	Members mem = null;
	String [] tlist={"캐릭터","가구","펫"};
	if(request.getParameter("mem_no") != null){
		mem_no = NLInt(request.getParameter("mem_no"));
		name = mdao.getMemNo(mem_no).getMem_name();
	}
	if(session.getAttribute("mem") != null){
		mem = (Members)session.getAttribute("mem");
		if(mem.getMem_no() == mem_no){
			isLog = true;
		}
	}
	Item back = new Item();
	back = dao.putBack(mem_no);
%>
<%
	String proc = NLStr(request.getParameter("proc"));
	String music_file = NLStr(request.getParameter("bgmList"));
	
	MusicDAO dao2 = new MusicDAO();
	Music ms = dao2.getMusic(mem_no);	// 회원이 현재 설정한 배경음악
	ArrayList<Music> musicList = dao2.musicList(mem_no);	// 회원이 보유한 음악목록 조회
	boolean isEnd = false;
	if(proc.equals("upt")){
		Music upt = new Music(music_file);
		isEnd = dao2.updateMusic(upt, mem_no);
	}
%>
<%
	int fno = NLInt(request.getParameter("fno"));
	String fname = NLStr(request.getParameter("fname"));
	FriendDAO fdao = new FriendDAO();
	boolean isreqfrd = false;
	if(session.getAttribute("mem") != null){
		if(!fname.equals("")){
			isreqfrd = fdao.reqFriend(mem.getMem_no(), fno, fname);
		}
	}
%>
<style type="text/css">
	<%if(session.getAttribute("mem") != null){%>
	#mini{background-image:url("images/<%=back.getItem_file()%>");background-size:800px 400px;width:800px;height:400px;border: 2px solid;}
	<%}%>
	a {
		color: black;
		text-decoration: none;
	}
	.btn {
		weight: 70px;
		height: 30px;
		color:white;
	}
</style>
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
				<br>
				<span><h3 id="frdAddBtn" class="btn">일촌 신청</h3></span>
			</div>
			<div id="menu">
				<ul>
					<li class="current_page_item"><a href="Yourhome.jsp?mem_no=<%=mem_no %>" accesskey="1" title="">Home</a></li>
					<li><a href="Yourhome_board01.jsp?mem_no=<%=mem_no %>" accesskey="2" title="">게시판</a></li>
					<li><a href="Yourhome_board02.jsp?mem_no=<%=mem_no %>" accesskey="3" title="">방명록</a></li>
				</ul>
			</div>
		</div>
		<div id="main">
			<div id="banner" class="title">
				<h2><%=name %>님의 미니홈페이지 입니다.</h2>
				<br><hr><br>
				<div align="right">
					<audio controls autoplay loop>
						<source src="music/<%=ms.getMusic_file() %>" type="audio/mpeg">
					</audio>
					<br>
					<form name="mus">
						<input type="hidden" name="proc" />
						<select name="bgmList" id="bgmList">
							<% for(Music m:musicList){ %>
							<option value="<%=m.getMusic_file() %>"><%=m.getMusic_title() %></option>
							<% } %>
						</select>
						<input type="button" id="chMusic" value="변경" />
					</form>
					<br><br>
				</div>
				<div id ="mini">
					<%for(int i=0;i<tlist.length;i++){ %>
					<%for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){ %>
					<img src ="images/<%=p.getItem_file()%>" style="position:relative;left:<%=p.getX()%>px;top:<%=p.getY()%>px;"/>
					<%} %>
					<%} %>
				</div>
				<br>
			</div>
			<form name="frd">
			<div id="contact" class="w3-modal" style="display:none">
				<div class="w3-modal-content w3-animate-zoom">
					<div class="w3-container w3-black">
						<input type="hidden" value="<%=mem_no%>" name="fno"/>
						<input type="hidden" value="<%=mem_no%>" name="mem_no"/>
						<span>일촌 명 : </span><span><input type="text" name="fname"/></span><br>
					</div>
					<div class="w3-container">
				      <p >일촌 신청을 원하시면 신청하기 버튼을 눌러주세요.</p>
				      <p align="left" style="float:left"><input type="button" class="w3-button w3-black" id="addBtn" value="신청하기"/></p>
				      <p align="right"><input type="button" class="w3-button w3-black" id="canBtn" value="취소"/></p>
				    </div>
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	var isreqfrd = <%=isreqfrd%>
	if(isreqfrd){
		alert("일촌 신청 하였습니다");
	}
	var isEnd = <%=isEnd %>;
	if(isEnd){
		alert("변경 완료했습니다.");
		location.href = "Myhome.jsp";
	}
	window.onload = function(){
		var proc = document.querySelector("input[name=proc]");
		var chMusic = document.getElementById("chMusic");
		chMusic.onclick = function(){
			if(confirm("배경음악을 변경하시겠습니까?")){
				proc.value = "upt";
				document.querySelector("form[name=mus]").submit();
			}
		};
		var frdAddBtn = document.querySelector("#frdAddBtn");
		frdAddBtn.onclick = function(){
			document.getElementById('contact').style.display='block';
		}
		var isLog = <%=isLog%>
		if(isLog){
			document.getElementById("frdAddBtn").style.display = "none"; 
		}else{
			document.getElementById("frdAddBtn").style.display = "block"; 
		}
		var canBtn = document.querySelector("#canBtn");
		canBtn.onclick = function(){
			document.getElementById('contact').style.display='none';
		}
		var addBtn = document.querySelector("#addBtn");
		addBtn.onclick = function(){
			document.querySelector("form[name=frd]").submit();
		}
		
	};
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
	String name = "비회원";
	int mem_no = 0;
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

<%
	ItemDAO dao = new ItemDAO();
	MembersDAO mdao = new MembersDAO();
	String [] tlist={"캐릭터","가구","펫"};
	if(session.getAttribute("mem") != null){
		Members mem = (Members)session.getAttribute("mem");
		if(mem != null){
			mem_no = mem.getMem_no();
			name = mem.getMem_name();
			ran_no = String.valueOf(mdao.wave());
		}
	}else{
		response.sendRedirect("mylogin.jsp?valid=N");
	}
	Item back = new Item();
	back = dao.putBack(mem_no);
	System.out.println(ran_no);
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
<style type="text/css">
	<%if(session.getAttribute("mem") != null){%>
	#mini{background-image:url("images/<%=back.getItem_file()%>");background-size:800px 400px;width:800px;height:400px;border: 2px solid;}
	<%}%>
	.btn {
		float: right;
		weight: 70px;
		height: 30px;
		background-color: white;
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
					<a href="Myhome.jsp"><%=name %></a>
				</h1>
				<span>1992 04.10</span>
				<br><br>
				<span><a href="Myhome_info.jsp">정보수정</a> | <a href="logout.jsp">로그아웃</a></span><br>
				<span><a href="Yourhome.jsp?mem_no=<%=ran_no %>">파도타기</a></span>
			</div>
			<div id="menu">
				<ul>
					<li class="current_page_item"><a href="Myhome.jsp" accesskey="1" title="">Home</a></li>
					<li><a href="Myhome_board01.jsp" accesskey="2" title="">게시판</a></li>
					<li><a href="Myhome_board02.jsp" accesskey="3" title="">방명록</a></li>
					<li><a href="Myhome_cong.jsp" accesskey="4" title="">내역보기</a></li>
					
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
					<form>
						<input type="hidden" name="proc" />
						<select name="bgmList" id="bgmList">
							<% for(Music m:musicList){ %>
							<option value="<%=m.getMusic_file() %>"><%=m.getMusic_title() %></option>
							<% } %>
						</select>
						<input type="button" id="chMusic" value="변경" />
					</form>
					<br><br><br>
				</div>
				<div id ="mini">
					<%for(int i=0;i<tlist.length;i++){ %>
					<%for(Item p : dao.mini_look(new Item(tlist[i],mem_no))){ %>
					<img src ="images/<%=p.getItem_file()%>" style="position:relative;left:<%=p.getX()%>px;top:<%=p.getY()%>px;"/>
					<%} %>
					<%} %>
				</div>
				<br>
				<form action="Myhome_change.jsp">
				<div align="right">
					<input type="hidden" name="mem_no" value="<%=mem_no %>" />
					<input type="submit" class="btn" value="수정"/>
				</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
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
				document.querySelector("form").submit();
			}
		};
	};
</script>
</html>
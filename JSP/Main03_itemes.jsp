<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*, project03.dao.*"%>
<%
	String path = request.getContextPath();
%>
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
	Members mem = null;
	boolean isLog = false;
	boolean isBuy = false;
	boolean moneyChk = false;
	String name = "비회원";
	int mem_no = 0;
	if(session.getAttribute("mem") != null){
		mem = (Members)session.getAttribute("mem");
		isLog= true;
		if(mem != null){
			mem_no = mem.getMem_no();
			name = mem.getMem_name();
		}
	}else{
		response.sendRedirect("mylogin.jsp?valid=N");
	}
	
	ItemDAO dao = new ItemDAO();
	MembersDAO dao2 = new MembersDAO();
	ArrayList<Item> ilist = new ArrayList<Item>();
	ilist = dao.itemList();
	ArrayList<Item> flist = new ArrayList<Item>();
	flist = dao.fileList();
	ArrayList<Item> milist = new ArrayList<Item>();
	if(mem!=null){
		milist = dao.memItem(mem.getMem_no());
	}
	
	
	String price = NLStr(request.getParameter("iprice")); // 아래의 type="hidden"에 받은 iprice값을 스크립트로 받아준다.
	int ino = NLInt(request.getParameter("ino")); // 아래의 type="hidden"에 받은 ino값을 스크립트로 받아준다.
	String iname = NLStr(request.getParameter("iname"));
	String itype = NLStr(request.getParameter("itype"));
	boolean hasitem = false;
	
	if(!price.equals("")){ // equlas로 비교하기 위해 iprice를 String형 price로 받았다.
		int p =  NLInt(price); // 위 String으로 받은 price를 int형 변수p에 담아준다.
		if(mem.getMem_cong() >= p){ // 현재 세션에 연결된 mem의 정보중 getMem_cong을 불러와 p(가격)과 비교한다.
			String fullitem ="";
			for(int i= 0; i<milist.size();i++){
				fullitem += milist.get(i).getItem_name();
			}
			if(!fullitem.contains(iname)){
				isBuy = dao2.updateMembers(mem_no,p); // dao2.updateMembers(mem.getMem_no(),p);가 True이면 isbuy가 Ture가 되면서 함수를 실행한다.
				dao2.addMemberitem(mem_no,ino); // dao2.addMemberitem(mem.getMem_no(),ino);가 True이면 알아서 만들어놓은 모듈(함수) sql이 동작된다.
				dao.usecong(mem_no,p,itype);
				session.setAttribute("mem", dao2.login(new Members(mem.getMem_id(),mem.getMem_pwd())));
			}else{
				hasitem = true;
			}
		
		}else{
			moneyChk = true; // mem.getMem_cong() >= p이 flase가되면 실행된다.
		} 
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="default.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
input[type=text]{width:100%;}
#item{
	width:150px;
	height:150px;
	border:2px solid;
	}
</style>
</head>
<body>

	<div id="header-wrapper2">
		<div id="header" class="container">
			<div id="logo">
				<h1>
					<a href="Main01.html"><span>KGITBANK</span></a>
				</h1>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Main01.html" title="">회사소개</a></li>
					<li><a href="Main02_notice.jsp" title="">공지사항</a></li>
					<li class="current_page_item"><a href="Main03_itemes.jsp"
						title="">아이템샵</a></li>
					<li><a href="Main04_charge.jsp" title="">콩알충전소</a></li>
					<li><a href="Myhome.jsp" title="">내홈피가기</a></li>
					<li id="login"><a href="mylogin.jsp" title="">로그인</a></li>
					<li id="logout"><a href="logout.jsp" title="">로그아웃</a></li>
				</ul>
			</div>
		</div>
	</div>
<div style="height:1000px;width:250px;padding-top:50px;float:left" id="mySidebar">
  <div class="w3-container w3-display-container w3-padding-16">
    <i onclick="w3_close()" class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>
    <h3 class="w3-wide" style="text-align:center;"><b>메뉴</b></h3>
  </div>
  
  <div class="w3-large" style="font-weight:bold">
    <a id="c01" onclick="myAccFunc1()" href="javascript:void(0)" class="w3-button w3-block w3-left-align">
      Body <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc1" class="w3-bar-block w3-hide w3-padding-large w3-medium" >
      <a href="Main03_itemes.jsp" onclick="w3_close()" class="w3-bar-item w3-button" style="background-color:#ccc">
      	<i class="fa fa-caret-right w3-margin-right"></i>캐릭터</a>
    </div>
  </div>
  
  <div class="w3-large" style="font-weight:bold">
    <a id="c01" onclick="myAccFunc2()" href="javascript:void(0)" class="w3-button w3-block w3-left-align">
      Accessory <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc2" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="Main03_itemes_Furniture.jsp" class="w3-bar-item w3-button "><i class="fa fa-caret-right w3-margin-right"></i>가구</a>
      <a href="Main03_itemes_Background.jsp" class="w3-bar-item w3-button "><i class="fa fa-caret-right w3-margin-right"></i>배경화면</a>
    </div>
  </div>
  
  <div class="w3-large" style="font-weight:bold">
    <a id="c01" onclick="myAccFunc3()" href="javascript:void(0)" class="w3-button w3-block w3-left-align">
      Pet <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc3" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="Main03_itemes_Pet1.jsp" class="w3-bar-item w3-button "><i class="fa fa-caret-right w3-margin-right"></i>일반펫</a>
    </div>
  </div>

  <div class="w3-large" style="font-weight:bold">
    <a id="c01" onclick="myAccFunc4()" href="javascript:void(0)" class="w3-button w3-block w3-left-align">
      Music <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc4" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="Main03_itemes_Music1.jsp" class="w3-bar-item w3-button "><i class="fa fa-caret-right w3-margin-right"></i>가요</a>
      <a href="Main03_itemes_Music2.jsp" class="w3-bar-item w3-button "><i class="fa fa-caret-right w3-margin-right"></i>POP</a>
      <a href="Main03_itemes_Music3.jsp" class="w3-bar-item w3-button "><i class="fa fa-caret-right w3-margin-right"></i>Jazz</a>
    </div>
  </div>
 </div>


<div style="float:left; padding-left:200px">
  <div>
     <br><br>
       <p style="font-weight:bold;font-size:25px;padding-right:150px" align="center">캐릭터 목록</p>
      <table style="padding-left:50p" width="1300px" border;>
      <%int itemcnt=1; %>
      <%for(Item i:ilist) {
         if(i.getItem_type().equals("캐릭터")){%>
            <%if(itemcnt%6==1){%><tr><%} %>
            <%for(Item f:flist){if(i.getItem_no()==f.getItem_no()){%>
      <form name="buy<%=i.getItem_name()%>">
         <td><img src="images/<%=f.getItem_file()%>" id="item"><br><button class="w3-button w3-black"  id="buy<%=i.getItem_name()%>"
         >Buy now <i class="fa fa-shopping-cart">
         </i></button><br><p><%=i.getItem_name()%><br><b><%=   i.getItem_price() %>콩알</b></p>
         <input type="hidden" value="<%=i.getItem_no()%>" name="ino"/>
         <input type="hidden" value="<%=i.getItem_price()%>" name="iprice"/>
         <input type="hidden" value="<%=i.getItem_name()%>" name="iname"/>
         <input type="hidden" value="<%=i.getItem_type()%>" name="itype"/>
         </td><%itemcnt++; %>
         <%if(itemcnt%6==0)%></tr>
      </form>
         <%}}}} %>
      </table>  
   </div>
</div>


<script type="text/javascript">

var hasitem = <%=hasitem%>
if(hasitem){
	alert("이미 보유한 아이템 입니다");
	
}
var iprice = document.querySelector("#iprice");
function showiprice(){
	alert(iprice.innerHTML);
}
var iname = document.querySelector("#iname");
function showiname(){
	alert(iname.innerHTML);
}
var moneyChk = <%=moneyChk%>;
if(moneyChk){
	if(confirm("콩알이 모자랍니다 \n충전 페이지로 넘어가시겠습니까?")){
		location.href="Main04_charge.jsp";
	}
}
var isBuy = <%=isBuy%>; // 자바에서 isBuy가 True가 되면 실행된다.
if(isBuy){
	alert("구매 하셨습니다");
}
var isLog = <%=isLog%>;
if(isLog){
	document.getElementById("login").style.display = "none"; 
	document.getElementById("logout").style.display = "block"; 
}else{
	document.getElementById("logout").style.display = "none"; 
	document.getElementById("login").style.display = "block"; 
}
window.onload=function(){

	var c01 = document.querySelectorAll("#c01");
	for(var idx=0;idx<c01.length;idx++){
		c01[idx].onclick();
	}
	<%for(Item i:ilist) {
	if(i.getItem_type().equals("캐릭터")){%>
	<%for(Item f:flist){if(i.getItem_no()==f.getItem_no()){%>
	var buy<%=i.getItem_name()%> = document.querySelector("#buy<%=i.getItem_name()%>");
	buy<%=i.getItem_name()%>.onclick = function(){
		document.querySelector("form[name=buy<%=i.getItem_name()%>]").submit();
	}
	<%}}}}%>
};
function myAccFunc1() {
	  var x = document.getElementById("demoAcc1");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else {
	    x.className = x.className.replace(" w3-show", "");
	  }
	}
function myAccFunc2() {
	  var x = document.getElementById("demoAcc2");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else {
	    x.className = x.className.replace(" w3-show", "");
	  }
	}
function myAccFunc3() {
	  var x = document.getElementById("demoAcc3");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else {
	    x.className = x.className.replace(" w3-show", "");
	  }
	}
function myAccFunc4() {
	  var x = document.getElementById("demoAcc4");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else {
	    x.className = x.className.replace(" w3-show", "");
	  }
	}
	// Open and close sidebar
function w3_open() {
	  document.getElementById("mySidebar").style.display = "block";
	  document.getElementById("myOverlay").style.display = "block";
	}
	 
function w3_close() {
	  document.getElementById("mySidebar").style.display = "none";
	  document.getElementById("myOverlay").style.display = "none";
	}


</script>

</body>
</html>






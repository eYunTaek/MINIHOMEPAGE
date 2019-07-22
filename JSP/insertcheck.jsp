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
	String pass = NLStr(request.getParameter("pass"));
	String name = NLStr(request.getParameter("name"));
	String civno = NLStr(request.getParameter("civno1"))+"-"+NLStr(request.getParameter("civno2"));
	String phone = NLStr(request.getParameter("phone1"))+"-"+NLStr(request.getParameter("phone2"))+"-"+NLStr(request.getParameter("phone3"));
	String email = NLStr(request.getParameter("emali1"))+"@"+NLStr(request.getParameter("emali2"));
	String address = NLStr(request.getParameter("address"));
	MembersDAO dao = new MembersDAO();
	Members mem = dao.getMem(id);
	boolean isInsert = false;
	if(!id.equals("") && !pass.equals("") && !name.equals("") && !civno.equals("") && !phone.equals("") && !email.equals("") && !address.equals("")){
		if(id.equals(mem.getMem_id())){
			response.sendRedirect("memInsert.jsp?valid=NI");
		}else{
			isInsert = dao.insertMem(new Members(id,pass,name,civno,phone,email,address));
			Members newmem = dao.getMem(id);
			dao.insertMini(newmem.getMem_no());
			dao.addMemberitem(newmem.getMem_no(), 1);
			dao.addMemberitem(newmem.getMem_no(), 4);
			ItemDAO idao = new ItemDAO();
			idao.wearItem(newmem,1);
			idao.wearItem(newmem,4);
			response.sendRedirect("memInsert.jsp?valid=Y");
		}
	}
	else if(!id.equals("") && id.equals(mem.getMem_id())){
		if(!id.equals("") && !pass.equals("")){
			response.sendRedirect("memInsert.jsp?valid=N");
		}
		else{
			response.sendRedirect("memInsert.jsp?valid=NI");
		}
	}
	else if(!id.equals("") && !id.equals(mem.getMem_id())){
		if(!id.equals("") && !pass.equals("")){
			response.sendRedirect("memInsert.jsp?valid=N");
		}
		else{
			response.sendRedirect("memInsert.jsp?valid=YS");
		}
	}
	else{
		response.sendRedirect("memInsert.jsp?valid=N");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=path%>/a00_com/a00_com.css"/>
<style type="text/css">
	input[type=text]{width:100%;}
/*

*/
</style>
<script type="text/javascript">
/*

 */
	window.onload = function(){
		var h1 = document.querySelector("h1");
		h1.innerHTML = "시작";
	};
</script>
</head>
<body>
<%

%>
	<h1></h1>
	<table align="center">
		<tr><th>타이틀</th></tr>
		<tr><td>내용</td></tr>
	</table>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*"%>
<%
	String path = request.getContextPath();
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
 	alert("로그아웃 하셨습니다");
	location.href="Main01.html";
</script>
</head>
<body>
<%
	session.removeAttribute("mem");
%>
	

</body>
</html>
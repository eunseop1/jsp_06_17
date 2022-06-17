<%@page import="kr.MS.service.MemoService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(!request.getMethod().equals("POST")){
		response.sendRedirect("index.jsp");
		return;
	}
	
	int currentPage = 1;
	try{
		currentPage = Integer.parseInt(request.getParameter("p"));
	}catch(Exception e){
		;
	}
	
	int pageSize = 10;
	try{
		pageSize = Integer.parseInt(request.getParameter("s"));
	}catch(Exception e){
		;
	}
	
	int blockSize = 10;
	try{
		blockSize = Integer.parseInt(request.getParameter("b"));
	}catch(Exception e){
		;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="vo" class="kr.MS.vo.MemoVO"/>
	<jsp:setProperty property="*" name="vo"/>
	
	<jsp:setProperty property="ip" name="vo" value="<%=request.getRemoteAddr() %>"/>
	<!-- request.getRemoteAddr()를 사용해서 클라이언트의 아이피를 얻기 -->
	
	<%
		if(vo != null){
			switch(vo.getMode()){
			case "insert":
				MemoService.getInstance().insert(vo);
				response.sendRedirect("index.jsp?p=1&s=" + pageSize + "&b=" + blockSize);
				break;
			case "update":
				MemoService.getInstance().update(vo);
				response.sendRedirect("index.jsp?p=" + currentPage + "&s=" + pageSize + "&b=" + blockSize);
				break;
			case "delete":
				MemoService.getInstance().delete(vo);
				response.sendRedirect("index.jsp?p=" + currentPage + "&s=" + pageSize + "&b=" + blockSize);
				break;
			}
		}
	%>
	
</body>
</html>
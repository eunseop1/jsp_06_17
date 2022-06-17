<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.MS.service.MemoService"%>
<%@page import="kr.MS.vo.MemoVO"%>
<%@page import="kr.MS.vo.PagingVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
	
	PagingVO<MemoVO> pagingVO = MemoService.getInstance().selectList(currentPage, pageSize, blockSize);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1줄 메모장</title>
<link href="${pageContext.request.servletContext.contextPath }/webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.servletContext.contextPath }/webjars/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.servletContext.contextPath }/webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#cancelBtn").css('display','none');
	});
	
	function updateComment(idx, name, content){
		$("#cancelBtn").css('display', 'inline');
		$("#idx").val(idx);
		$("#name").val(name);
		$("#content").val(content);
		$("#submitBtn").val("수정");
		$("#mode").val("update");
		$("#password").focus();
	}
	function deleteComment(idx, name, content){
		$("#cancelBtn").css('display', 'inline');
		$("#idx").val(idx);
		$("#name").val(name);
		$("#content").val(content);
		$("#submitBtn").val("삭제");
		$("#mode").val("delete");
		$("#password").focus();
	}
	function resetComment(){
		$("#cancelBtn").css('display','none');
		$("#idx").val("0");
		$("#name").val("");
		$("#content").val("");
		$("#submitBtn").val("저장");
		$("#mode").val("insert");
		$("#name").focus();
	}
</script>
<style type="text/css">
	table{width: 900px; margin: auto; border: none; padding: 5px;}
	td {padding: 5px; border: 1px solid gray;}
	th {padding: 5px; border: 1px solid gray; background-color: silver; text-align: center;}
	.title {font-size: 18pt; border: none; text-align: center;}
</style>
</head>
<body>
	<table>
		<tr>
			<td colspan="5" class="title">1줄 메모장</td>
		</tr>
		<tr>
			<td colspan="5" align="right" style="border: none;"><%=pagingVO.getPageInfo() %></td>
		</tr>
		<tr>
			<th width="5%">No</th>
			<th>작성자</th>
			<th width="60%">내용</th>
			<th>작성일</th>
			<th>IP</th>
		</tr>
		<%
			if(pagingVO.getTotalCount() == 0){
		%>
		<tr>
			<td colspan="5" align="center">등록된 글이 없습니다.</td>
		</tr>
		<%
			}else{
				for(MemoVO vo : pagingVO.getList()){
		%>
		<tr align="center">
			<td><%=vo.getIdx() %></td>
			<td><%=vo.getName() %></td>
			<td title="<%=vo.getContent() %>" align="left">
			<%
			String content = vo.getContent();
			if(content.length() > 30){
				content = content.substring(0, 30) + "....";
			}
			content = content.replaceAll("<", "&lt;");
			out.println(content);
			%>
			<input type="button" onclick="updateComment(<%=vo.getIdx()%>, '<%=vo.getName() %>', '<%=vo.getContent() %>')" value="수정" class="btn btn-outline-success btn-sm"/>
			<input type="button" onclick="deleteComment(<%=vo.getIdx()%>, '<%=vo.getName() %>', '<%=vo.getContent() %>')" value="삭제" class="btn btn-outline-success btn-sm"/>
			</td>
			<td>
			<%
			Date date = vo.getRegDate();
			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd hh:mm");
			out.println(sdf.format(date));
			%>
			</td>
			<td><%=vo.getIp() %></td>
		</tr>
		<%
				}
			}
		%>
		<tr>
			<td colspan="5" style="border: none;" align="center">
				<%=pagingVO.getPageList() %>
			</td>
		</tr>
		<tr>
			<td colspan="5" style="border: none;" align="center">
				<form action="updateOk.jsp" method="post">
					<input type="hidden" name="idx" id="idx" value="0"/>
					<input type="hidden" name="p" id="p" value="<%=pagingVO.getCurrentPage()%>"/>
					<input type="hidden" name="s" id="s" value="<%=pagingVO.getPageSize()%>"/>
					<input type="hidden" name="b" id="b" value="<%=pagingVO.getBlockSize()%>"/>
					<input type="hidden" name="mode" id="mode" value="insert"/>
					<input type="text" name="name" id="name" required="required" size="5"/>
					<input type="password" name="password" id="password" required="required" size="5"/>
					<input type="text" name="content" id="content" required="required" size="75"/>
					<input type="submit" id="submitBtn" value="저장" class="btn btn-outline-success btn-sm"/>
					<input type="button" id="cancelBtn" value="취소" class="btn btn-outline-success btn-sm" onclick="resetComment()"/>
				</form>
			</td>
		</tr>
	</table>
	
</body>
</html>
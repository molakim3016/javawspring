<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminLeft.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
  <h5>관리자 홈화면</h5>
  <hr/>
  <p>
		신규 가입자 수(오늘 가입) : <a href="${ctp}/admin/member/adminMemberList" target="adminContent">${memCount}</a>
  </p>
  <hr/>
  <p>
		신규 작성 글 수(오늘작성) : <a href="${ctp}/admin/board/adminBoardList" target="adminContent">${boardCount}</a>
  </p>
</div>
<p><br/></p>
</body>
</html>
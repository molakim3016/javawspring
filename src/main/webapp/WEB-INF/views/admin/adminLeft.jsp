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
	<style>
	a:hover {
		text-decoration: none;
		color:black;
	}
	.accor a {
		display: inline-block;
	  width: 100%;
	  height: 40px;
	}
</style>
</head>
<body style="background-color: #ccc">
<p><br/></p>
<div class="container">
	<div id="accordion">
		<h5>관리자메뉴</h5>
		<hr/>
		<div>
			<a href="${ctp}/" target="_top"><b>홈으로</b></a>
		</div>
		<hr/>
	  <div><a data-toggle="collapse" href="#collapseOne"><b>방명록</b></a></div>
	  <div id="collapseOne" class="collapse accor mt-3" data-parent="#accordion">
			<a href="#">방명록리스트</a>
	  </div>
	  <hr/>
	  <div><a data-toggle="collapse" href="#collapseTwo"><b>회원</b></a></div>
	  <div id="collapseTwo" class="collapse accor mt-3" data-parent="#accordion">
			<a href="${ctp}/admin/member/adminMemberList" target="adminContent">회원리스트</a>
	  </div>
	  <hr/>
	  <div><a data-toggle="collapse" href="#collapseThree"><b>게시판</b></a></div>
	  <div id="collapseThree" class="collapse accor mt-3" data-parent="#accordion">
			<a href="${ctp}/admin/board/adminBoardList" target="adminContent">게시판리스트</a>
	  </div>
	  <hr/>
	  <div><a data-toggle="collapse" href="#collapseFour"><b>기타작업</b></a></div>
	  <div id="collapseFour" class="collapse accor mt-3" data-parent="#accordion">
			<a href="${ctp}/admin/file/fileList" target="adminContent">임시파일</a>
	  </div>
	  <hr/>
	</div>
</div>
<p><br/></p>
</body>
</html>
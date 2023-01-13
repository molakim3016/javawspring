<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberIdSearch.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	
  	function idSearch() {
			let name = myform.name.value;
			let email = myform.email.value;
			
			if(name.trim()=='') {
				alert("이름을 입력해주세요");
				myform.name.focus();
				return false;
			}
			else if(email.trim()=='') {
				alert("이메일을 입력해주세요");
				myform.email.focus();
				return false;
			}
			
			let query = {
					name:name,
					email:email
			};
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/memberIdSearch",
				data : query,
				success : function(res) {
					if(res=="0") {
						alert("찾으시는 정보를 찾을수 없습니다.");
					}
					else {
						alert("찾으시는 아이디는 "+res+"입니다.");
					}
				},
				error : function() {
					alert("전송오류!!");
				}
			});
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>아이디 찾기</h2>
  <p>이름과 이메일 주소를 입력해서 아이디를 찾을수있습니다.</p>
  <form name="myform" method="post">
  	<table class="table table-bordered">
  		<tr>
  			<th>이름</th>
  			<td><input type="text" name="name" id="name" class="form-control"/></td>
  		</tr>
  		<tr>
  			<th>메일주소</th>
  			<td><input type="text" name="email" id="email" class="form-control"/></td>
  		</tr>
  		<tr>
  			<td colspan="2" class="text-center">
  				<input type="button" value="아이디찾기" onclick="idSearch()" class="btn btn-success"/>
  				<input type="reset" value="다시입력" class="btn btn-warning"/>
  				<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-secondary"/>
  			</td>
  		</tr>
  	</table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>

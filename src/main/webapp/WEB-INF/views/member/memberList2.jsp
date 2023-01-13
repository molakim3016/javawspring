<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use stirct';
		
		function midSearch() {
			let mid = myform.mid.value;
			if(mid.trim() == "") {
				alert("아이디를 입력하세요!");
				myform.mid.focus();
			}
			else {
				myform.submit();
			}
		}
		
		function fCheck(mid,nickName,name,gender,birthday,tel,address,email,homePage,job,hobby,content,level,photo) {
			//console.log('');
			let telArr = tel.split('-');
    	if(telArr[1].trim()=="" || telArr[2].trim()=="") tel = "없음";
    	address = address.replace(/\//g, ' ');
			if(level==0) level='관리자';
			else if(level==1) level='운영자';
			else if(level==2) level='우수회원';
			else if(level==3) level='정회원';
			else if(level==4) level='준회원';
			$("#myModal").on("show.bs.modal", function(e){
				$(".modal-body #mid").html(mid);
				$(".modal-body #nickName").html(nickName);
				$(".modal-body #name").html(name);
				$(".modal-body #gender").html(gender);
				$(".modal-body #birthday").html(birthday);
				$(".modal-body #tel").html(tel);
				$(".modal-body #address").html(address);
				$(".modal-body #email").html(email);
				$(".modal-body #homePage").html(homePage);
				$(".modal-body #job").html(job);
				$(".modal-body #hobby").html(hobby);
				$(".modal-body #content").html(content);
				$(".modal-body #level").html(level);
				$(".modal-body #photo").html("<img src=${ctp}/member/"+photo+" width='150px' />");
			});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">
    <c:if test="${empty mid}">전체 회원 리스트</c:if>
    <c:if test="${!empty mid}"><font color='blue'><b>${mid}</b></font> 회원 리스트(총<font color='red'>${pageVO.totRecCnt}</font>건)</c:if>
  </h2>
  <br/>
  <form name="myform">
  	<div class="row mb-2">
  		<div class="col form-inline">
  			<input type="text" name="mid" class="form-control" autofocus/> &nbsp;
  			<input type="button" value="아이디개별검색" onclick="midSearch();" class="btn btn-secondary" />
  		</div>
  		<div class="col text-right"><button type="button" onclick="location.href='${ctp}/member/memberList';" class="btn btn-secondary">전체검색</button></div>
  	</div>
  </form>
  <table class="table table-hover text-center">
  	<tr class="table-dark text-dark">
  		<th>번호</th>
  		<th>아이디</th>
  		<th>별명</th>
  		<th>성명</th>
  		<th>성별</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td>${curScrStartNo}</td>
  			<td><a href="#" onclick="fCheck('${vo.mid}','${vo.nickName}','${vo.name}','${vo.gender}','${vo.birthday}','${vo.tel}','${vo.address}','${vo.email}','${vo.homePage}','${vo.job}','${vo.hobby}','${vo.content}','${vo.level}','${vo.photo}')" data-toggle="modal" data-target="#myModal">${vo.mid}</a></td>
  			<td>${vo.nickName}</td>
  			<td>${vo.name}<c:if test="${sLevel == 0 && vo.userInfor == '비공개'}"><font color='red'>(비공개)</font></c:if></td>
  			<td>${vo.gender}</td>
  		</tr>
  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
  	</c:forEach>
  	<tr><td colspan="5" class="m-0 p-0"></td></tr>
  </table>
</div>
<br/>
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=1&mid=${mid}">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVO.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&mid=${mid}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/member/memberList?pag=${i}&mid=${mid}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${i}&mid=${mid}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&mid=${mid}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVO.pag < pageVO.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${pageVO.totPage}&mid=${mid}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<!-- 블록 페이지 끝 -->

<!-- 주소록을 Modal로 출력하기 -->
<div class="modal fade" id="myModal" style="width:680px;">
	<div class="modal-dialog">
		<div class="modal-content" style="width:600px;">
			<div class="modal-header" style="width:600px;">
				<h4 class="modal-titile">회원 상세정보</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body" style="width:600px;height:400px;overflow:auto;">
				<table class="table table-bordered">
					<tr>
						<th>아이디</th>
						<td id="mid"></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td id="nickName"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td id="name"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td id="gender"></td>
					</tr>
					<tr>
						<th>생일</th>
						<td id="birthday"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td id="tel"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td id="address"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td id="email"></td>
					</tr>
					<tr>
						<th>홈페이지</th>
						<td id="homePage"></td>
					</tr>
					<tr>
						<th>직업</th>
						<td id="job"></td>
					</tr>
					<tr>
						<th>취미</th>
						<td id="hobby"></td>
					</tr>
					<tr>
						<th>자기소개</th>
						<td id="content"></td>
					</tr>
					<tr>
						<th>등급</th>
						<td id="level"></td>
					</tr>
					<tr>
						<th>사진</th>
						<td id="photo"></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer" style="width:600px;">
				<button type="button" class="close btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
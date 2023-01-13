<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	
 		// 전체선택
    $(function(){
    	$(".checkAll").click(function(){
    		if($(".checkAll").prop("checked")) {
	    		$(".chk").prop("checked", true);
    		}
    		else {
	    		$(".chk").prop("checked", false);
    		}
    	});
    });
    
    // 선택항목 반전
    $(function(){
    	$("#reverseAll").click(function(){
    		$(".chk").prop("checked", function(){
    			return !$(this).prop("checked");
    		});
    	});
    });
    
 		// 선택항목 삭제하기(ajax처리하기)
    function selectDelCheck() {
    	let ans = confirm("선택된 모든 게시물을 삭제 하시겠습니까?");
    	if(!ans) return false;
    	let delItems = "";
    	for(let i=0; i<myform.chk.length; i++) {
    		if(myform.chk[i].checked == true) delItems += myform.chk[i].value + "/";
    	}
  		
    	if(delItems == "") {
    		alert('삭제할 게시물을 선택하세요.');
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/file/fileDelete",
    		data : {delItems : delItems},
    		success:function() {
					alert("삭제완료");
				  location.reload();
    		},
    		error  :function() {
    			alert("전송오류!!");
    		}
    	});
    }
  </script>
</head>
<body>

<p><br/></p>
<div class="container">	
  <h2>서버 파일 리스트</h2>
  <hr/>
  <p>서버의 파일 경로 : ${ctp}/data/ckeditor/~~~파일명</p>
  <form name="myform" id="myform">
  
  <div id="btnView" class="row p-2">
	  <div class="col custom-control custom-switch">
		  <input type="checkbox" class="custom-control-input checkAll" id="switch1">
		  <label class="custom-control-label btn btn-success" for="switch1">전체선택/해제</label>
		</div>
	  <div class="col"><input type="button" value="선택반전" id="reverseAll" class="btn btn-primary"/></div>
	  <div class="col"><input type="button" value="선택삭제" onclick="selectDelCheck()" class="btn btn-danger"/></div>
	</div>
	
  <hr/>
  <c:forEach var="file" items="${files}" varStatus="st">
  	<c:if test="${file != 'board'}">
  		<input type="checkbox" name="chk" class="chk" value="${st.index}">
  		<img src="${ctp}/data/ckeditor/${file}" width="150px" /><hr/>
  	</c:if>
  </c:forEach>
  </form>
</div>
<p><br/></p>
</body>
</html>

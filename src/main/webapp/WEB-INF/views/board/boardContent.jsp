<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use strict';
		
		// 전체 댓글(보이기/가리기)
		$(document).ready(function() {
			$("#reply").show();
			$("#replyViewBtn").hide();
			
			$("#replyHiddenBtn").click(function() {
				$("#reply").slideUp(500);
				$("#replyViewBtn").show();
				$("#replyHiddenBtn").hide();
			});

			$("#replyViewBtn").click(function() {
				$("#reply").slideDown(500);
				$("#replyViewBtn").hide();
				$("#replyHiddenBtn").show();
			});
			
		});
		
		function goodCheck() {
			$.ajax({
				type : "post",
				url :	"${ctp}/board/boardGood",
				data : {idx: ${vo.idx}},		// ${vo.idx}는 숫자이기에 이렇게 써도되지만 문자라면 "${vo.idx}" 라고 써야함
				success: function() {
					location.reload();
				},
				error : function() {
					alert("전송 오류~~");
				}
			});
		}
		
		function boardDelCheck() {
			let ans = confirm("현 게시글을 삭제하시겠습니까?");
			if(ans) location.href = "${ctp}/board/boardDeleteOk?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
		}
		
		// 댓글 달기
		function replyCheck() {
			let content = $("#content").val();
			if(content.trim() == ""){
				alert("댓글을 입력하세요.");
				$("#content").focus();
				return false;
			}
			let query = {
					boardIdx : ${vo.idx},
					mid			 : '${sMid}',
					nickName : '${sNickName}',
					content  : content,
					hostIp   : '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type : "post",
				url  : "${ctp}/board/boardReplyInput",
				data : query,
				success:function(res) {
					if(res == "1") {
						alert("댓글이 입력되었습니다.");
						location.reload();
					}
					else {
						alert("댓글 입력 실패~~~");
					}
				},
				error : function() {
					alert("전송 오류!!");
				}
			});
		}
		
		// 댓글 삭제하기
		function replyDelCheck(idx) {
			let ans = confirm("댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/board/boardReplyDeleteOk",
				data : {idx:idx},
				success : function() {
					location.reload();
				},
				error : function() {
					alert("전송 오류~~");
				}
			});
		}
		
		function goodDBCheck(goodSw,goodIdx,partIdx,mid) {
			let query = {
					goodSw:goodSw,
					goodIdx:goodIdx,
					partIdx:partIdx,
					mid:mid
				};
			$.ajax({
				type:"post",
				url:"${ctp}/board/boardDBGood",
				data: query,
				success : function() {
					location.reload();
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
		
		// 답변글(부모댓글의 댓글-대댓글)
		function insertReply(idx,level,levelOrder,nickName) {
			let insReply = '';
			insReply += '<div class="container">';
			insReply += '<table class="m-2 p-0" style="width:90%">';
			insReply += '<tr>';
			insReply += '<td class="p-0 text-left">';
			insReply += '<div>';
			insReply += '답변 댓글 달기 : &nbsp;';
			insReply += '<input type="text" name="nickName" value="${sNickName}" size="6" readonly class="p-0"/>';
			insReply += '</div>';
			insReply += '</td>';
			insReply += '<td>';
			insReply += '<input type="button" value="답글달기" onclick="replyCheck2('+idx+','+level+','+levelOrder+')"/>';
			insReply += '</td>';
			insReply += '</tr>';
			insReply += '<tr>';
			insReply += '<td colspan="2" class="text-center p-0">';
			insReply += '<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'">';
			insReply += '@'+nickName+'\n';
			insReply += '</textarea>';
			insReply += '</td>';
			insReply += '</tr>';
			insReply += '</table>';
			insReply += '</div>';
			
			$("#replyBoxOpenBtn"+idx).hide();
			$("#replyBoxCloseBtn"+idx).show();
			$("#replyBox"+idx).slideDown(500);
			$("#replyBox"+idx).html(insReply);
		}
		
		function updatdReply(idx,content) {
			let insReply = '';
			insReply += '<div class="container">';
			insReply += '<table class="m-2 p-0" style="width:90%">';
			insReply += '<tr>';
			insReply += '<td class="p-0 text-left">';
			insReply += '<div>';
			insReply += '댓글 수정 : &nbsp;';
			insReply += '<input type="text" name="nickNameUpdate" value="${sNickName}" size="6" readonly class="p-0"/>';
			insReply += '</div>';
			insReply += '</td>';
			insReply += '<td>';
			insReply += '<input type="button" value="수정하기" onclick="replyUpdate('+idx+')"/>';
			insReply += '</td>';
			insReply += '</tr>';
			insReply += '<tr>';
			insReply += '<td colspan="2" class="text-center p-0">';
			insReply += '<textarea rows="3" class="form-control p-0" name="contentUpdate" id="contentUpdate'+idx+'">';
			insReply += content;
			insReply += '</textarea>';
			insReply += '</td>';
			insReply += '</tr>';
			insReply += '</table>';
			insReply += '</div>';
			
			$("#replyUpdateBoxOpenBtn"+idx).hide();
			$("#replyUpdateBoxCloseBtn"+idx).show();
			$("#replyUpdateBox"+idx).slideDown(500);
			$("#replyUpdateBox"+idx).html(insReply);
		}
		
		function closeReply(idx) {
			$("#replyBoxOpenBtn"+idx).show();
			$("#replyBoxCloseBtn"+idx).hide();
			$("#replyBox"+idx).slideUp(500);
		}
		
		function closeUpdateReply(idx) {
			$("#replyUpdateBoxOpenBtn"+idx).show();
			$("#replyUpdateBoxCloseBtn"+idx).hide();
			$("#replyUpdateBox"+idx).slideUp(500);
		}
		
		function replyCheck2(idx,level,levelOrder) {
			let boardIdx = "${vo.idx}";
			let mid = "${sMid}";
			let nickName = "${sNickName}";
			let content = $("#content"+idx).val();
			let hostIp = "${pageContext.request.remoteAddr}";
			
			if(content.trim() == "") {
				alert("답변글(대댓글)을 입력하세요!");
				$("#content"+idx).focus();
				return false;
			}
			
			let query={
				boardIdx : boardIdx,
				mid : mid,
				nickName : nickName,
				content : content,
				hostIp : hostIp,
				level : level,
				levelOrder : levelOrder
			};
			
			$.ajax({
				type : "post",
				url : "${ctp}/board/boardReplyInput2",
				data : query,
				success : function() {
					location.reload();
				},
				error : function() {
					alert("전송오류!!");
				}
			});
		}
		
		function replyUpdate(idx) {
			let content = $("#contentUpdate"+idx).val();
			
			if(content.trim() == "") {
				alert("답변글(대댓글)을 입력하세요!");
				$("#contentUpdate"+idx).focus();
				return false;
			}
			
			let query={
				content : content,
				idx:idx
			};
			
			$.ajax({
				type : "post",
				url : "${ctp}/board/boardReplyUpdate",
				data : query,
				success : function() {
					location.reload();
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
  <h2 class="text-center">글 내 용 보 기</h2>
  <br/>
  <table class="table table-borderless">
  	<tr>
  		<td class="text-right">hostIp : ${vo.hostIp}</td>
  	</tr>
  </table>
  <table class="table table-bordered">
  	<tr>
  		<th>글쓴이</th>
  		<td>${vo.nickName}</td>
  		<th>글쓴날짜</th>
  		<td>${fn: substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
  	</tr>
		<tr>
			<th>글제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
  	<tr>
  		<th>전자메일</th>
  		<td>${vo.email}</td>
  		<th>조회수</th>
  		<td>${vo.readNum}</td>
  	</tr>
  	<tr>
  		<th>홈페이지</th>
  		<td>${vo.homePage}</td>
  		<th>좋아요</th>
  		<td><a href="javascript:goodCheck()">
            <c:if test="${fn:contains(sSw,vo.idx)}"><font color="red">❤</font></c:if>
            <c:if test="${!fn:contains(sSw,vo.idx)}">❤</c:if>
          </a>
          ${vo.good} ,
          <a href="javascript:goodCheckPlus()">👍</a>
          <a href="javascript:goodCheckMinus()">👎</a> , 
  				<a href="javascript:goodDBCheck('${goodVO.goodSw}','${goodVO.idx}','${vo.idx}','${sMid}')">
            <c:if test="${goodVO.goodSw == 'Y'}"><font color="red">❤</font></c:if>
            <c:if test="${goodVO.goodSw != 'Y'}">❤</c:if>(토글DB)
          </a>
      </td>
  	</tr>
  	<tr>
  		<th>글내용</th>
  		<td colspan="3" style="height:220px">${fn: replace(vo.content, newLine, "<br/>")}</td>
  	</tr>
  	<tr>
  		<td colspan="4" class="text-center">
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary" />
				<c:if test="${sMid == vo.mid || sLevel == 0}">
	  			<input type="button" value="수정하기" onclick="location.href='${ctp}/board/boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-success" />
	  			<input type="button" value="삭제하기" onclick="boardDelCheck()" class="btn btn-danger" />
				</c:if>
  		</td>
  	</tr>
  </table>
  
  <!-- 이전글/다음글 처리 -->
  <table class="table table-borderless">
  	<tr>
  		<td>
  			<c:if test="${!empty pnVos[1]}">
					다음글 : <a href="${ctp}/board/boardContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">${pnVos[1].title}</a><br/>
				</c:if>
				<c:if test="${pnVos[0].idx > vo.idx}">
					다음글 : <a href="${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">${pnVos[0].title}</a><br/>
				</c:if>
				<c:if test="${pnVos[0].idx < vo.idx}">
					이전글 : <a href="${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">${pnVos[0].title}</a><br/>
				</c:if>
  		</td>
  	</tr>
  </table>
</div>
<br/>

<!-- 댓글(대댓글) 처리 -->
<!-- 댓글 리스트 보여주기 -->
<div class="text-center mb-3">
	<input type="button" value="댓글보이기" id="replyViewBtn" class="btn btn-secondary" />
	<input type="button" value="댓글가리기" id="replyHiddenBtn" class="btn btn-info" />
</div>
<div id="reply" class="container">
	<table class="table table-hover text-left">
		<tr style="background-color:#eee">
			<th>작성자</th>
			<th>댓글내용</th>
			<th class="text-center">작성일자</th>
			<th class="text-center">접속IP</th>
			<th class="text-center">답글</th>
		</tr>
		<c:forEach var="replyVo" items="${replyVos}">
			<tr>
				<td class="text-left">
					<c:if test="${replyVo.level <= 0}">${replyVo.nickName}</c:if>	<!-- 부모댓글의 경우는 들여쓰기하지 않는다. -->
					<c:if test="${replyVo.level > 0}">
						<c:forEach var="i" begin="1" end="${replyVo.level}">&nbsp;&nbsp;</c:forEach> ┗ ${replyVo.nickName}
					</c:if>
					<c:if test="${sMid == replyVo.mid || sLevel == 0}">
						(<a href="javascript:replyDelCheck(${replyVo.idx})" title="삭제하기">x</a>)
					</c:if>
				</td>
				<td>
					${fn:replace(replyVo.content, newLine, "<br/>")}
				</td>
				<td class="text-center">${replyVo.WDate}</td>
				<td class="text-center">${replyVo.hostIp}</td>
				<td class="text-center">
					<input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.level}','${replyVo.levelOrder}','${replyVo.nickName}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-info btn-sm" />
					<input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-warning btn-sm" style="display: none;" />
					<c:if test="${sMid == replyVo.mid}">
						<input type="button" value="수정" onclick="updatdReply('${replyVo.idx}','${replyVo.content}')" id="replyUpdateBoxOpenBtn${replyVo.idx}" class="btn btn-success btn-sm" />
						<input type="button" value="닫기" onclick="closeUpdateReply('${replyVo.idx}')" id="replyUpdateBoxCloseBtn${replyVo.idx}" class="btn btn-warning btn-sm" style="display: none;" />
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyBox${replyVo.idx}"></div></td>
			</tr>
			<tr>
				<td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyUpdateBox${replyVo.idx}"></div></td>
			</tr>
		</c:forEach>
	</table>
	<!-- 댓글 입력창 -->
	<!-- <form name="replyForm" method="post" action=""> -->
	<form name="replyForm">
		<table class="table text-center">
			<tr>
				<td style="width:85%" class="text-left">
					글내용 : <textarea rows="4" name="content" id="content" class="form-control"></textarea>
				</td>
				<td style="width:15%">
					<br/>
					<p>작성자 : ${sNickName}</p>
					<p>
						<input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm" />
					</p>
				</td>
			</tr>
		</table>
		<%-- <input type="hidden" name="boardIdx" value="${vo.idx}" />
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" /> --%>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/></body>
</html>
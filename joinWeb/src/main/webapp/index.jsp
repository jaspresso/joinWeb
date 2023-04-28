<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
   function registerCheckFunction() {
	   var userID = $('#userID').val();
	   $.ajax({
		   type: 'POST',
		   url: './UserRegisterCheckServlet',
		   data: {userID: userID},
		   success: function(result) {
			   if(result == 1){
				   $('#checkMessage').html('사용할 수 있는 아이디입니다.');
				   $('#checkType').attr('class', 'modal-content panel-success');
			   }else{
				   $('#checkMessage').html('사용할 수 없는 아이디입니다.');
				   $('#checkType').attr('class', 'modal-content panel-warning');
			   }
			   $('#checkModal').modal("show");
		   }
	   });
   }
   
   function passwordCheckFunction() {
	   var userPassword1 = $('#userPassword1').val();
	   var userPassword2 = $('#userPassword2').val();
	   if(userPassword1 != userPassword2){
		   $('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	   }else{
		   $('#passwordCheckMessage').html('');
	   }
   }
  </script>
</head>
<body>
	<div class="container">
		<form method="post" action="./userRegister">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 등록 양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><h5>아이디</h5></td>
						<td><input class="form-control" type="text" id="userID"
							name="userID" maxlength="20" placeholder="아이디를 입력해주세요."></td>
						<td><button type="button" class="btn btn-primary" onclick="registerCheckFunction();">중복체크</button></td>
					</tr>
					<tr>
						<td><h5>비밀번호</h5></td>
						<td><input class="form-control" type="password" onkeyup="passwordCheckFunction();"
							id="userPassword1" name="userPassword1" maxlength="20" placeholder="비밀번호를 입력해주세요."></td>
						<td></td>
					</tr>
					<tr>
						<td><h5>비밀번호 확인</h5></td>
						<td colspan="2"><input class="form-control" type="password" onkeyup="passwordCheckFunction();"
							id="userPassword2" name="userPassword2" maxlength="20" placeholder="비밀번호 확인을 입력해주세요."></td>
					</tr>
					<tr>
						<td><h5>이름</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="userName" name="userName" maxlength="20" placeholder="이름을 입력해주세요."></td>
					</tr>
					<tr>
						<td><h5>나이</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="userAge" name="userAge" maxlength="20" placeholder="나이를 입력해주세요."></td>
					</tr>
					<tr>
						<td><h5>성별</h5></td>
						<td colspan="2">
							<div class="btn-group btn-group-toggle" data-toggle="buttons">
								<label class="btn btn-primary active"> 
								  <input type="radio" name="userGender" autocomplete="off" value="남자"
									checked>남자
								</label> 
								<label class="btn btn-primary active"> 
								  <input type="radio" name="userGender" autocomplete="off" value="여자"
									checked>여자
								</label>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control" type="email"
							id="userEmail" name="userEmail" maxlength="20" placeholder="이메일을 입력해주세요."></td>
					</tr>
					<tr>
					  
						<td colspan="3" style="text-align: left;"><h5 style="color: red;" id="passwordCheckMessage"></h5> <input
							class="btn btn-primary pull-right" type="submit" value="회원가입"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
<%
	 String messageContent = null;
	 if(session.getAttribute("messageContent") != null) {
		 messageContent=(String)session.getAttribute("messageContent");
	 }
	 String messageType = null;
	 if(session.getAttribute("messageType") != null) {
		 messageType = (String)session.getAttribute("messageType");
	 }
	 if(messageContent != null){
%>
	
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
	 <div class="vertical-alignment-helper">
	  <div class="modal-dialog vertical-align-center">
	   <div class="modal-content <% if(messageType.equals("오류메시지")) out.println("panel-warning"); else out.println("panel-success"); %>">
	    <div class="modal-header panel-heading">
	     <button type="button" class="close" data-dismiss="modal">
	       <span aria-hidden="true">&times;</span> 
	     </button>
	     <h4 class="modal-title">
	      <%= messageType %>
	     </h4>
	    </div>
	    <div class="modal-body">
	     <%= messageContent %>
	    </div>
	    <div class="modal-footer">
	      <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	    </div>
	   </div>
	  </div>
	 </div>
	</div>
	<script>
	 $('#messageModal').modal("show");
	</script>
	<%
	 session.removeAttribute("messageContent");
	 session.removeAttribute("messageType");
	 }
	%>
	
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
	 <div class="vertical-alignment-helper">
	  <div class="modal-dialog vertical-align-center">
	   <div id="checkType" class="modal-content panel-info">
	    <div class="modal-header panel-heading">
	     <button type="button" class="close" data-dismiss="modal">
	       <span aria-hidden="true">&times;</span> 
	     </button>
	     <h4 class="modal-title">
	      확인 메시지
	     </h4>
	    </div>
	    <div class="modal-body" id="checkMessage">
	    </div>
	    <div class="modal-footer">
	      <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	    </div>
	   </div>
	  </div>
	 </div>
	</div>
	
	
</body>
</html>
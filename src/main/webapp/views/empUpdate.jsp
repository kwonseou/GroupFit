<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>
<body>
	<jsp:include page="GroupFit_gnb.jsp"></jsp:include>

	<div class="content-wrapper" style="margin-top: 57.08px">
		<h3>직원 프로필 수정하기</h3>
		<form action="empUpdate.do" method="post" enctype="multipart/form-data" onsubmit="return test()">
			<table class="table table-dark table-striped">
				<tr>
					<c:if test="${emp.new_photo_name ne null}">
						<img width="90px" height="90px" src="/photo/${emp.new_photo_name}">
					</c:if>
					<input type="file" name="file" multiple="multiple" onchange="previewImage(this)"/>
					<img id="preview" style="max-width: 200px; max-height: 200px;">
					<img src="img/GroupFit_lg_2.png" alt="그룹핏"
						width="90px" height="90px" onerror="this.src='img/GroupFit_lg_2.png'"/>
				</tr>
				<tr>
					<th>*사내번호</th>
					<td><input type="text" name="emp_no" value="${emp.emp_no}" readonly /></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="text" name="pw" value="" id="pw"/></td>
				</tr>
				<tr>
					<th>*이름</th>
					<td><input type="text" name="name" value="${emp.name}" id="name" /></td>
				</tr>
				<tr>
					<th>*성별</th>
					<td>
						<input type="radio" value="남" name="gender" 
						<c:if test="${emp.gender eq '남'}">checked</c:if>
						 />남
						
						<input type="radio" value="여" name="gender"
						<c:if test="${emp.gender eq '여'}">checked</c:if>
						 />여
					</td>
				</tr>
				<tr>
					<th>*생년월일</th>
					<td><input type="date" name="birth" value="${emp.birth}" id="birth"/></td>
				</tr>
				<tr>
					<th>*연락처</th>
					<td><input type="text" name="phone" value="${emp.phone}" id="phone"/></td>
				</tr>
				<tr>
					<th>*이메일</th>
					<td><input type="email" name="email" value="${emp.email}" id="email"/></td>
				</tr>
				<tr>
					<th>*지점번호</th>
					<td>
						<select name="b_idx" id="b_idx">
						    <option value="1" <c:if test="${emp.b_idx eq '1'}">selected="selected"</c:if> >서초</option>
						    <option value="2" <c:if test="${emp.b_idx eq '2'}">selected="selected"</c:if> >방배</option>
						    <option value="3" <c:if test="${emp.b_idx eq '3'}">selected="selected"</c:if> >역삼</option>
						    <option value="4" <c:if test="${emp.b_idx eq '4'}">selected="selected"</c:if> >논현</option>
						</select>			
					</td>
				</tr>
				<tr>
					<th>*직급</th>
					<td>
						<select name="position" id="position">
							<option value="FC" <c:if test="${emp.position eq 'FC'}">selected="selected"</c:if> >FC</option>
						    <option value="트레이너" <c:if test="${emp.position eq '트레이너'}">selected="selected"</c:if> >트레이너</option>
						    <option value="지점장" <c:if test="${emp.position eq '지점장'}">selected="selected"</c:if> >지점장</option>
						    <option value="대표" <c:if test="${emp.position eq '대표'}">selected="selected"</c:if > >대표</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>*재직상태</th>
					<td>
					<select name="status" id="status">
					    <option value="재직" <c:if test="${emp.status eq '재직'}">selected="selected"</c:if> >재직</option>
					    <option value="휴직" <c:if test="${emp.status eq '휴직'}">selected="selected"</c:if> >휴직</option>
					    <option value="퇴직" <c:if test="${emp.status eq '퇴직'}">selected="selected"</c:if> >퇴직</option>
					</select>	
					
					</td>
				</tr>
				<tr>
					<th>*입사일자</th>
					<td><input type="date" id="join_year" name="join_year" value="${emp.join_year}" /></td>
				</tr>
				<tr>
					<th>퇴사일자</th>
					<td><input type="date" id="retire_year" name="retire_year"/></td>
				</tr>
				<input type="submit" value="수정" />
				<button type="button" onclick="location.href='./empList.go'">목록</button>	
				<button type="button" onclick="location.href='./empDelete.do?detailid=${emp.emp_no}'">삭제</button>
			</table>
		</form>
	</div>
</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

function previewImage(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        $('#preview').attr('src', e.target.result);
      };
      reader.readAsDataURL(input.files[0]);
    }
  }

function test() {
	var pw = document.getElementById('pw').value;
	var name = document.getElementById('name').value;
	var gender = $(":input:radio[name=gender]:checked").val();
	var birth = document.getElementById('birth').value;
	var phone = document.getElementById('phone').value;
	var email = document.getElementById('email').value;
	var b_idx = document.getElementById('b_idx').value;
	var position = document.getElementById('position').value;
   	var status = document.getElementById('status').value;
   	var join_year = document.getElementById('join_year').value;
   
   if (pw.trim() != '' && pw.length < 8) {
	   alert('비밀번호는 8자리 이상 입력해주세요!');
	   return false;
	 }
   if (name.trim() == '') {
      alert('이름을 입력해주세요.');
      return false;
   }
   if (!gender) {
      alert('성별을 입력해주세요.');
      return false;
   }
   if (birth.trim() == '') {
      alert('생년월일을 입력해주세요.');
      return false;
   }
   if (phone.trim() == '') {
      alert('연락처를 입력해주세요.');
      return false;
   }
   if (email.trim() == '') {
      alert('이메일을 입력해주세요.');
      return false;
   }
   if (b_idx.trim() == '') {
      alert('지점을 입력해주세요.');
      return false;
   }
   if (position.trim() == '') {
      alert('지점을 입력해주세요.');
      return false;
   }
   if (status.trim() == '') {
      alert('재직상태를 입력해주세요.');
      return false;
   }
   if (join_year.trim() == '') {
      alert('입사일를 입력해주세요.');
      return false;
   }
   return true;
}


</script>
</html>
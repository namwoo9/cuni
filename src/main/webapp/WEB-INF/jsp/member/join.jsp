<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.cuni.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
/*
$(document).on('change', '#name', function(){
	fn_test();
});
function fn_test(){
	var name = $('#name').val();
	alert('dd');
	$.ajax({
		url : '${pageContext.request.contextPath}/user/idCheck?loginId='+ loginId,
		type : 'get',
		success : function(data) {
			console.log("1 = 중복o / 0 = 중복x : "+ data);							
			
			if (data == 1) {
					// 1 : 아이디가 중복되는 문구
					$("#id_check").text("사용중인 아이디입니다 :p");
					$("#id_check").css("color", "red");
					$("#reg_submit").attr("disabled", false);
				} else {
					
					if(idJ.test(loginId)){
						// 0 : 아이디 길이 / 문자열 검사
						$("#id_check").text("");
						$("#reg_submit").attr("disabled", false);
			
					} else if(loginId == ""){
						
						$('#id_check').text('아이디를 입력해주세요 :)');
						$('#id_check').css('color', 'red');
						$("#reg_submit").attr("disabled", false);				
						
					} else {
						
						$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :) :)");
						$('#id_check').css('color', 'red');
						$("#reg_submit").attr("disabled", false);
					}
					
				}
			}, error : function() {
					console.log("실패");
			}
		});
}
*/
// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
// $(document).ready(function(){
	
// });

// alert("11")
$(function(){
	$("#loginId").blur(function() {
		// id = "id_reg" / name = "userId"
		var loginId = $('#loginId').val();
		var loginIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
		$.ajax({	
			url : '${pageContext.request.contextPath}/user/idCheck?loginId='+ loginId,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$('#loginId').focus();
						$("#id_check").text("사용중인 아이디입니다");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} else {
						$("#id_check").text("");
					}
				if (!loginIdCheck.test($('#loginId').val())) {
					
					$('#loginId').focus();		
					$("#id_check").text("영문, 숫자로 5글자 이상 입력 해주세요.");
					$("#id_check").css("color", "red");
				} 
				if (data == 0 && loginIdCheck.test($('#loginId').val())) {
					$("#id_check").text("사용 가능한 아이디입니다.");
					$("#id_check").css("color", "blue");
				}
				if(loginId == ""){
					$('#loginId').val('');
					$('#loginId').focus();		
					$('#id_check').text('아이디를 입력해주세요');
					$('#id_check').css('color', 'red');
					$("#reg_submit").attr("disabled", true);				
				}
				}, error : function() {
						console.log("실패");
				}
			});
		});

	$("#loginPw").blur(function() {
		var loginPw = $(this).val();
		var loginId = $('#loginId').val();
		if(loginPw == ""){
			$('#Pw_check').text('비밀번호를 입력해주세요');
			$('#Pw_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);
		} else if (loginPw.length <= 3) {
			$('#loginPw').val('');
			$('#loginPw').focus();
			$('#Pw_check').text('최소 4자리 입력해주세요');
			$('#Pw_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);
		} else {
			$('#Pw_check').text('');		
			$("#reg_submit").attr("disabled", false);
		}

		if (loginId == loginPw) {
			$('#loginPw').val('');
			$('#loginPw').focus();
			$('#Pw_check').text('아이디와 비밀번호를 다르게 입력해주세요');
			$('#Pw_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);
		}
		// id = "id_reg" / name = "userId"
	});

	$("#loginPwConfirm").blur(function() {
		var loginPwConfirm = $("#loginPwConfirm").val();
		var loginPw = $("#loginPw").val();
		if(loginPw != loginPwConfirm){
			$('#loginPw').val('');
			$('#loginPwConfirm').val('');
			$('#loginPw').focus();
			$('#Pwcf_check').text('비밀번호와 일치하지 않습니다.');
			$('#Pwcf_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);
		} else {
			$('#Pwcf_check').text('');
		}
	});

	$("#email").blur(function() {
		var email = $("#email").val();	
		if(email == null){
			$('#email').focus();
			$('#check_font').text('이메일을 입력하세요');
			$('#check_font').css('color', 'red');
			$("#reg_submit").attr("disabled", true);
		}
	});
});
<!--유효성 검사-->

</script>

<div class="login-box con table-common">
	<form action="./doJoin" method="POST"
		onsubmit="submitJoinForm(this); return false;">
		<!-- " -->
		<table>
			<colgroup>
				<col width="150">
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td><input type="text" id="loginId" name="loginId"
						autocomplete="off" autofocus="autofocus"
						placeholder="아이디를 입력해주세요." maxlength="12" required>
						<div class="check_font" id="id_check"></div></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="loginPw" name="loginPw"
						placeholder="비밀번호를 입력해주세요." maxlength="12" required>
						<div class="check_font" id="Pw_check"></div></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="loginPwConfirm"
						name="loginPwConfirm" placeholder="비밀번호 확인을 입력해주세요."
						maxlength="12" required>
						<div class="check_font" id="Pwcf_check"></div></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" id="name" name="name"
						autocomplete="off" placeholder="닉네임을 입력해주세요." maxlength="10"
						required></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" id="email" name="email"
						placeHolder="이메일 인증을 받으셔야 로그인 하실 수 있습니다." maxlength="20">
						<div class="check_font" id="email_check"></div>
						</td>
				</tr>
				<tr>
					<th>가입</th>
					<td><input class="btn-a" id="reg_submit" type="submit"
						value="가입"> <input class="btn-a" type="reset" value="취소"
						onclick="location.href = '/';"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>
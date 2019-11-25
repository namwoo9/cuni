<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.cuni.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<script>
	var joinFormSubmited = false;

	function submitJoinForm(form) {
		if (joinFormSubmited) {
			alert('처리중입니다.');
			return false;
		}

		var emailP = /\w+@\w+\.\w+\.?\w*/;

		form.loginId.value = form.loginId.value.trim();

		for (var i = 0; i < form.loginId.value.length; i++) {
			ch = form.loginId.value.charAt(i)
			if (!(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z')
					&& !(ch >= '0' && ch <= '9')) {
				alert('아이디는 영문과 숫자만 입력 가능합니다.');
				form.loginId.value = '';
				form.loginId.focus();
				return false;
			}
		}
		// 	 숫자도 가능하게 하려면	!(ch >= '0' && ch <= '9')

		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return false;
		}

		if (form.loginId.value.length <= 3) {
			alert('4자리 이상 입력해주세요');
			form.loginId.value = '';
			form.loginId.focus();
			return false;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length < 4) {
			alert('비밀번호를 4자리 이상 입력해주세요.');
			form.loginPw.value = '';
			form.loginPw.focus();
			return;
		}
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('비밀번호 확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('비밀번호가 같지 않습니다.');
			form.loginPwConfirm.value = "";
			form.loginPwConfirm.focus();
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.name.focus();
			return;
		}

		for (var i = 0; i < form.name.value.length; i++) {
			ch = form.name.value.charAt(i)
			if (!(ch >= '가' && ch <= '힣') && !(ch >= 'a' && ch <= 'z')
					&& !(ch >= 'A' && ch <= 'Z') && !(ch >= '0' && ch <= '9')) {
				alert('닉네임에 특수문자를 사용하실 수 없습니다.');
				form.name.value = '';
				form.name.focus();
				return false;
			}
		}
		// 		var kor = /^[가-힣]+$/;
		// 		var eng = /^[a-zA-Z]{4,10}$/;
		// 		if (eng.test(form.name.value)) {
		// 			alert('영어는 6글자 이하로 적어주세요'');
		// 			form.name.value = '';
		// 			form.name.focus();
		// 			return false;
		// 		}

		if (form.name.value.length < 2) {
			alert('2자리 이상 입력해주세요.');
			form.name.value = "";
			form.name.focus();
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		if (!email.match(emailP)) {
			alert("이메일 형식에 맞지 않습니다.");
			return false;
		}

		form.submit();
		joinFormSubmited = true;
	}
</script>

<div class="login-box con table-common">
	<form action="./doJoin" method="POST"
		onsubmit="submitJoinForm(this); return false;">
		<table>
			<colgroup>
				<col width="150">
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="loginId" autocomplete="off"
						autofocus="autofocus" placeholder="아이디를 입력해주세요." maxlength="12"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="loginPw"
						placeholder="비밀번호를 입력해주세요." maxlength="12"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="loginPwConfirm"
						placeholder="비밀번호 확인을 입력해주세요." maxlength="12"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="name" autocomplete="off"
						placeholder="닉네임을 입력해주세요." maxlength="10"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email"
						placeHolder="이메일을 입력해주세요." maxlength="20"></td>
				</tr>
				<tr>
					<th>가입</th>
					<td><input class="btn-a" type="submit" value="가입"> <input
						class="btn-a" type="reset" value="취소"
						onclick="location.href = '/';"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>
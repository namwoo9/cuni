<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="회원정보 수정" />
<%@ include file="../part/head.jspf"%>

<script>
	function modifyFormSubmited(form) {
		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			alert('닉네임을 입력해주세요');
			form.name.focus();
			return false;
		}

		for (var i = 0; i < form.name.value.length; i++) {
			ch = form.name.value.charAt(i)
			if (!(ch >= '가' && ch <= '힣') && !(ch >= 'a' && ch <= 'z')
					&& !(ch >= 'A' && ch <= 'Z') && !(ch >= '0' && ch <= '9')) {
				alert('닉네임에 특수문자, 공백을 사용하실 수 없습니다.');
				form.name.value = '';
				form.name.focus();
				return false;
			}
		}

		if (form.name.value.length < 2) {
			alert('2자리 이상 입력해주세요');
			form.name.focus();
			return false;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return false;
		}

		form.afterPw.value = form.afterPw.value.trim();

		if (form.afterPw.value.length == 0) {
			alert('변경할 비밀번호를 입력해주세요');
			form.afterPw.value = "";
			form.afterPw.focus();
			return false;
		} else if (form.afterPw.value.length <= 3) {
			alert('4자리 이상 입력해주세요');
			form.afterPw.value = "";
			form.afterPw.focus();
			return false;
		}

		form.checkPw.value = form.checkPw.value.trim();

		if (form.checkPw.value.length == 0) {
			alert('비밀번호 확인 입력해주세요');
			form.checkPw.focus();
			return false;
		}

		if (form.afterPw.value != form.checkPw.value) {
			alert('변경할 비밀번호와 일치하지 않습니다');
			form.checkPw.value = "";
			form.checkPw.focus();
			return false;
		}

		form.submit();
	}
</script>

<div class="con table-common">
	<form action="./doModify" method="POST"
		onsubmit="modifyFormSubmited
			(this); return false;">
		<table>
			<colgroup>
				<col width="150">
			</colgroup>
			<tbody>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="name" value="${loginedMember.name}"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" value="${loginedMember.email}"></td>
				</tr>
				<!-- 				<tr> -->
				<!-- 					<th>기존 비밀번호</th> -->
				<!-- 					<td><input type="password" name="beforePw"></td> -->
				<!-- 				</tr> -->
				<tr>
					<th>변경할 비밀번호</th>
					<td><input type="password" name="afterPw" maxlength="10"
						placeholder="변경할 비밀번호"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="checkPw" maxlength="10"
						placeholder="변경할 비밀번호 확인"></td>
				</tr>

				<tr>
					<th>수정</th>
					<td><input class="btn-a" type="submit" value="수정"> <input
						class="btn-a" type="reset" value="취소"
						onclick="location.href = '/member/myPage?id=${loginedMember.id}';">
						<button class="btn-a" type="button"
							onclick="if ( confirm('정말 탈퇴하시겠습니까?') ) location.href = './doSecession'">회원탈퇴</button></td>

				</tr>

			</tbody>
		</table>
	</form>


</div>
<%@ include file="../part/foot.jspf"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 모바일에서 디바이스의 해상도가 아닌 디바이스의 실제 크기를 기준으로 너비/높이를 잡는다. -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>채팅방</title>
<link rel="stylesheet" href="/css/chat/main.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="/js/chat/main.js"></script>
</head>
<body>
	<div id="chat-room">
		<div class="message-box" id="style-1">
			<div class="message-group" data-date-str="2019년 07월 10일 수요일">
				
			</div>
		</div>
		<div class="input-box">
			<input type="text" id="text-input">
			<div class="btn-plus">
				<i class="fa fa-plus" aria-hidden="true"></i>
			</div>
			<div class="btn-emo">
				<i class="fa fa-smile-o" aria-hidden="true"></i>
			</div>
			<div class="btn-submit">
				<span>전송</span>
			</div>
		</div>
	</div>

</body>
</html>
 	
var chatWriter = prompt('닉네임을 입력해주세요');

chatWriter = chatWriter.trim();
if (chatWriter == null) {
	location.href="/";
}
if (chatWriter <= 0) {
	alert('공백은 사용 하실 수 없습니다');
	location.href="/chat/main";
} else if (chatWriter.length < 2) {
	alert('2자리 이상 입력해주세요');
	location.href="/chat/main";
}
for (var i = 0; i < chatWriter.length; i++) {
	ch = chatWriter.charAt(i);
	if (!(ch >= '가' && ch <= '힣') && !(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z') && !(ch >= '0' && ch <= '9')) {
		alert('올바른 닉네임을 입력해주세요.');
		location.href="/chat/main";
	}
}


// $('.data-date-str').contents().wrap('<a href="/"
// class="data-date-str"></a>');

function Chat__sendMessage() {
    // val()은 엘리먼트가 가지고 있는 value 속성의 값을 가져온다.
    var 메세지 = $('#chat-room .input-box #text-input').val();
    
    
    메세지 = 메세지.trim(); // 메시지 양끝에 있는 공백제거
    
    chatWriter = chatWriter.trim();
    
    if (chatWriter == '') {
    	alert('닉네임을 입력하세요');
    	location.href="/chat/main";
    	return false;
    }
    // 메세지 변수에 들어있는 값이 ''와 같다면
    if ( 메세지 == '' ) {
        // 함수를 더 이상 진행시키지 않고 여기서 종료시킨다.
        $('#chat-room .input-box #text-input').val('');
        $('#chat-room .input-box #text-input').focus();
        return false;
    }
    	
    $.post(
    	'./addMessage',
    	{
    		writer:chatWriter,
    		body:메세지
    	},
    	function(data) {
    		
    	},
    	'json'
    );
    
    // val(문자열)은 엘리먼트가 가지고 있는 value 속성의 값을 입력받은 문자열로 교체하라는 뜻입니다.
    $('#chat-room .input-box #text-input').val('');
      $('#chat-room .input-box #text-input').focus();
}

var Chat__lastReceivedMessageId = -1;

function Chat__loadNewMessages() {
	$.get(
		'./getMessages',
		{
			from: Chat__lastReceivedMessageId + 1
		},
		function(data) {
			for ( var i = 0; i < data.length; i++ ) {
				var message = data[i];
				Chat__lastReceivedMessageId = message.id;
				Chat__drawMessage(message);
			}
			
			setTimeout(Chat__loadNewMessages, 200);
			
		}
	);
}

function Chat__drawMessage(message) {
	var 메세지 = message.body;
	var writer = message.writer;
	
	var whoClassName = 'mine';

	if ( writer != chatWriter ) {
		whoClassName = 'other';
	}
	
	var html = `
	    <div class="chat-message ${whoClassName}">
	        <section><i class="fa fa-user"></i></section>
	        <span>${writer}</span>
	        <div>${메세지}</div>
	    </div>
	    `;
    
    $('#chat-room .message-group:last-child').append(html);
    
    $('#chat-room .message-box').scrollTop(99999999999);
};

$(function() {
	$('#chat-room .input-box .btn-submit').click(Chat__sendMessage);
	
	// input 창에서 키보드 눌림 이벤트 발생시 함수를 실행하도록 예약
	$('#chat-room .input-box #text-input').keydown(function(e) {
	    // 만약 입력한 키코드가 13, 즉 엔터라면 함수를 실행한다.
	    if ( e.keyCode == 13 ) {
	    	Chat__sendMessage();
	    }
	});
	
	Chat__loadNewMessages();
});
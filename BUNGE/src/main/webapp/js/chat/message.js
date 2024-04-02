$(function(){

    const webSocket = new WebSocket('ws://localhost:8088/chat');
    const $inputMessage = $(".type_msg");

    webSocket.onerror = function(e){
        onError(e);
    };

    webSocket.onopen = function(e){
        onOpen(e);
    };

    webSocket.onmessage = function(e){
        onMessage(e);
    };

    function onMessage(e){
        console.log("메세지 왔다");

        const chatData = JSON.parse(e.data);
  /*      const date = new Date();
        var dateInfo = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();

        if(chatMsg.substring(0,6) == 'server'){
            var $chat = $("<div class='chat notice'>" + chatMsg[0].msg + "</div>");
            $('#chat-container').append($chat);
        }else{
            var $chat = $("<div class='chat-box'><div class='chat'>" + chatMsg + "</div><div class='chat-info chat-box'>"+ dateInfo +"</div></div>");
            $('#chat-container').append($chat);
        }
        var $chat = $("<div class='chat-box'><div class='chat'>" + chatMsg[0].msg + "</div><div class='chat-info chat-box'>"+ dateInfo +"</div></div>");
        $('#chat-container').append($chat);*/

        console.log("onMessage chatId: " + chatData[0].chatId);
        console.log("onMessage sellerId: " + chatData[0].sellerId);
        console.log("onMessage buyerId: " + chatData[0].buyerId);

        if (chatData[0].chatId != selectedChatId) {
            return;
        }
        if (chatData[0].sellerId != selectedSellerId || chatData[0].buyerId != selectedBuyerId) {
            return;
        }

        const $chat = $(`
                    <div class="d-flex justify-content-start mb-4">
                        <div class="img_cont_msg">
                            <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
                                 class="rounded-circle user_img_msg">
                        </div>
                        <div class="msg_cotainer">
                            ${chatData[0].msg}
                            <span class="msg_time">${chatData[0].time}</span>
                        </div>
                    </div>
        `);
        $('.msg_card_body').append($chat);

        // $('.msg_card_body').scrollTop($('.msg_card_body')[0].scrollHeight+20);
    }

    function onOpen(e){
        console.log("오픈 확인용: ");
    }

    function onError(e){
        alert(e.data);
    }

    function send(){

        const chatMsg = $inputMessage.val();
        console.log(chatMsg);
        if(chatMsg == ''){
            return;
        }
        const date = new Date();
        const dateInfo = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        console.log("send dateInfo" + dateInfo);
        const $chat = $(`
                    <div class="d-flex justify-content-end mb-4">
                        <div class="msg_cotainer_send">
                            ${chatMsg}
                            <span class="msg_time_send">${dateInfo}</span>
                        </div>
                    </div>
        `);
        $('.msg_card_body').append($chat);

        const chatData = selectedChatId + "|split|" + selectedSellerId + "|split|" +
            selectedBuyerId + "|split|" + chatMsg;;
        webSocket.send(chatData);
        $inputMessage.val("");
        // $('.msg_card_body').scrollTop($('.msg_card_body')[0].scro\llHeight+20);

        $.ajax({
            type: "post",
            url: "messageStore.com",
            data: {"chatId": selectedChatId, "content": chatMsg},
            dataType: "json",
            success: function (rdata) {
                if (rdata.length > 0) {
                    console.log("메세지 저장 성공");
                }
            },
        });
    }

    $inputMessage.keydown(function(key){
        if(key.keyCode == 13){
            $('.type_msg').focus();
            $('.send_btn').click();
            return;
        }
        console.log("type_msg keydown");
    });

    $('.send_btn').click(function(){
        send();
        $inputMessage.val("");
        console.log("send_btn click");
    });

    function loadMessage() {
        console.log("loadMessage() Start");
        $.ajax({
            type: "post",
            url: "messageLoad.com",
            data: {"chatId": selectedChatId},
            dataType: "json",
            success: function (rdata) {
                console.log(rdata);

                let chat = "";
                $(rdata).each(function () {
                    if (loginId == this.memberId) {
                        chat += `
                        <div class="d-flex justify-content-end mb-4">
                            <div class="msg_cotainer_send">
                                ${this.content}
                                <span class="msg_time_send">${this.sendDate.substring(11, 16)}</span>
                            </div>
                        </div>
                    `;
                    } else {
                        chat += `
                        <div class="d-flex justify-content-start mb-4">
                            <div class="img_cont_msg">
                                <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
                                     class="rounded-circle user_img_msg">
                            </div>
                            <div class="msg_cotainer">
                                ${this.content}
                                <span class="msg_time">${this.sendDate.substring(11, 16)}</span>
                            </div>
                        </div>
                        `;
                    }
                });
                $('.msg_card_body').html(chat);
            },
        })

        console.log("loadMessage() End");
    }

    $(document).on('click', '.contacts li', function () {
        console.log("loadMessage() 클릭")
        loadMessage();
    });
})
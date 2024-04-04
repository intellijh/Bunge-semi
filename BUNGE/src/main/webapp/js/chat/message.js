let webSocket = "";

function loadMessage() {
    console.log("loadMessage() Start");
    $('.msg_card_body').empty();
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

$(function(){

    webSocket = new WebSocket('ws://localhost:8088/chat');
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
        const chatId = chatData[0].chatId;
        const sellerId = chatData[0].sellerId;
        const buyerId = chatData[0].buyerId;
        const msg = chatData[0].msg;
        let time = chatData[0].time

        console.log("onMessage chatId: " + chatId);
        console.log("onMessage sellerId: " + sellerId);
        console.log("onMessage buyerId: " + buyerId);

        // 자기한테 온 메세지인지 확인
        if (sellerId != loginId && buyerId != loginId) {
            return;
        }

        $("#" + chatId).find("p:eq(0)").text(msg);
        $("#" + chatId).find("p:eq(1)").text(time.substring(0, 16));

        console.log("return문 넘김");

        if (chatId != selectedChatId) {
            return;
        }

        const $chat = $(`
                    <div class="d-flex justify-content-start mb-4">
                        <div class="img_cont_msg">
                            <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
                                 class="rounded-circle user_img_msg">
                        </div>
                        <div class="msg_cotainer">
                            ${msg}
                            <span class="msg_time">${time.substring(10, 16)}</span>
                        </div>
                    </div>
        `);
        $('.msg_card_body').append($chat);

        $('.msg_card_body').scrollTop($('.msg_card_body')[0].scrollHeight+20);
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
        if(chatMsg == ""){
            return;
        }
        const date = new Date();
        const year = date.getFullYear();
        const month = `00${date.getMonth()}`.slice(-2);
        const todayDate = `00${date.getDate()}`.slice(-2);
        const hours = `00${date.getHours()}`.slice(-2);
        const minutes = `00${date.getMinutes()}`.slice(-2);
        const dateInfo = `${year}-${month}-${todayDate} ${hours}:${minutes}`;

        console.log("send dateInfo" + dateInfo);
        const $chat = $(`
                    <div class="d-flex justify-content-end mb-4">
                        <div class="msg_cotainer_send">
                            ${chatMsg}
                            <span class="msg_time_send">${dateInfo.substring(11)}</span>
                        </div>
                    </div>
        `);
        $('.msg_card_body').append($chat);

        const chatData = selectedChatId + "|split|" + selectedSellerId + "|split|" +
            selectedBuyerId + "|split|" + chatMsg;
        webSocket.send(chatData);
        $inputMessage.val("");
        $('.msg_card_body').scrollTop($('.msg_card_body')[0].scrollHeight+20);

        $.ajax({
            type: "post",
            url: "messageStore.com",
            data: {"chatId": selectedChatId, "content": chatMsg},
            dataType: "json",
            success: function (rdata) {
                if (rdata == 1) {
                    console.log("메세지 저장 성공");
                    $("#" + selectedChatId).find("p:eq(0)").text(chatMsg);
                    $("#" + selectedChatId).find("p:eq(1)").text(dateInfo);
                    // getChatList();
                }
            },
        });
    }

    $inputMessage.keydown(function(event){
        if (event.key === "Enter") {
            $('.type_msg').focus();
            $('.send_btn').click();
            event.preventDefault();
        }
    });

    $('.send_btn').click(function(){
        if ($inputMessage.val().trim() == "" || $inputMessage.val() == null) {
            return;
        }
        send();
        $inputMessage.val("");
        console.log("send_btn click");
    });
})
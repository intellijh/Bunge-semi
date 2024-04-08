let webSocket = "";

function loadMessage() {

    console.log("loadMessage() Start");
    $(".msg_card_body").empty();
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
                                <img src="image/profile.png"
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
            $(".msg_card_body").html(chat);
            $(".msg_card_body").scrollTop($(".msg_card_body")[0].scrollHeight);
        },
    })

    console.log("loadMessage() End");
}

$(function(){

    webSocket = new WebSocket('ws://localhost:8088/BUNGE/chat');
    const $inputMessage = $(".type_msg");

    webSocket.onerror = function(e){
        onError(e);
    };

    webSocket.onopen = function(e){
        onOpen(e);
    };

    webSocket.onmessage = function(e){

        console.log("메세지 왔다");
        console.log(e.data);

        // 채팅 데이터
        const chatData = JSON.parse(e.data);
        const chatId = chatData[0].chatId;
        const sellerId = chatData[0].sellerId;
        const buyerId = chatData[0].buyerId;
        const msg = chatData[0].msg;
        let time = chatData[0].time

        console.log("onMessage chatId: " + chatId);
        console.log("onMessage sellerId: " + sellerId);
        console.log("onMessage buyerId: " + buyerId);
        console.log("onMessage msg: " + msg);

        // 자기한테 온 메세지인지 확인
        if (sellerId != loginId && buyerId != loginId) {
            return;
        }

        if (!$("#" + chatId).length) {
            let output = "";
            output +=
                `<li id=${chatId} style="cursor: pointer">
                            <div class="d-flex bd-highlight">
                                <div class="img_cont">
                                    <img src="image/profile.png"
                                         class="rounded-circle user_img">
                                    <span class="online_icon"></span>
                                </div>
                                <div class="user_info">`;

            // 채팅 정보 리스트에 출력
            if (this.sellerId == loginId) {
                output += `     <span class="buyer">${buyerId}</span>
                                    <p class="info_msg">${msg}</p>
                                    <p>${time}</p>`;
            } else {
                output += `     <span class="seller">${sellerId}</span>
                                    <p class="info_msg">${this.msg}</p>
                                    <p>${time}</p>`;
            }
            output += `
                                </div>
                            </div>
                        </li>`;
            $(".contacts").append(output);
            console.log("chatId length");
        }
        console.log("chatId length end");

        // 채팅 목록 메세지 날짜 업데이트
        if (msg == " ") {
            $("#" + chatId).find(".user_info span").text("알 수 없는 사용자");
        }
        $("#" + chatId).find("p:eq(0)").text(msg);
        $("#" + chatId).find("p:eq(1)").text(time.substring(0, 16));

        // 리스트 최상단으로 채팅 이동
        console.log(document.getElementById(chatId).outerHTML);
        const updateChatHtml = document.getElementById(chatId).outerHTML;
        $("#" + chatId).remove();
        $(".contacts").prepend(updateChatHtml);

        // 선택한 채팅방만 채팅방 화면에 메세지 업데이트
        if (chatId != selectedChatId) {
            return;
        }

        if (msg == " ") {
            deleteMessage(e);
            return;
        }

        onMessage(e);
    };

    function onMessage(e){

        const chatData = JSON.parse(e.data);
        const msg = chatData[0].msg;
        let time = chatData[0].time

        // 스크롤 위치
        const scrollPosition = $(".msg_card_body").prop("scrollTop");
        const scrollHeight = $(".msg_card_body").prop("scrollHeight") - $(".msg_card_body").prop("clientHeight");

        const $chat = $(`
                    <div class="d-flex justify-content-start mb-4">
                        <div class="img_cont_msg">
                            <img src="image/profile.png"
                                 class="rounded-circle user_img_msg">
                        </div>
                        <div class="msg_cotainer">
                            ${msg}
                            <span class="msg_time">${time.substring(10, 16)}</span>
                        </div>
                    </div>
        `);
        $(".msg_card_body").append($chat);

        // 메세지 수신 시 사용자의 스크롤 위치가 최하단일때만 자동 스크롤 적용
        if (scrollPosition == scrollHeight) {
            $(".msg_card_body").scrollTop($(".msg_card_body")[0].scrollHeight);
        }
    }

    function deleteMessage(e) {
        $(".user_info.chat_top").find("span").text("알 수 없는 사용자");
        $(".delete_msg").remove();
        $(".msg_card_body").after("<div class='delete_msg'>상대방이 채팅을 삭제했습니다</div>");
        $(".type_msg").val("");
        $(".type_msg").prop("readonly", true);
    }

/*
    function onMessage(e){

        console.log("메세지 왔다");
        console.log(e.data);
        // 스크롤 위치
        const scrollPosition = $(".msg_card_body").prop("scrollTop");
        const scrollHeight = $(".msg_card_body").prop("scrollHeight") - $(".msg_card_body").prop("clientHeight");

        // 채팅 데이터
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

        // 채팅 목록 메세지 날짜 업데이트
        $("#" + chatId).find("p:eq(0)").text(msg);
        $("#" + chatId).find("p:eq(1)").text(time.substring(0, 16));

        // 리스트 최상단으로 채팅 이동
        console.log(document.getElementById(chatId).outerHTML);
        const updateChatHtml = document.getElementById(chatId).outerHTML;
        $("#" + chatId).remove();
        $(".contacts").prepend(updateChatHtml);

        // 선택한 채팅방만 채팅방 화면에 메세지 업데이트
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
        $(".msg_card_body").append($chat);

        // 메세지 수신 시 사용자의 스크롤 위치가 최하단일때만 자동 스크롤 적용
        if (scrollPosition == scrollHeight) {
            $(".msg_card_body").scrollTop($(".msg_card_body")[0].scrollHeight);
        }
    }
*/

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
        $(".msg_card_body").append($chat);

        const chatData = selectedChatId + "|split|" + selectedSellerId + "|split|" +
            selectedBuyerId + "|split|" + chatMsg;
        webSocket.send(chatData);
        $inputMessage.val("");
        $(".msg_card_body").scrollTop($(".msg_card_body")[0].scrollHeight);

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

    $inputMessage.keydown(function (e) {
        console.log(e);
        if (e.key === "Enter") {
            $('.send_btn').click();
            e.preventDefault();
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
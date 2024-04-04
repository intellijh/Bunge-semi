let selectedChatId = 0;
let selectedSellerId = "";
let selectedBuyerId = ""
let loginId = "";

function getChatList() {
    console.log("getList");
    let sessionChatId = $("#sessionChatId").val();
    console.log("session chat 데이터: " + sessionChatId);
    
    // 세션으로 넘겨준 chatId 있는 지 확인
    if (sessionChatId == null || sessionChatId == "") {
        sessionChatId = 0;
    }
    console.log("session chat 데이터 0으로: " + sessionChatId);
    $.ajax({
        type: "post",
        url: "chatLoad.com",
        data: {"chatId": sessionChatId},
        dataType: "json",
        success: function (rdata) {
            console.log("getChat rdata: " + rdata);

            if (rdata.length <= 0) {
                console.log("getList length 안");
                $(".contacts").empty();
                return;
            }

            let output = ``;
            $(rdata).each(function () {
                console.log(this);
                console.log(this.sellerId);
                console.log(this.buyerId);
                console.log(this.chatId);

                output +=
                    `<li id=${this.chatId} style="cursor: pointer">
                            <div class="d-flex bd-highlight">
                                <div class="img_cont">
                                    <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
                                         class="rounded-circle user_img">
                                    <span class="online_icon"></span>
                                </div>
                                <div class="user_info">`;
                console.log("getChatList() loginId: " + loginId);

                // 상대방이 채팅방 나간 사용자인지 확인
                if (this.sellerId == null || this.sellerId == "") {
                    this.sellerId = "알 수 없는 사용자";
                } else if (this.buyerId == null || this.buyerId == "") {
                    this.buyerId = "알 수 없는 사용자";
                }

                // 채팅 정보 리스트에 출력
                if (this.sellerId == loginId) {
                    output += `     <span class="buyer">${this.buyerId}</span>
<!--                                    <p>${this.sellerId}</p>-->
                                    <p>${this.latestContent}</p>
                                    <p>${this.updateDate}</p>`;
                } else {
                    output += `     <span class="seller">${this.sellerId}</span>
<!--                                    <p>${this.buyerId}</p>-->
                                    <p>${this.latestContent}</p>
                                    <p>${this.updateDate}</p>`;
                }

                output += `
                                </div>
                            </div>
                        </li>`;
            });
            $(".contacts").html(output);

            console.log("initial selectedChatId: " + selectedChatId);

            console.log("stored chatId = " + selectedChatId);
            console.log("stored sellerId = " + selectedSellerId);
            console.log("stored buyerId = " + selectedBuyerId);

            // 세션으로 넘겨준 chatId 없으면 최상단 채팅 선택
            selectedChatId = sessionChatId;
            if (selectedChatId == 0) {
                $(".contacts li").eq(0).click();
                console.log("click !!!");
            } else {
                $("#" + selectedChatId).click();
                console.log("getChatList 아이디 0 아닐 때 클릭");
            }
        }
    });
}

$(document).on('click', '.contacts li', function() {

    selectedChatId = $(this).attr("id");
    console.log("this: " + $(this).find("span").text());

    const position = $(this).find("span");
    if (position.hasClass("seller")) {
        selectedSellerId = $(this).find(".seller").text();
        selectedBuyerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
        $(".chat_top").html(`<span>${selectedSellerId}</span>`);
        console.log("click p1: " + $(this).find("p").eq(0).text());
    } else {
        selectedBuyerId = $(this).find(".buyer").text();
        selectedSellerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
        $(".chat_top").html(`<span>${selectedBuyerId}</span>`);
        console.log("click p2: " + $(this).find("p").eq(0).text());
    }

    console.log("click chatId = " + selectedChatId);
    console.log("click sellerId = " + selectedSellerId);
    console.log("click buyerId = " + selectedBuyerId);
    $(".contacts li").removeClass("active");
    $(this).addClass("active");
    loadMessage();
    // getChatList();
});

function deleteChat() {

    $.ajax({
        type: "post",
        url: "chatDelete.com",
        data: {"chatId": selectedChatId, "sellerId": selectedSellerId},
        dataType: "json",
        success: function (rdata) {
            if (rdata == 1) {
                selectedChatId = 0;
                getChatList();
            }
        }
    });

    // webSocket.send()
}

$(document).on("click", ".delete-chat-btn", function () {
    console.log("삭제 클릭");
    deleteChat();
    $("#action_menu_btn").click();
});

$(function () {
    loginId = $("#loginId").val();
    console.log("myId = " + loginId);

    $('#action_menu_btn').click(function () {
        $(".action_menu").toggle();
    });
    console.log("load");

    getChatList();
});

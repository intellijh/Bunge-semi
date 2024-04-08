let selectedChatId = 0;
let selectedSellerId = "";
let selectedBuyerId = ""
let loginId = "";

function getChatList() {

    console.log("getList");
    let $sessionChatId = $("#sessionChatId");
    console.log("session chat 데이터: " + $sessionChatId.val());
    
    // 세션으로 넘겨준 chatId 있는 지 확인
    if ($sessionChatId.val() == null || $sessionChatId.val() == "") {
        console.log("getChatList sessionChatId null 체크");
        $sessionChatId.val(0);
    }
    console.log("session chat 데이터 0으로: " + $sessionChatId.val());
    $.ajax({
        type: "post",
        url: "chatLoad.com",
        data: {"chatId": $sessionChatId.val()},
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
                                    <img src="image/profile.png"
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
                                    <p class="info_msg">${this.latestContent}</p>
                                    <p>${this.updateDate}</p>`;
                } else {
                    output += `     <span class="seller">${this.sellerId}</span>
                                    <p class="info_msg">${this.latestContent}</p>
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
            selectedChatId = $sessionChatId.val();
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

    // 선택한 채팅 정보 변수에 저장
    selectedChatId = $(this).attr("id");
    console.log("this: " + $(this).find("span").text());

    const position = $(this).find("span");
    if (position.hasClass("seller")) {
        selectedSellerId = $(this).find(".seller").text();
        selectedBuyerId = loginId;
        $(".chat_top").html(`<span>${selectedSellerId}</span>`);
        console.log("click p1: " + $(this).find("p").eq(0).text());
    } else {
        selectedBuyerId = $(this).find(".buyer").text();
        selectedSellerId = loginId;
        $(".chat_top").html(`<span>${selectedBuyerId}</span>`);
        console.log("click p2: " + $(this).find("p").eq(0).text());
    }

    console.log("click chatId = " + selectedChatId);
    console.log("click sellerId = " + selectedSellerId);
    console.log("click buyerId = " + selectedBuyerId);
    
    $(".contacts li").removeClass("active");
    $(this).addClass("active");
    
    // 채팅 메세지 로드
    loadMessage();

    $(".delete_msg").remove();
    $(".type_msg").prop("readonly", false);

    if ($(this).find("span").text() == "알 수 없는 사용자") {
        $(".msg_card_body").after("<div class='delete_msg'>상대방이 채팅을 삭제했습니다</div>");
        const scrollPosition = $(".msg_card_body").prop("scrollTop");
        const scrollHeight = $(".msg_card_body").prop("scrollHeight") - $(".msg_card_body").prop("clientHeight");
        if (scrollPosition == scrollHeight) {
            $(".msg_card_body").scrollTop($(".msg_card_body")[0].scrollHeight);
        }
        $(".type_msg").prop("readonly", true);
    }
});

function deleteChat() {

    console.log("deleteChat() sellerId: " + selectedSellerId);
    $.ajax({
        type: "post",
        url: "chatDelete.com",
        data: {"chatId": selectedChatId, "sellerId": selectedSellerId},
        dataType: "json",
        success: function (rdata) {
            if (rdata == 1) {
                const deleteData = selectedChatId + "|split|" + selectedSellerId + "|split|" +
                    selectedBuyerId + "|split|" + "|delete|";
                console.log("deleteData: " + deleteData);
                webSocket.send(deleteData);
                selectedChatId = 0;
                getChatList();
            }
        }
    });
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

    // 채팅 검색 기능
    $(".search").on("keyup", function () {
        const value = $(this).val().toLowerCase();
        $(".contacts li .user_info").filter(function () {
            $(this).closest("li").toggle($(this).children().text().toLowerCase().indexOf(value) > -1)
        });
    });
});

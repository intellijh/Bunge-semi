let selectedChatId = 0;
let selectedSellerId = "";
let selectedBuyerId = ""
let loginId = "";

function getChatList() {

    let $sessionChatId = $("#sessionChatId");

    // 세션으로 넘겨준 chatId 있는 지 확인
    if ($sessionChatId.val() == null || $sessionChatId.val() == "") {
        $sessionChatId.val(0);
    }

    $.ajax({
        type: "post",
        url: "chatLoad.com",
        data: {"chatId": $sessionChatId.val()},
        dataType: "json",
        success: function (rdata) {

            if (rdata.length <= 0) {
                $(".contacts").empty();
                $(".card").hide();
                let output = "";
                output +=
                    "<div class='no-chat'>" +
                    "   아직 채팅이 없습니다.<br><br>" +
                    "   <button style='border: none; padding: 10px 15px; background: #BCE55C'>" +
                    "       <a href='trade.net' style='text-decoration-line: none'>대화하러 가기</a>" +
                    "   </button>" +
                    "</div>";
                $(".container-fluid").prepend(output);
                return;
            }

            $(".no-chat").remove();

            let output = ``;
            $(rdata).each(function () {

                output +=
                    `<li id=${this.chatId} style="cursor: pointer">
                            <div class="d-flex bd-highlight">
                                <div class="img_cont">
                                    <img src="image/profile.png"
                                         class="rounded-circle user_img">
                                    <span class="online_icon"></span>
                                </div>
                                <div class="user_info">`;

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

            // 세션으로 넘겨준 chatId 없으면 최상단 채팅 선택
            selectedChatId = $sessionChatId.val();
            if (selectedChatId == 0) {
                $(".contacts li").eq(0).click();
            } else {
                $("#" + selectedChatId).click();
            }
        }
    });
}

$(document).on('click', '.contacts li', function() {

    // 선택한 채팅 정보 변수에 저장
    selectedChatId = $(this).attr("id");

    const position = $(this).find("span");
    if (position.hasClass("seller")) {
        selectedSellerId = $(this).find(".seller").text();
        selectedBuyerId = loginId;
        $(".chat_top").html(`<span>${selectedSellerId}</span>`);
    } else {
        selectedBuyerId = $(this).find(".buyer").text();
        selectedSellerId = loginId;
        $(".chat_top").html(`<span>${selectedBuyerId}</span>`);
    }

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

    $.ajax({
        type: "post",
        url: "chatDelete.com",
        data: {"chatId": selectedChatId, "sellerId": selectedSellerId},
        dataType: "json",
        success: function (rdata) {
            if (rdata == 1) {
                const deleteData = selectedChatId + "|split|" + selectedSellerId + "|split|" +
                    selectedBuyerId + "|split|" + "|delete|";
                webSocket.send(deleteData);
                selectedChatId = 0;
                getChatList();
            }
        }
    });
}

$(document).on("click", ".delete-chat-btn", function () {
    deleteChat();
    $("#action_menu_btn").click();
});

$(function () {
    loginId = $("#loginId").val();

    // 토글 메뉴 클릭 이벤트
    $('#action_menu_btn').click(function () {
        $(".action_menu").toggle();
    });

    // 메뉴 외 클릭 시 닫기
    $("body").click(function (e) {
        if ($(e.target).parent("#action_menu_btn").length >= 1) {
            return;
        }
        $(".action_menu").hide();
    });

    getChatList();

    // 채팅 검색 기능
    $(".search").on("keyup", function () {
        const value = $(this).val().toLowerCase();
        $(".contacts li .user_info").filter(function () {
            $(this).closest("li").toggle($(this).children().text().toLowerCase().indexOf(value) > -1)
        });
    });
});

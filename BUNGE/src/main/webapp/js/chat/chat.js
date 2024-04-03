let selectedChatId = 0;
let selectedSellerId = "";
let selectedBuyerId = ""
let loginId = "";

function getChatList() {

    console.log("getList");
    $.ajax({
        type: "post",
        url: "chatLoad.com",
        dataType: "json",
        success: function (rdata) {

            if (rdata.chatList.length <= 0) {
                console.log("getList length 안");
                $(".contacts").empty();
                return;
            }

            let output = ``;
            $(rdata.chatList).each(function () {
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
                if (this.sellerId == loginId) {
                    output += `     <span class="buyer">${this.buyerId}</span>
                                    <p>${this.sellerId}</p>
                                    <p>${this.updateDate}</p>`;
                } else {
                    output += `     <span class="seller">${this.sellerId}</span>
                                    <p>${this.buyerId}</p>
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

            if (selectedChatId == 0) {
                $(".contacts li").eq(0).click();
                console.log("click !!!");
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
    $("#"+selectedChatId).addClass("active");
    loadMessage();
    // getChatList();
});

function deleteChat() {

    $.ajax({
        type: "post",
        url: "chatDelete.com",
        data: {"chatId": selectedChatId},
        dataType: "json",
        success: function (rdata) {
            if (rdata == 1) {
                getChatList();
            }
        }
    });
}

$(document).on("click", ".delete-chat-btn", function () {
    console.log("삭제 클릭");
    deleteChat();
});
$(document).on("click", ".test_btn", function () {
    console.log("테스트 버튼");
    getChatList();
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

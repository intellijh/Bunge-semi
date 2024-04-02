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
            console.log("ajax");
            if (rdata.chatList.length <= 0) {
                return;
            }

            console.log("0over?");
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
                // $("li").addClass("active");
            });
            $(".contacts").html(output);

            if (selectedChatId == 0) {
                selectedChatId = $(".contacts li").eq(0).attr("id");
                const position = document.querySelector(".contacts li:first-child .user_info span").classList;
                console.log("position: " + position);
                if (position.contains("seller")) {
                    selectedSellerId = $(".contacts li:eq(0) .user_info .seller").text();
                    selectedBuyerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
                } else {
                    selectedBuyerId = $(".contacts li:eq(0) .user_info .buyer").text();
                    selectedSellerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
                }
            }
            console.log("stored chatId = " + selectedChatId);
            console.log("stored sellerId = " + selectedSellerId);
            console.log("stored buyerId = " + selectedBuyerId);

            $(".contacts li").removeClass("active");
            $("#"+selectedChatId).addClass("active");
        }
    });

    // setTimeout(getChatList, 1000);
}

$(document).on('click', '.contacts li', function() {

    selectedChatId = $(this).attr("id");
    console.log("this: " + $(this).find("span").text());

    const position = $(this).find("span");
    if (position.hasClass("seller")) {
        selectedSellerId = $(this).find(".seller").text();
        selectedBuyerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
        console.log("click p1" + $(this).find("p").eq(0).text());
    } else {
        selectedBuyerId = $(this).find(".buyer").text();
        selectedSellerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
        console.log("click p2" + $(this).find("p").eq(0).text());
    }

    console.log("click chatId = " + selectedChatId);
    console.log("click sellerId = " + selectedSellerId);
    console.log("click buyerId = " + selectedBuyerId);
    getChatList();
});

$(function () {
    loginId = $("#loginId").val();
    console.log("myId = " + loginId);

    $('#action_menu_btn').click(function () {
        $('.action_menu').toggle();
    });
    console.log("load");

    getChatList();
});

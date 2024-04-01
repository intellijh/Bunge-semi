let selectedChatId = 0;
let selectedSellerId = null;
let selectedBuyerId = null;

function getChatList() {

    console.log("getList");
    $.ajax({
        type: "post",
        url: "chatLoad.com",
        data: {"loginId": $("#loginId").val()},
        dataType: "json",
        success: function (rdata) {
            console.log("ajax");
            if (rdata.chatList.length <= 0) {
                return;
            }
            const loginId = $("#loginId").val();
            console.log("loginId = " + loginId);

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
                if (this.sellerId == loginId) {
                    output += `     <span>${this.buyerId}</span>
                                    <p>${this.sellerId}</p>
                                    <p>${this.updateDate}</p>`;
                } else {
                    output += `     <span>${this.sellerId}</span>
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
                selectedSellerId = $(".contacts li:eq(0) .user_info span").text();
                selectedBuyerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
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
    selectedSellerId = $(".contacts li:eq(0) .user_info span").text();
    selectedBuyerId = $(".contacts li:eq(0) .user_info p:eq(0)").text();
    console.log("click chatId = " + selectedChatId);
    console.log("click sellerId = " + selectedSellerId);
    console.log("click buyerId = " + selectedBuyerId);
    getChatList();
});

$(function () {
    $('#action_menu_btn').click(function () {
        $('.action_menu').toggle();
    });
    console.log("load");

    getChatList();
});

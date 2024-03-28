function getList() {
    console.log("getList");
    $.ajax({
        type: "post",
        url: "chatLoad.com",
        data: {"loginId": $("#loginId").val()},
        dataType: "json",
        success: function (rdata) {
            console.log("ajax");
            if (rdata.chat.length > 0) {
                console.log("0over?");
                let output = ``;
                $(rdata.chat).each(function () {
                    console.log(rdata.chat);
                    output +=
                        `<li>
                            <div class="d-flex bd-highlight">
                                <div class="img_cont">
                                    <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
                                         class="rounded-circle user_img">
                                    <span class="online_icon"></span>
                                </div>
                                <div class="user_info">
                                    <span>${this.sellerId}</span>
                                    <p>${this.buyerId}</p>
                                    <p>${this.openDate}</p>
                                </div>
                            </div>
                        </li>`;
                });
                $(".contacts").html(output);
            }
        }
    });
}

$(function () {
    $('#action_menu_btn').click(function () {
        $('.action_menu').toggle();
    });
    console.log("load");

    getList();
});
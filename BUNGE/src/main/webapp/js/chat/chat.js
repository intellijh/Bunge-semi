let chatId = 0;

function getChatList() {
    console.log("getList");
    $.ajax({
        type: "post",
        url: "chatLoad.com",
        data: {"loginId": $("#loginId").val()},
        dataType: "json",
        success: function (rdata) {
            console.log("ajax");
            if (rdata.chat.length <= 0) {
                return;
            }
            const loginId = $("#loginId").val();
            console.log("loginId = " + loginId);

            console.log("0over?");
            let output = ``;
            $(rdata.chat).each(function () {
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

            if (chatId == 0) {
                chatId = $(".contacts li").eq(0).attr("id");
            }
            console.log("stored chatId = " + chatId);
            // $(".contacts li").click(function () {
            //     chatId = $(this).attr("id");
            //     console.log("click chatId = " + chatId);
            // });



            $(".contacts li").removeClass("active");
            $("#"+chatId).addClass("active");
        }
    });

    // setTimeout(getChatList, 1000);
}

$(document).on('click', '.contacts li', function() {
    chatId = $(this).attr("id");
    console.log("click chatId = " + chatId);
    getChatList();
});

// getMessage = setInterval(function () {
//
//     $.ajax({
//         type: "post",
//         url: "messageLoad.com",
//         data: {"loginId": $("#loginId").val()},
//         dataType: "json",
//         success: function (rdata) {
//             console.log("ajax");
//             if (rdata.chat.length > 0) {
//                 console.log("0over?");
//                 let output = ``;
//                 $(rdata.chat).each(function () {
//                     console.log(rdata.chat);
//                     output +=
//                         `<li>
//                             <div class="d-flex bd-highlight">
//                                 <div class="img_cont">
//                                     <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
//                                          class="rounded-circle user_img">
//                                     <span class="online_icon"></span>
//                                 </div>
//                                 <div class="user_info">
//                                     <span>${this.sellerId}</span>
//                                     <p>${this.buyerId}</p>
//                                     <p>${this.openDate}</p>
//                                 </div>
//                             </div>
//                         </li>`;
//                 });
//                 $(".contacts").html(output);
//             }
//         }
//     });
// }, 3000);

function sendMessage() {
    let msg = $(".type_msg").val();
    console.log(msg);
    if (msg == null) {
        return;
    }

    // $.ajax({
    //     type: "post",
    //     url: "chatLoad.com",
    //     data: {"loginId": $("#loginId").val()},
    //     dataType: "json",
    //     success: function (rdata) {
    //         console.log("ajax");
    //         if (rdata.chat.length > 0) {
    //             console.log("0over?");
    //             let output = ``;
    //             $(rdata.chat).each(function () {
    //                 console.log(rdata.chat);
    //                 output +=
    //                     `<li>
    //                         <div class="d-flex bd-highlight">
    //                             <div class="img_cont">
    //                                 <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
    //                                      class="rounded-circle user_img">
    //                                 <span class="online_icon"></span>
    //                             </div>
    //                             <div class="user_info">
    //                                 <span>${this.sellerId}</span>
    //                                 <p>${this.buyerId}</p>
    //                                 <p>${this.openDate}</p>
    //                             </div>
    //                         </div>
    //                     </li>`;
    //             });
    //             $(".contacts").html(output);
    //         }
    //     }
    // });
}

$(function () {
    $('#action_menu_btn').click(function () {
        $('.action_menu').toggle();
    });
    console.log("load");

    // $(".send_btn").click(function () {
    //     console.log("click");
    //     sendMessage();
    // });

    getChatList();
});

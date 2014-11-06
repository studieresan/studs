$(function() {
    var logo = $(".hide-nav-logo");
    $(window).scroll(function() {
        var scroll = $(window).scrollTop();
        if (scroll >= 320) {
        	logo.fadeIn(400);
        } else {
        	logo.fadeOut(400);
        }
    });
});
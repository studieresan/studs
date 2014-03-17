$(function() {
    $('.post').each(function(i, e) {
        var maxHeight = $(e).find('.post-content').css('maxHeight');
        var readMoreOpen = $(e).find('.read-more-open');
        var readMoreClose= $(e).find('.read-more-close');
        readMoreOpen.on('click', function() {
            $(e).find('.post-content').css({maxHeight: '100%'});
            readMoreOpen.addClass("hide");
            readMoreClose.removeClass("hide");
        });
        readMoreClose.on('click', function() {
            $(e).find('.post-content').css({maxHeight: maxHeight});
            readMoreOpen.removeClass("hide");
            readMoreClose.addClass("hide");
        })
    });
});
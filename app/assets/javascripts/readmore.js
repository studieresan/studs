$(window).bind("load", function() {
    $('.post').each(function(i, e) {
        var expandedHeight;
        var postContent = $(e).find('.post-content');
        var collapsedHeight = postContent.height();
        var maxHeight = postContent.css('maxHeight');
        var readMoreOpen = $(e).find('.read-more-open');
        var readMoreClose = $(e).find('.read-more-close');
        readMoreOpen.on('click', function() {
            readMoreOpen.addClass("hide");
            readMoreClose.removeClass("hide");
            postContent.css({maxHeight: '100%'}); // Set max-height to 100% in order to be able to get expanded height
            expandedHeight = postContent.css('height', '100%').height();
            postContent.css('height', collapsedHeight); // Reset to correct (collapsed) height
            postContent.animate({
                height: expandedHeight + "px"
            }, 1000);
        });
        readMoreClose.on('click', function() {
            readMoreOpen.removeClass("hide");
            readMoreClose.addClass("hide");
            postContent.animate({
                height: collapsedHeight + "px"
            }, 1000);
        });
    })
});

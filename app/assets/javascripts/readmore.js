$(function() {
    $('.post').each(function(i, e) {
        var postContent = $(e).find('.post-content');
        var collapsedHeight = postContent.height();
        var maxHeight = postContent.css('maxHeight');
        postContent.css({maxHeight: '100%'}); // Set max-height to 100% in order to be able to get expanded height
        var expandedHeight = postContent.css('height', '100%').height();
        postContent.css('height', collapsedHeight); // Reset to correct (collapsed) height
        var readMoreOpen = $(e).find('.read-more-open');
        var readMoreClose = $(e).find('.read-more-close');
        readMoreOpen.on('click', function() {
            readMoreOpen.addClass("hide");
            readMoreClose.removeClass("hide");
            postContent.animate({
                height: expandedHeight + "px"
            }, 1000);
        });
        readMoreClose.on('click', function() {
            readMoreOpen.removeClass("hide");
            readMoreClose.addClass("hide");
            // Only scroll if the expanded height is bigger than collapsed height
            if (parseInt(expandedHeight) > parseInt(collapsedHeight)) {
                $('html, body').animate({
                    scrollTop: postContent.offset().top
                }, 1000);
            }
            postContent.animate({
                height: collapsedHeight + "px"
            }, 1000);
        });
    })
});

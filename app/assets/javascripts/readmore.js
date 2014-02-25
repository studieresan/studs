$(function() {
    $('.post .read-more').each(function(i, e) {
        $(e).on('click', function() {
            $(e).parent().find('.post-content').css({maxHeight: '100%'});
            $(e).hide();
        });
    });
});
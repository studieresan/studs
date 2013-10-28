$(function() {
  /** Smooth scrolling to anchor */
  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        if ($('#navigation-bar .navbar-collapse.in').length == 1) { 
          //If responsive menu is not collapsed, collapse it.
          $('#navigation-bar .navbar-toggle').click();
        }
        $('html,body').animate({
          scrollTop: target.offset().top - 70
        }, 500);
        return false;
      }
    }
  });
});
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

window.requestAnimFrame = (function(){
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          window.oRequestAnimationFrame      ||
          window.msRequestAnimationFrame     ||
          function( callback ){
            window.setTimeout(callback, 1000 / 60);
          };
})();

(function(win, d) {

  var $ = d.querySelector.bind(d);

  var header = $('.header');
  var intro = $('.intro');
  var team = $('.the-team');

  var ticking = false;
  var lastScrollY = 0;

  function onResize () {
    updateElements(win.scrollY);
  }

  function onScroll (evt) {

    if(!ticking) {
      ticking = true;
      window.requestAnimationFrame(updateElements);
      lastScrollY = win.scrollY;
    }
  }

  function updateElements () {

    var relativeY = lastScrollY / 4000;

    // prefix(header.style, "Transform", "translate3d(0px," + pos(0, 400, relativeY, 0) + 'px, 0)');

    if (window.chrome && navigator.platform.indexOf("Linux") !== -1) {
      team.style.backgroundPosition = '0px ' + pos(0, 800, relativeY, 0) + 'px';
    } else {
      prefix(team.style, "Transform", "translate3d(0px," + pos(0, 800, relativeY, 0) + 'px, 0)');
    }

    ticking = false;
  }

  function pos(base, range, relY, offset) {
    return base + limit(0, 1, relY - offset) * range;
  }

  function prefix(obj, prop, value) {

    var prefs = ['webkit', 'Moz', 'o', 'ms'];
    for (var pref in prefs) {
      obj[prefs[pref] + prop] = value;
    }
  }

  function limit(min, max, value) {
    return Math.max(min, Math.min(max, value));
  }

  (function() {

    updateElements(win.scrollY);

  })();

  win.addEventListener('resize', onResize, false);
  win.addEventListener('scroll', onScroll, false);

})(window, document);
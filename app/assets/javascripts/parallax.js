var Environment = {
    //mobile or desktop compatible event name, to be used with '.on' function
    TOUCH_DOWN_EVENT_NAME: 'mousedown touchstart',
    TOUCH_UP_EVENT_NAME: 'mouseup touchend',
    TOUCH_MOVE_EVENT_NAME: 'mousemove touchmove',
    TOUCH_DOUBLE_TAB_EVENT_NAME: 'dblclick dbltap',

    isAndroid: function() {
        return navigator.userAgent.match(/Android/i);
    },
    isBlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    isIOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    isOpera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    isWindows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    isMobile: function() {
        return (Environment.isAndroid() || Environment.isBlackBerry() || Environment.isIOS() || Environment.isOpera() || Environment.isWindows());
    },
    isRetina: function() {
        return window.devicePixelRatio > 1;
    }
};

if (Environment.isRetina() && !Environment.isMobile()) {

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

        if (header == undefined ||intro == undefined || team == undefined) {
            return;
        }

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

            prefix(team.style, "Transform", "translate3d(0px," + pos(0, 800, relativeY, 0) + 'px, 0)');

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
}
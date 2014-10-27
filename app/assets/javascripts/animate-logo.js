$(function() {
	var controller = new ScrollMagic();
	var tween = TweenMax.to("#main-logo", 1, {right: '1300px', height: '70px', top: '0px'});
	var scene = new ScrollScene({duration: 400, offset: 0})
								.setTween(tween)
                .addTo(controller);
});
$(function() {

    var container = $('#instagram-all-images');
    if (container.length === 0)
    	return; // Element not found

    var min_img_width = 200;

    function onResize() {

    	var rowsize = 1;
    	
    	while ((rowsize+1)*min_img_width <= container.width())
    		rowsize++;


    	var side = Math.floor(container.width() / rowsize);
    	container.children('div').width(side).height(side);
    }

    $(window).resize(onResize);
});
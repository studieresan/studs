$(function() {

    var container = $('.instagram-img-container').first();
    var limit = parseInt(container.attr('limit'));

    CLIENT_ID = '763c0316965b4483b1b97e024bbcb6e1';
    TAGS = ['studs2014', 'studs14']

    var photos = [];

    function sortPhotos() {
        photos.sort(function(a, b) { return b[0]-a[0] }); // Sort descending on create_time
    }

    function addPhotos() {
        for (var i = 0; i < Math.min(photos.length, limit); i++) {
            container.append(photos[i][1]);
        }
        $(window).trigger('resize'); // Trigger resize event to adjust img sizes
    }

    function removeTags(caption) {
        return caption.replace(/#[^\s]+/igm , '');
    }

    function joinTags(tags) {
        for (var i = 0; i < tags.length; i++)
            tags[i] = '#' + tags[i];

        return tags.join(' ');
    }

    // Request photos for all tags recursively
    var i = 0;
    function requestTag(i) {
        var url = 'https://api.instagram.com/v1/tags/' + TAGS[i] + '/media/recent?client_id=' + CLIENT_ID + '&callback=?'
        
        $.getJSON( url, function( response ) {
            $.each( response.data, function( idx, data ) {
                if (data.type == "image") {
                    photos.push( [ 
                        parseInt(data.created_time), 
                        '<div>' + 
                        '<img alt="" src="' + data.images.low_resolution.url + '"/>' +
                        '<p class="caption">' + (data.caption ? removeTags(data.caption.text) : '') + '</p>' +
                        '<p class="tags">' + (data.tags ? joinTags(data.tags) : '') + '</p>' +
                        '</div>'
                    ] );
                }
            });
        })
        .done(function() {
            if (i+1 < TAGS.length) {
                requestTag(i+1);
            } else {
                sortPhotos();
                addPhotos();
            }
        });
    }

    // Kick off tag requesting
    requestTag(0);
});

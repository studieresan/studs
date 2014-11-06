$(function() {

    var container = $('.instagram-img-container').first();
    var limit = parseInt(container.attr('limit'));

    CLIENT_ID = '763c0316965b4483b1b97e024bbcb6e1';
    TAGS = ['studs15']

    var next_max_tag_ids = $.map(TAGS, function() { return 'null'; });
    var is_loading = false;
    var photos_to_add = [];
    var added_photos = 0;

    function sortNewPhotos() {
        photos_to_add.sort(function(a, b) { return b[0]-a[0] }); // Sort descending on create_time
    }

    function addNewPhotos() {
        for (var i = 0; i < photos_to_add.length; i++) {
            if (added_photos >= limit)
                break;

            container.append(photos_to_add[i][1]);
            added_photos++;
        }
        photos_to_add = [];
        
        $(window).trigger('resize'); // Trigger resize event to adjust img sizes
    }

    // function removeTags(caption) {
    //     return caption.replace(/#[^\s]+/igm , '');
    // }

    function joinTags(tags) {
        for (var i = 0; i < tags.length; i++)
            tags[i] = '#' + tags[i];
        return tags.join(' ');
    }

    // Request photos for all tags recursively
    var i = 0;
    function requestTag(i) {
        if (i >= TAGS.length) {
            sortNewPhotos();
            addNewPhotos();
            is_loading = false;
            return;
        }

        if (next_max_tag_ids[i] === null) {
            requestTag(i+1);
            return;
        }

        var url = 'https://api.instagram.com/v1/tags/' + TAGS[i] + '/media/recent?' 
            + 'client_id=' + CLIENT_ID 
            + '&max_tag_id=' + next_max_tag_ids[i]
            + '&callback=?';

        $.getJSON( url, function( response ) {
            $.each( response.data, function( idx, data ) {
                if (data.type == "image") {
                    photos_to_add.push( [ 
                        parseInt(data.created_time), 
                        '<div>' + 
                        '<img alt="" src="' + data.images.low_resolution.url + '"/>' +
                        '<p class="caption">' + (data.caption ? data.caption.text : '') + '</p>' +
                        '<p class="tags">' + (data.tags ? joinTags(data.tags) : '') + '</p>' +
                        '</div>'
                    ] );
                }
            });

            if ('next_max_tag_id' in response.pagination) {
                next_max_tag_ids[i] = response.pagination.next_max_tag_id;
            } else {
                next_max_tag_ids[i] = null;
            }
        })
        .done(function() {
            requestTag(i+1);
        });
    }

    function loadMore() {
        if (is_loading || added_photos >= limit)
            return;
        is_loading = true;
        photos_to_add = [];
        requestTag(0); // Kick off tag requesting
    }

    loadMore(); // Initial loading

    // Load more on scroll or resize if we're near bottom of document
    $(window).on('scroll resize', function() {
        if ($(window).scrollTop() > $(document).height() - $(window).height() - 220) // 220 min img width/height
            loadMore();
    });
});

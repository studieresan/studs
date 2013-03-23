$(function() {
  // Countdowns
  $('ul.countdown').each(function() {
    var $container = $(this);
    // Server provided timestamps for current time and countdown end time
    var server_now = $container.data('current');
    var server_end = $container.data('to');
    if (!server_now || !server_end || server_now >= server_end)
      return;

    // Adjusted (local) end time and remaining time in seconds
    var end_time = (server_end - server_now)*1000 + new Date().getTime();
    var remaining = (end_time - Math.round(new Date().getTime())) / 1000;
    
    // Callback which updates countdown
    var interval = null;
    interval = setInterval(function() {
      // Update remaining time
      var rem = --remaining;
      if (rem <= 0) {
        clearInterval(interval);
        rem = 0;
      }

      // Selectors and denominators for each unit
      var selector = ['days', 'hours', 'minutes', 'seconds'];
      var divider = [24*60*60, 60*60, 60, 1];

      // Update and substract each unit
      for (var i = 0; i < selector.length; i++) {
        var val = Math.floor(rem / divider[i]);
        rem %= divider[i];
        $container.find('li.'+selector[i]+' strong').text(val);
      }
    }, 1000);
  });
});

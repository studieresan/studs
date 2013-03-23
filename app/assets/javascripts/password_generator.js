$(function() {
  // Add random password generation button to users form
  var $input = $('input#user_password');
  if ($input.length) {
    // References to relevant DOM elements
    var $input_confirm = $('input#user_password_confirmation');
    var $container = $input.closest('.input');
    // I18n text for generate button
    var text = $input.data('generate');
    // Generate password generation button and insert after the password input
    $('<input type="button" id="password_generatator" value="'+text+'" />')
      .appendTo($container)
      .click(function() {
        // Generate random string
        var alphabet = 'abcdefghjkmnpqrstuvwxyz0123456789';
        var pwd = '';
        for (var i = 0; i < 10; i++)
          pwd += alphabet.charAt(Math.floor(Math.random() * alphabet.length));
        // Update password & confirmation inputs, unmasking password input
        $input.val(pwd).prop('type', 'text');
        $input_confirm.val(pwd);
      });

    // Revert back to password input if user modifies password
    $input.keypress(function(ev) {
      if (ev.which !== 0 && !ev.ctrlKey && !ev.metaKey && $input.prop('type') != 'password')
        $input.prop('type', 'password');
    });
  }
})

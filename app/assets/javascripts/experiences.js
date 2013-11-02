$(function() {
  // Experience end_date toggling
  $('#experience_no_end_date').bind('click change', function() {
    var $this = $(this);
    $this.closest('div').find('.end_date')[$this.is(':checked') ? 'hide' : 'show']();
  }).change();
});

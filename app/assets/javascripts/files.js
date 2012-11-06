$(function() {
  $('table.files a.action.replace').click(function() {
    $('input#file_name').val($(this).closest('tr').find('a.download').text());
    $('input#file_file').click();
    return false;
  });
});

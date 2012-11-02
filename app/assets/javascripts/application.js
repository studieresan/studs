//= require suggester
//= require tagger

$(function() {
  $('input[data-suggestions]').suggester();

  // Resume form tag input
  $('#resume_skill_list').tagger();

  // Resume search form & listing
  var $searchForm = $('form.resume-search');
  if ($searchForm.length) {
    var $tagger = $searchForm.find('input#s').tagger({
      allowDragging: false
    });

    var $table = $('table.resumes');
    $table.on('click', 'a.tag, a.itag', function() {
      console.log("Add: " + $(this).text());
      $tagger.tagger('addTag', $(this).text());
      return false;
    });
  }

  // Experience end_date toggling
  $('#experience_no_end_date').bind('click change', function() {
    var $this = $(this);
    $this.closest('.wrap').find('.select')[$this.is(':checked') ? 'hide' : 'show']();
  }).click();
});

//= require suggester
//= require tagger

$(function() {
  // Resume form tag input
  $('#resume_skill_list').suggester().tagger();

  // Resume search form & listing
  var $searchForm = $('form.resume-search');
  if ($searchForm.length) {
    var $tagger = $searchForm.find('input#s').suggester().tagger({
      allowDragging: false
    });

    var $table = $('table.resumes');
    $table.on('click', 'a.tag, a.itag', function() {
      console.log("Add: " + $(this).text());
      $tagger.tagger('addTag', $(this).text());
      return false;
    });
  }
});

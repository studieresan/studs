$(function() {
  var $table = $('table.resumes');
  if (!$table.length) return;

  // Resume form tag input
  $('#resume_skill_list').tagger();

  // Resume search form & listing
  var $searchForm = $('form.resume-search');
  if ($searchForm.length) {
    var $tagger = $searchForm.find('input#s').tagger({
      allowDragging: false
    });

    $table.on('click', 'a.tag, a.itag', function() {
      console.log("Add: " + $(this).text());
      $tagger.tagger('addTag', $(this).text());
      return false;
    });
  }
});

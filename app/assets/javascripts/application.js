//= require suggester
//= require tagger

$(function() {
  // Resume form tag input
  $('#resume_skill_list').suggester().tagger();

  // Resume search form
  $('form.resume-search').each(function() {
    var $form = $(this);
    $form.find('input#skills').suggester().tagger({
      allowDragging: false
    });
  })
});

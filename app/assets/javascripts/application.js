//= require jquery
//= require bootstrap
//= require script
//= require suggester
//= require tagger
//= require resumes
//= require experiences
//= require files
//= require password_generator

$(function() {
  // Enable suggestions for all inputs with a suggestions data attribute
  $('input[data-suggestions]').suggester();
});

$(function() {
  $('#instagram-feed').instagram({
    hash: 'studs2013',
    show: 6,
    clientId: 'afcc1e598062435789439adb642a9933'
  })
});

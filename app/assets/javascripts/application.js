//= require jquery
//= require bootstrap
//= require script
//= require suggester
//= require tagger
//= require resumes
//= require experiences
//= require files
//= require password_generator
//= require upload

$(function() {
  // Enable suggestions for all inputs with a suggestions data attribute
  $('input[data-suggestions]').suggester();
});

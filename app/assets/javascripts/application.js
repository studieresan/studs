//= require jquery
//= require bootstrap
//= require script
//= require suggester
//= require tagger
//= require resumes
//= require experiences
//= require files
//= require password_generator
//= require markdown
//= require to-markdown
//= require bootstrap-markdown
//= require charts
//= require readmore
//= require lightbox
//= require TweenMax.min
//= require jquery.scrollmagic.min
//= require animate-logo
//= require instagram
//= require auto-size-instagram

$(function() {
  // Enable suggestions for all inputs with a suggestions data attribute
  $('input[data-suggestions]').suggester();
});

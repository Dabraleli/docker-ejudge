$(document).ready(function() {
  var table = $(".standings tr").length;
  $(".standings").width("10%");
  for (var i = 0; i < 3; i++) {
  	$('.standings tr:last').remove();
  }
  setInterval(function() {
    cache_clear()
  }, 30000);
});

function cache_clear() {
  window.location.reload(true);
}
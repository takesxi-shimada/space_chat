// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//

$(
function () {
  var timer = 0;
  $('#btn-submit').mousedown(function() {
    timer = (new Date()).getTime();
    console.log(timer);
    document.getElementById('btn-submit').src = '/images/ui/btn-submit_2.png';
  });
  $('#btn-submit').mouseup(function() {
    var end = (new Date()).getTime();
    var size = end - timer;
    console.log(size);
    document.getElementById('btn-submit').src = '/images/ui/btn-submit_1.png';
  });
}
);

$(function() {
  //開くボタンを押した時には
  $("#search").click(function () {
    $("#search-wrap").addClass('panelactive');
  });

  //閉じるボタンを押した時には
  $(".close-btn").click(function () {
      $("#search-wrap").removeClass('panelactive');
  });
});
$(document).on('turbolinks:load', function() {
  $(function() {
    $("ul.menu li").hover(
      function() {
        $(".menuSub:not(:animated)", this).slideDown();
      },
      function() {
        $(".menuSub", this).slideUp();
      }
    );
  });
});
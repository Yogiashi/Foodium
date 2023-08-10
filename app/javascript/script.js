// トップページのスライドショー
$(function() {
  let slideIndex = 0;
  showSlides();

  function showSlides() {
    // スライドの要素を取得
    const slides = document.querySelectorAll(".slide.fade");

    // slideIndexを1増やす（次のスライドに進む）
    slideIndex++;

    // スライドの数よりもslideIndexが大きくなった場合、最初のスライドに戻る
    if (slideIndex > slides.length) {
      slideIndex = 1;
    }

    // 現在のスライドを表示（opacityを1に設定）
    slides[slideIndex - 1].style.opacity = "1";

    // 1つ前のスライドを非表示（opacityを0に設定）
    slides[slideIndex - 2 < 0 ? slides.length - 1 : slideIndex - 2].style.opacity = "0";

    // 一定時間（6000ミリ秒＝6秒）後に再度showSlides関数を呼び出す（次のスライドに進むための処理）
    setTimeout(showSlides, 4000);
  }
});

$(function(){
$('#slick01').slick({
autoplay: true, //自動再生
dots: true, //ドットインジケータの表示
});
});

// タブ機能
$(function() {
  $('.tab').click(function(){
    $('.tab-active').removeClass('tab-active');
    $(this).addClass('tab-active');
    $('.box-show').removeClass('box-show');
    const index = $(this).index();
    $('.tabbox').eq(index).addClass('box-show');
  });
});

// サイドバーの検索フォーム一覧
$(function() {
  //開くボタンを押した時
  $("#search").click(function () {
    $("#search-wrap").addClass('panelactive');
  });

  //閉じるボタンを押した時
  $(".close-btn").click(function () {
      $("#search-wrap").removeClass('panelactive');
  });
});

$(function() {
//ボタンのイベント
  $(".btn1").click(function(){
    $(".search-form").show('slow');
    $(".btn1").hide('slow')
  });
});

$(document).on('click touchend', function(event) {
  // 表示した検索フォーム以外の部分をクリックしたとき
  if (!$(event.target).closest('.search-group').length) {
    $('.search-form').hide('slow');
     $(".btn1").show('slow');
  }
});

// 画像プレビュー機能
$(function() {
  function readURL(input) {
      if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
  $('.img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      }
  }
  $(document).on('change', '.img_field', function(){
    readURL(this);
  });
});// ロゴをクリックするとページの最上部にスクロール
$(function() {
$('#top a').on('click',function(event){
  $('body, html').animate({
    scrollTop:0
  }, 800);
  event.preventDefault();
});
});
// ユーザー詳細ページの編集・削除ボタン
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
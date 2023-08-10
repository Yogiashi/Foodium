// トップページのスライドショー
$(function(){
    $('.slider').slick({
    autoplay: true,//自動的に動き出すか。初期値はfalse。
    autoplaySpeed: 3000,//次のスライドに切り替わる待ち時間
    speed:1000,//スライドの動きのスピード。初期値は300。
    infinite: true,//スライドをループさせるかどうか。初期値はtrue。
    slidesToShow: 1,//スライドを画面に3枚見せる
    slidesToScroll: 1,//1回のスクロールで3枚の写真を移動して見せる
    arrows: true,//左右の矢印あり
    prevArrow: '<div class="slick-prev"></div>',//矢印部分PreviewのHTMLを変更
    nextArrow: '<div class="slick-next"></div>',//矢印部分NextのHTMLを変更
    dots: true,//下部ドットナビゲーションの表示
        pauseOnFocus: false,//フォーカスで一時停止を無効
        pauseOnHover: false,//マウスホバーで一時停止を無効
        pauseOnDotsHover: false,//ドットナビゲーションをマウスホバーで一時停止を無効
    });
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
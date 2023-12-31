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

// サイドバーの検索フォーム
$(function() {
  $("#search").click(function () {
    $("#search-wrap").addClass('panelactive');
  });

  //閉じるボタンを押した時
  $(".close-btn").click(function () {
      $("#search-wrap").removeClass('panelactive');
  });
});
// =======================================================


//管理者側のユーザー検索ボタン
$(function() {
  $(".btn1").click(function(){
    $(".search-form").show('slow');
    $(".btn1").hide('slow')
  });
});

// 表示した検索フォーム以外の部分をクリックしたら閉じる
$(document).on('click touchend', function(event) {
  if (!$(event.target).closest('.search-group').length) {
    $('.search-form').hide('slow');
     $(".btn1").show('slow');
  }
});
// ========================================================

// 複数画像プレビュー機能
$(function(){
  $('.img_field').on('change', function(e) {
    let files = e.target.files;
    let previewContainer = $('#image-preview');
    previewContainer.empty(); // 既存のプレビューをクリア
    Array.from(files).forEach(file => {
      let reader = new FileReader();
      reader.onload = function(event) {
        console.log({event})
        let imagePreview = $('<img>').attr('src', event.target.result).addClass('img_prev col-3').attr('size', '150x250');
        previewContainer.append(imagePreview);
      };
      reader.readAsDataURL(file);
    })
  });
});

// ユーザー画像プレビュー機能
$(function() {
  function readURL(input) {
      if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
  $('.user_img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      }
  }
  $(document).on('change', '.user_img_field', function(){
    readURL(this);
  });
});

// ロゴをクリックするとページの最上部にスクロール
$(function() {
$('#top a').on('click',function(event){
  $('body, html').animate({
    scrollTop:0
  }, 800);
  event.preventDefault();
});
});

// ユーザー詳細ページの「・・・」（編集・削除ボタン）
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


// swiper
document.addEventListener("DOMContentLoaded", function(){
  var mySwiper = new Swiper('.swiper', {
    loop: true,
    pagination: {
      el: '.swiper-pagination',
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev'
    }
  });
});


// トップページのスライドショー
document.addEventListener("DOMContentLoaded", function(){
  var mySwiper = new Swiper('.swiper-top', {
    loop: true,
    autoplay: true,
    speed: 4000,
    simulateTouch: false,
    pagination: false,
    navigation: false,
    centeredSlides: true,
  });
});
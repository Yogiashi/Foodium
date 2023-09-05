# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: ENV['ADMIN_MAIL'],
  password: ENV['ADMIN_PASS']
)

users = User.create!(
  [
    {email: ENV['USER_MAIL1'], name: 'user1', password: ENV['USER_PASS'],introduction: '食べることが大好きです。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: ENV['USER_MAIL2'], name: 'user2', password: ENV['USER_PASS'],introduction: 'よろしくお願いします！', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: ENV['USER_MAIL3'], name: 'user3', password: ENV['USER_PASS'],introduction: 'カフェ巡りが趣味です。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")},
    {email: ENV['USER_MAIL4'], name: 'user4', password: ENV['USER_PASS'],introduction: '東京都在住。大学生。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")},
    {email: ENV['USER_MAIL5'], name: 'user5', password: ENV['USER_PASS'],introduction: '全国を食べ歩いてます。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")}
  ]
)

tags = Tag.create!([
  { name: 'ハンバーグ' },
  { name: '吉祥寺' },
  { name: '隠れ家' },
  { name: '定食' },
  { name: 'チーズケーキ' },
  { name: 'カフェ' },
  { name: 'ゆったり' },
  { name: 'パフェ' },
  { name: 'トースト' },
  { name: 'ラーメン' },
  { name: 'モンブラン' },
  { name: 'モーニング' },
  { name: '味噌ラーメン' },
  { name: '抹茶' }
])

posts = Post.create!(
  [
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")], shop_name: 'hum', dish_name: 'ハンバーグ', caption: 'いろんな味で楽しめて、ハンバーグを３つまで頼めます！', price: '1200', address: '東京都武蔵野市吉祥寺本町２丁目８−３', displayed: true, user_id: users[0].id },
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")], shop_name: 'teisoyku', dish_name: 'バジルソースのチキン定食', caption: '隠れ家的な定食屋さんで料理も美味しかった〜。', price: '1100', address: '東京都世田谷区三軒茶屋１丁目２７−３３', displayed: true, user_id: users[1].id },
    {post_images: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post13.jpg"), filename:"sample-post13.jpg"), shop_name: '式部', dish_name: 'ラーメン', caption: 'さっぱりしていて美味しかった😋', price: '1000', address: '栃木県佐野市久保町214', displayed: true, user_id: users[4].id },
    {post_images: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post7.jpg"), shop_name: 'sweet', dish_name: 'パフェ', caption: 'パフェ専門店に行ってきた！満足感高い！', price: '900', address: 'スカイツリー', displayed: true, user_id: users[1].id },
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post8.jpg"), filename:"sample-post8.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post9.jpg"), filename:"sample-post9.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post10.jpg"), filename:"sample-post10.jpg")], shop_name: 'cake', dish_name: 'チーズケーキ', caption: 'おしゃれなカフェ見つけた。手作り感あるチーズケーキで美味しかった〜。', price: '500', address: '江古田', displayed: true, user_id: users[3].id },
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post11.jpg"), filename:"sample-post11.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post12.jpg"), filename:"sample-post12.jpg")], shop_name: 'Dive', dish_name: 'ハニートースト', caption: '行きたかったカフェに行ってきた！ハニートーストを頼んだ！。', price: '1100', address: '東京都渋谷区松濤1-27−1', displayed: true, user_id: users[0].id },
    {post_images: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post14.jpg"), filename:"sample-post14.jpg"), shop_name: 'mon', dish_name: 'モンブラン', caption: '抹茶のモンブランとか最高。', price: '800', address: '東京都目黒区自由が丘1-29-3', displayed: true, user_id: users[4].id },
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post15.jpg"), filename:"sample-post15.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post16.jpg"), filename:"sample-post16.jpg")], shop_name: 'park', dish_name: 'モーニングセット', caption: '行きたかったカフェでモーニングを注文。眺めが最高！', price: '1300', address: '南池袋公園', displayed: true, user_id: users[2].id },
    {post_images: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post17.jpg"), filename:"sample-post17.jpg"), shop_name: '天格', dish_name: 'ラーメン', caption: '味噌ラーメンいただきました！濃厚でドロっと系の味噌ラーメンでめっちゃ美味しかった！', price: '900', address: 'スカイツリー', displayed: true, user_id: users[0].id },
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg")], shop_name: 'cake', dish_name: 'チーズケーキ', caption: '大人気のカフェです。しっとりしたチーズケーキで美味しかったです。', price: '800', address: '東京都杉並区善福寺４丁目５−９', displayed: true, user_id: users[2].id },
    {post_images: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post18.jpg"), filename:"sample-post18.jpg"), shop_name: 'バーグ', dish_name: '2種ハンバーグ', caption: 'ハンバーグ専門店に行ってきましたー。数種類あるソースから２種類選べて、斬新なハンバーグ屋さんでしたー。', price: '1500', address: '道玄坂２丁目２５−５ 島田ビル 2F', displayed: true, user_id: users[3].id }
  ]
)

PostTag.create!([
  { post: posts[0], tag: tags[0] },
  { post: posts[0], tag: tags[1] },
  { post: posts[1], tag: tags[2] },
  { post: posts[1], tag: tags[3] },
  { post: posts[2], tag: tags[9] },
  { post: posts[3], tag: tags[7] },
  { post: posts[4], tag: tags[4] },
  { post: posts[4], tag: tags[5] },
  { post: posts[4], tag: tags[2] },
  { post: posts[5], tag: tags[8] },
  { post: posts[5], tag: tags[5] },
  { post: posts[6], tag: tags[10] },
  { post: posts[6], tag: tags[5] },
  { post: posts[6], tag: tags[13] },
  { post: posts[7], tag: tags[8] },
  { post: posts[7], tag: tags[11] },
  { post: posts[7], tag: tags[5] },
  { post: posts[7], tag: tags[6] },
  { post: posts[8], tag: tags[9] },
  { post: posts[8], tag: tags[12] },
  { post: posts[9], tag: tags[4] },
  { post: posts[9], tag: tags[5] },
  { post: posts[10], tag: tags[0] }
  ])
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
    {email: ENV['USER_MAIL3'], name: 'user3', password: ENV['USER_PASS'],introduction: 'カフェ巡りが趣味です。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
  ]
)

tags = Tag.create!([
  { name: 'ハンバーグ' },
  { name: '吉祥寺' },
  { name: '隠れ家' },
  { name: '定食' },
  { name: 'チーズケーキ' },
  { name: 'カフェ' },
  { name: 'ゆったり' }
])

posts = Post.create!(
  [
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")], shop_name: 'hum', dish_name: 'ハンバーグ', caption: 'いろんな味で楽しめて、ハンバーグを３つまで頼めます！', price: '1200', address: '吉祥寺', displayed: true, user_id: users[0].id },
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")], shop_name: 'teisoyku', dish_name: 'バジルソースのチキン定食', caption: '隠れ家的な定食屋さんで料理も美味しかった〜。', price: '1100', address: '三軒茶屋', displayed: true, user_id: users[1].id },
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg")], shop_name: 'cake', dish_name: 'チーズケーキ', caption: '大人気のカフェです。しっとりしたチーズケーキで美味しかったです。', price: '800', address: '練馬', displayed: true, user_id: users[2].id }
  ]
)

PostTag.create!([
  { post: posts[0], tag: tags[0] },
  { post: posts[0], tag: tags[1] },
  { post: posts[1], tag: tags[2] },
  { post: posts[1], tag: tags[3] },
  { post: posts[2], tag: tags[4] },
  { post: posts[2], tag: tags[5] },
  { post: posts[2], tag: tags[6] }
  ])
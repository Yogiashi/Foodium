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
    {email: 'a@example.com', name: 'user1', password: 'password',introduction: 'カフェ巡りが趣味です。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'b@example.com', name: 'user2', password: 'password',introduction: 'よろしくお願いします！', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'c@example.com', name: 'user3', password: 'password',introduction: '食べることが大好きです。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
  ]
)

tags = Tag.create!([
  { name: '洋食' },
  { name: 'ケーキ' },
  { name: '和食' },
  { name: '吉祥寺' },
  { name: 'オムライス' },
  { name: 'ハンバーグ' },
])

posts = Post.create!(
  [
    {post_images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")], shop_name: 'cake', dish_name: 'チーズケーキ', caption: '大人気のカフェです。', price: '800', address: '渋谷', displayed: true, user_id: users[0].id },
    {post_images: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), shop_name: 'teisoyku', dish_name: '定食', caption: 'おしゃれな定食屋です。', price: '1300', address: '吉祥寺', displayed: true, user_id: users[1].id },
    {post_images: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), shop_name: 'omellete', dish_name: 'オムライス', caption: '大人気の洋食屋さんです。', price: '1100', address: '丸の内', displayed: true, user_id: users[2].id }
  ]
)

PostTag.create!([
  { post: posts[0], tag: tags[1] },
  { post: posts[1], tag: tags[2] },
  { post: posts[1], tag: tags[3] },
  { post: posts[2], tag: tags[4] }
  ])
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 Admin.create!(
   email: 'admin@test',
   password: 'admintest'
   )

  Item.create!(
    name: "フルーツタルト",
    price_without_tax: 1000,
   )

Item.create!(
    name: "イチゴタルト",
    price_without_tax: 1200,
   )

Item.create!(
    name: "フランスパン",
    price_without_tax: 1200,
   )

Item.create!(
    name: "ブルーベリーケーキ",
    price_without_tax: 500,
   )

Item.create!(
    name: "レアチーズケーキ",
    price_without_tax: 1600,
   )

Item.create!(
    name: "チーズケーキ",
    price_without_tax: 400,
   )

Item.create!(
    name: "生チョコ",
    price_without_tax: 350,

   )

Item.create!(
    name: "シュークリーム",
    price_without_tax: 200,
   )

Item.create!(
    name: "特製フルーツタルト",
    price_without_tax: 200
   )


Item.create!(
    name: "アイスケーキ",
    price_without_tax: 200,
   )


Item.create!(
    name: "ティラミスケーキ",
    price_without_tax: 200
   )

Item.create!(
    name: "アップルパイ",
    price_without_tax: 200
   )
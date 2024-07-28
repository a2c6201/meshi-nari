# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = [
  ['テストユーザー', 'test@gmail', 'test_pass']
]

menus = [
  ['ベンチプレス', 1]
]

users.each do |name, email, password|
  User.create(name:, email:, password:)
end

menus.each do |name, user_id|
  Menu.create(name:, user_id:)
end

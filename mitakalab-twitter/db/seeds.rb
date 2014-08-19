@user = User.new
@user.name = 'a'
@user.username = 'a'
@user.location = 'Tottori, Japan'
@user.about = 'Nice to meet you. I am from database!'
@user.email = 'a@b.com'
@user.save

@au = AdminUser.new
@au.email = 'one@test.com'
@au.username = 'one'
@au.password = 'hogehoge'
@au.save

@au = AdminUser.new
@au.email = 'two@test.com'
@au.username = 'two'
@au.password = 'hogehoge'
@au.save

@au = AdminUser.new
@au.email = 'three@test.com'
@au.username = 'three'
@au.password = 'hogehoge'
@au.save

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

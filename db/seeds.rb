# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Page.create(
  title: "Home",
  slug: "home"
)

Page.create(
  title: "About",
  slug: "about"
)

Page.create(
  title: "Contact",
  slug: "contact"
)

Page.create(
  title: "Footer",
  slug: "footer"
)

Product.create(
  name: "Selfie Branch",
  price_cents: 2000,
  weight: 16,
  length: 4,
  width: 4,
  height: 6
)

Post.create(
  title: "New Post",
  body: "This is a new post"
)

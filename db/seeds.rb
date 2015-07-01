100.times do {
	Post.create(
	title: Faker::Company.catch_phrase,
	body: Faker::Lorem.sentence(12)
	user_id: rand(4)+1
	category_id: rand(5)+1
	)
}

["New Idea", "Recent Events", "Product Review", "Travel", "Random"].each do |name|
	Category.create(title: name)

["Silly","Too Serious","Shower Thought","Uplifting","Surreal","Inspiring"].each do |name|
  Tag.create(name: name)
end

User.create!(
	name: 'Julio Garcia',
	email: 'julio@shipkraken.com',
	password: 'Oiluj97',
	password_confirmation: 'Oiluj97',
	admin: true,
	activated: true,
	activated_at: Time.zone.now
)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n + 1}@sampleapp.com"
	password = 'password'
	User.create!(
		name: name,
		email: email,
		password: password,
		password_confirmation: password,
		activated: true,
		activated_at: Time.zone.now
	)
end

users = User.order(:created_at).take(6)
50.times do
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.microposts.create!(content: content) }
end
User.create!(
	name: 'Julio Garcia',
	email: 'julio@shipkraken.com',
	password: 'Oiluj97',
	password_confirmation: 'Oiluj97'
)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n + 1}@sampleapp.com"
	password = 'password'
	User.create!(
		name: name,
		email: email,
		password: password,
		password_confirmation: password
	)
end
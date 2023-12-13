# frozen_string_literal: true

esrb_ratings = %w[E E7 T M AO]
playstyles = %w[casual balanced hardcore]

if Game.count == 0
  30.times do 
    Game.create({
      name: Faker::Game.title,
      release_date: Faker::Date.between(from: '2014-01-01', to: '2023-01-01'),
      esrb_rating: esrb_ratings.shuffle[0],
      developer: Faker::Games::Pokemon.name,
      publisher: Faker::Games::Dota.team,
      genre: Faker::Game.genre,
      min_players: Faker::Number.between(from: 1, to: 4),
      max_players: Faker::Number.between(from: 4, to: 8),
      system_id: Faker::Number.between(from: 1, to: 3)
    })
  end
end

if User.count < 5
  20.times do 
    User.create({
      email: Faker::Internet.email,
      password: Faker::Internet.password
    })
  end
end

User.all.each do |u|
  u.create_player(u)
end

Player.all.each do |p|
  p.headline = Faker::Games::DnD.title_name
  p.playstyle = playstyles.shuffle[0]
  p.pfp_src = "https://www.voicesquad.com/app/uploads/tamaryn-Payne-260x260.jpg"
  p.timezone = Faker::Address.time_zone
  p.save!

  5.times do 
    PlayerGame.create(player_id: p.id, game_id: Faker::Number.between(from: 1, to: Game.count))
  end
end
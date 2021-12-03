# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

csv_text = File.read(Rails.root.join("lib", "seeds", "nfl.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
csv.each do |row|
  score = Score.new
  score.date = row["Date"]
  score.home_team = row["Home Team"]
  score.away_team = row["Away Team"]
  score.home_score = row["Home Score"]
  score.away_score = row["Away Score"]
  score.closing_spread_home = row["Home Line Close"]
  score.closing_spread_away = row["Away Line Close"]
  score.save
  puts "The game of #{score.home_team} visiting the #{score.away_team} playing on #{score.date} has been saved"
end

puts "There are now #{Score.count} rows in the scores table"

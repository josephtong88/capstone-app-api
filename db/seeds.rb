# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ISO-8859-1
require "csv"

csv_text = File.read(Rails.root.join("lib", "seeds", "nfl.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
csv.each do |row|
  score = Score.new
  score.date = row[0]
  puts row["Date"]
  score.home_team = row["Home Team"]
  score.away_team = row["Away Team"]
  score.home_score = row["Home Score"]
  score.away_score = row["Away Score"]
  score.closing_spread_home = row["Home Line Close"]
  score.closing_spread_away = row["Away Line Close"]
  score.save
  if (score.home_score - score.away_score) > -score.closing_spread_home
    score.home_team_cover = "Yes"
  elsif (score.home_score - score.away_score) == -score.closing_spread_home
    score.home_team_cover = "Tie"
  else
    score.home_team_cover = "No"
  end
  if (score.away_score - score.home_score) > -score.closing_spread_away
    score.away_team_cover = "Yes"
  elsif (score.away_score - score.home_score) == -score.closing_spread_away
    score.away_team_cover = "Tie"
  else
    score.away_team_cover = "No"
  end
  if score.date.between?(2021 - 11 - 20, 2021 - 11 - 23)
    puts "date is between"
  else
    puts "date is not between"
  end
  score.save

  puts "#{score.home_team} (#{score.closing_spread_home}) vs.  #{score.away_team} (#{score.closing_spread_away}) on #{score.date}. 
  Final Score #{score.home_team}-#{score.home_score} to #{score.away_team}-#{score.away_score}.
  Did the home team cover? #{score.home_team_cover}
  Did the away team cover? #{score.away_team_cover}
  "
end

puts "There are now #{Score.count} rows in the scores table"

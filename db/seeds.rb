# require "csv"

# csv_text = File.read(Rails.root.join("lib", "seeds", "nflteams.csv"))
# csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
# csv.each do |row|
#   team = Team.new
#   team.team_name = row["Teams"]
#   team.save
#   puts "#{team.team_name} saved"
# end

# puts "There are now #{Team.count} rows in the Teams table"

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
  score.home_team_id = Team.find_by(team_name: score.home_team).id
  score.away_team_id = Team.find_by(team_name: score.away_team).id
  score.save
end

puts "There are now #{Score.count} rows in the scores table"

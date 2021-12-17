class TeamsController < ApplicationController
  #shows all teams
  def index
    teams = Team.all
    render json: teams.as_json
  end

  #shows all scores for team by id param
  def show
    scores = Score.where("home_team_id =? OR away_team_id =?", params[:id], params[:id])
    render json: scores.as_json
  end

  #shows all scores for team by id param and date param
  def datedshow
    scores = Score.where("home_team_id =? OR away_team_id =?", params[:id], params[:id]).where("date>=? AND date<=?", params[:start_date], params[:end_date]).where("home_team =? OR away_team =?", "Baltimore Ravens", "Baltimore Ravens")

    render json: scores.as_json
  end

  #

  #shows team name by id param
  def showteam
    team = Team.find_by(id: params[:id])
    render json: team.as_json
  end

  def records
    home_win = 0
    home_loss = 0
    home_su_tie = 0
    home_cover = 0
    home_not_cover = 0
    home_ats_tie = 0

    away_win = 0
    away_loss = 0
    away_su_tie = 0
    away_cover = 0
    away_not_cover = 0
    away_ats_tie = 0

    team = Score.all.where("home_team_id": params[:id])
    team.each do |score|
      if score.home_team_cover == "Yes"
        home_cover += 1
      elsif score.home_team_cover == "No"
        home_not_cover += 1
      elsif score.home_team_cover == "Tie"
        home_ats_tie += 1
      end
      if score.home_score > score.away_score
        home_win += 1
      elsif score.home_score < score.away_score
        home_loss += 1
      elsif score.home_score == score.away_score
        home_su_tie += 1
      end
    end

    team = Score.all.where("away_team_id": params[:id])
    team.each do |score|
      if score.away_team_cover == "Yes"
        away_cover += 1
      elsif score.away_team_cover == "No"
        away_not_cover += 1
      elsif score.away_team_cover == "Tie"
        away_ats_tie += 1
      end
      if score.home_score < score.away_score
        away_win += 1
      elsif score.home_score > score.away_score
        away_loss += 1
      elsif score.home_score == score.away_score
        away_su_tie += 1
      end
    end
    win = home_win + away_win
    loss = home_loss + away_loss
    su_tie = home_su_tie + away_su_tie
    cover = home_cover + away_cover
    not_cover = home_not_cover + away_not_cover
    ats_tie = home_ats_tie + away_ats_tie

    record = "Straightup Record: #{win} - #{loss} - #{su_tie}. 
    ATS Record: #{cover} - #{not_cover} - #{ats_tie}."
    render json: record.as_json
  end

  def homerecords
    home_win = 0
    home_loss = 0
    home_su_tie = 0
    home_cover = 0
    home_not_cover = 0
    home_ats_tie = 0

    team = Score.all.where("home_team_id": params[:id])
    team.each do |score|
      if score.home_team_cover == "Yes"
        home_cover += 1
      elsif score.home_team_cover == "No"
        home_not_cover += 1
      elsif score.home_team_cover == "Tie"
        home_ats_tie += 1
      end
      if score.home_score > score.away_score
        home_win += 1
      elsif score.home_score < score.away_score
        home_loss += 1
      elsif score.home_score == score.away_score
        home_su_tie += 1
      end
    end

    record = "Home Record: 
    Straightup Record: #{home_win} - #{home_loss} - #{home_su_tie}. 
    ATS Record: #{home_cover} - #{home_not_cover} - #{home_ats_tie}."

    render json: record.as_json
  end

  def awayrecords
    away_win = 0
    away_loss = 0
    away_su_tie = 0
    away_cover = 0
    away_not_cover = 0
    away_ats_tie = 0

    team = Score.all.where("away_team_id": params[:id])
    team.each do |score|
      if score.away_team_cover == "Yes"
        away_cover += 1
      elsif score.away_team_cover == "No"
        away_not_cover += 1
      elsif score.away_team_cover == "Tie"
        away_ats_tie += 1
      end
      if score.home_score < score.away_score
        away_win += 1
      elsif score.home_score > score.away_score
        away_loss += 1
      elsif score.home_score == score.away_score
        away_su_tie += 1
      end
    end

    record = "Away Record: 
    Straightup Record: #{away_win} - #{away_loss} - #{away_su_tie}.
    ATS Record: #{away_cover} - #{away_not_cover} - #{away_ats_tie}."
    render json: record.as_json
  end
end

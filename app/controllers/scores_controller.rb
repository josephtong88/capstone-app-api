class ScoresController < ApplicationController
  def index
    scores = Score.all
    render json: scores.as_json
  end

  # def show
  #   score = Score.find_by(id: params[:id])
  #   render json: score.as_json
  # end

  def create
    score = Score.new(
      date: params[:input_date],
      home_team: params[:input_home_team],
      away_team: params[:input_away_team],
      home_score: params[:input_home_score],
      away_score: params[:input_away_score],
      closing_spread_home: params[:input_closing_spread_home],
      closing_spread_away: params[:input_closing_spread_away],
    )
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

  def destroy
    score = Score.find_by(id: params[:id])
    score.destroy
    render json: { message: "This score record has been destroyed" }
  end
  
  


  end
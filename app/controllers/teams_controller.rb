class TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams.as_json
  end

  def show
    team = Score.all.where("home_team_id =? OR away_team_id =?", params[:id], params[:id])
    render json: team.as_json
  end

  def showteam
    team = Team.find_by(id: params[:id])
    render json: team.as_json
  end
end

class CompetitionTeamsController < ApplicationController

  def create
    competition = Competition.find(params[:id])
    team = Team.where("lower(nickname) like ?", "%#{params[:nickname].downcase}%")
    CompetitionTeam.create({competition_id: (params[:id]), team_id: (team.first.id)})
    redirect_to "/competitions/#{params[:id]}"
  end

end

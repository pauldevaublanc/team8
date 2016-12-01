class TeamUsersController < ApplicationController

  def new
    @captain_teams = Team.where(captain_id: current_user.id)
    @team_user = TeamUser.new(user_id: params[:user_id])

  end

  def create
    @team_user = TeamUser.new(team_user_params)
    @team_user.requester_id = current_user.id
    @team_user.status = "pending"
    @team_user.save!

    @team = Team.where(id: @team_user.team_id)
    # raise
    redirect_to team_path(@team[0].id)
  end

private

  def team_user_params
    params.require(:team_user).permit(:team_id, :user_id, :requester_id, :status)
  end

end

class TeamFavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy]
  before_action :logged_in
  def index
    @fav = current_user.team_favorites

    @home_game = []
    @away_game = []
    @game = {}
    @fav.each do |fav|
      @home_game = Game.where("home_team_id = ? ",fav.team.team_id).select(:gameday).order("gameday desc")
      @away_game = Game.where("away_team_id = ? ",fav.team.team_id).select(:gameday).order("gameday desc")

      k = fav.team.team_id
      v = Game.where("home_team_id = ? or away_team_id = ?", fav.team.team_id, fav.team.team_id).order("gameday desc")
      @game[k] = v
    end

  end

  def create
    @fav = TeamFavorite.new(favorite_params)

    respond_to do |format|
      if @fav.save
        format.html {redirect_to :back, notice: 'Added your favorite successfully'}
      else
        format.html {redirect_to :back, notice: "同じ選手または同じチームは重複して選べません。"}
      end
    end
  end

  def destroy
    @fav.destroy
    redirect_to :back
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @fav = TeamFavorite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_params
      params.require(:favorite).permit(:team_id, :user_id)
    end
end

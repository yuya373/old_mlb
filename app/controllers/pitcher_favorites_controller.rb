class PitcherFavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy]

  def create
    @fav = PitcherFavorite.new(favorite_params)

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
      @fav = PitcherFavorite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_params
      params.require(:favorite).permit(:pitcher_id, :user_id)
    end
end

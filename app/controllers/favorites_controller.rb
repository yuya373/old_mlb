class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update, :destroy]

  # GET /favorites
  # GET /favorites.json
  def index
    if current_user
     @fav_team = current_user.team_favorites
     @fav_pitcher = current_user.pitcher_favorites
     @fav_batter = current_user.batter_favorites
    else
    end
  end

  # GET /favorites/1
  # GET /favorites/1.json
  def show
  end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites
  # POST /favorites.json
  def create
    @favorite = Favorite.new(favorite_params)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to :back, notice: ' Added your favorite successfully.' }
      else
        format.html { redirect_to :back, notice: "同じ選手または同じチームは重複して選べません。"}
        p @favorite.errors
      end
    end
  end

  # PATCH/PUT /favorites/1
  # PATCH/PUT /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to @favorite, notice: 'Favorite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to favorites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_params
      params.require(:favorite).permit(:team_id, :p_id, :b_id, :user_id, :c_type)
    end
end

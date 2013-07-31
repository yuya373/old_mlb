class MediaController < ApplicationController
 def show
  @g_id = params[:g_id]
  @media = Media.where(game_id: @g_id).order(:sv_id)
 end
end

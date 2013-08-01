class MediaController < ApplicationController
 def show
  @g_id = params[:g_id]
  @media = Media.where(game_id: @g_id).order(:sv_id).where.not(media_type: 'condensed')
  @cg = Media.where(game_id: @g_id).where(media_type: 'condensed').first
 end
end

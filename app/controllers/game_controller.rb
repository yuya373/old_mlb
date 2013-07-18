class GameController < ApplicationController
  def index
    if params[:date]
      @note = true
      @year = params[:date][:year]
      @month = params[:date][:month]
      @day = params[:date][:day]

      @game = Game.where('year = ?',@year).where('month = ?',@month).where('day = ?',@day)
    else
      @note = nil
    end
  end

  def show
    @game_id = params[:game_id]
    @game = Game.where('gameday = ?',@game_id).first
  end


end

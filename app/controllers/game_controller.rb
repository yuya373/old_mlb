class GameController < ApplicationController
  def test
    @games = Game.where('year = ? and month = ?', params[:year], params[:month])
  end
  def index
    if params[:date]
      @note = true
      @year = params[:date][:year]
      @month = params[:date][:month]
      @day = params[:date][:day]

      @game = Game.y_m_d(@year,@month,@day)
    else
      @note = nil
    end
  end

  def show
    @g_id = params[:g_id]
    @game = Game.from_game_id(@g_id).first
  end

  def atbat
    @g_id = params[:g_id]
    @game = Game.from_game_id(@g_id).first
    @atbat = @game.atbats
    @inning = @atbat.select('distinct inning')
    @num = []
    @inning.each do |inn|
      @num << inn.inning
    end

    @data = {}
    @num.each do |num|
      @data[num] = {}
      top_atbat = @atbat.where('inning = ?',num).where('t_b = ?','top')
      bot_atbat = @atbat.where('inning = ?',num).where('t_b = ?','bottom')
      @data[num][:top] = top_atbat
      @data[num][:bot] = bot_atbat
    end


  end

end

class PitchTypeDetailsController < ApplicationController

  def index

  end
  def pitchings
    @column = PitchTypeDetail.select('DISTINCT pitch_type')
    @pitch_type = params[:type]
    session[:type] = @pitch_type
    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]

    @pitchings = PitchTypeDetail.where('pitch_type = ?', session[:type]).where('p_b = ?','p').where.not('ab = ?','0').order(@item + ' ' + @direction)

  end

  def battings
    @column = PitchTypeDetail.select('DISTINCT pitch_type')
    @pitch_type = params[:type]
    session[:type] = @pitch_type
    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]

    @pitchings = PitchTypeDetail.where('pitch_type = ?', session[:type]).where('p_b = ?', 'b').where.not('ab = ?','0').order(@item + ' ' +  @direction)
  end
end

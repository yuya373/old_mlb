class AtbatController < ApplicationController
  def show
    @p_column = Atbat.where.not('pitcher_name =  ?','-').select('DISTINCT pitcher_name, pitcher_id').order('pitcher_name asc')

    @p_id = params[:pitcher]

    @b_column = Atbat.where.not('pitcher_name =  ?','-').where('pitcher_id = ?',params[:pitcher]).select('DISTINCT batter_name, batter_id')

    @b_id = params[:batter]

    @atbat = Atbat.where('pitcher_id = ?', @p_id).where('batter_id = ?', @b_id)
  end
end

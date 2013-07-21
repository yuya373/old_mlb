class PitchTypeDetailsController < ApplicationController

  def index

  end
  def pitchings
    @hash = {
    'フォーシーム' => 'ff',
    'ツーシーム' => 'ft',
    'カットボール' => 'fc',
    'スプリット' => 'fs',
    'フォーク' => 'fo',
    'シンカー' => 'si',
    'スライダー' => 'sl',
    'カーブ' => 'cu',
    'ナックルカーブ' => 'kc',
    'チェンジアップ' => 'ch',
    'スクリュー' => 'sc',
    'ナックル' => 'kn'
    }

    if params[:type]
      @pitch_type = params[:type]
      session[:type] = @pitch_type
      @note = true
    else
      @note = nil
    end

    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]

    @pitchings = PitchTypeDetail.where('pitch_type = ?', session[:type]).where('p_b = ?','p').where.not('ab = ?','0').order(@item + ' ' + @direction)

  end

  def battings
    @hash = {
    'フォーシーム' => 'ff',
    'ツーシーム' => 'ft',
    'カットボール' => 'fc',
    'スプリット' => 'fs',
    'フォーク' => 'fo',
    'シンカー' => 'si',
    'スライダー' => 'sl',
    'カーブ' => 'cu',
    'ナックルカーブ' => 'kc',
    'チェンジアップ' => 'ch',
    'スクリュー' => 'sc',
    'ナックル' => 'kn'
    }
    if params[:type]
      @pitch_type = params[:type]
      session[:type] = @pitch_type
      @note = true
    else
      @note = nil
    end

    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]

    @pitchings = PitchTypeDetail.where('pitch_type = ?', session[:type]).where('p_b = ?', 'b').where.not('ab = ?','0').order(@item + ' ' +  @direction)
  end
end

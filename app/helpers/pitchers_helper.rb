module PitchersHelper
  def pitcher_sort(word,item,direction)
    output = link_to word.upcase, sort: word
    output += pitcher_arrow(word,item,direction).html_safe
  end

  def pitcher_arrow(word,item,direction)
    if word == item
      direction = direction == 'asc' ? '↓' : '↑'
      return '<small>' + direction + '</small>'
      # return '<i class="icon-arrow-' + direction + '"></i>'
    else
      return ''
    end
  end
end

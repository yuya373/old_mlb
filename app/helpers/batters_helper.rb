module BattersHelper
  def batter_sort(word,item,direction)
    output = link_to word.upcase, sort: word
    output += batter_arrow(word, item, direction).html_safe
  end

  def batter_arrow(word,item,direction)
    if word == item
      direction = direction == 'asc' ? '↓' : '↑'
      return '<small>' + direction + '</small>'
      # return '<i class="icon-arrow-' + direction + '"></i>'
    else
      return ''
    end
  end
end

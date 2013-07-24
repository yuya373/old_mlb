module TeamHelper
  def tb_sort(word,item,direction)
    output = link_to word.upcase, sort: "tb_#{word}"
    output += arrow(word, item, direction).html_safe
  end

  def tp_sort(word,item,direction)
    output = link_to word.upcase, sort: "tp_#{word}"
    output += arrow(word, item, direction).html_safe
  end

  def arrow(word,item,direction)
    if item.slice(3,10) == word
     direction = direction == 'asc' ? '↓' : '↑'
      return '<small>' + direction + '</small>'
    else
      return ''
    end
  end
end

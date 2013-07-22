module ApplicationHelper
  def sortable(word)
    link_to word.upcase, sort: word
  end
end

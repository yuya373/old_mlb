module ApplicationHelper
  def when_updated(obj)
   output = "<div class='span10'><div class='alert alert-info'>" + "updated at: #{l(obj[:updated_at])}" + "</div></div>"
   output.html_safe

  end

end

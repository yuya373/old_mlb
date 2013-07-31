module ApplicationHelper
  def when_updated(obj)
   output = "<div class='span6'><div class='alert alert-info'>" + "updated at: #{l(obj[:updated_at])}" + "</div></div></br></br>"
   output.html_safe

  end

end

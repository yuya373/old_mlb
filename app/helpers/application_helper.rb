module ApplicationHelper
  def when_updated(obj)
    "updated at: #{l(obj[:updated_at])}"

  end

end

module ApplicationHelper
  def when_updated(obj)
   output = "<div class='span6'><div class='alert alert-info'>" + "updated at: #{l(obj[:updated_at])}" + "</div></div></br></br>"
   output.html_safe

  end

end

module SimpleCalendar
  module ViewHelpers

    private
    def month_header(selected_month, options)
      content_tag :h4 do
        previous_month = selected_month.advance :months => -1
        next_month = selected_month.advance :months => 1
        tags = []

        tags << month_link(options[:prev_text], previous_month, options[:params], {:class => "previous-month"})
        tags << "#{I18n.t("date.month_names")[selected_month.month]} #{selected_month.year}"
        tags << month_link(options[:next_text], next_month, options[:params], {:class => "next-month"})

        tags.join.html_safe
      end
    end
  end
end

module ApplicationHelper
  def nice_date(date)
    date.strftime("%a %d %b %Y")
  end
  
  # http://neoarch.wordpress.com/2008/02/29/setting-focus-in-rails-with-prototype/
  def set_focus_to_id(id)
    javascript_tag("$('#{id}').focus();")
  end
end

module ApplicationHelper
  def full_title(page_title)
    if page_title.empty?
      'RhoHi'
    else
      "#{page_title} | RhoHi"
    end
  end
end

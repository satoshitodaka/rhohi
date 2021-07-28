module ApplicationHelper
  def full_title(page_title)
    if page_title.empty?
      'Rhohi'
    else
      "#{page_title} | Rhohi"
    end
  end
end

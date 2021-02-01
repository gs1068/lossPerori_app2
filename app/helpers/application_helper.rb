module ApplicationHelper
  def full_title(page_title)
    if page_title.blank?
      "LossPerori"
    else
      "#{page_title} - LossPerori"
    end
  end
end

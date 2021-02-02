module ApplicationHelper
  def full_title(page_title)
    if page_title.blank?
      "ロスペロリ"
    else
      "#{page_title} - ロスペロリ"
    end
  end
end

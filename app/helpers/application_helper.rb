module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-warning"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def movie_index_page?
    params[:controller] == 'movies' && params[:action] == 'index'
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end

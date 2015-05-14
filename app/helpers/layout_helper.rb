# coding: utf-8
module LayoutHelper

  def full_title(page_title)
    base_title = "職GET：ニューヨーク就職サイト"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def current_if_about
  	'current' if params[:action] == "about"
  end

  def current_if_posting
  	if ["jobs", "orders"].include?(params[:controller]) && ["new", "edit", "review", "success"].include?(params[:action])
  			'current'
  	end
  end

end
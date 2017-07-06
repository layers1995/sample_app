module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')	# define method, argument is optional
    base_title = "Ruby on Rails Tutorial Sample App"	# variable assignment
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
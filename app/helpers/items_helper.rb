module ItemsHelper

  def direction(column)
    params[column] == "ASC" ? "DESC" : "ASC"
  end
  
  def name_icon
    if params[:name_sort] == "ASC"
      tag(:span, class: "glyphicon glyphicon-triangle-top", style: "padding-left: 5px")
    elsif params[:name_sort] == "DESC"
      tag(:span, class: "glyphicon glyphicon-triangle-bottom", style: "padding-left: 5px")
    end
  end
  
  def current_bid_icon
    if params[:current_bid_sort] == "ASC"
      tag(:span, class: "glyphicon glyphicon-triangle-top", style: "padding-left: 5px")
    elsif params[:current_bid_sort] == "DESC"
      tag(:span, class: "glyphicon glyphicon-triangle-bottom", style: "padding-left: 5px")
    end
  end
  
  def bid_count_icon
    if params[:bid_count_sort] == "ASC"
      tag(:span, class: "glyphicon glyphicon-triangle-top", style: "padding-left: 5px")
    elsif params[:bid_count_sort] == "DESC"
      tag(:span, class: "glyphicon glyphicon-triangle-bottom", style: "padding-left: 5px")
    end
  end
end
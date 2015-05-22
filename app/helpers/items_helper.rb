module ItemsHelper

  def direction(column)
    params[column] == "ASC" ? "DESC" : "ASC"
  end
end
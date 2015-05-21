module ItemsHelper

  def direction(column)
    params[column] ? "DESC" : "ASC"
  end
end
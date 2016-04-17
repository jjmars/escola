module ApplicationHelper
  def current_unit
    return @current_unit ||= Unit.find(params[:unit_id]) if params[:unit_id]
  end
  
  def current_school
    return @school ||= School.first # TODO: substituir pela escola do usuário
  end
end

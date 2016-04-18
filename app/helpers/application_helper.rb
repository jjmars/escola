module ApplicationHelper
  def current_unit
    return @current_unit ||= Unit.find(params[:unit_id]) if params[:unit_id]
  end
  
  def current_school
    return @current_school ||= current_user.school if current_user
  end
end

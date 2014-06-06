class GoalDecorator < Draper::Decorator
  delegate_all

  def permission?
    current_user == object.user    
  end
end

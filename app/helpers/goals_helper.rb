module GoalsHelper
  
  def goal_edit_button(goal)
    if current_user == goal.user
      link_to "edit goal", edit_goal_url(goal)
    end
  end
  
  def goal_delete_button(goal)
    if current_user == goal.user
      button_to "delete goal", goal_url(goal), method: :delete 
    end
  end
  
  def goal_completed(goal)
    if goal.completed
      ' completed'
    elsif current_user == goal.user
      button_to('complete goal', complete_goal_url(goal))
    end
  end
end

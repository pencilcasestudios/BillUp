module ApplicationHelper
  def body_id
    controller.controller_name
  end

  def new_or_create_action?
    (controller.action_name == "new") || (controller.action_name == "create")
  end 

  def title(page_title)
    content_for(:title) { page_title }
  end
end

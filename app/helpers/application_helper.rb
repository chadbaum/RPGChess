# helper methods for application controller
module ApplicationHelper
  # Following 4 methods added to add a devise route
  # for registration on index.html.erb
  def resource_name
    :user
  end

  def resource_class
    User
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end

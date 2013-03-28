module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def background_images
    %w{ berlin singapore san\ francisco }.each do |destination|
      
    end
    "<img id='#{name}'> src='/assets/#{name}.jpg'"
  end
end

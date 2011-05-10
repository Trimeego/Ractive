class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin_user?
    if current_user.email!='jdouglas@icgconsulting.com'
      redirect_to root_path
    end
  end
  
end

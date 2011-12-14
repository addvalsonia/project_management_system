# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password
  helper_method :current_user_session, :current_user
  
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

def require_user
   unless current_user
     # flash[:notice] = "You must be logged in to access this page"
     # redirect_to new_user_session_url
     redirect_to root_url
     return false
   end
 end

 def require_no_user
   if current_user
     store_location
     flash[:notice] = "You must be logged out to access this page"
     redirect_to logout_url
     return false
   end
 end

 def require_admin_user
   unless current_user and (current_user.role =="ru"  or current_user.role == "su")
     store_location
     flash[:notice] = "You must be logged in with admin rights .to access this page"
     redirect_to root_url
     return false
   end
 end

 def require_normal_admin_user
   unless current_user and (current_user.role =="sub"  or current_user.role == "ru")
     store_location
     flash[:notice] = "You must be logged in with admin rights .to access this page"
     redirect_to request.referer
     return false
   end
 end

 def require_su_user
   unless current_user and current_user.role == "su"
     store_location
     flash[:notice] = "You must be logged in with admin rights to access this page"
     redirect_to root_url
     return false
   end
 end    
end

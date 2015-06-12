class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
 
		def current_user
		  @current_user ||= User.find_by(id: session[:user_id])
		end

		def sorting (list)
			@sorting = case params[:sorting]
				          when 'ca' then 'created_at ASC'
                  when 'cd' then 'created_at DESC'
                  when 'la' then 'likes_count ASC'
                  when 'ld' then 'likes_count DESC'
                else
                  'created_at DESC'
                end
      list.order(@sorting)
    end
		 
		helper_method :current_user
		helper_method :sorting

end

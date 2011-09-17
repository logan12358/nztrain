class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect(message)
      if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redir = :back
      else
        redir = new_user_session_path
      end

      redirect_to(redir, :alert => message)
  end

  def check_signed_in
    if !user_signed_in?
      redirect("You must be signed in to perform this operation")
    end
  end

end

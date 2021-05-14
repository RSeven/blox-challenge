class ApplicationController < ActionController::Base
  def moderator_only!
    if !current_user.moderator?
      flash[:alert] = "This is a moderator only feature"
      redirect_to authenticated_root_url
    end
  end
end

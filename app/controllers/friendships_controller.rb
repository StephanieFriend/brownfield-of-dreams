class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_username: params[:github_username])

    if current_user.friends << friend
      flash[:success] = 'Successfully added friend'
    else
      flash[:error] = 'Unable to find user'
    end
    redirect_to dashboard_path
  end
end

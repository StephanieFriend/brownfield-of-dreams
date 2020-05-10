class GithubSessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    current_user.update!(github_token: auth[:credentials][:token], github_username: auth[:extra][:raw_info][:login])
    redirect_to root_url, :notice => "Signed in with Github!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end

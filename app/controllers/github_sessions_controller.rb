class GithubSessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth 
      current_user.update(github_token: auth[:credentials][:token], github_username: auth[:extra][:raw_info][:login])
      redirect_to root_url, :notice => "Signed in with Github!"
    else
      redirect_to dashboard_path, :notice => "Failed to connect to Github"
    end
  end

end

class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(uid: params[:uid])
    friendship = Friendship.new(user: current_user, friend: friend)
    if friendship.save
      flash[:success] = 'Successfully added friend'
    else
      flash[:error] = 'Unable to find user'
    end
    redirect_to dashboard_path
  end
end
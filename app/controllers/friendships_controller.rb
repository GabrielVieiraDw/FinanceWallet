class FriendshipsController < ApplicationController
  def create
    friendship = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following"
    else
      flash[:alert] = "Unable to follow, try later"
    end
    redirect_to friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Unfollowing"
    redirect_to friends_path
  end
end

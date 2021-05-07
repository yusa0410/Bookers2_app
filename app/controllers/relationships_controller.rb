class RelationshipsController < ApplicationController
  def create
      user = User.find(params[:user_id])
      if user
       current_user.follow(user) unless current_user.following?(user)
      end
      redirect_to request.referer
  end

  def destroy
      Relationship.find(params[:user_id]).destroy
      redirect_to request.referer
  end
  
  #————————フォロー・フォロワー一覧を表示する-————————————
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end

class RelationshipsController < ApplicationController
  def create
      user = User.find(params[:user_id])
      if user
       current_user.follow(user) unless current_user.following?(user)
      end
      redirect_to request.referer
  end

  def destroy
      Relationship.find(params[:id]).destroy
      redirect_to request.referer
  end
end

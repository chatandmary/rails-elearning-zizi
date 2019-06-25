class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:followed_id])
    if current_user.follow(user)
      @relationship = current_user.active_relationships.find_by(followed_id: params[:followed_id])
      @relationship.create_activity(user: current_user)
    end
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end

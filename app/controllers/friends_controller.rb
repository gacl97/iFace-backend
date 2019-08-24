class FriendsController < ApplicationController
  before_action :set_current_user
  before_action :set_friend, only: :destroy

  def index
    @friends = @current_user.friends
    render json: @friends
  end

  def destroy
    @current_user.remove_friend(@friend)
  end

  private

    def set_current_user
      @current_user = User.find(params[:user_id]) 
    end

    def set_friend
      @friend = @current_user.friends.find(params[:friend_id])
    end
end

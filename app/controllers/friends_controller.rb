class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy
  before_action :set_current_user

  def index
    @friends = @current_user.friends
  end

  def destroy
    @current_user.remove_friend(@friend)
  end

  private

    def set_current_user
      @current_user = User.find(params[:user_id]) 
    end

    def set_friend
      @friend = current_user.friends.find(params[:id])
    end
end

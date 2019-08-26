class FriendRequestsController < ApplicationController
    before_action :set_friend_request, except: [:index, :create] 
    before_action :set_current_user, except: :destroy 
    
    def create
        friend = User.find(friend_request_params[:friend_id])
        @friend_request = @current_user.friend_requests.new(friend: friend)

        if @friend_request.save
            render json: @friend_request, status: :created
        else
            render json: @friend_request.errors, status: :unprocessable_entity
        end
    end

    def index
        @incoming = FriendRequest.where(friend: @current_user).to_json(include: :user)
        @outgoing = @current_user.friend_requests.to_json(include: :friend)
        render json: {
            incoming: JSON.parse(@incoming), 
            outgoing: JSON.parse(@outgoing)
        }
    end

    def update
        @friend_request.accept
        @friend_request.destroy
    end

    def destroy
        @friend_request.destroy
    end

    private

        def set_current_user
            @current_user = User.find(params[:user_id]) 
        end

        def set_friend_request
            @friend_request = FriendRequest.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def friend_request_params
            params.require(:friend_request).permit(:friend_id)
        end
end

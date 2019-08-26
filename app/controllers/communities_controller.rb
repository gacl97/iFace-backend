class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :update, :destroy]

  # GET /communities
  def index
    
    if params[:user_id]
      @owned = User.find(params[:user_id]).owned_communities
      @others = User.find(params[:user_id]).communities
      @communities = {
        owner: @owned,
        member: @others
      }
    else
      @communities = Community.all
    end
    render json: @communities, include: :users
  end

  # GET /communities/1
  def show
    render json: @community.to_json(include: [:owner, :users])
  end

  # POST /communities
  def create
    @community = Community.new(community_params)
    if @community.save
      render json: @community.to_json(include: [:owner, :users]), status: :created, location: @community
    else
      render json: @community.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /communities/1
  def update
    if @community.update(community_params)
      render json: @community.to_json(include: [:owner, :users])
    else
      render json: @community.errors, status: :unprocessable_entity
    end
  end

  # DELETE /communities/1
  def destroy
    @community.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def community_params
      if params[:user_id]
        params[:community][:owner_id] = params[:user_id]
      end

      params.require(:community).permit(:name, :content, :owner_id, user_ids: [])
    end
end

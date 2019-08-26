class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
   
    if params[:user_id]
      @sent = User.find(params[:user_id]).sent_messages
      @received = User.find(params[:user_id]).received_messages
      @messages = {
        messages: @sent | @received
      }
    else
      @messages = Message.all
    end
    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message.to_json(include: [ :sender, :receiver ])
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      if params[:user_id]
        params[:message][:sender_id] = params[:user_id]
      end

      params.require(:message).permit(:content, :sender_id, :receiver_id)
    end
end

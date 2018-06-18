class ChatsController < ApplicationController
  before_action :authorize

  def index
    @users = User.all
    @chats = Chat.all
  end

  def create
    if Chat.between(@current_user.id, params[:recipient_id]).present?
      @chat = Chat.between(@current_user.id, params[:recipient_id]).first
    else
      @chat = Chat.create!(sender_id: @current_user.id, recipient_id: params[:recipient_id])
    end
    @message = @chat.messages.create!(user_id: @current_user.id, body: params[:message])
    if @message.errors.any?
      render json: {
        success: false, errors: @message.errors.messages
      }.to_json, status: 422
    else
      render template: '/chats/create'
    end
  end

  def update
    @chat = Chat.find(params[:id])
    @message = @chat.messages.create!(user_id: @current_user.id, body: params[:message])
    if @message.errors.any?
      render json: {
        success: false, errors: @message.errors.messages
      }.to_json, status: 422
    else
      render template: '/chats/create'
    end
  end

  private

     def chat_params
      params.permit(:recipient_id, :nickname, :message)
     end

     def device_token
       request.headers.fetch('Authorization')
     end

     def authorize
       @current_user = User.find_by(device_id: device_token)
       if @current_user == nil
         if device_token == nil
           errors = 'Need device id at Authorization header'
         elsif params[:nickname] == nil
           errors = 'Need user nickname at params'
         end
         if errors
           render json: {
              success: false,
              errors: errors
           }.to_json, status: 403
         else
           @current_user = User.create!(device_id: device_token, nickname: params[:nickname])
         end
       end
     end
end

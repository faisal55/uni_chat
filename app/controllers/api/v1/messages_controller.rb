class Api::V1::MessagesController < ApplicationController

	before_action :set_message, :only => [:destroy, :update]

	def get_public_messages
		@messages = Message.public_messages
		@messages = @messages.where("LOWER(message) LIKE ?", "%#{params[:keyword]}%") unless params[:keyword].blank?
		data = @messages.as_json
		render :json => {data: data, message: "#{@messages.count} public messages found"}, :success => true
	end

	def index
		@group_messages = Message.group_messages 
		@group_messages = @group_messages.where("group_id =?", params[:group_id]) unless params[:group_id].blank?
		@group_messages = @group_messages.where("LOWER(message) LIKE ?", "%#{params[:keyword]}%") unless params[:keyword].blank?
		data = @group_messages.as_json
		render :json => {data: data, message: "#{@group_messages.count} group messages found"}, :success => true
	end

	def create
		@message = Message.new(message_params)
		if @message.save
			render :json => {data: @message.as_json, message: "Message has been saved successfully!"}, success: true
		else
			render :json => {message: "#{@message.errors.full_messages.last}"}, success: false
		end
	end

	def destroy	
		@message.destroy
		render :json => {message: "Message deleted successfully!"}, success: true
	end

	def update
		if @message.update_attributes(message_params)
			render :json => {data: @message.as_json, message: "Message has been updated successfully!"}, success: true
		else
			render :json => {message: "#{@message.errors.full_messages.last}"}, success: false
		end	
	end

	private

	def set_message
		@message = Message.find(params[:id])
	end

	def message_params
		params.require(:message).permit(:message, :sender_id, :message_type, :group_id)
		#TO create new message for group POST: {message: {message: "Hello testing group", sender_id: 1, message_type: 1, group_id: 1}}
		#TO create new message for public POST: {message: {message: "Hello testing public", sender_id: 1, message_type: 0}}
	end

end
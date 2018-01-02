class Api::V1::GroupsController < ApplicationController

	before_action :set_group, :only => [:destroy, :update, :set_members, :get_members, :remove_members]

	def index
		@groups = Group.joins(:group_members) 
		@groups = @groups.where("group_members.user_id =?", @current_api_user.id) unless @current_api_user.blank?
		data = @groups.uniq.as_json
		render :json => {data: data, message: "#{@groups.count} groups found"}, :success => true
	end

	def create
		@group = Group.new(group_params)
		if @group.save
			render :json => {data: @group.as_json, message: "Group has been saved successfully!"}, success: true
		else
			render :json => {message: "#{@group.errors.full_messages.last}"}, success: false
		end
	end

	def set_members
		if @group.group_members.where("user_id =?", params[:user_id]).blank?
			@group.group_members << GroupMember.new(:user_id => params[:user_id])
			render :json => {data: @group.users, message: "Memeber has been added to group #{@group.name} successfully!"}, success: true
		else
			render :json => {message: "Memeber has already been added in group #{@group.name}"}, success: false
		end
	end

	def get_members
		users = @group.users
		render :json => {data: users.as_json, message: "#{users.count} memebers exist in group #{@group.name}"}, success: true
	end

	def remove_members
		@group.group_members.find_by_user_id(params[:user_id]).try(:destroy)
		users = @group.users
		render :json => {data: users.as_json, message: "#{users.count} memebers exist in group #{@group.name}"}, success: true
	end

	def destroy	
		@group.destroy
		render :json => {message: "Group deleted successfully!"}, success: true
	end

	def update
		if @group.update_attributes(group_params)
			render :json => {data: @group.as_json, message: "Group has been updated successfully!"}, success: true
		else
			render :json => {message: "#{@group.errors.full_messages.last}"}, success: false
		end	
	end

	private

	def set_group
		@group = Group.find(params[:id])
	end

	def group_params
		params.require(:group).permit(:name, :group_type)
		
		#TO create General Group POST: {"group": {"name": "New group", group_type: 0}}
		#TO create new Personal message POST: {"group": {"name": "Personal group", group_type: 1}}


	end

end
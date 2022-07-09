class GroupUsersController < ApplicationController
  
  def create
    @group = Group.find(params[:group_id])
    group_user = GroupUser.new
    group_user.user_id = current_user.id
    group_user.group_id = @group.id
    if group_user.save
      redirect_to group_path(@group.id)
    else
      redirect_to groups_path
    end
  end
  
  def destroy
    @group = Group.find(params[:group_id])
    group_user = GroupUser.find_by(user_id: current_user.id, group_id: @group.id)
    if group_user.destroy
      redirect_to group_path(@group.id)
    else
      redirect_to groups_path
    end
  end
  
end

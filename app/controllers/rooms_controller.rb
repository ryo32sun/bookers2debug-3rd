class RoomsController < ApplicationController
  # before_action :follow_correct_user, only: [:create, :show]
  
  def create
    @room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: @room.id)
    another_entry = Entry.create(join_room_params)
    redirect_to room_path(@room)
  end
  
  
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
    @entries.each do |entry|
      if entry.user_id == current_user.id
        @mutual = true
      end
    end
    if @mutual
      render :show
    else
      redirect_to users_path
    end
  end

  def index
  end
  
  private
  
  def join_room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
    # params.permit(:user_id, :room_id).merge(room_id: @room.id)
  end
  
  # def follow_correct_user
  #   @user = User.find(params[:use_id])
  #   unless @user.following?(current_user) && current_user.following?(@user)
  #     redirect_to users_path
  #   end
  # end
  
end

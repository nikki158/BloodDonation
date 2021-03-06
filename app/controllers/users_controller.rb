#Author: Ibrahim Ali Mohamed
#Emial: ibrahim.ali.0403@gmail.com

class UsersController < ApplicationController
  before_action :authenticate_logging_in, only: [:active_donations, :pause, :unpause]
  before_action :set_user, only: [:show, :active_donations]
  
  # show the profile of user if not hidden
  def show   
    usersids = User.getUsersHideThierAccounts
    @hide_account = false
    if usersids.include?(@user.id)
      @hide_account = true
    end
  end 
 
  # show donor active donation
  def active_donations
    @requests = User.my_active_donations(current_user) 
  end

  def pause
    current_user.update_attribute(:pause , true)
    if current_user.pause
      current_user.update_attribute(:stop_getting_email , true)
      redirect_to root_path, notice: "Successfully paused your donation ability."
    else
      redirect_to root_path, alert: "Something went wrong with your account, plaese call us"
    end
  end

  def unpause
    current_user.update_attribute(:pause , false)
    if !current_user.pause
      current_user.update_attribute(:stop_getting_email , false)
      redirect_to root_path, notice: "Successfully unpaused your donation ability."
    else
      redirect_to root_path, alert: "Something went wrong with your account, plaese call us"
    end
  end

  private
    #authenticate user
    def authenticate_logging_in
      if current_user === nil
        redirect_to new_user_session_path , notice: "You must login first!"       
      end
    end

    def set_user
      #@user = User.find(params[:id])
      @user = User.find( User.decrypt(params[:id]) )
    end 
end

#Author: Ibrahim Ali Mohamed
#Emial: ibrahim.ali.0403@gmail.com

class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :configure_permitted_parameters, if: :devise_controller?
   
    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :birth_date, :phone, :nationalid, :blood_type, :gender, :lastdonation, :savedpeople, :location_name, :location_lng, :location_lat, :num_of_active_requests, :pause, :notifications,:created_at, :hide_account, :stop_getting_email ) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :birth_date, :phone, :nationalid, :blood_type, :gender, :lastdonation, :savedpeople, :location_name, :location_lng, :location_lat,:created_at, :num_of_active_requests, :pause, :notifications, :hide_account, :stop_getting_email) }
        end
end

class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :clear_item_search

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:fname, :lname, :email, :password, :password_confirmation)
      end
    end

    def after_sign_in_path_for user
      session[:forward_url] ? session.delete(:forward_url) : super
    end

    def get_current_auction
      #  now = TimeDate.current
      #  upcoming auction = now < start
      #  auction in progress = now > start && now < finish
      #  auction over = now > finish
      #  To determine the current auction: look for an auction that is in progress or upcoming,
      #    if none exists, the current auction is the last auction, that is, the most recently ended.
      @auction = # Auction.find("? < start", now) ||
                 # Auction.find("? > start AND ? < finish", now, now) ||
                   Auction.order(:finish).last
    end

    def clear_item_search
      user_searching = params[:name_sort] || params[:current_bid_sort] || params[:bid_count_sort]
      session[:search] = nil unless user_searching
    end

end

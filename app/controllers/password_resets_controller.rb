class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
    render
  end
  
  def create
    @user = User.find_by_email(params[:email])
    
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "We've sent you an email. Please check your inbox for instructions on how to reset your password."
      redirect_to root_url
      
    else
      flash[:notice] = "No member was found with that email address."
      render :action => :new
    end
  end
  
  def edit
    render
  end
  
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password updated OK. Welcome back."
      redirect_to books_path
    else
      render :action => :edit
    end
  end
  
  private
  
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:alert] = "We couldn't find your account. Try restarting the password reset process."
      redirect_to root_url
    end
  end
  
end

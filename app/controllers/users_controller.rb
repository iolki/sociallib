class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :show]
  before_filter :require_user, :only => [:edit, :update, :watched_books, :loans]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thanks for joining Sutton Bookshare. Welcome!"
      redirect_back_or_default books_path
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
    
  def watched_books
    @watchings = Watching.find_all_by_user_id(current_user, :order => "created_at DESC")
  end
  
  def loans
    @loans = current_user.active_loans
  end
  
  def borrowings
    @loans = current_user.active_borrowings
  end
end
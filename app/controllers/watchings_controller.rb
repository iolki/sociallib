class WatchingsController < ApplicationController
  before_filter :require_user
  
  # POST /watchings
  # POST /watchings.xml
  def create
    @watching = Watching.create(:book_id => params[:book_id], :user => current_user)
    redirect_to title_path(@watching.book.title), :notice => "Watched book OK"
  end
  
  # DELETE /watchings/1
  # DELETE /watchings/1.xml
  def destroy
    @watching = Watching.find_by_id_and_user_id(params[:id], current_user) # Need to check that this watching belongs to this user
    @watching.destroy

    respond_to do |format|
      format.html { redirect_to(:watchlist, :notice => "Unwatched book OK") }
      format.xml  { head :ok }
    end
  end
end

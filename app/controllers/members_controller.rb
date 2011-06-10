class MembersController < ApplicationController
  def index
    @members = User.all :order => 'RANDOM()', :limit => 30
  end

  def show
    @user = User.find_by_login(params[:login])

    respond_to do |format|
      format.html
      format.rss { render :layout => false } # show.rss.builder
      format.atom { render :layout => false } # show.atom.builder
    end
  end
end

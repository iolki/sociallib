class AuthorsController < ApplicationController
  # GET /authors/1
  # GET /authors/1.xml
  def show
    @author = Author.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.rss { render :layout => false } # show.rss.builder
      format.atom { render :layout => false } # show.atom.builder
      format.xml  { render :xml => @author }
      format.json { render :json => @author }
    end
  end
end

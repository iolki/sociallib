class TitlesController < ApplicationController
  def index
    @titles = Title.all :order => 'created_at DESC'
    
    respond_to do |format|
      format.atom { render :layout => false } # index.atom.builder
      format.xml  { render :xml => @titles, :include => [:books, :subject, :authors] }
      format.json  { render :json => @titles, :include => [:books, :subject, :authors] }
    end
  end

  # GET /titles/1
  # GET /titles/1.xml
  # GET /titles/1.json
  def show
    @title = Title.find_by_isbn13(params[:id])
    @watching = Watching.new
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @title, :include => [:books, :subject, :authors] }
      format.json { render :json => @title, :include => [:books, :subject, :authors] }
    end
  end
end

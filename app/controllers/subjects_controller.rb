class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all(:order => :name)
  end

  # GET /subjects/1
  # GET /subjects/1.xml
  def show
    @subject = Subject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subject }
      format.json { render :json => @subject }
    end
  end
end

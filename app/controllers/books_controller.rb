class BooksController < ApplicationController
  before_filter :require_user, :except => [ :show ] 

  # GET /books
  # GET /books.xml
  def index
    @books = Book.find_all_by_user_id(current_user.id, :order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
#       format.xml  { render :xml => @books.to_xml(:include => :title) }
#       format.json { render :json => @books.to_json(:include => :title) }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
      format.json { render :json => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = current_user.books.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    begin
      if @title = Title.find_or_create_by_isbn13(params[:isbn13])
  
        @book = Book.create(
          :title => @title,
          :user => current_user,
          :status => StaticData::BOOK_STATUS['AVAILABLE']
        )
    
        respond_to do |format|
          if ! @book.nil?
            format.html { redirect_to(books_path, :notice => 'Book was added OK') }
            format.xml  { render :xml => @book, :status => :created, :location => @book }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
          end
        end
    else
      flash[:alert] = "Invalid ISBN."
      redirect_to :books
    end

    rescue
      flash[:alert] = "Book not found. Sorry, you can't add this book at the moment. We're working to recognise more books."
      redirect_to :books
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = current_user.books.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = current_user.books.find(params[:id])

    if @book.available?
      @book.destroy
  
      respond_to do |format|
        format.html { redirect_to(books_url, :notice => "Book deleted OK") }
        format.xml  { head :ok }
      end
    else
      redirect_to(books_url, :notice => "You can't delete books that are on loan")
    end
  end
end

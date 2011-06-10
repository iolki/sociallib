class SearchController < ApplicationController
  def index
    @q = params[:q].strip.downcase
#     @type = params[:type]
#     if @type == 'titles'
      # sqlite uses || operator to concat strings, postgres uses TEXTCAT
      @titles = Title.find_by_sql(["
        SELECT *
        FROM titles
        WHERE LOWER(TEXTCAT(TEXTCAT(title, ' '), subtitle)) LIKE(?)", "%#{@q}%"
      ])
      Search.create(:query => @q, :results => @titles.count)

#     elsif @type == 'authors'
#       @titles = Author.find_by_sql("
#         SELECT t.*
#         FROM authors a
#         LEFT JOIN titles t
#         ON t
#         WHERE title || ' ' || subtitle LIKE('%#{params[:q]}%')
#       " )
#     else
#       @titles = []
#     end
  end
end

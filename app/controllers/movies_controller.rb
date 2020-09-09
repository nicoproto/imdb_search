class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # 1.  @movies = Movie.where(title: params[:query])

      # 2.  @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")

      # 3.  sql_query = "title ILIKE :query OR syllabus ILIKE :query"
      #     @movies = Movie.where(sql_query, query: "%#{params[:query]}%")
      # 4. sql_query = " \
      #     movies.title @@ :query \
      #     OR movies.syllabus @@ :query \
      #     OR directors.first_name @@ :query \
      #     OR directors.last_name @@ :query
      #   "
      #   @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      @movies = PgSearch.multisearch(params[:query]).map { |result| result.searchable }
    else
      @movies = Movie.all
    end
  end
end

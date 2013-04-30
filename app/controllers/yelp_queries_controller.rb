class YelpQueriesController < ApplicationController
  respond_to :json

  def create
    @query = YelpQuery.new.fetch!(params[:query])
    if @query.has_key?("error")
      render :json => { :results => @query }
    else
      render :json => { :results => YelpResult.load(@query["businesses"].first(5)) }
    end
  end
end

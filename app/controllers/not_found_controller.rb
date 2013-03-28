class NotFoundController < ApplicationController
  def show
    render :text => "Page not found"
  end
end
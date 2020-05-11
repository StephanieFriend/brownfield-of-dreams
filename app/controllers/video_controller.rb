class VideoController < ApplicationController

  def show
    @presenter = Video.find(params[:id])
  end
end
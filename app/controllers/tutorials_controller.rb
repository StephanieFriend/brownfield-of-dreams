class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    redirect_to edit_admin_tutorial_path(tutorial) if @facade.videos == []
  end

  def message
    tutorial = Tutorial.find(params[:id])
    flash[:notice] = "You must be logged in to bookmark videos."
    redirect_to tutorial_path(tutorial)
  end
end

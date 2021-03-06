class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def import
    @tutorial = Tutorial.new
  end

  def create
    begin
      tutorial = Tutorial.new(tutorial_params)
      tutorial.import if tutorial.playlist_id
      tutorial.save

      flash[:success] = "Successfully created tutorial. #{
      view_context.link_to('View it here', tutorial_path(tutorial.id))}."
    rescue StandardError
      flash[:error] = 'Unable to create playlist.'
    end
    redirect_to admin_dashboard_path
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :playlist_id, :title,
                                     :description, :thumbnail)
  end
end

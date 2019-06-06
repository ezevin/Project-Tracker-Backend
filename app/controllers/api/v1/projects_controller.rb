class Api::V1::ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render json: @projects.to_json(include: [materials: {only: [:label, :price, :description, :quantity, :image_url, :place_purchased]}])
  end

  def create
    @project = Project.create(project_params)
    render json: @project
  end

  def update
    get_project.update(project_params)
    render json: @project
  end

  def destroy
    get_project.destroy
    flash[:notice] = "You have deleted this project"
  end
# private
  def get_project
    @project = Project.find(params[:id])
  end

  def project_params
      params.require(:project).permit(:title, :user_id, :start_date, :due_date, :budget, :finished, :details, :finished_image)
  end

end

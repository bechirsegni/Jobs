class ResumesController < ApplicationController
  before_filter :set_resume, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @resumes = Resume.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 1)
    @newsletter = Newsletter.new
  end

  def show
  end

  def new
    @resume = current_user.resumes.build
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    if @resume.save
      redirect_to resumes_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @resume.update(resume_params)
      redirect_to resume_path
    else
      render :edit
    end
  end

  def destroy
    if @resume.destroy
      redirect_to root_path
    else
      redirect_to resume_path
    end
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:title, :description, :location, :role,:date,:edu_title,:edu_location,:edu_date,:edu_description,:additional )
  end

  def correct_user
    @resume = current_user.resumes.find_by(id: params[:id])
    redirect_to resumes_path, notice: "Not authorized to edit this job" if @resume.nil?
  end
end
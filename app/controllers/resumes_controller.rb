class ResumesController < ApplicationController
  before_filter :set_resume, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:skills].present?
      @resumes = Resume.skilled_with(params[:skills]).paginate(:page => params[:page], :per_page => 5).page(params[:page]).includes(:user).order("id DESC")
    elsif
      @resumes ||= Resume.search(params[:search]).location(params[:location]).paginate(:page => params[:page], :per_page => 5).page(params[:page]).includes(:user).order("id DESC")
    else
      @resumes = Resume.all.paginate(:page => params[:page], :per_page => 5).page(params[:page]).includes(:user).order("id DESC")
    end
    @newsletter = Newsletter.new
    @jobs = Job
  end

  def show
  @resume.user
  end

  def new
    @resume = current_user.resumes.build
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    @resume.cv = params[:resume][:cv]
    if @resume.save!
      redirect_to resumes_path, notice:'Resume was successfully Created'
    else
      render :new
    end
  end

  def download
    send_file @resume.cv.path, :type => @resume.cv_content_type, :disposition => 'inline'
  end


  def edit

  end

  def update
    if @resume.update(resume_params)
      redirect_to resume_path ,notice:'Resume was successfully Updated'
    else
      render :edit
    end
  end

  def destroy
      @resume.destroy
      redirect_to root_path, notice:'Resume was successfully Destroyed'
  end


  private

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:title,:location, :experience,:education,:information,:user_id,:skill_list,:cv )
  end

  def correct_user
    @resume = current_user.resumes.find_by_id(params[:id])
    redirect_to resumes_path, notice: "Not authorized to edit this job" if @resume.nil?
  end
end

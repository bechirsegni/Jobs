class JobsController < ApplicationController
  before_filter :set_job, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:tag]
      @jobs = Job.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 8).page params[:page]
    elsif params[:query].present?
      @jobs = Job.search(params[:query], page: params[:page])
    else
      @jobs = Job.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8).page params[:page]
    end
    @newsletter = Newsletter.new
  end



  def show
  end

  def new
    @job = current_user.jobs.build
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def update
    if @job.update(job_params)
      @job.category_id = params[:category_id]
      redirect_to job_path
    else
      render :edit
    end
  end

  def destroy
    if @job.destroy
      redirect_to root_path
    else
      redirect_to job_path
    end
  end

 private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :company_name,:location,:salary,:experience,:category_id,:tag_list)
  end

  def correct_user
    @job = current_user.jobs.find_by(id: params[:id])
    redirect_to jobs_path, notice: "Not authorized to edit this job" if @job.nil?
  end

end
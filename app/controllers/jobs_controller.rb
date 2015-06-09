class JobsController < ApplicationController
  before_filter :set_job, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]


  def index
    @jobs = Job.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 1)
    @newsletter = Newsletter.new
  end

  def show
  end

  def new
    @job = current_user.jobs.build
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

  end

  def update
    if @job.update(job_params)
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
    params.require(:job).permit(:title, :description, :company,:location,:salary,:experience )
  end

  def correct_user
    @job = current_user.jobs.find_by(id: params[:id])
    redirect_to jobs_path, notice: "Not authorized to edit this job" if @job.nil?
  end

end
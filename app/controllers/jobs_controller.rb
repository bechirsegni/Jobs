class JobsController < ApplicationController
  before_filter :set_job, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:tags].present?
      @jobs = Job.tagged_with(params[:tags]).paginate(:page => params[:page], :per_page => 5).page(params[:page]).includes(:tags,:user).order("id DESC")
    elsif
      @jobs ||= Job.search(params[:search]).location(params[:location]).paginate(:page => params[:page], :per_page => 5).page(params[:page]).includes(:tags,:user).order("id DESC")
    elsif params[:categories].blank?
      @jobs ||= Job.all.paginate(:page => params[:page], :per_page => 5).page(params[:page]).includes(:tags,:user).order("id DESC")
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
    if @job.save!
      redirect_to jobs_path, notice: "Job Successfully Created"
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
   if  @job.destroy
      redirect_to jobs_path, notice: 'Job Successfully Destroyed'

    else
      redirect_to job_path
    end
  end

 private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :company_name,:location,:salary,:experience,:category_id,:tag_list,:address,:url,:apply)
  end

  def correct_user
    @job = current_user.jobs.find_by_id(params[:id])
    redirect_to jobs_path, notice: "Not authorized to edit this job" if @job.nil?
  end

end
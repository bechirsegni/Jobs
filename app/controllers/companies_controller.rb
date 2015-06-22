class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = current_user.companies.build
  end

  def edit
  end


  def create
    @company = current_user.companies.build(company_params)
    if @company.save!
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  def update
      if @company.update(company_params)
       redirect_to @company, notice: 'Company was successfully updated.'
      else
       render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name,:about,:address,:user_id,:job_id,:logo,:website)
    end

  def correct_user
    @company = current_user.companies.find_by(params[:id])
    redirect_to companies_path, notice: "Not authorized to edit this job" if @company.nil?
  end
end

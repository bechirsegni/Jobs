class NewslettersController < ApplicationController

  def index
  @newsletters = Newsletter.all
  end
  def new
    @newsletter = Newsletter.new
  end
  def create
    @newsletter = Newsletter.create(newsletter_params)
    if @newsletter.save!
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def newsletter_params
    params.require(:newsletter).permit(:email)
  end

end
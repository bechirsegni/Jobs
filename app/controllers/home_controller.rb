class HomeController < ApplicationController

  def index
    @jobs = Job.all
    @resumes = Resume.all
  end

  def about
  end

  def terms
  end

  def contact
  end
end

class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:tag]
      @blogs = Blog.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 1).page(params[:page])
    elsif params[:query].present?
      @blogs = Blog.search(params[:query])
    else
      @blogs = Blog.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 1).page(params[:page])
    end
  end


  def show
  end

  def new
    @blog = current_user.blogs.build
  end

  def edit
  end

  def create
    @blog = current_user.blogs.build(blog_params)
      if @blog.save
      redirect_to @blog, notice: 'Post was successfully created.'
      else
        render :new
       end
  end

  def update
      if @blog.update(blog_params)
        redirect_to @blog, notice: 'Post was successfully updated.'
        else
         render :edit
      end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :description, :tags,:tag_list)
    end

    def correct_user
      @blog = current_user.blogs.find_by(id: params[:id])
      redirect_to blogs_path, notice: "Not authorized to edit this Post" if @blog.nil?
    end
end

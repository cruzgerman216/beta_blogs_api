class BlogsController < ApplicationController
  
  before_action :authenticate_request, except: [:index]

  def index
    blogs = Blog.all

    render json: BlogBlueprint.render(blogs, view: :normal)
  end

  def create 
    blog = @current_user.blogs.new(blog_params)

    if blog.save
      render json: BlogBlueprint.render(blog, view: :normal), status: :created
    else
      render json: blog.errors, status: :unprocessable_entity
    end
  end

  private 

  def blog_params 
    params.permit(:title, :content, :cover_image)
  end
end
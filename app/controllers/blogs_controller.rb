class BlogsController < ApplicationController
  
  def index
    result = BlogService::Base.filter(params)
    if result.success?
      render_success(payload: BlogBlueprint.render_as_hash(result.payload, view: :normal, current_user: @current_user), status: :ok)
    else 
      render_error(errors: result.errors, status: :unprocessable_entity)
    end
  end 

  def create 
    blog = @current_user.blogs.new(blog_params)

    if blog.save
      render json: BlogBlueprint.render(blog, view: :normal), status: :created
    else
      render json: blog.errors, status: :unprocessable_entity
    end
  end

  def like
    blog = Blog.find(params[:blog_id])
    like = blog.likes.new(user_id: @current_user.id) 
    blog_creator = blog.user
    
    if like.save
      Pusher.trigger(blog_creator.id, 'like', {
        blog_id: blog.id,
        notification: "#{@current_user.username} has liked #{blog.title}!"
      })
      head :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def unlike
    blog = Blog.find(params[:blog_id])
    like = blog.likes.find_by(user_id: @current_user.id)
    if like.destroy
      head :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  private 

  def blog_params 
    params.permit(:title, :content, :cover_image)
  end
end
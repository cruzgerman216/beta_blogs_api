class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserBlueprint.render(user, view: :normal), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
  

  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params)

    render json: blog
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy

    render json: blog
  end

  private

  def user_params
    params.permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
  end
end

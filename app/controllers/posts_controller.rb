class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  # only signed in user can access the #new and #create action
  before_action :signed_in_user, only: [:new, :create]
  def new
  	@post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.user_id
    @post.save
    redirect_to root_path
  end

  private

    def signed_in_user
  	  redirect_to signin_path, notice: "Please sign in" unless signed_in?
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end

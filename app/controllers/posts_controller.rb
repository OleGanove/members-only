class PostsController < ApplicationController
  # only signed in user can access the #new and #create action
  before_action :signed_in_user, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    @post.save
    redirect_to root_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to(:back)
    flash[:error] = "Post has been deleted"
  end

  private

    def signed_in_user
  	  redirect_to signin_path, notice: "Please sign in" unless signed_in?
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end

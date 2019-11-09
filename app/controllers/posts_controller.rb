class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :show
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build post_params
    flash[:success] = t "flash.success.micropost_created"
    if @post.save
      params[:post_images]["image"].each do |a|
        @post_image = @post.post_images.create!(link: a)
      end
    end
    redirect_to current_user
  end

  def show
    @post = Post.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end

  def destroy
    @post_id = @post.id
    respond_to do |format|
      format.html{redirect_to current_user}
      if @post.destroy
        format.js{flash[:success] = t "flash.success.micropost_deleted"}
      else
        format.js{flash[:danger] = t "flash.danger.delete_micropost_fail"}
      end
    end
  end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end

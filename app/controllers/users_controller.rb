class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :show
  before_action :load_user, only: %i(show destroy following followers)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  # authorize_resource

  def show
    @posts = @user.posts.create_desc.page(
      params[:page]
    ).per Settings.num_feeds_per_page
    redirect_to(root_url) && return unless @user
  end

  def index; end

  def new
    @user = User.new
  end

  def newfeed
    @reivew_posts = current_user.posts.build
    @feed_items = current_user.feed.create_desc.page(
      params[:page]
    ).per Settings.num_feeds_per_page
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t "flash.success.welcome_message"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def destroy
    if @user.admin?
      flash[:danger] = t"flash.danger.cannot_delete_admin"
    elsif @user.destroy
      flash[:success] = t "flash.success.user_deleted_message"
    else
      flash[:danger] = t"flash.danger.cannot_deleted"
    end
    redirect_to user_url
  end

  def following
    @title = t "label.following"
    @users = @user.following.page params[:page]
    render :show_follow
  end

  def followers
    @title = t "label.followers"
    @users = @user.followers.page params[:page]
    render :show_follow
  end

  private

  def correct_user
    return if current_user? @user
    flash[:danger] = t "flash.danger.not_correct_user"
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?
    flash[:danger] = t "flash.danger.not_admin"
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.danger.user_not_found"
    redirect_to root_path
  end
end

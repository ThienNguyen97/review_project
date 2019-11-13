class CommentsController < ApplicationController
#   before_action :authenticate_user!

#   def show
#     @post_id = params[:id]
#     @list_post_comments = Comment.create_desc.list_post_comments params[:id]
#     respond_to do |format|
#       format.html
#       format.js
#     end
#   end

#   def create
#     @post_id = comment_params[:post_id]
#     @comment = current_user.comments.build comment_params
#     respond_to do |format|
#       format.html
#       if @comment.save
#         Notifications::CommentReplyService.new(@comment).perform
#         @list_post_comments = Comment.create_desc.list_post_comments @post_id
#         format.js{flash[:success] = t "flash.success.comment_created"}
#       else
#         @list_post_comments = Comment.create_desc.list_post_comments @post_id
#         format.js{flash[:danger] = t "flash.danger.create_comment_fail"}
#       end
#     end
#   end

#   def destroy
#     @comment = Comment.find_by id: params[:id]
#     @post_id = @comment.post_id
#     respond_to do |format|
#       format.html
#       if @comment.destroy
#         @list_post_comments = Comment.create_desc.list_post_comments @post_id
#         format.js{flash[:success] = t "flash.success.comment_deleted"}
#       else
#         @list_post_comments = Comment.create_desc.list_post_comments @post_id
#         format.js{flash[:danger] = t "flash.danger.delete_comment_fail"}
#       end
#     end
#   end

#   private

#   def comment_params
#     params.require(:comment).permit(:post_id, :content)
#   end
# end
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comment, only: %i(update destroy)

  def create
    comments = @post.comments
    comment = @post.comments.build comment_params

    if comment.save
      flash[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end

    render json: {comments_count: comments.size, comment_id: comment.id}
  end

  def update
    @comment.post_id = params[:post_id]

    if @comment.update comment_params.merge user_id: current_user.id
      flash[:success] = t "update_success"
    else
      flash[:danger] = t "update_fail"
    end
  end

  def destroy
    comments = @post.comments

    if (comments.include? @comment) && comments.delete(@comment)
      flash[:success] = t "destroy_success"
    else
      flash[:danger] = t "destroy_fail"
    end

    render json: {comments_count: @post.comments.size}
  end

  private

  def comment_params
    params.require(:comment).permit :content, :post_id, :user_id
  end

  def find_comment
    @comment = @post.comments.find_by id: params[:id]

    return if @comment
    flash[:danger] = t "comment_not_found"
    redirect_to posts_path @post
  end

  def find_post
    @post = Post.find_by id: params[:post_id]

    return if @post.present?
    flash[:danger] = t "post_not_found"
    redirect_to root_path
  end
end

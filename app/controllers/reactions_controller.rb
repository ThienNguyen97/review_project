class ReactionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post_id = params[:id]
    @liked_post_users = User.liked_post_users Settings.reaction_type.like,
      params[:id]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @reaction = Reaction.create reaction_type_id: params[:reaction_type_id],
                                user_id: params[:user_id],
                                post_id: params[:post_id]
    # Notifications::ReactionReplyService.new(@reaction).perform
    @post_id = params[:post_id]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @reaction = Reaction.find_by id: params[:id]
    @post_id = @reaction.post_id
    @reaction.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end
end

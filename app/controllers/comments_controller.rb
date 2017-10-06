class CommentsController < ApplicationController

  expose_decorated(:support)

  def create
    comment = CommentOnSupport.new(current_user.object, support, comment_params)
    comment.commence!

    redirect_to support_path(support), notice: "You contributed to this support request"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

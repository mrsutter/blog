class Web::Posts::CommentsController < Web::Posts::ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    init_comment
    save_comment

    respond_to do |format|
      format.html { redirect_to post_path(resource_post) }
      format.js
    end
  end

  private

  def init_comment
    @comment = resource_post.comments.new
    @comment.user = current_user
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def save_comment
    verify_comment && @comment.update_attributes(comment_params)
  end

  def verify_comment
    return true if current_user
    verify_recaptcha(model: @comment, attribute: :captcha)
  end
end

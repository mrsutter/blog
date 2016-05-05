class Web::Posts::CommentsController < Web::Posts::ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user!, :authenticate_admin!,
                     only: [:create]

  def create
    init_comment
    save_comment
    find_comments

    respond_to do |format|
      format.html { redirect_to post_path(resource_post) }
      format.js
    end
  end

  def accept
    find_comment
    @comment.accept!

    respond_to do |format|
      format.html { redirect_to post_path(resource_post) }
      format.js
    end
  end

  def decline
    find_comment
    @comment.decline!

    respond_to do |format|
      format.html { redirect_to post_path(resource_post) }
      format.js
    end
  end

  def destroy
    find_comment
    @comment.destroy!
    find_comments

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

  def find_comment
    @comment ||= resource_post.comments.find(params[:id])
  end

  def find_comments
    @comments ||= resource_post.comments.available_for(current_user)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def save_comment
    verify_comment && @comment.update_attributes(comment_params)
  end

  def verify_comment
    return true if current_user
    Recaptcha.verify(@comment, recaptcha_response)
  end

  def recaptcha_response
    params['g-recaptcha-response']
  end
end

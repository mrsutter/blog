class Web::PostsController < Web::ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user!, :authenticate_admin!,
                     only: [:index, :show]

  def index
    query_params = params[:q] || { sort: 'desc' }

    @q = PostSearchType.new(query_params)
    @posts = @q.search
               .preload(post: { scope: Post.includes(:category) })
               .page(params[:page])
               .per(per_page)
  end

  def show
    find_post
    find_comments
    init_comment
  end

  def new
    init_post
  end

  def create
    init_post
    if @post.update_attributes(post_params)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    find_post
  end

  def update
    find_post

    if @post.update_attributes(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    find_post

    @post.destroy!
    redirect_to root_path
  end

  private

  def init_post
    @post = Post.new
  end

  def find_post
    @post ||= Post.includes(comments: :user).find(params[:id])
  end

  def find_comments
    @comments ||= @post.comments.available_for(current_user).ordered
  end

  def init_comment
    @comment = Comment.new
  end

  def post_params
    params.require(:post).permit(:category_id, :name, :body, tag_list: [])
  end
end

class Web::Posts::ApplicationController < Web::ApplicationController
  def resource_post
    @post ||= Post.find(params[:post_id])
  end
end

class PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.order(created_at: :desc)
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      flash.now[:notice] = "コメントを送信しました。"
    else
      flash.now[:notice] = "コメントを入力してください。"
    end
  end

  def destroy
    @post_comment = PostComment.find_by(post_id: params[:post_id], id: params[:id])
    @post_comment.user_id = current_user.id
    @post_comment.destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.order(created_at: :desc)
    flash.now[:notice] = "コメントを削除しました。"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

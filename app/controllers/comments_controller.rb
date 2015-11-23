class CommentsController < ApplicationController

	def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    # @ecomment.username = current_user.name
    redirect_to :back
	end

	def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id]) if @post.present?

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def update
  # 	@post = Post.find(params[:post_id])
  # 	@comment = @post.comments.find(params[:id]) if @post.present?

  #   respond_to do |format|
  #     if @comments.update(comment_params)
  #       format.html { redirect_to :back, notice: 'Comment was successfully edited.' }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
	  @comment = Comment.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def comment_params
	  params.require(:comment).permit(:body)
	end

end

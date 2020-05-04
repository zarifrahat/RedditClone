class CommentsController < ApplicationController
    before_action :ensure_logged_in
    
    def new
        @comment = Comment.new

        render :new
    end

    def create
        @comment = Comment.new(comment_params)

        if @comment.save
            redirect_to post_url(params[:post_id])
        else
            flash[:errors] = @comment.errors.full_messages
            render :new
        end
    end

    def show
        @comment = Comment.find_by(id: params[:id])

        render :show
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end

class PostsController < ApplicationController
    before_action  :ensure_logged_in
    before_action :ensure_author, only:[:new, :create, :destroy, :edit, :update]


    def new
        @subs = Sub.all
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        
        if @post.save
            redirect_to post_url(params[:id])
        else
            flash[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def show
        @post = Post.find_by(id: params[:id])
        @comments_by_parent_id = @post.comments_by_parent_id
        render :show

    end

    def destroy
        @post = Post.find_by(id: params[:id])

        @post.delete
        redirect_to sub_url(params[:sub_id])
    end

    def edit
        @post = Post.find_by(id: params[:id])
        if @post
            render :edit
        else
            flash[:errors] = ["Post does not exist!"]
            redirect_to sub_url(params[:sub_id])
        end
    end

    def update
        @post = Post.find_by(id: params[:id])
        if @post.update_attributes(post_params)
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            render :edit
        end

    end

    private

    def post_params
        params.require(:post).permit(:title, :url, :content, :sub_ids)
    end
end

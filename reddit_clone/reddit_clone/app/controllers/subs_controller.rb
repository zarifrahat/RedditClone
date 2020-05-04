class SubsController < ApplicationController
    before_action :ensure_moderator, only: [:edit, :update, :destroy]

    def index
        @subs = Sub.all
        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def destroy
        @sub = Sub.find(params[:id])
        @sub.delete
        redirect_to subs_url
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to subs_url
        else
            flash[:errors] = @sub.errors.full_messages
            redirect_to subs_url
        end
    end

    def edit
        @sub = Sub.find(params[:id])
        if @sub
            render :edit
        else
            flash[:errors] = ["Sub does not exist!"]
        end
    end

    def update
        @sub = Sub.find(params[:id])
        if @sub.update_attributes(sub_params)
            redirect_to sub_url(@sub)
        else
            flash[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    def new
        render :new
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end

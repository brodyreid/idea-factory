class IdeasController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authorize, only: [:edit, :update, :delete] ## order here matters, need to find idea before authorizing that idea

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = current_user
        if @idea.save
            flash[:primary] = "Idea created!"
            redirect_to idea_path(@idea.id)
        else
            render :new
        end
    end

    def index
        @ideas = Idea.all.order(created_at: :desc)
    end

    def show
        @review = Review.new
        @reviews = @idea.reviews.order(created_at: :desc)
    end

    def edit
    end

    def update
        if @idea.update idea_params
            flash[:dark] = "Idea has been updated!"
            redirect_to idea_path(@idea)
        else
            render :edit
        end
    end

    def destroy
        @idea.destroy
        flash[:danger] = "Idea has been deleted!"
        redirect_to root_path
    end


    private
    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def find_idea
        @idea = Idea.find params[:id]
    end

    def authorize
        unless can?(:crud, @idea)
            flash[:danger] = "Not Authorized"
            redirect_to root_path
        end
    end
end

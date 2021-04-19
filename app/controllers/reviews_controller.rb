class ReviewsController < ApplicationController
    before_action :authenticate_user!

    def create
        @idea = Idea.find params[:idea_id]
        @review = Review.new review_params
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            flash[:light] = "Review posted"
            redirect_to idea_path(@idea)
        else
            render 'ideas/show'
        end
    end

    def destroy
        @review = Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy
            flash[:danger] = "Review deleted"
            redirect_to idea_path(@review.idea)
        else
            head :unauthorized
        end    
    end

    private

    def review_params
        params.require(:review).permit(:description)
    end
end

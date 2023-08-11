class SubsController < ApplicationController
    before_action :ensure_moderator_exists, only: [:edit, :update]

    def edit
        @sub = Sub.find_by(id: params[:id])
        render :edit
    end

    def update 
        @sub = Sub.find_by(id: params[:id])
        if sub && sub.update(update_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit 
        end
    end


    private 

    def ensure_moderator_exists
        @sub = Sub.find(params[:id])
        unless sub.moderator_id == current_user.id
            flash.now[:errors] = ["Only moderators can edit subs."]
            render :edit         
        end
    end

    def update_params 
        params.require(:sub).permit(:title, :description)
    end
end



class SubsController < ApplicationController
    before_action :ensure_moderator_exists, only: [:edit, :update]

    def edit
        @sub = Sub.find_by(id: params[:id])
        render :edit
    end


    private 

    def ensure_moderator_exists
        @sub = Sub.find(params[:id])
        unless sub.moderator_id == current_user.id
            flash.now[:errors] = ["Only moderators can edit subs."]
            render :edit         
        end
    end
end

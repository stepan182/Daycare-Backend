class AllergiesController < ApplicationController
  before_action :authorize
    
    def index
        @allergies = Allergy.all
        @allergy = Allergy.new
    end
    
    def new
        @allergy = Allergy.new
    end
    
    def create
        @allergy = Allergy.new(allergy_params)
        if @allergy.save
          flash[:success] = "Success: allergy added"
          redirect_to allergies_path
        else
          render 'new'
        end
    end
    
    def update
        @allergy = Allergy.find(params[:id])
        if @allergy.update_attributes(allergy_params)
          flash[:success] = "Allergy updated"
          redirect_to request.referrer
        else
          flash[:danger] = "Allergy not updated. " + @allergy.errors.full_messages.to_s
          redirect_to request.referrer
        end
    end
    
    def destroy
        @allergy = Allergy.find(params["id"])
        @allergy.destroy
        flash[:success] = "Allergy deleted"
        redirect_to request.referrer
    end
    
    
    private

    def allergy_params
      params.require(:allergy).permit(:allergy_name, :icon, :description)
    end
    
end

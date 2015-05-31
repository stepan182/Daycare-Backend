class AllergiesController < ApplicationController
  before_action :authorize
    
    def index
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
    
    def destroy
        #@allergy.destroy
        flash[:success] = "Allergy deleted"
        redirect_to request.referrer || root_url
    end
    
    
    private

    def allergy_params
      params.require(:allergy).permit(:allergy_name, :icon, :description)
    end
    
end

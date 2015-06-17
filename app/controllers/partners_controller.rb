class PartnersController < ApplicationController
	before_action :authorize

	def index
        @partners = Partner.all
    end

    def new
        @partner = Partner.new
    end

    def create
    @partner = Partner.new(partner_params)
    
	    if @partner.save
	      flash[:success] = "Success: partner has been added"
	      redirect_to '/partners'
	    else
	      
	      render 'new'
	    end
    end

    def edit
    	@partner = Partner.find(params["id"])
    end

    def update
	    @partner = Partner.find(params[:id])
	    if @partner.update_attributes(partner_params)
	      flash[:success] = "Partner updated"
	      redirect_to '/partners'
	    else
	      render 'edit'
	    end
  	end

    def destroy
	    @partner = Partner.find(params["id"])
	    @partner.destroy
	    flash[:success] = "Partner deleted"
	    redirect_to '/partners'
  	end


    private

    def partner_params
      params.require(:partner).permit(:partner_name, :username, :password, :email, :address, :country)
    end

end

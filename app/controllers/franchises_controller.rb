class FranchisesController < ApplicationController
  before_action :authorize

  def index
    @franchises = Franchise.all
  end

  def new
    @franchise = Franchise.new
  end

  def create
    @franchise = Franchise.new(franchise_params)

    if @franchise.save
      flash[:success] = "Success: franchise has been added"
      redirect_to '/franchises'
    else

      render 'new'
    end
  end

  def edit
    @franchise = Franchise.find(params["id"])
  end

  def update
    @franchise = Franchise.find(params[:id])
    if @franchise.update_attributes(franchise_params)
      flash[:success] = "Franchise updated"
      redirect_to '/franchises'
    else
      render 'edit'
    end
  end

  def destroy
    @franchise = Franchise.find(params["id"])
    @franchise.destroy
    flash[:success] = "Franchise deleted"
    redirect_to '/franchises'
  end


  private

  def franchise_params
    params.require(:franchise).permit(:franchise_name, :username, :password, :email, :address, :country)
  end

end

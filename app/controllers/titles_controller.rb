class TitlesController < ApplicationController
    before_action :authorize
    
    def index
        #@titles = Title.all
        @titles = Title.all.joins(:customers).where(customers: {country: params["country"], customer_type_id: params["customer_type_name"]["customer_type_id"], id: params["customer_id"]}).joins(:user_types).where(user_types: {id: params["user_type_name"]["user_type_id"]}).joins(:daycare_departments).where(daycare_departments: {id: params["daycare_department_name"]["daycare_department_id"]}).distinct
    end
    
    def new
        @title = Title.new
    end
    
    def create
        @title = Title.create(title: params["title"]["title"])
        @title.save
            
        @title.update_attribute(:customer_ids, params[:customer_id])
        @title.update_attribute(:user_type_ids, params["user_type_name"]["user_type_id"])
        @title.update_attribute(:daycare_department_ids, params["daycare_department_name"]["daycare_department_id"])

        flash[:success] = "Success: Title created."
        redirect_to "/todos/titles?" + params["tmp_params"]
    end

    def edit
       @title = Title.find(params["id"])
    end
    
    def update
        @title = Title.find(params[:id])
        if @title.update_attributes(title_params)
          flash[:success] = "Title updated"
          redirect_to "/todos/titles?" + params["tmp_params"]
        else
          render 'edit'
        end
    end
    
    def destroy
        @title = Title.find(params["id"])
        @title.destroy
        flash[:success] = "Title deleted"
        redirect_to "/todos/titles?" + params["tmp_params"]
    end
    
    
      private

        def title_params
          params.permit(:title)
        end
    
end

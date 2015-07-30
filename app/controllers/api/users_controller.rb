class Api::UsersController < Api::ApiController

	def login
		user = User.find_by(username: params[:username])
    
	    if user && user.authenticate(params[:password])
	      render status: 200, json: user, :only => [:username, :is_manager, :is_worker, :is_parent, :customer_id, :department_id]
	      
	    else
	      render status: 422, json: {
	        errors: "Invalid username/password combination"
	      }.to_json
	    end
	end

	def create
		
		user = User.new(user_params)

		if user.save
	      render status: 200, json: {
	        message: "Successfully created user.",
	        user: user
	      }.to_json
	    else
	      render status: 422, json: {
	        errors: user.errors
	      }.to_json
	    end
	end

	def update_customer_id
		user = User.find_by(username: params[:username])
        if user.update_attribute(:customer_id, params[:customer_id])
        	render status: 200, json: {
	        message: "Successfully updated user.",
	        user: user
	      }.to_json
        end
	end

	def update_department_id
		user = User.find_by(username: params[:username])
        if user.update_attribute(:department_id, params[:department_id])
        	render status: 200, json: {
	        message: "Successfully updated user.",
	        user: user
	      }.to_json
        end
	end


	private

    def user_params
      params.permit(:name, :username, :password, :email, :country, :address, :customer_id, :is_manager, :is_worker, :is_parent)
    end

end
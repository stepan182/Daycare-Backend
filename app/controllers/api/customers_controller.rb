class Api::CustomersController < Api::ApiController

	def index

		if params[:q].present?
		  render json: Customer.where("customer_type_id = 1 and customer_name LIKE '%#{params[:q]}%'"), :only => [:id, :customer_name, :address, :country]
		else
		  render json: Customer.where(customer_type_id: 1), :only => [:id, :customer_name, :address, :country]
		end
	end

	def create
		
		customer = Customer.new(customer_params)

		if customer.save
	      render status: 200, json: {
	        message: "Successfully created daycare.",
	        daycare: customer
	      }.to_json
	    else
	      render status: 422, json: {
	        errors: customer.errors
	      }.to_json
	    end
	end

	def get_departments
		if params["customer_id"].present?
		  render json: Customer.find(params["customer_id"]).daycare_departments, :only => [:id, :department_name]
		end
	end

	def create_departments
		if params["customer_id"].present? && params[:department_name].present?
          department = DaycareDepartment.create(department_name: params[:department_name])
          if department.save
          	department.update_attribute(:customer_ids, params[:customer_id])

          	render status: 200, json: {
	        message: "Successfully created department.",
	        department: department
	        }.to_json
	      else
	        render status: 422, json: {
	          errors: department.errors
	        }.to_json
	      end

		end
	end

	def send_email_to_worker
		if params["email"].present?
			AdminMailer.invite_worker(params["email"]).deliver
			render status: 200, json: {
	          email: "Email was send"
	        }.to_json
		end
	end

	def send_email_to_parent
		if params["email"].present?
			AdminMailer.invite_parent(params["email"]).deliver
			render status: 200, json: {
	          email: "Email was send"
	        }.to_json
		end
	end


	private

    def customer_params
      params.permit(:customer_name, :email, :country, :address, :customer_type_id, :password)
    end

end
class Manager::DaycareController < ApplicationController
  layout "manager"
  
  def new
  end

  def create
  	#### Create customer daycare 
    customer = Customer.create(customer_name: params[:customer_name], email: params[:email], country: params[:country], address: params[:address], customer_type_id: 1, password: "test")

    user_type = UserType.find_by(user_type_name: "Daycare Manager", customer_id: customer.id)
			
	if !user_type
		user_type = UserType.create(user_type_name: "Daycare Manager", customer_type_id: 1, customer_id: customer.id)
	end

	user = User.find(params[:user_id])
    user.update_columns(customer_id: customer.id, user_type_id: user_type.id)

    ###### Create depts
    dept = params[:department_name]

    dept.each do |d|
    	if !d[1].to_s.blank?
        	department = DaycareDepartment.create(department_name: d[1].to_s)
          	if department.save
          		department.update_attribute(:customer_ids, customer.id)
          	end
        end
    end

    redirect_to "/manager/congratulate"
	
  end


end
class Api::PrivilegesController < Api::ApiController

	def index
		if params["user_type_id"].present?

		  privileges = Privilege.where(user_type_id: params["user_type_id"])

		  render json: privileges
		end
	end


end
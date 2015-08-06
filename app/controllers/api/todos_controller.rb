class Api::TodosController < Api::ApiController

	def index
		
		@todo = Array.new

		todos = Todo.all.joins(:customers).where(customers: {customer_type_id: params["customer_type_id"], id: params["customer_id"]}).joins(:user_types).where(user_types: {id: params["user_type_id"]}).joins(:daycare_departments).where(daycare_departments: {id: params["daycare_department_name"]["daycare_department_id"]}).distinct
		
		todos.each do |todo|
		  @tmp = Hash.new

		  @tmp[:id] = todo.id
		  @tmp[:subject] = todo.subject
		  @tmp[:complete_by] = todo.complete_by
		  @tmp[:icon] = todo.icon
		  @tmp[:repeat] = todo.repeat
		  @tmp[:delegatable] = todo.delegatable
		  @tmp[:due] = ""
		  
		  repeats = todo.repeat

          date_from = todo.complete_by
        
          case repeats	
            when "week"
              date_to = date_from.to_datetime + 1.week
            when "2week"
              date_to = date_from.to_datetime + 2.week
            when "month"
              date_to = date_from.to_datetime + 1.month
            when "year"
              date_to = date_from.to_datetime + 1.year
          else
          	date_to = date_from.to_datetime
          end

          todo.tasks.each do |task|
            task_complainces = Task.find(task.id).task_complainces.where(created_at: date_from..date_to)
            
            if !task_complainces.blank?
              @tmp[:due] = "yes"
            end

            task.subtasks.each do |subtask|
                
                subtask_complainces = Subtask.find(subtask.id).subtask_complainces.where(created_at: date_from..date_to)

                if !subtask_complainces.blank?
	              @tmp[:due] = "yes"
	            end
            end

          end

		  @todo << @tmp
          
		end

		render json: @todo
		  
	end

	def edit
		todo = Todo.find(params["id"])

		render json: todo.as_json(:include => { :tasks => {
                             :include => { :subtasks => {} },
                             } })

	end

	def post_subtask_compliance
		if params["subtask_id"].present?
			subtask = SubtaskComplaince.create(subtask_id: params["subtask_id"])
			  if subtask.save
	          	render status: 200, json: {
		        message: "Successfully created subtask compliance.",
		        compliance: subtask
		        }.to_json
		      else
		        render status: 422, json: {
		          errors: subtask.errors
		        }.to_json
		      end
		end
	end

	def get_subtask_compliance
		repeats = params["repeats"]

        date_from = params["date_from"]
        
        case repeats
          when "week"
            date_to = date_from.to_datetime + 1.week
          when "2week"
            date_to = date_from.to_datetime + 2.week
          when "month"
            date_to = date_from.to_datetime + 1.month
          when "year"
            date_to = date_from.to_datetime + 1.year
        else
        	date_to = date_from.to_datetime
        end
        
		subtask_complainces = Subtask.find(params["subtask_id"]).subtask_complainces.where(created_at: date_from..date_to)
        

        render json: subtask_complainces
	end

	def post_task_compliance
		if params["task_id"].present?
			task = TaskComplaince.create(task_id: params["task_id"])
			  if task.save
	          	render status: 200, json: {
		        message: "Successfully created task compliance.",
		        compliance: task
		        }.to_json
		      else
		        render status: 422, json: {
		          errors: task.errors
		        }.to_json
		      end
		end
	end

	def get_task_compliance
		repeats = params["repeats"]

        date_from = params["date_from"]
        
        case repeats
          when "week"
            date_to = date_from.to_datetime + 1.week
          when "2week"
            date_to = date_from.to_datetime + 2.week
          when "month"
            date_to = date_from.to_datetime + 1.month
          when "year"
            date_to = date_from.to_datetime + 1.year
        else
        	date_to = date_from.to_datetime
        end
        
		task_complainces = Task.find(params["task_id"]).task_complainces.where(created_at: date_from..date_to)
        

        render json: task_complainces

	end

	def delegate_todo
		
	end

end


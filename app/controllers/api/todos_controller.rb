class Api::TodosController < Api::ApiController

	def index
		
		@todo = Array.new

		if params["user_type_id"].present? && params["daycare_department_name"]["daycare_department_id"].present?
		  todos = Todo.all.joins(:customers).where(customers: {customer_type_id: params["customer_type_id"], id: params["customer_id"]}).joins(:user_types).where(user_types: {id: params["user_type_id"]}).joins(:daycare_departments).where(daycare_departments: {id: params["daycare_department_name"]["daycare_department_id"]}).distinct
		else
		  todos = Todo.all.joins(:customers).where(customers: {customer_type_id: params["customer_type_id"], id: params["customer_id"]}).distinct
		end

		todos.each do |todo|
		  @tmp = Hash.new

		  @tmp[:id] = todo.id
		  @tmp[:subject] = todo.subject
		  @tmp[:complete_by] = todo.complete_by
		  @tmp[:icon] = todo.icon
		  @tmp[:repeat] = todo.repeat
		  @tmp[:delegatable] = todo.delegatable
		  @tmp[:completed] = todo.completed
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
            
            if task_complainces.blank? && DateTime.now > date_from
              @tmp[:due] = "yes"
            end

            task.subtasks.each do |subtask|
                
                subtask_complainces = Subtask.find(subtask.id).subtask_complainces.where(created_at: date_from..date_to)

                if subtask_complainces.blank? && DateTime.now > date_from
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

	def create
		task = params[:task]
        subtask = params[:subtask]

		@todo = Todo.create(subject: params["subject"], icon: params["icon"], repeat: params["repeat"], complete_by: params["complete_by"], delegatable: params["todoDelegatable"])
        
        @todo.save
	    
        @todo.update_attribute(:customer_ids, params[:customer_id])
        @todo.update_attribute(:user_type_ids, params[:user_type_ids])
        @todo.update_attribute(:daycare_department_ids, params[:daycare_department_ids])
            
        task.each do |t|
          if !t[1].to_s.blank? && !params["taskDelegatable"].present?
            @task = Task.create(task: t[1].to_s, todo_id: @todo.id)
          elsif !t[1].to_s.blank? && params["taskDelegatable"].present?
            @task = Task.create(task: t[1].to_s, delegatable: params["taskDelegatable"][t[0].to_s], todo_id: @todo.id)
          end
            @task.save
            
            subtask.each do |s|    
              
            if s[0] == t[0]
                
                s[1].each do |sd|
                    
                    if !sd[1].to_s.blank? && !params["subtaskDelegatable"].present?
                      @subtask = Subtask.create(subtask: sd[1].to_s, task_id: @task.id)
                    elsif !sd[1].to_s.blank? && params["subtaskDelegatable"].present?
                      @subtask = Subtask.create(subtask: sd[1].to_s, delegatable: params["subtaskDelegatable"][t[0].to_s][sd[0].to_s], task_id: @task.id)
                    end
                    @subtask.save
              
                end
                
            end
              
            end
            
        end

        render json: {
		          todo: @todo,
		          errors: @todo.errors
		        }.to_json

	end

	def delete_todo
		todo = Todo.find(params[:todo_id])

		if todo.destroy
			render status: 200, json: {
		          message: "Todo deleted"
		          }.to_json
		else
			render status: 422, json: {
		          errors: todo.errors
		          }.to_json
		end
	end

	def update_todo
		task = params[:task]
        subtask = params[:subtask]

        @todo = Todo.find(params["id"])
        @todo.update_attributes(subject: params["subject"], icon: params["icon"], repeat: params["repeat"], complete_by: params["complete_by"], delegatable: params["todoDelegatable"])
        

        task.each do |t|
            @task = Task.find_by(id: t[0])
            if @task
                t_dlg = params["taskDelegatable"].present? ? params["taskDelegatable"][t[0].to_s] : 0
                @task.update_attributes(task: t[1].to_s, delegatable: t_dlg)
            end
        end  
            
        subtask.each do |sd|
            @subtask = Subtask.find_by(id: sd[0])
            if @subtask
                sd_dlg = params["subtaskDelegatable"].present? ? params["subtaskDelegatable"][sd[0].to_s] : 0
                @subtask.update_attributes(subtask: sd[1].to_s, delegatable: sd_dlg)
            end
        end

        render json: {
		          message: "Todo updated",
		          errors: @todo.errors
		          }.to_json
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

        todo = Todo.find(params[:todo_id])

        case todo.repeat
          when "week"
            new_date = todo.complete_by.to_datetime + 1.week
          when "2week"
            new_date = todo.complete_by.to_datetime + 2.week
          when "month"
            new_date = todo.complete_by.to_datetime + 1.month
          when "year"
            new_date = todo.complete_by.to_datetime + 1.year
        else
        	new_date = todo.complete_by.to_datetime
        end

        todo.update_attribute(:daycare_department_ids, params[:department_ids])
        todo.update_attribute(:completed, false)
        todo.update_attribute(:complete_by, new_date)

        todo.tasks.each do |task|
        	
        	task.subtasks.each do |subtask|
        		if !subtask.delegatable
        			subtask.destroy
        		#else
        			#subtask.subtask_complainces.each do |sb|
        			#	sb.destroy
        			#end
        		end
        	end

        	if !task.delegatable
        		task.destroy
        	#else
        		#tasks.task_complainces.each do |t|
        			#t.destroy
        		#end
        	end

        end

        render json: {
		        message: "Delegeted todo.",
		        todo: todo
		        }.to_json

	end

	def complete_todo
		todo = Todo.find(params[:todo_id])
		
		case todo.repeat
          when "week"
            new_date = todo.complete_by.to_datetime + 1.week
          when "2week"
            new_date = todo.complete_by.to_datetime + 2.week
          when "month"
            new_date = todo.complete_by.to_datetime + 1.month
          when "year"
            new_date = todo.complete_by.to_datetime + 1.year
        else
        	new_date = todo.complete_by.to_datetime
        end

		todo.update(completed: true, complete_by: new_date)
		render json: {
		        message: "Completed todo.",
		        todo: todo
		        }.to_json
	end

	def get_active_departments
		todo = Todo.find(params[:todo_id]).daycare_departments
		render json: todo
	end

	def get_active_user_types
		todo = Todo.find(params[:todo_id]).user_types
		render json: todo
	end

	def get_titles
		titles = Title.all.joins(:customers).where(customers: {customer_type_id: params["customer_type_id"], id: params["customer_id"]}).joins(:user_types).where(user_types: {id: params["user_type_id"]}).joins(:daycare_departments).where(daycare_departments: {id: params["daycare_department_name"]["daycare_department_id"]}).distinct
		render json: titles
	end

	def report_details
        @todo = Todo.find(params["report_id"])
        repeats = @todo.repeat

        @tasks = @todo.tasks
        @subtasks = Hash.new(Array.new)
        @required_complainces = Array.new
        @complainces = Hash.new(Array.new)
        @subtask_complainces = Hash.new(Array.new)

        ### Required Complainces
        case repeats
        when "week"
            (params["report_date_from"].to_datetime.to_i .. params["report_date_to"].to_datetime.to_i).step(1.week) do |date|
                @required_complainces << Time.at(date)
            end
        when "2week"
            (params["report_date_from"].to_datetime.to_i .. params["report_date_to"].to_datetime.to_i).step(2.week) do |date|
                @required_complainces << Time.at(date)
            end
        when "month"
            (params["report_date_from"].to_datetime.to_i .. params["report_date_to"].to_datetime.to_i).step(1.month) do |date|
                @required_complainces << Time.at(date)
            end
        when "year"
            (params["report_date_from"].to_datetime.to_i .. params["report_date_to"].to_datetime.to_i).step(1.year) do |date|
                @required_complainces << Time.at(date)
            end
        else

        end
        
        ### Actual Complainces
        
        # task
        @tasks.each do |task|
            
            @complainces[task.id] = task.task_complainces.where(created_at: params["report_date_from"]..params["report_date_to"])
            
            @subtasks[task.id] = task.subtasks

            # subtask
            task.subtasks.each do |subtask|
                
                @subtask_complainces[subtask.id] = subtask.subtask_complainces.where(created_at: params["report_date_from"]..params["report_date_to"])
                
            end

        end

        render json: {
		        todo: @todo,
		        tasks: @tasks,
		        subtasks: @subtasks,
		        required_complainces: @required_complainces,
		        task_complainces: @complainces,
		        subtask_complainces: @subtask_complainces
		        }.to_json

    end

end


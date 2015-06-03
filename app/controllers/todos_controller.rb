class TodosController < ApplicationController
    before_action :authorize
    
    def index
        @todos = Todo.includes(tasks: :subtasks)
    end
    
    def new
        @todo = Todo.new
        @customer = Customer.new
        @type_providers = CustomerType.all
        @departments_providers = DaycareDepartment.all
    end
    
    def create
        task = params[:task]
        subtask = params[:subtask]
        
        @todo = Todo.create(todo_params)
        @todo.save
            
        @todo.update_attribute(:customer_ids, params[:customer_id])
            
        task.each do |t|
            @task = Task.create(task: t[1].to_s, todo_id: @todo.id) if !t[1].to_s.blank?
            @task.save
            
            subtask.each do |s|    
              
            if s[0] == t[0]
                
                s[1].each do |sd|
                    
                    if !sd[1].to_s.blank?
                      @subtask = Subtask.create(subtask: sd[1].to_s, task_id: @task.id)
                      @subtask.save
                    end
              
                end
                
            end
              
            end
            
        end
        
        flash[:success] = "Success: Task created."
        redirect_to "/todos"
    
    end
    
    def edit
        #@todo = Todo.find(id: params["id"]).includes(tasks: :subtasks)
    end
    
    def update
    end
    
    def destroy
        @todo = Todo.find(params["id"])
        @todo.destroy
        flash[:success] = "Todo deleted"
        redirect_to request.referrer
    end
    
    
    private

    def todo_params
      params.permit(:subject, :complete_by)
    end
    
end

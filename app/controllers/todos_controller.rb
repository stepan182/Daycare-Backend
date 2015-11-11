class TodosController < ApplicationController
  before_action :authorize

  def index

  end

  def new
    @todo = Todo.new
    @customer = Customer.new
    @type_providers = CustomerType.all
    @franchises = Franchise.all
    @partners = Partner.all
  end

  def create
    task = params[:task]
    subtask = params[:subtask]

    @todo = Todo.create(subject: params["subject"], icon: params["icon"], repeat: params["repeat"], complete_by: params["complete_by"], delegatable: params["todoDelegatable"])
    @todo.save

    @todo.update_attribute(:customer_ids, params[:customer_id])
    @todo.update_attribute(:user_type_ids, params["user_type_name"]["user_type_id"])
    @todo.update_attribute(:daycare_department_ids, params["daycare_department_name"]["daycare_department_id"])

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

    flash[:success] = "Success: Todo created."
    redirect_to "/todos"

  end

  def edit_search
    @type_providers = CustomerType.all
    @franchises = Franchise.all
    @partners = Partner.all
  end

  def edit_index
    #@todos = Todo.includes(tasks: :subtasks)
    @todos = Todo.all.joins(:customers).where(customers: {country: params["country"], customer_type_id: params["customer_type_name"]["customer_type_id"], id: params["customer_id"]}).joins(:user_types).where(user_types: {id: params["user_type_name"]["user_type_id"]}).joins(:daycare_departments).where(daycare_departments: {id: params["daycare_department_name"]["daycare_department_id"]}).distinct
  end

  def edit
    @todo = Todo.find(params["id"])
  end

  def update
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

    flash[:success] = "Success: Todo updated."
    redirect_to "/todos"

  end

  def destroy
    @todo = Todo.find(params["id"])
    @todo.destroy
    flash[:success] = "Todo deleted"
    redirect_to "/todos"
  end

  def report_search
    @type_providers = CustomerType.all
    @franchises = Franchise.all
    @partners = Partner.all
  end

  def titles_search
    @type_providers = CustomerType.all
    @franchises = Franchise.all
    @partners = Partner.all
  end

  def report_index
    @todos = Todo.all.joins(:customers).where(customers: {country: params["country"], customer_type_id: params["customer_type_name"]["customer_type_id"], id: params["customer_id"]}).joins(:user_types).where(user_types: {id: params["user_type_name"]["user_type_id"]}).joins(:daycare_departments).where(daycare_departments: {id: params["daycare_department_name"]["daycare_department_id"]}).distinct
  end

  def report_details
    @todo = Todo.find(params["report_id"])
    repeats = @todo.repeat

    @tasks = @todo.tasks
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

      # subtask
      task.subtasks.each do |subtask|

        @subtask_complainces[subtask.id] = subtask.subtask_complainces.where(created_at: params["report_date_from"]..params["report_date_to"])

      end

    end

  end


  private

  def todo_params
    params.permit(:subject)
  end

end

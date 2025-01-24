class TasksController < ApplicationController
  before_action :set_task, only: [ :destroy, :edit, :update ]
  def index
    @tasks_count = Task.count

    # Defina valores padrão vazios para as variáveis
    @pending = Task.where(status: "pending")
    @completed = Task.where(status: "completed")
    @in_progress = Task.where(status: "in-progress")

    # Aplica o filtro se params[:status] for fornecido
    if params[:status].present?
      case params[:status]
      when "pending"
        @pending = @pending
        @completed = Task.none
        @in_progress = Task.none
      when "completed"
        @completed = @completed
        @pending = Task.none
        @in_progress = Task.none
      when "in-progress"
        @in_progress = @in_progress
        @pending = Task.none
        @completed = Task.none
      end
    end
  end

  def update_status
    @task = Task.find(params[:id])
    new_status = params[:status] # Pega o novo status vindo do AJAX

    if @task.update(status: new_status)
      respond_to do |format|
        format.js # Vai procurar o arquivo update_status.js.erb
      end
    else
      render json: { error: 'There was a problem updating this task' }, status: 400
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save!
      redirect_to root_path, notice: "Task created successfully!"
    else
      flash.now[:alert] = "There was a problem creating the task."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: 'Task updated successfully.'
    else
      render :edit
    end
  end


  def destroy
    if @task.destroy
      respond_to do |format|
        format.js   # Vai procurar o arquivo destroy.js.erb
      end
    else
      render json: { error: 'There was a problem deleting this task' }, status: 400
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

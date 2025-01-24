class TasksController < ApplicationController
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


end

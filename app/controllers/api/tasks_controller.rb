class Api::TasksController < ApplicationController

  def index
    @tasks = Task.order('created_at DESC')
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Task.find(params[:id]).destroy!
  end

  def update
    # toggle!で属性(boolean)を反転して保存する
    Task.find(params[:id]).toggle!(:is_done)
  end

  private

  def task_params
    params.require(:task).permit(:name, :is_done)
  end

end

class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit]
  before_action :require_user_logged_in, only: [:index, :show, :edit, :new, :destroy]
  
  def index
    @task = current_user.tasks.build
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end
  
  def new
    @task = current_user.tasks.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に追加されました'
      redirect_to '/'
    else
      flash[:danger] = 'Task が追加されませんでした'
      render :new
    end
  end
  
  def edit
    @task = current_user.tasks.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    if logged_in?
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
    end
  end
end

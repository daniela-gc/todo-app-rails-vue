class Api::V1::TaskItemsController < Api::V1::BaseController
  before_action :set_task_item, only: [:show, :update, :destroy]

  # GET /task_items
  def index
    task_items = TaskItem.all

    render json: TaskItemSerializer.new(task_items)
  end

  # GET /task_items/:id
  def show
    render json: TaskItemSerializer.new(@task_item)
  end

  # POST /task_items
  def create
    task_item = TaskItem.new(task_item_params)

    if task_item.save
      render json: TaskItemSerializer.new(task_item), status: :created, location: [:api, :v1, task_item]
    else
      render json: ErrorSerializer.new(task_item), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /task_items/:id
  def update
    @task_item.attributes = task_item_params

    if @task_item.save
      render json: TaskItemSerializer.new(@task_item)
    else
      render json: ErrorSerializer.new(@task_item), status: :unprocessable_entity

    end
  end

  # DELETE /task_items/:id
  def destroy
    @task_item.destroy

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_item
      @task_item = TaskItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_item_params
      params
      .fetch(:task_item, {})
      .permit(
        :description,
        :scheduled_date,
        :category
      )
    end
end

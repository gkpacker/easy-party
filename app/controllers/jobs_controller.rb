class JobsController < ApplicationController
  before_action :find_job, only: [:edit, :update, :delete]

  def index
    @jobs = Job.select(params[:event_id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to event_path(job.event)
  end

  def delete
  end

  private

  def job_params
    params.require(:job).permit(:event_id, :professional_id, :price, :accepted?, :done?)
  end

  private

  def find_job
    @job = Job.find(params[:event_id])
  end
end

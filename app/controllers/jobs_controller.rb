class JobsController < ApplicationController
  before_action :find_job, only: [:edit, :update, :destroy]

  def index
    @jobs = Job.select(params[:event_id])
  end

  def new
    @job = Job.new
    @events = current_user.events
    @user = User.find(params[:user_id])
  end

  def create
    @job = Job.new(job_params)
    @job.event_id = params[:job][:event]
    @job.professional = User.find(params[:user_id])
    @job.save
    redirect_to event_path(@job.event)
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to event_path(@job.event)
    else
      render :edit
    end
  end

  def destroy
    event = @job.event
    @job.destroy
    redirect_to event_path(event)
  end

  private

  def job_params
    params.require(:job).permit(:event_id, :price, :accepted?, :done?)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end

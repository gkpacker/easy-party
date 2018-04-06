class JobsController < ApplicationController
  before_action :find_job, only: [:edit, :update, :destroy, :accept, :decline, :done]
  before_action :set_events, only: [:new, :edit]
  def index
    @jobs = Job.select(params[:event_id])
  end

  def new
    @job = Job.new
    authorize @job
    @events = current_user.events
    @professional = User.find(params[:user_id])
    @user = current_user
  end

  def create
    @job = Job.new(job_params)
    @job.professional = User.find(params[:user_id])
    authorize @job
    if @job.save
      redirect_to event_path(@job.event)
    else
      render :new
    end
  end

  def edit
    @user = current_user
    authorize @job
  end

  def update
    authorize @job
    if @job.update(job_params)
      redirect_to event_path(@job.event)
    else
      render :edit
    end
  end

  def destroy
    event = @job.event
    authorize @job
    @job.destroy
  end

  def accept
    authorize @job
    @job.accepted = true
    @job.save!
  end

  def decline
    authorize @job
    @job.accepted = false
    @job.save!
  end

  def done
    authorize @job
    @job.done = true
    @job.save!
    event = @job.event
    redirect_to event_path(event)
  end

  private

  def job_params
    params.require(:job).permit(:event_id, :price, :accepted?, :done?, :rating, :comment)
  end

  def find_job
    @job = Job.find(params[:id])
  end

  def set_events
    @events = policy_scope(Event)
  end
end

class JobsController < ApplicationController
  def index
    @jobs = Job.select(params[:event_id])
  end

  private

  def job_params
    params.require(:job).permit(:event_id)
  end
end

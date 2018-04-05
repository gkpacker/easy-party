class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    authorize @event
    @pictures = @event.pictures.all
  end

  def new
    @event = Event.new
    authorize @event
    @pictures = @event.pictures.build
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user
    authorize @event
    if @event.save
      if params[:pictures].present?
        params[:pictures]['picture'].each do |a|
          @pictures = @event.pictures.create!(:picture => a)
        end
      end
      redirect_to event_path(@event)
    else
      render :new
    end
  end


  def edit
    @event = current_user.events.find(params[:id])
    authorize @event
  end

  def update
    @event = Event.new
    @event.organizer = current_user
    authorize @event
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event
    @event.destroy
    redirect_to organizers_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :location, :description, :organizer_id, :pictures['picture'])
  end



end

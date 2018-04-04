class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    @pictures = @event.pictures.all
  end

  def new
    @event = Event.new
    @pictures = @event.pictures.build
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user
    if @event.save
      params[:pictures]['picture'].each do |a|
        @pictures = @event.pictures.create!(:picture => a)
      end
      redirect_to event_path(@event)
    else
      render :new
    end
  end


  def edit
    if current_user.events.find(params[:id])
      @event = current_user.events.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update

  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :location, :description, :organizer_id, :pictures['picture'])
  end

end

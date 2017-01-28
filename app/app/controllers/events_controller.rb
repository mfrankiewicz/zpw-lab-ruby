class EventsController < ApplicationController
  def index
      @events = Event.all
  end

  def new
      @event = Event.new
  end

  def create
      @event = Event.new(event_params)
      if @event.save
          flash[:message] = 'Event został poprawnie stworzony.'
          redirect_to events_path
      else
          render :action => "new"
      end
  end

    def event_params
        params.require(:event).permit(:artist, :description, :price_low, :price_high, :seat_count, :event_date, :adult)
    end
end

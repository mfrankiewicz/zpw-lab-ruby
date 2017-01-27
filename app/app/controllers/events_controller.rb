class EventsController < ApplicationController
  def index
      @events = Event.all
  end

  def new
      @event = Event.new
  end

  def create
      @event = Event.new(params[:event])
      if @event.save
          flash[:message] = 'Event został poprawnie stworzony.'
          redirect_to events_path
      else
          render :action => "new"
      end
  end
end

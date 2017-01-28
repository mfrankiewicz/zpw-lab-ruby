class EventsController < ApplicationController
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]
    def index
        @admin = true;
        if @admin
            @events = Event.all
        else
            @events = Event.where("event_date < ?", Date.today)
        end
    end

    def new
        @event = Event.new
    end

    def edit
    end

    def show
    end

    def create
        @event = Event.new(event_params)
        if @event.save
            flash[:message] = 'Event has been successfully added.'
            redirect_to events_path
        else
            render :action => "new"
        end
    end

    def update
        respond_to do |format|
            if @event.update(event_params)
                format.html { redirect_to @event, notice: 'Event was successfully updated.' }
                format.json { render :show, status: :ok, location: @event }
            else
                format.html { render :edit }
                format.json { render json: @event.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @event.destroy
        respond_to do |format|
            format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    def set_ticket
        @event = Event.find(params[:id])
    end
    def event_params
        params.require(:event).permit(:artist, :description, :price_low, :price_high, :seat_count, :event_date, :adult)
    end
end

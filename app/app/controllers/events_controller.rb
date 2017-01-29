class EventsController < ApplicationController
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]
    before_action :check_admin
    before_action :verify_access, only: [:new, :create, :edit, :update, :destroy]
    def index

        if @authorized
            @eventsRes = Event.all
        else
            @eventsRes = Event.where("event_date > ?", Date.today)
        end

        @events = []
        if request.query_parameters != nil && request.query_parameters[:filters] != nil
            @date_from = request.query_parameters[:filters][:date_from]
            @date_to = request.query_parameters[:filters][:date_to]
        end

        @eventsRes.each do |event|

            if @date_from != nil && @date_to != nil
                if @date_from.to_date != nil && @date_to.to_date != nil
                    if event.event_date >= @date_from.to_date && event.event_date <= @date_to.to_date
                        @events << event
                    end
                end
            else
                @events << event
            end

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

    def check_admin
        @authorized = session[:authorized]
    end

    def verify_access
        if !@authorized
            redirect_to root_path
        end
    end
end

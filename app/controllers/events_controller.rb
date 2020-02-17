class EventsController < ApplicationController
  def index
    @events = Event.all.order(:id)
  end

  def new
    @event = Event.new
    @venues = Venue.all.order(:name)
    @cities = City.all.order(:name)
    @categories = Category.all.order(:name)
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = session[:user_id]
    if @event.save
      redirect_to events_path
      flash[:success] = 'Event created successfully'
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to events_path
      flash[:success] = "Event updated successfully"
    else
      render :edit
    end
  end

  def show
    session[:event_id] = params[:id]
    @event = Event.find(params[:id])
    @event_booking = EventBooking.new
    @event_bookings = @event.event_bookings
    if params[:booking_id]
      @booking_confirmed = EventBooking.find(params[:booking_id])
    end
  end

  def booking_list
    @event_bookings = EventBooking.all
    @event = Event.find(params[:id])
    puts "------#{@event_bookings.inspect}"
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to events_path
    flash[:success] = "Event deleted successfully!"
  end

  private
  def event_params
    params[:event].permit(:name, :description, :venue_id, :city_id, :start_datetime, :end_datetime, :entry_fee, :category_id, :avatar, :status, :ticket_left)
  end
end

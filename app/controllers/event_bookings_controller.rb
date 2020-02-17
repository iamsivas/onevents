class EventBookingsController < ApplicationController
  include EventBookingsHelper
  skip_before_action :verify_authenticity_token

  def index
  	@event_bookings = EventBooking.all
  end

  def new
  	@event_booking = EventBooking.new
  end

  def create
  	@event_booking = EventBooking.new(event_booking_params)
  	@event_booking.user_id = session[:user_id]
  	@event_booking.event_id = params[:event_id]
  	respond_to do |format|
      if @event_booking.save
        format.html { redirect_to event_path(@event_booking.event_id, booking_id: @event_booking.id), notice: 'Event booking was successfully created.' }
        format.json { render :show, status: :created, location: @event_booking }
      else
        format.html { render :new }
        format.json { render json: @event_booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @event_booking.update(event_booking_params)
        format.html { redirect_to @event_booking, success: 'Event booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_booking }
      else
        format.html { render :edit }
        format.json { render json: @event_booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def book_ticket
    @user = User.find(session[:user_id])
    @event = Event.find(session[:event_id])
    original_price = @event.entry_fee.to_i * params[:tktcount].to_i
    if @user.gender == 'Female'
      discounted_price = original_price - (original_price * 5 / 100)
    else
      discounted_price = original_price
    end
    @bookticket = helpers.book_ticket(session[:event_id], session[:user_id], discounted_price, params[:tktcount])
    @minus_ticket = (@event.ticket_left.to_i - params[:tktcount].to_i)
    @event.ticket_left = @minus_ticket.to_i
    if @event.save
      respond_to do |format|
        format.html { }
        format.json { render json: discounted_price }
      end
    end
  end

  def booked_user_list
    @users = EventBooking.where("user_id != ?", session[:user_id])
  end

  def destroy
  	@event_booking.destroy
    respond_to do |format|
      format.html { redirect_to event_bookings_url, success: 'Event booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_event_booking
  	@event_booking = EventBooking.find(params[:id])
  end

  def event_booking_params
  	params.require(:event_booking).permit(:event_id, :user_id, :total_ticket, :total_price)
  end
end

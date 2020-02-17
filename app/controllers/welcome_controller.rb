class WelcomeController < ApplicationController
  def index
  	@events = Event.all.order(:start_datetime)
  end
end

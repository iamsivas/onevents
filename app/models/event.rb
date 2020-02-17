class Event < ApplicationRecord
  has_one_attached :avatar

  has_many :event_bookings

  belongs_to :city
  belongs_to :venue
  belongs_to :user

  validate :check_date, on: :create

  private
  def check_date
    if self.start_datetime >= self.end_datetime
			errors.add(:start_datetime," is invalid!")
		end
  end
end

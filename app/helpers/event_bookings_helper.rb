module EventBookingsHelper
  def book_ticket(user, event, ticket, price)
    @ticket_book = EventBooking.new()
    @ticket_book.user_id = user
    @ticket_book.event_id = event
    @ticket_book.total_price = ticket
    @ticket_book.total_ticket = price
    @ticket_book.save
  end
end

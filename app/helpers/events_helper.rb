module EventsHelper

  def get_seats_list_for_event(event)
    taken_seats_list = event.tickets.map {|ticket| ticket.seat_id.to_i}
    all_seats = [*1..event.total_seats]

    all_seats - taken_seats_list
  end

  def has_available_seats
    (@event.total_seats - @event.tickets.length) > 0
  end

  def get_available_seats(event)
    event.total_seats - event.tickets.length
  end
end

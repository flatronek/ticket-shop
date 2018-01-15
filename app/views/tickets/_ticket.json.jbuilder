json.extract! ticket, :id, :name, :seat_id, :address, :price, :email, :phone, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)

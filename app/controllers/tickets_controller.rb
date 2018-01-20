class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:return]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :return]

  # GET /tickets
  # GET /tickets.json
  def index
    if is_admin
      @tickets = Ticket.order("pending_return DESC")
    else
      @tickets = Ticket.where(user: current_user)
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  def return
    @ticket.update(pending_return: true, omit_validation: true)
    redirect_to tickets_path, notice: "Your ticket return is now pending for administrator's acceptance."

  end

  # GET /tickets/new
  def new
    event = Event.find(params[:event_id])

    @ticket = event.tickets.new
    @ticket.price = calculate_ticket_price
    if event.total_seats - event.tickets.length == 0
      redirect_to event, alert: 'There are no available seats left.'
    elsif @ticket.price > current_user.account_balance
      redirect_to event, alert: "You don't have enough funds on your account."
    else
      puts("Calculated ticket price: #{@ticket.price}")
    end
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = current_user.tickets.new(ticket_params)
    @ticket.price = calculate_ticket_price

    respond_to do |format|
      if @ticket.save
        current_user.update(account_balance: current_user.account_balance - @ticket.price)

        format.html {redirect_to @ticket, notice: 'Ticket was successfully created.'}
        format.json {render :show, status: :created, location: @ticket}
      else
        format.html {render :new}
        format.json {render json: @ticket.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html {redirect_to @ticket, notice: 'Ticket was successfully updated.'}
        format.json {render :show, status: :ok, location: @ticket}
      else
        format.html {render :edit}
        format.json {render json: @ticket.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    @ticket.user.update(account_balance: @ticket.user.account_balance + @ticket.price)

    respond_to do |format|
      format.html {redirect_to tickets_path, notice: 'Ticket was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    params.require(:ticket).permit(:name, :seat_id, :address, :price, :email, :phone, :event_id)
  end

  def correct_user
    @ticket = current_user.tickets.find_by(id: params[:id])
    redirect_to tickets_path, alert: 'You are not allowed to modify this ticket.' if @ticket.nil?
  end

  def calculate_ticket_price
    event = @ticket.event
    days_diff = (event.event_date - Date.today).to_i

    puts("Days diff: #{days_diff}")
    if days_diff == 0
      result = event.price_high * 1.2
    else
      result = event.price_high - days_diff / 30.0 * (event.price_high - event.price_low)
    end
    result.round(2)
  end
end

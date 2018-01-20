class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :is_admin, :except => [:index, :show]
  before_action :set_event, :only => [:edit, :update, :show]

  def index
    if is_admin
      @events = Event.all
    else
      @events = Event.where(event_date: Date.today..(Date.today + 30.days))
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to "/events/#{@event.id}", notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def edit
  end

  def show
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:artist, :description, :price_low, :price_high, :event_date, :total_seats, :adults_only)
  end
end

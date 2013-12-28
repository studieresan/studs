class EventsController < ApplicationController
  respond_to :html
  before_filter :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
    respond_with(@events)
  end

  def show
    respond_with(@event)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(params[:event])
    user_ids = params[:user][:user_id] - [""]
    users = User.find(user_ids)
    @event.users << users
    @event.save
    respond_with(@event)
  end

  def update
    @event.update_attributes(params[:event])
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end
end

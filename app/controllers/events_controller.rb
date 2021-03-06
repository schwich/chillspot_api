class EventsController < ApplicationController
  respond_to :json

  def index
    if not params[:latitude].nil? and not params[:longitude].nil?
      coords = []
      coords.push(params[:latitude])
      coords.push(params[:longitude])
      @nearby_events = Event.near(coords, 10)

      #render json: @nearby_events
    else
      @events = Event.all
      render json: @events
    end
  end

  def show
    if not params[:latitude].nil? and not params[:longitude].nil?
      coords = []
      coords.push(params[:latitude])
      coords.push(params[:longitude])
      @event = Event.find(params[:id])
      if @event.geocoded?
        @event_distance = @event.distance_from(coords)
      end
    else
      @event = Event.find(params[:id])
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      # Also add user to event?

      render json: { status: 201, event_id: @event.id }
    else
      render json: { errors: @event.errors }, status: 422
    end
  end

  def update
    @event = Event.find(params[:id])
    if not params[:latitude].nil? and not params[:longitude].nil?
      if @event.update_attributes(:latitude => params[:latitude], :longitude => params[:longitude])
        render json: { status: 200 }
      else
        render json: { errors: @event.errors }, status: 422
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    render json: { status: 204 , id: params[:id]}
  end

  def get_users
    @event = Event.find(params[:id])
    @users = @event.users
    render json: @users
  end

  def add_user
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.create_relationship(user_id: @user.id, event_id: @event.id)
    render json: { status: 201 }
  end

  def remove_user
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.relationship.destroy
    render json: { status: 204 }
  end

  def create_event_and_add_user
    @event = Event.new(event_params)

    @user = User.find(params[:user_id])

    if @event.save
      # Also add user to event
      @user.create_relationship(user_id: @user.id, event_id: @event.id)

      render json: { status: 205, event_id: @event.id }
    else
      render json: { errors: @event.errors }, status: 422
    end
  end

  private
    def event_params
      params.require(:event).permit(:latitude, :longitude, :address, :category, :sub_category, :note)
    end
end

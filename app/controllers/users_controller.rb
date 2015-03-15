class UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { status: 201 }
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])

    if not params[:latitude].nil? and not params[:longitude].nil?
      if @user.update_attributes(:latitude => params[:latitude], :longitude => params[:longitude])
        render json: { status: 200 }
      else 
        render json: { errors: @user.errors }, status: 422
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { status: 204 }
  end

  def get_event
    @user = User.find(params[:id])
    @event = @user.event
    render json: @event
  end

  private
    def user_params
      params.require(:user).permit(:username, :email)
    end
  
end

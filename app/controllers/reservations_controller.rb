class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @reservations = Reservation.all
  end

  def new
    @user = User.find(params[:user_id])
    @car = Car.find(params[:car_id])
    @reservation = Reservation.new
  end

  def show
    @reservation = Reservation.find_by(id: params[:id])
  end

  def confirm
    @user = current_user
    @car = Car.find(params[:car_id])
    @day = params[:day]
    @time = params[:time]
    @reservation = Reservation.new(reservation_params)
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to @reservation, flash: { alert: message }
    end
  end

  def create
    @user = current_user
    @car = Car.find(params[:reservation][:car_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約に成功しました"
      redirect_to reservation_path (@reservation)
    else
      flash.now[:alert] = "予約に失敗しました"
      render "reservations/new"
    end
  end

  def edit
    @cars = Car.all
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @user = current_user
    @car = Car.find(params[:reservation][:car_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:success] = "予約を削除しました。"
      redirect_to user_path(current_user.id)
    else
      render :show
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:day, :time, :car_id, :user_id, :start_time)
  end
end

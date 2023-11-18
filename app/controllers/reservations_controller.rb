class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end

  def new
    @user = current_user
    @car = Car.find(params[:reservation][:car_id])
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to @reservation, flash: { alert: message }
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @user = current_user
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
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @user = current_user
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

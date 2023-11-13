class CarsController < ApplicationController
  def index
    @date1 = Date.current.strftime('%Y/%m/%d')
    @user = current_user
    @cars = current_user.cars
  end

  def new
    @user = current_user
    @car = Car.new
  end
 
  def create
    @user = current_user
    @car = Car.new(car_params)
    @car.user_id = current_user.id
    if @car.save
      flash[:notice] = "車両を登録しました"
      redirect_to cars_path
    else
      flash[:notice] = "車両を登録できませんでした"
      render "new"
    end
  end

  def show
    @user = current_user
    @car = Car.find(params[:id])
  end

  def edit
    @car = Car.find(params[:id])
  end
 
  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      flash[:notice] = "車両を更新しました"
      redirect_to cars_path
    else
      render :edit
    end
  end
 
  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    flash[:notice] = "車両を削除しました"
    redirect_to cars_path
  end

  def car_params
    params.require(:car).permit(
      :car_name,
      :introduction
    )
  end
end

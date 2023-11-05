class UsersController < ApplicationController

  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password))
    if @user.save
      redirect_to users_show_path
    else
      render "new"
    end
  end
 
  def show
    @user = current_user
    @user = User.find(current_user.id)
    @user_reservations = current_user.reservations.where("day >= ?", Date.current).order(day: :desc)
    @visit_historys = current_user.reservations.where("day < ?", Date.current).where("day > ?", Date.today << 12).order(day: :desc)
  end
 
  def edit
    @user = User.find(current_user.id)
  end
 
  def update
    @user = User.find(current_user.id)
    if current_user.update(params.require(:user).permit(:company, :name))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to users_show_path
    else
      flash[:notice] = "ユーザー情報を登録できませんでした"
      render "edit"
    end
  end
 
  def destroy
  end
end

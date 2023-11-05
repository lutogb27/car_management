class HomesController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @user = current_user
  end

   def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.company = "guset"
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in user
    redirect_to cars_index_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end

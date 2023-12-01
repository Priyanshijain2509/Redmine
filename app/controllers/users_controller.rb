class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'Account was successfully updated.'
      redirect_to request.referrer || root_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
    :language, :nick_name)
  end
end

class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
    current_user_id = current_user.id.to_s
    all_issues = Issue.all
    @user_assigned_issues = []
    all_issues.each do |issue|
      user_assigned = issue.assignee.include?(current_user_id)
      @user_assigned_issues << user_assigned
    end
    @assigned_issues_count = @user_assigned_issues.count(true)
    @reported_issues_count = Issue.where(user_id: @user.id).count
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

class HomeController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    date = Date.today
    default_month_range = date.beginning_of_month.day..date.end_of_month.day
    # @team = Team.all
    @users = User.all
  end

end

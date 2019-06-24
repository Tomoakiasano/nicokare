class HomeController < ApplicationController
  require 'date'
  before_action :sign_in_required, only: [:show]
  def index
    @Date = Date.today
    @month_range = @Date.beginning_of_month.day..@Date.end_of_month.day
    @team = Team.all
    @users = User.all
  end

end

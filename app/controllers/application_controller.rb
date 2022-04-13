class ApplicationController < ActionController::Base
  before_action :days_running

  def days_running
    @days_running = Date.today.mjd - Date.new(2022,4,5).mjd
  end
end

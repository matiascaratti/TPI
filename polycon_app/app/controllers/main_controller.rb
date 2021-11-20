class MainController < ApplicationController
  before_action :authenticate_user!
  def home
    @professionals = Professional.all
  end
end

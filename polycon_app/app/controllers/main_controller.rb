class MainController < ApplicationController
  def home
    @professionals = Professional.all
    @users = User.all
  end
end

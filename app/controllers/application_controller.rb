# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery
  http_basic_authenticate_with name: username, password: password, :if => :admin_controller?


  def username
    'xaler'
  end

  def password
    'n[Q3}UK2>dM4Y7'
  end

  def admin_controller?
    self.class < ActiveAdmin::BaseController
  end
end

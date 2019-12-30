#todo
# user_name and password validation
# enable csrf
# hash the password while inserting in DB
# user_name already exists
#
class UserController < ApplicationController

  def sign_in
    begin
      user = User.select([:password, :id]).where(name: params[:name]).first
      return head status: :unauthorized unless user.password == params[:password]
      session[:current_user_id] = user.id
    rescue ActiveRecord::RecordNotFound
      return head status: :unauthorized
    end

    head status: :ok
  end

  def sign_up
    new_user = User.new(name: params[:name], password: params[:password] )
    if new_user.save
      head status: :created
    else
      head status: 400
    end
  end

  def sign_out
    clear_session
    head status: :ok
  end

  def login_page
  end

end
class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.where("provider = ?",auth["provider"]).where("uid = ?",auth["uid"]).first


    if user
      session[:user_id] = user.id
    else
      User.create_with_omniauth(auth)
    end
      redirect_to root_path, notice: "Signed In!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed Out!"
  end
end

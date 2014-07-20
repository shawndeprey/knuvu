class Api::V1::BaseController < ApplicationController
  respond_to :json
  before_action :load_session_user
  before_action :require_session
  before_action :require_verification

  def load_session_user
    @session_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def require_session
    return render json: { :errors => ['You must login to do that.'] }, :status => :unauthorized unless @session_user
  end

  def require_verification
    return render json: { :errors => ['You must be verified to do that.'] }, :status => :unauthorized unless @session_user.verified?
  end

  def require_admin_session
    return render json: { }, :status => :not_found unless @session_user.admin?
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end
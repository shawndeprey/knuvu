class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :require_session, only: [:create]
  skip_before_action :require_verification, only: [:create]

  # GET /api/v1/session.json
  def show
    # MetricsHelper::track MetricsHelper::USER_GET_SESSION, {authenticated: true, verified: @user.verified, api: 'v2'}, @user, [@user]
    render json: @session_user
  end

  # POST /api/v1/session.json
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.password == ApplicationHelper.md5(params[:password])
      if @user.verified?
        # MetricsHelper::track(MetricsHelper::LOGIN, {}, @user)
        login @user
        render json: @user
      else
        render json: {errors: ["Account not verified. Check your email or contact KnuVu."]}, status: :unprocessable_entity
      end
    else
      render json: {errors: ["Email and/or password incorrect."]}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/session.json
  def destroy
    # MetricsHelper::track(MetricsHelper::LOGOUT, {}, @session_user)
    logout
    head :no_content
  end

end
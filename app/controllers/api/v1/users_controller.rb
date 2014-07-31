class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :require_session, only: [:create, :password_reset_request, :reset_password]
  skip_before_action :require_verification, only: [:create, :password_reset_request, :reset_password]
  before_action :require_admin_session, only: [:show, :destroy]
  before_action :set_user, except: [:create, :password_reset_request, :reset_password]

  # GET /api/v1/users/1.json
  def show
    # MetricsHelper::track MetricsHelper::USER_SHOW, {email: @user.email})
    # Verify user and send back limited model if not session user
    render json: @user, root: :user
  end

  # POST /api/v1/users.json
  def create
    @user = User.new(user_params)
    @user.verified = true # With our whitelist we don't need to worry about verification
    if @user.save
      # MetricsHelper::track(MetricsHelper::USER_CREATE, {email: @user.email})
      @user.generate_reset_hash!
      render json: @user, root: :user, status: :created
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/users/1.json
  def update
    if @user.update_attributes(user_params)
      # MetricsHelper::track(MetricsHelper::USER_UPDATE, {email: @user.email})
      render json: @user, root: :user, status: :accepted
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1.json
  def destroy
    # MetricsHelper::track MetricsHelper::USER_DESTROY, {email: @user.email}
    # Verify user
    @user.destroy
    head :no_content
  end

  # POST /api/v1/users/password_reset_request.json?email=shawndeprey@gmail.com
  def password_reset_request
    @user = User.find_by_email(params[:email])
    # MetricsHelper::track(MetricsHelper::USER_UPDATE, {email: @user.email})
    if @user
      @user.generate_reset_hash!
      # MetricsHelper::track(MetricsHelper::USER_UPDATE, {email: @user.email})
      UserMailer.delay.password_reset(@user)
      render json: {}, status: :created
    else
      render json: {errors: ["Unable to find user with email #{params[:email]}."]}, status: :unprocessable_entity
    end
  end

  # POST /api/v1/users/reset_password.json?reset_hash=njn2n2n2duv2n2odnvoiidnsdlknvsm&password=newPassword
  def reset_password
    @user = User.find_by_reset_hash(params[:reset_hash])
    # MetricsHelper::track(MetricsHelper::USER_UPDATE, {email: @user.email})
    if @user
      @user.password = params[:password]
      # MetricsHelper::track(MetricsHelper::USER_UPDATE, {email: @user.email})
      if @user.save
        # MetricsHelper::track(MetricsHelper::USER_UPDATE, {email: @user.email})
        render json: @user, root: :user, status: :accepted
      else
        render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {errors: ["Wrong confirmation code, please check your email and try again."]}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:full_name, :email, :phone, :password, :avatar)
    end
end
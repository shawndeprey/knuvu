class Api::V1::UsersController < Api::V1::BaseController
  #skip_before_filter :require_session
  #skip_before_filter :require_verification
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /company_lists/1.json
  def show
    # MetricsHelper::track MetricsHelper::USER_SHOW, {email: @user.email})
    # Verify user and send back limited model if not session user
    render json: @user, root: :user
  end

  # POST /api/v1/users.json
  def create
    @user = User.new(user_params)
    if @user.save
      # MetricsHelper::track(MetricsHelper::USER_CREATE, {email: @user.email})
      render json: @user, root: :user, status: :created
    else
      render json: {'errors' => @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/users/1.json
  def update
    if @user.update_attributes(user_params)
      # MetricsHelper::track(MetricsHelper::USER_UPDATE, {email: @user.email})
      render json: @user, root: :user, status: :accepted
    else
      render json: {'errors' => @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1.json
  def destroy
    # MetricsHelper::track MetricsHelper::USER_DESTROY, {email: @user.email}
    # Verify user
    @user.destroy
    head :no_content
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
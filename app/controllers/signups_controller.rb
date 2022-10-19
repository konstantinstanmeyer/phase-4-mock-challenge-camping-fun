class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :update, :destroy]

  # GET /signups
  def index
    @signups = Signup.all

    render json: @signups
  end

  # GET /signups/1
  def show
    render json: @signup
  end

  # POST /signups

  def create
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created
  end

  # PATCH/PUT /signups/1
  def update
    if @signup.update!(signup_params)
      render json: @signup
    else
      render json: @signup.errors, status: :unprocessable_entity
    end
  end

  # DELETE /signups/1
  def destroy
    @signup.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      signup = Signup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def signup_params
      params.permit(:camper_id, :activity_id, :time)
    end

    def render_not_found_response
      render json: { error: "Activity not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
      render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end

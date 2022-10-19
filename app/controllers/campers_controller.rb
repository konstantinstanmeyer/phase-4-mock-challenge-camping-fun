class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  before_action :set_camper, only: [:show, :update, :destroy]

  # GET /campers
  def index
    @campers = Camper.all

    render json: @campers
  end

  # GET /campers/1
  def show
    render json: @camper, serializer: CampersActivitiesSerializer
  end

  # POST /campers
  def create
    @camper = Camper.new(camper_params)

    if @camper.save
      render json: @camper, status: :created, location: @camper
    else
      render json: @camper.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campers/1
  def destroy
    @camper.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camper
      @camper = Camper.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camper_params
      params.permit(:name, :age)
    end

    def render_not_found_response
      render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
      render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end

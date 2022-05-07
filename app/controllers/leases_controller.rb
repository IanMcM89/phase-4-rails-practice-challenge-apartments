class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    lease = find_lease
    lease.destroy
    head :no_content
  end

  private

  def find_lease
    Lease.find(params[:id])
  end

  def lease_params
    params.permit(:rent, :tenant_id, :apartment_id)
  end

  def render_not_found_response
    render json: { error: "Lease not found" }, status: :not_found
  end
end
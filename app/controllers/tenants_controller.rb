class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def index
    tenants = Tenant.all
    render json: tenants
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def show
    tenant = find_tenant
    render json: tenant
  end

  def update
    tenant = find_tenant
    tenant.update(tenant_params)
    render json: tenant
  end

  def destroy
    tenant = find_tenant
    tenant.destroy
    head :no_content
  end

  private

  def find_tenant
    Tenant.find(params[:id])
  end

  def tenant_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Tenant not found" }, status: :not_found
  end
end

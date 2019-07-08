class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
    @organization  = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to organizations_path
    else
      render :index
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :hourly_rate)
  end
end

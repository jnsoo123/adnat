class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to organizations_path
    else
      render :edit
    end
  end

  def destroy
    if @organization.destroy
      redirect_to organizations_path
    else
      render :edit
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :hourly_rate)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end

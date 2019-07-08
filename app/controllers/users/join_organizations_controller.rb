module Users
  class JoinOrganizationsController < ApplicationController
    def update
      if current_user.update organization: organization
        redirect_to root_path
      end
    end

    private

    def organization
      Organization.find(params[:organization_id])
    end
  end
end

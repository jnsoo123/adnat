module Users
  class LeaveOrganizationsController < ApplicationController
    def update
      if current_user.update organization: nil
        redirect_to organizations_path
      end
    end
  end
end

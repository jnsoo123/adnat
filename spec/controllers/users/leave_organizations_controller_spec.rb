require 'rails_helper'

RSpec.describe Users::LeaveOrganizationsController, type: :controller do
  let(:organization) { create :organization }
  let(:user) { create :user, organization: organization }

  before { sign_in user }

  context 'PATCH update' do
    subject { patch :update }

    it 'updates users organization' do
      subject
      user.reload
      expect(user.organization).to eq nil
    end

    it 'returns 302' do
      subject
      expect(response).to have_http_status 302
    end
  end
end

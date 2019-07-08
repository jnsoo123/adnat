require 'rails_helper'

RSpec.describe Users::JoinOrganizationsController, type: :controller do
  let(:user) { create :user }
  let(:organization) { create :organization }

  before { sign_in user }

  context 'PATCH update' do
    subject { patch :update, params: { organization_id: organization.id } }

    it 'updates users organization' do
      subject
      user.reload
      expect(user.organization).to eq organization
    end

    it 'returns 302' do
      subject
      expect(response).to have_http_status 302
    end
  end
end

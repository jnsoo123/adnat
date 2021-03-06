require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  context 'GET index' do
    before do
      create_list :organization, 3
    end

    it 'fetches all organizations' do
      get :index
      expect(assigns[:organizations]).to eq Organization.all
    end
  end

  context 'POST create' do
    context 'having invalid params' do
      subject do
        post :create, params: { 
          organization: {
            name: nil,
            hourly_rate: 12
          } 
        }
      end

      it 'doesnt create an organization' do
        expect { subject }.to change { Organization.count }.by(0)
      end

      it 'returns 200' do
        subject
        expect(response).to have_http_status 200
      end
    end

    context 'having valid params' do
      subject do
        post :create, params: { 
          organization: {
            name: 'Test',
            hourly_rate: 12
          } 
        }
      end

      it 'creates an organization' do
        expect { subject }.to change { Organization.count }.by(1)
      end

      it 'returns 302' do
        subject
        expect(response).to have_http_status 302
      end
    end
  end

  context 'GET edit' do
    let(:organization) { create :organization }

    subject { get :edit, params: { id: organization.id } }

    it 'fetches for correct organization to be edited' do
      subject
      expect(assigns[:organization]).to eq organization
    end

    it 'returns 200' do
      subject
      expect(response).to have_http_status 200
    end
  end

  context 'PATCH update' do
    let(:organization) { create :organization }

    subject do
      patch :update, params: { 
        id: organization.id,  
        organization: {
          name: 'updated name',
        }
      } 
    end

    it 'updates organization' do
      subject
      organization.reload
      expect(organization.name).to eq 'updated name'
    end
  end

  context 'DELETE destroy' do
    let!(:organization) { create :organization }

    subject { delete :destroy, params: { id: organization.id } }

    it 'deletes the organization' do
      expect { subject }.to change { Organization.count }.from(1).to(0)
    end

    it 'returns 302' do
      subject
      expect(response).to have_http_status 302
    end
  end
end

require 'rails_helper'

RSpec.describe Users::UpdateAccountsController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  context 'GET edit' do
    subject { get :edit }

    it 'initializes UserForm with logged in user' do
      subject
      expect(assigns[:user]).to be_a UserForm
      expect(assigns[:user].user).to eq user
    end

    it 'returns 200' do
      subject
      expect(response).to have_http_status 200
    end
  end

  context 'PATCH update' do
    subject do
      patch :update, params: {
        user: {
          name: 'Some Name'
        }
      }
    end

    context 'with correct params' do
      it 'updates user' do
        expect { subject }.to change { user.reload.name }.to('Some Name')
      end

      it 'returns 302' do
        subject
        expect(response).to have_http_status 302
      end
    end

    context 'with incorrect params' do
      before do 
        allow_any_instance_of(UserForm).to receive(:update).and_return(false)
      end

      it 'doesnt update user' do
        expect { subject }.to_not change { user.reload.name }
      end

      it 'returns 200' do
        subject
        expect(response).to have_http_status 200
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  let(:organization) { create :organization }
  let(:user) { create :user, organization: organization }

  before { sign_in user }

  context 'GET index' do
    before do
      test_user = create :user, organization: organization
      create :shift, user: test_user
      create :shift, user: test_user
      create :shift, user: test_user

      other_org = create :organization
      test_user = create :user, organization: other_org
      create :shift, user: test_user
      create :shift, user: test_user
      create :shift, user: test_user
    end

    subject { get :index }

    it 'fetches for all shifts under users org' do
      subject
      expect(assigns[:shifts].count).to eq 3
    end

    it 'initializes ShiftForm object' do
      subject
      expect(assigns[:shift]).to be_a ShiftForm
    end

    it 'returns 200' do
      subject
      expect(response).to have_http_status 200
    end
  end

  context 'POST create' do
    subject do
      post :create, params: {
        shift: {
          shift_date:   Date.today.to_s,
          start:        '08:00 AM',
          finish:       '05:00 PM',
          break_length: 60
        }
      }
    end

    it 'creates shift with form object' do
      subject
      expect(assigns[:shift]).to be_a ShiftForm
    end

    it 'creates shift' do
      expect { subject }.to change { Shift.count }.by(1)
    end

    it 'returns 302' do
      subject
      expect(response).to have_http_status 302
    end
  end
end

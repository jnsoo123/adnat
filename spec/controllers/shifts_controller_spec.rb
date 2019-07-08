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

  context 'GET edit' do
    let(:shift) { create :shift }

    subject { get :edit, params: { id: shift.id } }

    it 'sets ShiftForm' do
      subject
      expect(assigns[:shift]).to be_a ShiftForm
      expect(assigns[:shift].shift).to eq shift
    end

    it 'returns 200' do
      subject
      expect(response).to have_http_status 200
    end
  end

  context 'PATCH update' do
    let(:shift) { create :shift }

    subject do
      patch :update, params: {
        id: shift.id,
        shift: {
          shift_date: '2018-01-01',
          start: '08:00 AM',
          finish: '05:00 PM',
          break_length: '100'
        }
      }
    end

    it 'updates start and finish date time' do
      subject
      shift.reload
      expect(shift.start.to_date.to_s).to eq '2018-01-01'
      expect(shift.finish.to_date.to_s).to eq '2018-01-01'
    end
  end
end

require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:shift) { build :shift }

  it 'has a valid factory' do
    expect(shift).to be_valid
  end

  context 'Instance Methods' do
    context '#shift_length' do
      it 'returns length of a shift' do
        shift.start  = '08:00 AM'
        shift.finish = '05:00 PM'

        expect(shift.shift_length).to eq 32400.0
      end
    end

    context '#hours_worked' do
      it 'returns total hours worked within shift minus break length' do
        shift.start  = '08:00 AM'
        shift.finish = '05:00 PM'

        expect(shift.hours_worked).to eq 8.0
      end
    end

    context '#shift_cost' do
      let(:organization) { create :organization, hourly_rate: 10 }
      let(:user)         { create :user, organization: organization }

      it 'returns computation of shift cost depending on org rate' do
        shift.user   = user
        shift.start  = '08:00 AM'
        shift.finish = '05:00 PM'

        expect(shift.shift_cost).to eq 80.0
      end
    end
  end
end

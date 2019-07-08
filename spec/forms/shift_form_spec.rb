require 'rails_helper'

RSpec.describe ShiftForm, type: :model do
  let(:organization) { create :organization }
  let(:user)         { create :user, organization: organization }
  let(:form)         { described_class.new(valid_attrs) }
  let(:valid_attrs)  {{
    shift_date:   Date.today.to_s,
    start:        '08:00 AM',
    finish:       '05:00 PM',
    break_length: 0,
    user_id:      user.id
  }}

  context 'Validation' do
    it 'is valid when all attributes are present' do
      expect(form).to be_valid
    end

    it 'doesnt allow empty shift_date' do
      form.shift_date   = nil
      expect(form).to_not be_valid
    end

    it 'doesnt allow empty start time' do
      form.start        = nil
      expect(form).to_not be_valid
    end

    it 'doesnt allow empty end time' do
      form.finish       = nil
      expect(form).to_not be_valid
    end

    it 'doesnt allow empty break length' do
      form.break_length = nil
      expect(form).to_not be_valid
    end

    it 'doesnt allow negative break length' do
      form.break_length = -20
      expect(form).to_not be_valid
    end

    it 'doesnt allow to save when finish time is greater than start time' do
      form.start        = '05:00 PM'
      form.finish       = '08:00 AM'
      expect(form).to_not be_valid
    end
  end

  context 'Instance Methods' do
    context '#save' do
      it 'creates shift' do
        expect { form.save }.to change { Shift.count }.by(1)
      end

      it 'doesnt create shift if an attribute is invalid' do
        form.break_length = nil
        expect { form.save }.to change { Shift.count }.by(0)
      end

      it 'returns false when an attribute is invalid' do
        form.break_length = nil
        expect(form.save).to be_falsy
      end
    end
  end
end

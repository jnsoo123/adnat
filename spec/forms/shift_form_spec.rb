require 'rails_helper'

RSpec.describe ShiftForm, type: :model do
  let(:shift) { create :shift }
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

  context 'Initialize' do
    let(:form)  { described_class.new(shift: shift) }

    it 'sets attributes when shift object is present' do
      expect(form.shift_date).to be_present
      expect(form.break_length).to be_present
      expect(form.user_id).to be_present
      expect(form.start).to be_present
      expect(form.finish).to be_present
    end
  end

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

    context '#update' do
      let(:form) { described_class.new(attrs) }
      let(:attrs) {{
        shift: shift,
        break_length: 100,
        start: '09:00 AM',
        finish: '04:00 PM',
      }}

      it 'updates shift' do
        form.update
        shift.reload
        expect(shift.break_length).to eq 100
        expect(shift.start.strftime('%I:%M %p')).to eq '09:00 AM'
        expect(shift.finish.strftime('%I:%M %p')).to eq '04:00 PM'
      end
    end
  end
end

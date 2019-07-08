require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  context 'Validations' do
    it 'can have no organization' do
      user.organization = nil
      expect(user).to be_valid
    end
  end
end

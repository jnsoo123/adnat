require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { build :organization }

  it 'has a valid factory' do
    expect(organization).to be_valid
  end

  context 'Validation' do
    after do
      expect(organization).to_not be_valid
    end

    it 'only accepts organization with name' do
      organization.name = nil
    end

    it 'only accepts organization with name' do
      organization.name = ''
    end

    it 'only accepts organization with hourly rate greater than 0' do
      organization.hourly_rate = 0
    end

    it 'only accepts organization with hourly rate greater than 0' do
      organization.hourly_rate = -1.23
    end

    it 'only accepts organization with hourly rate greater than 0' do
      organization.hourly_rate = nil
    end
  end
end

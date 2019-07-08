require 'rails_helper'

RSpec.describe UserForm do
  let(:user) { create :user }
  let(:form) { described_class.new(user: user)}

  context 'Initialization' do
    it 'sets attributes when user is passed' do
      expect(form.name).to eq user.name
      expect(form.email).to eq user.email
    end

    context 'with no user' do
      let(:form) { described_class.new }
      it 'doesnt set attributes when user is not passed' do
        expect(form.name).to be_nil
        expect(form.email).to be_nil
      end
    end
  end

  context 'Validation' do
    context 'when password is not present' do
      let(:form) {
        described_class.new(
          user: user,
          email: 'new_email@example.com',
          name: 'New name'
        ) 
      }

      it 'doesnt check password validation' do
        expect(form).to be_valid
      end
    end

    context 'when one attribute is not present' do
      let(:form) {
        described_class.new(
          user: user,
          email: '',
          name: 'New name'
        ) 
      }

      it 'only check name or email validation' do
        expect(form).to_not be_valid
      end
    end

    context 'when password is present' do
      context 'wrong old password' do
        let(:form) {
          described_class.new(
            user: user,
            old_password:          'wrong_password',
            password:              'new_password',
            password_confirmation: 'new_password'
          ) 
        }

        it 'is invalid when old_password doesnt match' do
          expect(form).to_not be_valid
        end
      end

      context 'wrong password confirmation' do
        let(:form) {
          described_class.new(
            user: user,
            old_password:          'password',
            password:              'new_password',
            password_confirmation: 'new_password_1'
          ) 
        }

        it 'is invalid when old_password doesnt match' do
          expect(form).to_not be_valid
        end
      end

      context 'credentials are correct' do
        let(:form) {
          described_class.new(
            user: user,
            old_password:          'password',
            password:              'new_password',
            password_confirmation: 'new_password'
          ) 
        }

        it 'is invalid when old_password doesnt match' do
          expect(form).to be_valid
        end
      end
    end
  end

  context 'Instance Methods' do
    context '#update' do
      it 'updates user' do
        form.name = 'new name'
        form.update
        user.reload
        expect(user.name).to eq 'new name'
      end
    end
  end
end

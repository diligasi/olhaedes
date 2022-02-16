require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  describe 'role enum' do
    let(:current_roles) { %i[admin supervisor lab field] }

    it 'should have all correct values set' do
      expect(current_roles.sort).to eq(User.roles.keys.map(&:to_sym).sort)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    context 'cpf' do
      it { is_expected.to validate_presence_of(:cpf) }
      it { is_expected.to validate_uniqueness_of(:cpf).ignoring_case_sensitivity }

      it 'does not allow cpf with more than 11 characters' do
        subject.cpf = '0123456789123456'
        expect(subject).to be_invalid
      end
    end

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

      it 'does not allow emails that do not fit the specified format' do
        invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_emails.each do |invalid_email|
          subject.email = invalid_email
          expect(subject).to be_invalid
        end
      end
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end
  end

  describe 'methods' do
    it { is_expected.to respond_to :active_for_authentication? }

    it 'removes non numerical characters from cpf' do
      cpf = Faker::CPF.number.insert(3, '.').insert(7, '.').insert(11, '-')
      subject.cpf = cpf
      expect(subject.cpf).to eq(cpf.delete('^0-9'))
    end
  end

  describe 'relationships' do
    pending "add some examples to (or delete) #{__FILE__}"
    # it { expect(subject).to respond_to :customer }
  end
end

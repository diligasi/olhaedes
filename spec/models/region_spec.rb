require 'rails_helper'

RSpec.describe Region, type: :model do
  subject { build :region }

  describe 'relationships' do
    it { should belong_to(:department) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:department_id).case_insensitive }
  end

  describe 'methods' do
    it { is_expected.to respond_to :number_of_active_users }
    it { expect(subject.number_of_active_users).to be_kind_of(Integer) }
  end
end

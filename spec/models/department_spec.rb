require 'rails_helper'

RSpec.describe Department, type: :model do
  subject { build :department }

  describe 'relationships' do
    it { should have_many(:regions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  describe 'methods' do
    it { is_expected.to respond_to :number_of_active_users }
    it { expect(subject.number_of_active_users).to be_kind_of(Integer) }
  end
end

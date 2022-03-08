require 'rails_helper'

RSpec.describe TestTube, type: :model do
  subject { build :test_tube }

  describe 'relationships' do
    it { should belong_to(:shed_type).optional }
    it { should belong_to(:field_form) }
    it { should have_many(:larvae) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
    it { is_expected.to validate_numericality_of(:collected_amount).is_greater_than(0) }
  end

  describe 'scope' do
    # context '.total_larvae_per_region_range' do
    #   soon...
    # end
  end
end

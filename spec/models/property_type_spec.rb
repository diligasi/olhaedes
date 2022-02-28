require 'rails_helper'

RSpec.describe PropertyType, type: :model do
  subject { build :property_type }

  describe 'relationships' do
    # it { should have_one(:field_form) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  describe 'scope' do
    describe '.visited_per_range' do
      # soon...
    end
  end
end

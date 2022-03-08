require 'rails_helper'

RSpec.describe Institutional, type: :model do
  subject { build :institutional }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone_numbers) }
    it { is_expected.to validate_presence_of(:description) }
  end
end

require 'rails_helper'

RSpec.describe Faq, type: :model do
  subject { build :faq }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:question) }
    it { is_expected.to validate_presence_of(:answer) }
  end
end

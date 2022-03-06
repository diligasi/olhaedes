require 'rails_helper'

RSpec.describe ShedType, type: :model do
  subject { build :shed_type }

  # describe 'relationships' do
  #   it { should have_many(:test_tubes) }
  # end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  # describe 'scope' do
  #   context '.based_on_role_for' do
  #     before do
  #       @admin_user       = create :user, :with_admin_role
  #       @not_admin_user_1 = create :user
  #       @not_admin_user_2 = create :user
  #
  #       @current_larva_species = create :larva_species
  #       @field_form_1          = create :field_form, property_type: @current_property_type, user: @not_admin_user_1
  #       @field_form_2          = create :field_form, property_type: @current_property_type, user: @not_admin_user_2
  #     end
  #
  #     it { expect(PropertyType.based_on_role_for(@admin_user).size).to eq(2) }
  #     it { expect(PropertyType.based_on_role_for(@not_admin_user_1).size).to eq(1) }
  #     it { expect(PropertyType.based_on_role_for(@not_admin_user_1).map(&:field_form)).to include(@field_form_1) }
  #     it { expect(PropertyType.based_on_role_for(@not_admin_user_1).map(&:field_form)).not_to include(@field_form_2) }
  #   end
  #
  #   context '.contaminated_places_per_range' do
  #     before do
  #       @field_form   = create :field_form
  #       @date_range_1 = DateTime.now.beginning_of_month..DateTime.now.end_of_month
  #       @date_range_2 = (DateTime.now.beginning_of_month - 5.month)..(DateTime.now.end_of_month - 2.months)
  #     end
  #
  #     it { expect(PropertyType.visited_per_range(@date_range_1)).to include(@field_form.property_type) }
  #     it { expect(PropertyType.visited_per_range(@date_range_2)).not_to include(@field_form.property_type) }
  #   end
  # end
end

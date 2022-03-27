require 'rails_helper'

RSpec.describe FieldForm, type: :model do
  subject { build :field_form }

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:property_type) }
    # it { should have_many(:test_tubes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:district) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }

    context 'zipcode' do
      it { is_expected.to validate_presence_of(:zipcode) }

      it 'does not allow zipcode with more than 8 characters' do
        subject.zipcode = '0123456789123456'
        expect(subject).to be_invalid
      end
    end
  end

  describe 'scope' do
    context '.by_agent_name' do
      let(:by_agent_name_field_form) { create :field_form }

      xit 'includes field forms from users with the given name' do
        user = by_agent_name_field_form.user
        expect(FieldForm.by_agent_name(user.name)).to include(by_agent_name_field_form)
      end

      xit 'excludes field forms from users without the given name' do
        expect(FieldForm.by_agent_name('Non existent')).not_to include(by_agent_name_field_form)
      end
    end

    context '.by_address' do
      let(:by_address_field_form) { create :field_form }

      xit 'includes field forms with the given address' do
        expect(FieldForm.by_address(by_address_field_form.street)).to include(by_address_field_form)
      end

      xit 'excludes field forms without the given address' do
        expect(FieldForm.by_address('Non existent')).not_to include(by_address_field_form)
      end
    end

    context '.by_date_range' do
      let(:by_date_range_field_form) { create :field_form }
      let(:range1) { [DateTime.now.beginning_of_day, (DateTime.now.end_of_day + 1.days)] }
      let(:range2) { [(DateTime.now.beginning_of_day + 2.days), (DateTime.now.end_of_day + 3.days)] }

      it 'includes field forms created on the given date range' do
        expect(FieldForm.by_date_range(range1)).to include(by_date_range_field_form)
      end

      it 'excludes field forms that were not created on the given date range' do
        expect(FieldForm.by_date_range(range2)).not_to include(by_date_range_field_form)
      end
    end

    context '.by_field_form_status' do
      let(:by_field_form_status_field_form) { create :field_form }
      let(:status) { by_field_form_status_field_form.status }

      it 'includes field forms according to the given status' do
        expect(FieldForm.by_field_form_status(status)).to include(by_field_form_status_field_form)
      end

      it 'excludes field forms not in according to the given status' do
        expect(FieldForm.by_field_form_status((FieldForm.statuses.keys - [status]).first)).not_to include(by_field_form_status_field_form)
      end
    end

    context '.by_property_type' do
      let(:by_property_type_field_form) { create :field_form }

      it 'includes field forms with the given property type id' do
        expect(FieldForm.by_property_type(by_property_type_field_form.property_type_id)).to include(by_property_type_field_form)
      end

      it 'excludes field forms without the given property type id' do
        expect(FieldForm.by_property_type(0)).not_to include(by_property_type_field_form)
      end
    end

    context '.by_shed_type' do
      pending 'soon...'
    end

    context '.by_larva_species' do
      pending 'soon...'
    end

    context '.by_larvae_amount' do
      pending 'soon...'
    end

    context '.by_dashboard_range' do
      pending 'soon...'
    end
  end

  describe 'methods' do
    it 'removes non numerical characters from zipcode' do
      zipcode = %w[24310-550 24346-210 24342-440].sample
      subject.zipcode = zipcode
      expect(subject.zipcode).to eq(zipcode.delete('^0-9'))
    end
  end
end

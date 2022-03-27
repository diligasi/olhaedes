class Larva < ApplicationRecord
  belongs_to :test_tube
  belongs_to :larva_species

  after_save :set_field_form_status

  private

  def set_field_form_status
    field_form = test_tube.field_form

    if field_form.test_tubes.all? { |tube| tube.larvae.size == tube.collected_amount }
      field_form.update(status: :complete)
    end
  end
end

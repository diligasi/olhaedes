class PropertyType < ApplicationRecord
  has_one :field_form

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :visited_per_range, lambda { |date_range|
    joins([field_form: [user: [region: [:department]]]])
      .where({ field_forms: { created_at: date_range } })
      .group('property_types.name')
      .select('property_types.name, count(property_types.*)')
      .order('property_types.name')
  }
end

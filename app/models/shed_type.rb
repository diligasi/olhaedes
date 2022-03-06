class ShedType < ApplicationRecord
  # has_many :test_tubes

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # scope :contaminated_places_per_range, lambda { |condition|
  #   joins(test_tubes: [field_form: [:property_type, { user: [region: :department] }]])
  #     .where(condition)
  #     .group('shed_types.name, property_types.name')
  #     .select('property_types.name as "property", shed_types.name as "place", count(shed_types.name)')
  #     .order('shed_types.name, property_types.name')
  # }
end

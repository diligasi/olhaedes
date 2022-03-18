class ShedType < ApplicationRecord
  has_many :test_tubes

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :based_on_role_for, lambda { |user|
    if user.admin?
      joins(test_tubes: [field_form: [user: [region: [:department]]]])
        .where(nil)
    else
      joins(test_tubes: [field_form: [user: [region: [:department]]]])
        .where({ departments: { id: user.region&.department&.id } })
    end
  }

  scope :contaminated_places_per_range, lambda { |date_range|
    joins(test_tubes: [field_form: [:property_type, { user: [region: :department] }]])
      .where({ field_forms: { created_at: date_range } })
      .group('shed_types.name, property_types.name')
      .select('property_types.name as "property", shed_types.name as "place", count(shed_types.name)')
      .order('shed_types.name, property_types.name')
  }
end

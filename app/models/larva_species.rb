class LarvaSpecies < ApplicationRecord
  has_many :larvae

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :based_on_role_for, lambda { |user|
    if user.admin?
      joins(larvae: [test_tube: [field_form: [user: [region: [:department]]]]])
        .where(nil)
    else
      joins(larvae: [test_tube: [field_form: [user: [region: [:department]]]]])
        .where({ departments: { id: user.region&.department&.id } })
    end
  }

  scope :species_by_region_per_range, lambda { |date_range|
    joins(larvae: [test_tube: [field_form: [user: [region: [:department]]]]])
      .where({ field_forms: { created_at: date_range } })
      .group('larva_species.name, regions.name')
      .select('larva_species.name as "specie", regions.name as "region", count(regions.name)')
      .order('regions.name, larva_species.name')
  }
end

class LarvaSpecies < ApplicationRecord
  has_many :larvae

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :species_by_region_per_range, lambda { |condition|
    joins(larvae: [test_tube: [field_form: [user: [region: [:department]]]]])
      .where(condition)
      .group('larva_species.name, regions.name')
      .select('larva_species.name as "specie", regions.name as "region", count(regions.name)')
      .order('regions.name, larva_species.name')
  }
end

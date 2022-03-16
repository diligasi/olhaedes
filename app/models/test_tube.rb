class TestTube < ApplicationRecord
  belongs_to :shed_type, optional: true
  belongs_to :field_form

  has_many :larvae

  alias_attribute :analysis, :larvae

  validates :code,             presence: true, uniqueness: { case_sensitive: false }
  validates :collected_amount, numericality: { greater_than: 0 }

  scope :total_larvae_per_region_range, lambda { |condition|
    joins(field_form: [user: [region: [:department]]])
      .where(condition)
      .group('regions.name')
      .select('regions.name as "region", sum(test_tubes.collected_amount)')
      .order('regions.name')
  }
end

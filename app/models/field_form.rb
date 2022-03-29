class FieldForm < ApplicationRecord
  belongs_to :user
  belongs_to :property_type

  has_many :test_tubes

  enum status: {
    pending:  0,
    complete: 1
  }

  enum visit_status: {
    allowed: 0,
    refused: 1,
    closed:  2
  }

  validates :street,       presence: true
  validates :district,     presence: true
  validates :city,         presence: true
  validates :state,        presence: true
  validates :zipcode,      presence: true, length: { is: 8 }
  validates :visit_status, inclusion: { in: visit_statuses.keys }
  validates :larvae_found, inclusion: { in: [true, false] }

  before_save :set_status

  scope :completed, -> {
    where(status: 'complete').distinct
  }

  scope :based_on_role_for, lambda { |user|
    if user.admin?
      left_outer_joins(:test_tubes, user: [region: [:department]])
        .where(nil)
    else
      left_outer_joins(:test_tubes, user: [region: [:department]])
        .where({ departments: { id: user.region&.department&.id } })
    end
  }

  scope :by_agent_name, lambda { |name|
    joins(:user)
      .where('unaccent(lower(users.name)) like ?', "%#{name.downcase}%")
  }

  scope :by_address, lambda { |term|
    where('unaccent(lower(street)) like :like or
            unaccent(lower(complement)) like :like or
            unaccent(lower(district)) like :like or
            unaccent(lower(block)) like :like or
            number = :equal or
            zipcode = :equal',
          like: "%#{term.downcase}%", equal: term)
  }

  scope :by_date_range, lambda { |range|
    where('date(field_forms.created_at) >= :start_date and
            date(field_forms.created_at) <= :end_date',
          start_date: range.first, end_date: range.last)
  }

  scope :by_field_form_status, lambda { |status|
    where('field_forms.status = ?', FieldForm.statuses[status])
  }

  scope :by_property_type, lambda { |type|
    where('field_forms.property_type_id = ?', type)
  }

  scope :by_shed_type, lambda { |type|
    includes(:test_tubes, :user)
      .where(test_tubes: { shed_type_id: type })
  }

  scope :by_larva_species, lambda { |species|
    includes({ test_tubes: [:larvae] }, :user)
      .where(test_tubes: { larvae: { larva_species_id: species } })
  }

  scope :by_larvae_amount, lambda { |amount|
    includes(:test_tubes, :user)
      .where(test_tubes: { collected_amount: amount })
  }

  scope :by_dashboard_range, lambda { |date_range|
    left_outer_joins(:test_tubes, user: [region: [:department]])
      .where({ field_forms: { created_at: date_range } })
  }

  # Ensures that only the zipcode numbers
  # are being saved in the database.
  def zipcode=(value)
    super(value.try(:delete, '^0-9'))
  end

  private

  def set_status
    self.status = if !self.larvae_found || (test_tubes.present? && test_tubes.all? { |tube| tube.larvae.size == tube.collected_amount })
                    :complete
                  else
                    :pending
                  end
  end
end

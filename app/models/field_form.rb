class FieldForm < ApplicationRecord
  belongs_to :user
  belongs_to :property_type

  # has_many :test_tubes

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

  scope :by_agent_name, lambda { |name|
    joins(:user)
      .where('lower(users.name) like ?', "%#{name.downcase}%")
  }

  scope :by_address, lambda { |term|
    where('lower(street) like :like or
            lower(complement) like :like or
            lower(district) like :like or
            lower(block) like :like or
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

  scope :by_larva_specy, lambda { |specy|
    includes({ test_tubes: [:larvas] }, :user)
      .where(test_tubes: { larvas: { larva_specy_id: specy } })
  }

  scope :by_larvae_amount, lambda { |amount|
    includes(:test_tubes, :user)
      .where(test_tubes: { collected_amount: amount })
  }

  scope :by_dashboard_range, lambda { |condition|
    left_outer_joins(:test_tubes, user: [region: [:department]])
      .where(condition)
  }

  # Ensures that only the zipcode numbers
  # are being saved in the database.
  def zipcode=(value)
    super(value.try(:delete, '^0-9'))
  end
end

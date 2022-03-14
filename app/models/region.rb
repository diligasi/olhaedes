class Region < ApplicationRecord
  belongs_to :department

  has_many :users

  validates :name, presence: true, uniqueness: { scope: :department_id, case_sensitive: false }

  # Returns the amount of active users from
  # the current region.
  def number_of_active_users
    users.where(users: { status: true }).size
  end
end

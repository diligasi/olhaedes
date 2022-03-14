class Department < ApplicationRecord
  has_many :regions, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Returns the amount of active users from
  # the current department's regions.
  def number_of_active_users
    regions.joins(:users).where(users: { status: true }).size
  end
end

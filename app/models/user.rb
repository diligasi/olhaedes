class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable

  enum role: {
    admin:      0,
    supervisor: 1,
    lab:        2,
    field:      3
  }

  validates :name,     presence: true
  validates :cpf,      presence: true, uniqueness: true, length: { is: 11 }
  validates :email,    presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :region,   presence: true, unless: -> { admin? }
  validates :role,     inclusion: { in: roles.keys }
  validates :status,   inclusion: { in: [true, false] }

  # Ensures that only active users can
  # log into the system.
  def active_for_authentication?
    super && status
  end

  # Ensures that only the CPF numbers
  # are being saved in the database.
  def cpf=(value)
    super(value.try(:delete, '^0-9'))
  end
end

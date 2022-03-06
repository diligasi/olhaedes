class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :based_on_role_for, lambda { |user|
    if user.admin?
      joins([field_form: [user: [region: [:department]]]])
        .where(nil)
    else
      joins([field_form: [user: [region: [:department]]]])
        .where({ departments: { id: user.region&.department&.id } })
    end
  }
end

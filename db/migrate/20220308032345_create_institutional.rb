class CreateInstitutional < ActiveRecord::Migration[7.0]
  def change
    create_table :institutional do |t|
      t.string :phone_numbers, null: false
      t.text   :description,   null: false

      t.timestamps
    end
  end
end

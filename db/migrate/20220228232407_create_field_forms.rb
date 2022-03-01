class CreateFieldForms < ActiveRecord::Migration[7.0]
  def change
    create_table :field_forms do |t|
      t.references :user,          null: false, foreign_key: true
      t.references :property_type, null: false, foreign_key: true

      t.integer :status, default: 0
      t.string  :street
      t.string  :number
      t.string  :complement
      t.string  :block
      t.string  :district
      t.string  :city
      t.string  :state
      t.string  :country
      t.string  :zipcode
      t.integer :visit_status
      t.text    :visit_comment
      t.boolean :larvae_found, default: false
      t.boolean :larvicide,    default: false
      t.boolean :rodenticide,  default: false

      t.timestamps
    end
  end
end

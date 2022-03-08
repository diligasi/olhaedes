class CreateTestTubes < ActiveRecord::Migration[7.0]
  def change
    create_table :test_tubes do |t|
      t.references :field_form, null: false, foreign_key: true
      t.references :shed_type, null: false, foreign_key: true
      t.string :code, null: false
      t.integer :collected_amount
      t.text :comments

      t.timestamps
    end
  end
end

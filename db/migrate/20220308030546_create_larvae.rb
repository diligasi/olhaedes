class CreateLarvae < ActiveRecord::Migration[7.0]
  def change
    create_table :larvae do |t|
      t.references :test_tube, null: false, foreign_key: true
      t.references :larva_species, null: false, foreign_key: true
      t.text :comments

      t.timestamps
    end
  end
end

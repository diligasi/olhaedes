class CreateShedTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :shed_types do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end

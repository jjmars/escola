class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.references :school, index: true, foreign_key: true
      t.references :unit, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
